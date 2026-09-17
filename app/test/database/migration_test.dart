// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/migration.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_services.dart';

void main() {
  group('migrateScripts', () {
    testWithProfile(
      'allows forward-compatible newer migrations in database',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final adapter = primaryDatabase.adapterForTesting;
          final migrationDb = Database<SchemaMigrationSchema>(
            adapter,
            SqlDialect.postgres(),
          );
          final table = migrationDb.schemaMigrations;
          const schemaName = 'test-forward-compat';

          // 1. Newer version applies 3 migrations.
          await migrateScripts(
            target: adapter,
            table: table,
            schemaName: schemaName,
            scripts: [
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000002_second.sql', content: 'SELECT 2;'),
              (name: '000003_third.sql', content: 'SELECT 3;'),
            ],
          );

          // 2. Older version (only knows about 000001 and 000002) runs migrateScripts.
          final warnings = <String>[];
          await migrateScripts(
            target: adapter,
            table: table,
            schemaName: schemaName,
            scripts: [
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000002_second.sql', content: 'SELECT 2;'),
            ],
            onWarning: warnings.add,
          );

          expect(warnings, hasLength(1));
          expect(
            warnings.single,
            contains(
              'Database schema `test-forward-compat` contains 1 newer migration(s) '
              'not present locally: `000003_third.sql`',
            ),
          );
        });
      },
    );

    testWithProfile(
      'throws when unknown migration precedes last local script',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final adapter = primaryDatabase.adapterForTesting;
          final migrationDb = Database<SchemaMigrationSchema>(
            adapter,
            SqlDialect.postgres(),
          );
          final table = migrationDb.schemaMigrations;
          const schemaName = 'test-out-of-order';

          // Apply 000001, 000002, 000003.
          await migrateScripts(
            target: adapter,
            table: table,
            schemaName: schemaName,
            scripts: [
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000002_middle.sql', content: 'SELECT 1;'),
              (name: '000003_second.sql', content: 'SELECT 2;'),
            ],
          );

          // Binary with only 000001 and 000003 should fail because 000002 precedes 000003.
          await expectLater(
            () => migrateScripts(
              target: adapter,
              table: table,
              schemaName: schemaName,
              scripts: [
                (name: '000001_first.sql', content: 'SELECT 1;'),
                (name: '000003_second.sql', content: 'SELECT 2;'),
              ],
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains(
                  'Existing history without local files (1 items): `000002_middle.sql`',
                ),
              ),
            ),
          );
        });
      },
    );

    testWithProfile(
      'throws when local script is missing from database but newer migration exists',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final adapter = primaryDatabase.adapterForTesting;
          final migrationDb = Database<SchemaMigrationSchema>(
            adapter,
            SqlDialect.postgres(),
          );
          final table = migrationDb.schemaMigrations;
          const schemaName = 'test-divergent';

          // Apply 000001 and 000003.
          await migrateScripts(
            target: adapter,
            table: table,
            schemaName: schemaName,
            scripts: [
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000003_third.sql', content: 'SELECT 3;'),
            ],
          );

          // Binary with 000001 and 000002 should fail because 000002 is unapplied while 000003 exists.
          await expectLater(
            () => migrateScripts(
              target: adapter,
              table: table,
              schemaName: schemaName,
              scripts: [
                (name: '000001_first.sql', content: 'SELECT 1;'),
                (name: '000002_second.sql', content: 'SELECT 2;'),
              ],
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains(
                  'Existing history without local files (1 items): `000003_third.sql`',
                ),
              ),
            ),
          );
        });
      },
    );
  });
}
