// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/service/download_counts/backend.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

/// Scans the datastore for packages and generates download count values with a
/// deterministic random seed.
///
/// TODO: generate download counts in bucket first
Future<void> generateFakeDownloadCountsInDatastore() async {
  final query = dbService.query<Package>();
  await for (final p in query.run()) {
    final r = math.Random(p.name.hashCode.abs());
    final count = (math.min(p.likes * p.likes, 50) + r.nextInt(50));
    await downloadCountsBackend.updateDownloadCounts(
      p.name!,
      {
        p.latestVersion!: count,
      },
      clock.now(),
    );
  }
}

Future<void> uploadFakeDownloadCountsToBucket(
    String downloadCountsFileName, String dataFilePath) async {
  final file = File(dataFilePath).readAsBytesSync();
  await storageService
      .bucket(activeConfiguration.downloadCountsBucketName!)
      .writeBytesWithRetry(downloadCountsFileName, file);
}

Future<void> generateFake30DaysTotals(Map<String, int> totals) async {
  await storageService
      .bucket(activeConfiguration.reportsBucketName!)
      .writeBytesWithRetry(
          downloadCounts30DaysTotalsFileName, jsonUtf8Encoder.convert(totals));
}

Future<void> generateFakeTrendScores(Map<String, double> trends) async {
  await storageService
      .bucket(activeConfiguration.reportsBucketName!)
      .writeBytesWithRetry(trendScoreFileName, jsonUtf8Encoder.convert(trends));
}
