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
      final changes =
          await updatePublicArchiveBucket(ageCheckThreshold: Duration.zero);
      expect(changes.archivesUpdated, 0);
      expect(changes.archivesToBeDeleted, 0);
      expect(changes.archivesDeleted, 0);
    });

    testWithProfile('missing file', fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final changes =
          await updatePublicArchiveBucket(ageCheckThreshold: Duration.zero);
      expect(changes.archivesUpdated, 1);
      expect(changes.archivesToBeDeleted, 0);
      expect(changes.archivesDeleted, 0);

      final changes2 =
          await updatePublicArchiveBucket(ageCheckThreshold: Duration.zero);
      expect(changes2.archivesUpdated, 0);
      expect(changes.archivesToBeDeleted, 0);
      expect(changes2.archivesDeleted, 0);
    });

    testWithProfile('extra file', fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.writeBytes('xyz.txt', [1]);

      // recent file gets ignored
      final recent = await updatePublicArchiveBucket();
      expect(recent.archivesUpdated, 0);
      expect(recent.archivesToBeDeleted, 0);
      expect(recent.archivesDeleted, 0);

      // non-recent file will get deleted
      final changes =
          await updatePublicArchiveBucket(ageCheckThreshold: Duration.zero);
      expect(changes.archivesUpdated, 0);
      expect(changes.archivesToBeDeleted, 1);
      expect(changes.archivesDeleted, 0);

      // non-recent file is deleted
      final changes2 = await updatePublicArchiveBucket(
        ageCheckThreshold: Duration.zero,
        deleteIfOlder: Duration.zero,
      );
      expect(changes2.archivesUpdated, 0);
      expect(changes2.archivesToBeDeleted, 0);
      expect(changes2.archivesDeleted, 1);

      // second round should report 0 deleted
      final changes3 =
          await updatePublicArchiveBucket(ageCheckThreshold: Duration.zero);
      expect(changes3.archivesUpdated, 0);
      expect(changes3.archivesToBeDeleted, 0);
      expect(changes3.archivesDeleted, 0);
    });
  });
}
