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
import 'package:json_serializable/annotations.dart';

import '../frontend/models.dart';
import '../shared/analyzer_client.dart';
import '../shared/mock_scores.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart';

import 'text_utils.dart';

part 'backend.g.dart';

Logger _logger = new Logger('pub.search.backend');

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
  /// When a package or its latest version is missing, the method returns with
  /// null at the given index.
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
        key: (PackageVersion pv) => pv.package);

    final List<AnalysisView> analysisViews = await Future.wait(packages.map(
      (Package p) async {
        if (p == null) return null;
        final PackageVersion pv = versions[p.name];
        return new AnalysisView(
            await analyzerClient.getAnalysisData(pv.package, pv.version));
      },
    ));

    final List<PackageDocument> results = new List(packages.length);
    for (int i = 0; i < packages.length; i++) {
      final Package p = packages[i];
      if (p == null) continue;
      final PackageVersion pv = versions[p.name];
      if (pv == null) continue;

      final analysisView = analysisViews[i];

      results[i] = new PackageDocument(
        url: pubUrlOfPackage(pv.package),
        package: pv.package,
        version: p.latestVersion,
        devVersion: p.latestDevVersion,
        platforms: indexDartPlatform(analysisView.platform),
        description: compactDescription(pv.pubspec.description),
        lastUpdated: pv.shortCreated,
        readme: compactReadme(pv.readmeContent),
        health: analysisView.health,
        popularity: mockScores[pv.package] ?? 0.0,
        timestamp: new DateTime.now().toUtc(),
      );
    }
    return results;
  }
}

class SnapshotStorage {
  final Storage storage;
  final Bucket bucket;
  final GZipCodec _gzip = new GZipCodec();

  SnapshotStorage(this.storage, this.bucket);

  Future<SearchSnapshot> fetch() async {
    final List<BucketEntry> list = await bucket.list().toList();
    final List<String> names = list
        .where((entry) => entry.isObject)
        .map((entry) => entry.name)
        .toList();
    if (names.isEmpty) return null;
    // Try to load the available snapshots in reverse order (latest first).
    names.sort();
    for (String selected in names.reversed) {
      try {
        final String json = await bucket
            .read(selected)
            .transform(_gzip.decoder)
            .transform(UTF8.decoder)
            .join();
        return new SearchSnapshot.fromJson(JSON.decode(json));
      } catch (e, st) {
        _logger.severe('Unable to load snapshot: $selected', e, st);
      }
    }
    return null;
  }

  Future store(SearchSnapshot snapshot) async {
    // garbage-collect old entries after upload is successful
    final List<BucketEntry> list = await bucket.list().toList();
    final List<String> toDelete = list
        .where((entry) => entry.isObject)
        .map((entry) => entry.name)
        .toList();

    // data buffer to write
    final List<int> buffer =
        _gzip.encode(UTF8.encode(JSON.encode(snapshot.toJson())));

    // generate name from current timestamp
    final String ts =
        new DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
    final currentName = 'snapshot-$ts.json.gz';

    // prevent race: don't delete entries that are later than current snapshot
    toDelete.removeWhere((String name) => name.compareTo(currentName) >= 0);

    // upload
    await bucket.writeBytes(currentName, buffer);

    // upload successful, garbage-collect entries
    for (String name in toDelete) {
      try {
        await bucket.delete(name);
      } catch (e, st) {
        _logger.warning('Snapshot delete failed: $name', e, st);
      }
    }
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
