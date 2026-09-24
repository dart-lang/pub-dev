// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/service/email/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/task/global_lock_models.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  _logger.info('Delete old GlobalLockState entities in Datastore');
  await dbService.deleteWithQuery(dbService.query<GlobalLockState>());

  // NOTE: Keep these around until all of the audit log record is migrated to use SQL.
  _logger.info('Backfilling audit log records...');
  await auditBackend.backfillSqlFromDatastore();
  await auditBackend.backfillDatastoreFromSql();

  // NOTE: Keep this around until Consent is migrated to use SQL.
  _logger.info('Backfilling consents...');
  await consentBackend.backfillSqlFromDatastore();

  // NOTE: Keep this around until OutgoingEmail is migrated to use SQL.
  _logger.info('Backfilling outgoing emails...');
  await emailBackend.backfillSqlFromDatastore();
}
