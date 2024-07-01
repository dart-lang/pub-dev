// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:io';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/sync_download_counts.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';
import 'fake_download_counts.dart';

void main() {
  group('', () {
    testWithProfile('Ingest download counts', fn: () async {
      final pkg = 'test';
      final downloadCounts =
          await downloadCountsBackend.lookupDownloadCountData(pkg);
      expect(downloadCounts, isNull);

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
      final updatedDownloadCounts = await downloadCountsBackend
          .updateDownloadCounts(pkg, versionsCounts, date);
      expect(updatedDownloadCounts, isNotNull);
      expect(updatedDownloadCounts.package, pkg);
      expect(updatedDownloadCounts.countData, isNotNull);
      expect(updatedDownloadCounts.countData.majorRangeCounts.length, 5);
      expect(updatedDownloadCounts.countData.totalCounts[0], 14);

      final countData =
          await downloadCountsBackend.lookupDownloadCountData(pkg);
      expect(countData, isNotNull);
      expect(countData!.majorRangeCounts.length, 5);
      expect(countData.totalCounts[0], 14);
    });

    testWithProfile('process download counts', fn: () async {
      final date = DateTime.parse('2024-01-05');
      final downloadCountsJsonFileName =
          'daily_download_counts/2024-01-05T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileName,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'));
      await processDownloadCounts(downloadCountsJsonFileName, date);

      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.totalCounts.first, 1);
      expect(countData.totalCounts.last, -1);
      expect(countData.majorRangeCounts.first.counts.first, 1);
      expect(countData.majorRangeCounts.first.counts.last, 0);
    });

    testWithProfile(
        'Process download counts - 0 count for unmentioned packages',
        fn: () async {
      final date = DateTime.parse('2024-01-05');
      final downloadCountsJsonFileNameJan5 =
          'daily_download_counts/2024-01-05T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileNameJan5,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'));
      await processDownloadCounts(downloadCountsJsonFileNameJan5, date);

      final nextDate = DateTime.parse('2024-01-06');
      final downloadCountsJsonFileNameJan6 =
          'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileNameJan6,
          path.join(
              Directory.current.path,
              'test',
              'service',
              'download_counts',
              'fake_download_counts_data_less_packages.jsonl'));
      await processDownloadCounts(downloadCountsJsonFileNameJan6, nextDate);

      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate, nextDate);

      // Packages not mentioned in json file should be updated with '0's on the
      // processed date.
      expect(
        countData.totalCounts.take(3),
        [0, 1, -1], // January 6th, 5th, 4th
      );

      expect(
        countData.majorRangeCounts.first.counts.take(3),
        [0, 1, 0], // January 6th, 5th, 4th
      );
    });

    testWithProfile('with faulty line', fn: () async {
      final nextDate = DateTime.parse('2024-01-06');
      final downloadCountsJsonFileNameJan6 =
          'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileNameJan6,
          path.join(
              Directory.current.path,
              'test',
              'service',
              'download_counts',
              'fake_download_counts_data_faulty_line.jsonl'));
      bool succeeded;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        succeeded = await processDownloadCounts(
            downloadCountsJsonFileNameJan6, nextDate);
      } finally {
        await subscription.cancel();
      }
      expect(succeeded, false);
      expect(
          messages,
          contains('Failed to proccess line '
              '{"package":"neon","total":"1","per_version":[{"version":"0.1.0","count":1}]} '
              'of file daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl \n'
              'FormatException: "count" must be a String.'));
      // We still process the lines that are possible
      final countData =
          await downloadCountsBackend.lookupDownloadCountData('analyzer');
      expect(countData, isNotNull);
      expect(countData!.newestDate, nextDate);

      final neonCountData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(neonCountData, isNull);
    });

    testWithProfile('file not present', fn: () async {
      final nextDate = DateTime.parse('2024-01-06');
      bool succeeded;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        succeeded =
            await processDownloadCounts('this_file_does_not_exist', nextDate);
      } finally {
        await subscription.cancel();
      }

      expect(succeeded, false);
      expect(messages, contains('Failed to read "this_file_does_not_exist".'));
    });

    testWithProfile('empty file', fn: () async {
      final nextDate = DateTime.parse('2024-01-06');
      final downloadCountsJsonFileNameJan6 =
          'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileNameJan6,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data_empty.jsonl'));
      bool succeeded;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        succeeded = await processDownloadCounts(
            downloadCountsJsonFileNameJan6, nextDate);
      } finally {
        await subscription.cancel();
      }

      expect(succeeded, false);
      expect(
          messages,
          contains(
              'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl is empty.'));
    });

    testWithProfile('Sync download counts - success', fn: () async {
      final today = clock.now();

      for (int i = numberOfSyncDays; i > 0; i--) {
        final date = today.addCalendarDays(-i);
        final fileName = [
          'daily_download_counts',
          formatDateForFileName(date),
          'data-000000000000.jsonl',
        ].join('/');
        await generateFakeDownloadCounts(
          fileName,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'),
        );
      }

      await syncDownloadCounts();
      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate!.day, today.addCalendarDays(-1).day);
      expect(
        countData.totalCounts.take(6).toList(),
        [1, 1, 1, 1, 1, -1],
      );
      expect(
        countData.majorRangeCounts.first.counts.take(6),
        [1, 1, 1, 1, 1, 0],
      );
    });

    testWithProfile('Sync download counts - last day fails', fn: () async {
      final today = clock.now();
      final yesterday = today.addCalendarDays(-1);

      for (int i = numberOfSyncDays; i > 1; i--) {
        final date = today.addCalendarDays(-i);
        final fileName = [
          'daily_download_counts',
          formatDateForFileName(date),
          'data-000000000000.jsonl',
        ].join('/');
        await generateFakeDownloadCounts(
          fileName,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'),
        );
      }

      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        await syncDownloadCounts();
      } finally {
        await subscription.cancel();
      }

      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate!.day, today.addCalendarDays(-2).day);
      expect(
        countData.totalCounts.take(6).toList(),
        [1, 1, 1, 1, -1, -1],
      );
      expect(
        countData.majorRangeCounts.first.counts.take(6),
        [1, 1, 1, 1, 0, 0],
      );
      expect(
          messages,
          contains('Failed to read '
              '"daily_download_counts/'
              '${formatDateForFileName(yesterday)}'
              '/data-000000000000.jsonl".'));
      print(messages);
      expect(
          messages,
          contains(
              'Download counts sync was partial. The following files failed:\n'
              '[daily_download_counts/${formatDateForFileName(yesterday)}'
              '/data-000000000000.jsonl]'));
    });

    testWithProfile('Sync download counts - fail', fn: () async {
      final today = clock.now();
      final skippedDate = today.addCalendarDays(-numberOfSyncDays);

      for (int i = numberOfSyncDays - 1; i > 0; i--) {
        final date = today.addCalendarDays(-i);
        final fileName = [
          'daily_download_counts',
          formatDateForFileName(date),
          'data-000000000000.jsonl',
        ].join('/');
        await generateFakeDownloadCounts(
          fileName,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'),
        );
      }
      var exception = '';
      try {
        await syncDownloadCounts();
      } on Exception catch (e) {
        exception = e.toString();
      }

      expect(
          exception,
          'Exception: Download counts sync was partial. The following files failed:'
          '[daily_download_counts/'
          '${formatDateForFileName(skippedDate)}'
          '/data-000000000000.jsonl]');

      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate!.day, today.addCalendarDays(-1).day);
      expect(
        countData.totalCounts.take(6).toList(),
        [1, 1, 1, 1, -1, -1],
      );
      expect(
        countData.majorRangeCounts.first.counts.take(6),
        [1, 1, 1, 1, 0, 0],
      );
    });
  });
}
