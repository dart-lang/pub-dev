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
  var _lastData = (data: <String, int>{}, etag: '');

  DownloadCountsBackend(this._db) {
    _thirtyDaysTotals = CachedValue(
        name: 'thirtyDaysTotalDownloadCounts',
        maxAge: Duration(days: 14),
        interval: Duration(minutes: 30),
        updateFn: _updateThirtyDaysTotals);
  }

  Future<Map<String, int>> _updateThirtyDaysTotals() async {
    try {
      final info = await storageService
          .bucket(activeConfiguration.reportsBucketName!)
          .infoWithRetry(downloadCounts30DaysTotalsFileName);

      if (_lastData.etag == info.etag) {
        return _lastData.data;
      }
      final data = (await storageService
              .bucket(activeConfiguration.reportsBucketName!)
              .read(downloadCounts30DaysTotalsFileName)
              .transform(utf8.decoder)
              .transform(json.decoder)
              .single as Map<String, dynamic>)
          .cast<String, int>();
      _lastData = (data: data, etag: info.etag);
      return data;
    } on FormatException catch (e, st) {
      logger.severe('Error loading 30-days total download counts:', e, st);
      rethrow;
    } on DetailedApiRequestError catch (e, st) {
      if (e.status != 404) {
        logger.severe(
            'Failed to load $downloadCounts30DaysTotalsFileName, error : ',
            e,
            st);
      }
      rethrow;
    }
  }

  Future<void> start() async {
    await _thirtyDaysTotals.update();
  }

  Future<void> close() async {
    await _thirtyDaysTotals.close();
  }

  int? lookup30DaysTotalCounts(String package) =>
      _thirtyDaysTotals.isAvailable ? _thirtyDaysTotals.value![package] : null;

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

      tx.queueMutations(
        inserts: [newDownloadCounts],
      );
      return newDownloadCounts;
    });
    await cache.downloadCounts(pkg).purge();
    return downloadCounts;
  }
}
