// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../frontend/models.dart';
import '../shared/analyzer_client.dart';
import '../shared/dartdoc_client.dart';
import '../shared/email.dart' show EmailAddress;
import '../shared/packages_overrides.dart';
import '../shared/popularity_storage.dart';
import '../shared/search_service.dart';
import '../shared/storage.dart';
import '../shared/versions.dart' as versions;
import 'text_utils.dart';

part 'backend.g.dart';

final Logger _logger = new Logger('pub.search.backend');

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

/// Datastore-related access methods for the search service
class SearchBackend {
  final DatastoreDB _db;

  SearchBackend(this._db);

  /// Loads the list of packages, their latest stable versions and returns a
  /// matching list of [PackageDocument] objects for search.
  ///
  /// Packages are omitted when:
  ///  * latest version is missing,
  ///  * analysis is missing,
  ///  * the package is not dart 2.0 compatible.
  Future<List<PackageDocument>> loadDocuments(List<String> packageNames) async {
    final List<Key> packageKeys = packageNames
        .map((String name) => _db.emptyKey.append(Package, id: name))
        .toList();
    var packages = (await _db.lookup(packageKeys)).cast<Package>();

    // Load only for the existing packages.
    final List<Key> versionKeys = packages
        .where((p) => p != null)
        .map((p) => p.latestVersionKey)
        .toList();
    final versionList = (await _db.lookup(versionKeys)).cast<PackageVersion>();
    final Map<String, PackageVersion> versions = new Map.fromIterable(
        versionList.where((pv) => pv != null),
        key: (pv) => (pv as PackageVersion).package);
    // Remove legacy packages from search
    packages = packages
        .where((p) =>
            versions.containsKey(p.name) &&
            !versions[p].pubspec.supportsOnlyLegacySdk)
        .toList();

    final pubDataFutures = Future.wait<String>(
      packages.map(
        (p) => dartdocClient.getTextContent(p.name, 'latest', 'pub-data.json',
            timeout: const Duration(minutes: 1)),
      ),
    );

    final List<AnalysisView> analysisViews =
        await analyzerClient.getAnalysisViews(packages.map((p) =>
            p == null ? null : new AnalysisKey(p.name, p.latestVersion)));

    final pubDataContents = await pubDataFutures;

    final List<PackageDocument> results = [];
    for (int i = 0; i < packages.length; i++) {
      final Package p = packages[i];
      if (p == null) continue;
      final PackageVersion pv = versions[p.name];
      if (pv == null) continue;

      final analysisView = analysisViews[i];
      final double popularity = popularityStorage.lookup(pv.package) ?? 0.0;

      final String pubDataContent = pubDataContents[i];
      List<ApiDocPage> apiDocPages;
      if (pubDataContent != null) {
        try {
          if (pubDataContent.isEmpty) {
            _logger.info('Got empty pub-data.json for package ${p.name}.');
          } else {
            apiDocPages = _apiDocPagesFromPubDataText(pubDataContent);
          }
        } catch (e, st) {
          _logger.severe('Parsing pub-data.json failed.', e, st);
        }
      }

      results.add(new PackageDocument(
        package: pv.package,
        version: p.latestVersion,
        devVersion: p.latestDevVersion,
        platforms: analysisView.platforms,
        description: compactDescription(pv.pubspec.description),
        created: p.created,
        updated: pv.created,
        readme: compactReadme(pv.readmeContent),
        isDiscontinued: p.isDiscontinued ?? false,
        doNotAdvertise: p.doNotAdvertise ?? false,
        health: analysisView.health,
        popularity: popularity,
        maintenance: analysisView.maintenanceScore,
        dependencies: _buildDependencies(analysisView),
        emails: _buildEmails(p, pv),
        apiDocPages: apiDocPages,
        timestamp: new DateTime.now().toUtc(),
      ));
    }
    return results;
  }

  Map<String, String> _buildDependencies(AnalysisView view) {
    final Map<String, String> dependencies = <String, String>{};
    view.allDependencies?.forEach((pd) {
      dependencies[pd.package] = pd.dependencyType;
    });
    return dependencies;
  }

  List<String> _buildEmails(Package p, PackageVersion pv) {
    final Set<String> emails = new Set<String>();
    emails.addAll(p.uploaderEmails.cast<String>());
    for (String value in pv.pubspec.authors) {
      final EmailAddress author = new EmailAddress.parse(value);
      if (author.email == null) continue;
      emails.add(author.email);
    }
    return emails.toList()..sort();
  }

  List<ApiDocPage> _apiDocPagesFromPubDataText(String text) {
    final decodedMap = json.decode(text) as Map;
    final pubData = new PubDartdocData.fromJson(decodedMap.cast());
    return apiDocPagesFromPubData(pubData);
  }
}

