// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:convert';

import 'package:basics/basics.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/fake/backend/fake_download_counts.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('', () {
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
      final date = DateTime.parse('1986-02-16');
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

    testWithProfile('compute weekly', fn: () async {
      final pkg = 'foo';
      final date = DateTime.parse('1986-02-16');
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

      for (var i = 0; i < 7 * 20; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts, date.addCalendarDays(i));
      }

      for (var i = 7 * 20; i < 7 * 40; i++) {
        await downloadCountsBackend.updateDownloadCounts(
            pkg, versionsCounts2, date.addCalendarDays(i));
      }

      final res = await computeWeeklyDownloads(pkg);

      final expectedList = List.from(List.filled(20, 147))
        ..addAll(List.filled(20, 98))
        ..addAll(List.filled(12, 0));
      final expectedNewstDate = date.addCalendarDays(7 * 40 - 1);

      expect(res.weeklyPoints, expectedList);
      expect(res.newestDate, expectedNewstDate);
    });
  });
}
