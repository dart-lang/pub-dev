// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/scoring.dart';

void main() {
  group('release frequency', () {
    test('single release now', () {
      expect(scoreReleaseFrequency([0]), closeTo(0.0803, 0.0005));
    });
    test('single release a month ago', () {
      expect(scoreReleaseFrequency([30]), closeTo(0.0735, 0.0005));
    });
    test('single release 4 months ago', () {
      expect(scoreReleaseFrequency([4 * 30]), closeTo(0.0562, 0.0005));
    });
    test('single release 8 months ago', () {
      expect(scoreReleaseFrequency([8 * 30]), closeTo(0.0394, 0.0005));
    });
    test('single release a year ago', () {
      expect(scoreReleaseFrequency([12 * 30]), closeTo(0.0056, 0.0005));
    });

    test('quarterly releases', () {
      expect(scoreReleaseFrequency(new List.generate(4, (i) => i * 91)),
          closeTo(0.2246, 0.0005));
    });
    test('bi-monthly releases', () {
      expect(scoreReleaseFrequency(new List.generate(6, (i) => i * 60)),
          closeTo(0.3228, 0.0005));
    });
    test('releases every 6 weeks', () {
      expect(scoreReleaseFrequency(new List.generate(9, (i) => i * 42)),
          closeTo(0.4634, 0.0005));
    });
    test('monthly releases', () {
      expect(scoreReleaseFrequency(new List.generate(12, (i) => i * 30)),
          closeTo(0.6183, 0.0005));
    });
    test('bi-weekly releases', () {
      expect(scoreReleaseFrequency(new List.generate(25, (i) => i * 14)),
          closeTo(0.7439, 0.0005));
    });
    test('weekly releases', () {
      expect(scoreReleaseFrequency(new List.generate(60, (i) => i * 7)),
          closeTo(1.0000, 0.0005));
    });
    test('daily releases', () {
      expect(scoreReleaseFrequency(new List.generate(390, (i) => i)),
          closeTo(1.0000, 0.0005));
    });

    test('daily in the past month', () {
      expect(scoreReleaseFrequency(new List.generate(30, (i) => i)),
          closeTo(0.1969, 0.0005));
    });
    test('daily for a month a year ago', () {
      expect(scoreReleaseFrequency(new List.generate(30, (i) => i + 330)),
          closeTo(0.0531, 0.0005));
    });
  });
}
