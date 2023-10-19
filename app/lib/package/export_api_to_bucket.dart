// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import '../shared/datastore.dart';
import '../shared/storage.dart';
import '../shared/utils.dart';
import '../shared/versions.dart';
import '../task/global_lock.dart';
import 'backend.dart';
import 'models.dart';

final Logger _logger = Logger('export_api_to_bucket');

/// The default concurrency to upload API JSON files to the bucket.
const _defaultUploadPackageApisToBucketConcurrency = 8;

/// The default cache timeout for content.
const _maxCacheAge = Duration(minutes: 10);

List<String> _apiPkgObjectNames(String package) => [
      '$runtimeVersion/api/packages/$package',
      'current/api/packages/$package',
    ];

class ApiExporter {
  final Bucket _bucket;
  final int _concurrency;
  final _lastSeen = <String, _UpdatedEvent>{};

  ApiExporter({
    required Bucket bucket,
    int concurrency = _defaultUploadPackageApisToBucketConcurrency,
  })  : _bucket = bucket,
        _concurrency = concurrency;

  /// Runs a forever loop and tries to get a global lock.
  ///
  /// Once it has the claim, it scans the packages entities and uploads
  /// the package API JSONs to the bucket.
  /// Tracks the package updates for the next up-to 24 hours and writes
  /// the API JSONs after every few minutes.
  ///
  /// When other process has the claim, the loop waits a minute before
  /// attempting to get the claim.
  Future<Never> uploadPackageApisInForeverLoop() async {
    final lock = GlobalLock.create(
      '$runtimeVersion/package/update-api-bucket',
      expiration: Duration(minutes: 20),
    );
    while (true) {
      try {
        await lock.withClaim((claim) async {
          await incrementalScanAndUploadPackageApis(claim);
        });
      } catch (e, st) {
        _logger.warning('Package API bucket update failed.', e, st);
      }
      // Wait for 1 minutes for sanity, before trying again.
      await Future.delayed(Duration(minutes: 1));
    }
  }

  /// Note: there is no global locking here, the full scan should be called
  /// only once every day, and it may be racing against the incremental
  /// updates.
  @visibleForTesting
  Future<void> fullScanAndUploadPackageApis() async {
    final pool = Pool(_concurrency);
    final futures = <Future>[];
    await for (final mp in dbService.query<ModeratedPackage>().run()) {
      final f = pool.withResource(() => _update(mp.asUpdatedEvent()));
      futures.add(f);
    }
    await Future.wait(futures);
    futures.clear();

    await for (final package in dbService.query<Package>().run()) {
      final f = pool.withResource(() => _update(package.asUpdatedEvent()));
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
  }

  @visibleForTesting
  Future<void> incrementalScanAndUploadPackageApis(
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
      _lastSeen.removeWhere((key, value) =>
          now.difference(value.updated) > const Duration(hours: 1));

      lastQueryStarted = now;
      final futures = <Future>[];
      await for (final event in _queryRecentEvents(lastQueryStarted)) {
        if (!claim.valid) {
          break;
        }
        final f = pool.withResource(() async {
          if (!claim.valid) {
            return;
          }
          await _update(event);
        });
        futures.add(f);
      }
      await Future.wait(futures);
      futures.clear();
      await Future.delayed(sleepDuration);
    }
    await pool.close();
  }

  Future<void> _update(_UpdatedEvent event) async {
    final last = _lastSeen[event.package];
    if (last != null && last.updated.isAtOrAfter(event.updated)) {
      return;
    }
    _lastSeen[event.package] = event;
    if (event.isVisible) {
      await _uploadPackageApiToBucket(event.package);
    } else {
      await _deletePackageFromBucket(event.package);
    }
  }

  /// Uploads the package version API response bytes to the bucket, mirroring
  /// the endpoint name in the file location.
  Future<void> _uploadPackageApiToBucket(String package) async {
    final data = await retry(() => packageBackend.listVersions(package));
    final rawBytes = jsonUtf8Encoder.convert(data.toJson());
    final gzippedBytes = gzip.encode(rawBytes);

    for (final objectName in _apiPkgObjectNames(package)) {
      final info = await _bucket.tryInfo(objectName);
      // Skip upload if the bytes length and md5 hash matches.
      if (info != null && info.length == gzippedBytes.length) {
        final md5Hash = md5.convert(gzippedBytes).bytes;
        if (info.md5Hash.length == md5Hash.length &&
            info.md5Hash.whereIndexed((i, e) => md5Hash[i] == e).length ==
                info.md5Hash.length) {
          continue;
        }
      }

      await uploadWithRetry(
        _bucket,
        objectName,
        gzippedBytes.length,
        () => Stream.value(gzippedBytes),
        metadata: ObjectMetadata(
          contentType: 'application/json; charset="utf-8"',
          contentEncoding: 'gzip',
          cacheControl: 'public, max-age=${_maxCacheAge.inSeconds}',
        ),
      );
    }
  }

  Future<void> _deletePackageFromBucket(String package) async {
    for (final objectName in _apiPkgObjectNames(package)) {
      await _bucket.tryDelete(objectName);
    }
  }

  Stream<_UpdatedEvent> _queryRecentEvents(DateTime lastQueryStarted) async* {
    final updatedThreshold = lastQueryStarted.subtract(Duration(minutes: 5));

    final q1 = dbService.query<ModeratedPackage>()
      ..filter('moderated >=', updatedThreshold)
      ..order('-moderated');
    yield* q1.run().map((mp) => mp.asUpdatedEvent());

    final q2 = dbService.query<Package>()
      ..filter('updated >=', updatedThreshold)
      ..order('-updated');
    yield* q2.run().map((p) => p.asUpdatedEvent());
  }

  /// Deletes obsolete runtime-versions from the bucket.
  Future<void> gcPackageApis() async {
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
}

typedef _UpdatedEvent = ({String package, DateTime updated, bool isVisible});

extension on ModeratedPackage {
  _UpdatedEvent asUpdatedEvent() =>
      (package: name!, updated: moderated, isVisible: false);
}

extension on Package {
  _UpdatedEvent asUpdatedEvent() =>
      (package: name!, updated: updated!, isVisible: isVisible);
}
