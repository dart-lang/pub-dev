// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/tool/backfill/backfill_new_buckets.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('backfillNewArchiveBuckets', () {
    testWithProfile('no update', fn: () async {
      final counts1 = await backfillNewArchiveBuckets();
      expect(counts1, {
        'canonical-checked': 6,
        'canonical-unchanged': 6,
        'public-checked': 6,
        'public-unchanged': 6,
      });

      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final counts2 = await backfillNewArchiveBuckets();
      expect(counts2, {
        'canonical-checked': 6,
        'canonical-unchanged': 6,
        'public-checked': 6,
        'public-unchanged': 5,
        'public-copied': 1
      });
    });

    testWithProfile('invalid archive', fn: () async {
      await backfillNewArchiveBuckets();

      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.writeBytes('packages/oxygen-1.0.0.tar.gz', <int>[0, 1]);

      final counts = await backfillNewArchiveBuckets();
      expect(counts, {
        'canonical-checked': 6,
        'canonical-unchanged': 6,
        'public-checked': 6,
        'public-unchanged': 5,
        'public-invalid': 1
      });
    });
  });
}
