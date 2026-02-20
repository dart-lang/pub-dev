// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:pana/src/dartdoc/pub_dartdoc_data.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';
import 'package:pub_dev/shared/monitoring.dart';
import 'package:retry/retry.dart';

import '../../publisher/backend.dart';
import '../../service/download_counts/backend.dart';
import '../../service/topics/models.dart';
import '../../shared/redis_cache.dart';
import '../../shared/utils.dart';
import '../package/backend.dart';
import '../package/model_properties.dart';
import '../package/models.dart';
import '../package/overrides.dart';
import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../search/mem_index.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/storage.dart';
import '../shared/versions.dart';
import '../task/backend.dart';
import '../task/global_lock.dart';

import 'models.dart';
import 'result_combiner.dart';
import 'sdk_mem_index.dart';
import 'search_client.dart';
import 'search_service.dart';
import 'text_utils.dart';

final Logger _logger = Logger('pub.search.backend');

/// The number of concurrent datastore/bucket fetch operations while
/// building or updating the snapshot.
const _defaultSnapshotBuildConcurrency = 8;

/// The (approximate) amount of time while the process holds the lock
/// and works on index building and updates.
const _maxLockHoldPeriod = Duration(days: 1);

/// Sets the backend service.
void registerSearchBackend(SearchBackend backend) =>
    ss.register(#_searchBackend, backend);

/// The active backend service.
SearchBackend get searchBackend => ss.lookup(#_searchBackend) as SearchBackend;

/// Holder instance for the in-memory (primary) [InMemoryPackageIndex] registered in the current service scope.
PackageIndexHolder get _packageIndexHolder =>
    ss.lookup(#_packageIndexHolder) as PackageIndexHolder;

/// Register a new [PackageIndexHolder] in the current service scope.
void registerPackageIndexHolder(PackageIndexHolder indexHolder) =>
    ss.register(#_packageIndexHolder, indexHolder);

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
      '$runtimeVersion/search/update-snapshot',
      expiration: Duration(minutes: 20),
    );
    final started = clock.now();
    while (true) {
      try {
        await lock.withClaim((claim) async {
          // Force timeout exception if the process does not release the lock.
          final lockHoldTimeout = _maxLockHoldPeriod + Duration(hours: 1);
          await doCreateAndUpdateSnapshot(claim).timeout(lockHoldTimeout);
        });
      } catch (e, st) {
        _logger.pubNoticeShout(
          'snapshot-building',
          'Snapshot update failed.',
          e,
          st,
        );
        // Force waiting at least an hour before we rethrow the exception,
        // otherwise we could get into a reboot loop that doesn't get much
        // real work done on the other tasks.
        final elapsed = clock.now().difference(started);
        if (elapsed < Duration(hours: 1)) {
          _logger.warning('Waiting before rethrowing exception.', e, st);
          await Future.delayed(Duration(hours: 1) - elapsed);
        }
        // Throwing here will crash the VM and force the instance to restart.
        rethrow;
      }

      // Allow another instance to get the lock and build the index.
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
    final workUntil = clock.now().add(_maxLockHoldPeriod);

    // creating snapshot from scratch
    final snapshot = SearchSnapshot();
    Future<void> updatePackage(String package, DateTime? updated) async {
      if (!claim.valid) {
        return;
      }
      if (isSdkPackage(package)) {
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
      await retry(() async {
        try {
          final doc = await loadDocument(package);
          snapshot.add(doc);
        } on RemovedPackageException catch (_) {
          snapshot.remove(package);
        } on NotFoundException catch (_) {
          snapshot.remove(package);
        }
      });
    }

    // initial scan of packages
    final pool = Pool(concurrency);
    final futures = <Future>[];
    await for (final package in packageBackend.allPackages()) {
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
    snapshot.updateAllScores();

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
        // Updates the normalized scores across all the packages.
        snapshot.updateAllScores();

        await _snapshotStorage.uploadDataAsJsonMap(snapshot.toJson());
        lastUploadedSnapshotTimestamp = snapshot.updated!;
      }

      await Future.delayed(sleepDuration);
    }
    await pool.close();
  }

  Future<Map<String, DateTime>> _queryRecentlyUpdated(
    DateTime lastQueryStarted,
  ) async {
    final updatedThreshold = lastQueryStarted.subtract(Duration(minutes: 5));
    final results = <String, DateTime>{};
    void addResult(String pkg, DateTime updated) {
      final current = results[pkg];
      if (current == null || current.isBefore(updated)) {
        results[pkg] = updated;
      }
    }

    await for (final e in _db.packages.listUpdatedSince(updatedThreshold)) {
      addResult(e.name, e.updated);
    }

    await for (final e in _db.tasks.listFinishedSince(updatedThreshold)) {
      addResult(e.package, e.finished);
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
    if (p.publisherId != null) {
      final publisherStatus = await publisherBackend.getPublisherStatus(
        p.publisherId!,
      );
      if (!publisherStatus.isVisible) {
        throw RemovedPackageException();
      }
    }

    // Get the scorecard with the latest version available with finished analysis.
    final scoreCard = await scoreCardBackend.getLatestFinishedScoreCardData(
      packageName,
    );

    // Load the version with the analysis above, or the latest version if no analysis
    // has been finished yet.
    final releases = await packageBackend.latestReleases(p);
    final pv = await packageBackend.lookupPackageVersion(
      packageName,
      scoreCard.packageVersion ?? releases.stable.version,
    );
    if (pv == null) {
      throw RemovedPackageException();
    }
    final readmeAsset = await packageBackend.lookupPackageVersionAsset(
      packageName,
      pv.version!,
      AssetKind.readme,
    );

    // Find tags from latest prerelease and/or preview (if there one).
    Future<Iterable<String>> loadFutureTags(String version) async {
      final futureVersion = await packageBackend.lookupPackageVersion(
        packageName,
        version,
      );
      final futureVersionAnalysis = await scoreCardBackend.getScoreCardData(
        packageName,
        version,
      );
      final futureTags = <String>{
        ...?futureVersion?.getTags(),
        ...?futureVersionAnalysis.panaReport?.derivedTags,
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
      ...?scoreCard.panaReport?.derivedTags,
      ...prereleaseTags,
      ...previewTags,
    };

    List<ApiDocPage>? apiDocPages;
    try {
      final pubDataBytes = await taskBackend.gzippedTaskResult(
        packageName,
        pv.version!,
        'doc/pub-data.json',
      );
      final pubDataContent = pubDataBytes == null
          ? null
          : utf8.decode(gzip.decode(pubDataBytes), allowMalformed: true);
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
      ...pv.pubspec!.canonicalizedTopics,
    ].join(' ');

    // select the latest entity updated timestamp (when available)
    final sourceUpdated = [p.updated, scoreCard.updated].nonNulls.maxOrNull;

    return PackageDocument(
      package: pv.package,
      version: pv.version!,
      tags: tags.toList(),
      description: compactDescription(descriptionAndTopics),
      created: p.created!,
      updated: p.lastVersionPublished!,
      readme: compactReadme(readmeAsset?.textContent),
      downloadCount: downloadCountsBackend.lookup30DaysTotalCounts(pv.package),
      trendScore: downloadCountsBackend.lookupTrendScore(pv.package),
      likeCount: p.likes,
      grantedPoints: scoreCard.grantedPubPoints,
      maxPoints: scoreCard.maxPubPoints,
      dependencies: await _buildDependencies(pv.pubspec!, scoreCard),
      apiDocPages: apiDocPages,
      timestamp: clock.now().toUtc(),
      sourceUpdated: sourceUpdated,
    );
  }

  Future<Map<String, String>> _buildDependencies(
    Pubspec pubspec,
    ScoreCardData? view,
  ) async {
    final dependencies = <String, String>{};
    for (final p in view?.panaReport?.allDependencies ?? <String>[]) {
      if (await packageBackend.isPackageVisible(p)) {
        dependencies[p] = DependencyTypes.transitive;
      }
    }
    for (final p in pubspec.devDependencies) {
      // Note: at this point the visibility may have been checked.
      if (dependencies.containsKey(p) ||
          await packageBackend.isPackageVisible(p)) {
        dependencies[p] = DependencyTypes.dev;
      }
    }
    for (final p in pubspec.dependencyNames) {
      // Note: at this point the visibility may have been checked.
      if (dependencies.containsKey(p) ||
          await packageBackend.isPackageVisible(p)) {
        dependencies[p] = DependencyTypes.direct;
      }
    }
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
      if (p.isNotVisible) continue;
      if (p.publisherId != null) {
        final ps = await publisherBackend.getPublisherStatus(p.publisherId!);
        if (!ps.isVisible) continue;
      }
      final releases = await packageBackend.latestReleases(p);
      yield PackageDocument(
        package: p.name!,
        version: releases.stable.version,
        tags: p.getTags().toList(),
        created: p.created!,
        updated: p.lastVersionPublished!,
        likeCount: p.likes,
        grantedPoints: 0,
        maxPoints: 0,
        timestamp: clock.now().toUtc(),
      );
    }
  }

  Future<List<PackageDocument>?> fetchSnapshotDocuments() async {
    try {
      final map = await _snapshotStorage.getContentAsJsonMap();
      if (map == null) {
        _logger.info('No snapshot to fetch.');
        return null;
      }
      final snapshot = SearchSnapshot.fromJson(map);
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
      minAgeThreshold: Duration(days: 182),
    );
    _logger.info(
      'delete-old-search-snapshots cleared $counts entries ($runtimeVersion)',
    );
  }

  /// Creates the content for the /api/package-name-completion-data endpoint.
  Future<Map<String, Object?>> getPackageNameCompletionData() async {
    final rs = await searchClient.search(
      ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.regularSearch(),
        limit: 20000,
      ),
      // Do not cache response at the search client level, as we'll be caching
      // it in a processed form much longer.
      skipCache: true,
    );
    return {'packages': rs.packageHits.map((p) => p.package).toList()};
  }

  /// Creates the gzipped byte content for the /api/package-name-completion-data endpoint.
  Future<List<int>> getPackageNameCompletionDataJsonGz() async {
    final bytes = await cache.packageNameCompletionDataJsonGz().get(() async {
      final data = await getPackageNameCompletionData();
      return gzip.encode(jsonUtf8Encoder.convert(data));
    });
    return bytes!;
  }

  Future<void> close() async {
    _snapshotStorage.close();
  }
}

/// Returns a new search form that may override predicates to their canonical forms.
/// Returns `null` if no change was made.
SearchForm? canonicalizeSearchForm(SearchForm form) {
  final query = form.parsedQuery;
  final tags = query.tagsPredicate;
  TagsPredicate? newTags;
  if (tags.hasTagPrefix('topic:')) {
    newTags = tags.canonicalizeKeys((key) {
      if (key.startsWith('topic:')) {
        final topic = key.substring(6);
        final canonicalTopic = canonicalTopics.aliasToCanonicalMap[topic];
        return canonicalTopic == null ? null : 'topic:$canonicalTopic';
      } else {
        return null;
      }
    });
  }
  if (newTags != null) {
    return form.change(query: query.change(tagsPredicate: newTags).toString());
  }

  final newQueryText = form.parsedQuery.text
      ?.split(' ')
      .map((p) {
        if (p.startsWith('#') && p.length > 1) {
          final topic = p.substring(1);
          // Checking the surface format, and skipping the change if the
          // text would be an invalid topic.
          if (!isValidTopicFormat(topic)) {
            return p;
          }
          // NOTE: We don't know if this topic exists or spelled correctly.
          //       We should consider restricting the updates to existing
          //       topics only (TBD).
          return 'topic:$topic';
        }
        return p;
      })
      .join(' ');
  if (newQueryText != form.parsedQuery.text) {
    return form.change(query: newQueryText);
  }

  return null;
}

/// Creates the index-related API data structure from the extracted dartdoc data.
List<ApiDocPage> apiDocPagesFromPubData(PubDartdocData pubData) {
  final nameToApiElementMap = <String, ApiElement>{};
  pubData.apiElements!.forEach((e) {
    final href = e.href;
    if (href != null) {
      nameToApiElementMap[e.qualifiedName] = e;
    }
  });

  final pathMap = <String, String?>{};
  final symbolMap = <String, Set<String>>{};

  bool isTopLevelApiElement(ApiElement? href) {
    if (href == null) return false;
    return href.isClass || href.isLibrary;
  }

  void update(String key, String symbol, String? documentation) {
    if (isCommonApiSymbol(symbol)) {
      return;
    }
    final set = symbolMap.putIfAbsent(key, () => <String>{});
    set.add(symbol);
  }

  pubData.apiElements!.forEach((apiElement) {
    if (isTopLevelApiElement(apiElement)) {
      pathMap[apiElement.qualifiedName] = apiElement.href;
      update(
        apiElement.qualifiedName,
        apiElement.name,
        apiElement.documentation,
      );
    } else if (apiElement.parent != null &&
        isTopLevelApiElement(nameToApiElementMap[apiElement.parent])) {
      update(apiElement.parent!, apiElement.name, apiElement.documentation);
    }
  });

  final results = pathMap.keys.where(symbolMap.containsKey).map((key) {
    final path = pathMap[key]!;
    final symbols = symbolMap[key]!.toList()..sort();
    return ApiDocPage(relativePath: path, symbols: symbols);
  }).toList();
  results.sort((a, b) => a.relativePath.compareTo(b.relativePath));
  return results;
}

/// Downloads the remote SDK content from [uri] and creates a cached file in the
/// `.dart_tool/pub-search-data/` directory.
///
/// When a local file in `app/.dart_tool/pub-search-data/<reduced-uri>` exists,
/// its content will be loaded instead. URL reduction replaces slashes and other
/// non-characters with a single dash `-`, like:
/// - `https-api.dart.dev-stable-latest-index.json`
Future<String> loadOrFetchSdkIndexJsonAsString(
  Uri uri, {
  @visibleForTesting Duration? ttl,
}) async {
  final fileName = uri.toString().replaceAll(RegExp(r'[^a-z0-9\.]+'), '-');
  final file = File(p.join('.dart_tool', 'pub-search-data', fileName));
  if (await file.exists()) {
    var canUseCached = true;
    if (ttl != null) {
      final age = clock.now().difference(await file.lastModified());
      if (age > ttl) {
        canUseCached = false;
      }
    }
    if (canUseCached) {
      return await file.readAsString();
    }
  }

  final content = await httpGetWithRetry(uri, responseFn: (rs) => rs.body);
  await file.parent.create(recursive: true);
  await file.writeAsString(content);
  return content;
}

class _CombinedSearchIndex implements SearchIndex {
  const _CombinedSearchIndex();

  @override
  bool isReady() => indexInfo().isReady;

  @override
  IndexInfo indexInfo() => _packageIndexHolder._index.indexInfo();

  @override
  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    final combiner = SearchResultCombiner(
      primaryIndex: _packageIndexHolder,
      sdkIndex: sdkIndex,
    );
    return await combiner.search(query);
  }
}

/// Holds an immutable [InMemoryPackageIndex] that is the actual active search index.
class PackageIndexHolder implements SearchIndex {
  var _index = InMemoryPackageIndex(documents: const []);

  @override
  bool isReady() => indexInfo().isReady;

  @override
  IndexInfo indexInfo() => _index.indexInfo();

  @override
  PackageSearchResult search(ServiceSearchQuery query) {
    return _index.search(query);
  }

  /// Updates the active package index with [newIndex].
  void updatePackageIndex(InMemoryPackageIndex newIndex) {
    _index = newIndex;
  }
}

/// Updates the active package index with [newIndex].
void updatePackageIndex(InMemoryPackageIndex newIndex) {
  _packageIndexHolder._index = newIndex;
}
