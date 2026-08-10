// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:math';

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/service/download_counts/package_trends.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

import '../../shared/redis_cache.dart' show cache;

Future<void> computeTrendScoreTask() async {
  final trendScores = await computeTrend();
  await uploadTrendScores(trendScores);
}

Future<Map<String, double>> computeTrend() async {
  final res = <String, double>{};

  await for (final pkg in packageBackend.allPackages()) {
    final name = pkg.name!;
    final downloads =
        (await downloadCountsBackend.lookupDownloadCountData(
          name,
        ))?.totalCounts ??
        [0];

    res[name] = computeTrendScore(downloads);
  }
  return res;
}

final trendScoreFileName = 'trend-scores-v2.json';

Future<void> uploadTrendScores(Map<String, double> trends) async {
  final reportsBucket = storageService.bucket(
    activeConfiguration.reportsBucketName!,
  );
  await uploadBytesWithRetry(
    reportsBucket,
    trendScoreFileName,
    jsonUtf8Encoder.convert(trends),
  );
}

Future<void> compute30DaysTotalTask() async {
  final allDownloadCounts = await downloadCountsBackend.listAllDownloadCounts();
  final totals = await compute30DayTotals(allDownloadCounts);
  await upload30DaysTotal(totals);
}

Future<Map<String, int>> compute30DayTotals(
  Stream<DownloadCounts> downloadCounts,
) async {
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
  final reportsBucket = storageService.bucket(
    activeConfiguration.reportsBucketName!,
  );
  await uploadBytesWithRetry(
    reportsBucket,
    downloadCounts30DaysTotalsFileName,
    jsonUtf8Encoder.convert(counts),
  );
}

Future<WeeklyDownloadCounts?> getWeeklyTotalDownloads(String package) async {
  return (await cache.weeklyDownloadCounts(package).get(() async {
    return computeWeeklyTotalDownloads(package);
  }));
}

Future<WeeklyVersionDownloadCounts?> getWeeklyVersionDownloads(
  String package,
) async {
  return (await cache.weeklyVersionDownloadCounts(package).get(() async {
    return computeWeeklyVersionDownloads(package);
  }));
}

/// Returns daily downloads starting from `newestDate` for [package] and up to
/// 2 years (731 days) back.
///
/// Returns `null` if no download data is available for [package].
Future<DailyDownloadCounts?> getDailyDownloadCounts(String package) async {
  return (await cache.dailyDownloadCounts(package).get(() async {
    return computeDailyDownloadCounts(package);
  }));
}

/// Computes daily downloads starting from `newestDate` for [package] and [days]
/// days back (defaults to 731 days, i.e. 2 years).
///
/// Returns `null` if no download data is available for [package].
Future<DailyDownloadCounts?> computeDailyDownloadCounts(
  String package, {
  int days = maxAge,
}) async {
  final countData = await downloadCountsBackend.lookupDownloadCountData(
    package,
  );
  if (countData == null || countData.newestDate == null) {
    return null;
  }

  final majorRangeDailyCounts = countData.majorRangeCounts
      .map(
        (vrc) => (
          counts: vrc.counts.take(days).toList(),
          versionRange: vrc.versionRange,
        ),
      )
      .toList();
  final minorRangeDailyCounts = countData.minorRangeCounts
      .map(
        (vrc) => (
          counts: vrc.counts.take(days).toList(),
          versionRange: vrc.versionRange,
        ),
      )
      .toList();
  final patchRangeDailyCounts = countData.patchRangeCounts
      .map(
        (vrc) => (
          counts: vrc.counts.take(days).toList(),
          versionRange: vrc.versionRange,
        ),
      )
      .toList();

  return DailyDownloadCounts(
    newestDate: countData.newestDate!,
    totalDailyDownloads: countData.totalCounts.take(days).toList(),
    majorRangeDailyDownloads: majorRangeDailyCounts,
    minorRangeDailyDownloads: minorRangeDailyCounts,
    patchRangeDailyDownloads: patchRangeDailyCounts,
  );
}

/// Computes weekly downloads starting from `newestDate` for [package] and 52
/// weeks back.
///
/// Each number in weeklyDownloads` is the total number of downloads for
/// a given 7 day period starting from the newest date with download counts
/// data available.
Future<WeeklyDownloadCounts?> computeWeeklyTotalDownloads(
  String package,
) async {
  final countData = await downloadCountsBackend.lookupDownloadCountData(
    package,
  );
  if (countData == null) {
    return null;
  }

  return WeeklyDownloadCounts(
    weeklyDownloads: _computeWeeklyCounts(countData.totalCounts),
    newestDate: countData.newestDate!,
  );
}

/// Computes weekly downloads starting from `newestDate` for [package] and 52
/// weeks back for all stored major, minor, and patch version ranges and total
/// downloads.
Future<WeeklyVersionDownloadCounts?> computeWeeklyVersionDownloads(
  String package,
) async {
  final countData = await downloadCountsBackend.lookupDownloadCountData(
    package,
  );
  if (countData == null) return null;

  final majorRangeWeeklyCounts = <VersionRangeCount>[];
  countData.majorRangeCounts.forEach((vrc) {
    majorRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange,
    ));
  });
  final minorRangeWeeklyCounts = <VersionRangeCount>[];
  countData.minorRangeCounts.forEach((vrc) {
    minorRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange,
    ));
  });
  final patchRangeWeeklyCounts = <VersionRangeCount>[];
  countData.patchRangeCounts.forEach((vrc) {
    patchRangeWeeklyCounts.add((
      counts: _computeWeeklyCounts(vrc.counts),
      versionRange: vrc.versionRange,
    ));
  });

  final weeklyTotalCounts = _computeWeeklyCounts(countData.totalCounts);

  return WeeklyVersionDownloadCounts(
    newestDate: countData.newestDate!,
    majorRangeWeeklyDownloads: majorRangeWeeklyCounts,
    minorRangeWeeklyDownloads: minorRangeWeeklyCounts,
    patchRangeWeeklyDownloads: patchRangeWeeklyCounts,
    totalWeeklyDownloads: weeklyTotalCounts,
  );
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
