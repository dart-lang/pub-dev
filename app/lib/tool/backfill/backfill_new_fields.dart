// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';

import '../../package/models.dart';
import '../../shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfill package with withheld fields...');
  await for (final pkg in dbService.query<Package>().run()) {
    if (pkg.isWithheld) {
      if (pkg.withheld != null && pkg.withheldExpires != null) {
        continue;
      }
      await withRetryTransaction(dbService, (tx) async {
        final now = clock.now().toUtc();
        final p = await tx.lookupValue<Package>(pkg.key);
        p.withheld ??= now;
        p.withheldExpires ??= p.withheld!.add(Duration(days: 60));
        p.updated = now;
        tx.insert(p);
      });
    }
  }
}
