// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

import '../shared/datastore.dart';

import 'models.dart';

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend =>
    ss.lookup(#_dartdocBackend) as DartdocBackend;

class DartdocBackend {
  final DatastoreDB _db;
  DartdocBackend(this._db);

  /// Scan the Datastore for [DartdocRun]s and remove everything.
  Future<void> deleteDartdocRuns() async {
    final query = _db.query<DartdocRun>();
    await _db.deleteWithQuery(query);
  }
}
