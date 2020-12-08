// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../../account/backend.dart';
import '../../history/backend.dart';
import '../../history/models.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

final _logger = Logger('backfill_history');

/// Backfills History entities for events that predate our code creating these
/// entities:
/// - [PackageUploaded]
Future<int> backfillHistoryAll(int concurrency, bool dryRun) async {
  final pool = Pool(concurrency);
  final futures = <Future<int>>[];
  await for (final p in dbService.query<Package>().run()) {
    futures.add(pool.withResource(() => backfillHistory(p.name, dryRun)));
  }
  final count = (await Future.wait(futures)).fold<int>(0, (a, b) => a + b);
  await pool.close();
  return count;
}

/// Backfills History entities for events that predate our code creating these
/// entities:
/// - [PackageUploaded]
Future<int> backfillHistory(String package, bool dryRun) async {
  _logger.info('Checking history in: $package');
  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  int count = 0;
  await for (PackageVersion pv in query.run()) {
    bool hasUploaded = false;
    await for (History history in historyBackend.getAll(
        packageName: package, packageVersion: pv.version)) {
      if (history.historyEvent is PackageUploaded) {
        hasUploaded = true;
      }
    }
    if (!hasUploaded) {
      _logger.info('Backfill upload history for ${pv.qualifiedVersionKey}.');
      count++;
      if (dryRun) continue;
      final uploaderEmail = await accountBackend.getEmailOfUserId(pv.uploader);
      await historyBackend.storeEvent(PackageUploaded(
        packageName: package,
        packageVersion: pv.version,
        uploaderId: pv.uploader,
        uploaderEmail: uploaderEmail,
        timestamp: pv.created,
      ));
    }
  }
  return count;
}
