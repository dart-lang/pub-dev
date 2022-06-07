// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
  _logger.info('Backfilling Packages...');
  await for (final p in dbService.query<Package>().run()) {
    await _backfillPackage(p);
  }
}

Future<void> _backfillPackage(Package package) async {
  if (package.isBlocked == package.isWithheld &&
      package.withheldReason == package.blockedReason) {
    return;
  }
  await withRetryTransaction(dbService, (tx) async {
    final p = await tx.lookupValue<Package>(package.key);
    p.updateIsBlocked(isBlocked: p.isWithheld, reason: p.withheldReason);
    tx.insert(p);
  });
}
