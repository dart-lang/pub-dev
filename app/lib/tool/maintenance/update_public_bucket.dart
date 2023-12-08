// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';

final _logger = Logger('update_public_buckets');

class PublicBucketUpdateStat {
  final int archivesUpdated;
  final int archivesToBeDeleted;
  final int archivesDeleted;

  PublicBucketUpdateStat({
    required this.archivesUpdated,
    required this.archivesToBeDeleted,
    required this.archivesDeleted,
  });
}

/// Updates the public package archive:
/// - copies missing archive objects from canonical to public bucket,
/// - deletes leftover objects from public bucket
///
/// Return the number of objects that were updated.
Future<PublicBucketUpdateStat> updatePublicArchiveBucket({
  @visibleForTesting Duration ageCheckThreshold = const Duration(days: 1),
  @visibleForTesting Duration deleteIfOlder = const Duration(days: 7),
}) async {
  _logger.info('Scanning PackageVersions for public bucket updates...');

  var updatedCount = 0;
  var toBeDeletedCount = 0;
  final deleteObjects = <String>[];
  final canonicalBucket =
      storageService.bucket(activeConfiguration.canonicalPackagesBucketName!);
  final publicBucket =
      storageService.bucket(activeConfiguration.publicPackagesBucketName!);

  final objectNamesInPublicBucket = <String>{};

  await for (final pv in dbService.query<PackageVersion>().run()) {
    // ignore: invalid_use_of_visible_for_testing_member
    final objectName = tarballObjectName(pv.package, pv.version!);
    final publicInfo = await publicBucket.tryInfo(objectName);

    if (publicInfo == null) {
      _logger.warning('Updating missing object in public bucket: $objectName');
      try {
        await storageService.copyObject(
          canonicalBucket.absoluteObjectName(objectName),
          publicBucket.absoluteObjectName(objectName),
        );
        updatedCount++;
      } on Exception catch (e, st) {
        _logger.shout(
          'Failed to copy $objectName from canonical to public bucket',
          e,
          st,
        );
      }
    }
    objectNamesInPublicBucket.add(objectName);
  }

  await for (final entry in publicBucket.list()) {
    // Skip non-objects.
    if (!entry.isObject) {
      continue;
    }
    // Skip objects that were matched in the previous step.
    if (objectNamesInPublicBucket.contains(entry.name)) {
      continue;
    }

    final publicInfo = await publicBucket.tryInfo(entry.name);
    if (publicInfo == null) {
      _logger.warning(
          'Failed to get info for public bucket object "${entry.name}".');
      continue;
    }

    // Skip recently updated objects.
    if (publicInfo.age < ageCheckThreshold) {
      // Ignore recent files.
      continue;
    }

    final canonicalInfo = await canonicalBucket.tryInfo(entry.name);
    if (canonicalInfo != null) {
      // Warn if both the canonical and the public bucket has the same object,
      // but it wasn't matched through the [PackageVersion] query above.
      if (canonicalInfo.age < ageCheckThreshold) {
        // Ignore recent files.
        continue;
      }
      _logger.severe(
          'Object without matching PackageVersion in canonical and public buckets: "${entry.name}".');
      continue;
    } else {
      // The object in the public bucket has no matching file in the canonical bucket.
      // We can assume it is stale and can delete it.
      if (publicInfo.age <= deleteIfOlder) {
        _logger.shout(
            'Object from public bucket will be deleted: "${entry.name}".');
        toBeDeletedCount++;
      } else {
        deleteObjects.add(entry.name);
      }
    }
  }

  for (final objectName in deleteObjects) {
    _logger.shout('Deleting object from public bucket: "$objectName".');
    await publicBucket.delete(objectName);
  }

  return PublicBucketUpdateStat(
    archivesUpdated: updatedCount,
    archivesToBeDeleted: toBeDeletedCount,
    archivesDeleted: deleteObjects.length,
  );
}
