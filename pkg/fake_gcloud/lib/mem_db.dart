import 'dart:mirrors';

import 'package:gcloud/datastore.dart' as ds;
import 'package:gcloud/db.dart';

import 'src/cloner.dart';

/// Implementation of [DatastoreDB] interface with in-memory storage.
///
/// Entities are cloned, and should be safe to modify them once they are stored
/// or read.
class MemDatastoreDB implements DatastoreDB {
  final _defaultPartition = Partition(null);
  final _entities = <Key, Model>{};
  final _cloner = Cloner(immutableTypes: [Key]);

  @override
  ds.Datastore get datastore => throw UnimplementedError();

  @override
  ModelDB get modelDB => throw UnimplementedError();

  @override
  Key get emptyKey => defaultPartition.emptyKey;

  @override
  Partition get defaultPartition => _defaultPartition;

  @override
  Partition newPartition(String namespace) => Partition(namespace);

  @override
  Future withTransaction(TransactionHandler transactionHandler) async {
    return await transactionHandler(_Transaction(this));
  }

  @override
  Future<List<T>> lookup<T extends Model>(List<Key> keys) async {
    return keys.map((k) => _cloner.clone(_entities[k])).cast<T>().toList();
  }

  @override
  Future commit({List<Model> inserts, List<Key> deletes}) async {
    await withTransaction((tx) async {
      tx.queueMutations(inserts: inserts, deletes: deletes);
      await tx.commit();
    });
  }

  @override
  Query<T> query<T extends Model>({Partition partition, Key ancestorKey}) {
    return _Query<T>(this, partition, ancestorKey);
  }
}

class _Transaction implements Transaction {
  final MemDatastoreDB _db;
  final _inserts = <Model>[];
  final _deletes = <Key>[];

  _Transaction(this._db);

  @override
  DatastoreDB get db => _db;

  @override
  Future<List<T>> lookup<T extends Model>(List<Key> keys) async {
    return keys
        .map((k) => _db._cloner.clone(_db._entities[k]))
        .cast<T>()
        .toList();
  }

  @override
  Query<T> query<T extends Model>(Key ancestorKey, {Partition partition}) {
    return _Query<T>(_db, partition, ancestorKey);
  }

  @override
  void queueMutations({List<Model> inserts, List<Key> deletes}) {
    _inserts.addAll(inserts ?? []);
    _deletes.addAll(deletes ?? []);
  }

  @override
  Future commit() async {
    _inserts.forEach((m) => _db._entities[m.key] = _db._cloner.clone(m));
    _deletes.forEach((k) => _db._entities.remove(k));
  }

  @override
  Future rollback() async {
    _inserts.clear();
    _deletes.clear();
  }
}

typedef bool FilterFn(Model model);

class _Query<T extends Model> implements Query<T> {
  final MemDatastoreDB _db;
  final Partition _partition;
  final Key _ancestorKey;
  int _limit = 0;
  int _offset = 0;
  String _orderByField;
  bool _orderByAsc = true;
  final _filters = <FilterFn>[];

  _Query(this._db, this._partition, this._ancestorKey);

  @override
  void filter(String filterString, Object comparisonObject) {
    final fieldName = filterString.split(' ').first;
    final compareStr = filterString.split(' ').last;
    final fn = _compareFns[compareStr];
    if (fn == null) {
      throw UnimplementedError('$compareStr not supported.');
    }
    _filters.add((model) {
      final im = reflect(model);
      final v = im.getField(Symbol(fieldName)).reflectee;
      if (v == null) return false;
      final c =
          Comparable.compare(v as Comparable, comparisonObject as Comparable);
      return fn(c);
    });
  }

  @override
  void limit(int limit) {
    _limit = limit;
  }

  @override
  void offset(int offset) {
    _offset = offset;
  }

  @override
  void order(String orderString) {
    if (orderString.startsWith('-')) {
      _orderByAsc = false;
      orderString = orderString.substring(1).trim();
    }
    _orderByField = orderString;
  }

  @override
  Stream<T> run() async* {
    final results = <T>[];
    for (Model m in _db._entities.values) {
      if (m is! T) continue;
      if (_partition != null && m.key.partition != _partition) continue;
      if (_ancestorKey != null && m.parentKey != _ancestorKey) continue;
      if (_filters.any((fn) => !fn(m))) continue;
      results.add(m as T);
    }
    if (_orderByField != null) {
      final fieldName = Symbol(_orderByField);
      results.sort((m1, m2) {
        final f1 = reflect(m1).getField(fieldName).reflectee;
        final f2 = reflect(m2).getField(fieldName).reflectee;
        final c = Comparable.compare(f1 as Comparable, f2 as Comparable);
        return _orderByAsc ? c : -c;
      });
    }
    if (_offset > 0) {
      results.removeRange(0, _offset);
    }
    if (_limit > 0) {
      results.removeRange(_limit, results.length);
    }
    for (T t in results) {
      yield _db._cloner.clone(t);
    }
  }
}

typedef bool _CompareFn(int c);
final _compareFns = <String, _CompareFn>{
  '=': (int c) => c == 0,
  '<': (int c) => c < 0,
  '<=': (int c) => c <= 0,
  '>': (int c) => c > 0,
  '>=': (int c) => c >= 0,
};
