// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/task/models.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfilling PackageState...');
  final query = dbService.query<PackageState>();
  await for (final s in query.run()) {
    if (s.updated != null) continue;
    await withRetryTransaction(dbService, (tx) async {
      final state = await tx.lookupOrNull<PackageState>(s.key);
      if (state != null) {
        state.updated = clock.now().toUtc();
        tx.insert(state);
      }
    });
  }
}
