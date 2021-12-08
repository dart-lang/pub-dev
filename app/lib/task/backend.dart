import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart'
    show readChunkedStream, MaximumSizeExceeded;
import 'package:client_data/task_api.dart' as api;
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart' show Bucket;
import 'package:googleapis/storage/v1.dart'
    show DetailedApiRequestError, ApiRequestError;
import 'package:logging/logging.dart' show Logger;
import 'package:pana/models.dart' show Summary;
import 'package:pool/pool.dart' show Pool;
import 'package:pub_dev/package/backend.dart' show packageBackend;
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/redis_cache.dart' show cache;
import 'package:pub_dev/shared/utils.dart' show canonicalizeVersion;
import 'package:pub_dev/shared/versions.dart'
    show runtimeVersion, gcBeforeRuntimeVersion, shouldGCVersion;
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/global_lock.dart';
import 'package:pub_dev/task/models.dart'
    show PackageState, PackageVersionState, maxTaskExecutionTime;
import 'package:pub_dev/task/scheduler.dart';
import 'package:pub_worker/blob.dart' show BlobIndex;
import 'package:pub_worker/pana_report.dart' show PanaReport;
import 'package:retry/retry.dart' show retry;
import 'package:shelf/shelf.dart' as shelf;

final _log = Logger('pub.task.backend');

