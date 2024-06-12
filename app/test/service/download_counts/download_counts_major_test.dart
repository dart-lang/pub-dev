// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:test/test.dart';

void main() {
  CountData setupInitialCounts(DateTime date) {
    final countData = CountData.empty();
    final versionsCounts = {
      '1.0.1': 2,
      '2.0.0-alpha': 2,
      '2.0.0': 2,
      '2.1.0': 2,
      '3.1.0': 2,
      '4.0.0-0': 2,
      '6.1.0': 2,
    };
    countData.addDownloadCounts(versionsCounts, date);
    expect(countData.newestDate, date);
    expect(countData.majorRangeCounts.length, 5);

    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(firstRange.counts.take(1).toList(), [2]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(secondRange.counts.take(1).toList(), [6]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(thirdRange.counts.take(1).toList(), [2]);

    final fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(fourthRange.counts.take(1).toList(), [2]);

    final fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fifthRange.counts.take(1).toList(), [2]);

    return countData;
  }

  test('Add counts on following date', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    // Extend existing counts and expel the lowest range.
    final versionsCounts = {
      '4.1.0': 10,
      '4.0.0': 10,
      '6.1.0': 10,
      '7.0.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.majorRangeCounts.length, 5);

    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(firstRange.counts.take(2).toList(), [0, 6]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(secondRange.counts.take(2).toList(), [0, 2]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(thirdRange.counts.take(2).toList(), [20, 2]);

    final fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(2).toList(), [10, 2]);

    final fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(1).toList(), [10]);
  });

  test('Add counts for two days later', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    // Extend existing counts and expel the lowest range.
    final versionsCounts = {
      '4.1.0': 10,
      '4.0.0': 10,
      '6.1.0': 10,
      '7.0.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(2);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.majorRangeCounts.length, 5);

    var firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    var secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    var thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(thirdRange.counts.take(3).toList(), [20, 0, 2]);

    var fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(3).toList(), [10, 0, 2]);

    var fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(1).toList(), [10]);

    // Update missing date.
    final versionsCounts2 = {
      '4.1.0': 8,
      '4.0.0': 8,
      '6.1.0': 8,
      '7.0.0': 8,
    };
    final newDate2 = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts2, newDate2);
    expect(countData.newestDate, newDate);

    firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(thirdRange.counts.take(3).toList(), [20, 16, 2]);

    fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(3).toList(), [10, 8, 2]);

    fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(2).toList(), [10, 8]);

    // Update existing values
    final versionsCounts3 = {
      '4.1.0': 7,
      '4.0.0': 7,
      '6.1.0': 7,
      '7.0.0': 7,
    };
    final newDate3 = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionsCounts3, newDate3);
    expect(countData.newestDate, newDate);

    firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(firstRange.counts.take(3).toList(), [0, 0, 6]);

    secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(secondRange.counts.take(3).toList(), [0, 0, 2]);

    thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(thirdRange.counts.take(3).toList(), [20, 14, 2]);

    fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(3).toList(), [10, 7, 2]);

    fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(2).toList(), [10, 7]);
  });

  test('Add counts on older date', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionsCounts = {
      '4.1.0': 10,
      '4.0.0': 10,
      '6.1.0': 10,
      '7.0.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(-2);

    countData.addDownloadCounts(versionsCounts, newDate);
    expect(countData.newestDate, initialLastDate);
    expect(countData.majorRangeCounts.length, 5);

    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(firstRange.counts.take(3).toList(), [6, 0, 0]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(secondRange.counts.take(3).toList(), [2, 0, 0]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(thirdRange.counts.take(3).toList(), [2, 0, 20]);

    final fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(3).toList(), [2, 0, 10]);

    final fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(3).toList(), [0, 0, 10]);
  });

  test('Add counts not affecting range', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionsCounts = {
      '0.1.0': 27,
      '0.1.1': 27,
    };
    final newDate = initialLastDate.addCalendarDays(1);
    countData.addDownloadCounts(versionsCounts, newDate);

    expect(countData.majorRangeCounts.length, 5);

    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(firstRange.counts.take(2).toList(), [0, 2]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(secondRange.counts.take(2).toList(), [0, 6]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(thirdRange.counts.take(2).toList(), [0, 2]);

    final fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(fourthRange.counts.take(2).toList(), [0, 2]);

    final fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fifthRange.counts.take(2).toList(), [0, 2]);
  });

  test('Add counts on missing range in the middle', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = setupInitialCounts(initialLastDate);

    final versionCounts = {
      '5.1.0': 10,
      '4.0.0': 10,
      '4.1.0': 10,
      '7.0.0': 10,
    };
    final newDate = initialLastDate.addCalendarDays(1);

    countData.addDownloadCounts(versionCounts, newDate);
    expect(countData.newestDate, newDate);
    expect(countData.majorRangeCounts.length, 5);

    // New range should be inserted in correct order, and lowest ranges are
    // expelled.
    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=3.0.0-0 <4.0.0');
    expect(firstRange.counts.take(2).toList(), [0, 2]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=4.0.0-0 <5.0.0');
    expect(secondRange.counts.take(2).toList(), [20, 2]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=5.0.0-0 <6.0.0');
    expect(thirdRange.counts.take(1).toList(), [10]);

    final fourthRange = countData.majorRangeCounts[3];
    expect(fourthRange.versionRange, '>=6.0.0-0 <7.0.0');
    expect(fourthRange.counts.take(2).toList(), [0, 2]);

    final fifthRange = countData.majorRangeCounts[4];
    expect(fifthRange.versionRange, '>=7.0.0-0 <8.0.0');
    expect(fifthRange.counts.take(1).toList(), [10]);
  });

  test('Add counts on missing range in the end', () async {
    final initialLastDate = DateTime.parse('1986-02-16');

    final countData = CountData.empty();
    final versionsCounts = {
      '1.0.1': 2,
      '2.0.0-alpha': 2,
      '2.0.0': 2,
      '2.1.0': 2,
    };
    countData.addDownloadCounts(versionsCounts, initialLastDate);
    expect(countData.newestDate, initialLastDate);
    expect(countData.majorRangeCounts.length, 2);

    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(firstRange.counts.take(1).toList(), [2]);

    final secondRange = countData.majorRangeCounts[1];
    expect(secondRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(secondRange.counts.take(1).toList(), [6]);

    final versionCounts = {
      '0.1.0': 10,
    };

    final newDate = initialLastDate.addCalendarDays(1);
    countData.addDownloadCounts(versionCounts, newDate);

    expect(countData.newestDate, newDate);
    expect(countData.majorRangeCounts.length, 3);

    // New range should be inserted in correct order.
    final newFirstRange = countData.majorRangeCounts[0];
    expect(newFirstRange.versionRange, '>=0.0.0-0 <1.0.0');
    expect(newFirstRange.counts.take(1).toList(), [10]);

    final newSecondRange = countData.majorRangeCounts[1];
    expect(newSecondRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(newSecondRange.counts.take(2).toList(), [0, 2]);

    final thirdRange = countData.majorRangeCounts[2];
    expect(thirdRange.versionRange, '>=2.0.0-0 <3.0.0');
    expect(thirdRange.counts.take(2).toList(), [0, 6]);
  });

  test('More than maxAge dates', () async {
    final initialLastDate = DateTime.parse('1986-02-16');
    final countData = CountData.empty();
    final versionsCounts = {
      '1.0.0': 2,
    };

    for (int i = 0; i < maxAge; i++) {
      countData.addDownloadCounts(
          versionsCounts, initialLastDate.addCalendarDays(i));
      expect(countData.newestDate, initialLastDate.addCalendarDays(i));
      expect(countData.majorRangeCounts.length, 1);

      final firstRange = countData.majorRangeCounts[0];
      expect(firstRange.versionRange, '>=1.0.0-0 <2.0.0');
      expect(firstRange.counts.length, 731);
      expect(firstRange.counts[i], 2);
    }

    final newVersionsCounts = {
      '1.0.0': 10,
    };
    countData.addDownloadCounts(
        newVersionsCounts, initialLastDate.addCalendarDays(maxAge));
    expect(countData.newestDate, initialLastDate.addCalendarDays(maxAge));
    expect(countData.majorRangeCounts.length, 1);
    final firstRange = countData.majorRangeCounts[0];
    expect(firstRange.versionRange, '>=1.0.0-0 <2.0.0');
    expect(firstRange.counts.length, maxAge);
    expect(firstRange.counts[0], 10);
    expect(firstRange.counts[1], 2);
    expect(firstRange.counts[maxAge - 1], 2);
  });
}
