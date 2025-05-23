// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';
import 'dart:io';

import 'package:basics/basics.dart';
import 'package:gcloud/storage.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/fake/backend/fake_download_counts.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/service/download_counts/package_trends.dart';
import 'package:pub_dev/service/download_counts/sync_download_counts.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('30 days download counts', () {
    testWithProfile('compute download counts 30-days totals', fn: () async {
      final pkg = 'foo';
      final versionsCounts = {
        '1.0.1': 2,
        '2.0.0-alpha': 2,
        '2.0.0': 2,
        '2.1.0': 2,
        '3.1.0': 2,
        '4.0.0-0': 2,
        '6.1.0': 2,
      };
      final date = DateTime.parse('1986-02-16T00:00:00Z');
      var downloadCounts1 = await downloadCountsBackend.updateDownloadCounts(
          pkg, versionsCounts, date);
      for (var i = 1; i < 5; i++) {
        downloadCounts1 = await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts, date.addCalendarDays(i));
      }

      expect(compute30DayTotal(downloadCounts1), 70);

      final pkg2 = 'bar';
      final versionsCounts2 = {
        '1.0.1': 3,
        '2.0.0-alpha': 3,
        '2.0.0': 3,
        '2.1.0': 3,
        '3.1.0': 3,
        '4.0.0-0': 3,
        '6.1.0': 3,
      };
      var downloadCounts2 = await downloadCountsBackend.updateDownloadCounts(
          pkg2, versionsCounts2, date);
      for (var i = 1; i < 5; i++) {
        downloadCounts2 = await downloadCountsBackend.updateDownloadCounts(
            pkg2, versionsCounts2, date.addCalendarDays(i));
      }

      expect(compute30DayTotal(downloadCounts2), 105);

      final pkg3 = 'baz';
      final versionsCounts3 = {
        '1.0.1': 4,
        '2.0.0-alpha': 4,
        '2.0.0': 4,
        '2.1.0': 4,
        '3.1.0': 4,
        '4.0.0-0': 4,
        '6.1.0': 4,
      };
      var downloadCounts3 = await downloadCountsBackend.updateDownloadCounts(
          pkg3, versionsCounts3, date);
      for (var i = 1; i < 5; i++) {
        downloadCounts3 = await downloadCountsBackend.updateDownloadCounts(
            pkg3, versionsCounts3, date.addCalendarDays(i));
      }
      expect(compute30DayTotal(downloadCounts3), 140);

      final downloadCounts = [
        downloadCounts1,
        downloadCounts2,
        downloadCounts3
      ];

      final res = await compute30DayTotals(Stream.fromIterable(downloadCounts));

      expect(
        res,
        {'foo': 70, 'bar': 105, 'baz': 140},
      );
    });

    testWithProfile('succesful 30 day totals upload', fn: () async {
      await upload30DaysTotal({'foo': 70, 'bar': 105, 'baz': 140});

      final data = await storageService
          .bucket(activeConfiguration.reportsBucketName!)
          .read(downloadCounts30DaysTotalsFileName)
          .transform(utf8.decoder)
          .transform(json.decoder)
          .single;

      expect(data, {'foo': 70, 'bar': 105, 'baz': 140});
    });

    testWithProfile('cache 30-days totals', fn: () async {
      await generateFake30DaysTotals({'foo': 70, 'bar': 105, 'baz': 140});
      expect(downloadCountsBackend.lookup30DaysTotalCounts('foo'), isNull);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('bar'), isNull);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('baz'), isNull);

      await downloadCountsBackend.start();
      expect(downloadCountsBackend.lookup30DaysTotalCounts('foo'), 70);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('bar'), 105);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('baz'), 140);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('bax'), isNull);

      await generateFake30DaysTotals({'foo': 90, 'bar': 120, 'baz': 150});
      await downloadCountsBackend.start();
      expect(downloadCountsBackend.lookup30DaysTotalCounts('foo'), 90);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('bar'), 120);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('baz'), 150);
      expect(downloadCountsBackend.lookup30DaysTotalCounts('bax'), isNull);
    });
  });

  group('weekly download counts', () {
    testWithProfile('compute weekly', fn: () async {
      final pkg = 'foo';
      final date = DateTime.parse('1986-02-16T00:00:00Z');
      final versionsCounts = {
        '1.0.1': 2,
        '2.0.0-alpha': 2,
        '2.0.0': 2,
        '2.1.0': 2,
        '3.1.0': 2,
        '4.0.0-0': 2,
        '6.1.0': 2,
      };
      final versionsCounts2 = {
        '1.0.1': 3,
        '2.0.0-alpha': 3,
        '2.0.0': 3,
        '2.1.0': 3,
        '3.1.0': 3,
        '4.0.0-0': 3,
        '6.1.0': 3,
      };

      for (var i = 0; i <= 7 * 20; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts, date.addCalendarDays(i));
      }

      for (var i = 7 * 20 + 1; i <= 7 * 40; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts2, date.addCalendarDays(i));
      }

      final res = await computeWeeklyTotalDownloads(pkg);

      final expectedList = List.from(List.filled(20, 147))
        ..addAll(List.filled(20, 98))
        ..add(14)
        ..addAll(List.filled(11, 0));
      final expectedNewestDate = date.addCalendarDays(7 * 40);

      expect(res!.weeklyDownloads, expectedList);
      expect(res.newestDate, expectedNewestDate);
    });

    testWithProfile('compute weekly for all verion ranges', fn: () async {
      final pkg = 'foo';
      final date = DateTime.parse('1986-02-16T00:00:00Z');
      final versions = [
        '1.1.0',
        '2.0.0-alpha',
        '2.0.0',
        '2.1.0',
        '3.1.0',
        '4.0.0-0',
        '6.0.1',
        '6.1.1',
        '6.1.2-alpha',
        '6.1.2',
        '6.1.3',
        '6.1.4',
        '6.1.4-0',
        '6.1.6',
        '6.2.0-alpha',
        '6.2.0',
        '6.2.1',
        '6.3.1',
        '6.4.0-0',
        '6.6.1',
      ];
      final versionsCounts = <String, int>{};
      versions.forEach((v) => versionsCounts[v] = 2);

      final versionsCounts2 = <String, int>{};
      versions.forEach((v) => versionsCounts2[v] = 1);

      for (var i = 0; i <= 7 * 10; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts, date.addCalendarDays(i));
      }
      for (var i = 7 * 10 + 1; i <= 7 * 20; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts2, date.addCalendarDays(i));
      }

      final res = await computeWeeklyVersionDownloads(pkg);

      final expectedNewestDate = date.addCalendarDays(7 * 20);
      expect(res!.newestDate, expectedNewestDate);

      final List<int> l1 = List.from(List.filled(10, 7))
        ..addAll(List.filled(10, 14))
        ..add(2)
        ..addAll(List.filled(31, 0));
      final List<int> l2 = List.from(List.filled(10, 21))
        ..addAll(List.filled(10, 42))
        ..add(6)
        ..addAll(List.filled(31, 0));
      final List<int> l3 = List.from(List.filled(10, 98))
        ..addAll(List.filled(10, 196))
        ..add(28)
        ..addAll(List.filled(31, 0));
      final List<int> l4 = List.from(List.filled(10, 49))
        ..addAll(List.filled(10, 98))
        ..add(14)
        ..addAll(List.filled(31, 0));
      final List<int> l5 = List.from(List.filled(10, 14))
        ..addAll(List.filled(10, 28))
        ..add(4)
        ..addAll(List.filled(31, 0));

      final expectedMajorWeeklyDownloads = [
        (counts: l1, versionRange: '>=1.0.0-0 <2.0.0'),
        (counts: l2, versionRange: '>=2.0.0-0 <3.0.0'),
        (counts: l1, versionRange: '>=3.0.0-0 <4.0.0'),
        (counts: l1, versionRange: '>=4.0.0-0 <5.0.0'),
        (counts: l3, versionRange: '>=6.0.0-0 <7.0.0')
      ];

      for (int i = 0; i < 5; i++) {
        expect(res.majorRangeWeeklyDownloads[i].counts,
            expectedMajorWeeklyDownloads[i].counts);
        expect(res.majorRangeWeeklyDownloads[i].versionRange,
            expectedMajorWeeklyDownloads[i].versionRange);
      }

      final expectedMinorWeeklyDownloads = [
        (counts: l4, versionRange: '>=6.1.0-0 <6.2.0'),
        (counts: l2, versionRange: '>=6.2.0-0 <6.3.0'),
        (counts: l1, versionRange: '>=6.3.0-0 <6.4.0'),
        (counts: l1, versionRange: '>=6.4.0-0 <6.5.0'),
        (counts: l1, versionRange: '>=6.6.0-0 <6.7.0')
      ];

      for (int i = 0; i < 5; i++) {
        expect(res.minorRangeWeeklyDownloads[i].counts,
            expectedMinorWeeklyDownloads[i].counts);
        expect(res.minorRangeWeeklyDownloads[i].versionRange,
            expectedMinorWeeklyDownloads[i].versionRange);
      }

      final expectedPatchWeeklyDownloads = [
        (counts: l5, versionRange: '>=6.2.0-0 <6.2.1'),
        (counts: l1, versionRange: '>=6.2.1-0 <6.2.2'),
        (counts: l1, versionRange: '>=6.3.1-0 <6.3.2'),
        (counts: l1, versionRange: '>=6.4.0-0 <6.4.1'),
        (counts: l1, versionRange: '>=6.6.1-0 <6.6.2'),
      ];

      for (int i = 0; i < 5; i++) {
        expect(res.patchRangeWeeklyDownloads[i].counts,
            expectedPatchWeeklyDownloads[i].counts);
        expect(res.patchRangeWeeklyDownloads[i].versionRange,
            expectedPatchWeeklyDownloads[i].versionRange);
      }
    });
  });
  group('trends', () {
    testWithProfile('compute trend', fn: () async {
      String date(int i) => i < 10 ? '2024-01-0$i' : '2024-01-$i';

      for (int i = 1; i < 16; i++) {
        final d = DateTime.parse(date(i));
        final downloadCountsJsonFileName =
            'daily_download_counts/${date(i)}T00:00:00Z/data-000000000000.jsonl';
        await uploadFakeDownloadCountsToBucket(
            downloadCountsJsonFileName,
            path.join(
                Directory.current.path,
                'test',
                'service',
                'download_counts',
                'fake_download_counts_data_for_trend1.jsonl'));
        await processDownloadCounts(d);
      }
      for (int i = 16; i < 31; i++) {
        final d = DateTime.parse(date(i));
        final downloadCountsJsonFileName =
            'daily_download_counts/${date(i)}T00:00:00Z/data-000000000000.jsonl';
        await uploadFakeDownloadCountsToBucket(
            downloadCountsJsonFileName,
            path.join(
                Directory.current.path,
                'test',
                'service',
                'download_counts',
                'fake_download_counts_data_for_trend2.jsonl'));
        await processDownloadCounts(d);
      }
      final neonTrend = computeTrendScore([
        ...List.filled(15, 2000),
        ...List.filled(15, 1000),
        ...List.filled(701, -1)
      ]);
      final oxygenTrend = computeTrendScore([
        ...List.filled(15, 5000),
        ...List.filled(15, 3000),
        ...List.filled(701, -1)
      ]);

      expect(await computeTrend(),
          {'flutter_titanium': 0.0, 'neon': neonTrend, 'oxygen': oxygenTrend});
    });

    testWithProfile('succesful trends upload', fn: () async {
      final trends = {'foo': 1.0, 'bar': 3.0, 'baz': 2.0};
      await uploadTrendScores(trends);

      final data = await storageService
          .bucket(activeConfiguration.reportsBucketName!)
          .read(trendScoreFileName)
          .transform(utf8.decoder)
          .transform(json.decoder)
          .single;

      expect(data, trends);
    });
  });

  testWithProfile('cache package trend scores', fn: () async {
    await generateFakeTrendScores({'foo': 3.0, 'bar': 1.0, 'baz': 2.0});
    expect(downloadCountsBackend.lookupTrendScore('foo'), isNull);
    expect(downloadCountsBackend.lookupTrendScore('bar'), isNull);
    expect(downloadCountsBackend.lookupTrendScore('baz'), isNull);

    await downloadCountsBackend.start();
    expect(downloadCountsBackend.lookupTrendScore('foo'), 3.0);
    expect(downloadCountsBackend.lookupTrendScore('bar'), 1.0);
    expect(downloadCountsBackend.lookupTrendScore('baz'), 2.0);
    expect(downloadCountsBackend.lookupTrendScore('bax'), isNull);

    await generateFakeTrendScores({'foo': 9.0, 'bar': 2.0, 'baz': 5.0});
    await downloadCountsBackend.start();
    expect(downloadCountsBackend.lookupTrendScore('foo'), 9.0);
    expect(downloadCountsBackend.lookupTrendScore('bar'), 2.0);
    expect(downloadCountsBackend.lookupTrendScore('baz'), 5.0);
    expect(downloadCountsBackend.lookupTrendScore('bax'), isNull);
  });
}
