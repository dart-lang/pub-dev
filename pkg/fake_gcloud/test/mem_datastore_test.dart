// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:fake_gcloud/mem_datastore.dart';

void main() {
  test('empty lookup', () async {
    final db = DatastoreDB(MemDatastore());
    final list = await db.lookup([db.emptyKey.append(Sample, id: 'x')]);
    expect(list, [null]);
  });

  test('transaction with rollback', () async {
    final db = DatastoreDB(MemDatastore());
    await db.commit(inserts: [
      Sample()
        ..parentKey = db.emptyKey
        ..id = 'x'
        ..count = 1,
    ]);
    await db.withTransaction((tx) async {
      final entry =
          (await tx.lookup<Sample>([db.emptyKey.append(Sample, id: 'x')]))
              .single;
      entry.count = 2;
      tx.queueMutations(inserts: [entry]);
      await tx.rollback();
    });
    final list = await db.lookup([db.emptyKey.append(Sample, id: 'x')]);
    final item = list.single as Sample;
    expect(item, isNotNull);
    expect(item.count, 1);
  });

  test('transaction with commit', () async {
    final db = DatastoreDB(MemDatastore());
    await db.commit(inserts: [
      Sample()
        ..parentKey = db.emptyKey
        ..id = 'x'
        ..count = 1,
    ]);
    await db.withTransaction((tx) async {
      tx.queueMutations(inserts: [
        Sample()
          ..parentKey = db.emptyKey
          ..id = 'x'
          ..count = 2,
      ]);
      await tx.commit();
    });
    final list = await db.lookup([db.emptyKey.append(Sample, id: 'x')]);
    final item = list.single as Sample;
    expect(item, isNotNull);
    expect(item.count, 2);
  });

  test('insert can happen when missing parent', () async {
    final db = DatastoreDB(MemDatastore());
    await db.commit(inserts: [
      Sample()
        ..parentKey = db.emptyKey.append(Sample, id: 'missing')
        ..id = 'x'
        ..count = 1,
    ]);

    final parent = await db.lookup([db.emptyKey.append(Sample, id: 'missing')]);
    expect(parent.single, isNull);

    final list = await db.lookup([
      db.emptyKey.append(Sample, id: 'missing').append(Sample, id: 'x'),
    ]);
    final item = list.single as Sample;
    expect(item, isNotNull);
    expect(item.count, 1);
  });

  test('conflicting update and delete', () async {
    final db = DatastoreDB(MemDatastore());
    final rs = db.commit(
      inserts: [
        Sample()
          ..parentKey = db.emptyKey
          ..id = 'x'
          ..count = 1,
      ],
      deletes: [
        db.emptyKey.append(Sample, id: 'x'),
      ],
    );
    await expectLater(rs, throwsA(isA<DatastoreError>()));
  });

  group('Queries', () {
    final db = DatastoreDB(MemDatastore());

    setUpAll(() async {
      await db.commit(inserts: [
        Sample()
          ..parentKey = db.emptyKey
          ..id = 'x1'
          ..type = 't1'
          ..updated = DateTime(2019, 02, 25)
          ..count = 1,
        Sample()
          ..parentKey = db.emptyKey
          ..id = 'x2'
          ..type = 't2'
          ..updated = DateTime(2019, 02, 26)
          ..count = 4,
      ]);
    });

    test('query for String: no match', () async {
      final q = db.query<Sample>()..filter('type =', 'abc');
      final list = await q.run().toList();
      expect(list, isEmpty);
    });

    test('query for String: match', () async {
      final q = db.query<Sample>()..filter('type =', 't1');
      final list = await q.run().toList();
      expect(list, hasLength(1));
      expect(list[0].id, 'x1');
    });

    test('query for int: greater', () async {
      final q = db.query<Sample>()..filter('count >', 3);
      final list = await q.run().toList();
      expect(list, hasLength(1));
      expect(list[0].id, 'x2');
    });

    test('query for int: less', () async {
      final q = db.query<Sample>()..filter('count <', 0);
      final list = await q.run().toList();
      expect(list, isEmpty);
    });

    test('query order ascending', () async {
      final q = db.query<Sample>()..order('count');
      final list = await q.run().toList();
      expect(list.map((s) => s.id).toList(), ['x1', 'x2']);
    });

    test('query order ascending', () async {
      final q = db.query<Sample>()..order('-count');
      final list = await q.run().toList();
      expect(list.map((s) => s.id).toList(), ['x2', 'x1']);
    });
  });

  group('hierarchies', () {
    final db = DatastoreDB(MemDatastore());

    setUpAll(() async {
      await db.commit(inserts: [
        Sample()
          ..parentKey = db.emptyKey
          ..id = 'root'
          ..type = 'root-type'
          ..updated = DateTime(2019, 02, 25)
          ..count = 1,
        Sample()
          ..parentKey = db.emptyKey.append(Sample, id: 'root')
          ..id = 'node-1'
          ..type = 'node-type'
          ..updated = DateTime(2019, 02, 26)
          ..count = 4,
      ]);
    });

    test('query without ancestorKey', () async {
      final q = db.query<Sample>();
      final list = (await q.run().toList()).map((s) => s.id).toList();
      list.sort();
      expect(list, ['node-1', 'root']);
    });

    test('query with ancestorKey', () async {
      final q =
          db.query<Sample>(ancestorKey: db.emptyKey.append(Sample, id: 'root'));
      final list = (await q.run().toList()).map((s) => s.id).toList();
      list.sort();
      expect(list, ['node-1']);
    });

    test('query with missing ancestorKey', () async {
      final q = db.query<Sample>(
          ancestorKey: db.emptyKey.append(Sample, id: 'missing'));
      final list = (await q.run().toList()).map((s) => s.id).toList();
      list.sort();
      expect(list, isEmpty);
    });
  });
}

@Kind(name: 'Sample', idType: IdType.String)
class Sample extends Model {
  @StringProperty()
  String type;

  @DateTimeProperty()
  DateTime updated;

  @IntProperty()
  int count;
}
