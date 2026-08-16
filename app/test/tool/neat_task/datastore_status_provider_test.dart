// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/neat_task/datastore_status_provider.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../shared/test_services.dart';

void main() {
  group('DatastoreStatusProvider', () {
    Future<List<NeatTaskStatus>> listStatuses() async {
      return await dbService.query<NeatTaskStatus>().run().toList();
    }

    Future<NeatTaskStatusRow?> lookupSqlRow(
      String name, {
      required bool isRuntimeVersioned,
    }) async {
      final rv = isRuntimeVersioned ? runtimeVersion : '-';
      return await primaryDatabase.withRetry(
        (db) => db.neatTaskStatuses.byKey(name, rv).fetch(),
      );
    }

    testWithProfile(
      'get empty status - global',
      fn: () async {
        final provider = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: false,
        );
        expect(await provider.get(), isEmpty);
        expect(await provider.get(), isEmpty);

        final row = await lookupSqlRow('task-id', isRuntimeVersioned: false);
        expect(row, isNotNull);
        expect(row!.status, isEmpty);
        expect(await listStatuses(), isEmpty);

        await deleteOldNeatTaskStatuses(dbService, maxAge: Duration(hours: 1));
        expect(
          await lookupSqlRow('task-id', isRuntimeVersioned: false),
          isNotNull,
        );

        await deleteOldNeatTaskStatuses(dbService, maxAge: Duration.zero);
        expect(
          await lookupSqlRow('task-id', isRuntimeVersioned: false),
          isNull,
        );
      },
    );

    testWithProfile(
      'get empty status - versioned',
      fn: () async {
        final provider = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: true,
        );
        expect(await provider.get(), isEmpty);
        expect(await provider.get(), isEmpty);
        final row = await lookupSqlRow('task-id', isRuntimeVersioned: true);
        expect(row, isNotNull);
        expect(row!.status, isEmpty);
        expect(await listStatuses(), isEmpty);
      },
    );

    testWithProfile(
      'set status - global',
      fn: () async {
        final provider = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: false,
        );
        expect(await provider.set([1, 2]), isTrue);
        expect(await provider.get(), [1, 2]);
        var row = await lookupSqlRow('task-id', isRuntimeVersioned: false);
        expect(row!.status, [1, 2]);

        expect(await provider.set([3, 4]), isTrue);
        expect(await provider.get(), [3, 4]);
        row = await lookupSqlRow('task-id', isRuntimeVersioned: false);
        expect(row!.status, [3, 4]);

        final list = await listStatuses();
        expect(row.etag, list.single.etag);

        await deleteOldNeatTaskStatuses(dbService, maxAge: Duration.zero);
        expect(await listStatuses(), isEmpty);
        expect(
          await lookupSqlRow('task-id', isRuntimeVersioned: false),
          isNull,
        );
      },
    );

    testWithProfile(
      'set status - versioned',
      fn: () async {
        final provider = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: true,
        );
        expect(await provider.set([1, 2]), isTrue);
        expect(await provider.get(), [1, 2]);
        var row = await lookupSqlRow('task-id', isRuntimeVersioned: true);
        expect(row!.status, [1, 2]);

        expect(await provider.set([3, 4]), isTrue);
        expect(await provider.get(), [3, 4]);
        row = await lookupSqlRow('task-id', isRuntimeVersioned: true);
        expect(row!.status, [3, 4]);
      },
    );

    testWithProfile(
      'set status concurrently - global',
      fn: () async {
        final p1 = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: false,
        );
        expect(await p1.set([1, 2]), isTrue);
        expect(await p1.get(), [1, 2]);

        final p2 = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: false,
        );
        expect(await p2.set([3, 4]), isFalse);
        expect(await p2.get(), [1, 2]);
        var row = await lookupSqlRow('task-id', isRuntimeVersioned: false);
        expect(row!.status, [1, 2]);

        expect(await p2.set([3, 4]), isTrue);
        expect(await p2.get(), [3, 4]);
        row = await lookupSqlRow('task-id', isRuntimeVersioned: false);
        expect(row!.status, [3, 4]);

        expect(await p1.set([1, 2]), isFalse);
      },
    );

    testWithProfile(
      'set status concurrently - versioned',
      fn: () async {
        final p1 = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: true,
        );
        expect(await p1.set([1, 2]), isTrue);
        expect(await p1.get(), [1, 2]);

        final p2 = DatastoreStatusProvider.create(
          dbService,
          'task-id',
          isRuntimeVersioned: true,
        );
        expect(await p2.set([3, 4]), isFalse);
        expect(await p2.get(), [1, 2]);
        expect(await p2.set([3, 4]), isTrue);
        expect(await p2.get(), [3, 4]);

        expect(await p1.set([1, 2]), isFalse);
      },
    );
  });
}
