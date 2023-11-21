// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_popularity/popularity.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../shared/cached_value.dart';
import '../shared/storage.dart';

final Logger _logger = Logger('pub.popularity');
final GZipCodec _gzip = GZipCodec();

/// Sets the popularity storage
void registerPopularityStorage(PopularityStorage storage) =>
    ss.register(#_popularityStorage, storage);

/// The active popularity storage
PopularityStorage get popularityStorage =>
    ss.lookup(#_popularityStorage) as PopularityStorage;

class PopularityStorage {
  late CachedValue<_PopularityData> _popularity;
  late final _PopularityLoader _loader;
  bool? _invalid;

  PopularityStorage(Bucket bucket) {
    _loader = _PopularityLoader(bucket);
    _popularity = CachedValue<_PopularityData>(
      name: 'popularity',
      interval: Duration(hours: 1),
      maxAge: Duration(days: 14),
      updateFn: () async => _loader.fetch(),
    );
  }

  bool get isInvalid =>
      _invalid ??
      (!_popularity.isAvailable || (_popularity.value?.isInvalid ?? true));

  DateTime? get lastFetched => _popularity.lastUpdated;
  String? get dateRange => _popularity.value?.dateRange;
  int get count => _popularity.value?.values.length ?? 0;

  double lookup(String package) =>
      _popularity.isAvailable ? _popularity.value!.values[package] ?? 0.0 : 0.0;

  int lookupAsScore(String package) => (lookup(package) * 100).round();

  Future<void> start() async {
    await _popularity.update();
  }

  Future<void> close() async {
    await _popularity.close();
  }

  // Updates popularity scores to fixed values, useful for testing.
  @visibleForTesting
  void updateValues(
    Map<String, double> values, {
    bool? invalid,
  }) {
    if (invalid != null) {
      _invalid = invalid;
    }
    // ignore: invalid_use_of_visible_for_testing_member
    _popularity.setValue(
        _PopularityData(values: values, first: clock.now(), last: clock.now()));
  }
}

class _PopularityLoader {
  final Bucket bucket;
  ObjectInfo? _lastObjectInfo;
  _PopularityData? _lastFetchedData;

  _PopularityLoader(this.bucket);

  Future<_PopularityData> fetch() async {
    final objectName = PackagePopularity.popularityFileName;
    _logger.info(
        'Checking popularity data info: ${bucketUri(bucket, objectName)}');
    final info = await bucket.info(objectName);
    if (_lastFetchedData != null &&
        _lastObjectInfo != null &&
        _lastObjectInfo!.hasSameSignatureAs(info)) {
      // Object didn't change since last fetch, returning the cached version.
      return _lastFetchedData!;
    }
    _logger.info('Loading popularity data: ${bucketUri(bucket, objectName)}');
    final latest = (await bucket
        .read(objectName)
        .transform(_gzip.decoder)
        .transform(utf8.decoder)
        .transform(json.decoder)
        .single) as Map<String, dynamic>;
    final data = _processJson(latest);
    _logger.info('Popularity updated for ${data.values.length} packages.');
    _lastObjectInfo = info;
    _lastFetchedData = data;
    return data;
  }

  _PopularityData _processJson(Map<String, dynamic> raw) {
    final popularity = PackagePopularity.fromJson(raw);
    final List<_Entry> entries = <_Entry>[];
    popularity.items.forEach((package, totals) {
      entries.add(_Entry(package, totals.score, totals.total));
    });
    entries.sort();
    final values = <String, double>{};
    for (int i = 0; i < entries.length; i++) {
      values[entries[i].package] = i / entries.length;
    }
    return _PopularityData(
      values: values,
      first: popularity.dateFirst,
      last: popularity.dateLast,
    );
  }
}

class _PopularityData {
  final Map<String, double> values;
  final DateTime? first;
  final DateTime? last;

  _PopularityData({
    required this.values,
    required this.first,
    required this.last,
  });

  String get dateRange =>
      '${first?.toIso8601String()} - ${last?.toIso8601String()}';

  /// Indicates that the data has no time range, or that the range is not
  /// covering a full day, or that it is more than a month old.
  late final isInvalid = first == null ||
      last == null ||
      last!.difference(first!).inDays < 1 ||
      clock.now().difference(last!).inDays > 30;
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
