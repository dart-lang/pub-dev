// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/storage.dart';

final _logger = Logger('package_storage');

class PackageStorage {
  final DatastoreDB _dbService;
  final Storage _storage;

  /// The Cloud Storage bucket to use for canonical package archives.
  /// The following files are present:
  /// - `packages/$package-$version.tar.gz` (package archive)
  final Bucket _canonicalBucket;

  /// The Cloud Storage bucket to use for public package archives.
  /// The following files are present:
  /// - `packages/$package-$version.tar.gz` (package archive)
  final Bucket _publicBucket;

  PackageStorage(
    this._dbService,
    this._storage,
    this._canonicalBucket,
    this._publicBucket,
  );

  /// Updates the public package archive:
  /// - copies missing archive objects from canonical to public bucket,
  /// - deletes leftover objects from public bucket
  ///
  /// Return the number of objects that were updated.
  Future<PublicBucketUpdateStat> updatePublicArchiveBucket({
    String? package,
    Duration ageCheckThreshold = const Duration(days: 1),
    Duration deleteIfOlder = const Duration(days: 7),
  }) async {
    _logger.info('Scanning PackageVersions for public bucket updates...');

    var updatedCount = 0;
    var toBeDeletedCount = 0;
    final deleteObjects = <String>{};

    final objectNamesInPublicBucket = <String>{};

    Package? lastPackage;
    final pvStream = package == null
        ? _dbService.query<PackageVersion>().run()
        : packageBackend.streamVersionsOfPackage(package);
    await for (final pv in pvStream) {
      if (lastPackage?.name != pv.package) {
        lastPackage = await packageBackend.lookupPackage(pv.package);
      }
      final isModerated = lastPackage!.isModerated || pv.isModerated;

      final objectName = tarballObjectName(pv.package, pv.version!);
      final publicInfo = await _publicBucket.tryInfo(objectName);

      if (isModerated) {
        if (publicInfo != null) {
          deleteObjects.add(objectName);
        }
        continue;
      }

      if (publicInfo == null) {
        _logger
            .warning('Updating missing object in public bucket: $objectName');
        try {
          await _storage.copyObject(
            _canonicalBucket.absoluteObjectName(objectName),
            _publicBucket.absoluteObjectName(objectName),
          );
          final newInfo = await _publicBucket.info(objectName);
          await updateContentDispositionToAttachment(newInfo, _publicBucket);
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

    final filterForNamePrefix =
        package == null ? 'packages/' : tarballObjectNamePackagePrefix(package);
    await for (final entry in _publicBucket.list(prefix: filterForNamePrefix)) {
      // Skip non-objects.
      if (!entry.isObject) {
        continue;
      }
      // Skip objects that were matched in the previous step.
      if (objectNamesInPublicBucket.contains(entry.name)) {
        continue;
      }
      if (deleteObjects.contains(entry.name)) {
        continue;
      }

      final publicInfo = await _publicBucket.tryInfo(entry.name);
      if (publicInfo == null) {
        _logger.warning(
            'Failed to get info for public bucket object "${entry.name}".');
        continue;
      }

      await updateContentDispositionToAttachment(publicInfo, _publicBucket);

      // Skip recently updated objects.
      if (publicInfo.age < ageCheckThreshold) {
        // Ignore recent files.
        continue;
      }

      final canonicalInfo = await _canonicalBucket.tryInfo(entry.name);
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
      await _publicBucket.delete(objectName);
    }

    return PublicBucketUpdateStat(
      archivesUpdated: updatedCount,
      archivesToBeDeleted: toBeDeletedCount,
      archivesDeleted: deleteObjects.length,
    );
  }
}

class PublicBucketUpdateStat {
  final int archivesUpdated;
  final int archivesToBeDeleted;
  final int archivesDeleted;

  PublicBucketUpdateStat({
    required this.archivesUpdated,
    required this.archivesToBeDeleted,
    required this.archivesDeleted,
  });

  bool get isAllZero =>
      archivesUpdated == 0 && archivesToBeDeleted == 0 && archivesDeleted == 0;
}
