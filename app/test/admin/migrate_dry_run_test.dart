// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/migrate_dry_run.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('migrate-dry-run', () {
    test('scripts do not control the transaction', () {
      final forbidden = RegExp(
        r'\b(begin|commit|rollback|end|concurrently|vacuum)\b',
        caseSensitive: false,
      );
      for (final e in migrateDryRunScripts.entries) {
        expect(forbidden.hasMatch(e.value), isFalse, reason: e.key);
      }
    });

    testWithProfile(
      'all predefined scripts run and roll back',
      fn: () async {
        for (final name in migrateDryRunScripts.keys) {
          final result = await migrateDryRun.invoke({'script': name});
          expect(result['rolledBack'], true);
          expect(result['ok'], true, reason: '$result');
        }
        // expecting this to complete without an issue
        expect(
          await primaryDatabase.migrateDryRun(
            'CREATE TABLE "dry_run_smoke" ("id" text NOT NULL);',
          ),
          isNull,
        );
        // dropping should fail because the table does not exist
        final dropError = await primaryDatabase.migrateDryRun(
          'DROP TABLE "dry_run_smoke";',
        );
        expect(dropError, contains('dry_run_smoke'));
        // nothing else persisted
        expect(await primaryDatabase.migrateDryRun('SELECT 1;'), isNull);
        expect(
          await primaryDatabase.migrateDryRun(
            'ALTER TABLE "user_sessions" '
            'DROP CONSTRAINT "user_sessions_fk_user";',
          ),
          isNotNull,
        );
      },
    );

    testWithProfile(
      'reports a failing script and rolls back partial changes',
      fn: () async {
        final error = await primaryDatabase.migrateDryRun(
          'CREATE TABLE "dry_run_partial" ("id" text);\n'
          'SELECT * FROM "no_such_table";',
        );
        expect(error, contains('no_such_table'));
        // The table creation must have been rolled back as well.
        expect(
          await primaryDatabase.migrateDryRun(
            'CREATE TABLE "dry_run_partial" ("id" text);',
          ),
          isNull,
        );
      },
    );

    testWithProfile(
      'fk script fails on orphaned sessions',
      fn: () async {
        final adapter = primaryDatabase.adapterForTesting;
        await adapter.script(
          'INSERT INTO "user_sessions" '
          '("session_id", "user_id", "created", "expires") '
          "VALUES ('s1', 'no-such-user', now(), now())",
        );
        try {
          final result = await migrateDryRun.invoke({
            'script': 'user-sessions-fk-user',
          });
          expect(result['ok'], false);
          expect(result['error'], contains('user_sessions_fk_user'));
        } finally {
          // the integrity check at the end of the test would flag the orphan
          await adapter.script('DELETE FROM "user_sessions"');
        }
      },
    );

    testWithProfile(
      'missing script',
      fn: () async {
        await expectLater(
          migrateDryRun.invoke({}),
          throwsA(isA<InvalidInputException>()),
        );
      },
    );

    testWithProfile(
      'unknown script',
      fn: () async {
        await expectLater(
          migrateDryRun.invoke({'script': 'nope'}),
          throwsA(isA<NotFoundException>()),
        );
      },
    );
  });
}
