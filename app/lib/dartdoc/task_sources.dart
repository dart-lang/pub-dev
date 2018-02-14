// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';

/// Creates a task when a version uploaded in the past 10 minutes has no
/// dartdoc yet.
class DartdocDatastoreHeadTaskSource extends DatastoreHeadTaskSource {
  DartdocDatastoreHeadTaskSource(DatastoreDB db)
      : super(db, TaskSourceModel.version, skipHistory: true);

  @override
  Future<bool> shouldYieldTask(Task task) async {
    // TODO: implement using the bucket-based backend.
    return false;
  }
}

/// Creates a task when the most recent dartdoc run is older than 30 days.
class DartdocDatastoreHistoryTaskSource extends DatastoreHistoryTaskSource {
  DartdocDatastoreHistoryTaskSource(DatastoreDB db) : super(db, afterDays: 30);

  @override
  Future<bool> requiresUpdate(String packageName, String packageVersion,
      {bool retryFailed: false}) async {
    // TODO: implement using the bucket-based backend.
    return false;
  }
}
