// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';

import '../../account/models.dart';
import '../../shared/datastore.dart';
import '../../shared/utils.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  await _backfillUserFields();
}

Future<void> _backfillUserFields() async {
  _logger.info('Backfill User fields.');
  await for (final user in dbService.query<User>().run()) {
    if (!user.isDeleted && user.externalSearchUserId == null) {
      await _backfillExternalUserId(user.key);
    }
  }
}

Future<void> _backfillExternalUserId(Key<String> key) async {
  await withRetryTransaction(dbService, (tx) async {
    final user = await tx.lookupValue<User>(key);
    if (user.externalSearchUserId != null) return;
    user.externalSearchUserId = createUuid();
    tx.insert(user);
  });
}
