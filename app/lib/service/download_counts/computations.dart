// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:math';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../shared/redis_cache.dart' show cache;

Future<void> compute30DaysTotalTask() async {
  final allDownloadCounts = await downloadCountsBackend.listAllDownloadCounts();
  final totals = await compute30DayTotals(allDownloadCounts);
  await upload30DaysTotal(totals);
}

Future<Map<String, int>> compute30DayTotals(
    Stream<DownloadCounts> downloadCounts) async {
  final res = <String, int>{};
  await for (final dc in downloadCounts) {
    res[dc.package] = compute30DayTotal(dc);
  }

  return res;
}

int compute30DayTotal(DownloadCounts downloadCounts) {
  final totals = downloadCounts.countData.totalCounts;
  return totals
      .take(30)
      .fold(0, (previousValue, element) => previousValue + max(0, element));
}

final downloadCounts30DaysTotalsFileName = 'download-counts-30-days-total.json';

Future<void> upload30DaysTotal(Map<String, int> counts) async {
  final reportsBucket =
      storageService.bucket(activeConfiguration.reportsBucketName!);
  await uploadBytesWithRetry(reportsBucket, downloadCounts30DaysTotalsFileName,
      jsonUtf8Encoder.convert(counts));
}

Future<WeeklyDownloadCounts?> getWeeklyTotalDownloads(String package) async {
  return (await cache.weeklyDownloadCounts(package).get(() async {
    return computeWeeklyTotalDownloads(package);
  }));
}

Future<WeeklyVersionDownloadCounts?> getWeeklyVersionDownloads(
    String package) async {
  return (await cache.weeklyVersionDownloadCounts(package).get(() async {
    return computeWeeklyVersionDownloads(package);
  }));
}

/// Computes weekly downloads starting from `newestDate` for [package] and 52
/// weeks back.
///
/// Each number in weeklyDownloads` is the total number of downloads for
/// a given 7 day period starting from the newest date with download counts
/// data available.
Future<WeeklyDownloadCounts?> computeWeeklyTotalDownloads(
    String package) async {
  final countData =
      await downloadCountsBackend.lookupDownloadCountData(package);
  if (countData == null) {
    return null;
  }

  return WeeklyDownloadCounts(
      weeklyDownloads: _computeWeeklyCounts(countData.totalCounts),
      newestDate: countData.newestDate!);
}

/// Computes weekly downloads starting from `newestDate` for [package] and 52
/// weeks back for all stored major, minor, and patch version ranges and total
/// downloads.
Future<WeeklyVersionDownloadCounts?> computeWeeklyVersionDownloads(
    String package) async {
  final countData =
      await downloadCountsBackend.lookupDownloadCountData(package);
  if (countData == null) return null;

  final majorRangeWeeklyCounts = <VersionRangeCount>[];
  countData.majorRangeCounts.forEach((vrc) {
    majorRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange
    ));
  });
  final minorRangeWeeklyCounts = <VersionRangeCount>[];
  countData.minorRangeCounts.forEach((vrc) {
    minorRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange
    ));
  });
  final patchRangeWeeklyCounts = <VersionRangeCount>[];
  countData.patchRangeCounts.forEach((vrc) {
    patchRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange
    ));
  });

  final weeklyTotalCounts = _computeWeeklyCounts(countData.totalCounts);

  return WeeklyVersionDownloadCounts(
      newestDate: countData.newestDate!,
      majorRangeWeeklyDownloads: majorRangeWeeklyCounts,
      minorRangeWeeklyDownloads: minorRangeWeeklyCounts,
      patchRangeWeeklyDownloads: patchRangeWeeklyCounts,
      totalWeeklyDownloads: weeklyTotalCounts);
}

List<int> _computeWeeklyCounts(List<int> dailyCounts) {
  final weeklyCounts = List.filled(52, 0);
  for (int w = 0; w < 52; w++) {
    var sum = 0;
    for (int d = 0; d < 7; d++) {
      if (dailyCounts[w * 7 + d] > 0) {
        sum += dailyCounts[w * 7 + d];
      }
    }
    weeklyCounts[w] = sum;
  }
  return weeklyCounts;
}
