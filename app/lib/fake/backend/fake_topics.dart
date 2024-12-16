// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';

import '../../service/topics/count_topics.dart';
import '../../shared/configuration.dart';
import '../../shared/storage.dart';
import '../../shared/utils.dart';

Future<void> generateFakeTopicValues() async {
  await storageService
      .bucket(activeConfiguration.reportsBucketName!)
      .writeBytesWithRetry(topicsJsonFileName,
          jsonUtf8Encoder.convert({'ffi': 7, 'ui': 5, 'network': 6}));
}
