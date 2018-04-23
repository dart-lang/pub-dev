// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';

import 'models.dart';

/// Sets the history backend.
void registerHistoryBackend(HistoryBackend backend) =>
    ss.register(#_historyBackend, backend);

/// The active history backend.
HistoryBackend get historyBackend => ss.lookup(#_historyBackend);

class HistoryBackend {
  final DatastoreDB _db;
  HistoryBackend(this._db);

  Future store(History history) async {
    await _db.withTransaction((tx) async {
      tx.queueMutations(inserts: [history]);
      await tx.commit();
    });
  }

  Future<List<History>> latest({
    @required String scope,
    @required String packageName,
    String packageVersion,
    int limit: 25,
  }) async {
    final query = _db.query(History)
      ..filter('scope =', scope)
      ..filter('packageName =', packageName)
      ..order('-timestamp')
      ..limit(limit);
    if (packageVersion != null) {
      query.filter('packageVersion =', packageVersion);
    }
    return query.run().map((m) => m as History).toList();
  }
}
