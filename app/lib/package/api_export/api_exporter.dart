// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/parallel_foreach.dart';

import '../../search/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/versions.dart';
import '../../task/global_lock.dart';
import '../backend.dart';
import '../models.dart';
import 'exported_api.dart';

final Logger _log = Logger('api_exporter');

/// Sets the API Exporter service.
void registerApiExporter(ApiExporter value) =>
    ss.register(#_apiExporter, value);

/// The active API Exporter service or null if it hasn't been initialized.
ApiExporter? get apiExporter => ss.lookup(#_apiExporter) as ApiExporter?;

const _concurrency = 30;

class ApiExporter {
  final ExportedApi _api;

  /// If [stop] has been called to stop background processes.
  ///
  /// `null` when not started yet, or we have been fully stopped.
  Completer<void>? _aborted;

  /// If background processes created by [start] have stopped.
  ///
  /// This won't be resolved if [start] has not been called!
  /// `null` when not started yet.
  Completer<void>? _stopped;

  ApiExporter({
    required Bucket bucket,
  }) : _api = ExportedApi(storageService, bucket);

  /// Start continuous background processes for scheduling of tasks.
  ///
  /// Calling [start] without first calling [stop] is an error.
  Future<void> start() async {
    if (_aborted != null) {
      throw StateError('ApiExporter.start() has already been called!');
    }
    // Note: During testing we call [start] and [stop] in a [FakeAsync.run],
    //       this only works because the completers are created here.
    //       If we create the completers in the constructor which gets called
    //       outside [FakeAsync.run], then this won't work.
    //       In the future we hopefully support running the entire service using
    //       FakeAsync, but this point we rely on completers being created when
    //       [start] is called -- and not in the [ApiExporter] constructor.
    final aborted = _aborted = Completer();
    final stopped = _stopped = Completer();

    // Start scanning for packages to be tracked
    scheduleMicrotask(() async {
      try {
        // Create a lock for task scheduling, so tasks
        final lock = GlobalLock.create(
          '$runtimeVersion/package/scan-sync-export-api',
          expiration: Duration(minutes: 25),
        );

        while (!aborted.isCompleted) {
          // Acquire the global lock and scan for package changes while lock is
          // valid.
          try {
            await lock.withClaim((claim) async {
              await _scanForPackageUpdates(claim, abort: aborted);
            }, abort: aborted);
          } catch (e, st) {
            // Log this as very bad, and then move on. Nothing good can come
            // from straight up stopping.
            _log.shout(
              'scanning failed (will retry when lock becomes free)',
              e,
              st,
            );
            // Sleep 5 minutes to reduce risk of degenerate behavior
            await Future.delayed(Duration(minutes: 5));
          }
        }
      } catch (e, st) {
        _log.severe('scanning loop crashed', e, st);
      } finally {
        _log.info('scanning loop stopped');
        // Report background processes as stopped
        stopped.complete();
      }
    });
  }

  /// Stop any background process that may be running.
  ///
  /// Calling this method is always safe.
  Future<void> stop() async {
    final aborted = _aborted;
    if (aborted == null) {
      return;
    }
    if (!aborted.isCompleted) {
      aborted.complete();
    }
    await _stopped!.future;
    _aborted = null;
    _stopped = null;
  }

  /// Gets and uploads the package name completion data.
  Future<void> synchronizePackageNameCompletionData() async {
    await _api.packageNameCompletionData.write(
      await searchBackend.getPackageNameCompletionData(),
    );
  }

  /// Synchronize all exported API.
  ///
  /// This is intended to be scheduled from a daily background task.
  Future<void> synchronizeExportedApi() async {
    final allPackageNames = <String>{};
    final packageQuery = dbService.query<Package>();
    await packageQuery.run().parallelForEach(_concurrency, (pkg) async {
      final name = pkg.name!;
      if (pkg.isNotVisible) {
        return;
      }
      allPackageNames.add(name);

      // TODO: Consider retries around all this logic
      await synchronizePackage(name);
    });

    await synchronizePackageNameCompletionData();

    await _api.garbageCollect(allPackageNames);
  }

  /// Sync package and into [ExportedApi], this will synchronize package into
  /// [ExportedApi].
  ///
  /// This method will update [ExportedApi] ensuring:
  ///  * Version listing for [package] is up-to-date,
  ///  * Advisories for [package] is up-to-date,
  ///  * Tarballs for each version of [package] is up-to-date,
  ///  * Delete tarballs from old versions that no-longer exist.
  ///
  /// This is intended when:
  ///  * Running a full background synchronization.
  ///  * When a change in [Package.updated] is detected.
  ///  * A package is moderated, or other admin action is applied.
  Future<void> synchronizePackage(String package) async {
    // TODO: Handle the case where [package] is deleted or invisible!
    // TODO: We may need to delete the package, but only if it's not too recent!
    final versionListing = await packageBackend.listVersions(package);
    // TODO: Consider skipping the cache when fetching security advisories
    final advisories = await securityAdvisoryBackend.listAdvisoriesResponse(
      package,
    );

    final versions = await packageBackend.tarballStorage
        .listVersionsInCanonicalBucket(package);

    // Remove versions that are not exposed in the public API.
    versions.removeWhere(
      (version, _) => !versionListing.versions.any((v) => v.version == version),
    );

    await _api.package(package).synchronizeTarballs(versions);
    await _api.package(package).advisories.write(advisories);
    await _api.package(package).versions.write(versionListing);
  }

  /// Scan for updates from packages until [abort] is resolved, or [claim]
  /// is lost.
  Future<void> _scanForPackageUpdates(
    GlobalLockClaim claim, {
    Completer<void>? abort,
  }) async {
    abort ??= Completer<void>();

    // Map from package to updated that has been seen.
    final seen = <String, DateTime>{};

    // We will schedule longer overlaps every 6 hours.
    var nextLongScan = clock.fromNow(hours: 6);

    // In theory 30 minutes overlap should be enough. In practice we should
    // allow an ample room for missed windows, and 3 days seems to be large enough.
    var since = clock.ago(days: 3);
    while (claim.valid && !abort.isCompleted) {
      // Look at all packages changed in [since]
      final q = dbService.query<Package>()
        ..filter('updated >', since)
        ..order('-updated');

      if (clock.now().isAfter(nextLongScan)) {
        // Next time we'll do a longer scan
        since = clock.ago(days: 1);
        nextLongScan = clock.fromNow(hours: 6);
      } else {
        // Next time we'll only consider changes since now - 30 minutes
        since = clock.ago(minutes: 30);
      }

      // Look at all packages that has changed
      await for (final p in q.run()) {
        // Abort, if claim is invalid or abort has been resolved!
        if (!claim.valid || abort.isCompleted) {
          return;
        }

        // Check if the [updated] timestamp has been seen before.
        // If so, we skip checking it!
        final lastSeen = seen[p.name!];
        if (lastSeen != null && lastSeen.toUtc() == p.updated!.toUtc()) {
          continue;
        }
        // Remember the updated time for this package, so we don't check it
        // again...
        seen[p.name!] = p.updated!;

        // Check the package
        await synchronizePackage(p.name!);
      }

      // Cleanup the [seen] map for anything older than [since], as this won't
      // be relevant to the next iteration.
      seen.removeWhere((_, updated) => updated.isBefore(since));

      // Wait until aborted or 10 minutes before scanning again!
      await abort.future.timeout(Duration(minutes: 10), onTimeout: () => null);
    }
  }
}
