// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';
import 'package:pub_dev/search/mem_index.dart';
import 'package:pub_dev/task/global_lock.dart';

import '../dartdoc/backend.dart';
import '../package/backend.dart';
import '../package/model_properties.dart';
import '../package/models.dart';
import '../package/overrides.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/storage.dart';
import '../shared/versions.dart';
import '../tool/utils/http.dart';

import 'dart_sdk_mem_index.dart';
import 'flutter_sdk_mem_index.dart';
import 'models.dart';
import 'result_combiner.dart';
import 'search_service.dart';
import 'text_utils.dart';

final Logger _logger = Logger('pub.search.backend');

/// The number of concurrent datastore/bucket fetch operations while
/// building or updating the snapshot.
const _defaultSnapshotBuildConcurrency = 8;

/// Sets the backend service.
void registerSearchBackend(SearchBackend backend) =>
    ss.register(#_searchBackend, backend);

/// The active backend service.
SearchBackend get searchBackend => ss.lookup(#_searchBackend) as SearchBackend;

/// The in-memory (primary) [InMemoryPackageIndex] registered in the current service scope.
InMemoryPackageIndex get _inMemoryPackageIndex =>
    ss.lookup(#_inMemoryPackageIndex) as InMemoryPackageIndex;

/// Register a new [InMemoryPackageIndex] in the current service scope.
void registerInMemoryPackageIndex(InMemoryPackageIndex index) =>
    ss.register(#_inMemoryPackageIndex, index);

/// The combined or delegated [SearchIndex] registered in the current service scope.
SearchIndex get searchIndex =>
    (ss.lookup(#_searchIndex) as SearchIndex?) ?? const _CombinedSearchIndex();

/// Register a new combined or delegated [SearchIndex] in the current service scope.
void registerSearchIndex(SearchIndex index) =>
    ss.register(#_searchIndex, index);

/// Datastore-related access methods for the search service
class SearchBackend {
  final DatastoreDB _db;
  final VersionedJsonStorage _snapshotStorage;
  final _http = httpRetryClient();

  SearchBackend(this._db, Bucket snapshotBucket)
      : _snapshotStorage = VersionedJsonStorage(snapshotBucket, 'snapshot/');

  /// Runs a forever loop and tries to get a global lock.
  ///
  /// Once it has the claim, it creates a new snapshot by loading
  /// all visible package data and uploads it into the snapshot storage.
  /// Tracks the package updates for the next up-to 24 hours and writes
  /// the snapshot after every 10 minutes.
  ///
  /// When other process has the claim, the loop waits a minute before
  /// attempting to get the claim.
  Future<Never> updateSnapshotInForeverLoop() async {
    final lock = GlobalLock.create(
      'update-search-snapshot',
      expiration: Duration(minutes: 20),
    );
    while (true) {
      try {
        await lock.withClaim((claim) async {
          await doCreateAndUpdateSnapshot(claim);
        });
      } catch (e, st) {
        _logger.warning('Snapshot update failed.', e, st);
      }
      // Wait for 1 minutes for sanity, before trying again.
      await Future.delayed(Duration(minutes: 1));
    }
  }

  @visibleForTesting
  Future<void> doCreateAndUpdateSnapshot(
    GlobalLockClaim claim, {
    Duration sleepDuration = const Duration(minutes: 2),
    int concurrency = _defaultSnapshotBuildConcurrency,
  }) async {
    final firstClaimed = clock.now();

    // The claim will be released after a day, another process may
    // start to build the snapshot from scratch again.
    final workUntil = clock.now().add(Duration(days: 1));

    // creating snapshot from scratch
    final snapshot = SearchSnapshot();
    Future<void> updatePackage(String package, DateTime? updated) async {
      if (!claim.valid) {
        return;
      }
      // Skip if the last document timestamp is before [updated].
      // 1-minute window is kept to reduce clock-skew.
      if (updated != null) {
        final currentDoc = snapshot.documents![package];
        final lastRefreshed =
            currentDoc?.sourceUpdated ?? currentDoc?.timestamp;
        if (lastRefreshed != null &&
            updated.isBefore(lastRefreshed.subtract(Duration(minutes: 1)))) {
          return;
        }
      }
      // update or remove the document
      try {
        final doc = await loadDocument(package);
        snapshot.add(doc);
      } on RemovedPackageException catch (_) {
        snapshot.remove(package);
      }
    }

    // initial scan of packages
    final pool = Pool(concurrency);
    final futures = <Future>[];
    await for (final package in dbService.query<Package>().run()) {
      if (package.isNotVisible) {
        continue;
      }
      if (!claim.valid) {
        break;
      }
      // This is the first scan, there isn't any existing document that we
      // can compare to, ignoring the updated field.
      final f = pool.withResource(() => updatePackage(package.name!, null));
      futures.add(f);
    }
    await Future.wait(futures);
    futures.clear();
    if (!claim.valid) {
      return;
    }

    // first complete snapshot, uploading it
    await _snapshotStorage.uploadDataAsJsonMap(snapshot.toJson());
    var lastUploadedSnapshotTimestamp = snapshot.updated!;

    // start monitoring
    var lastQueryStarted = firstClaimed;
    while (claim.valid) {
      final now = clock.now().toUtc();
      if (now.isAfter(workUntil)) {
        break;
      }

      lastQueryStarted = now;

      // query updates
      final recentlyUpdated = await _queryRecentlyUpdated(lastQueryStarted);
      for (final e in recentlyUpdated.entries) {
        if (!claim.valid) {
          break;
        }
        final f = pool.withResource(() => updatePackage(e.key, e.value));
        futures.add(f);
      }
      await Future.wait(futures);
      futures.clear();

      if (claim.valid && lastUploadedSnapshotTimestamp != snapshot.updated) {
        await _snapshotStorage.uploadDataAsJsonMap(snapshot.toJson());
        lastUploadedSnapshotTimestamp = snapshot.updated!;
      }

      await Future.delayed(sleepDuration);
    }
    await pool.close();
  }

  Future<Map<String, DateTime>> _queryRecentlyUpdated(
      DateTime lastQueryStarted) async {
    final updatedThreshold = lastQueryStarted.subtract(Duration(minutes: 5));
    final results = <String, DateTime>{};
    void addResult(String pkg, DateTime updated) {
      final current = results[pkg];
      if (current == null || current.isBefore(updated)) {
        results[pkg] = updated;
      }
    }

    final q1 = _db.query<Package>()
      ..filter('updated >=', updatedThreshold)
      ..order('-updated');
    await for (final p in q1.run()) {
      addResult(p.name!, p.updated!);
    }

    final q2 = _db.query<ScoreCard>()
      ..filter('updated >=', updatedThreshold)
      ..order('-updated');
    await for (final sc in q2.run()) {
      addResult(sc.packageName!, sc.updated!);
    }

    return results;
  }

  /// Loads the latest stable version, its analysis results and extracted
  /// dartdoc content, and returns a [PackageDocument] objects for search.
  ///
  /// When a package, or its latest version is missing, the method throws
  /// [RemovedPackageException].
  Future<PackageDocument> loadDocument(String packageName) async {
    final p = await packageBackend.lookupPackage(packageName);
    if (p == null || p.isNotVisible) {
      throw RemovedPackageException();
    }
    final releases = await packageBackend.latestReleases(p);

    final pv = await packageBackend.lookupPackageVersion(
        packageName, releases.stable.version);
    if (pv == null) {
      throw RemovedPackageException();
    }
    final readmeAsset = await packageBackend.lookupPackageVersionAsset(
        packageName, pv.version!, AssetKind.readme);

    final scoreCard =
        await scoreCardBackend.getScoreCardData(packageName, pv.version!);

    // Find tags from latest prerelease and/or preview (if there one).
    Future<Iterable<String>> loadFutureTags(String version) async {
      final futureVersion =
          await packageBackend.lookupPackageVersion(packageName, version);
      final futureVersionAnalysis =
          await scoreCardBackend.getScoreCardData(packageName, version);
      final futureTags = <String>{
        ...?futureVersion?.getTags(),
        ...?futureVersionAnalysis?.panaReport?.derivedTags,
      };
      return futureTags.where(isFutureVersionTag);
    }

    final prereleaseTags = releases.showPrerelease
        ? await loadFutureTags(releases.prerelease!.version)
        : const <String>{};
    final previewTags = releases.showPreview
        ? await loadFutureTags(releases.preview!.version)
        : const <String>{};

    final tags = <String>{
      // Every package gets the show:* tags, so they can be used as override in
      // the query text.
      PackageTags.showHidden,
      PackageTags.showDiscontinued,
      PackageTags.showUnlisted,
      PackageVersionTags.showLegacy,

      // regular tags
      ...p.getTags(),
      ...pv.getTags(),
      ...?scoreCard?.panaReport?.derivedTags,
      ...prereleaseTags,
      ...previewTags,
    };

    final pubDataContent = await dartdocBackend.getTextContent(
        packageName, 'latest', 'pub-data.json',
        timeout: const Duration(minutes: 1), maxSize: 10 * 1014);

    List<ApiDocPage>? apiDocPages;
    try {
      if (pubDataContent == null || pubDataContent.isEmpty) {
        _logger.info('Got empty pub-data.json for package $packageName.');
      } else {
        apiDocPages = _apiDocPagesFromPubDataText(pubDataContent);
      }
    } catch (e, st) {
      _logger.severe('Parsing pub-data.json failed.', e, st);
    }

    final descriptionAndTopics = <String>[
      pv.pubspec!.description ?? '',
      ...?pv.pubspec!.topics,
    ].join(' ');

    // select the latest entity updated timestamp (when available)
    final sourceUpdated = [
      p.updated,
      scoreCard?.updated,
    ].whereNotNull().maxOrNull;

    return PackageDocument(
      package: pv.package,
      version: pv.version!,
      tags: tags.toList(),
      description: compactDescription(descriptionAndTopics),
      created: p.created,
      updated: p.lastVersionPublished,
      readme: compactReadme(readmeAsset?.textContent),
      likeCount: p.likes,
      grantedPoints: scoreCard?.grantedPubPoints,
      maxPoints: scoreCard?.maxPubPoints ?? 0,
      dependencies: _buildDependencies(pv.pubspec!, scoreCard),
      apiDocPages: apiDocPages,
      timestamp: clock.now().toUtc(),
      sourceUpdated: sourceUpdated,
    );
  }

  Map<String, String> _buildDependencies(Pubspec pubspec, ScoreCardData? view) {
    final Map<String, String> dependencies = <String, String>{};
    view?.panaReport?.allDependencies?.forEach((p) {
      dependencies[p] = DependencyTypes.transitive;
    });
    pubspec.devDependencies.forEach((package) {
      dependencies[package] = DependencyTypes.dev;
    });
    pubspec.dependencyNames.forEach((package) {
      dependencies[package] = DependencyTypes.direct;
    });
    return dependencies;
  }

  List<ApiDocPage> _apiDocPagesFromPubDataText(String text) {
    final decodedMap = json.decode(text) as Map;
    final pubData = PubDartdocData.fromJson(decodedMap.cast());
    return apiDocPagesFromPubData(pubData);
  }

  /// Loads a minimum set of package document data for indexing.
  Stream<PackageDocument> loadMinimumPackageIndex() async* {
    final query = _db.query<Package>();
    await for (final p in query.run()) {
      final releases = await packageBackend.latestReleases(p);
      yield PackageDocument(
        package: p.name!,
        version: releases.stable.version,
        tags: p.getTags().toList(),
        created: p.created,
        updated: p.lastVersionPublished,
        likeCount: p.likes,
        grantedPoints: 0,
        maxPoints: 0,
        timestamp: clock.now().toUtc(),
      );
    }
  }

  /// Downloads the remote SDK content relative to the base URI.
  Future<String> fetchSdkIndexContentAsString({
    required Uri baseUri,
    required String relativePath,
  }) async {
    final uri = baseUri.resolve(relativePath);
    final rs = await _http.get(uri);
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code for $uri: ${rs.statusCode}');
    }
    return rs.body;
  }

  /// Downloads the remote SDK page and tries to extract the first paragraph of the content.
  Future<String?> _fetchSdkLibraryDescription({
    required Uri baseUri,
    required String relativePath,
  }) async {
    try {
      final content = await fetchSdkIndexContentAsString(
          baseUri: baseUri, relativePath: relativePath);
      final parsed = html_parser.parse(content);
      final descr = parsed.body
          ?.querySelector('section.desc.markdown')
          ?.querySelector('p')
          ?.text
          .trim();
      return descr == null ? null : compactDescription(descr);
    } catch (e) {
      _logger.info(
          'Unable to fetch SDK library description $baseUri $relativePath', e);
      return null;
    }
  }

  /// Downloads the remote SDK page and tries to extract the first paragraph of the content
  /// for each library in [libraryRelativeUrls].
  Future<Map<String, String>> fetchSdkLibraryDescriptions({
    required Uri baseUri,
    required Map<String, String> libraryRelativeUrls,
  }) async {
    final values = <String, String>{};
    for (final library in libraryRelativeUrls.keys) {
      final descr = await _fetchSdkLibraryDescription(
        baseUri: baseUri,
        relativePath: libraryRelativeUrls[library]!,
      );
      if (descr != null) {
        values[library] = descr;
      }
    }
    return values;
  }

  Future<List<PackageDocument>?> fetchSnapshotDocuments() async {
    try {
      final map = await _snapshotStorage.getContentAsJsonMap();
      if (map == null) {
        _logger.info('No snaptshot to fetch.');
        return null;
      }
      final snapshot = SearchSnapshot.fromJson(map);
      snapshot.documents!
          .removeWhere((packageName, doc) => isSoftRemoved(packageName));

      final count = snapshot.documents!.length;
      _logger.info('Got $count packages from snapshot at ${snapshot.updated}');
      return snapshot.documents?.values.toList();
    } catch (e, st) {
      _logger.shout('Unable to load search snapshot.', e, st);
    }
    return null;
  }

  /// Deletes old data files in snapshot storage (for old runtimes that are more
  /// than half a year old).
  Future<void> deleteOldData() async {
    final counts = await _snapshotStorage.deleteOldData(
        minAgeThreshold: Duration(days: 182));
    _logger.info(
        'delete-old-search-snapshots cleared $counts entries ($runtimeVersion)');
  }

  Future<void> close() async {
    _snapshotStorage.close();
    _http.close();
  }
}

/// Creates the index-related API data structure from the extracted dartdoc data.
List<ApiDocPage> apiDocPagesFromPubData(PubDartdocData pubData) {
  final nameToKindMap = <String, String>{};
  pubData.apiElements!.forEach((e) {
    nameToKindMap[e.qualifiedName] = e.kind;
  });

  final pathMap = <String, String?>{};
  final symbolMap = <String, Set<String>>{};

  bool isTopLevel(String? kind) => kind == 'library' || kind == 'class';

  void update(String key, String symbol, String? documentation) {
    if (isCommonApiSymbol(symbol)) {
      return;
    }
    final set = symbolMap.putIfAbsent(key, () => <String>{});
    set.add(symbol);
  }

  pubData.apiElements!.forEach((apiElement) {
    if (isTopLevel(apiElement.kind)) {
      pathMap[apiElement.qualifiedName] = apiElement.href;
      update(
          apiElement.qualifiedName, apiElement.name, apiElement.documentation);
    } else if (apiElement.parent != null &&
        isTopLevel(nameToKindMap[apiElement.parent])) {
      update(apiElement.parent!, apiElement.name, apiElement.documentation);
    }
  });

  final results = pathMap.keys.where(symbolMap.containsKey).map((key) {
    final path = pathMap[key]!;
    final symbols = symbolMap[key]!.toList()..sort();
    return ApiDocPage(
      relativePath: path,
      symbols: symbols,
    );
  }).toList();
  results.sort((a, b) => a.relativePath.compareTo(b.relativePath));
  return results;
}

class _CombinedSearchIndex implements SearchIndex {
  const _CombinedSearchIndex();

  @override
  bool isReady() => indexInfo().isReady;

  @override
  IndexInfo indexInfo() => _inMemoryPackageIndex.indexInfo();

  @override
  PackageSearchResult search(ServiceSearchQuery query) {
    final combiner = SearchResultCombiner(
      primaryIndex: _inMemoryPackageIndex,
      dartSdkMemIndex: dartSdkMemIndex,
      flutterSdkMemIndex: flutterSdkMemIndex,
    );
    return combiner.search(query);
  }
}
