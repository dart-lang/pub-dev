// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';

import '../shared/datastore.dart';
import 'models.dart';

/// Sets the history backend.
void registerHistoryBackend(HistoryBackend backend) =>
    ss.register(#_historyBackend, backend);

/// The active history backend.
HistoryBackend get historyBackend =>
    ss.lookup(#_historyBackend) as HistoryBackend;

/// Stores and queries [History] entries.
class HistoryBackend {
  final DatastoreDB _db;
  HistoryBackend(this._db);

  /// Store a history [event]. When storing is not enabled, this will only log
  /// the method call, and not store the entry in Datastore.
  Future<String> storeEvent(HistoryEvent event) async {
    final history = History.entry(event);
    await _db.commit(inserts: [history]);
    return history.id;
  }

  Stream<History> getAll({
    @required String packageName,
    @required String packageVersion,
    int limit,
  }) {
    final query = _db.query<History>()
      ..filter('packageName =', packageName)
      ..filter('packageVersion =', packageVersion)
      ..order('-timestamp');
    if (limit != null && limit > 0) {
      query.limit(limit);
    }
    return query.run();
  }
}
