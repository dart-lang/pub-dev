// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfill Package.retentionUntil...');
  final pkgQuery = dbService.query<Package>()..filter('isModerated =', true);
  await for (final e in pkgQuery.run()) {
    if (e.retentionUntil != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final pkg = await tx.lookupValue<Package>(e.key);
      if (!pkg.isModerated || pkg.retentionUntil != null) {
        return;
      }
      pkg.retentionUntil = pkg.moderatedAt!.add(defaultModeratedKeptUntil);
      tx.insert(pkg);
    });
  }

  _logger.info('Backfill PackageVersion.retentionUntil...');
  final versionQuery = dbService.query<PackageVersion>()
    ..filter('isModerated =', true);
  await for (final e in versionQuery.run()) {
    if (e.retentionUntil != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final pv = await tx.lookupValue<PackageVersion>(e.key);
      if (!pv.isModerated || pv.retentionUntil != null) {
        return;
      }
      pv.retentionUntil = pv.moderatedAt!.add(defaultModeratedKeptUntil);
      tx.insert(pv);
    });
  }

  _logger.info('Backfill Publisher.retentionUntil...');
  final publisherQuery = dbService.query<Publisher>()
    ..filter('isModerated =', true);
  await for (final e in publisherQuery.run()) {
    if (e.retentionUntil != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<Publisher>(e.key);
      if (!p.isModerated || p.retentionUntil != null) {
        return;
      }
      p.retentionUntil = p.moderatedAt!.add(defaultModeratedKeptUntil);
      tx.insert(p);
    });
  }

  _logger.info('Backfill User.retentionUntil...');
  final userQuery = dbService.query<User>()..filter('isModerated =', true);
  await for (final e in userQuery.run()) {
    if (e.retentionUntil != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<User>(e.key);
      if (!p.isModerated || p.retentionUntil != null) {
        return;
      }
      p.retentionUntil = p.moderatedAt!.add(defaultModeratedKeptUntil);
      tx.insert(p);
    });
  }

  _logger.info('Backfill completed.');
}
