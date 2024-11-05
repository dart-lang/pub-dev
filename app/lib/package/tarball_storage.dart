// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import '../shared/datastore.dart';
import '../shared/storage.dart';
import '../shared/utils.dart';
import 'backend.dart';
import 'models.dart';

final _logger = Logger('package_storage');

/// The GCS object name of a tarball object - excluding leading '/'.
@visibleForTesting
String tarballObjectName(String package, String version) =>
    '${_tarballObjectNamePackagePrefix(package)}$version.tar.gz';

/// The GCS object prefix of a tarball object for a given [package] - excluding leading '/'.
String _tarballObjectNamePackagePrefix(String package) => 'packages/$package-';

class TarballStorage {
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

  TarballStorage(
    this._dbService,
    this._storage,
    this._canonicalBucket,
    this._publicBucket,
  );

  /// Gets the object info of the archive file from the canonical bucket.
  Future<ObjectInfo?> getCanonicalBucketArchiveInfo(
      String package, String version) async {
    final objectName = tarballObjectName(package, version);
    return await _canonicalBucket.tryInfo(objectName);
  }

  /// Gets the object info of the archive file from the public bucket.
  Future<ObjectInfo?> getPublicBucketArchiveInfo(
      String package, String version) async {
    final objectName = tarballObjectName(package, version);
    return await _publicBucket.tryInfo(objectName);
  }

  /// Returns the publicly available download URL from the storage bucket.
  Future<Uri> getPublicDownloadUrl(String package, String version) async {
    final object = tarballObjectName(package, Uri.encodeComponent(version));
    return Uri.parse(_publicBucket.objectUrl(object));
  }

  /// Verifies the content of an archive in the canonical bucket.
  Future<ContentMatchStatus> matchArchiveContentInCanonical(
    String package,
    String version,
    Uint8List bytes,
  ) async {
    final objectName = tarballObjectName(package, version);
    final info = await _canonicalBucket.tryInfo(objectName);
    if (info == null) {
      return ContentMatchStatus.missing;
    }
    if (info.length != bytes.length) {
      return ContentMatchStatus.different;
    }
    final md5hash = md5.convert(bytes).bytes;
    if (!md5hash.byteToByteEquals(info.md5Hash)) {
      return ContentMatchStatus.different;
    }
    final objectBytes = await _canonicalBucket.readAsBytes(objectName);
    if (bytes.byteToByteEquals(objectBytes)) {
      return ContentMatchStatus.same;
    } else {
      return ContentMatchStatus.different;
    }
  }

  /// Copies the uploaded object from the temp bucket to the canonical bucket.
  Future<void> copyFromTempToCanonicalBucket({
    required String sourceAbsoluteObjectName,
    required String package,
    required String version,
  }) async {
    await _storage.copyObject(
      sourceAbsoluteObjectName,
      _canonicalBucket.absoluteObjectName(tarballObjectName(package, version)),
    );
  }

  /// Copies archive bytes from canonical bucket to public bucket.
  Future<void> copyArchiveFromCanonicalToPublicBucket(
      String package, String version) async {
    final objectName = tarballObjectName(package, version);
    await _storage.copyObject(
      _canonicalBucket.absoluteObjectName(objectName),
      _publicBucket.absoluteObjectName(objectName),
    );
  }

  /// Updates the `content-disposition` header to `attachment` on the public archive file.
  Future<void> updateContentDispositionOnPublicBucket(
      String package, String version) async {
    final info = await getPublicBucketArchiveInfo(package, version);
    if (info != null) {
      await updateContentDispositionToAttachment(info, _publicBucket);
    }
  }

  /// Deletes package archive from all buckets.
  Future<void> deleteArchiveFromAllBuckets(
      String package, String version) async {
    final objectName = tarballObjectName(package, version);
    await deleteFromBucket(_canonicalBucket, objectName);
    await deleteFromBucket(_publicBucket, objectName);
  }

  /// Deletes the package archive file from the canonical bucket.
  Future<void> deleteArchiveFromCanonicalBucket(
      String package, String version) async {
    final objectName = tarballObjectName(package, version);
    final info = await _canonicalBucket.tryInfo(objectName);
    if (info != null) {
      await _canonicalBucket.delete(objectName);
    }
  }

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

    final filterForNamePrefix = package == null
        ? 'packages/'
        : _tarballObjectNamePackagePrefix(package);
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

enum ContentMatchStatus {
  missing,
  different,
  same;
}
