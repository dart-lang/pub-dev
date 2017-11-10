// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:_popularity/popularity.dart';

import '../search/scoring.dart';
import '../shared/utils.dart';

final Logger _logger = new Logger('pub.popularity');
final GZipCodec _gzip = new GZipCodec();

/// Sets the popularity storage
void registerPopularityStorage(PopularityStorage storage) =>
    ss.register(#_popularityStorage, storage);

/// The active popularity storage
PopularityStorage get popularityStorage => ss.lookup(#_popularityStorage);

class PopularityStorage {
  final Storage storage;
  final Bucket bucket;
  final _values = <String, double>{};

  String get _latestPath => PackagePopularity.popularityFileName;

  PopularityStorage(this.storage, this.bucket);

  double lookup(String package) => _values[package];

  Future init() async {
    await fetch();
    new Timer.periodic(const Duration(days: 1), (_) {
      fetch();
    });
  }

  Future fetch() async {
    _logger.info('Loading popularity data: ${bucketUri(bucket, _latestPath)}');
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
          'Unable to load popularity data: ${bucketUri(bucket, _latestPath)}',
          e,
          st);
    }
  }

  void _updateLatest(Map raw) {
    final Map<String, int> rawTotals = {};
    final popularity = new PackagePopularity.fromJson(raw);
    popularity.items.forEach((pkg, item) {
      rawTotals[pkg] = item.score;
    });
    final summary = new Summary(rawTotals.values);
    for (String package in rawTotals.keys) {
      final int raw = rawTotals[package];
      _values[package] = summary.bezierScore(raw);
    }
    _logger.info('Popularity updated for ${popularity.items.length} packages.');
  }
}
