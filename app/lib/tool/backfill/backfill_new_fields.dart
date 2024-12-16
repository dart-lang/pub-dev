// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/api_export/api_exporter.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/datastore.dart';

final _logger = Logger('backfill_new_fields');

/// Backfills new fields that are introduced in a release.
///
/// Fields should be added here as they are added to the models.
/// CHANGELOG.md must be updated with the new fields, and the next
/// release could remove the backfill from here.
Future<void> backfillNewFields() async {
  await migrateIsBlocked();
  await _removeKnownUnmappedFields();
}

/// Migrates entities from the `isBlocked` fields to the new `isModerated` instead.
@visibleForTesting
Future<void> migrateIsBlocked() async {
  _logger.info('Migrating isBlocked...');
  final pkgQuery = dbService.query<Package>()..filter('isBlocked =', true);
  await for (final entity in pkgQuery.run()) {
    await withRetryTransaction(dbService, (tx) async {
      final pkg = await tx.lookupValue<Package>(entity.key);
      // sanity check
      if (!pkg.isBlocked) {
        return;
      }
      pkg
        ..isModerated = true
        ..moderatedAt = pkg.moderatedAt ?? pkg.blocked ?? clock.now()
        ..isBlocked = false
        ..blocked = null
        ..blockedReason = null;
      tx.insert(pkg);
    });

    // sync exported API(s)
    await apiExporter?.synchronizePackage(entity.name!, forceDelete: true);

    // retract or re-populate public archive files
    await packageBackend.tarballStorage.updatePublicArchiveBucket(
      package: entity.name!,
      ageCheckThreshold: Duration.zero,
      deleteIfOlder: Duration.zero,
    );
  }

  final publisherQuery = dbService.query<Publisher>()
    ..filter('isBlocked =', true);
  await for (final entity in publisherQuery.run()) {
    await withRetryTransaction(dbService, (tx) async {
      final publisher = await tx.lookupValue<Publisher>(entity.key);
      // sanity check
      if (!publisher.isBlocked) {
        return;
      }
      publisher
        ..isModerated = true
        ..moderatedAt = publisher.moderatedAt ?? clock.now()
        ..isBlocked = false;
      tx.insert(publisher);
    });
  }

  final userQuery = dbService.query<User>()..filter('isBlocked =', true);
  await for (final entity in userQuery.run()) {
    await withRetryTransaction(dbService, (tx) async {
      final user = await tx.lookupValue<User>(entity.key);
      // sanity check
      if (!user.isBlocked) {
        return;
      }
      user
        ..isModerated = true
        ..moderatedAt = user.moderatedAt ?? clock.now()
        ..isBlocked = false;
      tx.insert(user);
    });
  }

  _logger.info('isBlocked migration completed.');
}

Future<void> _removeKnownUnmappedFields() async {
  await for (final p in dbService.query<Package>().run()) {
    if (p.additionalProperties.isEmpty) continue;
    if (p.additionalProperties.containsKey('isWithheld') ||
        p.additionalProperties.containsKey('withheldReason')) {
      await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(p.key);
        pkg.additionalProperties.remove('isWithheld');
        pkg.additionalProperties.remove('withheldReason');
        tx.insert(pkg);
      });
    }
  }
}
