// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/consent_backend.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/neat_task/datastore_status_provider.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  // NOTE: Keep this around until Consent is migrated to use SQL.
  _logger.info('Backfilling consents...');
  await consentBackend.backfillSqlFromDatastore();

  // NOTE: Keep this around until User is migrated to use SQL.
  _logger.info('Backfilling users...');
  await accountBackend.backfillSqlFromDatastore();

  // NOTE: Keep this around until ReservedPackage is migrated to use SQL.
  _logger.info('Backfilling reserved packages...');
  await packageBackend.backfillReservedPackagesSqlFromDatastore();

  // NOTE: Keep this around until ModeratedPackage is migrated to use SQL.
  _logger.info('Backfilling moderated packages...');
  await packageBackend.backfillPackageTombstonesSqlFromDatastore();

  // NOTE: Keep this around until SecurityAdvisory is migrated to use SQL.
  _logger.info('Backfilling security advisories...');
  await securityAdvisoryBackend.backfillSqlFromDatastore();

  // NOTE: Keep this around until PackageVersionAsset is migrated to use SQL.
  _logger.info('Backfilling package version assets...');
  await packageBackend.backfillPackageVersionAssetsSqlFromDatastore();

  // NOTE: Keep this around until Package and PackageVersion are migrated to use SQL.
  _logger.info('Backfilling packages and package versions...');
  await packageBackend.backfillPackagesSqlFromDatastore();

  // NOTE: Keep this around until Publisher and PublisherMember are migrated to use SQL.
  _logger.info('Backfilling publishers and publisher members...');
  await publisherBackend.backfillPublishersSqlFromDatastore();

  // NOTE: Keep this around until Like is migrated to SQL.
  _logger.info('Backfilling package likes...');
  await likeBackend.backfillSqlFromDatastore();

  // NOTE: Keep this around until ModerationCase is migrated to SQL.
  _logger.info('Backfilling moderation cases...');
  await adminBackend.backfillModerationCasesSqlFromDatastore();

  // TODO: Remove Datastore entity in a future release.
  _logger.info('Deleting DownloadCounts from Datastore...');
  await dbService.deleteWithQuery<DownloadCounts>(
    dbService.query<DownloadCounts>(),
  );

  // TODO: Remove Datastore entity in a future release.
  _logger.info('Deleting NeatTaskStatus from Datastore...');
  await dbService.deleteWithQuery<NeatTaskStatus>(
    dbService.query<NeatTaskStatus>(),
  );
}
