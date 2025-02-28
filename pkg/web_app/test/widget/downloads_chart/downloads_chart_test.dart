// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:web_app/src/widget/downloads_chart/computations.dart';
// import 'package:web_app/src/widget/downloads_chart/widget.dart';

void main() {
  test('week lists - simpler', () {
    final List<int> l1 = List.from(List.filled(10, 10))
      ..addAll(List.filled(10, 20))
      ..add(2)
      ..addAll(List.filled(31, 0));

    final List<int> l2 = List.from(List.filled(10, 20))
      ..addAll(List.filled(10, 40))
      ..add(4)
      ..addAll(List.filled(31, 0));

    final List<int> l3 = List.from(List.filled(10, 70))
      ..addAll(List.filled(10, 140))
      ..add(14)
      ..addAll(List.filled(31, 0));

    final totals = List<int>.from(List.filled(10, 110))
      ..addAll(List.filled(10, 220))
      ..add(22)
      ..addAll(List.filled(31, 0));

    final patchRangeDownloads = [
      (counts: l1, versionRange: '>=6.2.0-0 <6.2.1'),
      (counts: l1, versionRange: '>=6.2.1-0 <6.2.2'),
      (counts: l1, versionRange: '>=6.3.1-0 <6.3.2'),
      (counts: l1, versionRange: '>=6.4.0-0 <6.4.1'),
      (counts: l1, versionRange: '>=6.6.1-0 <6.6.2'),
    ];

    final minorRangeDownloads = [
      (counts: l1, versionRange: '>=6.1.0-0 <6.2.0'),
      (counts: l2, versionRange: '>=6.2.0-0 <6.3.0'),
      (counts: l1, versionRange: '>=6.3.0-0 <6.4.0'),
      (counts: l1, versionRange: '>=6.4.0-0 <6.5.0'),
      (counts: l1, versionRange: '>=6.6.0-0 <6.7.0')
    ];

    final majorRangeDownloads = [
      (counts: l1, versionRange: '>=1.0.0-0 <2.0.0'),
      (counts: l1, versionRange: '>=2.0.0-0 <3.0.0'),
      (counts: l1, versionRange: '>=3.0.0-0 <4.0.0'),
      (counts: l1, versionRange: '>=4.0.0-0 <5.0.0'),
      (counts: l3, versionRange: '>=6.0.0-0 <7.0.0')
    ];

    final w1 = prepareWeekLists(totals, majorRangeDownloads, 52).weekLists;
    final w2 = prepareWeekLists(totals, minorRangeDownloads, 52).weekLists;
    final w3 = prepareWeekLists(totals, patchRangeDownloads, 52).weekLists;

    for (int i = 42; i < 52; i++) {
      expect(w1[i], [10, 10, 10, 10, 70]);
      expect(w2[i], [50, 10, 20, 10, 10, 10]);
      expect(w3[i], [60, 10, 10, 10, 10, 10]);
    }

    for (int i = 32; i < 42; i++) {
      expect(w1[i], [20, 20, 20, 20, 140]);
      expect(w2[i], [100, 20, 40, 20, 20, 20]);
      expect(w3[i], [120, 20, 20, 20, 20, 20]);
    }

    expect(w1[31], [2, 2, 2, 2, 14]);
    expect(w2[31], [10, 2, 4, 2, 2, 2]);
    expect(w3[31], [12, 2, 2, 2, 2, 2]);

    for (int i = 0; i < 31; i++) {
      expect(w1[i], [0, 0, 0, 0, 0]);
      expect(w2[i], [0, 0, 0, 0, 0, 0]);
      expect(w3[i], [0, 0, 0, 0, 0, 0]);
    }
  });

  group('closestPointOnLine tests', () {
    test('point on the line', () {
      final lineStart = (0, 0);
      final lineEnd = (10, 10);
      final point = (5, 5);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (5.0, 5.0));
    });

    test('point before the line', () {
      final lineStart = (0, 0);
      final lineEnd = (10, 10);
      final point = (-2, -5);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (double.maxFinite, double.maxFinite));
    });

    test('point after the line', () {
      final lineStart = (0, 0);
      final lineEnd = (10, 10);
      final point = (15, 15);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (double.maxFinite, double.maxFinite));
    });

    test('point off the line', () {
      final lineStart = (0, 0);
      final lineEnd = (10, 10);
      final point = (5, 3);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (4.0, 4.0));
    });

    test('vertical line', () {
      final lineStart = (1, 2);
      final lineEnd = (1, 10);
      final point = (5, 5);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (1.0, 5.0));
    });

    test('horizontal line', () {
      final lineStart = (2, 1);
      final lineEnd = (10, 1);
      final point = (5, 5);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (5.0, 1.0));
    });

    test('same start and end points', () {
      final lineStart = (5, 5);
      final lineEnd = (5, 5);
      final point = (10, 10);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (5.0, 5.0));
    });

    test('line with negative coordinates', () {
      final lineStart = (-5, -5);
      final lineEnd = (5, 5);
      final point = (0, 10);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (5.0, 5.0));
    });

    test('line with negative and positive coordinates', () {
      final lineStart = (-5, 5);
      final lineEnd = (5, -5);
      final point = (0, 0);
      final closest = closestPointOnLine(lineStart, lineEnd, point);
      expect(closest, (0.0, 0.0));
    });
  });

  group('isPointOnPathWithTolerance', () {
    test('Points on and off the line segment', () {
      final path = [(0.0, 0.0), (2.0, 2.0), (4.0, 0.0)];

      final pointOnLine = (1.0, 1.0);
      expect(isPointOnPathWithTolerance(path, pointOnLine, 0.001), isTrue);

      final pointCloseToLine = (1.0, 1.1);
      expect(isPointOnPathWithTolerance(path, pointCloseToLine, 0.2), isTrue);
      expect(
          isPointOnPathWithTolerance(path, pointCloseToLine, 0.001), isFalse);

      final pointFurtherFromLine = (1.0, 1.5);
      expect(
          isPointOnPathWithTolerance(path, pointFurtherFromLine, 0.1), isFalse);
    });

    test('Path with fewer than 2 points', () {
      final path = [(1.0, 1.0)];
      final point = (1.0, 1.0);
      expect(isPointOnPathWithTolerance(path, point, 0.001), isFalse);
    });

    test('Point on zero length segment', () {
      final chart = [(1.0, 1.0), (1.0, 1.0), (5.0, 1.0)];
      final point = (1.0, 1.0);
      expect(isPointOnPathWithTolerance(chart, point, 0.001), isTrue);
    });
  });
}
