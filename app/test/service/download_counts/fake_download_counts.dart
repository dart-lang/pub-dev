// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/configuration.dart';

Future<void> generateFakeDownloadCounts(
    String downloadCountsFileName, String dataFilePath) async {
  final file = File(dataFilePath).readAsBytesSync();
  await storageService
      .bucket(activeConfiguration.downloadCountsBucketName!)
      .writeBytes(downloadCountsFileName, file);
}
