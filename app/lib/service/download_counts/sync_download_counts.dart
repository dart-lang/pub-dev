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
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/storage.dart';

final Logger _logger = Logger('pub.download_counts');

/// Extract map from version to download counts for a given day.
///
/// Expects input on the form:
/// ```json
/// {
///   "per_version": [
///     {"version": "<version>", "count": "<count>"},
///     ...
///   ]
/// }
/// ```
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
  } on Exception catch (e) {
    _logger.info('Failed to read "$downloadCountsFileName"./n'
        '$e');
    return false;
  }
  if (bytes.isEmpty) {
    _logger.severe('$downloadCountsFileName is empty.');
    return false;
  }

  bool hasFailedLines = false;
  // Before '2024-05-03' the query generating the download count data had a bug
  // in the reg exp causing incorrect versions to be stored.
  final regExpQueryFixDate = DateTime.parse('2024-05-03');
  final processedPackages = <String>{};
  var lines = <String>[];

  try {
    lines = utf8.decode(bytes).split('\n');
  } on FormatException catch (e) {
    _logger.severe('Failed to utf8 decode bytes of $downloadCountsFileName/n'
        '$e');
    return false;
  }

  final pool = Pool(10);
  await Future.wait(lines.map((line) async {
    return await pool.withResource(() async {
      if (line.isBlank) {
        return;
      }
      final String package;
      final Map<String, int> dayCounts;
      try {
        final data = json.decode(line);
        if (data is! Map<String, dynamic>) {
          throw FormatException('Download counts data is not valid json');
        }

        if (data['package'] is! String) {
          throw FormatException('"package" must be a String');
        }
        package = data['package'] as String;
        processedPackages.add(package);

        dayCounts = _extractDayCounts(data);
      } on FormatException catch (e) {
        _logger.severe(
            'Failed to proccess line $line of file $downloadCountsFileName \n'
            '$e');
        hasFailedLines = true;
        return;
      }

      List<String> versions;
      try {
        // Validate that the package and version exist and ignore the
        // non-existing packages and versions.
        // First do it via the cached data, fall back to query for invisible
        // and moderated packages.
        versions = (await packageBackend.listVersionsCached(package))
            .versions
            .map((e) => e.version)
            .toList();

        final nonExistingVersions = <String>[];
        dayCounts.keys.forEach((version) {
          if (!versions.contains(version)) {
            nonExistingVersions.add(version);
            if (date.isBefore(regExpQueryFixDate)) {
              // If the data is generated before the fix of the query, we
              // ignore versions that do not exist.
              _logger.warning(
                  '$package-$version appeared in download counts data but does'
                  ' not exist');
            } else {
              _logger.severe(
                  '$package-$version appeared in download counts data but does'
                  ' not exist');
            }
          }
        });

        nonExistingVersions.forEach((v) => dayCounts.remove(v));
      } on NotFoundException catch (e) {
        final pkg = await packageBackend.lookupPackage(package);
        // The package is neither invisible or tombstoned, hence there is
        // probably an error in the generated data.
        if (pkg == null &&
            (await packageBackend.lookupModeratedPackage(package)) == null) {
          _logger.severe(
              'Package $package appeared in download counts data for file '
              '$downloadCountsFileName but does not exist.\n'
              'Error: $e');
          return;
        } // else {
        // The package is either invisible, tombstoned or has no versions.
        // }
      }

      await downloadCountsBackend.updateDownloadCounts(
        package,
        dayCounts,
        date,
      );
    });
  }));

  // Record zero downloads for this date for packages not mentioned in the
  // query output.
  final allPackageNames = await packageBackend.allPackageNames().toSet();
  final missingPackages = allPackageNames.difference(processedPackages.toSet());
  await Future.wait(missingPackages.map((package) async {
    return await pool.withResource(() async {
      // Calling 'updateDownloadCounts' for 'package' with an empty dataset
      // causes '0' to be added for all versions, hereby indicating 0 downloads.
      await downloadCountsBackend.updateDownloadCounts(package, {}, date);
    });
  }));
  return !hasFailedLines;
}

const defaultNumberOfSyncDays = 5;

/// Synchronizes the download counts backend with download counts data from
/// [date] and [numberOfSyncDays] going back.
///
/// For instance, if the [date] represents '2024-05-29' and [numberOfSyncDays]
/// is '3', data will be synced for '2024-05-27', '2024-05-28', and
/// '2024-05-29'.
///
/// If [date] or [numberOfSyncDays] are not provided the defaults are
/// yesterday's date and [defaultNumberOfSyncDays] respectively.
///
/// Reads each of the daily download counts files from the Cloud storage bucket
/// and processes the data. If processing of a file fails it will still continue
/// with the other files.
///
/// Throws an exception if one or more of the syncs fail except if the only
/// failed file is that of yesterday. We expect this function to be called at
/// least once per day, hence tolerating that yesterday's data is not yet ready.
Future<void> syncDownloadCounts(
    {DateTime? date, int numberOfSyncDays = defaultNumberOfSyncDays}) async {
  final yesterday = clock.now().addCalendarDays(-1);
  final startingDate = date ?? yesterday;
  final failedFiles = <String>[];

  for (int i = 0; i < numberOfSyncDays; i++) {
    final syncDate = startingDate.addCalendarDays(-i);
    // TODO(zarah): Handle the case where there is more than one file per day.
    final fileName = [
      'daily_download_counts',
      formatDateForFileName(syncDate),
      'data-000000000000.jsonl',
    ].join('/');
    final success = await processDownloadCounts(fileName, syncDate);
    if (!success) {
      failedFiles.add(fileName);
    }
  }
  final yesterdayFileName = [
    'daily_download_counts',
    formatDateForFileName(yesterday),
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

String formatDateForFileName(DateTime date) {
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-${day}T00:00:00Z';
}
