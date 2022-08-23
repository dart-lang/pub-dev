// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('update public bucket', () {
    testWithProfile('no update', fn: () async {
      final updated = await updatePublicArchiveBucket();
      expect(updated, 0);
    });

    testWithProfile('missing file', fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final updated = await updatePublicArchiveBucket();
      expect(updated, 1);
    });
  });
}
