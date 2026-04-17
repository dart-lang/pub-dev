// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_services.dart';

void main() {
  group('Retry zone - without transaction', () {
    testWithProfile(
      'retry returns value',
      fn: () async {
        int count = 0;
        final rs = await primaryDatabase!.withRetry((db) async {
          count++;
          return 2;
        });
        expect(count, 1);
        expect(rs, 2);
      },
    );

    testWithProfile(
      'ResponseException is not retried',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.withRetry((db) async {
            count++;
            throw NotFoundException('');
          }),
          throwsA(isA<NotFoundException>()),
        );
        expect(count, 1);
      },
    );

    testWithProfile(
      'retried 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.withRetry((db) async {
            count++;
            await db.insertBadData();
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );

    testWithProfile(
      'embedded exception is retried only 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.withRetry((db) async {
            await primaryDatabase!.withRetry((db) async {
              count++;
              await db.insertBadData();
            });
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );

    testWithProfile(
      'embedded transaction is retried only 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.withRetry((db) async {
            await primaryDatabase!.transactWithRetry((db) async {
              count++;
              await db.insertBadData();
            });
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );
  });

  group('Retry zone - with transaction', () {
    testWithProfile(
      'transactWithRetry returns value',
      fn: () async {
        int count = 0;
        final rs = await primaryDatabase!.transactWithRetry((db) async {
          count++;
          return 2;
        });
        expect(count, 1);
        expect(rs, 2);
      },
    );

    testWithProfile(
      'ResponseException is not retried',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.transactWithRetry((db) async {
            count++;
            throw NotFoundException('');
          }),
          throwsA(isA<NotFoundException>()),
        );
        expect(count, 1);
      },
    );

    testWithProfile(
      'retried 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.transactWithRetry((db) async {
            count++;
            await db.insertBadData();
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );

    testWithProfile(
      'embedded exception is retried only 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.transactWithRetry((db) async {
            await primaryDatabase!.transactWithRetry((db) async {
              count++;
              await db.insertBadData();
            });
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );

    testWithProfile(
      'embedded non-transaction is retried only 3 times',
      fn: () async {
        int count = 0;

        await expectLater(
          () async => await primaryDatabase!.transactWithRetry((db) async {
            await primaryDatabase!.withRetry((db) async {
              count++;
              await db.insertBadData();
            });
          }),
          throwsA(isA<DatabaseException>()),
        );
        expect(count, 3);
      },
    );
  });
}

extension on Database<PrimarySchema> {
  Future<void> insertBadData() => task_dependencies
      .insert(
        runtime_version: 'x'.asExpr,
        package: 'pkg'.asExpr,
        dependency: 'dep'.asExpr,
      )
      .execute();
}
