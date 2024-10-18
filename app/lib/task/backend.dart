import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/task_api.dart' as api;
import 'package:_pub_shared/data/task_payload.dart';
import 'package:chunked_stream/chunked_stream.dart' show MaximumSizeExceeded;
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart' show Bucket;
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:indexed_blob/indexed_blob.dart' show BlobIndex, FileRange;
import 'package:logging/logging.dart' show Logger;
import 'package:pana/models.dart' show Summary;
import 'package:pool/pool.dart' show Pool;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart'
    show canonicalizeVersion, isNewer, VersionIterableExt;
import 'package:pub_dev/shared/versions.dart'
    show
        runtimeVersion,
        gcBeforeRuntimeVersion,
        shouldGCVersion,
        acceptedRuntimeVersions;
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/global_lock.dart';
import 'package:pub_dev/task/handlers.dart';
import 'package:pub_dev/task/models.dart'
    show
        PackageState,
        PackageStateInfo,
        PackageVersionStateInfo,
        PackageVersionStatus,
        initialTimestamp,
        maxTaskExecutionTime;
import 'package:pub_dev/task/scheduler.dart';
import 'package:pub_semver/pub_semver.dart' show Version;
import 'package:shelf/shelf.dart' as shelf;

final _log = Logger('pub.task.backend');

/// The maximum gzipped length of task results that we are putting in the cache.
/// Larger content will be still served, but not from the cache.
const _gzippedTaskResultCacheSizeThreshold = 1 * 1024 * 1024;

final gzippedUtf8JsonCodec = json.fuse(utf8).fuse(gzip);

