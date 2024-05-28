// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Backfilling Package automated publishing fields.');
  await for (final package in dbService.query<Package>().run()) {
    if (package.automatedPublishing == null) continue;

    await withRetryTransaction(dbService, (tx) async {
      final p = await tx.lookupValue<Package>(package.key);
      tx.insert(p);
    });
  }
}
