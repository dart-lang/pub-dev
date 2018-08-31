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

import '../shared/utils.dart';

final Logger _logger = new Logger('pub.popularity');
final GZipCodec _gzip = new GZipCodec();

/// Sets the popularity storage
void registerPopularityStorage(PopularityStorage storage) =>
    ss.register(#_popularityStorage, storage);

/// The active popularity storage
PopularityStorage get popularityStorage =>
    ss.lookup(#_popularityStorage) as PopularityStorage;

class PopularityStorage {
  final Storage storage;
  final Bucket bucket;
  final _values = <String, double>{};
  DateTime _lastFetched;
  String _dateRange;
  Timer _timer;

  String get _latestPath => PackagePopularity.popularityFileName;

  PopularityStorage(this.storage, this.bucket);

  DateTime get lastFetched => _lastFetched;
  String get dateRange => _dateRange;
  int get count => _values.length;

  double lookup(String package) => _values[package];

  Future init() async {
    await fetch('init');
    _timer = new Timer.periodic(const Duration(hours: 4), (_) {
      fetch('refetch');
    });
  }

  Future close() async {
    _timer?.cancel();
    _timer = null;
  }

  Future fetch(String reason) async {
    _logger.info(
        'Loading popularity data ($reason): ${bucketUri(bucket, _latestPath)}');
    try {
      final Map<String, dynamic> latest = await bucket
          .read(_latestPath)
          .transform(_gzip.decoder)
          .transform(utf8.decoder)
          .transform(json.decoder)
          .single;
      _updateLatest(latest);
      _lastFetched = new DateTime.now().toUtc();
    } catch (e, st) {
      _logger.severe(
          'Unable to load popularity data: ${bucketUri(bucket, _latestPath)}',
          e,
          st);
    }
  }

  void _updateLatest(Map<String, dynamic> raw) {
    final popularity = new PackagePopularity.fromJson(raw);
    final List<_Entry> entries = <_Entry>[];
    popularity.items.forEach((package, totals) {
      entries.add(new _Entry(package, totals.score, totals.total));
    });
    entries.sort();
    for (int i = 0; i < entries.length; i++) {
      _values[entries[i].package] = i / entries.length;
    }
    _dateRange = '${popularity.dateFirst?.toIso8601String()} - '
        '${popularity.dateLast?.toIso8601String()}';
    _logger.info('Popularity updated for ${popularity.items.length} packages.');
  }
}

class _Entry implements Comparable<_Entry> {
  final String package;
  final int score;
  final int total;

  _Entry(this.package, this.score, this.total);

  @override
  int compareTo(_Entry other) {
    final int x = score.compareTo(other.score);
    return x != 0 ? x : total.compareTo(other.total);
  }
}