/// Register a [CloudCompute] pool for task workers in the current
/// service scope.
///
/// This is mainly used to inject a fake [CloudCompute] for testing.
void registerTaskWorkerCloudCompute(CloudCompute workerPool) =>
    ss.register(#_taskWorkerCloudCompute, workerPool);

/// Get the active [CloudCompute] pool for task workers.
CloudCompute get taskWorkerCloudCompute =>
    ss.lookup(#_taskWorkerCloudCompute) as CloudCompute;

/// Sets the task backend service.
void registerTaskBackend(TaskBackend backend) =>
    ss.register(#_taskBackend, backend);

/// The active task backend service.
TaskBackend get taskBackend => ss.lookup(#_taskBackend) as TaskBackend;

class TaskBackend {
  final DatastoreDB _db;
  final Bucket _bucket;

  /// If [stop] has been called to stop background processes.
  ///
  /// `null` when not started yet, or we have been fully stopped.
  Completer<void>? _aborted;

  /// If background processes created by [start] have stopped.
  ///
  /// This won't be resolved if [start] has not been called!
  /// `null` when not started yet.
  Completer<void>? _stopped;

  TaskBackend(this._db, this._bucket);

  /// Start continuous background processes for scheduling of tasks.
  ///
  /// Calling [start] without first calling [stop] is an error.
  Future<void> start() async {
    if (_aborted != null) {
      throw StateError('TaskBackend.start() has already been called!');
    }
    // Note: During testing we call [start] and [stop] in a [FakeAsync.run],
    //       this only works because the completers are created here.
    //       If we create the completers in the constructor which gets called
    //       outside [FakeAsync.run], then this won't work.
    //       In the future we hopefully support running the entire service using
    //       FakeAsync, but this point we rely on completers being created when
    //       [start] is called -- and not in the [TaskBackend] constructor.
    final aborted = _aborted = Completer();
    final stopped = _stopped = Completer();

    // Start scanning for packages to be tracked
    final _doneScanning = Completer<void>();
    scheduleMicrotask(() async {
      try {
        // Create a lock for task scheduling, so tasks
        final lock = GlobalLock.create(
          '$runtimeVersion/task/scanning',
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
        _doneScanning.complete();
      }
    });

    // Start background task to schedule tasks
    final _doneScheduling = Completer<void>();
    scheduleMicrotask(() async {
      try {
        // Create a lock for task scheduling, so tasks
        final lock = GlobalLock.create(
          '$runtimeVersion/task/scheduler',
          expiration: Duration(minutes: 25),
        );

        while (!aborted.isCompleted) {
          // Acquire the global lock and create VMs for pending packages, and
          // kill overdue VMs.
          try {
            await lock.withClaim((claim) async {
              await schedule(claim, taskWorkerCloudCompute, _db,
                  abort: aborted);
            }, abort: aborted);
          } catch (e, st) {
            // Log this as very bad, and then move on. Nothing good can come
            // from straight up stopping.
            _log.shout(
              'scheduling iteration failed (will retry when lock becomes free)',
              e,
              st,
            );
            // Sleep 5 minutes to reduce risk of degenerate behavior
            await Future.delayed(Duration(minutes: 5));
          }
        }
      } catch (e, st) {
        _log.severe('scheduling loop crashed', e, st);
      } finally {
        _log.info('scheduling loop stopped');
        _doneScheduling.complete();
      }
    });

    scheduleMicrotask(() async {
      // Wait for background process to finish
      await Future.wait([
        _doneScanning.future,
        _doneScheduling.future,
      ]);

      // Report background processes as stopped
      stopped.complete();
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

  /// Track all package versions.
  ///
  /// This will synchronize any changes from [Package] and [PackageVersion]
  /// entities to [PackageState] entities.
  ///
  /// This is intended to run as a background tasks that is called once per
  /// day or so.
  Future<void> backfillTrackingState() async {
    // Store package name, so we can skip looking at these when scanning for
    // [PackageState] entities that shouldn't exist.
    final packageNames = <String>{};

    // Allow a little concurrency
    final pool = Pool(10);
    // Track error / stackTrace, so we can re-throw the first error, when this
    // backfill task is done. We want to bubble up so that background task is
    // not registered as having completed successfully.
    Object? error;
    StackTrace? stackTrace;

    // For each package we should ensure state is tracked
    final pq = _db.query<Package>();
    await for (final p in pq.run()) {
      packageNames.add(p.name!);

      scheduleMicrotask(() async {
        await pool.withResource(() async {
          try {
            await trackPackage(p.name!, updateDependents: false);
          } catch (e, st) {
            _log.severe('failed to track state for "${p.name}"', e, st);
            if (error == null) {
              error = e; // save [e] for later, if this is the first failure
              stackTrace = st;
            }
          }
        });
      });
    }

    // Check that all [PackageState] entities have a matching [Package] entity.
    final sq = _db.query<PackageState>()
      ..filter('runtimeVersion =', runtimeVersion);

    await for (final state in sq.run()) {
      if (!packageNames.contains(state.package)) {
        final r = await pool.request();

        scheduleMicrotask(() async {
          try {
            // Lookup the package to ensure it really doesn't exist
            final packageKey = _db.emptyKey.append(Package, id: state.package);
            final package = await _db.lookupOrNull<Package>(packageKey);
            if (package == null) {
              await _db.commit(deletes: [state.key]);
            }
          } catch (e, st) {
            _log.severe('failed to untrack "${state.package}"', e, st);
            if (error == null) {
              error = e; // save [e] for later, if this is the first failure
              stackTrace = st;
            }
          } finally {
            r.release(); // always release to avoid deadlock
          }
        });
      }
    }

    // Wait for all ongoing microtasks started above to complete.
    await pool.close();
    await pool.done;

    // If we had any error, we rethrow to ensure that any background task
    // calling this method won't register completion as successful.
    if (error != null) {
      // Hack to rethrow [error] with [stackTrace]
      await Future.error(error!, stackTrace);
    }
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
      final q = _db.query<Package>()
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
        await trackPackage(p.name!, updateDependents: true);
      }

      // Cleanup the [seen] map for anything older than [since], as this won't
      // be relevant to the next iteration.
      seen.removeWhere((_, updated) => updated.isBefore(since));

      // Wait until aborted or 10 minutes before scanning again!
      await abort.future.timeout(Duration(minutes: 10), onTimeout: () => null);
    }
  }

  Future<void> trackPackage(
    String packageName, {
    bool updateDependents = false,
  }) async {
    var lastVersionCreated = initialTimestamp;
    String? latestVersion;
    final changed = await withRetryTransaction(_db, (tx) async {
      final pkgKey = _db.emptyKey.append(Package, id: packageName);

      final stateKey = PackageState.createKey(_db, runtimeVersion, packageName);
      // Lookup Package and PackageVersion in the same transaction.
      final packageFuture = tx.lookupOrNull<Package>(pkgKey);
      final packageVersionsFuture =
          tx.query<PackageVersion>(pkgKey).run().toList();
      final stateFuture = tx.lookupOrNull<PackageState>(stateKey);
      // Ensure we await all futures!
      await Future.wait([packageFuture, packageVersionsFuture, stateFuture]);
      final state = await stateFuture;
      final package = await packageFuture;
      final packageVersions = await packageVersionsFuture;

      if (package == null) {
        return false; // assume package was deleted!
      }
      latestVersion = package.latestVersion;

      // Update the timestamp for when the last version was published.
      // This is used if we need to update dependents.
      lastVersionCreated = packageVersions.map((pv) => pv.created!).max;

      // If package is not visible, we should remove it!
      if (package.isNotVisible) {
        if (state != null) {
          tx.delete(state.key);
        }
        // also delete earlier runtime versions
        for (final rv
            in acceptedRuntimeVersions.where((rv) => rv != runtimeVersion)) {
          final key = PackageState.createKey(_db, rv, packageName);
          final s = await tx.lookupOrNull(key);
          if (s != null) {
            tx.delete(s.key);
          }
        }
        return true;
      }

      // Determined the set of versions to track
      final versions = _versionsToTrack(package, packageVersions).map(
        (v) => v.canonicalizedVersion, // add extra sanity!
      );

      // Ensure we have PackageState entity
      if (state == null) {
        // Create [PackageState] entity to track the package
        _log.info('Started state tracking for $packageName');
        tx.insert(
          PackageState()
            ..setId(runtimeVersion, packageName)
            ..runtimeVersion = runtimeVersion
            ..versions = {
              for (final version in versions)
                version: PackageVersionStateInfo(
                  scheduled: initialTimestamp,
                  attempts: 0,
                ),
            }
            ..dependencies = <String>[]
            ..lastDependencyChanged = initialTimestamp
            ..finished = initialTimestamp
            ..derivePendingAt(),
        );
        return true; // no more work for this package, state is synced
      }

      // List versions that not tracked, but should be
      final untrackedVersions = [
        ...versions.whereNot(state.versions!.containsKey),
      ];

      // List of versions that are tracked, but don't exist. These have
      // probably been deselected by _versionsToTrack.
      final deselectedVersions = [
        ...state.versions!.keys.whereNot(versions.contains),
      ];

      // There should never be an overlap between versions untracked and
      // versions that tracked by now deselected.
      assert(
        untrackedVersions
            .toSet()
            .intersection(deselectedVersions.toSet())
            .isEmpty,
      );

      // Stop transaction, if there is no changes to be made!
      if (untrackedVersions.isEmpty && deselectedVersions.isEmpty) {
        return false;
      }

      // Make changes!
      state.versions!
        // Remove versions that have been deselected
        ..removeWhere((v, _) => deselectedVersions.contains(v))
        // Add versions we should be tracking
        ..addAll({
          for (final v in untrackedVersions)
            v: PackageVersionStateInfo(
              scheduled: initialTimestamp,
              attempts: 0,
            ),
        });
      state.derivePendingAt();

      _log.info('Update state tracking for $packageName');
      tx.insert(state);
      return true;
    });

    if (changed) {
      await _purgeCache(packageName, latestVersion);
    }

    if (updateDependents &&
        !lastVersionCreated.isAtSameMomentAs(initialTimestamp)) {
      await _updateLastDependencyChangedForDependents(
        packageName,
        lastVersionCreated,
      );
    }
  }

  /// Garbage collect [PackageState] and results from old runtimeVersions.
  Future<void> garbageCollect() async {
    // GC the old [PackageState] entities
    await _db.deleteWithQuery(
      _db.query<PackageState>()
        ..filter('runtimeVersion <', gcBeforeRuntimeVersion),
    );

    // Limit to 50 concurrent deletion requests
    final pool = Pool(50);

    // Objects in the bucket are stored under the following pattern:
    //   `<runtimeVersion>/<package>/<version>/...`
    // Thus, we list with `/` as delimiter and get a list of runtimeVersions
    await for (final d in _bucket.list(prefix: '', delimiter: '/')) {
      if (!d.isDirectory) {
        _log.warning('bucket should not contain any top-level object');
        continue;
      }

      // Remove trailing slash from object prefix, to get a runtimeVersion
      assert(d.name.endsWith('/'));
      final rtVersion = d.name.substring(0, d.name.length - 1);

      // Check if the runtimeVersion should be GC'ed
      if (shouldGCVersion(rtVersion)) {
        // List all objects under the `<rtVersion>/`
        await for (final obj in _bucket.list(prefix: d.name, delimiter: '')) {
          // Limit concurrency
          final r = await pool.request();

          // Schedule a microtask, that always ends by releasing the resource.
          // Any issues deleting are logged as a warning, we'll probably try
          // again later, so this is not really an issue.
          scheduleMicrotask(() async {
            try {
              await _bucket.delete(obj.name);
            } catch (e, st) {
              _log.warning('Failed to garbage collect: ${d.name}', e, st);
            } finally {
              r.release(); // always release to avoid deadlock
            }
          });
        }
      }
    }

    // Close the pool, and wait for all pending deletion request to complete.
    await pool.close();
    await pool.done;
  }

  /// Update [PackageState.lastDependencyChanged] for all packages with
  /// dependency on [package] to at-least [publishedAt].
  Future<void> _updateLastDependencyChangedForDependents(
    String package,
    DateTime publishedAt,
  ) async {
    // Max concurrency of 20!
    final pool = Pool(20);

    // Query for [PackageState] that has [package] listed in [dependencies].
    // Notice that datastore query logic for `dependencies = package` means
    // entities where:
    //  (A) `dependencies` is equal to `package` (won't happen here).
    //  (B) `dependencies` is a list of strings containing `packages`,
    //      this is the matching logic we leverage here.
    //
    // We only update [PackageState] to have [lastDependencyChanged], this
    // ensures that there is no risk of indefinite propagation.
    final q = _db.query<PackageState>()
      ..filter('dependencies =', package)
      ..filter('lastDependencyChanged <', publishedAt);
    await for (final state in q.run()) {
      final r = await pool.request();

      // Schedule a microtask that attempts to update [lastDependencyChanged],
      // and logs any failures before always releasing the [r].
      scheduleMicrotask(() async {
        try {
          final changed = await withRetryTransaction(_db, (tx) async {
            // Reload [state] within a transaction to avoid overwriting changes
            // made by others trying to update state for another package.
            final s = await tx.lookupValue<PackageState>(state.key);
            if (s.lastDependencyChanged!.isBefore(publishedAt)) {
              tx.insert(
                s
                  ..lastDependencyChanged = publishedAt
                  ..derivePendingAt(),
              );
              return true;
            }
            return false;
          });
          if (changed) {
            await _purgeCache(state.package);
          }
        } catch (e, st) {
          _log.warning(
            'failed to propagate lastDependencyChanged for ${state.package}',
            e,
            st,
          );
        } finally {
          r.release(); // always release to avoid deadlocks
        }
      });
    }
    // Close the pool -- no more resources requested.
    await pool.close();
    // Wait for all resources to be released.
    await pool.done;
  }

  // Handles POST `/api/tasks/$package/$version/upload`
  Future<api.UploadTaskResultResponse> handleUploadResult(
    shelf.Request request,
    String package,
    String version,
  ) async {
    InvalidInputException.checkPackageName(package);
    version = InvalidInputException.checkSemanticVersion(version);

    final key = PackageState.createKey(_db, runtimeVersion, package);
    final state = await _db.lookupOrNull<PackageState>(key);
    if (state == null || state.versions![version] == null) {
      throw NotFoundException.resource('$package/$version');
    }
    final versionState = state.versions![version]!;

    // Check the secret token
    if (!versionState.isAuthorized(_extractBearerToken(request))) {
      throw AuthenticationException.authenticationRequired();
    }
    assert(versionState.scheduled != initialTimestamp);
    assert(versionState.instance != null);
    assert(versionState.zone != null);

    // Set expiration of signed URLs to remaining execution time + 5 min to
    // allow for clock skew.
    final expiration = maxTaskExecutionTime -
        (clock.now().difference(versionState.scheduled)) +
        Duration(minutes: 5);

    // Use sha256 truncated to 32 bytes as identifier
    final blobId = hex
        .encode(sha256.convert(utf8.encode(versionState.instance!)).bytes)
        .substring(0, 32);

    final [blobUploadInfo, indexUploadInfo] = await Future.wait([
      uploadSigner.buildUpload(
        _bucket.bucketName,
        '$runtimeVersion/$package/$version/$blobId.blob',
        expiration,
        // Allow up to 300 MB, keep in mind that 1.6GB dartdoc compressed to 92MB.
        maxUploadSize: 300 * 1024 * 1024,
      ),
      uploadSigner.buildUpload(
        _bucket.bucketName,
        '$runtimeVersion/$package/$version/index.json',
        expiration,
        // Allow up to 64 MB just a sanity limit!
        maxUploadSize: 64 * 1024 * 1024,
      )
    ]);

    return api.UploadTaskResultResponse(
      blobId: '$runtimeVersion/$package/$version/$blobId.blob',
      blob: blobUploadInfo,
      index: indexUploadInfo,
    );
  }

  // Handles POST `/api/tasks/$package/$version/finished`
  Future<shelf.Response> handleUploadFinished(
    shelf.Request request,
    String package,
    String version,
  ) async {
    ArgumentError.checkNotNull(request, 'request');
    InvalidInputException.checkPackageName(package);
    version = InvalidInputException.checkSemanticVersion(version);

    String? zone, instance;
    bool isInstanceDone = false;
    final index = await _loadTaskResultIndex(
      package: package,
      version: version,
      runtimeVersion: runtimeVersion,
    );
    final summary = _panaSummaryFromGzippedBytes(
      package,
      version,
      await _gzippedTaskResult(index, 'summary.json'),
    );
    final hasDocIndexHtml = index.lookup('doc/index.html') != null;
    await withRetryTransaction(_db, (tx) async {
      final key = PackageState.createKey(_db, runtimeVersion, package);
      final state = await tx.lookupOrNull<PackageState>(key);
      if (state == null || state.versions![version] == null) {
        throw NotFoundException.resource('$package/$version');
      }
      final versionState = state.versions![version]!;

      // Check the secret token
      if (!versionState.isAuthorized(_extractBearerToken(request))) {
        throw AuthenticationException.authenticationRequired();
      }
      assert(versionState.scheduled != initialTimestamp);
      assert(versionState.instance != null);
      assert(versionState.zone != null);

      // Update dependencies, if pana summary has dependencies
      if (summary != null && summary.allDependencies != null) {
        final updatedDependencies = _updatedDependencies(
          state.dependencies,
          summary.allDependencies,
          // for logging only
          package: package,
          version: version,
        );
        // Only update if new dependencies have been discovered.
        // This avoids unnecessary churn on datastore when there is no changes.
        if (state.dependencies != updatedDependencies &&
            !{...?state.dependencies}.containsAll(updatedDependencies)) {
          state.dependencies = updatedDependencies;
        }
      }

      zone = versionState.zone!;
      instance = versionState.instance!;

      // Remove instanceName, zone, secretToken, and set attempts = 0
      state.versions![version] = PackageVersionStateInfo(
        scheduled: versionState.scheduled,
        docs: hasDocIndexHtml,
        pana: summary != null,
        finished: true,
        attempts: 0,
        instance: null, // version is no-longer running on this instance
        secretToken: null, // TODO: Consider retaining this for idempotency
        zone: null,
      );

      // Determine if something else was running on the instance
      isInstanceDone = state.versions!.values.none(
        (v) => v.instance == instance,
      );

      // Ensure that we update [state.pendingAt], otherwise it might be
      // re-scheduled way too soon.
      state.derivePendingAt();
      state.finished = clock.now().toUtc();

      tx.insert(state);
    });

    // Clearing the state cache after the update.
    await _purgeCache(package, version);

    // If nothing else is running on the instance, delete it!
    // We do this in a microtask after returning, so that it doesn't slow down
    // worker response. We avoid doing it in the transaction because we wish to
    // avoid doing this operation again if the transaction fails.
    if (isInstanceDone) {
      assert(zone != null && instance != null);
      _log.info('instance $instance is done, calling APIs to terminate it!');
      scheduleMicrotask(() async {
        try {
          await taskWorkerCloudCompute.delete(zone!, instance!);
        } catch (e, st) {
          _log.severe(
            'failed to delete task-worker w. zone/instance: $zone/$instance',
            e,
            st,
          );
        }
      });
    }

    return shelf.Response.ok('');
  }

  Future<Uint8List?> _readFromBucket(
    String path, {
    int? offset,
    int? length,
  }) async {
    try {
      return await _bucket.readAsBytes(
        path, offset: offset, length: length,
        maxSize: 10 * 1024 * 1024, // sanity limit
      );
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) {
        return null;
      }
      rethrow;
    } on MaximumSizeExceeded catch (e, st) {
      _log.shout('max size exceeded path: $path', e, st);
      return null;
    }
  }

  /// Purge cache entries used to serve [gzippedTaskResult] for given
  /// [package] and [version].
  Future<void> _purgeCache(String package, [String? version]) async {
    await Future.wait([
      cache.taskPackageStatus(package).purge(),
      cache.latestFinishedVersion(package).purge(),
      if (version != null) cache.taskResultIndex(package, version).purge(),
      if (version != null) purgeScorecardData(package, version, isLatest: true),
    ]);
  }

  /// Fetch and cache `index.json` for [package] and [version].
  ///
  /// The returned [BlobIndex] will carry a [BlobIndex.blobId] that is the
  /// path for the blob being reference, this path will include runtime-version,
  /// package name, version and randomized blobId.
  Future<BlobIndex?> _taskResultIndex(String package, String version) async {
    return await cache.taskResultIndex(package, version).get(
      () async {
        // Don't try to load index if we don't consider the version for analysis.
        final status = await packageStatus(package);
        if (!status.versions.containsKey(version)) {
          return BlobIndex.empty(blobId: '');
        }
        final versionStatus = status.versions[version]!.status;
        // if analysis has failed, don't try to load results
        if (versionStatus == PackageVersionStatus.failed) {
          return BlobIndex.empty(blobId: '');
        }
        return await _loadTaskResultIndex(
          package: package,
          version: version,
          runtimeVersion: status.runtimeVersion ?? runtimeVersion,
        );
      },
    );
  }

  Future<BlobIndex> _loadTaskResultIndex({
    required String package,
    required String version,
    required String runtimeVersion,
  }) async {
    final pathPrefix = '$runtimeVersion/$package/$version';
    final path = '$pathPrefix/index.json';
    final bytes = await _readFromBucket(path);
    if (bytes == null) {
      return BlobIndex.empty(blobId: '');
    }
    final index = BlobIndex.fromBytes(bytes);
    final blobId = index.blobId;
    // We must check that the blobId points to a file under:
    //  `$runtimeVersion/$package/$version/`
    // Technically, the blob index is produced by the sandbox and we cannot
    // trust it to not be malformed.
    if (!_blobIdPattern.hasMatch(blobId) ||
        !blobId.startsWith('$pathPrefix/')) {
      _log.warning('invalid blobId: "$blobId" in index in "$path"');
      return BlobIndex.empty(blobId: '');
    }
    if (bytes.length > 1024 * 1024) {
      _log.info(
          '[pub-task-large-index] index size over 1 MB: $package $version ${bytes.length}');
    }
    return index;
  }

  /// Return gzipped result from task for the given [package]/[version] or
  /// `null`.
  Future<List<int>?> gzippedTaskResult(
    String package,
    String version,
    String path,
  ) async {
    version = canonicalizeVersion(version)!;
    final index = await _taskResultIndex(package, version);
    if (index == null) {
      return null;
    }
    return await _gzippedTaskResult(index, path);
  }

  /// Return gzipped result of [path] from an [index] or `null` if it does not exists.
  Future<List<int>?> _gzippedTaskResult(BlobIndex index, String path) async {
    // Normalize // and remove initial slash
    if (path.startsWith('/') || path.contains('//')) {
      path = path.split('/').where((s) => s.isNotEmpty).join('/');
    }

    FileRange range;
    try {
      final r = index.lookup(path);
      if (r == null) {
        return null;
      }
      range = r;
    } on FormatException {
      return null;
    }

    // Notice that by using the [range.blobId] in the cache key we ensure that
    // if we purge `taskResultIndex` for the given [package]/[version] then
    // we'll not need to purge the cache for `gzippedTaskResult`, and we get the
    // new files.
    // Keep in mind that the [IndexBlob] return from [_taskResultIndex] has a
    // blobId that is the path to the blob within the task-result bucket.
    final length = range.end - range.start;
    if (length <= _gzippedTaskResultCacheSizeThreshold) {
      return cache.gzippedTaskResult(range.blobId, path).get(
            () => _readFromBucket(
              range.blobId,
              offset: range.start,
              length: length,
            ),
          );
    } else {
      return _readFromBucket(
        range.blobId,
        offset: range.start,
        length: length,
      );
    }
  }

  /// Return gzipped contents of file generated by dartdoc or `null`.
  Future<List<int>?> dartdocFile(
    String package,
    String version,
    String path,
  ) async {
    return await gzippedTaskResult(
      package,
      version,
      'doc/$path',
    );
  }

  /// Return [Summary] from pana or `null` if not available.
  ///
  /// The summary can be unavailable for a number of reasons:
  ///  * package is not tracked for analysis,
  ///  * package/version is not tracked for analysis,
  ///  * analysis is pending/running/failed
  ///  * time allocated for analysis was exhausted.
  ///
  /// Even, if the [Summary] from pana is missing, it's possible that the
  /// [taskLog] is present. This happens if the analysis failed gracefully or
  /// allocated time was exhausted before the worker completed all versions.
  Future<Summary?> panaSummary(String package, String version) async {
    final data = await gzippedTaskResult(package, version, 'summary.json');
    return _panaSummaryFromGzippedBytes(package, version, data);
  }

  Summary? _panaSummaryFromGzippedBytes(
      String package, String version, List<int>? data) {
    if (data == null) {
      return null;
    }
    try {
      return Summary.fromJson(
        gzippedUtf8JsonCodec.decode(data) as Map<String, dynamic>,
      );
    } on FormatException catch (e, st) {
      _log.shout('Summary for $package/$version is malformed', e, st);
      return null;
    }
  }

  /// Get log from task run of [package] and [version].
  ///
  /// If log is unavailable, it returns some information about the internal state.
  ///
  /// If log is unavailable it's usually because:
  ///  * package is not tracked for analysis,
  ///  * package/version is not tracked for analysis,
  ///  * analysis is pending/running, or,
  ///  * worker/analysis failed non-gracefully.
  ///
  /// Generally, the worker will upload a log with error messages if analysis
  /// fails or timeout are reached.
  Future<String?> taskLog(String package, String version) async {
    final data = await gzippedTaskResult(package, version, 'log.txt');
    if (data == null) {
      final status = await packageStatus(package);
      if (status.runtimeVersion == null) {
        return 'no log - no tracking information';
      }
      final v = status.versions[version];
      if (v == null) {
        return 'no log - version is not tracked';
      }
      return 'no log - current version status: ${v.status}';
    }
    try {
      return utf8.decode(gzip.decode(data), allowMalformed: true);
    } on FormatException catch (e, st) {
      _log.shout('Task log for $package/$version is malformed', e, st);
      return 'no log - `log.txt` contains malformed characters';
    }
  }

  /// Get the most up-to-date status information for a package that has already been analyzed.
  Future<PackageStateInfo> packageStatus(String package) async {
    final status = await cache.taskPackageStatus(package).get(() async {
      for (final rt in acceptedRuntimeVersions) {
        final key = PackageState.createKey(_db, rt, package);
        final state = await dbService.lookupOrNull<PackageState>(key);
        // skip states where the entry was created, but no analysis has not finished yet
        if (state == null || state.hasNeverFinished) {
          continue;
        }
        return PackageStateInfo(
          runtimeVersion: state.runtimeVersion!,
          package: package,
          versions: state.versions ?? {},
        );
      }
      return PackageStateInfo.empty(package: package);
    });
    return status ?? PackageStateInfo.empty(package: package);
  }

  /// Create a URL for getting a resource created in pana.
  ///
  /// This is used for screenshot images.
  ///
  /// This is handled by [handleTaskResource].
  String resourceUrl(String package, String version, String path) =>
      '/packages/$package/versions/$version/gen-res/$path';

  /// Backfills the tracking state and then processes in all packages with
  /// calling [processPayload].
  ///
  /// TODO: rework the callback method into Future<TaskResult> Function(String package, String version);
  ///       to handle the upload boilerplate inside this method.
  Future<void> backfillAndProcessAllPackages(
    Future<void> Function(Payload payload) processPayload,
  ) async {
    await backfillTrackingState();
    await for (final state in dbService.query<PackageState>().run()) {
      final zone = taskWorkerCloudCompute.zones.first;
      // ignore: invalid_use_of_visible_for_testing_member
      final payload = await updatePackageStateWithPendingVersions(
        dbService,
        state,
        zone,
        taskWorkerCloudCompute.generateInstanceName(),
      );
      if (payload == null) continue;
      await processPayload(payload);
    }
  }

  /// Trigger a one-off priority bump for [packageName].
  ///
  /// Intended to be used for admin actions, not intended for normal operations.
  Future<void> adminBumpPriority(String packageName) async {
    // Ensure we're up-to-date.
    await trackPackage(packageName);

    await withRetryTransaction(_db, (tx) async {
      final stateKey = PackageState.createKey(_db, runtimeVersion, packageName);
      final state = await tx.lookupOrNull<PackageState>(stateKey);
      if (state != null) {
        state.pendingAt = initialTimestamp;
        tx.insert(state);
      }
    });
  }

  /// Returns the latest version of the [package] which has a finished analysis.
  ///
  /// Returns `null` if no such version exists.
  Future<String?> latestFinishedVersion(String package) async {
    final cachedValue =
        await cache.latestFinishedVersion(package).get(() async {
      for (final rt in acceptedRuntimeVersions) {
        final key = PackageState.createKey(_db, rt, package);
        final state = await dbService.lookupOrNull<PackageState>(key);
        // skip states where the entry was created, but no analysis has not finished yet
        if (state == null || state.hasNeverFinished) {
          continue;
        }
        final bestVersion = state.versions?.entries
            .where((e) => e.value.finished)
            .map((e) => Version.parse(e.key))
            .latestVersion;
        if (bestVersion != null) {
          // sanity check: the version is not deleted
          final pv = await packageBackend.lookupPackageVersion(
              package, bestVersion.toString());
          if (pv != null) {
            return bestVersion.toString();
          }
        }
      }
      return '';
    });
    return (cachedValue == null || cachedValue.isEmpty) ? null : cachedValue;
  }

  /// Returns the closest version of the [package] which has a finished analysis.
  ///
  /// If [version] or newer exists with finished analysis, it will be preferred, otherwise
  /// older versions may be considered too.
  ///
  /// When [preferDocsCompleted] is set, a successfully completed but potentially older
  /// version is preferred over a completed version without documentation.
  ///
  /// Returns `null` if no such version exists.
  Future<String?> closestFinishedVersion(
    String package,
    String version, {
    bool preferDocsCompleted = false,
  }) async {
    final cachedValue =
        await cache.closestFinishedVersion(package, version).get(() async {
      final semanticVersion = Version.parse(version);
      for (final rt in acceptedRuntimeVersions) {
        final key = PackageState.createKey(_db, rt, package);
        final state = await dbService.lookupOrNull<PackageState>(key);
        // Skip states where the entry was created, but the analysis has not finished yet.
        if (state == null || state.hasNeverFinished) {
          continue;
        }
        List<Version>? candidates;
        if (preferDocsCompleted) {
          final finishedDocCandidates = state.versions?.entries
              .where((e) => e.value.docs)
              .map((e) => Version.parse(e.key))
              .toList();
          if (finishedDocCandidates != null &&
              finishedDocCandidates.isNotEmpty) {
            candidates = finishedDocCandidates;
          }
        }

        candidates ??= state.versions?.entries
            .where((e) => e.value.finished)
            .map((e) => Version.parse(e.key))
            .toList();
        if (candidates == null || candidates.isEmpty) {
          continue;
        }
        if (candidates.contains(semanticVersion)) {
          return version;
        }
        final newerCandidates =
            candidates.where((e) => isNewer(semanticVersion, e)).toList();
        if (newerCandidates.isNotEmpty) {
          // Return the earliest finished that is newer than [version].
          return newerCandidates
              .reduce((a, b) => isNewer(a, b) ? a : b)
              .toString();
        }
        return candidates.latestVersion!.toString();
      }
      return '';
    });
    return (cachedValue == null || cachedValue.isEmpty) ? null : cachedValue;
  }
}

final _blobIdPattern = RegExp(r'^[^/]+/[^/]+/[^/]+/[0-9a-fA-F]+\.blob$');

/// Extract `<token>` from `Authorization: Bearer <token>`.
String? _extractBearerToken(shelf.Request request) {
  final authorization = request.headers['authorization'];
  if (authorization == null || authorization.isEmpty) {
    return null;
  }

  final parts = authorization.split(' ');
  if (parts.length != 2 || parts.first.trim().toLowerCase() != 'bearer') {
    return null;
  }
  return parts.last.trim();
}

/// Given a list of versions return the list of versions that should be
/// tracked for analysis.
///
/// We don't analyze all versions, instead we aim to only analyze:
///  * Latest two stable releases (or latest release if it is not yet stable);
///  * Latest preview release (if newer than latest stable release);
///  * Latest prerelease (if newer than latest preview release);
///  * 5 latest major versions (if any).
List<Version> _versionsToTrack(
  Package package,
  List<PackageVersion> packageVersions,
) {
  final visibleVersions = packageVersions
      // Ignore retracted versions
      .where((pv) => !pv.isRetracted)
      // Ignore moderated versions
      .where((pv) => !pv.isModerated)
      .map((pv) => pv.semanticVersion)
      .toSet();
  final visibleStableVersions = visibleVersions
      // Ignore prerelease versions
      .where((v) => !v.isPreRelease)
      .toList()
    ..sort((a, b) => -a.compareTo(b));
  return {
    // Always analyze latest version (may be non-stable if package has only prerelease versions).
    package.latestSemanticVersion,

    // Consider latest two stable versions to keep previously analyzed results on new package publishing.
    ...visibleStableVersions.take(2),

    // Only consider prerelease and preview versions, if they are newer than
    // the current stable release.
    if (package.showPrereleaseVersion) package.latestPrereleaseSemanticVersion,
    if (package.showPreviewVersion) package.latestPreviewSemanticVersion,

    // Consider 5 latest major versions, if any:
    ...visibleStableVersions
        // Create a map from major version to latest version in series.
        .groupFoldBy<int, Version>(
          (v) => v.major,
          (a, b) => a == null || a < b ? b : a,
        )
        // Just take the latest version for each major version, sort and take 5
        .values
        .sorted(Comparable.compare)
        .reversed
        .take(5)
  }.nonNulls.where(visibleVersions.contains).toList();
}

List<String> _updatedDependencies(
  List<String>? dependencies,
  List<String>? discoveredDependencies, {
  required String package,
  required String version,
}) {
  dependencies ??= [];
  discoveredDependencies ??= [];

  // If discoveredDependencies is in dependencies, then we're done.
  if (dependencies.toSet().containsAll(discoveredDependencies)) {
    return dependencies;
  }

  // Check if any of the dependencies returned have invalid names, if this is
  // the case, then we should ignore the entire result!
  final hasBadDependencies = discoveredDependencies.any((dep) {
    try {
      // TODO: These sanity checks should probably split out, into a general
      //       extension method on [Summary]. The idea here is to protect
      //       against invalid data from the sandbox. We should consider all
      //       the output we get from the sandbox as suspect :D
      InvalidInputException.checkPackageName(dep);
      return false;
    } on ResponseException {
      _log.shout(
        'pub_worker responses with summary.allDependencies containing "$dep"'
        ' in package "$package" version "$version"',
      );
      return true;
    }
  });
  if (hasBadDependencies) {
    return dependencies; // no changes!
  }

  // An indexed property cannot be larger than 1500 bytes, strings counts as
  // length + 1, so we prefer newly [discoveredDependencies] and then choose
  // [dependencies], after which we just pick the dependencies we can get while
  // staying below 1500 bytes.
  var size = 0;
  return discoveredDependencies
      .followedBy(dependencies.whereNot(discoveredDependencies.contains))
      .takeWhile((p) => (size += p.length + 1) < 1500)
      .sorted();
}
