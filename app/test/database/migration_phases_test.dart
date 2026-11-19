// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/admin/backend.dart';
import 'package:pub_dev/admin/models.dart';
import 'package:pub_dev/admin/tools/user_merger.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/migration_phases.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/service/security_advisories/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/remove_orphaned_likes.dart';
import 'package:pub_dev/tool/maintenance/update_package_likes.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_services.dart';

void main() {
  group('migration_phases gating', () {
    testWithProfile(
      'package_likes sql-primary gates like backfill, maintenance tasks, and likes_count overwrites',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        final now = clock.now().toUtc();

        // Seed a SQL-only like and bump SQL packages.likes_count above Datastore.
        await primaryDatabase.transactWithRetry((db) async {
          await db.packageLikes
              .insertValue(
                userId: user.userId,
                package: 'oxygen',
                createdAt: now,
              )
              .execute();
          await db.packages
              .where((p) => p.name.equalsValue('oxygen'))
              .update((p, set) => set(likesCount: toExpr(42)))
              .execute();
        });

        // Also seed a Datastore-only orphaned like to verify removeOrphanedLikes skips.
        final orphanedLikeKey = dbService.emptyKey
            .append(User, id: 'missing-user')
            .append(Like, id: 'oxygen');
        await dbService.commit(
          inserts: [
            Like()
              ..parentKey = orphanedLikeKey.parent
              ..id = 'oxygen'
              ..packageName = 'oxygen'
              ..created = now.subtract(Duration(days: 5)),
          ],
        );

        await setMigrationPhase(
          MigrationEntity.packageLikes,
          MigrationPhase.sqlPrimary,
        );

        // Like backfill must neither delete SQL-only rows nor backfill Datastore ones.
        expect(await likeBackend.backfillSqlFromDatastore(), 0);
        final sqlLike = await primaryDatabase.withRetry(
          (db) => db.packageLikes.byKey(user.userId, 'oxygen').fetch(),
        );
        expect(sqlLike, isNotNull);

        // Package backfill ignores likes_count differences when package_likes is sql-primary.
        expect(await packageBackend.backfillPackagesSqlFromDatastore(), 0);
        final oxygenBefore = await primaryDatabase.withRetry(
          (db) => db.packages.byKey('oxygen').fetch(),
        );
        expect(oxygenBefore!.likesCount, 42);

        // Updating another Package field in Datastore still syncs via backfill and
        // mirrorPackageToSql without clobbering SQL likes_count.
        final dsPkg = (await packageBackend.lookupPackage('oxygen'))!;
        dsPkg.isUnlisted = true;
        dsPkg.updated = now.add(Duration(minutes: 1));
        await dbService.commit(inserts: [dsPkg]);

        expect(await packageBackend.backfillPackagesSqlFromDatastore(), 1);
        final oxygenAfterBackfill = await primaryDatabase.withRetry(
          (db) => db.packages.byKey('oxygen').fetch(),
        );
        expect(oxygenAfterBackfill!.isUnlisted, isTrue);
        expect(oxygenAfterBackfill.likesCount, 42);

        dsPkg.isUnlisted = false;
        dsPkg.updated = now.add(Duration(minutes: 2));
        await dbService.commit(inserts: [dsPkg]);
        await packageBackend.mirrorPackageToSql(dsPkg);
        final oxygenAfterMirror = await primaryDatabase.withRetry(
          (db) => db.packages.byKey('oxygen').fetch(),
        );
        expect(oxygenAfterMirror!.isUnlisted, isFalse);
        expect(oxygenAfterMirror.likesCount, 42);

        // Live like/unlike on N-1 while package_likes is sql-primary applies
        // atomic +/-1 deltas instead of overwriting SQL likes_count with
        // Datastore's stale Package.likes snapshot.
        final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
        // Liking a package that already has a SQL-only like (for `user`) does
        // not double-increment SQL likes_count.
        await likeBackend.likePackage(user.userId, 'oxygen');
        expect(
          (await primaryDatabase.withRetry(
            (db) => db.packages.byKey('oxygen').fetch(),
          ))!.likesCount,
          42,
        );
        // Liking with another user increments SQL likes_count from 42 -> 43.
        await likeBackend.likePackage(admin.userId, 'oxygen');
        expect(
          (await primaryDatabase.withRetry(
            (db) => db.packages.byKey('oxygen').fetch(),
          ))!.likesCount,
          43,
        );
        // Unliking decrements SQL likes_count from 43 -> 42.
        await likeBackend.unlikePackage(admin.userId, 'oxygen');
        expect(
          (await primaryDatabase.withRetry(
            (db) => db.packages.byKey('oxygen').fetch(),
          ))!.likesCount,
          42,
        );

        // Weekly Like maintenance tasks skip when package_likes is sql-primary.
        expect(await updatePackageLikes(), 0);
        final removed = await removeOrphanedLikes(
          minAgeThreshold: Duration.zero,
        );
        expect(removed.found, 0);
        expect(removed.deleted, 0);

        // Clean up the intentionally broken Datastore fixture for post-test
        // integrity verification.
        await dbService.commit(deletes: [orphanedLikeKey]);
      },
    );

    testWithProfile(
      'package_likes sql-primary preserves SQL likes_count delta during duplicate-like user merge',
      fn: () async {
        final admin = await accountBackend.lookupUserByEmail('admin@pub.dev');
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');

        // Both users like oxygen while still datastore-primary.
        await likeBackend.likePackage(admin.userId, 'oxygen');
        await likeBackend.likePackage(user.userId, 'oxygen');

        // Simulate SQL likes_count diverging ahead of Datastore, then cut over.
        await primaryDatabase.withRetry(
          (db) => db.packages
              .where((p) => p.name.equalsValue('oxygen'))
              .update((p, set) => set(likesCount: toExpr(42)))
              .execute(),
        );
        await setMigrationPhase(
          MigrationEntity.packageLikes,
          MigrationPhase.sqlPrimary,
        );

        final merger = UserMerger(
          db: dbService,
          concurrency: 2,
          omitEmailCheck: true,
        );
        await merger.mergeUser(admin.userId, user.userId);

        final oxygen = await primaryDatabase.withRetry(
          (db) => db.packages.byKey('oxygen').fetch(),
        );
        expect(oxygen!.likesCount, 41);
        expect(
          await primaryDatabase.withRetry(
            (db) => db.packageLikes.byKey(admin.userId, 'oxygen').fetch(),
          ),
          isNull,
        );
        expect(
          await primaryDatabase.withRetry(
            (db) => db.packageLikes.byKey(user.userId, 'oxygen').fetch(),
          ),
          isNotNull,
        );
      },
    );

    testWithProfile(
      'packages sql-primary prevents deleting SQL-only packages and versions',
      fn: () async {
        final now = clock.now().toUtc();
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');

        await primaryDatabase.transactWithRetry((db) async {
          await db.packages
              .insertValue(
                name: 'sql_only_pkg',
                createdAt: now,
                updatedAt: now,
                lastVersionPublishedAt: now,
                latestVersion: '1.0.0',
                versionsCount: 1,
                likesCount: 0,
                isDiscontinued: false,
                isUnlisted: false,
                isModerated: false,
                isAdminDeleted: false,
                assignedTagsJson: JsonValue(const <String>[]),
                deletedVersionsJson: JsonValue(const <String>[]),
              )
              .execute();
          await db.packageVersions
              .insertValue(
                package: 'sql_only_pkg',
                version: '1.0.0',
                createdAt: now,
                pubspecJson: JsonValue({
                  'name': 'sql_only_pkg',
                  'version': '1.0.0',
                }),
                librariesJson: JsonValue(const <String>[]),
                uploader: user.userId,
                isRetracted: false,
                isModerated: false,
                isAdminDeleted: false,
              )
              .execute();
          await db.packageVersions
              .insertValue(
                package: 'oxygen',
                version: '9.9.9-sql-only',
                createdAt: now,
                pubspecJson: JsonValue({
                  'name': 'oxygen',
                  'version': '9.9.9-sql-only',
                }),
                librariesJson: JsonValue(const <String>[]),
                uploader: user.userId,
                isRetracted: false,
                isModerated: false,
                isAdminDeleted: false,
              )
              .execute();
        });

        await setMigrationPhase(
          MigrationEntity.packages,
          MigrationPhase.sqlPrimary,
        );

        expect(await packageBackend.backfillPackagesSqlFromDatastore(), 0);
        final pkgRow = await primaryDatabase.withRetry(
          (db) => db.packages.byKey('sql_only_pkg').fetch(),
        );
        final versionRow = await primaryDatabase.withRetry(
          (db) => db.packageVersions.byKey('oxygen', '9.9.9-sql-only').fetch(),
        );
        expect(pkgRow, isNotNull);
        expect(versionRow, isNotNull);
      },
    );

    testWithProfile(
      'package_version_assets sql-primary prevents deleting SQL-only assets',
      fn: () async {
        final now = clock.now().toUtc();
        await primaryDatabase.withRetry(
          (db) => db.packageVersionAssets
              .insertValue(
                package: 'oxygen',
                version: '1.2.0',
                kind: 'sql_only_kind',
                path: 'SQL_ONLY.md',
                updatedAt: now,
                textContent: 'sql only',
              )
              .execute(),
        );

        await setMigrationPhase(
          MigrationEntity.packageVersionAssets,
          MigrationPhase.sqlPrimary,
        );

        expect(
          await packageBackend.backfillPackageVersionAssetsSqlFromDatastore(),
          0,
        );
        // lookupPackageVersionAsset calls mirrorPackageVersionAssetToSqlByKey;
        // it must not delete a SQL-only asset when sql-primary.
        final lookedUp = await packageBackend.lookupPackageVersionAsset(
          'oxygen',
          '1.2.0',
          'sql_only_kind',
        );
        expect(lookedUp, isNotNull);
        expect(lookedUp!.textContent, 'sql only');
      },
    );

    testWithProfile(
      'publishers sql-primary prevents backfill and lookupPublisher from deleting SQL-only publisher',
      fn: () async {
        final now = clock.now().toUtc();
        final user = await accountBackend.lookupUserByEmail('admin@pub.dev');

        await primaryDatabase.transactWithRetry((db) async {
          await db.publishers
              .insertValue(
                publisherId: 'sql-only.example.com',
                createdAt: now,
                updatedAt: now,
                isAbandoned: false,
                isModerated: false,
              )
              .execute();
          await db.publisherMembers
              .insertValue(
                publisherId: 'sql-only.example.com',
                userId: user.userId,
                createdAt: now,
                updatedAt: now,
                role: 'admin',
              )
              .execute();
        });

        await setMigrationPhase(
          MigrationEntity.publishers,
          MigrationPhase.sqlPrimary,
        );

        expect(await publisherBackend.backfillPublishersSqlFromDatastore(), 0);
        // lookupPublisher calls _mirrorAndFetch -> mirrorPublisherToSql; must not delete!
        final lookedUp = await publisherBackend.lookupPublisher(
          'sql-only.example.com',
        );
        expect(lookedUp, isNotNull);
        expect(lookedUp!.publisherId, 'sql-only.example.com');

        final members = await primaryDatabase.withRetry(
          (db) => db.publisherMembers
              .where((m) => m.publisherId.equalsValue('sql-only.example.com'))
              .fetch(),
        );
        expect(members, hasLength(1));
      },
    );

    testWithProfile(
      'moderation_cases sql-primary prevents deleting SQL-only moderation cases',
      fn: () async {
        final now = clock.now().toUtc();
        await primaryDatabase.withRetry(
          (db) => db.moderationCases
              .insertValue(
                caseId: 'sql-only-case',
                reporterEmail: 'reporter@example.com',
                openedAt: now,
                source: 'externalNotification',
                kind: 'notification',
                subject: 'package:oxygen',
                isSubjectOwner: false,
                status: 'pending',
              )
              .execute(),
        );

        // Also seed an old (>3 years) Datastore+SQL moderation case to verify
        // deleteModerationCases skips when moderation_cases is sql-primary.
        final oldOpened = now.subtract(Duration(days: 4 * 365));
        final oldCase = ModerationCase.init(
          caseId: 'old-ds-case',
          reporterEmail: 'reporter@example.com',
          source: ModerationSource.externalNotification,
          kind: ModerationKind.notification,
          status: ModerationStatus.pending,
          subject: 'package:oxygen',
          url: null,
          isSubjectOwner: false,
          appealedCaseId: null,
        )..opened = oldOpened;
        await dbService.commit(inserts: [oldCase]);
        await adminBackend.mirrorModerationCaseToSql(oldCase);

        await setMigrationPhase(
          MigrationEntity.moderationCases,
          MigrationPhase.sqlPrimary,
        );

        expect(await adminBackend.backfillModerationCasesSqlFromDatastore(), 0);
        // lookupModerationCaseRow calls mirrorModerationCaseToSqlById;
        // it must not delete a SQL-only case when sql-primary.
        final row = await adminBackend.lookupModerationCaseRow('sql-only-case');
        expect(row, isNotNull);
        expect(row!.caseId, 'sql-only-case');

        await adminBackend.deleteModerationCases();
        expect(
          await adminBackend.lookupModerationCase('old-ds-case'),
          isNotNull,
        );
        expect(
          await primaryDatabase.withRetry(
            (db) => db.moderationCases.byKey('old-ds-case').fetch(),
          ),
          isNotNull,
        );
      },
    );

    testWithProfile(
      'users and security_advisories sql-primary skip Datastore backfills',
      fn: () async {
        final now = clock.now().toUtc();
        final dsOnlyUser = User()
          ..id = 'ds-only-user'
          ..oauthUserId = 'ds-only-oauth'
          ..email = 'ds-only@example.com'
          ..created = now;
        final dsOnlyAdvisory = SecurityAdvisory()
          ..id = 'GHSA-sql-primary-test'
          ..osv = OSV(
            schemaVersion: '1.6.0',
            id: 'GHSA-sql-primary-test',
            modified: now.toIso8601String(),
          )
          ..modified = now
          ..published = now
          ..syncTime = now
          ..affectedPackages = ['oxygen']
          ..aliases = const ['GHSA-sql-primary-test'];
        await dbService.commit(inserts: [dsOnlyUser, dsOnlyAdvisory]);

        await setMigrationPhase(
          MigrationEntity.users,
          MigrationPhase.sqlPrimary,
        );
        await setMigrationPhase(
          MigrationEntity.securityAdvisories,
          MigrationPhase.sqlPrimary,
        );

        expect(await accountBackend.backfillSqlFromDatastore(), 0);
        expect(await securityAdvisoryBackend.backfillSqlFromDatastore(), 0);

        final sqlUser = await primaryDatabase.withRetry(
          (db) => db.users.byKey('ds-only-user').fetch(),
        );
        final sqlAdvisory = await primaryDatabase.withRetry(
          (db) => db.securityAdvisories.byKey('GHSA-sql-primary-test').fetch(),
        );
        expect(sqlUser, isNull);
        expect(sqlAdvisory, isNull);

        // Clean up the synthetic Datastore entities for post-test integrity verification.
        await dbService.commit(deletes: [dsOnlyUser.key, dsOnlyAdvisory.key]);
      },
    );
  });
}
