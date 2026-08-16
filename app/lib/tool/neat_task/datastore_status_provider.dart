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

/// Task status provider that uses the SQL database and Datastore to load
/// and store the status of the process.
///
/// On a successful [set], the same value is mirrored (best-effort) into Datastore.
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

  late final _runtimeVersionValue = _runtimeVersion(
    _name,
    isRuntimeVersioned: _isRuntimeVersioned,
  );

  @override
  Future<List<int>> get() async {
    final row = await primaryDatabase.transactWithRetry((db) async {
      var row = await db.neatTaskStatuses
          .byKey(_name, _runtimeVersionValue)
          .fetch();
      if (row != null) {
        return row;
      }
      final now = clock.now().toUtc();
      final etag = Ulid().toCanonical();
      row = await db.neatTaskStatuses
          .insertValue(
            taskName: _name,
            runtimeVersion: _runtimeVersionValue,
            status: Uint8List(0),
            etag: etag,
            updatedAt: now,
          )
          .onConflict(.primaryKey)
          .doNothing()
          .returnInserted()
          .executeAndFetch();
      row ??= await db.neatTaskStatuses
          .byKey(_name, _runtimeVersionValue)
          .fetch();
      return row;
    });
    _etag = row!.etag;
    return row.status;
  }

  @override
  Future<bool> set(List<int>? status) async {
    final statusBytes = Uint8List.fromList(status ?? <int>[]);
    final newEtag = Ulid().toCanonical();
    final now = clock.now().toUtc();
    // Sentinel that never matches a real etag, used when this provider has
    // not claimed a row yet (i.e. [get] was never called).
    final previousEtag = _etag ?? '';

    final row = await primaryDatabase.withRetry(
      (db) => db.neatTaskStatuses
          .insertValue(
            taskName: _name,
            runtimeVersion: _runtimeVersionValue,
            status: statusBytes,
            etag: newEtag,
            updatedAt: now,
          )
          .onConflict(.primaryKey)
          .update(
            (_, excluded, set) => set(
              status: excluded.status,
              etag: excluded.etag,
              updatedAt: excluded.updatedAt,
            ),
          )
          .where((existing, _) => existing.etag.equalsValue(previousEtag))
          .returnUpserted()
          .executeAndFetch(),
    );
    if (row != null) {
      _etag = newEtag;
      await _mirrorToDatastore(
        status: statusBytes,
        etag: newEtag,
        updatedAt: now,
      );
      return true;
    } else {
      return false;
    }
  }

  /// Best-effort mirror of the current claim into Datastore.
  Future<void> _mirrorToDatastore({
    required List<int> status,
    required String etag,
    required DateTime updatedAt,
  }) async {
    try {
      final entity =
          NeatTaskStatus.init(_name, isRuntimeVersioned: _isRuntimeVersioned)
            ..statusBase64 = base64.encode(status)
            ..etag = etag
            ..updated = updatedAt;
      await _db.commit(inserts: [entity]);
    } catch (e, st) {
      _logger.warning('Datastore NeatTaskStatus mirror failed: $_id', e, st);
    }
  }
}

/// Deletes old rows that were not updated for more than a month ago.
Future<void> deleteOldNeatTaskStatuses(
  db.DatastoreDB dbService, {
  Duration maxAge = const Duration(days: 30),
}) async {
  final now = clock.now().toUtc();
  final deleteBefore = now.subtract(maxAge);

  var sqlDeleted = 0;
  try {
    final deletedRows = await primaryDatabase.withRetry(
      (db) => db.neatTaskStatuses
          .where((row) => row.updatedAt.isBeforeValue(deleteBefore))
          .delete()
          .returnDeleted()
          .executeAndFetch(),
    );
    sqlDeleted = deletedRows.length;
  } catch (e, st) {
    _logger.warning('SQL NeatTaskStatus cleanup failed.', e, st);
  }

  var datastoreDeleted = 0;
  try {
    final query = dbService.query<NeatTaskStatus>();
    final counts = await dbService.deleteWithQuery<NeatTaskStatus>(
      query,
      where: (status) {
        if (status.updated == null) return true;
        return status.updated!.isBefore(deleteBefore);
      },
    );
    datastoreDeleted = counts.deleted;
  } catch (e, st) {
    _logger.warning('Datastore NeatTaskStatus cleanup failed.', e, st);
  }

  _logger.info(
    'delete-old-neat-task-statuses cleared $sqlDeleted SQL entries and '
    '$datastoreDeleted Datastore entries (${versions.runtimeVersion}).',
  );
}
