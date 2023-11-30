// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import '../search/backend.dart';
import '../shared/datastore.dart';
import '../shared/storage.dart';
import '../shared/utils.dart';
import '../shared/versions.dart';
import '../task/global_lock.dart';
import 'backend.dart';
import 'models.dart';

final Logger _logger = Logger('export_api_to_bucket');

/// The default concurrency to upload API JSON files to the bucket.
const _defaultBucketUpdateConcurrency = 8;

/// The default cache timeout for content.
const _pkgApiMaxCacheAge = Duration(minutes: 10);
const _pkgNameCompletitionDataMaxAge = Duration(hours: 8);

List<String> _apiPkgObjectNames(String package) => [
      '$runtimeVersion/api/packages/$package',
      'current/api/packages/$package',
    ];

List<String> _apiPkgNameCompletitionDataNames() => [
      '$runtimeVersion/api/package-name-completion-data',
      'current/api/package-name-completion-data',
    ];

class ApiExporter {
  final Bucket _bucket;
  final int _concurrency;
  final _pkgLastUpdated = <String, _PkgUpdatedEvent>{};

  ApiExporter({
    required Bucket bucket,
    int concurrency = _defaultBucketUpdateConcurrency,
  })  : _bucket = bucket,
        _concurrency = concurrency;

  /// Runs a forever loop and tries to get a global lock.
  ///
  /// Once it has the claim, it scans the package entities and uploads
  /// the package API JSONs to the bucket.
  /// Tracks the package updates for the next up-to 24 hours and writes
  /// the API JSONs after every few minutes.
  ///
  /// When other process has the claim, the loop waits a minute before
  /// attempting to get the claim.
  Future<Never> uploadInForeverLoop() async {
    final lock = GlobalLock.create(
      '$runtimeVersion/package/update-api-bucket',
      expiration: Duration(minutes: 20),
    );
    while (true) {
      try {
        await lock.withClaim((claim) async {
          await incrementalPkgScanAndUpload(claim);
        });
      } catch (e, st) {
        _logger.warning('Package API bucket update failed.', e, st);
      }
      // Wait for 1 minutes for sanity, before trying again.
      await Future.delayed(Duration(minutes: 1));
    }
  }

  /// Gets and uploads the package name completion data.
  Future<void> uploadPkgNameCompletionData() async {
    final bytes = await searchBackend.getPackageNameCompletitionDataJsonGz();
    final bytesAndHash = _BytesAndHash(bytes);
    for (final objectName in _apiPkgNameCompletitionDataNames()) {
      if (await _isSameContent(objectName, bytesAndHash)) {
        continue;
      }
      await uploadWithRetry(
        _bucket,
        objectName,
        bytes.length,
        () => Stream.value(bytes),
        metadata: ObjectMetadata(
          contentType: 'application/json; charset="utf-8"',
          contentEncoding: 'gzip',
          cacheControl:
              'public, max-age=${_pkgNameCompletitionDataMaxAge.inSeconds}',
        ),
      );
    }
  }

