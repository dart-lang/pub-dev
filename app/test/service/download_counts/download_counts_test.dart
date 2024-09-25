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
      await processDownloadCounts(date);

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
      await processDownloadCounts(date);

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
      await processDownloadCounts(nextDate);

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
      Set<String> failedFiles;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        failedFiles = await processDownloadCounts(nextDate);
      } finally {
        await subscription.cancel();
      }
      expect(failedFiles, isNotEmpty);
      expect(messages.first, contains('Failed to proccess line'));
      expect(messages.first,
          contains('FormatException: "count" must be a String.'));
      // We still process the lines that are possible
      final countData =
          await downloadCountsBackend.lookupDownloadCountData('oxygen');
      expect(countData, isNotNull);
      expect(countData!.newestDate, nextDate);

      final neonCountData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(neonCountData, isNull);
    });

    testWithProfile('with non-existing package', fn: () async {
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
              'fake_download_counts_data_non_existing_package.jsonl'));
      Set<String> failedFiles;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        failedFiles = await processDownloadCounts(nextDate);
      } finally {
        await subscription.cancel();
      }
      expect(failedFiles, isEmpty);
      expect(messages.first, contains('Could not find `package "hest"`.'));
      // We still process the lines that are possible
      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate, nextDate);

      final hestCountData =
          await downloadCountsBackend.lookupDownloadCountData('hest');
      expect(hestCountData, isNull);
    });

    testWithProfile('file not present', fn: () async {
      final nextDate = DateTime.parse('2024-01-06');
      Set<String> failedFiles;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        failedFiles = await processDownloadCounts(nextDate);
      } finally {
        await subscription.cancel();
      }

      expect(failedFiles, isNotEmpty);
      expect(messages.first, contains('Failed to read'));
    });

    testWithProfile('empty file', fn: () async {
      final nextDate = DateTime.parse('2024-01-06');
      final downloadCountsJsonFileNameJan6 =
          'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl';
      await generateFakeDownloadCounts(
          downloadCountsJsonFileNameJan6,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data_empty.jsonl'));
      Set<String> failedFiles;
      final messages = <String>[];
      final subscription = Logger.root.onRecord.listen((event) {
        messages.add(event.message);
      });
      try {
        failedFiles = await processDownloadCounts(nextDate);
      } finally {
        await subscription.cancel();
      }

      expect(failedFiles, isNotEmpty);
      expect(
          messages,
          contains(
              'daily_download_counts/2024-01-06T00:00:00Z/data-000000000000.jsonl is empty.'));
    });

    testWithProfile('Sync download counts - success', fn: () async {
      final today = clock.now();

      for (int i = defaultNumberOfSyncDays; i > 0; i--) {
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

    testWithProfile('Sync download counts with non defaults - success',
        fn: () async {
      final customSyncDays = 3;
      final customDate = DateTime.parse('2014-05-29');

      for (int i = 0; i < customSyncDays; i++) {
        final date = customDate.addCalendarDays(-i);
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

      await syncDownloadCounts(
          date: customDate, numberOfSyncDays: customSyncDays);
      final countData =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countData, isNotNull);
      expect(countData!.newestDate!.day, customDate.day);
      expect(
        countData.totalCounts.take(customSyncDays + 1).toList(),
        List.filled(customSyncDays + 1, 1)..[customSyncDays] = -1,
      );
      expect(
        countData.majorRangeCounts.first.counts.take(customSyncDays + 1),
        List.filled(customSyncDays + 1, 1)..[customSyncDays] = 0,
      );
    });

    testWithProfile('Sync download counts - last day fails', fn: () async {
      final today = clock.now();
      final yesterday = today.addCalendarDays(-1);

      for (int i = defaultNumberOfSyncDays; i > 1; i--) {
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
          messages.first,
          contains('Failed to read any files with prefix '
              '"daily_download_counts/'
              '${formatDateForFileName(yesterday)}'
              '/data-'));
      expect(
          messages,
          contains(
              'Download counts sync was partial. The following files failed:\n'
              '[daily_download_counts/${formatDateForFileName(yesterday)}'
              '/data-]'));
    });

    testWithProfile('Sync download counts - fail', fn: () async {
      final today = clock.now();
      final skippedDate = today.addCalendarDays(-defaultNumberOfSyncDays);

      for (int i = defaultNumberOfSyncDays - 1; i > 0; i--) {
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

      var exception = '';
      try {
        await syncDownloadCounts();
      } on Exception catch (e) {
        exception = e.toString();
      } finally {
        await subscription.cancel();
      }
      expect(
          messages[messages.length - 2],
          contains('Failed to read any files with prefix '
              '"daily_download_counts/'
              '${formatDateForFileName(skippedDate)}'
              '/data-'));

      expect(
          exception,
          'Exception: Download counts sync was partial. The following files failed:'
          '[daily_download_counts/'
          '${formatDateForFileName(skippedDate)}'
          '/data-]');

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

    testWithProfile('Sync download counts several data files - success',
        fn: () async {
      final today = clock.now();

      for (int i = defaultNumberOfSyncDays; i > 0; i--) {
        final date = today.addCalendarDays(-i);
        final fileName = [
          'daily_download_counts',
          formatDateForFileName(date),
          'data-000000000000.jsonl',
        ].join('/');

        final fileName1 = [
          'daily_download_counts',
          formatDateForFileName(date),
          'data-000000000001.jsonl',
        ].join('/');

        await generateFakeDownloadCounts(
          fileName,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data.jsonl'),
        );

        await generateFakeDownloadCounts(
          fileName1,
          path.join(Directory.current.path, 'test', 'service',
              'download_counts', 'fake_download_counts_data1.jsonl'),
        );
      }

      await syncDownloadCounts();
      final countDataNeon =
          await downloadCountsBackend.lookupDownloadCountData('neon');
      expect(countDataNeon, isNotNull);
      expect(countDataNeon!.newestDate!.day, today.addCalendarDays(-1).day);
      expect(
        countDataNeon.totalCounts.take(6).toList(),
        [1, 1, 1, 1, 1, -1],
      );
      expect(
        countDataNeon.majorRangeCounts.first.counts.take(6),
        [1, 1, 1, 1, 1, 0],
      );

      final countDataFT = await downloadCountsBackend
          .lookupDownloadCountData('flutter_titanium');
      expect(countDataFT, isNotNull);
      expect(countDataFT!.newestDate!.day, today.addCalendarDays(-1).day);
      expect(
        countDataFT.totalCounts.take(6).toList(),
        [1, 1, 1, 1, 1, -1],
      );
      expect(
        countDataFT.majorRangeCounts.first.counts.take(6),
        [1, 1, 1, 1, 1, 0],
      );
    });
  });

  testWithProfile('Sync download counts several data files - success & failure',
      fn: () async {
    final today = clock.now();

    for (int i = defaultNumberOfSyncDays; i > 0; i--) {
      final date = today.addCalendarDays(-i);
      final fileName = [
        'daily_download_counts',
        formatDateForFileName(date),
        'data-000000000000.jsonl',
      ].join('/');

      final fileName1 = [
        'daily_download_counts',
        formatDateForFileName(date),
        'data-000000000001.jsonl',
      ].join('/');

      await generateFakeDownloadCounts(
        fileName,
        path.join(Directory.current.path, 'test', 'service', 'download_counts',
            'fake_download_counts_data.jsonl'),
      );

      await generateFakeDownloadCounts(
        fileName1,
        path.join(Directory.current.path, 'test', 'service', 'download_counts',
            'fake_download_counts_data_empty.jsonl'),
      );
    }
    String exception = '';
    try {
      await syncDownloadCounts();
    } on Exception catch (e) {
      exception = e.toString();
    }
    final countDataNeon =
        await downloadCountsBackend.lookupDownloadCountData('neon');
    expect(countDataNeon, isNotNull);
    expect(countDataNeon!.newestDate!.day, today.addCalendarDays(-1).day);
    expect(
      countDataNeon.totalCounts.take(6).toList(),
      [1, 1, 1, 1, 1, -1],
    );
    expect(
      countDataNeon.majorRangeCounts.first.counts.take(6),
      [1, 1, 1, 1, 1, 0],
    );

    expect(
        exception,
        contains(
            'Exception: Download counts sync was partial. The following files failed:'
            '[daily_download_counts/'
            '${formatDateForFileName(today.addCalendarDays(-1))}'
            '/data-000000000001.jsonl'));

    final countDataFT =
        await downloadCountsBackend.lookupDownloadCountData('flutter_titanium');
    expect(countDataFT, isNotNull);
    expect(countDataFT!.newestDate!.day, today.addCalendarDays(-1).day);
    expect(
      countDataFT.totalCounts.take(6).toList(),
      [0, 0, 0, 0, 0, -1],
    );
  });
  testWithProfile('Sync download counts several data files - failure',
      fn: () async {
    final today = clock.now();

    final goodDate = today.addCalendarDays(-2);
    final fileName = [
      'daily_download_counts',
      formatDateForFileName(goodDate),
      'data-000000000000.jsonl',
    ].join('/');

    final fileName1 = [
      'daily_download_counts',
      formatDateForFileName(goodDate),
      'data-000000000001.jsonl',
    ].join('/');

    await generateFakeDownloadCounts(
      fileName,
      path.join(Directory.current.path, 'test', 'service', 'download_counts',
          'fake_download_counts_data.jsonl'),
    );

    await generateFakeDownloadCounts(
      fileName1,
      path.join(Directory.current.path, 'test', 'service', 'download_counts',
          'fake_download_counts_data1.jsonl'),
    );
    final faultyDate = today.addCalendarDays(-1);
    final fileName2 = [
      'daily_download_counts',
      formatDateForFileName(faultyDate),
      'data-000000000000.jsonl',
    ].join('/');

    final fileName3 = [
      'daily_download_counts',
      formatDateForFileName(faultyDate),
      'data-000000000001.jsonl',
    ].join('/');

    await generateFakeDownloadCounts(
      fileName2,
      path.join(Directory.current.path, 'test', 'service', 'download_counts',
          'fake_download_counts_data_empty.jsonl'),
    );

    await generateFakeDownloadCounts(
      fileName3,
      path.join(Directory.current.path, 'test', 'service', 'download_counts',
          'fake_download_counts_data_empty.jsonl'),
    );

    String exception = '';
    try {
      await syncDownloadCounts();
    } on Exception catch (e) {
      exception = e.toString();
    }
    final countDataNeon =
        await downloadCountsBackend.lookupDownloadCountData('neon');
    expect(countDataNeon, isNotNull);
    expect(countDataNeon!.newestDate!.day, goodDate.day);
    expect(
      countDataNeon.totalCounts.take(6).toList(),
      [1, -1, -1, -1, -1, -1],
    );
    expect(
      countDataNeon.majorRangeCounts.first.counts.take(6),
      [1, 0, 0, 0, 0, 0],
    );

    expect(
        exception,
        contains(
            'Exception: Download counts sync was partial. The following files failed:'
            '[daily_download_counts/'
            '${formatDateForFileName(faultyDate)}'
            '/data-000000000000.jsonl'));

    final countDataFT =
        await downloadCountsBackend.lookupDownloadCountData('flutter_titanium');
    expect(countDataFT, isNotNull);
    expect(countDataFT!.newestDate!.day, goodDate.day);
    expect(
      countDataFT.totalCounts.take(6).toList(),
      [1, -1, -1, -1, -1, -1],
    );
    expect(
      countDataFT.majorRangeCounts.first.counts.take(6),
      [1, 0, 0, 0, 0, 0],
    );
  });
}
