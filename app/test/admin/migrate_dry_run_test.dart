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
            'ALTER TABLE "users" DROP CONSTRAINT "users_chk_moderated";',
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
      'chk script fails on moderated user without timestamp',
      fn: () async {
        final adapter = primaryDatabase.adapterForTesting;
        await _breakOneUser(adapter);
        try {
          final result = await migrateDryRun.invoke({
            'script': 'users-chk-moderated',
          });
          expect(result['ok'], false);
          expect(result['error'], contains('users_chk_moderated'));
        } finally {
          await _restoreUsers(adapter);
        }
      },
    );

    testWithProfile(
      'prefix with trailing star runs all matching scripts',
      fn: () async {
        final result = await migrateDryRun.invoke({'script': 'packages-fk-*'});
        expect(result['rolledBack'], true);
        expect(result['ok'], true, reason: '$result');
        final results = result['results'] as List;
        expect(results.map((r) => r['script']), [
          'packages-fk-latest-version',
          'packages-fk-publisher',
          'packages-fk-replaced-by',
        ]);

        final all = await migrateDryRun.invoke({'script': '*'});
        expect(all['ok'], true, reason: '$all');
        expect(
          (all['results'] as List).map((r) => r['script']),
          migrateDryRunScripts.keys,
        );
      },
    );

    testWithProfile(
      'prefix reports failures of individual scripts',
      fn: () async {
        final adapter = primaryDatabase.adapterForTesting;
        await _breakOneUser(adapter);
        try {
          final result = await migrateDryRun.invoke({'script': 'user*'});
          expect(result['ok'], false);
          final byName = {
            for (final r in result['results'] as List)
              r['script'] as String: r as Map,
          };
          expect(byName['users-chk-moderated']!['ok'], false);
          expect(byName['users-unique-active-email']!['ok'], true);
        } finally {
          await _restoreUsers(adapter);
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
        await expectLater(
          migrateDryRun.invoke({'script': 'nope-*'}),
          throwsA(isA<NotFoundException>()),
        );
      },
    );
  });
}

/// Marks one user as moderated without a `moderated_at` timestamp.
Future<void> _breakOneUser(dynamic adapter) async {
  await adapter.script(
    'UPDATE "users" SET "is_moderated" = true, "moderated_at" = NULL '
    'WHERE "user_id" = (SELECT min("user_id") FROM "users")',
  );
}

Future<void> _restoreUsers(dynamic adapter) async {
  await adapter.script(
    'UPDATE "users" SET "is_moderated" = false WHERE "moderated_at" IS NULL',
  );
}
