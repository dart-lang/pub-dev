// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';

/// Sets the download counts backend service.
void registerDownloadCountsBackend(DownloadCountsBackend backend) =>
    ss.register(#_downloadCountsBackend, backend);

/// The active download counts backend service.
DownloadCountsBackend get downloadCountsBackend =>
    ss.lookup(#_downloadCountsBackend) as DownloadCountsBackend;

class DownloadCountsBackend {
  final DatastoreDB _db;

  DownloadCountsBackend(this._db);

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
