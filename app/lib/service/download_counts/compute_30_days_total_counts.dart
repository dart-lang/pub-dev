// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:math';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

Future<void> compute30DaysTotalTask() async {
  final allDownloadCounts = await downloadCountsBackend.listAllDownloadCounts();
  final totals = await compute30DayTotals(allDownloadCounts);
  await updload30DaysTotal(totals);
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

Future<void> updload30DaysTotal(Map<String, int> counts) async {
  final reportsBucket =
      storageService.bucket(activeConfiguration.reportsBucketName!);
  await uploadBytesWithRetry(reportsBucket, downloadCounts30DaysTotalsFileName,
      jsonUtf8Encoder.convert(counts));
}
