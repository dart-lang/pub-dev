// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../database/publisher_sql_utils.dart';
import '../shared/test_services.dart';

void main() {
  group('Publisher SQL mirror', () {
    Future<PublisherRow> readRow() async {
      final row = await primaryDatabase.withRetry(
        (db) => db.publishers.byKey('example.com').fetch(),
      );
      return row!;
    }

    testWithProfile(
      'skips the write when SQL is newer than Datastore',
      fn: () async {
        await publisherBackend.mirrorPublisherToSql('example.com');
        final before = await readRow();
        final newer = before.updatedAt.add(const Duration(minutes: 1));
        await primaryDatabase.transactWithRetry((db) async {
          await db.publishers
              .byKey('example.com')
              .update(
                (_, set) => set(
                  description: 'sql-newer'.asExpr,
                  updatedAt: newer.asExpr,
                ),
              )
              .execute();
        });

        await publisherBackend.mirrorPublisherToSql('example.com');

        final after = await readRow();
        expect(after.description, 'sql-newer');
        expect(after.updatedAt.isAtSameMomentAs(newer), isTrue);
      },
    );

    testWithProfile(
      'skips the write when updated and members are the same',
      fn: () async {
        await publisherBackend.mirrorPublisherToSql('example.com');
        await primaryDatabase.transactWithRetry((db) async {
          await db.publishers
              .byKey('example.com')
              .update((_, set) => set(description: 'sql-marker'.asExpr))
              .execute();
        });

        await publisherBackend.mirrorPublisherToSql('example.com');

        expect((await readRow()).description, 'sql-marker');
      },
    );

    testWithProfile(
      'writes when updated is the same but the members differ',
      fn: () async {
        await publisherBackend.mirrorPublisherToSql('example.com');
        await primaryDatabase.transactWithRetry((db) async {
          await db.publishers
              .byKey('example.com')
              .update((_, set) => set(description: 'sql-marker'.asExpr))
              .execute();
          await db.publisherMembers
              .where((m) => m.publisherId.equalsValue('example.com'))
              .delete()
              .execute();
        });

        await publisherBackend.mirrorPublisherToSql('example.com');

        await expectPublisherInSqlMatchesDatastore('example.com');
      },
    );

    testWithProfile(
      'writes when Datastore is newer than SQL',
      fn: () async {
        await publisherBackend.mirrorPublisherToSql('example.com');
        final before = await readRow();
        await primaryDatabase.transactWithRetry((db) async {
          await db.publishers
              .byKey('example.com')
              .update(
                (_, set) => set(
                  description: 'sql-older'.asExpr,
                  updatedAt: before.updatedAt
                      .subtract(const Duration(minutes: 1))
                      .asExpr,
                ),
              )
              .execute();
        });

        await publisherBackend.mirrorPublisherToSql('example.com');

        await expectPublisherInSqlMatchesDatastore('example.com');
      },
    );
  });
}
