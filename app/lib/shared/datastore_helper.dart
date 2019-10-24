import 'package:gcloud/db.dart';
import 'package:retry/retry.dart';

class TransactionWrapper {
  final Transaction _tx;
  bool _mutated = false;

  TransactionWrapper._(this._tx);

  Future<List<T>> lookup<T extends Model>(List<Key> keys) =>
      _tx.lookup<T>(keys);

  Future<T> lookupOrNull<T extends Model>(Key key) =>
      _tx.lookupValue<T>(key, orElse: () => null);

  Future<T> lookupValue<T extends Model>(Key key, {T orElse()}) =>
      _tx.lookupValue<T>(key, orElse: orElse);

  Query<T> query<T extends Model>(Key ancestorKey, {Partition partition}) =>
      _tx.query<T>(ancestorKey, partition: partition);

  void insert(Model entity) => queueMutations(inserts: [entity]);

  void delete(Key key) => queueMutations(deletes: [key]);

  void queueMutations({List<Model> inserts, List<Key> deletes}) {
    _mutated = true;
    _tx.queueMutations(inserts: inserts, deletes: deletes);
  }
}

/// Call [fn] with a [TransactionWrapper] that is either committed or
/// rolled back when [fn] returns.
Future<T> withTransaction<T>(
  DatastoreDB db,
  Future<T> Function(TransactionWrapper) fn,
) async {
  return db.withTransaction<T>((tx) async {
    bool done = false;
    try {
      final wrapper = TransactionWrapper._(tx);
      final retval = await fn(wrapper);
      if (wrapper._mutated) {
        await tx.commit();
        done = true;
      }
      return retval;
    } finally {
      if (!done) {
        await tx.rollback();
      }
    }
  });
}

/// Call [fn] with a [TransactionWrapper] that is either committed or
/// rolled back when [fn] returns, and retried if [fn] fails.
Future<T> withRetryTransaction<T>(
  DatastoreDB db,
  Future<T> Function(TransactionWrapper) fn,
) =>
    retry<T>(() => withTransaction<T>(db, fn));
