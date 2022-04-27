// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/fake/backend/fake_pana_runner.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('ScoreCard pana report', () {
    testWithProfile('write and read pana reports', fn: () async {
      await processJobsWithFakePanaRunner();

      final cards = await scoreCardBackend.getScoreCardDataForAllVersions(
        'oxygen',
        ['1.0.0', '1.2.0', '2.0.0-nonexisting'],
      );
      final reports = cards.map((c) => c?.panaReport).toList();

      expect(reports.first, isNotNull);
      expect(reports.last, isNull);
      final report = reports[1]!;
      expect(report.derivedTags, [
        'sdk:dart',
        'sdk:flutter',
        'runtime:native-aot',
        'runtime:native-jit',
        'runtime:web',
        'platform:android',
        'platform:ios',
        'platform:macos',
        'platform:web',
        'platform:windows',
        'license:bsd-3-clause',
        'license:fsf-libre',
        'license:osi-approved',
      ]);
      expect(report.report!.grantedPoints, 33);
      expect(report.report!.maxPoints, 60);
      expect(report.report!.sections.first.summary,
          contains('8/30 points: Package layout'));
    });
  });
}
