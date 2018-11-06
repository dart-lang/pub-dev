// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/storage.dart';

/// Returns a valid `gs://` URI for a given [bucket] + [path] combination.
String bucketUri(Bucket bucket, String path) =>
    'gs://${bucket.bucketName}/$path';

Future<Bucket> getOrCreateBucket(Storage storage, String name) async {
  if (!await storage.bucketExists(name)) {
    await storage.createBucket(name);
  }
  return storage.bucket(name);
}
