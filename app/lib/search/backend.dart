// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:logging/logging.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

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

import 'models.dart';
import 'search_service.dart';
import 'text_utils.dart';

final Logger _logger = Logger('pub.search.backend');

/// Sets the backend service.
void registerSearchBackend(SearchBackend backend) =>
    ss.register(#_searchBackend, backend);

/// The active backend service.
SearchBackend get searchBackend => ss.lookup(#_searchBackend) as SearchBackend;

/// Sets the snapshot storage
void registerSnapshotStorage(SnapshotStorage storage) =>
    ss.register(#_snapshotStorage, storage);

/// The active snapshot storage
SnapshotStorage get snapshotStorage =>
    ss.lookup(#_snapshotStorage) as SnapshotStorage;

/// The [PackageIndex] registered in the current service scope.
PackageIndex get packageIndex =>
    ss.lookup(#packageIndexService) as PackageIndex;

/// Register a new [PackageIndex] in the current service scope.
void registerPackageIndex(PackageIndex index) =>
    ss.register(#packageIndexService, index);

/// Datastore-related access methods for the search service
class SearchBackend {
  final DatastoreDB _db;
  final _http = httpRetryClient();

  SearchBackend(this._db);

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
        timeout: const Duration(minutes: 1));

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

    return PackageDocument(
      package: pv.package,
      version: pv.version!,
      tags: tags.toList(),
      description: compactDescription(pv.pubspec!.description),
      created: p.created,
      updated: p.lastVersionPublished,
      readme: compactReadme(readmeAsset?.textContent),
      likeCount: p.likes,
      grantedPoints: scoreCard?.grantedPubPoints,
      maxPoints: scoreCard?.maxPubPoints ?? 0,
      dependencies: _buildDependencies(pv.pubspec!, scoreCard),
      apiDocPages: apiDocPages,
      timestamp: clock.now().toUtc(),
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

  Future<void> close() async {
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

class SnapshotStorage {
  final VersionedJsonStorage _storage;
  SearchSnapshot? _snapshot;
  Timer? _snapshotWriteTimer;

  SnapshotStorage(Bucket bucket)
      : _storage = VersionedJsonStorage(bucket, 'snapshot/');

  Map<String, PackageDocument> get documents => _snapshot!.documents!;

  void add(PackageDocument doc) {
    _snapshot!.add(doc);
  }

  void remove(String package) {
    _snapshot!.remove(package);
  }

  void startTimer() {
    _snapshotWriteTimer ??= Timer.periodic(
        Duration(hours: 6, minutes: Random.secure().nextInt(120)), (_) {
      _updateSnapshotIfNeeded();
    });
  }

  Future<void> fetch() async {
    final version = await _storage.detectLatestVersion();
    if (version == null) {
      _logger.shout('Unable to detect the latest search snapshot file.');
    }
    try {
      final map = await _storage.getContentAsJsonMap(version);
      _snapshot = SearchSnapshot.fromJson(map);
      _snapshot!.documents!
          .removeWhere((packageName, doc) => isSoftRemoved(packageName));

      final count = _snapshot!.documents!.length;
      _logger
          .info('Got $count packages from snapshot at ${_snapshot!.updated}');
    } catch (e, st) {
      final uri = _storage.getBucketUri(version);
      _logger.shout('Unable to load search snapshot: $uri', e, st);
    }
    // Create an empty snapshot if the above failed. This will be populated with
    // package data via a separate update process.
    _snapshot ??= SearchSnapshot();
  }

  /// Deletes old data files in snapshot storage (for old runtimes that are more
  /// than half a year old).
  Future<void> deleteOldData() async {
    final counts =
        await _storage.deleteOldData(minAgeThreshold: Duration(days: 182));
    _logger.info(
        'delete-old-search-snapshots cleared $counts entries ($runtimeVersion)');
  }

  Future<void> _updateSnapshotIfNeeded() async {
    // TODO: make the catch-all block narrower
    try {
      final wasUpdatedRecently =
          await _storage.hasCurrentData(maxAge: Duration(hours: 24));
      if (wasUpdatedRecently) {
        _logger.info('Snapshot update skipped (found recent snapshot).');
      } else {
        _logger.info('Updating search snapshot...');
        await _storage.uploadDataAsJsonMap(_snapshot!.toJson());
        _logger.info('Search snapshot update completed.');
      }
    } catch (e, st) {
      _logger.warning('Unable to update search snapshot.', e, st);
    }
  }

  Future<void> close() async {
    _snapshotWriteTimer?.cancel();
    _snapshotWriteTimer = null;
    _storage.close();
  }
}
