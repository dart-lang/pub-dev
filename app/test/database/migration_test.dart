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
          final m = _setup('test-forward-compat');

          // 1. Newer version applies 3 migrations.
          await m.run([
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000002_second.sql', content: 'SELECT 2;'),
            (name: '000003_third.sql', content: 'SELECT 3;'),
          ]);

          // 2. Older version (only knows about 000001 and 000002) runs migrateScripts.
          await m.run([
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000002_second.sql', content: 'SELECT 2;'),
          ]);

          expect(await m.rows(), hasLength(3));
        });
      },
    );

    testWithProfile(
      'applies all scripts after a partial application',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-partial');
          final scripts = [
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000002_second.sql', content: 'SELECT 2;'),
            (name: '000003_third.sql', content: 'SELECT 3;'),
          ];

          await m.run(scripts.sublist(0, 1));
          expect(await m.rows(), hasLength(1));

          await m.run(scripts);
          expect(await m.rows(), hasLength(3));
        });
      },
    );

    testWithProfile(
      'throws when unknown migration precedes last local script',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-out-of-order');

          // Apply 000001, 000002, 000003.
          await m.run([
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000002_middle.sql', content: 'SELECT 1;'),
            (name: '000003_second.sql', content: 'SELECT 2;'),
          ]);

          // Binary with only 000001 and 000003 should fail because 000002 precedes 000003.
          await expectLater(
            () => m.run([
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000003_second.sql', content: 'SELECT 2;'),
            ]),
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
          final m = _setup('test-divergent');

          // Apply 000001 and 000003.
          await m.run([
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000003_third.sql', content: 'SELECT 3;'),
          ]);

          // Binary with 000001 and 000002 should fail because 000002 is unapplied while 000003 exists.
          await expectLater(
            () => m.run([
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000002_second.sql', content: 'SELECT 2;'),
            ]),
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

    testWithProfile(
      'failed script leaves no history, concurrent runs both succeed',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-atomic');

          await expectLater(
            () => m.run([(name: '000001_bad.sql', content: 'SELECT 1/0;')]),
            throwsA(anything),
          );
          expect(await m.rows(), isEmpty);

          final scripts = [
            (name: '000001_first.sql', content: 'SELECT 1;'),
            (name: '000002_second.sql', content: 'SELECT 2;'),
          ];
          await Future.wait([for (var i = 0; i < 3; i++) m.run(scripts)]);
          expect(await m.rows(), hasLength(2));
        });
      },
    );

    testWithProfile(
      'throws on hash mismatch of an applied script',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-hash-mismatch');
          await m.run([(name: '000001_first.sql', content: 'SELECT 1;')]);
          await expectLater(
            () => m.run([(name: '000001_first.sql', content: 'SELECT 2;')]),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('Script hash difference detected: `000001_first.sql`'),
              ),
            ),
          );
        });
      },
    );

    testWithProfile(
      'throws on duplicate script names',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-duplicate');
          await expectLater(
            () => m.run([
              (name: '000001_first.sql', content: 'SELECT 1;'),
              (name: '000001_first.sql', content: 'SELECT 2;'),
            ]),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('Repeated script name: `000001_first.sql`'),
              ),
            ),
          );
          expect(await m.rows(), isEmpty);
        });
      },
    );

    testWithProfile(
      'applies only new scripts, re-run is a no-op',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-incremental');
          final first = (
            name: '000001_first.sql',
            content: 'CREATE TABLE test_mig_incr_a (id int);',
          );
          final second = (
            name: '000002_second.sql',
            content: 'CREATE TABLE test_mig_incr_b (id int);',
          );
          final third = (
            name: '000003_third.sql',
            content: 'CREATE TABLE test_mig_incr_c (id int);',
          );

          await m.run([first, second]);
          // Re-running would fail on the existing tables.
          await m.run([first, second]);
          expect(await m.rows(), hasLength(2));

          // Only the new script is executed.
          await m.run([first, second, third]);
          expect(await m.rows(), hasLength(3));
          expect(await m.tableExists('test_mig_incr_c'), isTrue);
        });
      },
    );

    testWithProfile(
      'schemas have independent histories',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final a = _setup('test-isolation-a');
          final b = _setup('test-isolation-b');
          await a.run([(name: '000001_first.sql', content: 'SELECT 1;')]);
          // Same name with different content is fine in another schema.
          await b.run([(name: '000001_first.sql', content: 'SELECT 2;')]);
          expect(await a.rows(), hasLength(1));
          expect(await b.rows(), hasLength(1));
          expect(
            (await a.rows()).single.scriptSha256,
            isNot((await b.rows()).single.scriptSha256),
          );
        });
      },
    );

    testWithProfile(
      'failing multi-statement script is rolled back entirely',
      fn: () async {
        await primaryDatabase.withRetry((db) async {
          final m = _setup('test-rollback');
          await expectLater(
            () => m.run([
              (
                name: '000001_bad.sql',
                content: 'CREATE TABLE test_mig_rollback (id int); SELECT 1/0;',
              ),
            ]),
            throwsA(anything),
          );
          expect(await m.tableExists('test_mig_rollback'), isFalse);
          expect(await m.rows(), isEmpty);
        });
      },
    );
  });
}

_Setup _setup(String schemaName) {
  final adapter = primaryDatabase.adapterForTesting;
  final migrationDb = Database<SchemaMigrationSchema>(
    adapter,
    SqlDialect.postgres(),
  );
  return _Setup(adapter, migrationDb.schemaMigrations, schemaName);
}

class _Setup {
  final DatabaseAdapter adapter;
  final Table<SchemaMigration> table;
  final String schemaName;
  _Setup(this.adapter, this.table, this.schemaName);

  Future<void> run(List<({String name, String content})> scripts) =>
      migrateScripts(
        target: adapter,
        table: table,
        schemaName: schemaName,
        scripts: [...scripts],
      );

  Future<List<SchemaMigration>> rows() =>
      table.where((m) => m.schemaName.equalsValue(schemaName)).fetch();

  Future<bool> tableExists(String name) async {
    final rs = await adapter
        .query(
          'SELECT count(*) FROM information_schema.tables '
          r'WHERE table_name = $1',
          [name],
        )
        .map((r) => r.readInt()!)
        .toList();
    return rs.single > 0;
  }
}