/// Register a [CloudCompute] pool for task workers in the current
/// service scope.
void registertaskWorkerCloudCompute(CloudCompute workerPool) =>
    ss.register(#_taskWorkerCloudCompute, workerPool);

/// Get the active [CloudCompute] pool for task workers.
CloudCompute get taskWorkerCloudCompute =>
    ss.lookup(#_taskWorkerCloudCompute) as CloudCompute;

/// Sets the task backend service.
void registerTaskBackend(TaskBackend backend) =>
    ss.register(#_taskBackend, backend);

/// The active task backend service.
TaskBackend get taskBackend => ss.lookup(#_taskBackend) as TaskBackend;

// TODO: Reduce number of versions we want to track with some heuristics
//       latest stable/preview/prerelease.
//       5 latest major versions.
//
// TODO: Handle case where worker has it doesn't have time to process remaining versions
//       It probably just writes in log that it could do it within given time constraints
//       and calls finish for each version signaling that the version needs not be retriggered!
// NOTE: Tracking all versions could be too much overhead in entity size.

class TaskBackend {
  final DatastoreDB _db;
  final CloudCompute _cloudCompute;
  final Bucket _bucket;

  /// If [start] has been called to start background processes.
  var _started = false;

  /// If [close] has been called to stop background processes.
  final _aborted = Completer<void>();

  /// If background processes created by [start] have stoppped.
  ///
  /// This won't be resolved if [start] has not been called!
  final _stopped = Completer<void>();

  TaskBackend(this._db, this._cloudCompute, this._bucket);

  /// Start continuous background processes for scheduling of tasks.
  ///
  /// Calling [start] multiple times is an error.
  Future<void> start() async {
    if (_started) {
      throw StateError('TaskBackend.start() has already been called!');
    }
    if (_aborted.isCompleted) {
      throw StateError('TaskBackend.close() has already been called!');
    }
    _started = true;

    // Start scanning for packages to be tracked
    final _doneScanning = Completer<void>();
    scheduleMicrotask(() async {
      try {
        // Create a lock for task scheduling, so tasks
        final lock = GlobalLock.create(
          '$runtimeVersion/task/scanning',
          expiration: Duration(minutes: 25),
        );

        while (!_aborted.isCompleted) {
          // Acquire the global lock and scan for package changes while lock is
          // valid.
          await lock.withClaim((claim) async {
            await _scanForPackageUpdates(claim, abort: _aborted);
          }, abort: _aborted);
        }
      } catch (e, st) {
        _log.severe('scanning loop crashed', e, st);
      } finally {
        _log.fine('scanning loop stopped');
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

        while (!_aborted.isCompleted) {
          // Acquire the global lock and create VMs for pending packages, and
          // kill overdue VMs.
          await lock.withClaim((claim) async {
            await schedule(claim, _cloudCompute, _db, abort: _aborted);
          }, abort: _aborted);
        }
      } catch (e, st) {
        _log.severe('scheduling loop crashed', e, st);
      } finally {
        _log.fine('scheduling loop stopped');
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
      _stopped.complete();
    });
  }

  /// Stop any background process that may be running.
  ///
  /// Calling this method is always safe.
  Future<void> close() async {
    if (!_aborted.isCompleted) {
      _aborted.complete();
    }
    if (_started) {
      await _stopped.future;
    }
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

      final r = await pool.request();
      scheduleMicrotask(() async {
        try {
          await _trackPackage(p.name!);
        } catch (e, st) {
          _log.severe('failed to track state for "${p.name}"', e, st);
          if (error == null) {
            error = e; // save [e] for later, if this is the first failure
            stackTrace = st;
          }
        } finally {
          r.release(); // always release to avoid deadlock
        }
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

    var since = clock.ago(minutes: 30);
    while (claim.valid && !abort.isCompleted) {
      // Look at all packages changed in [since]
      final q = _db.query<Package>()
        ..filter('updated >', since)
        ..order('-updated');

      // Next time we'll only consider changes since now - 5 minutes
      since = clock.ago(minutes: 5);

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
        await _trackPackage(p.name!);
      }

      // Cleanup the [seen] map for anything older than [since], as this won't
      // be relevant to the next iteration.
      seen.removeWhere((_, updated) => updated.isBefore(since));

      // Wait 10 minutes before scanning again!
      await Future.any([
        Future.delayed(Duration(minutes: 10)),
        abort.future,
      ]);
    }
  }

  Future<void> _trackPackage(String packageName) async {
    await withRetryTransaction(_db, (tx) async {
      final pkgKey = _db.emptyKey.append(Package, id: packageName);

      final stateKey = PackageState.createKey(_db, runtimeVersion, packageName);
      // Lookup Package and PackageVersion in the same transaction.
      // Await results later to ensure concurrent lookups!
      final packageFuture = tx.lookupOrNull<Package>(pkgKey);
      final versionsFuture = tx.query<PackageVersion>(pkgKey).run().toList();
      final state = await tx.lookupOrNull<PackageState>(stateKey);
      final package = await packageFuture;
      final versions = await versionsFuture;
      if (package == null) {
        return; // assume package was deleted!
      }

      // If package is not visible, we should remove it!
      if (package.isNotVisible) {
        if (state != null) {
          tx.delete(state.key);
        }
        return;
      }

      // Ensure we have PackageState entity
      if (state == null) {
        // Create [PackageState] entity to track the package
        _log.info('Started state tracking for $packageName');
        tx.insert(
          PackageState()
            ..setId(runtimeVersion, packageName)
            ..runtimeVersion = runtimeVersion
            ..versions = {
              for (final v in versions)
                v.version!: PackageVersionState(
                  scheduled: DateTime(0),
                  attempts: 0,
                ),
            }
            ..dependencies = <String>[]
            ..lastDependencyChanged = DateTime(0)
            ..derivePendingAt(),
        );
        return; // no more work for this package, state is sync'ed
      }

      // List versions that not tracked, but should be
      final untrackedVersions = versions
          .map((v) => v.version!)
          .whereNot((v) => state.versions!.containsKey(v))
          .toList();

      // List of versions that are tracked, but don't exist. These have
      // probably been deleted.
      final deletedVersions = state.versions!.keys
          .where((v) => versions.none((pv) => pv.version == v))
          .toList();

      // There should never be an overlap between versions untracked and
      // versions that tracked by now missing / deleted.
      assert(
        untrackedVersions.toSet().intersection(deletedVersions.toSet()).isEmpty,
      );

      // Stop transaction, if there is no changes to be made!
      if (untrackedVersions.isEmpty && deletedVersions.isEmpty) {
        return;
      }

      // Make changes!
      state.versions!
        // Remove versions that have been deleted
        ..removeWhere((v, _) => deletedVersions.contains(v))
        // Add versions we should be tracking
        ..addAll({
          for (final v in untrackedVersions)
            v: PackageVersionState(
              scheduled: DateTime(0),
              attempts: 0,
            ),
        });

      _log.info('Update state tracking for $packageName');
      tx.insert(state);
    });
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

  /// Report [package] and [version] published and trigger analysis if required.
  ///
  /// It is always to safe to call [trackPackageVersion] for a [package] and
  /// [version] that exists. This method simply ensures that the [package] and
  /// [version] is tracked, and that all packages with dependency on [package]
  /// is scheduled for new analysis.
  Future<void> trackPackageVersion(String package, String version) async {
    version = canonicalizeVersion(version)!;

    final packageVersion = await packageBackend.lookupPackageVersion(
      package,
      version,
    );
    if (packageVersion == null) {
      throw StateError(
        'TaskBackend.trackPackageVersion($package, $version) was called before '
        'PackageVersion entity is created',
      );
    }

    // Ensure that `version` is present in [PackageState.versions]
    await withRetryTransaction(_db, (tx) async {
      final key = PackageState.createKey(_db, runtimeVersion, package);
      var state = await tx.lookupOrNull<PackageState>(key);
      // If state is present and contains `version` then we're done.
      if (state != null && state.versions!.containsKey(version)) {
        return;
      }

      // Ensure we have PackageState entity
      state ??= PackageState()
        ..setId(runtimeVersion, package)
        ..runtimeVersion = runtimeVersion
        ..versions = {}
        ..dependencies = <String>[]
        ..lastDependencyChanged = DateTime(0);

      // Ensure the version is present
      state.versions![version] ??= PackageVersionState(
        scheduled: DateTime(0),
        attempts: 0,
      );

      // Update pendingAt
      state.derivePendingAt();

      // Store state
      tx.insert(state);
    });

    await _updateLastDependencyChangedForDependents(
      package,
      packageVersion.created!,
    );
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
    // ensures that there is no risk of indefinite propergation.
    final q = _db.query<PackageState>()
      ..filter('dependencies =', package)
      ..filter('lastDependencyChanged <', publishedAt);
    await for (final state in q.run()) {
      final r = await pool.request();

      // Schedule a microtask that attempts to update [lastDependencyChanged],
      // and logs any failures before always releasing the [r].
      scheduleMicrotask(() async {
        try {
          await withRetryTransaction(_db, (tx) async {
            // Reload [state] within a transaction to avoid overwriting changes
            // made by others trying to update state for another package.
            final s = await tx.lookupValue<PackageState>(state.key);
            if (s.lastDependencyChanged!.isBefore(publishedAt)) {
              tx.insert(
                s
                  ..lastDependencyChanged = publishedAt
                  ..derivePendingAt(),
              );
            }
          });
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
    if (versionState.isAuthorized(_extractBearerToken(request))) {
      throw AuthenticationException.authenticationRequired();
    }
    assert(versionState.scheduled != DateTime(0));
    assert(versionState.instance != null);
    assert(versionState.zone != null);

    // Set expiration of signed URLs to remaining execution time + 5 min to
    // allow for clock skew.
    final expiration = maxTaskExecutionTime -
        (clock.now().difference(versionState.scheduled)) +
        Duration(minutes: 5);

    // Use sha256 truncated to 32 bytes as identifier
    final id = hex
        .encode(sha256.convert(utf8.encode(versionState.instance!)).bytes)
        .substring(0, 32);

    final uploadInfos = await Future.wait([
      'run-$id-dartdoc.blob',
      'run-$id-log.txt',
      'dartdoc-index.json',
      'pana-report.json',
    ].map(
      (name) => uploadSigner.buildUpload(
        _bucket.bucketName,
        '$runtimeVersion/$package/$version/$name',
        expiration,
      ),
    ));
    assert(uploadInfos.length == 4);

    return api.UploadTaskResultResponse(
      dartdocBlobId: 'run-$id-dartdoc.blob',
      panaLogId: 'run-$id-log.txt',
      dartdocBlob: uploadInfos[0],
      panaLog: uploadInfos[1],
      dartdocIndex: uploadInfos[2],
      panaReport: uploadInfos[3],
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
    await withRetryTransaction(_db, (tx) async {
      final key = PackageState.createKey(_db, runtimeVersion, package);
      final state = await tx.lookupOrNull<PackageState>(key);
      if (state == null || state.versions![version] == null) {
        throw NotFoundException.resource('$package/$version');
      }
      final versionState = state.versions![version]!;

      // Check the secret token
      if (versionState.isAuthorized(_extractBearerToken(request))) {
        throw AuthenticationException.authenticationRequired();
      }
      assert(versionState.scheduled != DateTime(0));
      assert(versionState.instance != null);
      assert(versionState.zone != null);

      zone = versionState.zone!;
      instance = versionState.instance!;

      // Remove instanceName, zone, secretToken, and set attempts = 0
      state.versions![version] = PackageVersionState(
        scheduled: versionState.scheduled,
        attempts: 0,
        instance: null, // version is no-longer running on this instance
        secretToken: null, // TODO: Consider retaining this for idempotency
        zone: null,
      );

      // Determine if something else was running on the instance
      isInstanceDone = state.versions!.values.any(
        (v) => v.instance == instance,
      );

      // Update dependencies, if pana summary has dependencies
      final summary = await panaSummary(package, version);
      if (summary != null && summary.allDependencies != null) {
        // TODO: Limit size of dependencies!!

        final dependencies = {...state.dependencies ?? []};
        // Only update if new dependencies have been discovered.
        // This avoids unnecessary churn on datastore when there is no changes.
        if (!dependencies.containsAll(summary.allDependencies ?? [])) {
          state.dependencies = {
            ...dependencies,
            ...summary.allDependencies ?? [],
          }.sorted();
        }
      }

      tx.insert(state);
    });

    // If nothing else is running on the instance, delete it!
    // We do this in a microtask after returning, so that it doesn't slow down
    // worker response. We avoid doing it in the transaction because we wish to
    // avoid doing this operation again if the transaction fails.
    if (isInstanceDone) {
      assert(zone != null && instance != null);
      scheduleMicrotask(() async {
        try {
          await _cloudCompute.delete(zone!, instance!);
        } catch (e, st) {
          _log.severe(
            'failed to delete task-worker w. zone/instance: $zone/$instance',
            e,
            st,
          );
        }
      });
    }

    // Clear cache entries for package / version
    await _purgeCache(package, version);

    return shelf.Response.ok('');
  }

  Future<List<int>?> _readFromBucket(
    String path, {
    int? offset,
    int? length,
  }) async =>
      await retry(
        () async {
          try {
            return await readChunkedStream(
              _bucket.read(path, offset: offset, length: length),
              maxSize: 10 * 1024 * 1024, // sanity limit
            );
          } on MaximumSizeExceeded catch (e, st) {
            _log.shout(
              'max size exceeded path: $path',
              e,
              st,
            );
            return null;
          }
        },
        maxAttempts: 3,
        retryIf: (e) {
          if (e is IOException) {
            return true; // I/O issues are worth retrying
          }
          if (e is DetailedApiRequestError) {
            final status = e.status;
            return status == null || status >= 500; // 5xx errors are retried
          }
          return e is ApiRequestError; // Unknown API errors are retried
        },
      ).catchError(
        (_) => null,
        test: (e) => e is DetailedApiRequestError && e.status == 404,
      );

  /// Purge cache entries used to serve dartdoc and pana report for given
  /// [package] and [version].
  Future<void> _purgeCache(String package, String version) async =>
      await Future.wait([
        cache.dartdocIndex(package, version).purge(),
        cache.panaReport(package, version).purge(),
      ]);

  /// Fetch and cache dartdoc-index.json for [package] and [version].
  Future<BlobIndex?> _dartdocIndex(String package, String version) async =>
      await cache.dartdocIndex(package, version).get(() async {
        final path = '$runtimeVersion/$package/$version/pana-report.json';
        final bytes = await _readFromBucket(path);
        if (bytes == null) {
          return null;
        }
        return BlobIndex.fromBytes(bytes);
      });

  /// Return gzipped dartdoc page or `null`.
  Future<List<int>?> dartdocPage(
    String package,
    String version,
    String path,
  ) async {
    version = canonicalizeVersion(version)!;

    final index = await _dartdocIndex(package, version);
    if (index == null) {
      return null;
    }

    final range = index.lookup(path);
    if (range == null) {
      return null;
    }

    if (_dartdocBlobIdPattern.hasMatch(range.blobId)) {
      _log.warning(
          'invalid blobId: "${range.blobId}" in dartdoc-index for $package / $version');
      return null;
    }

    return await cache
        .dartdocPage(package, version, range.blobId, path)
        .get(() => _readFromBucket(
              '$runtimeVersion/$package/$version/${range.blobId}',
              offset: range.start,
              length: range.end - range.start,
            ));
  }

  /// Fetch and cache [PanaReport] for [package] and [version].
  ///
  /// This will not cache malformed reports or missing reports, but instead
  /// return `null` for such cases.
  Future<PanaReport?> _panaReport(String package, String version) async =>
      await cache.panaReport(package, version).get(() async {
        final path = '$runtimeVersion/$package/$version/pana-report.json';
        final data = await _readFromBucket(path);
        if (data == null) {
          return null;
        }
        try {
          return PanaReport.fromJson(
            json.fuse(utf8).decode(data) as Map<String, dynamic>,
          );
        } on FormatException catch (e, st) {
          _log.shout('PanaReport at $path is malformed', e, st);
          return null;
        }
      });

  /// Return [Summary] from pana or `null` if not available.
  Future<Summary?> panaSummary(String package, String version) async {
    version = canonicalizeVersion(version)!;

    final report = await _panaReport(package, version);
    return report?.summary;
  }

  /// Get log from pana run of [package] and [version].
  ///
  /// Returns `null`, if not available.
  Future<String?> panaLog(String package, String version) async {
    version = canonicalizeVersion(version)!;

    final report = await _panaReport(package, version);
    if (report == null) {
      return null;
    }
    // Basic sanity check
    if (_panaLogIdPattern.hasMatch(report.logId)) {
      _log.shout(
        'Invalid PanaReport.logId: "${report.logId}" for $package/$version',
        Exception('Invalid logId'),
      );
      return null;
    }

    return await cache.panaLog(package, version, report.logId).get(() async {
      final path = '$runtimeVersion/$package/$version/${report.logId}';
      final data = await _readFromBucket(path);
      if (data == null) {
        return null;
      }
      return utf8.decode(data, allowMalformed: true);
    });
  }
}

final _panaLogIdPattern = RegExp(r'^run-[0-9a-fA-F]+-log\.txt$');
final _dartdocBlobIdPattern = RegExp(r'^run-[0-9a-fA-F]+-dartdoc\.blob$');

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
