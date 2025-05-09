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
      // Average = 1500 for the first 30 values. Slope: 10.
      final downloads =
          List<int>.generate(analysisWindowDays * 2, (i) => 1645 - (i * 10));
      final expectedRate = 10.0 / 1500.0;
      expect(computeRelativeGrowthRate(downloads), expectedRate);
    });

    test('calculates negative relative growth rate for negative trend', () {
      // Input list (newest first):  [1355, 1365, ..., 1645]
      // Average = 1500. Slope: -10.
      final downloads =
          List<int>.generate(analysisWindowDays, (i) => 1355 + (i * 10));
      final expectedRate = -10.0 / 1500.0;
      expect(computeRelativeGrowthRate(downloads), expectedRate);
    });

    test(
        'calculates positive relative growth for data barely meeting threshold',
        () {
      // Input list (newest first): [1016, 1015, ..., 987]
      // Average: 1001.5. Slope: 1.
      final downloads =
          List<int>.generate(analysisWindowDays, (i) => 1016 - i * 1);
      final expectedRate = 1.0 / 1001.5;
      expect(computeRelativeGrowthRate(downloads), closeTo(expectedRate, 1e-9));
    });

    test('should handle fluctuating data with a slight positive overall trend',
        () {
      // Newest first. Average 1135.
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
      final expectedRate = 683250.0 / 67425.0 / 1135.0;
      expect(computeRelativeGrowthRate(downloads), expectedRate);
    });
  });
  group('computeTrendScore', () {
    test('Short history, very low sum, positive growth -> heavily dampened',
        () {
      final downloads = [100, 50];
      // For relativeGrowth:
      //   Padded data: [100, 50, 0...0] (28 zeros)
      //   avg = 150/30 = 5
      //   growthRate = 63750 / 67425
      final expectedDampening = min(1.0, 150 / 30000);
      final expectedRelativeGrowth = 63750 / 67425 / 5;
      final expectedScore =
          expectedRelativeGrowth * expectedDampening * expectedDampening;
      expect(computeTrendScore(downloads), expectedScore);
    });
  });

  test('Full history, sum meets threshold, positive growth -> no dampening',
      () {
    final downloads =
        List<int>.generate(analysisWindowDays, (i) => 1645 - (i * 10));
    // For relativeGrowth:
    //   data: [1645, 1635, ..., 1355]
    //   avg = 1500,
    //   growthrate = 10
    final expectedDampening = min(1.0, 45000 / 30000);
    final expectedRelativeGrowth = 10 / 1500;
    final expectedScore =
        expectedRelativeGrowth * expectedDampening * expectedDampening;
    expect(computeTrendScore(downloads), expectedScore);
  });

  test('Negative growth, sum meets threshold -> no dampening', () {
    final downloads =
        List<int>.generate(analysisWindowDays, (i) => 1355 + (i * 10));
    // For relativeGrowth:
    //   data: [1645, 1635, ..., 1355]
    //   avg = 1500,
    //   growthrate = -10
    final expectedDampening = min(1.0, 45000 / 30000);
    final expectedRelativeGrowth = -10.0 / 1500;
    final expectedScore =
        expectedRelativeGrowth * expectedDampening * expectedDampening;
    expect(computeTrendScore(downloads), expectedScore);
  });
  test('Full history, sum below threshold, positive growth -> dampened', () {
    final downloads =
        List<int>.generate(analysisWindowDays, (i) => 645 - (i * 10));
    // For relativeGrowth:
    //   data: [645,..., 345, 355]
    //   avg = 500
    //   growthrate = 10
    final expectedDampening = min(1.0, 15000 / 30000);
    final expectedRelativeGrowth = 10.0 / 500.0;
    final expectedScore =
        expectedRelativeGrowth * expectedDampening * expectedDampening;

    expect(computeTrendScore(downloads), expectedScore);
  });

  test('Empty totalDownloads list -> score 0', () {
    final downloads = <int>[];
    expect(computeTrendScore(downloads), 0);
  });

  test('Full history, all zero downloads -> score 0', () {
    final downloads = List<int>.filled(analysisWindowDays, 0);
    expect(computeTrendScore(downloads), 0);
  });

  test('ThirtyDaySum just below threshold correctly, flat growth', () {
    final downloads = List<int>.filled(analysisWindowDays, 999);
    expect(computeTrendScore(downloads), 0);
  });

  test('Short history, high sum meets threshold -> no dampening', () {
    final downloads = List<int>.filled(15, 2000);
    final expectedDampening = min(1.0, 30000 / 30000);
    final expectedRelativeGrowth = 6750000 / 67425 / 1000;
    final expectedScore =
        expectedRelativeGrowth * expectedDampening * expectedDampening;

    expect(computeTrendScore(downloads), expectedScore);
  });
}
