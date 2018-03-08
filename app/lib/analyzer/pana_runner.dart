// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';
import 'package:pana/src/version.dart';

import '../shared/analyzer_service.dart';
import '../shared/configuration.dart';
import '../shared/task_scheduler.dart';
import '../shared/utils.dart';

import 'backend.dart';
import 'models.dart';

final Logger _logger = new Logger('pub.analyzer.pana');

class PanaRunner implements TaskRunner {
  final AnalysisBackend _analysisBackend;

  PanaRunner(this._analysisBackend);

  @override
  Future<TaskTargetStatus> checkTargetStatus(Task task) {
    return _analysisBackend.checkTargetStatus(
        task.package, task.version, task.updated);
  }

  @override
  Future<bool> runTask(Task task) async {
    final packageStatus =
        await _analysisBackend.getPackageStatus(task.package, task.version);
    if (!packageStatus.exists) {
      _logger.info('Package does not exists: $task.');
      return false;
    }

    try {
      await _analysisBackend.deleteObsoleteAnalysis(task.package, task.version);
    } catch (e) {
      _logger.warning('Analysis GC failed: $task', e);
    }

    final DateTime timestamp = new DateTime.now().toUtc();
    final Analysis analysis =
        new Analysis.init(task.package, task.version, timestamp);

    if (packageStatus.isDiscontinued) {
      _logger.info('Package is discontinued: $task.');
      analysis.analysisStatus = AnalysisStatus.discontinued;
      analysis.maintenanceScore = 0.0;
      final backendStatus = await _analysisBackend.storeAnalysis(analysis);
      return backendStatus.wasRace;
    }

    final Duration age = timestamp.difference(packageStatus.publishDate).abs();
    if (age > twoYears && !packageStatus.isLatestStable) {
      _logger.info(
          'Package is older than two years and has newer release: $task.');
      analysis.analysisStatus = AnalysisStatus.outdated;
      analysis.maintenanceScore = 0.0;
      final backendStatus = await _analysisBackend.storeAnalysis(analysis);
      return backendStatus.wasRace;
    }

    Future<Summary> analyze() async {
      Directory tempDir;
      try {
        tempDir = await Directory.systemTemp.createTemp('pana');
        final pubCacheDir = await tempDir.resolveSymbolicLinks();
        final PackageAnalyzer analyzer = await PackageAnalyzer.create(
          flutterDir: envConfig.flutterSdkDir,
          pubCacheDir: pubCacheDir,
        );
        return await analyzer.inspectPackage(
          task.package,
          version: task.version,
          keepTransitiveLibs: false,
          logger: new Logger.detached('pana/${task.package}/${task.version}'),
        );
      } catch (e, st) {
        _logger.severe(
            'Failed (v$panaPkgVersion) - ${task.package}/${task.version}',
            e,
            st);
      } finally {
        if (tempDir != null) {
          await tempDir.delete(recursive: true);
        }
      }
      return null;
    }

    Summary summary = await analyze();
    final bool firstRunWithErrors =
        summary?.suggestions?.where((s) => s.isError)?.isNotEmpty ?? false;
    if (summary == null || firstRunWithErrors) {
      _logger.info('Retrying $task...');
      await new Future.delayed(new Duration(seconds: 15));
      summary = await analyze();
    }

    if (summary == null) {
      analysis.analysisStatus = AnalysisStatus.aborted;
    } else {
      final bool lastRunWithErrors =
          summary?.suggestions?.where((s) => s.isError)?.isNotEmpty ?? false;
      if (!lastRunWithErrors) {
        analysis.analysisStatus = AnalysisStatus.success;
      } else {
        analysis.analysisStatus = AnalysisStatus.failure;
      }
      analysis.analysisJson = summary.toJson();
      analysis.maintenanceScore =
          summary?.maintenance?.getMaintenanceScore(age: age);
    }

    final backendStatus = await _analysisBackend.storeAnalysis(analysis);

    if (backendStatus.isLatestStable &&
        analysis.analysisStatus != AnalysisStatus.success &&
        analysis.analysisStatus != AnalysisStatus.discontinued) {
      reportIssueWithLatest('analyzer', task, '${analysis.analysisStatus}');
    }

    return backendStatus.wasRace;
  }
}
