// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: annotate_overrides
library pub_dartlang_org.search.backend;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:logging/logging.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:json_annotation/json_annotation.dart';
import 'package:_popularity/popularity.dart';

import '../frontend/models.dart';
import '../shared/analyzer_client.dart';
import '../shared/mock_scores.dart';
import '../shared/search_service.dart';

import 'scoring.dart';
import 'text_utils.dart';

part 'backend.g.dart';

Logger _logger = new Logger('pub.search.backend');

final Duration _year = const Duration(days: 365);
final Duration _twoYears = _year * 2;

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

/// Sets the popularity storage
void registerPopularityStorage(PopularityStorage storage) =>
    ss.register(#_popularityStorage, storage);

/// The active popularity storage
PopularityStorage get popularityStorage => ss.lookup(#_popularityStorage);

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
      final double popularity = popularityStorage.lookup(pv.package) ??
          mockScores[pv.package]?.toDouble() ??
          0.0;
      final double maintenance = _calculateMaintenance(p, pv);

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
        maintenance: maintenance,
        timestamp: new DateTime.now().toUtc(),
      );
    }
    return results;
  }

  double _calculateMaintenance(Package p, PackageVersion pv) {
    final DateTime now = new DateTime.now().toUtc();
    final Duration age = now.difference(pv.created);

    if (age > _twoYears) {
      return 0.0;
    }

    double score = 1.0;

    if (age > _year) {
      final int daysLeft = (_twoYears - age).inDays;
      final double p = daysLeft / 365;
      score *= max(0.0, min(1.0, p));
    }

    if (pv.changelogContent == null || pv.changelogContent.length < 100) {
      score *= 0.80;
    }
    if (pv.readmeContent == null || pv.readmeContent.length < 100) {
      score *= 0.95;
    }

    // no confidence from the author?
    if (pv.version.startsWith('0.0.')) {
      score *= 0.95;
    } else if (pv.version.startsWith('0.')) {
      score *= 0.99;
    }

    // TODO: check frequency of major version releases

    return score;
  }
}

class PopularityStorage {
  static final String _latestPath = 'popularity-latest.json.gz';
  final Storage storage;
  final Bucket bucket;

  final _values = <String, double>{};

  PopularityStorage(this.storage, this.bucket);

  double lookup(String package) => _values[package];

  Future init() async {
    await fetch();
    new Timer.periodic(const Duration(days: 1), (_) {
      fetch();
    });
  }

  Future fetch() async {
    _logger.info('Loading popularity data: ${_bucketUri(bucket, _latestPath)}');
    try {
      final Map latest = await bucket
          .read(_latestPath)
          .transform(_gzip.decoder)
          .transform(UTF8.decoder)
          .transform(JSON.decoder)
          .single;
      _updateLatest(latest);
    } catch (e, st) {
      _logger.severe(
          'Unable to load popularity data: ${_bucketUri(bucket, _latestPath)}',
          e,
          st);
    }
  }

  void _updateLatest(Map raw) {
    final Map<String, int> rawTotals = {};
    final popularity = new PackagePopularity.fromJson(raw);
    for (var item in popularity.items) {
      final int finalVotes =
          item.votesDirect * 25 + item.votesDev * 5 + item.votesTotal;
      rawTotals[item.pkg] = finalVotes;
    }
    final summary = new Summary(rawTotals.values);
    for (String package in rawTotals.keys) {
      final int raw = rawTotals[package];
      _values[package] = summary.bezierScore(raw);
    }
    _logger.info('Popularity updated for ${popularity.items.length} packages.');
  }
}

class SnapshotStorage {
  final String _latestPath = 'snapshot-latest.json.gz';
  final Storage storage;
  final Bucket bucket;

  SnapshotStorage(this.storage, this.bucket);

  Future<SearchSnapshot> fetch() async {
    Future<SearchSnapshot> load(String path) async {
      try {
        final Map json = await bucket
            .read(path)
            .transform(_gzip.decoder)
            .transform(UTF8.decoder)
            .transform(JSON.decoder)
            .single;
        return new SearchSnapshot.fromJson(json);
      } catch (e, st) {
        _logger.severe(
            'Unable to load search snapshot: ${_bucketUri(bucket, path)}',
            e,
            st);
      }
      return null;
    }

    final SearchSnapshot latest = await load(_latestPath);
    if (latest != null) return latest;

    // TODO: remove after the prod instance is migrated to single-file uploads
    // Fall back on listing the bucket.
    _logger.severe('Falling back to list the search snapshot bucket.');

    final List<BucketEntry> list = await bucket.list().toList();
    final List<String> names = list
        .where((entry) => entry.isObject)
        .map((entry) => entry.name)
        .toList();
    if (names.isEmpty) return null;
    // Try to load the available snapshots in reverse order (latest first).
    names.sort();
    for (String selected in names.reversed) {
      final SearchSnapshot snapshot = await load(selected);
      if (snapshot != null) return snapshot;
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

final GZipCodec _gzip = new GZipCodec();

/// Returns a valid `gs://` URI for a given [bucket] + [path] combination.
String _bucketUri(Bucket bucket, String path) =>
    "gs://${bucket.bucketName}/$path";
