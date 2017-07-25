// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pana/pana.dart';

import '../shared/analyzer_service.dart';
import '../shared/configuration.dart';
import '../shared/task_scheduler.dart' show Task;

import 'backend.dart';
import 'models.dart';
import 'versions.dart';

final Logger _logger = new Logger('pub.analyzer.pana');

class PanaRunner {
  final AnalysisBackend _analysisBackend;

  PanaRunner(this._analysisBackend);

  Future runTask(Task task) async {
    if (!await _analysisBackend.isValidTarget(task.package, task.version)) {
      _logger.info('Skipping task: $task');
      return;
    }

    Summary summary;
    try {
      final PackageAnalyzer analyzer =
          new PackageAnalyzer(flutterDir: envConfig.flutterSdkDir);
      summary = await analyzer.inspectPackage(
        task.package,
        version: task.version,
        keepTransitiveLibs: true, // TODO: decide if this is really needed
      );
    } catch (e, st) {
      _logger.severe('Pana execution failed.', e, st);
    }

    final Analysis analysis = new Analysis.init(task.package, task.version)
      ..timestamp = new DateTime.now().toUtc()
      ..panaVersion = panaVersion
      ..flutterVersion = flutterVersion;

    if (summary == null) {
      analysis.analysisStatus = AnalysisStatus.aborted;
    } else {
      if (summary.issues == null || summary.issues.isEmpty) {
        analysis.analysisStatus = AnalysisStatus.success;
      } else {
        analysis.analysisStatus = AnalysisStatus.failure;
      }
      analysis.analysisJson = summary.toJson();
    }

    await _analysisBackend.storeAnalysis(analysis);
  }
}
