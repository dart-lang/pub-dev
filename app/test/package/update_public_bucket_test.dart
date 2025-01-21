// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/tarball_storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('update public bucket', () {
    Future<PublicBucketUpdateStat> _updatePublicArchiveBucket({
      String? package,
      Duration? ageCheckThreshold,
      Duration? deleteIfOlder,
    }) async {
      return await packageBackend.tarballStorage.updatePublicArchiveBucket(
        package: package,
        ageCheckThreshold: ageCheckThreshold ?? Duration.zero,
        deleteIfOlder: deleteIfOlder ?? const Duration(days: 7),
      );
    }

    testWithProfile('no update', fn: () async {
      final changes = await _updatePublicArchiveBucket();
      expect(changes.isAllZero, isTrue);
    });

    testWithProfile('missing file - without package filter', fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final changes = await _updatePublicArchiveBucket();
      expect(changes.archivesUpdated, 1);
      expect(changes.archivesToBeDeleted, 0);
      expect(changes.archivesDeleted, 0);

      final changes2 = await _updatePublicArchiveBucket();
      expect(changes2.isAllZero, isTrue);
    });

    testWithProfile('missing file - with matching package filter',
        fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final changes = await _updatePublicArchiveBucket(package: 'oxygen');
      expect(changes.archivesUpdated, 1);
      expect(changes.archivesToBeDeleted, 0);
      expect(changes.archivesDeleted, 0);

      final changes2 = await _updatePublicArchiveBucket(package: 'oxygen');
      expect(changes2.isAllZero, isTrue);

      final changes3 = await _updatePublicArchiveBucket();
      expect(changes3.isAllZero, isTrue);
    });

    testWithProfile('missing file - with different package filter',
        fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.delete('packages/oxygen-1.0.0.tar.gz');

      final changes = await _updatePublicArchiveBucket(package: 'neon');
      expect(changes.isAllZero, isTrue);

      final changes2 = await _updatePublicArchiveBucket(package: 'neon');
      expect(changes2.isAllZero, isTrue);

      // eventual update
      final changes3 = await _updatePublicArchiveBucket();
      expect(changes3.archivesUpdated, 1);
      expect(changes3.archivesToBeDeleted, 0);
      expect(changes3.archivesDeleted, 0);
    });

    testWithProfile('extra file - without package filter',
        expectedLogMessages: [
          'SHOUT Object from public bucket will be deleted: "packages/oxygen-0.0.99.tar.gz".',
          'SHOUT Deleting object from public bucket: "packages/oxygen-0.0.99.tar.gz".',
        ], fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.writeBytes('packages/oxygen-0.0.99.tar.gz', [1]);

      // recent file gets ignored
      final recent = await _updatePublicArchiveBucket(
          ageCheckThreshold: Duration(days: 1));
      expect(recent.isAllZero, isTrue);

      // non-recent file will get deleted
      final changes = await _updatePublicArchiveBucket();
      expect(changes.archivesUpdated, 0);
      expect(changes.archivesToBeDeleted, 1);
      expect(changes.archivesDeleted, 0);

      // non-recent file is deleted
      final changes2 = await _updatePublicArchiveBucket(
        deleteIfOlder: Duration.zero,
      );
      expect(changes2.archivesUpdated, 0);
      expect(changes2.archivesToBeDeleted, 0);
      expect(changes2.archivesDeleted, 1);

      // second round should report 0 deleted
      final changes3 = await _updatePublicArchiveBucket();
      expect(changes3.isAllZero, isTrue);
    });

    testWithProfile('extra file - with matching package filter',
        expectedLogMessages: [
          'SHOUT Object from public bucket will be deleted: "packages/oxygen-0.0.99.tar.gz".',
          'SHOUT Deleting object from public bucket: "packages/oxygen-0.0.99.tar.gz".',
        ], fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.writeBytes('packages/oxygen-0.0.99.tar.gz', [1]);

      // recent file gets ignored
      final recent = await _updatePublicArchiveBucket(
          ageCheckThreshold: Duration(days: 1));
      expect(recent.isAllZero, isTrue);

      // non-recent file will get deleted
      final changes = await _updatePublicArchiveBucket(package: 'oxygen');
      expect(changes.archivesUpdated, 0);
      expect(changes.archivesToBeDeleted, 1);
      expect(changes.archivesDeleted, 0);

      // non-recent file is deleted
      final changes2 = await _updatePublicArchiveBucket(
        package: 'oxygen',
        deleteIfOlder: Duration.zero,
      );
      expect(changes2.archivesUpdated, 0);
      expect(changes2.archivesToBeDeleted, 0);
      expect(changes2.archivesDeleted, 1);

      // second round should report 0 deleted
      final changes3 = await _updatePublicArchiveBucket(package: 'oxygen');
      expect(changes3.isAllZero, isTrue);

      // no further changes
      final changes4 = await _updatePublicArchiveBucket();
      expect(changes4.isAllZero, isTrue);
    });

    testWithProfile('extra file - with different package filter',
        expectedLogMessages: [
          'SHOUT Object from public bucket will be deleted: "packages/oxygen-0.0.99.tar.gz".',
        ], fn: () async {
      final bucket =
          storageService.bucket(activeConfiguration.publicPackagesBucketName!);
      await bucket.writeBytes('packages/oxygen-0.0.99.tar.gz', [1]);

      // no matching file
      final recent = await _updatePublicArchiveBucket(package: 'neon');
      expect(recent.isAllZero, isTrue);

      // no matching files
      final changes = await _updatePublicArchiveBucket(package: 'neon');
      expect(changes.isAllZero, isTrue);
      final changes2 = await _updatePublicArchiveBucket(
        package: 'neon',
        deleteIfOlder: Duration.zero,
      );
      expect(changes2.isAllZero, isTrue);
      final changes3 = await _updatePublicArchiveBucket(package: 'neon');
      expect(changes3.isAllZero, isTrue);

      // changes will be picked up without filter
      final changes4 = await _updatePublicArchiveBucket();
      expect(changes4.isAllZero, isFalse);
    });
  });
}
