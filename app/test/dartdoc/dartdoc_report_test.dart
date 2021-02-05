// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/pana.dart' hide ReportStatus;
import 'package:pub_dev/dartdoc/backend.dart';
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('ScoreCard dartdoc report', () {
    testWithServices('write and read dartdoc reports', () async {
      await scoreCardBackend.updateReport(
          hydrogen.packageName,
          hydrogen.latestVersion,
          DartdocReport(
            reportStatus: ReportStatus.success,
            dartdocEntry: DartdocEntry(
              uuid: 'report-uuid-1',
              packageName: hydrogen.packageName,
              packageVersion: hydrogen.latestVersion,
              runtimeVersion: runtimeVersion,
              flutterVersion: flutterVersion,
              dartdocVersion: dartdocVersion,
              sdkVersion: toolStableSdkVersion,
              hasContent: true,
              depsResolved: true,
              isLatest: true,
              isObsolete: false,
              totalSize: 121212,
              archiveSize: 101010,
              usesFlutter: false,
              timestamp: DateTime(2020, 07, 14, 11, 12, 13),
            ),
            documentationSection:
                documentationCoverageSection(documented: 10, total: 12),
          ));

      final reports = await scoreCardBackend.loadReportForAllVersions(
        hydrogen.packageName,
        [hydrogen.latestVersion, '0.1.2'],
        reportType: ReportType.dartdoc,
      );

      expect(reports.first, isNotNull);
      expect(reports.last, isNull);
      final report = reports.first as DartdocReport;
      expect(report.dartdocEntry, isNotNull);
      expect(report.dartdocEntry.totalSize, 121212);

      final entries = await dartdocBackend.getEntriesForVersions(
        hydrogen.packageName,
        [hydrogen.latestVersion, '0.1.2'],
      );

      expect(entries.first, isNotNull);
      expect(entries.last, isNull);
      expect(entries.first.totalSize, 121212);
    });
  });
}
