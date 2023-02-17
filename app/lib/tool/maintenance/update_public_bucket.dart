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
  final int archivesDeleted;

  PublicBucketUpdateStat({
    required this.archivesUpdated,
    required this.archivesDeleted,
  });
}

/// Updates the public package archive:
/// - copies missing archive objects from canonical to public
///
/// Return the number of objects that were updated.
Future<PublicBucketUpdateStat> updatePublicArchiveBucket({
  @visibleForTesting Duration ageCheckThreshold = const Duration(days: 1),
}) async {
  _logger.info('Scanning PackageVersions for public bucket updates...');

  var updated = 0;
  var deleted = 0;
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
      await storageService.copyObject(
        canonicalBucket.absoluteObjectName(objectName),
        publicBucket.absoluteObjectName(objectName),
      );
      updated++;
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
      continue;
    }

    final canonicalInfo = await canonicalBucket.tryInfo(entry.name);
    if (canonicalInfo != null) {
      if (publicInfo.age < ageCheckThreshold) {
        continue;
      }
      _logger.severe(
          'Object without matching PackageVersion in canonical and public buckets: "${entry.name}".');
      continue;
    }

    _logger.shout('Deleting object from public bucket: "${entry.name}".');
    deleted++;
  }

  return PublicBucketUpdateStat(
    archivesUpdated: updated,
    archivesDeleted: deleted,
  );
}
