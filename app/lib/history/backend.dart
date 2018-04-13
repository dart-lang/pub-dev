// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

const String _latest = 'latest';

/// Sets the history backend.
void registerHistoryBackend(HistoryBackend backend) =>
    ss.register(#_historyBackend, backend);

/// The active history backend.
HistoryBackend get historyBackend => ss.lookup(#_historyBackend);

final _uuid = new Uuid();

class HistoryBackend {
  final DatastoreDB _db;
  HistoryBackend(this._db);

  Future store({
    @required String package,
    String version: _latest,
    DateTime timestamp,
    @required String source,
    @required String type,
    Map<String, dynamic> paramsMap,
  }) async {
    final history = new History(
      id: _uuid.v4(),
      packageName: package,
      packageVersion: version,
      timestamp: timestamp,
      source: source,
      type: type,
      paramsMap: paramsMap,
    );
    await _db.withTransaction((tx) async {
      tx.queueMutations(inserts: [history]);
      await tx.commit();
    });
  }
}
