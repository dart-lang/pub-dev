// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/service/openid/gcp_openid.dart';
import 'package:pub_dev/service/openid/github_openid.dart';
import 'package:pub_dev/service/openid/jwt.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/utils.dart' show createUuid;
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

AuditLogRecord _testRecord({
  required String userId,
  required List<String> packages,
  DateTime? expires,
}) {
  final now = clock.now().toUtc();
  return AuditLogRecord()
    ..id = createUuid()
    ..created = now
    ..expires = expires ?? now.add(Duration(days: 30))
    ..kind = AuditLogRecordKind.packageOptionsUpdated
    ..agent = userId
    ..summary = 'test record'
    ..data = {'packages': packages}
    ..users = [userId]
    ..packages = packages
    ..packageVersions = <String>[]
    ..publishers = <String>[];
}

void main() {
  group('before parameter parse and format', () {
    final backend = AuditBackend(DatastoreDB(MemDatastore()));

    test('nearby timestamps', () {
      final t1 = clock.now().toUtc();
      final t2 = t1.subtract(Duration(milliseconds: 1));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, t2.toIso8601String());
      expect(backend.parseBeforeQueryParameter(param), t2);
    });

    test('larger difference', () {
      final t1 = clock.now().toUtc();
      final t2 = t1.subtract(Duration(days: 2));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, hasLength(10));
      final parsed = backend.parseBeforeQueryParameter(param);
      expect(t2.isBefore(parsed), true);
      expect(t1.isAfter(parsed), true);
    });
  });

  group('message test', () {
    test('user uploads a package', () {
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.0.0',
        uploader: AuthenticatedUser(
          User.init()
            ..id = 'user-id'
            ..email = 'user@pub.dev',
          audience: 'fake-client-audience',
        ),
      );
      expect(
        r.summary,
        'Package `pkg` version `1.0.0` was published by `user@pub.dev`.',
      );
      expect(r.data, {
        'package': 'pkg',
        'version': '1.0.0',
        'email': 'user@pub.dev',
      });
    });

    test('GitHub Action uploads a package', () {
      final token = JsonWebToken(
        header: {},
        payload: {
          'aud': 'https://pub.dev',
          'event_name': 'push',
          'exp': 0,
          'iat': 0,
          'iss': 'github',
          'nbf': 0,
          'ref': 'tag',
          'ref_type': 'refs/tags/v1.2.0',
          'repository': 'abcd/efgh',
          'repository_id': '11',
          'repository_owner': 'abcd',
          'repository_owner_id': '22',
          'actor': 'abcd',
          'sha': 'some-hash-value',
          'run_id': 'example-run-id',
        },
        signature: [],
      );
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.2.0',
        uploader: AuthenticatedGitHubAction(
          idToken: token,
          payload: GitHubJwtPayload(token.payload),
        ),
      );
      expect(
        r.summary,
        'Package `pkg` version `1.2.0` was published from GitHub Actions '
        '(`run_id`: [`example-run-id`](https://github.com/abcd/efgh/actions/runs/example-run-id)) '
        'triggered by pushing revision [`some-hash-value`](https://github.com/abcd/efgh/commit/some-hash-value) '
        'to the `abcd/efgh` repository.',
      );
      expect(r.data, {
        'package': 'pkg',
        'version': '1.2.0',
        'repository': 'abcd/efgh',
        'run_id': 'example-run-id',
        'sha': 'some-hash-value',
      });
    });

    test('Google Cloud service account uploads a package', () {
      final token = JsonWebToken(
        header: {},
        payload: {
          'aud': 'https://pub.dev',
          'exp': 0,
          'iat': 0,
          'iss': 'google',
          'sub': 'sub-value',
          'nbf': 0,
          'email': 'account@example.com',
        },
        signature: [],
      );
      final r = AuditLogRecord.packagePublished(
        created: clock.now(),
        package: 'pkg',
        version: '1.2.0',
        uploader: AuthenticatedGcpServiceAccount(
          idToken: token,
          payload: GcpServiceAccountJwtPayload(token.payload),
        ),
      );
      expect(
        r.summary,
        'Package `pkg` version `1.2.0` was published by '
        'Google Cloud service account: `account@example.com`.',
      );
      expect(r.data, {
        'package': 'pkg',
        'version': '1.2.0',
        'email': 'account@example.com',
      });
    });
  });

  group('SQL migration', () {
    testWithProfile(
      'migrateToSql writes row and associations',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);
        final record = _testRecord(userId: user.userId, packages: ['oxygen']);
        await dbService.commit(inserts: [record]);
        await auditBackend.migrateToSql(record);

        final row = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(record.id!).fetch(),
        );
        expect(row, isNotNull);
        expect(row!.kind, AuditLogRecordKind.packageOptionsUpdated);
        expect(row.agent, user.userId);
        expect(row.dataJson?.value, {
          'packages': ['oxygen'],
        });

        final associations = await primaryDatabase.withRetry(
          (db) => db.auditLogAssociations
              .where((a) => a.recordId.equalsValue(record.id!))
              .fetch(),
        );
        expect(associations.map((a) => '${a.kind}:${a.value}').toSet(), {
          'user:${user.userId}',
          'package:oxygen',
        });
      },
    );

    testWithProfile(
      'migrateToSql is idempotent',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);
        final record = _testRecord(userId: user.userId, packages: ['oxygen']);
        await dbService.commit(inserts: [record]);
        await auditBackend.migrateToSql(record);
        await auditBackend.migrateToSql(record);

        final rows = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords
              .where((r) => r.id.equalsValue(record.id!))
              .fetch(),
        );
        expect(rows, hasLength(1));

        final associations = await primaryDatabase.withRetry(
          (db) => db.auditLogAssociations
              .where((a) => a.recordId.equalsValue(record.id!))
              .fetch(),
        );
        expect(associations, hasLength(2)); // users + packages, no duplicates
      },
    );

    testWithProfile(
      'migrateFromDatastore moves old entities to SQL',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);
        final record = _testRecord(userId: user.userId, packages: ['oxygen']);
        record.created = clock.now().toUtc().subtract(Duration(minutes: 5));
        final recent = _testRecord(userId: user.userId, packages: ['oxygen']);
        await dbService.commit(inserts: [record, recent]);

        var row = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(record.id!).fetch(),
        );
        expect(row, isNull);

        final count = await auditBackend.migrateFromDatastore();
        expect(count, 1);
        expect(await dbService.lookup<AuditLogRecord>([record.key]), [null]);

        // recent entity is left untouched
        expect(await dbService.lookup<AuditLogRecord>([recent.key]), [
          isNotNull,
        ]);
        final recentRow = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(recent.id!).fetch(),
        );
        expect(recentRow, isNull);
        await dbService.commit(deletes: [recent.key]);

        row = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(record.id!).fetch(),
        );
        expect(row, isNotNull);
      },
    );

    testWithProfile(
      'deleteExpiredSqlRecords removes only expired rows',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);
        final expired = _testRecord(
          userId: user.userId,
          packages: ['oxygen'],
          expires: clock.now().toUtc().subtract(Duration(days: 1)),
        );
        final live = _testRecord(userId: user.userId, packages: ['oxygen']);
        await dbService.commit(inserts: [expired, live]);
        await auditBackend.migrateToSql(expired);
        await auditBackend.migrateToSql(live);

        await auditBackend.deleteExpiredSqlRecords();

        final expiredRow = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(expired.id!).fetch(),
        );
        expect(expiredRow, isNull);
        final expiredAssociations = await primaryDatabase.withRetry(
          (db) => db.auditLogAssociations
              .where((a) => a.recordId.equalsValue(expired.id!))
              .fetch(),
        );
        expect(expiredAssociations, isEmpty);

        final liveRow = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(live.id!).fetch(),
        );
        expect(liveRow, isNotNull);

        expect(await dbService.lookup<AuditLogRecord>([expired.key]), [null]);
      },
    );

    testWithProfile(
      'deleteSqlRecordsForPackage removes rows referencing the package',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);
        final record = _testRecord(userId: user.userId, packages: ['oxygen']);
        await dbService.commit(inserts: [record]);
        await auditBackend.migrateToSql(record);

        await auditBackend.deleteSqlRecordsForPackage('oxygen');

        final row = await primaryDatabase.withRetry(
          (db) => db.auditLogRecords.byKey(record.id!).fetch(),
        );
        expect(row, isNull);

        expect(await dbService.lookup<AuditLogRecord>([record.key]), [null]);
      },
    );
  });

  group('listRecordsForUserId ordering and cursor', () {
    testWithProfile(
      'returns records in reverse-chronological order',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);

        final r1 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r1]);
        await auditBackend.migrateToSql(r1);

        clockControl.elapse(minutes: 1);
        final r2 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r2]);
        await auditBackend.migrateToSql(r2);

        clockControl.elapse(minutes: 1);
        final r3 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r3]);
        await auditBackend.migrateToSql(r3);

        final page = await auditBackend.listRecordsForUserId(user.userId);
        final ids = page.records.map((r) => r.recordId).toList();
        expect(ids.indexOf(r3.id!), lessThan(ids.indexOf(r2.id!)));
        expect(ids.indexOf(r2.id!), lessThan(ids.indexOf(r1.id!)));
      },
    );

    testWithProfile(
      '`before` cursor excludes records created after it',
      fn: () async {
        final user = await accountBackend.lookupUserByEmail(adminAtPubDevEmail);

        final r1 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r1]);
        await auditBackend.migrateToSql(r1);

        clockControl.elapse(minutes: 1);
        final r2 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r2]);
        await auditBackend.migrateToSql(r2);

        clockControl.elapse(minutes: 1);
        final r3 = _testRecord(userId: user.userId, packages: []);
        await dbService.commit(inserts: [r3]);
        await auditBackend.migrateToSql(r3);

        final page = await auditBackend.listRecordsForUserId(
          user.userId,
          before: r2.created,
        );
        final ids = page.records.map((r) => r.recordId).toList();
        expect(ids, isNot(contains(r3.id)));
        expect(ids, containsAll([r1.id, r2.id]));
        expect(ids.indexOf(r2.id!), lessThan(ids.indexOf(r1.id!)));
      },
    );
  });
}
