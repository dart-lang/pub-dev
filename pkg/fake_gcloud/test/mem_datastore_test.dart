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
