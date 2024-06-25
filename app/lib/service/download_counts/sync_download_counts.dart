// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';

final Logger _logger = Logger('pub.download_counts');
Map<String, int> _extractDayCounts(Map<String, dynamic> json) {
  final countsList = json['per_version'];
  if (countsList is! List) {
    throw FormatException('"per_version" must be a list.');
  }
  final dayCounts = <String, int>{};
  countsList.forEach((e) {
    if (e is! Map) {
      throw FormatException('"per_version" list entry must be a map.');
    }

    final version = e['version'];
    if (version is! String) {
      throw FormatException('"version" must be a String.');
    }

    final count = e['count'];
    if (count is! String) {
      throw FormatException('"count" must be a String.');
    }

    dayCounts[version] = int.parse(count);
  });

  return dayCounts;
}

Future<bool> processDownloadCounts(
    String downloadCountsFileName, DateTime date) async {
  final downloadCountsBucket =
      storageService.bucket(activeConfiguration.downloadCountsBucketName!);
  Uint8List bytes;
  try {
    bytes = await downloadCountsBucket.readAsBytes(downloadCountsFileName);
  } on Exception {
    _logger.info('Failed to read "$downloadCountsFileName".');
    return false;
  }
  if (bytes.isEmpty) {
    _logger.info('$downloadCountsFileName is empty.');
    return false;
  }

  bool failedLines = false;
  final processedPackages = <String>{};
  final lines = utf8.decode(bytes).split('\n');
  final pool = Pool(10);
  await Future.wait(lines.map((line) async {
    return await pool.withResource(() async {
      if (line.isBlank) {
        return;
      }
      try {
        final data = json.decode(line) as Map<String, dynamic>;
        final dayCounts = _extractDayCounts(data);
        final package = data['package'];
        if (package is! String) {
          throw FormatException('"package" must be a String');
        }

        await downloadCountsBackend.updateDownloadCounts(
            package, dayCounts, date);
        processedPackages.add(package);
      } on FormatException catch (e) {
        _logger.info(
            'Failed to proccess line $line of file $downloadCountsFileName \n'
            '$e');
        failedLines = true;
      }
    });
  }));

  if (failedLines) {
    return false;
  } else {
    final allPackageNames = await packageBackend.allPackageNames().toSet();
    final missingPackages = allPackageNames
      ..removeWhere((p) => processedPackages.contains(p));

    await Future.wait(missingPackages.map((package) async {
      return await pool.withResource(() async {
        await downloadCountsBackend.updateDownloadCounts(package, {}, date);
      });
    }));
    return true;
  }
}

const numberOfSyncDays = 5;
Future<void> syncDownloadCounts() async {
  final today = clock.now();
  final yesterday = today.addCalendarDays(-1);
  final failedFiles = <String>[];

  for (int i = numberOfSyncDays; i > 0; i--) {
    final syncDate = today.addCalendarDays(-i);
    final fileName = [
      'daily_download_counts',
      '${syncDate.year}-${syncDate.month}-${syncDate.day}T00:00:00Z',
      'data-000000000000.jsonl',
    ].join('/');
    final success = await processDownloadCounts(fileName, syncDate);
    if (!success) {
      failedFiles.add(fileName);
    }
  }
  final yesterdayFileName = [
    'daily_download_counts',
    '${yesterday.year}-${yesterday.month}-${yesterday.day}T00:00:00Z',
    'data-000000000000.jsonl',
  ].join('/');

  if (failedFiles.isNotEmpty) {
    _logger
        .shout('Download counts sync was partial. The following files failed:\n'
            '$failedFiles');

    if (failedFiles.length > 1 || failedFiles.first != yesterdayFileName) {
      // We only disregard failure of yesterday's file. Otherwise we consider
      // the sync to be broken.
      throw Exception(
          'Download counts sync was partial. The following files failed:'
          '$failedFiles');
    }
  }
}
