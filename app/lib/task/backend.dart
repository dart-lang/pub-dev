import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chunked_stream/chunked_stream.dart'
    show readChunkedStream, MaximumSizeExceeded;
import 'package:client_data/task_api.dart' as api;
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
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/redis_cache.dart' show cache;
import 'package:pub_dev/shared/utils.dart' show canonicalizeVersion;
import 'package:pub_dev/shared/versions.dart' show runtimeVersion;
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

// TODO: Create setupTaskBackend() which creates bucket, cloudCompute
// TODO: Ensure that runBackgroundProcessing() is triggered in default instance at startup

/// Sets the task backend service.
void registerTaskBackend(TaskBackend backend) =>
    ss.register(#_taskBackend, backend);

/// The active task backend service.
TaskBackend get taskBackend => ss.lookup(#_taskBackend) as TaskBackend;

class TaskBackend {
  final DatastoreDB _db;
  final CloudCompute _cloudCompute;
  final Bucket _bucket;

  TaskBackend._(this._db, this._cloudCompute, this._bucket);

  /// Run background processing, it should be sufficient to create one of these
  /// for the entire system. However, it is important that at-least one of these
  /// are running at any given time.
  Future<void> runBackgroundProcessing() async {
    // TODO: Scan for new updated packages
    //       Loop:
    //         for each package (updated since)
    //            trackPackageVersion(..)
    //         sleep
    // Consider using another global lock for this to reduce number of write
    // conflicts.

    final lock = GlobalLock.create(
      '$runtimeVersion/task/scheduler',
      expiration: Duration(minutes: 25),
    );

    // ignore: literal_only_boolean_expressions
    while (true) {
      // acquire the global lock and create VMs for pending packages, and
      // kill overdue VMs.
      await lock.withClaim((claim) async {
        await schedule(claim, _cloudCompute, _db);
      });
    }
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
    // TODO: Find out if [PackageVersion.created] can be null, this is undocumented
    final publishedAt = packageVersion.created ?? DateTime.now().toUtc();

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
        ..lastDependencyChanged = publishedAt;

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

    // With concurrency of 20, update `lastDependencyChanged` and `pendingAt`
    // for all [PackageState] entities with a dependency on `package`.
    final pool = Pool(20);
    final q = _db.query<PackageState>()
      ..filter('dependencies =', package)
      ..filter('lastDependencyChanged <', publishedAt);
    await for (final state in q.run()) {
      final r = await pool.request();
      scheduleMicrotask(() async {
        try {
          await withRetryTransaction(_db, (tx) async {
            final s = await tx.lookupValue<PackageState>(state.key);
            if (s.lastDependencyChanged!.isBefore(publishedAt)) {
              s.lastDependencyChanged = publishedAt;
              s.derivePendingAt();
              tx.insert(s);
            }
          });
        } finally {
          r.release();
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
        (DateTime.now().difference(versionState.scheduled)) +
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
        instance: null,
        secretToken: null,
        zone: null,
      );

      tx.insert(state);

      // Determine if something else was running on the instance
      isInstanceDone = state.versions!.values.any(
        (v) => v.instance == instance,
      );
    });

    // If nothing else is running on the instance, delete it!
    // We do this in a microtask after returning, so that it doesn't slow down
    // worker response. We avoid doing it in the transaction because we wish to
    // avoid this operation being retried.
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
