// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:typed_sql/typed_sql.dart';
import 'package:ulid/ulid.dart';

import '../../database/database.dart';
import '../../database/schema.dart';
import '../../shared/datastore.dart' as db;
import '../../shared/versions.dart' as versions show runtimeVersion;

final _logger = Logger('datastore_neat_status_provider');

/// Tracks the status of the task.
///
/// The `id` of the entity is either `global/name` or `scope/name`.
@db.Kind(name: 'NeatTaskStatus', idType: db.IdType.String)
class NeatTaskStatus extends db.ExpandoModel<String> {
  /// The name of the task.
  @db.StringProperty()
  String? name;

  /// The runtimeVersion of the task.
  /// Tasks the work on non-versioned data should use '-' as a value.
  ///
  /// TODO: cleanup entities without scope or name
  /// TODO: make scope and name required: true
  @db.StringProperty()
  String? runtimeVersion;

  @db.StringProperty(required: true, indexed: false)
  String? etag;

  @db.StringProperty(required: true, indexed: false)
  String? statusBase64;

  @db.DateTimeProperty()
  DateTime? updated;

  NeatTaskStatus();

  NeatTaskStatus.init(String name, {required bool isRuntimeVersioned})
    // ignore: prefer_initializing_formals
    : name = name,
      runtimeVersion = _runtimeVersion(
        name,
        isRuntimeVersioned: isRuntimeVersioned,
      ),
      updated = clock.now().toUtc() {
    // Not in initializer list as id is declared in a super class.
    id = _compositeId(name, isRuntimeVersioned: isRuntimeVersioned);
  }
}

String _runtimeVersion(String name, {required bool isRuntimeVersioned}) {
  return isRuntimeVersioned ? versions.runtimeVersion : '-';
}

String _compositeId(String name, {required bool isRuntimeVersioned}) {
  final runtimeVersion = _runtimeVersion(
    name,
    isRuntimeVersioned: isRuntimeVersioned,
  );
  return '$runtimeVersion/$name';
}

/// Task status provider that uses Datastore and [NeatTaskStatus] entries
/// to load and store the status of the process.
///
/// Datastore remains the authority for claiming tasks: [set] performs its
/// optimistic-concurrency check against Datastore only. On a successful
/// [set], the same value is mirrored (best-effort) into the SQL database, so
/// that the runtime-independent task state is present on a later switch.
class DatastoreStatusProvider extends NeatStatusProvider {
  final db.DatastoreDB _db;
  final String _name;
  final bool _isRuntimeVersioned;
  final String _id;
  String? _etag;

  DatastoreStatusProvider._(this._db, this._name, this._isRuntimeVersioned)
    : _id = _compositeId(_name, isRuntimeVersioned: _isRuntimeVersioned);

  static NeatStatusProvider create(
    db.DatastoreDB db,
    String name, {
    required bool isRuntimeVersioned,
  }) {
    return NeatStatusProvider.withRetry(
      DatastoreStatusProvider._(db, name, isRuntimeVersioned),
    );
  }

  @override
  Future<List<int>> get() async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: _id);

    var e = await _db.lookupOrNull<NeatTaskStatus>(key);
    if (e == null) {
      await db.withRetryTransaction(_db, (tx) async {
        final status = await tx.lookupOrNull<NeatTaskStatus>(key);
        if (status != null) {
          e = status;
          return;
        }
        tx.insert(
          NeatTaskStatus.init(_name, isRuntimeVersioned: _isRuntimeVersioned)
            ..etag = Ulid().toCanonical()
            ..statusBase64 = base64.encode(<int>[]),
        );
      });
      e ??= await _db.lookupOrNull<NeatTaskStatus>(key);
    }
    _etag = e!.etag;
    return base64.decode(e!.statusBase64!);
  }

  @override
  Future<bool> set(List<int>? status) async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: _id);
    final claimed = await db.withRetryTransaction(_db, (tx) async {
      var e = await tx.lookupOrNull<NeatTaskStatus>(key);
      if (e != null && e.etag != _etag) {
        return null;
      }
      e ??= NeatTaskStatus.init(_name, isRuntimeVersioned: _isRuntimeVersioned);
      e
        ..statusBase64 = base64.encode(status ?? <int>[])
        ..etag = Ulid().toCanonical()
        ..updated = clock.now().toUtc();
      tx.insert(e);
      return (etag: e.etag!, updated: e.updated!);
    });
    if (claimed != null) {
      _etag = claimed.etag;
      await _mirrorToSql(
        status: status ?? <int>[],
        etag: claimed.etag,
        updatedAt: claimed.updated,
      );
      return true;
    } else {
      return false;
    }
  }

  /// Best-effort mirror of the current claim into the SQL database.
  Future<void> _mirrorToSql({
    required List<int> status,
    required String etag,
    required DateTime updatedAt,
  }) async {
    try {
      await _writeNeatTaskStatusToSql(
        name: _name,
        runtimeVersion: _runtimeVersion(
          _name,
          isRuntimeVersioned: _isRuntimeVersioned,
        ),
        status: status,
        etag: etag,
        updatedAt: updatedAt,
      );
    } catch (e, st) {
      _logger.warning('SQL NeatTaskStatus mirror failed: $_id', e, st);
    }
  }
}

Future<void> _writeNeatTaskStatusToSql({
  required String name,
  required String runtimeVersion,
  required List<int> status,
  required String etag,
  required DateTime updatedAt,
}) async {
  final statusBytes = Uint8List.fromList(status);
  await primaryDatabase.transactWithRetry((db) async {
    // TODO: consider supporting a generated `upsertValue()` in typed_sql
    await db.neatTaskStatuses
        .insertValue(
          taskName: name,
          runtimeVersion: runtimeVersion,
          status: statusBytes,
          etag: etag,
          updatedAt: updatedAt,
        )
        .onConflict(.primaryKey)
        .update(
          (_, _, set) => set(
            status: statusBytes.asExpr,
            etag: etag.asExpr,
            updatedAt: updatedAt.asExpr,
          ),
        )
        .execute();
  });
}

/// Deletes old entities in datastore that were not updated for
/// more than a month ago.
Future<void> deleteOldNeatTaskStatuses(
  db.DatastoreDB dbService, {
  Duration maxAge = const Duration(days: 30),
}) async {
  final query = dbService.query<NeatTaskStatus>();
  final now = clock.now().toUtc();
  final deleteBefore = now.subtract(maxAge);
  final count = await dbService.deleteWithQuery<NeatTaskStatus>(
    query,
    where: (status) {
      if (status.updated == null) return true;
      return status.updated!.isBefore(deleteBefore);
    },
    beforeDelete: (values) {
      for (final status in values) {
        final name = status.name;
        final runtimeVersion = status.runtimeVersion;
        if (name != null && runtimeVersion != null) {}
      }
    },
  );
  await primaryDatabase.withRetry((db) async {
    await db.neatTaskStatuses
        .where((row) => row.updatedAt.isBeforeValue(deleteBefore))
        .delete()
        .execute();
  });
  _logger.info(
    'delete-old-neat-task-statuses cleared $count entries (${versions.runtimeVersion}).',
  );
}
