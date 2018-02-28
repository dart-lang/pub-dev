// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';

import 'backend.dart';

final Logger _logger = new Logger('dartdoc.task_sources');

/// Creates a task when a version uploaded in the past 10 minutes has no
/// dartdoc yet.
class DartdocDatastoreHeadTaskSource extends DatastoreHeadTaskSource {
  DartdocDatastoreHeadTaskSource(DatastoreDB db)
      : super(db, TaskSourceModel.version, skipHistory: true);

  @override
  Future<bool> shouldYieldTask(Task task) async {
    final entry =
        await dartdocBackend.getLatestEntry(task.package, task.version, false);
    return entry == null;
  }
}

/// Creates a task when the most recent dartdoc run is older than
/// [entryUpdateThreshold] days.
class DartdocDatastoreHistoryTaskSource extends DatastoreHistoryTaskSource {
  DartdocDatastoreHistoryTaskSource(DatastoreDB db) : super(db);

  @override
  Future<bool> requiresUpdate(String packageName, String packageVersion,
      {bool retryFailed: false}) async {
    final status = await dartdocBackend.checkTargetStatus(
        packageName, packageVersion, null, retryFailed);
    if (status.shouldSkip) {
      _logger.info(
          'Task source skipping $packageName $packageVersion, reason: ${status.reason}.');
    }
    return !status.shouldSkip;
  }
}
