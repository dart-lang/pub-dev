// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/dartdoc/backend.dart';
import 'package:pub_dev/dartdoc/dartdoc_runner.dart';
import 'package:pub_dev/fake/backend/fake_dartdoc_runner.dart';
import 'package:pub_dev/job/job.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('ScoreCard dartdoc report', () {
    testWithProfile('write and read dartdoc reports', fn: () async {
      // run with fake dartdoc runner
      final jobProcessor = DartdocJobProcessor(
        aliveCallback: null,
        runner: FakeDartdocRunner(),
      );
      await JobMaintenance(dbService, jobProcessor).scanUpdateAndRunOnce();

      final cards = await scoreCardBackend.getScoreCardDataForAllVersions(
        'oxygen',
        ['1.0.0', '1.2.0', '2.0.0-nonexisting'],
      );
      final reports = cards.map((c) => c?.dartdocReport).toList();

      expect(reports.first, isNotNull);
      expect(reports.last, isNull);
      final report = reports[1]!;
      expect(report.dartdocEntry, isNotNull);
      expect(report.dartdocEntry!.totalSize, 585);
      expect(report.documentationSection!.grantedPoints, 10);
      expect(report.documentationSection!.maxPoints, 10);
      expect(
          report.documentationSection!.summary,
          contains(
              '17 out of 20 API elements (85.0 %) have documentation comments.'));

      final entries = await dartdocBackend.getEntriesForVersions(
        'oxygen',
        ['1.0.0', '1.2.0', '2.0.0-nonexisting'],
      );

      expect(entries.first, isNotNull);
      expect(entries.last, isNull);
      expect(entries[1]!.totalSize, 585);
    });
  });
}
