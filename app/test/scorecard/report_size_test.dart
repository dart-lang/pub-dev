// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pana/pana.dart' as pana;
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/scorecard/models.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('ScoreCard report size test', () {
    testWithProfile(
      'oversized pana report',
      fn: () async {
        await scoreCardBackend.updateReportOnCard(
          'oxygen',
          '1.0.0',
          panaReport: PanaReport(
            timestamp: DateTime(2021, 09, 30, 12, 10, 00),
            panaRuntimeInfo: pana.PanaRuntimeInfo(
              panaVersion: panaVersion,
              sdkVersion: toolStableDartSdkVersion,
            ),
            reportStatus: ReportStatus.success,
            derivedTags: List.generate(10000, (i) => 'tag:value-$i'),
            allDependencies: List.generate(10000, (i) => 'p$i'),
            licenses: null,
            report: pana.Report(sections: [
              pana.ReportSection(
                id: 'id',
                title: 'title',
                grantedPoints: 10,
                maxPoints: 10,
                status: pana.ReportStatus.passed,
                summary: 'abcd 1234' * 10000,
              ),
            ]),
            result: null,
            urlProblems: [],
            screenshots: null,
          ),
        );

        final card = await scoreCardBackend.getScoreCardData(
          'oxygen',
          '1.0.0',
          skipSandboxedOutput: true,
        );
        expect(json.decode(json.encode(card!.toJson())), {
          'packageName': 'oxygen',
          'packageVersion': '1.0.0',
          'runtimeVersion': isNotNull,
          'updated': isNotNull,
          'packageCreated': isNotNull,
          'packageVersionCreated': isNotNull,
          'dartdocReport': isNotNull,
          'panaReport': {
            'timestamp': isNotEmpty,
            'reportStatus': 'aborted',
            'derivedTags': [
              'has:pana-report-exceeds-size-threshold',
            ],
            'allDependencies': isEmpty,
            'report': {
              'sections': [
                {
                  'id': 'error',
                  'title': 'Report exceeded size limit.',
                  'grantedPoints': 10,
                  'maxPoints': 10,
                  'status': 'partial',
                  'summary':
                      'The `pana` report exceeded size limit. A log about the issue has been filed, the site admins will address it soon.',
                },
              ],
            },
            'urlProblems': []
          },
        });
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'oversized dartdoc report',
      fn: () async {
        await scoreCardBackend.updateReportOnCard(
          'oxygen',
          '1.0.0',
          dartdocReport: DartdocReport(
            timestamp: DateTime(2021, 09, 30, 12, 10, 00),
            reportStatus: ReportStatus.aborted,
            dartdocEntry: null,
            documentationSection: pana.ReportSection(
              id: pana.ReportSectionId.documentation,
              title: pana.documentationSectionTitle,
              grantedPoints: 10,
              maxPoints: 10,
              status: pana.ReportStatus.passed,
              summary: '1234 5678 90ab cdef ghij klmn opqr stuv wxyz' * 1000000,
            ),
          ),
        );

        final card = await scoreCardBackend.getScoreCardData(
          'oxygen',
          '1.0.0',
          skipSandboxedOutput: true,
        );
        expect(json.decode(json.encode(card!.dartdocReport!.toJson())), {
          'timestamp': isNotNull,
          'reportStatus': 'aborted',
          'dartdocEntry': null,
          'documentationSection': {
            'id': 'documentation',
            'title': 'Provide documentation',
            'grantedPoints': 10,
            'maxPoints': 10,
            'status': 'partial',
            'summary':
                'The `dartdoc` report exceeded size limit. A log about the issue has been filed, the site admins will address it soon.',
          },
        });
      },
      processJobsWithFakeRunners: true,
    );
  });
}
