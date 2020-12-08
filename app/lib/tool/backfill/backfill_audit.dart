// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../../account/backend.dart';
import '../../audit/models.dart';
import '../../package/models.dart';
import '../../shared/datastore.dart';

final _logger = Logger('backfill_audit');

/// Backfills [AuditLogRecord] entities for events that predate our code
/// creating these entities:
/// - [AuditLogRecordKind.packagePublished]
Future<int> backfillAuditAll(int concurrency, bool dryRun) async {
  final pool = Pool(concurrency);
  final futures = <Future<int>>[];
  await for (final p in dbService.query<Package>().run()) {
    futures.add(pool.withResource(() => backfillAudit(p.name, dryRun)));
  }
  final count = (await Future.wait(futures)).fold<int>(0, (a, b) => a + b);
  await pool.close();
  return count;
}

/// Backfills [AuditLogRecord] entities for events that predate our code
/// creating these entities:
/// - [AuditLogRecordKind.packagePublished]
Future<int> backfillAudit(String package, bool dryRun) async {
  _logger.info('Checking audit records in: $package');
  final recordQuery = dbService.query<AuditLogRecord>()
    ..filter('packages =', package);
  final records = await recordQuery.run().toList();

  final packageKey = dbService.emptyKey.append(Package, id: package);
  final query = dbService.query<PackageVersion>(ancestorKey: packageKey);
  int count = 0;
  await for (final pv in query.run()) {
    final hasUploaded = records.any((r) =>
        r.kind == AuditLogRecordKind.packagePublished &&
        r.packageVersions.contains(pv.qualifiedVersionKey.qualifiedVersion));
    if (!hasUploaded) {
      _logger.info('Backfill audit for ${pv.qualifiedVersionKey}.');
      count++;
      if (dryRun) continue;

      final uploader = await accountBackend.lookupUserById(pv.uploader);
      await dbService.commit(
        inserts: [
          AuditLogRecord.packagePublished(
            uploader: uploader,
            package: pv.package,
            version: pv.version,
            created: pv.created,
          ),
        ],
      );
    }
  }
  return count;
}
