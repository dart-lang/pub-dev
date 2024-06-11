// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:test/test.dart';

void main() {
  CountData setupInitialCounts(DateTime date) {
    final countData = CountData.init();
    final versionsCounts = {
      '1.1.1': 2,
      '1.2.0-alpha': 2,
      '1.2.0': 2,
      '1.2.1': 2,
      '1.3.1': 2,
      '1.4.0-0': 2,
      '1.6.1': 2,
    };
    countData.addDownloadCounts(versionsCounts, date);
    expect(countData.newestDate, date);
    expect(countData.minorRangeCounts.length, 5);

    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.1.0-0 <1.2.0');
    expect(firstRange.counts.take(1), [2]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(secondRange.counts.take(1), [6]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(thirdRange.counts.take(1), [2]);

    final fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(fourthRange.counts.take(1), [2]);

    final fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fifthRange.counts.take(1), [2]);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(2), [14, 0]);

    return countData;
  }

  test('Add counts on following date', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    // Extend existing counts and expel the lowest range.
    final versionsCounts = {
      '1.4.1': 10,
      '1.4.0': 10,
      '1.6.1': 10,
      '1.7.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.minorRangeCounts.length, 5);

    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(firstRange.counts.take(2), [0, 6]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(secondRange.counts.take(2), [0, 2]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(thirdRange.counts.take(2), [20, 2]);

    final fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(2), [10, 2]);

    final fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(2), [10, 0]);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(3), [40, 14, 0]);
  });

  test('Add counts for two days later', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    // Extend existing counts and expel the lowest range.
    final versionsCounts = {
      '1.4.1': 10,
      '1.4.0': 10,
      '1.6.1': 10,
      '1.7.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(2);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.minorRangeCounts.length, 5);

    var firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    var secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    var thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(thirdRange.counts.take(3).toList(), [20, 0, 2]);

    var fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(3).toList(), [10, 0, 2]);

    var fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(1).toList(), [10]);

    expect(countData.majorRangeCounts.length, 1);
    var majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [40, 0, 14, 0]);

    // Update missing date.
    final versionsCounts2 = {
      '1.4.1': 8,
      '1.4.0': 8,
      '1.6.1': 8,
      '1.7.0': 8,
    };
    final newDate2 = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts2, newDate2);
    expect(countData.newestDate, newDate);

    firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(thirdRange.counts.take(3).toList(), [20, 16, 2]);

    fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(3).toList(), [10, 8, 2]);

    fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(2).toList(), [10, 8]);

    expect(countData.majorRangeCounts.length, 1);
    majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [40, 32, 14, 0]);

    // Update existing values
    final versionsCounts3 = {
      '1.4.1': 7,
      '1.4.0': 7,
      '1.6.1': 7,
      '1.7.0': 7,
    };
    final newDate3 = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts3, newDate3);
    expect(countData.newestDate, newDate);

    firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(thirdRange.counts.take(3).toList(), [20, 14, 2]);

    fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(3).toList(), [10, 7, 2]);

    fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(2).toList(), [10, 7]);

    expect(countData.majorRangeCounts.length, 1);
    majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [40, 28, 14, 0]);
  });

  test('Add counts on older date', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionsCounts = {
      '1.4.1': 10,
      '1.4.0': 10,
      '1.6.1': 10,
      '1.7.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(-2);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, initialLastDate);
    expect(countData.minorRangeCounts.length, 5);

    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(firstRange.counts.take(3), [6, 0, 0]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(secondRange.counts.take(3), [2, 0, 0]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(thirdRange.counts.take(3), [2, 0, 20]);

    final fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(3), [2, 0, 10]);

    final fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(3), [0, 0, 10]);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [14, 0, 40, 0]);
  });

  test('Add counts not affecting minor ranges', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionsCounts = {
      '0.0.1': 27,
      '0.0.2': 27,
    };
    final newDate = initialLastDate.addCalendarDays(1);
    countData.addDownloadCounts(versionsCounts, newDate);

    expect(countData.minorRangeCounts.length, 5);

    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.1.0-0 <1.2.0');
    expect(firstRange.counts.take(2).toList(), [0, 2]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(secondRange.counts.take(2).toList(), [0, 6]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(thirdRange.counts.take(2).toList(), [0, 2]);

    final fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(fourthRange.counts.take(2).toList(), [0, 2]);

    final fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fifthRange.counts.take(2).toList(), [0, 2]);

    expect(countData.majorRangeCounts.length, 2);

    final firstMajorRange = countData.majorRangeCounts[0];
    expect(firstMajorRange.versionRange, '>=0.0.0-0 <1.0.0');
    expect(firstMajorRange.counts.take(3), [54, 0, 0]);

    final secondMajorRange = countData.majorRangeCounts[1];
    expect(secondMajorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(secondMajorRange.counts.take(3), [0, 14, 0]);
  });

  test('Add counts on missing minor range in the middle', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionCounts = {
      '1.5.1': 10,
      '1.4.0': 10,
      '1.4.1': 10,
      '1.7.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.minorRangeCounts.length, 5);

    // New range should be inserted in correct order, and lowest ranges are
    // expelled.
    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.3.0-0 <1.4.0');
    expect(firstRange.counts.take(2).toList(), [0, 2]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.4.0-0 <1.5.0');
    expect(secondRange.counts.take(2).toList(), [20, 2]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.5.0-0 <1.6.0');
    expect(thirdRange.counts.take(1).toList(), [10]);

    final fourthRange = countData.minorRangeCounts[3];
    expect(fourthRange.versionRange, '>=1.6.0-0 <1.7.0');
    expect(fourthRange.counts.take(2).toList(), [0, 2]);

    final fifthRange = countData.minorRangeCounts[4];
    expect(fifthRange.versionRange, '>=1.7.0-0 <1.8.0');
    expect(fifthRange.counts.take(1).toList(), [10]);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [40, 14, 0, 0]);
  });

  test('Add counts on missing minor range in the end', () async {
    final initialLastDate = DateTime.parse('1986-02-16');

    final countData = CountData.init();
    final versionsCounts = {
      '1.1.0': 2,
      '1.2.0-alpha': 2,
      '1.2.0': 2,
      '1.2.1': 2,
    };
    countData.addDownloadCounts(versionsCounts, initialLastDate);
    expect(countData.newestDate, initialLastDate);
    expect(countData.minorRangeCounts.length, 2);

    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.1.0-0 <1.2.0');
    expect(firstRange.counts.take(1).toList(), [2]);

    final secondRange = countData.minorRangeCounts[1];
    expect(secondRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(secondRange.counts.take(1).toList(), [6]);

    final versionCounts = {
      '1.0.1': 10,
    };

    final newDate = initialLastDate.addCalendarDays(1);
    countData.addDownloadCounts(versionCounts, newDate);

    expect(countData.newestDate, newDate);
    expect(countData.minorRangeCounts.length, 3);

    // New range should be inserted in correct order.
    final newFirstRange = countData.minorRangeCounts[0];
    expect(newFirstRange.versionRange, '>=1.0.0-0 <1.1.0');
    expect(newFirstRange.counts.take(1).toList(), [10]);

    final newSecondRange = countData.minorRangeCounts[1];
    expect(newSecondRange.versionRange, '>=1.1.0-0 <1.2.0');
    expect(newSecondRange.counts.take(2).toList(), [0, 2]);

    final thirdRange = countData.minorRangeCounts[2];
    expect(thirdRange.versionRange, '>=1.2.0-0 <1.3.0');
    expect(thirdRange.counts.take(2).toList(), [0, 6]);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [10, 8, 0, 0]);
  });

  test('More than maxAge dates', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = CountData.init();
    final versionsCounts = {
      '1.1.0': 2,
    };

    for (int i = 0; i < maxAge; i++) {
      countData.addDownloadCounts(
          versionsCounts, initialLastDate.addCalendarDays(i));
      expect(countData.newestDate, initialLastDate.addCalendarDays(i));
      expect(countData.minorRangeCounts.length, 1);

      final firstRange = countData.minorRangeCounts[0];
      expect(firstRange.versionRange, '>=1.1.0-0 <1.2.0');
      expect(firstRange.counts.length, 731);
      expect(firstRange.counts[i], 2);
    }

    final newVersionsCounts = {
      '1.1.0': 10,
    };
    countData.addDownloadCounts(
        newVersionsCounts, initialLastDate.addCalendarDays(maxAge));
    expect(countData.newestDate, initialLastDate.addCalendarDays(maxAge));
    expect(countData.minorRangeCounts.length, 1);
    final firstRange = countData.minorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.1.0-0 <1.2.0');
    expect(firstRange.counts.length, maxAge);
    expect(firstRange.counts[0], 10);
    expect(firstRange.counts[1], 2);
    expect(firstRange.counts[maxAge - 1], 2);

    expect(countData.majorRangeCounts.length, 1);
    final majorRange = countData.majorRangeCounts.first;
    expect(majorRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(majorRange.counts.take(4), [10, 2, 2, 2]);
  });
}
