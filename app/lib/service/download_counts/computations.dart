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

Future<WeeklyDownloadCounts?> getWeeklyDownloads(String package) async {
  return (await cache.weeklyDownloadCounts(package).get(() async {
    final wdc = await computeWeeklyDownloads(package);
    if (wdc.newestDate == null) {
      return null;
    }
    return WeeklyDownloadCounts(
        weeklyDownloads: wdc.weeklyDownloads, newestDate: wdc.newestDate!);
  }));
}

/// Computes `weeklyDownloads` starting from `newestDate` for [package].
///
/// Each number in `weeklyDownloads` is the total number of downloads for
/// a given 7 day period starting from the newest date with download counts
/// data available.
Future<({List<int> weeklyDownloads, DateTime? newestDate})>
    computeWeeklyDownloads(String package) async {
  final weeklyDownloads = List.filled(52, 0);
  final countData =
      await downloadCountsBackend.lookupDownloadCountData(package);
  if (countData == null) {
    return (weeklyDownloads: <int>[], newestDate: null);
  }

  final totals = countData.totalCounts;

  for (int w = 0; w < 52; w++) {
    var sum = 0;
    for (int d = 0; d < 7; d++) {
      if (totals[w * 7 + d] > 0) {
        sum += totals[w * 7 + d];
      }
    }
    weeklyDownloads[w] = sum;
  }

  return (weeklyDownloads: weeklyDownloads, newestDate: countData.newestDate!);
}
