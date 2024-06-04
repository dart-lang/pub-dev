// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/shared/datastore.dart';

/// Sets the download counts backend service.
void registerDownloadCountsBackend(DownloadCountsBackend backend) =>
    ss.register(#_downloadCountsBackend, backend);

/// The active download counts backend service.
DownloadCountsBackend get downloadCountsBackend =>
    ss.lookup(#_downloadCountsBackend) as DownloadCountsBackend;

class DownloadCountsBackend {
  final DatastoreDB _db;

  DownloadCountsBackend(this._db);

  Future<DownloadCounts?> lookupDownloadCounts(String pkg) async {
    final key = _db.emptyKey.append(DownloadCounts, id: pkg);
    return _db.lookupOrNull<DownloadCounts>(key);
  }

  Future<DownloadCounts> ingestDownloadCounts(String pkg, CountData cd) async {
    return await withRetryTransaction(_db, (tx) async {
      final downloadCounts = DownloadCounts()
        ..id = pkg
        ..countData = cd;

      tx.queueMutations(
        inserts: [downloadCounts],
      );

      return downloadCounts;
    });
  }
}

Future<void> updateDownloadCounts(
  String pkg,
  Map<String, int> dayCounts,
  DateTime dateTime,
) async {
  final downloadCounts = await downloadCountsBackend.lookupDownloadCounts(pkg);
  final countData = downloadCounts?.countData ?? CountData.empty();
  countData.addDownloadCounts(dayCounts, dateTime);
  await downloadCountsBackend.ingestDownloadCounts(pkg, countData);
}