/// Creates the index-related API data structure from the extracted dartdoc data.
List<ApiDocPage> apiDocPagesFromPubData(PubDartdocData pubData) {
  final nameToKindMap = <String, String>{};
  pubData.apiElements.forEach((e) {
    nameToKindMap[e.qualifiedName] = e.kind;
  });

  final pathMap = <String, String>{};
  final symbolMap = <String, Set<String>>{};
  final docMap = <String, List<String>>{};

  bool isTopLevel(String kind) => kind == 'library' || kind == 'class';

  void update(String key, String symbol, String documentation) {
    final set = symbolMap.putIfAbsent(key, () => new Set<String>());
    set.add(symbol);

    documentation = documentation?.trim();
    if (documentation != null && documentation.isNotEmpty) {
      final list = docMap.putIfAbsent(key, () => []);
      list.add(compactReadme(documentation));
    }
  }

  pubData.apiElements.forEach((apiElement) {
    if (isTopLevel(apiElement.kind)) {
      pathMap[apiElement.qualifiedName] = apiElement.href;
      update(
          apiElement.qualifiedName, apiElement.name, apiElement.documentation);
    }

    if (!isTopLevel(apiElement.kind) &&
        apiElement.parent != null &&
        isTopLevel(nameToKindMap[apiElement.parent])) {
      update(apiElement.parent, apiElement.name, apiElement.documentation);
    }
  });

  final results = pathMap.keys.map((key) {
    final path = pathMap[key];
    final symbols = symbolMap[key].toList()..sort();
    return new ApiDocPage(
      relativePath: path,
      symbols: symbols,
      textBlocks: docMap[key],
    );
  }).toList();
  results.sort((a, b) => a.relativePath.compareTo(b.relativePath));
  return results;
}

/// Splits the flat SDK data into per-library data (in the same data format).
List<PubDartdocData> splitLibraries(PubDartdocData data) {
  final librariesMap = <String, List<ApiElement>>{};
  final rootMap = <String, String>{};
  data.apiElements?.forEach((elem) {
    String library;
    if (elem.parent == null) {
      library = elem.name;
    } else {
      library = rootMap[elem.parent] ?? elem.parent;
      rootMap[elem.qualifiedName] = library;
    }
    librariesMap.putIfAbsent(library, () => <ApiElement>[]).add(elem);
  });
  return librariesMap.values
      .map((list) => new PubDartdocData(apiElements: list))
      .toList();
}

/// Creates the index-related data structure for an SDK library.
PackageDocument createSdkDocument(PubDartdocData lib) {
  final apiDocPages = apiDocPagesFromPubData(lib);
  final package = lib.apiElements.first.name;
  final documentation = lib.apiElements.first.documentation ?? '';
  final description = documentation.split('\n\n').first.trim();
  return new PackageDocument(
    package: package,
    version: versions.toolEnvSdkVersion,
    description: description,
    apiDocPages: apiDocPages,
  );
}

class SnapshotStorage {
  VersionedJsonStorage _snapshots;

  SnapshotStorage(Bucket bucket)
      : _snapshots = new VersionedJsonStorage(bucket, 'snapshot/');

  Future<SearchSnapshot> fetch() async {
    final version = await _snapshots.detectLatestVersion();
    if (version == null) {
      _logger.shout('Unable to detect the latest search snapshot file.');
      return null;
    }
    try {
      final map = await _snapshots.getContentAsJsonMap(version);
      final snapshot = new SearchSnapshot.fromJson(map);
      snapshot.documents
          .removeWhere((packageName, doc) => isSoftRemoved(packageName));
      return snapshot;
    } catch (e, st) {
      final uri = _snapshots.getBucketUri(version);
      _logger.shout('Unable to load search snapshot: $uri', e, st);
    }
    return null;
  }

  Future store(SearchSnapshot snapshot) async {
    await _snapshots.uploadDataAsJsonMap(snapshot.toJson());
  }

  void scheduleOldDataGC() {
    _snapshots.scheduleOldDataGC();
  }
}

@JsonSerializable()
class SearchSnapshot {
  @JsonKey(nullable: false)
  DateTime updated;

  @JsonKey(nullable: false)
  Map<String, PackageDocument> documents;

  SearchSnapshot._(this.updated, this.documents);

  factory SearchSnapshot() =>
      new SearchSnapshot._(new DateTime.now().toUtc(), {});

  factory SearchSnapshot.fromJson(Map<String, dynamic> json) =>
      _$SearchSnapshotFromJson(json);

  void add(PackageDocument doc) {
    updated = new DateTime.now().toUtc();
    documents[doc.package] = doc;
  }

  void addAll(Iterable<PackageDocument> docs) {
    docs.forEach(add);
  }

  void remove(String packageName) {
    updated = new DateTime.now().toUtc();
    documents.remove(packageName);
  }

  Map<String, dynamic> toJson() => _$SearchSnapshotToJson(this);
}
