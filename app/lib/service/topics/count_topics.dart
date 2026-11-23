// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import '../../database/schema.dart';

final topicsJsonFileName = 'topics.json';

Future<void> countTopics() async {
  final topics = <String, int>{};

  await for (final p in packageBackend.allPackageLatestVersions()) {
    final v = await packageBackend.lookupPackageVersion(
      p.name,
      p.latestVersion,
    );
    if (v == null) {
      continue;
    }
    for (final t in v.pubspec.canonicalizedTopics) {
      topics.update(t, (value) => value + 1, ifAbsent: () => 1);
    }
  }

  final reportsBucket = storageService.bucket(
    activeConfiguration.reportsBucketName!,
  );
  await uploadBytesWithRetry(
    reportsBucket,
    topicsJsonFileName,
    jsonUtf8Encoder.convert(topics),
  );
}
