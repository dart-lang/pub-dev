// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/service/security_advisories/sync_security_advisories.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Resyncing all security advisories...');
  // This will backfill the `pub_display_url` in the `database_specific` field on the `SecurityAdvisory` entity.
  await syncSecurityAdvisories(resync: true);

  _logger.info('Backfilling isModerated fileds...');
  await for (final e in dbService.query<Package>().run()) {
    if (e.isModerated != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final o = await tx.lookupValue<Package>(e.key);
      o.isModerated = false;
      tx.insert(o);
    });
  }
  await for (final e in dbService.query<PackageVersion>().run()) {
    if (e.isModerated != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final o = await tx.lookupValue<PackageVersion>(e.key);
      o.isModerated = false;
      tx.insert(o);
    });
  }
  await for (final e in dbService.query<User>().run()) {
    if (e.isModerated != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final o = await tx.lookupValue<User>(e.key);
      o.isModerated = false;
      tx.insert(o);
    });
  }
  await for (final e in dbService.query<Publisher>().run()) {
    if (e.isModerated != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final o = await tx.lookupValue<Publisher>(e.key);
      o.isModerated = false;
      tx.insert(o);
    });
  }
  _logger.info('Backfill completed.');
}
