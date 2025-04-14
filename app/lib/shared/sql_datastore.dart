// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart';

/// WARNING: This class is not for production use yet.
class SqlDatastore implements Datastore {
  @override
  Future<List<Key>> allocateIds(List<Key> keys) async {
    throw UnimplementedError();
  }

  @override
  Future<Transaction> beginTransaction({bool crossEntityGroup = false}) async {
    return _Transaction();
  }

  @override
  Future rollback(Transaction transaction) async {
    // no-op
  }

  @override
  Future<List<Entity?>> lookup(
    List<Key> keys, {
    Transaction? transaction,
  }) async {
    return await Future.wait(
        keys.map((k) async => await _lookup(k, transaction)));
  }

  Future<Entity?> _lookup(Key key, Transaction? transaction) async {
    if (_isPackageState(key)) {
      // final stateId = key.elements.single.id as String;
      // TODO: store in the transaction object that the entry exists
      //
      // TODO: if (transaction != null) also add FOR UPDATE clause
      // final row = await _db.packageStates.byKey(stateId: stateId);
      //
      // return row == null ? : _packageStateRowToEntity(row);
    }
    throw UnimplementedError();
  }

  @override
  Future<Page<Entity>> query(
    Query query, {
    Partition? partition,
    Transaction? transaction,
  }) async {
    if (query.kind == 'PackageState') {
      // TODO: build query
      // TODO: run query with limit + offset
      // TODO: transform rows + build nextFn
      // TODO: store in the transaction object that the entry exists
    }
    throw UnimplementedError();
  }

  @override
  Future<CommitResult> commit({
    List<Entity> inserts = const [],
    List<Entity> autoIdInserts = const [],
    List<Key> deletes = const [],
    Transaction? transaction,
  }) async {
    if (autoIdInserts.isNotEmpty) {
      throw UnimplementedError();
    }
    for (final key in deletes) {
      if (_isPackageState(key)) {
        // final stateId = key.elements.single.id as String;
        // await _db.packageStates.delete(state_id: stateId).execute();
        continue;
      }
      throw UnimplementedError();
    }

    for (final entity in inserts) {
      if (_isPackageState(entity.key)) {
        // final stateId = key.elements.single.id as String;
        // TODO: use the transaction object if the entity exists or use lookup or upsert
        // await _db.packageStates.insert(stateId: stateId, ...).execute();
        continue;
      }
      throw UnimplementedError();
    }

    throw UnimplementedError();
  }
}

class _Transaction implements Transaction {}

class _Page implements Page<Entity> {
  @override
  final List<Entity> items;

  @override
  final bool isLast;

  final Future<Page<Entity>> Function({int? pageSize}) _nextFn;

  _Page(this.items, this.isLast, this._nextFn);

  @override
  Future<Page<Entity>> next({int? pageSize}) async {
    return _nextFn(pageSize: pageSize);
  }
}

bool _isPackageState(Key key) {
  return (key.elements.length == 1 &&
      key.elements.single.kind == 'PackageState');
}

Entity _packageStateRowToEntity(PackageStateRow row) {
  return Entity(
      Key([
        KeyElement('PackageState', '${row.runtime_version}/${row.package}')
      ]),
      {
        'runtimeVersion': row.runtime_version,
        'versions': json.encode(row.versions_blob),
        'abortedTokens': null,
        'pendingAt': null,
        'dependencies': null,
        'lastDependencyChanged': null,
        'finished': null,
      });
}

abstract class PackageStateRow {
  String get runtime_version;
  String get package;
  Map<String, dynamic> get versions_blob;
}
