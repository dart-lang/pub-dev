// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:ulid/ulid.dart';

import '../../shared/datastore.dart' as db;

@db.Kind(name: 'NeatTaskStatus', idType: db.IdType.String)
class NeatTaskStatus extends db.ExpandoModel<String> {
  String get name => id;

  @db.StringProperty(required: true, indexed: false)
  String etag;

  @db.StringProperty(required: true, indexed: false)
  String statusBase64;
}

/// Task status provider that uses Datastore and [NeatTaskStatus] entries
/// to load and store the status of the process.
class DatastoreStatusProvider extends NeatStatusProvider {
  final db.DatastoreDB _db;
  final String name;
  String _etag;

  DatastoreStatusProvider._(this._db, this.name);

  static NeatStatusProvider create(db.DatastoreDB db, String name) {
    return NeatStatusProvider.withRetry(
      DatastoreStatusProvider._(db, name),
    );
  }

  @override
  Future<List<int>> get() async {
    final key = _db.emptyKey.append(NeatTaskStatus, id: name);

    var e = await _db.lookupValue<NeatTaskStatus>(key, orElse: () => null);
    if (e == null) {
      await db.withRetryTransaction(_db, (tx) async {
        final status = await tx.lookupOrNull<NeatTaskStatus>(key);
        if (status != null) {
          e = status;
          return;
        }
        tx.insert(NeatTaskStatus()
          ..id = name
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
    final key = _db.emptyKey.append(NeatTaskStatus, id: name);
    final newEtag = await db.withRetryTransaction(_db, (tx) async {
      var e = await tx.lookupOrNull<NeatTaskStatus>(key);
      if (e != null && e.etag != _etag) {
        return null;
      }
      e ??= NeatTaskStatus()..id = name;
      e.statusBase64 = base64.encode(status ?? <int>[]);
      e.etag = Ulid().toCanonical();
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
