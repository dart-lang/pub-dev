// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

import '../shared/datastore.dart' as db;

import 'model.dart';

export 'model.dart';

typedef ShouldProcess = Future<bool> Function(
    String package, String version, DateTime updated);

/// Sets the active job backend.
void registerJobBackend(JobBackend backend) =>
    ss.register(#_job_backend, backend);

/// The active job backend.
JobBackend get jobBackend => ss.lookup(#_job_backend) as JobBackend;

class JobBackend {
  final db.DatastoreDB _db;

  JobBackend(this._db);

  /// Deletes the old entries.
  Future<void> deleteOldEntries() async {
    await _db.deleteWithQuery<Job>(_db.query<Job>());
  }
}
