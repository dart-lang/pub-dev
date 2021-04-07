// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:ulid/ulid.dart';

import '../../shared/datastore.dart' as db;
import '../../shared/versions.dart' show runtimeVersion;

/// Tracks the status of the task.
///
/// The `id` of the entity is either `global/name` or `scope/name`.
@db.Kind(name: 'NeatTaskStatus', idType: db.IdType.String)
class NeatTaskStatus extends db.ExpandoModel<String> {
  /// The name of the task.
  @db.StringProperty()
  String name;

  /// The scope of the task.
  ///
  /// TODO: cleanup entities without scope or name
  /// TODO: make scope and name required: true
  @db.StringProperty()
  String scope;

  @db.StringProperty(required: true, indexed: false)
  String etag;

  @db.StringProperty(required: true, indexed: false)
  String statusBase64;

  @db.DateTimeProperty()
  DateTime updated;

  NeatTaskStatus();

  NeatTaskStatus.init(this.name, this.scope) {
    scope ??= 'global';
    id = '$scope/$name';
    updated = DateTime.now().toUtc();
  }
}

/// Task status provider that uses Datastore and [NeatTaskStatus] entries
/// to load and store the status of the process.
class DatastoreStatusProvider extends NeatStatusProvider {
  final db.DatastoreDB _db;
  final String _name;
  final String _scope;
  String _id;
  String _etag;

  DatastoreStatusProvider._(this._db, this._name, String scope)
      : _scope = scope ?? 'global' {
    _id = '$_scope/$_name';
  }

  static NeatStatusProvider create(
    db.DatastoreDB db,
    String name, {
    @required bool isRuntimeVersioned,
  }) {
    return NeatStatusProvider.withRetry(
      DatastoreStatusProvider._(
          db, name, isRuntimeVersioned ? runtimeVersion : null),
    );
  }

  @override
  Future<List<int>> get() async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: _id);

    var e = await _db.lookupValue<NeatTaskStatus>(key, orElse: () => null);
    if (e == null) {
      await db.withRetryTransaction(_db, (tx) async {
        final status = await tx.lookupOrNull<NeatTaskStatus>(key);
        if (status != null) {
          e = status;
          return;
        }
        tx.insert(NeatTaskStatus.init(_name, _scope)
          ..etag = Ulid().toCanonical()
          ..statusBase64 = base64.encode(<int>[]));
      });
      e ??= await _db.lookupValue<NeatTaskStatus>(key, orElse: () => null);
    }
    _etag = e.etag;
    return base64.decode(e.statusBase64);
  }

  @override
  Future<bool> set(List<int> status) async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: _id);
    final newEtag = await db.withRetryTransaction(_db, (tx) async {
      var e = await tx.lookupOrNull<NeatTaskStatus>(key);
      if (e != null && e.etag != _etag) {
        return null;
      }
      e ??= NeatTaskStatus.init(_name, _scope);
      e
        ..statusBase64 = base64.encode(status ?? <int>[])
        ..etag = Ulid().toCanonical()
        ..updated = DateTime.now().toUtc();
      tx.insert(e);
      return e.etag;
    });
    if (newEtag != null) {
      _etag = newEtag;
      return true;
    } else {
      return false;
    }
  }
}

/// Deletes old entities in datastore that were not updated for
/// more than a month ago.
Future<void> deleteOldNeatTaskStatuses(
  db.DatastoreDB dbService, {
  Duration maxAge = const Duration(days: 30),
}) async {
  final query = dbService.query<NeatTaskStatus>();
  final now = DateTime.now().toUtc();
  await dbService.deleteWithQuery<NeatTaskStatus>(query, where: (status) {
    // TODO: once a month passed after the release of this feature, delete these too.
    if (status.updated == null) return false;

    final diff = now.difference(status.updated);
    return diff > maxAge;
  });
}
