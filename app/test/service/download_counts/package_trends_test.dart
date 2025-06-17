// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:pub_dev/service/download_counts/package_trends.dart';
import 'package:test/test.dart';

void main() {
  group('calculateLinearRegressionSlope', () {
    test('correctly calculates slope for chronological data', () {
      expect(calculateLinearRegressionSlope([10.0, 20.0, 30.0]), 10.0);
      expect(calculateLinearRegressionSlope([30.0, 20.0, 10.0]), -10.0);
      expect(calculateLinearRegressionSlope([10.0, 10.0, 10.0]), 0);
      expect(calculateLinearRegressionSlope([0.0, 0.0, 0.0]), 0);
    });

    test('return 0.0 if denominator is very small', () {
      expect(calculateLinearRegressionSlope([]), 0.0);
      expect(calculateLinearRegressionSlope([10.0]), 0.0);
    });
  });

  group('computeRelativeGrowthRate', () {
    test('returns 0.0 for stable downloads', () {
      final downloads = List<int>.generate(analysisWindowDays, (i) => 2000);
      expect(computeRelativeGrowthRate(downloads), 0.0);
    });

    test('returns 0.0 for 0 downloads', () {
      final downloads = List<int>.generate(analysisWindowDays, (i) => 0);
      expect(computeRelativeGrowthRate(downloads), 0.0);
    });

    test('calculates positive relative growth rate for positive trend', () {
      // Input list (newest first):  [1645, 1635, ..., 1355] (30 values)
      final downloads =
          List<int>.generate(analysisWindowDays, (i) => 1645 - (i * 10));
      final expectedRate = 0.0066800225103267686;
      expect(computeRelativeGrowthRate(downloads), closeTo(expectedRate, 1e-9));
    });

    test('calculates negative relative growth rate for negative trend', () {
      // Input list (newest first):  [1355, 1365, ..., 1645]
      final downloads =
          List<int>.generate(analysisWindowDays, (i) => 1355 + (i * 10));
      final expectedRate = -0.0066800225103267686;
      expect(computeRelativeGrowthRate(downloads), closeTo(expectedRate, 1e-9));
    });

    test(
        'calculates positive relative growth for data barely meeting threshold',
        () {
      // Input list (newest first): [1016, 1015, ..., 987]
      final downloads =
          List<int>.generate(analysisWindowDays, (i) => 1016 - i * 1);
      final expectedRate = 0.000998546932871653;
      expect(computeRelativeGrowthRate(downloads), closeTo(expectedRate, 1e-9));
    });

    test('should handle fluctuating data with a slight positive overall trend',
        () {
      // Newest first.
      final downloads = <int>[
        1300,
        1250,
        1280,
        1230,
        1260,
        1210,
        1240,
        1190,
        1220,
        1170,
        1200,
        1150,
        1180,
        1130,
        1160,
        1110,
        1140,
        1090,
        1120,
        1070,
        1100,
        1050,
        1080,
        1030,
        1060,
        1010,
        1040,
        990,
        1020,
        970
      ];
      final expectedRate = 0.008963997580330865;
      expect(computeRelativeGrowthRate(downloads), closeTo(expectedRate, 1e-9));
    });
  });
  group('computeTrendScore', () {
    test('Short history, very low sum, -> heavily dampened', () {
      final downloads = [100, 50];
      final totalSum = 150;

      final expectedRelativeGrowth = 0.69315;
      final expectedDampening =
          calculateSigmoidScaleScore(total30Downloads: totalSum);
      final expectedScore = expectedRelativeGrowth * expectedDampening;

      expect(computeTrendScore(downloads), closeTo(expectedScore, 0.0001));
    });

    test('Full history, positive growth -> almost no dampening', () {
      final downloads = // [1645, 1635, ..., 1355]
          List<int>.generate(analysisWindowDays, (i) => 1645 - (i * 10));
      final totalSum = downloads.reduce((a, b) => a + b); // 45000

      final expectedRelativeGrowth = 0.006673;
      final expectedDampening =
          calculateSigmoidScaleScore(total30Downloads: totalSum);
      final expectedScore = expectedRelativeGrowth * expectedDampening;

      expect(computeTrendScore(downloads), closeTo(expectedScore, 0.0001));
    });

    test('Full history, negative growth -> almost no dampening', () {
      final downloads = // [1355, 1365, ..., 1645]
          List<int>.generate(analysisWindowDays, (i) => 1355 + (i * 10));
      final totalSum = downloads.reduce((a, b) => a + b); // 45000
      final expectedRelativeGrowth = -0.006673;
      final expectedDampening =
          calculateSigmoidScaleScore(total30Downloads: totalSum);
      final expectedScore = expectedRelativeGrowth * expectedDampening;

      expect(computeTrendScore(downloads), closeTo(expectedScore, 0.0001));
    });

    test('Full history, sum below threshold, positive growth -> dampened', () {
      final downloads = // [645, ... , 355]
          List<int>.generate(analysisWindowDays, (i) => 645 - (i * 10));
      final totalSum = downloads.reduce((a, b) => a + b);
      final expectedRelativeGrowth = 0.020373587410745377;
      final expectedDampening =
          calculateSigmoidScaleScore(total30Downloads: totalSum);
      final expectedScore = expectedRelativeGrowth * expectedDampening;

      expect(computeTrendScore(downloads), closeTo(expectedScore, 0.0001));
    });

    test('Empty totalDownloads list -> score 0', () {
      final downloads = <int>[];
      expect(computeTrendScore(downloads), 0);
    });

    test('Full history, all zero downloads -> score 0', () {
      final downloads = List<int>.filled(analysisWindowDays, 0);
      expect(computeTrendScore(downloads), 0);
    });

    test('Full history, sum just below threshold, flat growth', () {
      final downloads = List<int>.filled(analysisWindowDays, 999);
      expect(computeTrendScore(downloads), closeTo(0.0, 0.0001));
    });

    test('Short history, high sum meets threshold, flat growth', () {
      final downloads = List<int>.filled(15, 2000);
      expect(computeTrendScore(downloads), closeTo(0.0, 0.0001));
    });
  });
}
