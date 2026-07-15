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
  _logger.info('Cleanup the Package.publishingConfig migration.');
  await for (final p in dbService.query<Package>().run()) {
    if (p.automatedPublishing != null) {
      // Note: the following code must not happen, but just in case, we abort the cleanup.
      if (p.publishingConfig == null) {
        _logger.shout(
          'Package "${p.name}" has `automatedPublishing` but no `publishingConfig`.',
        );
        return;
      }
      await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(p.key);
        pkg.automatedPublishing = null;
        tx.insert(pkg);
      });
    }
  }
}
