// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../package/backend.dart';
import '../package/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/popularity_storage.dart';
import '../shared/versions.dart' as versions;

import 'model.dart';

export 'model.dart';

const _shortExtendDuration = Duration(hours: 12);

final _logger = Logger('pub.job.backend');

typedef ShouldProcess = Future<bool> Function(
    String package, String version, DateTime updated);

/// Sets the active job backend.
void registerJobBackend(JobBackend backend) =>
    ss.register(#_job_backend, backend);

/// The active job backend.
JobBackend get jobBackend => ss.lookup(#_job_backend) as JobBackend;

class JobBackend {
  final db.DatastoreDB _db;

  JobBackend(this._db);

  String _id(JobService service, String package, String version) => Uri(
        pathSegments: [
          versions.runtimeVersion,
          service.toString().split('.').last,
          package,
          version,
        ],
      ).toString();

  /// Triggers analysis job.
  Future<void> triggerAnalysis(
    String package,
    String? version, {
    bool isHighPriority = false,
  }) async {
    await jobBackend.trigger(
      JobService.analyzer,
      package,
      version: version,
      isHighPriority: isHighPriority,
    );
  }

  /// Triggers analysis/dartdoc for [package]/[version] if older than [updated].
  Future<void> trigger(
    JobService service,
    String package, {
    String? version,
    DateTime? updated,
    bool? shouldProcess,
    bool isHighPriority = false,
  }) async {
    final pKey = _db.emptyKey.append(Package, id: package);
    final p = await _db.lookupOrNull<Package>(pKey);
    if (p == null || p.isNotVisible) {
      _logger.info("Couldn't trigger $service job: $package not found.");
      return;
    }
    final latestReleases = await packageBackend.latestReleases(p);

    version ??= latestReleases.stable.version;
    final pvKey = pKey.append(PackageVersion, id: version);
    final pv = await _db.lookupOrNull<PackageVersion>(pvKey);
    if (pv == null) {
      _logger
          .info("Couldn't trigger $service job: $package $version not found.");
      return;
    }

    final isLatestStable = p.latestVersion == version;
    final isLatestPrerelease = latestReleases.showPrerelease &&
        latestReleases.prerelease!.version == version;
    final isLatestPreview = latestReleases.showPreview &&
        latestReleases.preview!.version == version;
    shouldProcess ??= updated == null || updated.isAfter(pv.created!);
    shouldProcess |= isHighPriority;
    await createOrUpdate(
      service: service,
      package: package,
      version: version,
      isLatestStable: isLatestStable,
      isLatestPrerelease: isLatestPrerelease,
      isLatestPreview: isLatestPreview,
      packageVersionUpdated: pv.created,
      shouldProcess: shouldProcess,
      priority: isHighPriority ? 0 : null,
    );
  }

  Future<void> createOrUpdate({
    required JobService service,
    required String package,
    required String version,
    required bool isLatestStable,
    required bool isLatestPrerelease,
    required bool isLatestPreview,
    required DateTime? packageVersionUpdated,
    required bool shouldProcess,
    int? priority,
  }) async {
    packageVersionUpdated ??= clock.now().toUtc();
    final id = _id(service, package, version);
    final state = shouldProcess ? JobState.available : JobState.idle;
    final lockedUntil =
        shouldProcess ? null : clock.now().add(_shortExtendDuration);
    await db.withRetryTransaction(_db, (tx) async {
      final current =
          await tx.lookupOrNull<Job>(_db.emptyKey.append(Job, id: id));
      if (current != null) {
        final hasNotChanged = current.isLatestStable == isLatestStable &&
            current.isLatestPrerelease == isLatestPrerelease &&
            current.isLatestPreview == isLatestPreview &&
            !current.packageVersionUpdated!.isBefore(packageVersionUpdated!) &&
            (priority == null || current.priority <= priority);
        if (hasNotChanged && !shouldProcess) {
          // no reason to re-schedule the job
          return;
        }
        if (current.state == JobState.available &&
            current.lockedUntil == null) {
          // already scheduled for processing
          return;
        }
        _logger.info('Updating job: $id ($state, $lockedUntil)');
        current
          ..isLatestStable = isLatestStable
          ..isLatestPrerelease = isLatestPrerelease
          ..isLatestPreview = isLatestPreview
          ..packageVersionUpdated = packageVersionUpdated
          ..state = state
          ..lockedUntil = lockedUntil
          ..processingKey = null // drops ongoing processing
          ..updatePriority(
            popularityStorage.lookup(package),
            fixPriority: priority,
          );
        tx.insert(current);
        return;
      } else {
        _logger.info('Creating job: $id');
        final job = Job()
          ..id = id
          ..service = service
          ..packageName = package
          ..packageVersion = version
          ..isLatestStable = isLatestStable
          ..isLatestPrerelease = isLatestPrerelease
          ..isLatestPreview = isLatestPreview
          ..packageVersionUpdated = packageVersionUpdated
          ..state = JobState.available
          ..lockedUntil = null
          ..lastStatus = JobStatus.none
          ..runtimeVersion = versions.runtimeVersion
          ..errorCount = 0
          ..updatePriority(
            popularityStorage.lookup(package),
            fixPriority: priority,
          );
        tx.insert(job);
        return;
      }
    });
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future<void> deleteOldEntries() async {
    final query = _db.query<Job>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion);
    await _db.deleteWithQuery<Job>(query);
  }
}
