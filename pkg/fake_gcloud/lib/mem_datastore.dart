import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart';

/// Implementation of [DatastoreDB] interface with in-memory storage.
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
    deletes?.forEach((key) => _entities.remove(key));
    inserts?.forEach((e) {
      _entities[e.key] = e;
    });
    if (autoIdInserts != null && autoIdInserts.isNotEmpty) {
      throw UnimplementedError();
    }
    return CommitResult([]);
  }

  @override
  Future<List<Entity>> lookup(List<Key> keys, {Transaction transaction}) async {
    return keys.map((key) => _entities[key]).toList();
  }

  @override
  Future<Page<Entity>> query(Query query,
      {Partition partition, Transaction transaction}) async {
    List<Entity> items = _entities.values
        .where((e) => e.key.elements.last.kind == query.kind)
        .where((e) =>
            query.ancestorKey == null ||
            e.key.elements[e.key.elements.length - 2] == query.ancestorKey)
        .where(
      (e) {
        if (query.filters == null || query.filters.isEmpty) {
          return true;
        }
        return query.filters.every((f) {
          final v = e.properties[f.name];
          if (v == null) return false;
          final c = Comparable.compare(v as Comparable, f.value as Comparable);
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
          final ap = a.properties[o.propertyName];
          final bp = b.properties[o.propertyName];
          final c = Comparable.compare(ap as Comparable, bp as Comparable);
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
    if (query.limit != null && query.limit > items.length) {
      items = items.sublist(0, query.limit);
    }
    return _Page(items, 0, 100);
  }

  @override
  Future rollback(Transaction transaction) async {
    return null;
  }
}

class _Transaction implements Transaction {}

class _Page implements Page<Entity> {
  final List<Entity> _items;
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
