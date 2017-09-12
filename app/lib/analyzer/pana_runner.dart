// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';

import '../shared/analyzer_service.dart';
import '../shared/configuration.dart';
import '../shared/notification.dart';
import '../shared/task_scheduler.dart' show Task, TaskRunner;

import 'backend.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.analyzer.pana');

class PanaRunner implements TaskRunner {
  final AnalysisBackend _analysisBackend;

  PanaRunner(this._analysisBackend);

  @override
  Future<bool> hasCompletedRecently(Task task) async {
    return !(await _analysisBackend.isValidTarget(task.package, task.version));
  }

  @override
  Future<bool> runTask(Task task) async {
    Summary summary;
    Directory tempDir;
    try {
      tempDir = await Directory.systemTemp.createTemp('pana');
      final pubCacheDir = await tempDir.resolveSymbolicLinks();
      final PackageAnalyzer analyzer = new PackageAnalyzer(
        flutterDir: envConfig.flutterSdkDir,
        pubCacheDir: pubCacheDir,
      );
      summary = await analyzer.inspectPackage(
        task.package,
        version: task.version,
        keepTransitiveLibs: true, // TODO: decide if this is really needed
      );
    } catch (e, st) {
      _logger.severe('Pana execution failed.', e, st);
    } finally {
      if (tempDir != null) {
        await tempDir.delete(recursive: true);
      }
    }

    final Analysis analysis = new Analysis.init(task.package, task.version);

    if (summary == null) {
      analysis.analysisStatus = AnalysisStatus.aborted;
    } else {
      if (summary.toolProblems == null || summary.toolProblems.isEmpty) {
        analysis.analysisStatus = AnalysisStatus.success;
      } else {
        analysis.analysisStatus = AnalysisStatus.failure;
      }
      analysis.analysisJson = summary.toJson();
    }

    final backendStatus = await _analysisBackend.storeAnalysis(analysis);

    if (backendStatus.isNewVersion) {
      // TODO: trigger re-analysis of packages depending on this one
    }

    if (backendStatus.isLatestStable) {
      // Do not await on the notification.
      notificationClient.notifySearch(analysis.packageName);
    }

    return backendStatus.wasRace;
  }
}
