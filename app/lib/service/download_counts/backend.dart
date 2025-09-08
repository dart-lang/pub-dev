// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/service/entrypoint/analyzer.dart';
import 'package:pub_dev/shared/cached_value.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/storage.dart';

/// Sets the download counts backend service.
void registerDownloadCountsBackend(DownloadCountsBackend backend) =>
    ss.register(#_downloadCountsBackend, backend);

/// The active download counts backend service.
DownloadCountsBackend get downloadCountsBackend =>
    ss.lookup(#_downloadCountsBackend) as DownloadCountsBackend;

class DownloadCountsBackend {
  final DatastoreDB _db;

  late CachedValue<Map<String, int>> _thirtyDaysTotals;
  var _lastDownloadsData = (data: <String, int>{}, etag: '');

  late CachedValue<Map<String, double>> _trendScores;
  var _lastTrendData = (data: <String, double>{}, etag: '');

  DownloadCountsBackend(this._db) {
    _thirtyDaysTotals = CachedValue<Map<String, int>>(
      name: 'thirtyDaysTotalDownloadCounts',
      maxAge: Duration(days: 14),
      interval: Duration(minutes: 30),
      updateFn: _updateThirtyDaysTotals,
    );
    _trendScores = CachedValue<Map<String, double>>(
      name: 'trendScores',
      maxAge: Duration(days: 14),
      interval: Duration(minutes: 30),
      updateFn: _updateTrendScores,
    );
  }

  Future<Map<String, int>> _updateThirtyDaysTotals() async {
    return _fetchAndUpdateCachedData<int>(
      fileName: downloadCounts30DaysTotalsFileName,
      currentCachedData: _lastDownloadsData,
      updateCache: (data) => _lastDownloadsData = data,
      errorContext: '30-days total download counts',
    );
  }

  Future<Map<String, double>> _updateTrendScores() async {
    return _fetchAndUpdateCachedData<double>(
      fileName: trendScoreFileName,
      currentCachedData: _lastTrendData,
      updateCache: (data) => _lastTrendData = data,
      errorContext: 'trend scores',
    );
  }

  Future<Map<String, V>> _fetchAndUpdateCachedData<V>({
    required String fileName,
    required ({Map<String, V> data, String etag}) currentCachedData,
    required void Function(({Map<String, V> data, String etag}) newData)
    updateCache,
    required String errorContext,
  }) async {
    try {
      final info = await storageService
          .bucket(activeConfiguration.reportsBucketName!)
          .infoWithRetry(fileName);

      if (currentCachedData.etag == info.etag) {
        return currentCachedData.data;
      }

      final rawData = await storageService
          .bucket(activeConfiguration.reportsBucketName!)
          .readWithRetry(
            fileName,
            (input) async => await input
                .transform(utf8.decoder)
                .transform(json.decoder)
                .single,
          );

      final data = _parseJsonToMapStringV<V>(rawData, fileName);

      final newData = (data: data, etag: info.etag);
      updateCache(newData);
      return data;
    } on FormatException catch (e, st) {
      logger.severe('Error parsing $errorContext: $e', e, st);
      rethrow;
    } on DetailedApiRequestError catch (e, st) {
      if (e.status != 404) {
        logger.severe(
          'Failed to load $fileName ($errorContext), error : $e',
          e,
          st,
        );
      }
      rethrow;
    } on TypeError catch (e, st) {
      logger.severe('Type error during processing $errorContext: $e', e, st);
      rethrow;
    }
  }

  Map<String, V> _parseJsonToMapStringV<V>(dynamic rawJson, String fileName) {
    if (rawJson is! Map) {
      throw FormatException(
        'Expected JSON for $fileName to be a Map, but got'
        ' ${rawJson.runtimeType}',
      );
    }

    final Map<String, V> result = {};
    for (final entry in rawJson.entries) {
      if (entry.key is! String) {
        throw FormatException(
          'Expected map keys for $fileName to be String, but found'
          ' ${entry.key.runtimeType}',
        );
      }
      if (entry.value is! V) {
        throw FormatException(
          'Expected map value for key "${entry.key}" in $fileName to be'
          ' ${V.runtimeType}, but got ${entry.value.runtimeType}',
        );
      }
      result[entry.key as String] = entry.value as V;
    }
    return result;
  }

  Future<void> start() async {
    await _thirtyDaysTotals.update();
    await _trendScores.update();
  }

  Future<void> close() async {
    await _thirtyDaysTotals.close();
    await _trendScores.close();
  }

  int? lookup30DaysTotalCounts(String package) =>
      _thirtyDaysTotals.isAvailable ? _thirtyDaysTotals.value![package] : null;

  double? lookupTrendScore(String package) =>
      _trendScores.isAvailable ? _trendScores.value![package] : null;

  Future<CountData?> lookupDownloadCountData(String pkg) async {
    return (await cache.downloadCounts(pkg).get(() async {
      final key = _db.emptyKey.append(DownloadCounts, id: pkg);
      final downloadCounts = await _db.lookupOrNull<DownloadCounts>(key);
      return downloadCounts?.countData;
    }));
  }

  Future<Stream<DownloadCounts>> listAllDownloadCounts() async {
    final query = _db.query<DownloadCounts>();
    return query.run();
  }

  Future<DownloadCounts> updateDownloadCounts(
    String pkg,
    Map<String, int> dayCounts,
    DateTime dateTime,
  ) async {
    final downloadCounts = await withRetryTransaction(_db, (tx) async {
      final key = _db.emptyKey.append(DownloadCounts, id: pkg);
      final oldDownloadCounts = await tx.lookupOrNull<DownloadCounts>(key);
      final countData = oldDownloadCounts?.countData ?? CountData.empty();

      countData.addDownloadCounts(dayCounts, dateTime);

      final newDownloadCounts = DownloadCounts()
        ..id = pkg
        ..countData = countData;

      tx.queueMutations(inserts: [newDownloadCounts]);
      return newDownloadCounts;
    });
    await cache.downloadCounts(pkg).purge();
    return downloadCounts;
  }
}
