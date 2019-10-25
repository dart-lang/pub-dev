// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:retry/retry.dart';

/// Wrap [Transaction] to avoid exposing [Transaction.commit] and
/// [Transaction.rollback].
class TransactionWrapper {
  final Transaction _tx;
  bool _mutated = false;

  TransactionWrapper._(this._tx);

  /// See [Transaction.lookup].
  Future<List<T>> lookup<T extends Model>(List<Key> keys) =>
      _tx.lookup<T>(keys);

  /// [lookupValue] or return `null`.
  Future<T> lookupOrNull<T extends Model>(Key key) =>
      _tx.lookupValue<T>(key, orElse: () => null);

  /// See [Transaction.lookupValue].
  Future<T> lookupValue<T extends Model>(Key key, {T orElse()}) =>
      _tx.lookupValue<T>(key, orElse: orElse);

  /// See [Transaction.query].
  Query<T> query<T extends Model>(Key ancestorKey, {Partition partition}) =>
      _tx.query<T>(ancestorKey, partition: partition);

  /// Insert [entity] in this transaction.
  void insert(Model entity) => queueMutations(inserts: [entity]);

  /// Delete entity at [key] in this transaction.
  void delete(Key key) => queueMutations(deletes: [key]);

  /// See [Transaction.queueMutations].
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