  /// Note: there is no global locking here, the full scan should be called
  /// only once every day, and it may be racing against the incremental
  /// updates.
  @visibleForTesting
  Future<void> fullPkgScanAndUpload() async {
    final pool = Pool(_concurrency);
    final futures = <Future>[];
    await for (final mp in dbService.query<ModeratedPackage>().run()) {
      final f = pool.withResource(() => _deletePackageFromBucket(mp.name!));
      futures.add(f);
    }
    await Future.wait(futures);
    futures.clear();

    await for (final package in dbService.query<Package>().run()) {
      final f = pool.withResource(() async {
        if (package.isVisible) {
          await _uploadPackageToBucket(package.name!);
        } else {
          await _deletePackageFromBucket(package.name!);
        }
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  }

  @visibleForTesting
  Future<void> incrementalPkgScanAndUpload(
    GlobalLockClaim claim, {
    Duration sleepDuration = const Duration(minutes: 2),
  }) async {
    final pool = Pool(_concurrency);
    // The claim will be released after a day, another process may
    // start to upload the API JSONs from scratch again.
    final workUntil = clock.now().add(Duration(days: 1));

    // start monitoring with a window of 7 days lookback
    var lastQueryStarted = clock.now().subtract(Duration(days: 7));
    while (claim.valid) {
      final now = clock.now().toUtc();
      if (now.isAfter(workUntil)) {
        break;
      }

      // clear old entries from last seen cache
      _pkgLastUpdated.removeWhere((key, event) =>
          now.difference(event.updated) > const Duration(hours: 1));

      lastQueryStarted = now;
      final futures = <Future>[];
      final eventsSince = lastQueryStarted.subtract(Duration(minutes: 5));
      await for (final event in _queryRecentPkgUpdatedEvents(eventsSince)) {
        if (!claim.valid) {
          break;
        }
        final f = pool.withResource(() async {
          if (!claim.valid) {
            return;
          }
          final last = _pkgLastUpdated[event.package];
          if (last != null && last.updated.isAtOrAfter(event.updated)) {
            return;
          }
          _pkgLastUpdated[event.package] = event;
          if (event.isVisible) {
            await _uploadPackageToBucket(event.package);
          } else {
            await _deletePackageFromBucket(event.package);
          }
        });
        futures.add(f);
      }
      await Future.wait(futures);
      futures.clear();
      await Future.delayed(sleepDuration);
    }
    await pool.close();
  }

  /// Uploads the package version API response bytes to the bucket, mirroring
  /// the endpoint name in the file location.
  Future<void> _uploadPackageToBucket(String package) async {
    final data = await retry(() => packageBackend.listVersions(package));
    final rawBytes = jsonUtf8Encoder.convert(data.toJson());
    final bytes = gzip.encode(rawBytes);
    final bytesAndHash = _BytesAndHash(bytes);

    for (final objectName in _apiPkgObjectNames(package)) {
      if (await _isSameContent(objectName, bytesAndHash)) {
        continue;
      }

      await uploadWithRetry(
        _bucket,
        objectName,
        bytes.length,
        () => Stream.value(bytes),
        metadata: ObjectMetadata(
          contentType: 'application/json; charset="utf-8"',
          contentEncoding: 'gzip',
          cacheControl: 'public, max-age=${_pkgApiMaxCacheAge.inSeconds}',
        ),
      );
    }
  }

  Future<void> _deletePackageFromBucket(String package) async {
    for (final objectName in _apiPkgObjectNames(package)) {
      await _bucket.tryDelete(objectName);
    }
  }

  Stream<_PkgUpdatedEvent> _queryRecentPkgUpdatedEvents(DateTime since) async* {
    final q1 = dbService.query<ModeratedPackage>()
      ..filter('moderated >=', since)
      ..order('-moderated');
    yield* q1.run().map((mp) => mp.asPkgUpdatedEvent());

    final q2 = dbService.query<Package>()
      ..filter('updated >=', since)
      ..order('-updated');
    yield* q2.run().map((p) => p.asPkgUpdatedEvent());
  }

  /// Deletes obsolete runtime-versions from the bucket.
  Future<void> deleteObsoleteRuntimeContent() async {
    final versions = <String>{};

    // Objects in the bucket are stored under the following pattern:
    //   `current/api/<package>`
    //   `<runtimeVersion>/api/<package>`
    // Thus, we list with `/` as delimiter and get a list of runtimeVersions
    await for (final d in _bucket.list(prefix: '', delimiter: '/')) {
      if (!d.isDirectory) {
        _logger.warning(
            'Bucket `${_bucket.bucketName}` should not contain any top-level object: `${d.name}`');
        continue;
      }

      // Remove trailing slash from object prefix, to get a runtimeVersion
      if (!d.name.endsWith('/')) {
        _logger.warning(
            'Unexpected top-level directory name in bucket `${_bucket.bucketName}`: `${d.name}`');
        return;
      }
      final rtVersion = d.name.substring(0, d.name.length - 1);
      if (runtimeVersionPattern.matchAsPrefix(rtVersion) == null) {
        continue;
      }

      // Check if the runtimeVersion should be GC'ed
      if (shouldGCVersion(rtVersion)) {
        versions.add(rtVersion);
      }
    }

    for (final v in versions) {
      await deleteBucketFolderRecursively(_bucket, '$v/', concurrency: 4);
    }
  }

  Future<bool> _isSameContent(
      String objectName, _BytesAndHash bytesAndHash) async {
    final info = await _bucket.tryInfo(objectName);
    if (info == null) {
      return false;
    }
    if (info.length != bytesAndHash.length) {
      return false;
    }
    if (bytesAndHash.md5Hash.length != info.md5Hash.length) {
      return false;
    }
    // making sure the timing is fixed
    var isSame = true;
    for (var i = 0; i < bytesAndHash.md5Hash.length; i++) {
      if (bytesAndHash.md5Hash[i] != info.md5Hash[i]) {
        isSame = false;
      }
    }
    return isSame;
  }
}

typedef _PkgUpdatedEvent = ({String package, DateTime updated, bool isVisible});

extension on ModeratedPackage {
  _PkgUpdatedEvent asPkgUpdatedEvent() =>
      (package: name!, updated: moderated, isVisible: false);
}

extension on Package {
  _PkgUpdatedEvent asPkgUpdatedEvent() =>
      (package: name!, updated: updated!, isVisible: isVisible);
}

class _BytesAndHash {
  final List<int> bytes;

  _BytesAndHash(this.bytes);

  late final length = bytes.length;
  late final md5Hash = md5.convert(bytes).bytes;
}
