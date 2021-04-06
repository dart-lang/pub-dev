// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:pub_dev/fake/backend/fake_pana_runner.dart';
import 'package:pub_dev/job/job.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('ScoreCard pana report', () {
    testWithProfile('write and read pana reports', fn: () async {
      // run with fake pana runner
      final jobProcessor = AnalyzerJobProcessor(
        aliveCallback: null,
        runner: FakePanaRunner(),
      );
      await JobMaintenance(dbService, jobProcessor).scanUpdateAndRunOnce();

      final reports = await scoreCardBackend.loadReportForAllVersions(
        'oxygen',
        ['1.0.0', '1.2.0', '2.0.0-nonexisting'],
        reportType: ReportType.pana,
      );

      expect(reports.first, isNotNull);
      expect(reports.last, isNull);
      final report = reports[1] as PanaReport;
      expect(report.derivedTags, [
        'sdk:dart',
        'runtime:native-aot',
        'runtime:native-jit',
        'runtime:web',
      ]);
      expect(report.report.grantedPoints, 33);
      expect(report.report.maxPoints, 60);
      expect(report.report.sections.first.summary,
          contains('8/30 points: Package layout'));
    });
  });
}
