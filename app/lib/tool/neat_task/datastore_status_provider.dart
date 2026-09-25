// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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

/// `neat_periodic_task` statuses are now stored in SQL, this entity is only
/// kept around to delete leftover entities from Datastore.
@db.Kind(name: 'NeatTaskStatus', idType: db.IdType.String)
@Deprecated('No longer in use.')
class NeatTaskStatus extends db.ExpandoModel<String> {}

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

/// Task status provider that uses the SQL database to load and store the
/// status of the process.
class NeatPeriodicTaskStatusProvider extends NeatStatusProvider {
  final String _name;
  final bool _isRuntimeVersioned;
  final String _id;
  String? _etag;

  NeatPeriodicTaskStatusProvider._(this._name, this._isRuntimeVersioned)
    : _id = _compositeId(_name, isRuntimeVersioned: _isRuntimeVersioned);

  static NeatStatusProvider create(
    String name, {
    required bool isRuntimeVersioned,
  }) {
    return NeatStatusProvider.withRetry(
      NeatPeriodicTaskStatusProvider._(name, isRuntimeVersioned),
    );
  }

  late final _runtimeVersionValue = _runtimeVersion(
    _name,
    isRuntimeVersioned: _isRuntimeVersioned,
  );

  @override
  Future<List<int>> get() async {
    var row = await primaryDatabase.withRetry(
      (db) => db.neatTaskStatuses.byKey(_name, _runtimeVersionValue).fetch(),
    );
    if (row == null) {
      final now = clock.now().toUtc();
      final etag = Ulid().toBase32(lowercase: true);
      row = await primaryDatabase.withRetry((db) async {
        final inserted = await db.neatTaskStatuses
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
        return inserted ??
            await db.neatTaskStatuses
                .byKey(_name, _runtimeVersionValue)
                .fetch();
      });
    }
    if (row == null) {
      throw StateError('Failed to initialize NeatTaskStatus row: $_id');
    }
    _etag = row.etag;
    return row.status;
  }

  @override
  Future<bool> set(List<int>? status) async {
    final statusBytes = Uint8List.fromList(status ?? <int>[]);
    final newEtag = Ulid().toBase32(lowercase: true);
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
          .where(
            (existing, _) =>
                existing.etag.equalsValue(previousEtag) |
                existing.etag.equalsValue(newEtag),
          )
          .returnUpserted()
          .executeAndFetch(),
    );
    if (row != null) {
      _etag = newEtag;
      return true;
    } else {
      return false;
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

  _logger.info(
    'delete-old-neat-task-statuses cleared $sqlDeleted SQL entries.',
  );
}
