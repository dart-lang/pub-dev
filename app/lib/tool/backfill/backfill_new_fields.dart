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
  await _removeKnownUnmappedFields();
}

Future<void> _removeKnownUnmappedFields() async {
  _logger.info('Removing unmapped fields...');
  await for (final p in dbService.query<Package>().run()) {
    if (p.additionalProperties.isEmpty) continue;
    if (p.additionalProperties.containsKey('automatedPublishingJson') ||
        p.additionalProperties.containsKey('blocked') ||
        p.additionalProperties.containsKey('blockedReason')) {
      await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(p.key);
        pkg.additionalProperties.remove('automatedPublishingJson');
        pkg.additionalProperties.remove('blocked');
        pkg.additionalProperties.remove('blockedReason');
        tx.insert(pkg);
      });
    }
  }
  _logger.info('Removing unmapped fields completed.');
}
