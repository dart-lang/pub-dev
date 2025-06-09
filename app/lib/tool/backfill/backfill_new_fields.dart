// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/secret/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Deleting Secret entries');
  await dbService.deleteWithQuery(dbService.query<Secret>());

  _logger.info('Backfill admin deleted fields...');
  await for (final e in dbService.query<Package>().run()) {
    if (e.isAdminDeleted == null) {
      await withRetryTransaction(dbService, (tx) async {
        final p = await tx.lookupOrNull<Package>(e.key);
        if (p == null) {
          return;
        }
        p.isAdminDeleted ??= false;
        tx.insert(p);
      });
    }
  }

  await for (final e in dbService.query<PackageVersion>().run()) {
    if (e.isAdminDeleted == null) {
      await withRetryTransaction(dbService, (tx) async {
        final p = await tx.lookupOrNull<PackageVersion>(e.key);
        if (p == null) {
          return;
        }
        p.isAdminDeleted ??= false;
        tx.insert(p);
      });
    }
  }
}
