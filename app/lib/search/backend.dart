// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.search.backend;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';

import '../frontend/models.dart';
import '../shared/analyzer_client.dart';
import '../shared/mock_scores.dart';
import '../shared/popularity_storage.dart';
import '../shared/search_service.dart';
import '../shared/utils.dart';

import 'text_utils.dart';

part 'backend.g.dart';

final Logger _logger = new Logger('pub.search.backend');
final GZipCodec _gzip = new GZipCodec();

/// Sets the backend service.
void registerSearchBackend(SearchBackend backend) =>
    ss.register(#_searchBackend, backend);

/// The active backend service.
SearchBackend get searchBackend => ss.lookup(#_searchBackend);

/// Sets the snapshot storage
void registerSnapshotStorage(SnapshotStorage storage) =>
    ss.register(#_snapshotStorage, storage);

/// The active snapshot storage
SnapshotStorage get snapshotStorage => ss.lookup(#_snapshotStorage);

/// Datastore-related access methods for the search service
class SearchBackend {
  final DatastoreDB _db;

  SearchBackend(this._db);

  /// Loads the list of packages, their latest stable versions and returns a
  /// matching list of [PackageDocument] objects for search.
  /// When a package, its latest version or its analysis is missing, the method
  /// returns with null at the given index.
  Future<List<PackageDocument>> loadDocuments(List<String> packageNames) async {
    final List<Key> packageKeys = packageNames
        .map((String name) => _db.emptyKey.append(Package, id: name))
        .toList();
    final List<Package> packages = await _db.lookup(packageKeys);

    // Load only for the existing packages.
    final List<Key> versionKeys = packages
        .where((p) => p != null)
        .map((p) => p.latestVersionKey)
        .toList();
    final List<PackageVersion> versionList = await _db.lookup(versionKeys);
    final Map<String, PackageVersion> versions = new Map.fromIterable(
        versionList.where((pv) => pv != null),
        key: (pv) => (pv as PackageVersion).package);

    final List<AnalysisView> analysisViews =
        await analyzerClient.getAnalysisViews(packages.map((p) =>
            p == null ? null : new AnalysisKey(p.name, p.latestVersion)));

    final List<PackageDocument> results = new List(packages.length);
    for (int i = 0; i < packages.length; i++) {
      final Package p = packages[i];
      if (p == null) continue;
      final PackageVersion pv = versions[p.name];
      if (pv == null) continue;

      final analysisView = analysisViews[i];
      if (!analysisView.hasAnalysisData) continue;
      final double popularity = popularityStorage.lookup(pv.package) ??
          mockScores[pv.package]?.toDouble() ??
          0.0;

      results[i] = new PackageDocument(
        package: pv.package,
        version: p.latestVersion,
        devVersion: p.latestDevVersion,
        platforms: analysisView.platforms,
        description: compactDescription(pv.pubspec.description),
        created: p.created,
        updated: pv.created,
        readme: compactReadme(pv.readmeContent),
        health: analysisView.health,
        popularity: popularity,
        maintenance: analysisView.maintenanceScore,
        dependencies: _buildDependencies(analysisView),
        timestamp: new DateTime.now().toUtc(),
      );
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
}

class SnapshotStorage {
  final String _latestPath = 'snapshot-latest.json.gz';
  final Storage storage;
  final Bucket bucket;

  SnapshotStorage(this.storage, this.bucket);

  Future<SearchSnapshot> fetch() async {
    try {
      final Map json = await bucket
          .read(_latestPath)
          .transform(_gzip.decoder)
          .transform(UTF8.decoder)
          .transform(JSON.decoder)
          .single;
      return new SearchSnapshot.fromJson(json);
    } catch (e, st) {
      _logger.severe(
          'Unable to load search snapshot: ${bucketUri(bucket, _latestPath)}',
          e,
          st);
    }
    return null;
  }

  Future store(SearchSnapshot snapshot) async {
    final List<int> buffer =
        _gzip.encode(UTF8.encode(JSON.encode(snapshot.toJson())));
    await bucket.writeBytes(_latestPath, buffer);
  }
}

@JsonSerializable()
class SearchSnapshot extends Object with _$SearchSnapshotSerializerMixin {
  @JsonKey(nullable: false)
  DateTime updated;

  @JsonKey(nullable: false)
  Map<String, PackageDocument> documents;

  SearchSnapshot._(this.updated, this.documents);

  factory SearchSnapshot() =>
      new SearchSnapshot._(new DateTime.now().toUtc(), {});

  factory SearchSnapshot.fromJson(Map json) => _$SearchSnapshotFromJson(json);

  void add(PackageDocument doc) {
    updated = new DateTime.now().toUtc();
    documents[doc.package] = doc;
  }

  void addAll(Iterable<PackageDocument> docs) {
    docs.forEach(add);
  }
}
