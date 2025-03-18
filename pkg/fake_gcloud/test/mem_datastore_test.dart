// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart';
import 'package:test/test.dart';

final _longString = '0123456789abcdef' * 100; // 1600 bytes
final _shortOf1M = '0123456789abcdef' * (65536 - 1);

void main() {
  test('empty lookup', () async {
    final db = DatastoreDB(MemDatastore());
    final list = await db.lookup([db.emptyKey.append(Sample, id: 'x')]);
    expect(list, [null]);
  });

  test('too long empty lookup', () async {
    final db = DatastoreDB(MemDatastore());
    await expectLater(
        () => db.lookup([db.emptyKey.append(Sample, id: _longString)]),
        throwsA(isA<DatastoreError>()));
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
      entry!.count = 2;
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

  group('property lengths', () {
    test('key element over 1500 bytes fails', () async {
      final db = DatastoreDB(MemDatastore());
      final rs = db.commit(
        inserts: [
          Sample()
            ..parentKey = db.emptyKey
            ..id = _longString
        ],
      );
      await expectLater(rs, throwsA(isA<DatastoreError>()));
    });

    test('indexed property over 1500 bytes fails', () async {
      final db = DatastoreDB(MemDatastore());
      final rs = db.commit(
        inserts: [
          Sample()
            ..parentKey = db.emptyKey
            ..id = 'x'
            ..type = _longString,
        ],
      );
      await expectLater(rs, throwsA(isA<DatastoreError>()));
    });

    test('non-indexed property over 1500 bytes is OK', () async {
      final db = DatastoreDB(MemDatastore());
      await db.commit(
        inserts: [
          Sample()
            ..parentKey = db.emptyKey
            ..id = 'x'
            ..content = _longString,
          Sample()
            ..parentKey = db.emptyKey
            ..id = 'x'
            ..content = _shortOf1M,
        ],
      );
    });

    test('overall property over 1M fails', () async {
      final db = DatastoreDB(MemDatastore());
      final rs = db.commit(
        inserts: [
          Sample()
            ..parentKey = db.emptyKey
            ..id = 'x'
            ..type = '0123456789abcdefghijklmonop' // pushes over 1M
            ..content = _shortOf1M,
        ],
      );
      await expectLater(rs, throwsA(isA<DatastoreError>()));
    });
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
    final store = MemDatastore();
    final db = DatastoreDB(store);

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
          ..count = 4
          ..content = 'abc123',
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

    test('write and read', () async {
      final sb = StringBuffer();
      store.writeTo(sb);
      expect(sb.length, 454);
      final newStore = MemDatastore()..readFrom(sb.toString().split('\n'));
      final newDb = DatastoreDB(newStore);

      final q = newDb.query<Sample>(
          ancestorKey: newDb.emptyKey.append(Sample, id: 'root'));
      final list = (await q.run().toList())
          .map((s) => {
                'id': s.id,
                'updated': s.updated,
                'count': s.count,
                'content': s.content,
              })
          .toList();
      expect(list.single, {
        'id': 'node-1',
        'updated': DateTime(2019, 02, 26).toUtc(),
        'count': 4,
        'content': 'abc123',
      });
    });
  });
}

@Kind(name: 'Sample', idType: IdType.String)
class Sample extends Model {
  @StringProperty()
  String? type;

  @DateTimeProperty()
  DateTime? updated;

  @IntProperty()
  int? count;

  @StringProperty(indexed: false)
  String? content;
}
