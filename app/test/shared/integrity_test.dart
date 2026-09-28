// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/integrity.dart';
import 'package:pub_dev/shared/utils.dart' show createUuid;
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import 'test_models.dart';
import 'test_services.dart';

void main() {
  // The post-test verification runs each part of the Datastore integrity check
  // with its own checker. These tests make sure that the `packages` part loads
  // the users and publishers that its checks depend on.
  group('Datastore integrity check parts', () {
    final testProfile = defaultTestProfile.changeDefaultUser(userAtPubDevEmail);

    /// Removes `user@pub.dev`, who is the uploader of `oxygen` and the only
    /// member of `example.com` (the publisher of `neon`) in [testProfile].
    Future<String> removeUser() async {
      final user = await accountBackend.lookupUserByEmail(userAtPubDevEmail);
      await createPubApiClient(
        authToken: siteAdminToken,
      ).adminRemoveUser(user.userId);
      return user.userId;
    }

    testWithProfile(
      'packages part reports a package of an abandoned publisher',
      testProfile: testProfile,
      fn: () async {
        await removeUser();
        final neon = await packageBackend.lookupPackage('neon');
        await dbService.commit(inserts: [neon!..isDiscontinued = false]);
      },
      integrityProblem:
          'Package "neon" has an abandoned publisher, must be marked discontinued.',
    );

    testWithProfile(
      'packages part reports a deleted uploader',
      testProfile: testProfile,
      fn: () async {
        final userId = await removeUser();
        final oxygen = await packageBackend.lookupPackage('oxygen');
        await dbService.commit(
          inserts: [
            oxygen!..uploaders = [userId],
          ],
        );
      },
      integrityProblem: RegExp('^Package "oxygen" references a deleted User '),
    );

    testWithProfile(
      'packages part reports missing PackageVersionInfo and PackageVersionAsset mismatches',
      testProfile: testProfile,
      fn: () async {
        final info = await packageBackend.lookupPackageVersionInfo(
          'oxygen',
          '1.0.0',
        );
        final readmeAsset = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.0.0',
          AssetKind.readme,
        );

        // 1. Delete PackageVersionAsset while still referenced in PackageVersionInfo.
        await dbService.commit(deletes: [readmeAsset!.key]);
        expect(
          await findAllIntegrityProblems().toList(),
          contains(
            'PackageVersionAsset "oxygen/1.0.0/readme" is referenced from '
            'PackageVersionInfo but does not exist.',
          ),
        );

        // 2. Restore asset, remove it from PackageVersionInfo.assets.
        info!.assets.remove(AssetKind.readme);
        await dbService.commit(inserts: [readmeAsset, info]);
        expect(
          await findAllIntegrityProblems().toList(),
          contains(
            'PackageVersionAsset "oxygen/1.0.0/readme" is not referenced from '
            'PackageVersionInfo.',
          ),
        );

        // 3. Delete PackageVersionInfo and its assets, leaving PackageVersion without info.
        final allAssets =
            await (dbService.query<PackageVersionAsset>()
                  ..filter('packageVersion =', 'oxygen/1.0.0'))
                .run()
                .toList();
        await dbService.commit(
          deletes: [info.key, ...allAssets.map((a) => a.key)],
        );
        expect(
          await findAllIntegrityProblems().toList(),
          contains('PackageVersion "oxygen/1.0.0" has no PackageVersionInfo.'),
        );

        // Restore original entities for post-test verification.
        info.assets.add(AssetKind.readme);
        await dbService.commit(inserts: [info, ...allAssets]);
      },
    );

    testWithProfile(
      'packages part reports versionCount and missing latestVersionKey',
      testProfile: testProfile,
      fn: () async {
        final oxygen = (await packageBackend.lookupPackage('oxygen'))!;
        final originalVersionCount = oxygen.versionCount;
        final originalLatestVersionKey = oxygen.latestVersionKey;

        oxygen
          ..versionCount = 99
          ..latestVersionKey = oxygen.key.append(PackageVersion, id: '9.9.9');
        await dbService.commit(inserts: [oxygen]);

        final problems = await findAllIntegrityProblems().toList();
        expect(
          problems,
          containsAll([
            'Package "oxygen" has `versionCount` (99) that differs from the '
                'number of versions until the last published date '
                '($originalVersionCount). Total number of versions: '
                '$originalVersionCount.',
            'Package "oxygen" has missing `latestVersionKey`: "9.9.9".',
          ]),
        );

        oxygen
          ..versionCount = originalVersionCount
          ..latestVersionKey = originalLatestVersionKey;
        await dbService.commit(inserts: [oxygen]);
      },
    );

    testWithProfile(
      'auditLogs part reports missing SQL mirror and missing Datastore entity',
      testProfile: testProfile,
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(userAtPubDevEmail);
        final oldCreated = clock.now().toUtc().subtract(
          const Duration(days: 5),
        );
        final expires = oldCreated.add(const Duration(days: 30));

        AuditLogRecord makeRecord() => AuditLogRecord()
          ..id = createUuid()
          ..created = oldCreated
          ..expires = expires
          ..kind = AuditLogRecordKind.packageOptionsUpdated
          ..agent = user.userId
          ..summary = 'test record'
          ..data = {
            'packages': ['oxygen'],
          }
          ..users = [user.userId]
          ..packages = ['oxygen']
          ..packageVersions = <String>[]
          ..publishers = <String>[];

        final datastoreOnly = makeRecord();
        final sqlOnly = makeRecord();
        await dbService.commit(inserts: [datastoreOnly]);
        await auditBackend.mirrorToSql(sqlOnly);

        final problems = await findAllIntegrityProblems().toList();
        expect(
          problems,
          containsAll([
            'AuditLogRecord "${datastoreOnly.id}" has no corresponding SQL mirror.',
            'SQL AuditLogRecord "${sqlOnly.id}" has no corresponding Datastore entity.',
          ]),
        );

        // Clean up so post-test verification starts from a valid state.
        await dbService.commit(deletes: [datastoreOnly.key]);
        await primaryDatabase.withRetry(
          (db) => db.auditLogRecords
              .where((r) => r.id.equalsValue(sqlOnly.id!))
              .delete()
              .execute(),
        );
      },
    );
  });
}
