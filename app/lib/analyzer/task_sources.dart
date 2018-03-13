// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import '../shared/analyzer_service.dart' show AnalysisStatus;
import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';
import '../shared/utils.dart';
import '../shared/versions.dart';

import 'backend.dart' show reanalyzeThreshold;
import 'models.dart';

/// Creates a task when a version uploaded in the past 10 minutes has no
/// analysis yet.
class AnalyzerDatastoreHeadTaskSource extends DatastoreHeadTaskSource {
  final DatastoreDB _db;
  AnalyzerDatastoreHeadTaskSource(DatastoreDB db)
      : _db = db,
        super(db, TaskSourceModel.version, skipHistory: true);

  @override
  Future<bool> shouldYieldTask(Task task) async {
    final List<PackageVersionAnalysis> items = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: task.package)
          .append(PackageVersionAnalysis, id: task.version)
    ]);
    return items.first == null;
  }
}

/// Creates a task when the most recent analysis is older than
/// [reanalyzeThreshold] days.
class AnalyzerDatastoreHistoryTaskSource extends DatastoreHistoryTaskSource {
  final DatastoreDB _db;

  AnalyzerDatastoreHistoryTaskSource(DatastoreDB db)
      : _db = db,
        super(db);

  @override
  Future<bool> requiresUpdate(String packageName, String packageVersion,
      {bool retryFailed: false}) async {
    final List<PackageVersionAnalysis> list = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: packageName)
          .append(PackageVersionAnalysis, id: packageVersion)
    ]);
    final PackageVersionAnalysis version = list.first;
    if (version == null) return true;

    if (isNewer(version.semanticRuntimeVersion, semanticRuntimeVersion)) {
      return true;
    }

    final Duration diff =
        new DateTime.now().toUtc().difference(version.analysisTimestamp);
    if (diff >= reanalyzeThreshold) return true;

    if (retryFailed &&
        version.analysisStatus != AnalysisStatus.success &&
        diff.inDays >= 1) {
      return true;
    }

    return false;
  }
}
