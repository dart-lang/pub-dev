// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/service/download_counts/computations.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

Future<void> generateFakeDownloadCounts(
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
