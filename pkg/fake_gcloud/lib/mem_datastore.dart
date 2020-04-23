import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart';

/// Implementation of [Datastore] interface with in-memory storage.
///
/// Entities are cloned, and should be safe to modify them once they are stored
/// or read.
class MemDatastore implements Datastore {
  final _entities = <Key, Entity>{};
  int _unusedId = 0;

  @override
  Future<List<Key>> allocateIds(List<Key> keys) async {
    return keys.map((k) {
      if (k.elements.last.id == null) {
        final elements = List<KeyElement>.from(k.elements);
        final last = elements.removeLast();
        elements.add(KeyElement(last.kind, _unusedId++));
        return Key(elements, partition: k.partition);
      } else {
        return k;
      }
    }).toList();
  }

  @override
  Future<Transaction> beginTransaction({bool crossEntityGroup = false}) async {
    return _Transaction();
  }

  @override
  Future<CommitResult> commit(
      {List<Entity> inserts,
      List<Entity> autoIdInserts,
      List<Key> deletes,
      Transaction transaction}) async {
    inserts ??= <Entity>[];
    deletes ??= <Key>[];

    if (autoIdInserts != null && autoIdInserts.isNotEmpty) {
      throw UnimplementedError(
          'fake_gcloud.Datastore.autoIdInserts is not implemented.');
    }

    // https://cloud.google.com/datastore/docs/concepts/transactions#what_can_be_done_in_a_transaction
    if (inserts.length + deletes.length > 500) {
      throw DatastoreError('Too many entities in the transaction.');
    }

    final newKeys = inserts.map((i) => i.key).toSet();

    // check if updated key is deleted
    for (final deletedKey in deletes) {
      if (newKeys.contains(deletedKey)) {
        throw DatastoreError('Conflicting update and delete on $deletedKey');
      }
    }

    // TODO: check serializability.
    // We need to track the keys that have been mutated since the Transaction
    // was created to ensure that there are no conflicts.
    // Alternatively: block overlapping transactions.

    // execute commit
    deletes.forEach((key) => _entities.remove(key));
    inserts.forEach((e) {
      _entities[e.key] = e;
    });

    return CommitResult([]);
  }

  @override
  Future<List<Entity>> lookup(List<Key> keys, {Transaction transaction}) async {
    if (keys.any((k) => k.elements.any((e) => e.id == null))) {
      throw ArgumentError('Key contains null.');
    }
    return keys.map((key) => _entities[key]).toList();
  }

  dynamic _getValue(Entity entity, String property) {
    if (property == '__key__') return entity.key;
    return entity.properties[property];
  }

  int _compare(dynamic a, dynamic b) {
    if (a is Key && b is Key) {
      if (a.elements.length != 1) {
        throw UnimplementedError();
      }
      if (b.elements.length != 1) {
        throw UnimplementedError();
      }
      return Comparable.compare(a.elements.single.id as Comparable,
          b.elements.single.id as Comparable);
    } else {
      return Comparable.compare(a as Comparable, b as Comparable);
    }
  }

  @override
  Future<Page<Entity>> query(Query query,
      {Partition partition, Transaction transaction}) async {
    List<Entity> items = _entities.values
        .where((e) => e.key.elements.last.kind == query.kind)
        .where(
      (e) {
        if (query.ancestorKey == null) {
          return true;
        }
        if (query.ancestorKey.partition != e.key.partition) {
          return false;
        }
        if (query.ancestorKey.elements.length != e.key.elements.length - 1) {
          return false;
        }
        for (int i = 0; i < query.ancestorKey.elements.length; i++) {
          if (query.ancestorKey.elements[i] != e.key.elements[i]) {
            return false;
          }
        }
        return true;
      },
    ).where(
      (e) {
        if (query.filters == null || query.filters.isEmpty) {
          return true;
        }
        return query.filters.every((f) {
          final v = _getValue(e, f.name);
          if (v == null) return false;
          final c = _compare(v, f.value);
          switch (f.relation) {
            case FilterRelation.Equal:
              return c == 0;
            case FilterRelation.LessThan:
              return c < 0;
            case FilterRelation.LessThanOrEqual:
              return c <= 0;
            case FilterRelation.GreatherThan:
              return c > 0;
            case FilterRelation.GreatherThanOrEqual:
              return c >= 0;
            default:
              throw UnimplementedError('Not handled relation: ${f.relation}');
          }
        });
      },
    ).toList();
    if (query.orders != null && query.orders.isNotEmpty) {
      items.sort((a, b) {
        for (Order o in query.orders) {
          final ap = _getValue(a, o.propertyName);
          final bp = _getValue(b, o.propertyName);
          final c = _compare(ap, bp);
          if (c == 0) continue;
          if (o.direction == OrderDirection.Ascending) {
            return c;
          } else {
            return -c;
          }
        }
        return 0;
      });
    }
    if (query.offset != null && query.offset > 0) {
      items = items.skip(query.offset).toList();
    }
    if (query.limit != null && query.limit < items.length) {
      items = items.sublist(0, query.limit);
    }
    return _Page(items, 0, 100);
  }

  @override
  Future<void> rollback(Transaction transaction) async {
    return null;
  }
}

class _Transaction implements Transaction {}

class _Page implements Page<Entity> {
  final List<Entity> _items;
  @override
  final List<Entity> items;
  final int _offset;
  final int _pageSize;

  _Page(this._items, this._offset, this._pageSize)
      : items = _items.skip(_offset).take(_pageSize).toList();

  @override
  bool get isLast => _offset + _pageSize > _items.length;

  @override
  Future<Page<Entity>> next({int pageSize}) async {
    return _Page(_items, _offset + _pageSize, pageSize ?? _pageSize);
  }
}
