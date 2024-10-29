// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:basics/basics.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/parallel_foreach.dart';
import 'package:retry/retry.dart';

import '../../search/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/storage.dart';
import '../../shared/versions.dart';
import '../../task/global_lock.dart';
import '../backend.dart';
import '../models.dart';
import 'exported_api.dart';

final Logger _logger = Logger('export_api_to_bucket');

/// The default concurrency to upload API JSON files to the bucket.
const _defaultBucketUpdateConcurrency = 8;

/// Sets the API Exporter service.
void registerApiExporter(ApiExporter value) =>
    ss.register(#_apiExporter, value);

/// The active API Exporter service or null if it hasn't been initialized.
ApiExporter? get apiExporter => ss.lookup(#_apiExporter) as ApiExporter?;

class ApiExporter {
  final ExportedApi _api;
  final Bucket _bucket;
  final int _concurrency;
  final _pkgLastUpdated = <String, _PkgUpdatedEvent>{};

  ApiExporter({
    required Bucket bucket,
    int concurrency = _defaultBucketUpdateConcurrency,
  })  : _api = ExportedApi(storageService, bucket),
        _bucket = bucket,
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
    await _api.packageNameCompletionData
        .write(await searchBackend.getPackageNameCompletionData());
  }

  Future<void> fullSync() async {
    final invisiblePackageNames = await dbService
        .query<ModeratedPackage>()
        .run()
        .map((mp) => mp.name!)
        .toSet();

    final allPackageNames = <String>{};
    final packageQuery = dbService.query<Package>();
    await packageQuery.run().parallelForEach(_concurrency, (pkg) async {
      final name = pkg.name!;
      if (pkg.isNotVisible) {
        invisiblePackageNames.add(name);
        return;
      }
      allPackageNames.add(name);

      // TODO: Consider retries around all this logic
      await syncPackage(name);
    });

    final visibilityConflicts =
        allPackageNames.intersection(invisiblePackageNames);
    if (visibilityConflicts.isNotEmpty) {
      // TODO: Shout into logs
    }

    await _api.garbageCollect(allPackageNames);
  }

  /// Sync package and into [ExportedApi], this will GC, etc.
  ///
  /// This is intended when:
  ///  * Running a full background synchronization.
  ///  * When a change in [Package.updated] is detected (maybe???)
  ///  * A package is moderated, or other admin action is applied.
  Future<void> syncPackage(String package) async {
    final versionListing = await packageBackend.listVersions(package);
    // TODO: Consider skipping the cache when fetching security advisories
    final advisories = await securityAdvisoryBackend.listAdvisoriesResponse(
      package,
    );

    await Future.wait(versionListing.versions.map((v) async {
      final version = v.version;

      // TODO: Will v.version work here, is the canonicalized version number?
      final absoluteObjectName =
          packageBackend.tarballStorage.getCanonicalBucketAbsoluteObjectName(
        package,
        version,
      );
      final info =
          await packageBackend.tarballStorage.getCanonicalBucketArchiveInfo(
        package,
        version,
      );
      if (info == null) {
        throw AssertionError(
          'Expected an archive for "$package" and "$version" at '
          '"$absoluteObjectName"',
        );
      }

      await _api.package(package).tarball(version).copyFrom(
            absoluteObjectName,
            info,
          );
    }));

    await _api.package(package).advisories.write(advisories);
    await _api.package(package).versions.write(versionListing);

    // TODO: Is this the canonoical version? (probably)
    final allVersions = versionListing.versions.map((v) => v.version).toSet();
    await _api.package(package).garbageCollect(allVersions);
  }

  /// Upload a single version of a new package.
  ///
  /// This is intended to be used when a new version of a package has been
  /// published.
  Future<void> uploadSingleVersion(
    String package,
    String version,
  ) async {
    final versionListing = await packageBackend.listVersions(package);

    // TODO: Will v.version work here, is the canonicalized version number?
    final absoluteObjectName =
        packageBackend.tarballStorage.getCanonicalBucketAbsoluteObjectName(
      package,
      version,
    );
    final info =
        await packageBackend.tarballStorage.getCanonicalBucketArchiveInfo(
      package,
      version,
    );
    if (info == null) {
      throw AssertionError(
        'Expected an archive for "$package" and "$version" at '
        '"$absoluteObjectName"',
      );
    }

    await _api.package(package).tarball(version).copyFrom(
          absoluteObjectName,
          info,
        );

    await _api.package(package).versions.write(versionListing);
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

  /// Updates the API files after a version has changed (e.g. new version was uploaded).
  Future<void> updatePackageVersion(String package, String version) async {
    await _uploadPackageToBucket(package);
  }

  /// Uploads the package version API response bytes to the bucket, mirroring
  /// the endpoint name in the file location.
  Future<void> _uploadPackageToBucket(String package) async {
    final data = await retry(() => packageBackend.listVersions(package));
    await _api.package(package).versions.write(data);
  }

  Future<void> _deletePackageFromBucket(String package) async {
    await _api.package(package).delete();
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
