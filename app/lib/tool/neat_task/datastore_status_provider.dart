// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:ulid/ulid.dart';

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
        runtimeVersion =
            _runtimeVersion(name, isRuntimeVersioned: isRuntimeVersioned),
        updated = clock.now().toUtc() {
    // Not in initializer list as id is declared in a super class.
    id = _compositeId(name, isRuntimeVersioned: isRuntimeVersioned);
  }
}

String _runtimeVersion(String name, {required bool isRuntimeVersioned}) {
  return isRuntimeVersioned ? versions.runtimeVersion : '-';
}

String _compositeId(String name, {required bool isRuntimeVersioned}) {
  final runtimeVersion =
      _runtimeVersion(name, isRuntimeVersioned: isRuntimeVersioned);
  return '$runtimeVersion/$name';
}

/// Task status provider that uses Datastore and [NeatTaskStatus] entries
/// to load and store the status of the process.
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
        DatastoreStatusProvider._(db, name, isRuntimeVersioned));
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
              ..statusBase64 = base64.encode(<int>[]));
      });
      e ??= await _db.lookupOrNull<NeatTaskStatus>(key);
    }
    _etag = e!.etag;
    return base64.decode(e!.statusBase64!);
  }

  @override
  Future<bool> set(List<int>? status) async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: _id);
    final newEtag = await db.withRetryTransaction(_db, (tx) async {
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
  final now = clock.now().toUtc();
  final count = await dbService.deleteWithQuery<NeatTaskStatus>(
    query,
    where: (status) {
      if (status.updated == null) return true;
      final diff = now.difference(status.updated!);
      return diff > maxAge;
    },
  );
  _logger.info(
      'delete-old-neat-task-statuses cleared $count entries (${versions.runtimeVersion}).');
}
