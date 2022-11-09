// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../package/backend.dart';
import '../package/models.dart';
import '../shared/datastore.dart' as db;
import '../shared/popularity_storage.dart';
import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'model.dart';

export 'model.dart';

const _defaultLockDuration = Duration(hours: 1);
const _shortExtendDuration = Duration(hours: 12);
const _longExtendDuration = Duration(days: 3);

final _logger = Logger('pub.job.backend');
final _random = math.Random.secure();

typedef ShouldProcess = Future<bool> Function(
    String package, String version, DateTime updated);

/// Sets the active job backend.
void registerJobBackend(JobBackend backend) =>
    ss.register(#_job_backend, backend);

/// The active job backend.
JobBackend get jobBackend => ss.lookup(#_job_backend) as JobBackend;

class JobBackend {
  final db.DatastoreDB _db;
  final _lastStats = <JobService, List<_AllStats>>{};
  final _availablePools = <JobService, _AvailablePool>{};

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

  /// Triggers dartdoc job.
  Future<void> triggerDartdoc(
    String package,
    String? version, {
    bool? shouldProcess,
    bool isHighPriority = false,
  }) async {
    await jobBackend.trigger(
      JobService.dartdoc,
      package,
      version: version,
      shouldProcess: shouldProcess,
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

  Future<Job?> lockAvailable(JobService service) async {
    bool isApplicable(Job job) {
      if (job.state != JobState.available) return false;
      if (job.runtimeVersion != versions.runtimeVersion) return false;
      return true;
    }

    final pool = _availablePools.putIfAbsent(service, () => _AvailablePool());
    if (!pool.hasAvailable) {
      final query = _db.query<Job>()
        ..filter('runtimeVersion =', versions.runtimeVersion)
        ..filter('service =', service)
        ..filter('state =', JobState.available)
        ..order('priority')
        ..limit(200);
      final list = await query.run().toList();
      list.removeWhere((job) => !isApplicable(job));
      pool.update(list);
    }

    while (pool.hasAvailable) {
      final candidate = pool.select();

      final job = await db.withRetryTransaction(_db, (tx) async {
        final selected = await tx.lookupOrNull<Job>(candidate.key);

        if (selected == null ||
            !isApplicable(selected) ||
            selected.attemptCount != candidate.attemptCount ||
            selected.processingKey != candidate.processingKey) {
          pool.markRace();
          return null;
        }
        final now = clock.now().toUtc();
        selected
          ..state = JobState.processing
          ..attemptCount = (selected.attemptCount ?? 0) + 1
          ..processingKey = createUuid()
          ..lockedUntil = now.add(_defaultLockDuration);
        tx.insert(selected);
        return selected;
      });
      if (job != null) return job;
    }
    return null;
  }

  Future<void> unlockStaleProcessing(JobService service) async {
    Future<void> _unlock(Job job) async {
      await db.withRetryTransaction(_db, (tx) async {
        final current = await tx.lookupValue<Job>(job.key);
        if (current.state == JobState.processing &&
            current.lockedUntil == job.lockedUntil) {
          final errorCount = current.errorCount + 1;
          current
            ..state = JobState.idle
            ..processingKey = null
            ..errorCount = errorCount
            ..lastStatus = JobStatus.aborted
            ..lockedUntil = _extendLock(errorCount)
            ..updatePriority(popularityStorage.lookup(job.packageName!));
          tx.insert(current);
        }
      });
    }

    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service)
      ..filter('state =', JobState.processing)
      ..filter('lockedUntil <', clock.now().toUtc());
    await for (Job job in query.run()) {
      try {
        await _unlock(job);
      } catch (e, st) {
        _logger.info('Unlock of $job failed.', e, st);
      }
    }
  }

  Future<void> checkIdle(
      JobService service, ShouldProcess shouldProcess) async {
    Future<void> _schedule(Job job) async {
      await db.withRetryTransaction(_db, (tx) async {
        final current = await tx.lookupValue<Job>(job.key);
        if (current.state == JobState.idle &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..state = JobState.available
            ..processingKey = null
            ..lockedUntil = null;
          tx.insert(current);
        }
      });
    }

    Future<void> _extend(Job job) async {
      await db.withRetryTransaction(_db, (tx) async {
        final current = await tx.lookupValue<Job>(job.key);
        if (current.state == JobState.idle &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..processingKey = null
            ..lockedUntil = clock.now().toUtc().add(_shortExtendDuration);
          tx.insert(current);
        }
      });
    }

    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service)
      ..filter('state =', JobState.idle)
      ..filter('lockedUntil <', clock.now().toUtc());
    await for (Job job in query.run()) {
      if (job.runtimeVersion != versions.runtimeVersion) continue;
      try {
        final process = await shouldProcess(
            job.packageName!, job.packageVersion!, job.packageVersionUpdated!);
        if (process) {
          await _schedule(job);
        } else {
          await _extend(job);
        }
      } catch (e, st) {
        _logger.info('Idle check of $job failed.', e, st);
      }
    }
  }

  Future<void> complete(Job job, JobStatus status, Duration runDuration) async {
    await db.withRetryTransaction(_db, (tx) async {
      final selected =
          await tx.lookupOrNull<Job>(_db.emptyKey.append(Job, id: job.id));
      if (selected == null) {
        _logger.info('Unable to complete missing job: $job.');
        return;
      }
      if (selected.processingKey == job.processingKey ||
          status == JobStatus.success) {
        _logger.info('Updating $job with $status');
        final isError =
            (status == JobStatus.failed) || (status == JobStatus.aborted);
        final errorCount = isError ? selected.errorCount + 1 : 0;
        selected
          ..state = JobState.idle
          ..lastStatus = status
          ..lastRunDurationInSeconds = runDuration.inSeconds
          ..processingKey = null
          ..errorCount = errorCount
          ..lockedUntil = _extendLock(errorCount)
          ..updatePriority(popularityStorage.lookup(selected.packageName!));
        tx.insert(selected);
      } else {
        _logger.info('Job $job completion aborted.');
      }
    });
  }

  Future<Map> stats(JobService service) async {
    final _AllStats stats = _AllStats();

    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service);
    await for (Job job in query.run()) {
      stats.add(job);
    }

    final List<_AllStats> list = _lastStats.putIfAbsent(service, () => []);
    stats.updateEstimates(list.isEmpty ? null : list.first);
    // keep only the last 60-90 minutes of stats
    while (list.isNotEmpty &&
        list.first.timestamp.difference(stats.timestamp).abs().inMinutes > 90) {
      list.removeAt(0);
    }
    list.add(stats);

    return stats.toMap();
  }

  DateTime _extendLock(int errorCount) {
    // If the Job completed without issues, or if the issues keep repeating more
    // than 3 times, the Job is forced to be idle for longer period.
    final extend = (errorCount == 0 || errorCount > 3)
        ? _longExtendDuration
        : _shortExtendDuration;
    return clock
        .now()
        .toUtc()
        .add(extend)
        .add(Duration(hours: math.min(errorCount, 168 /* one week */)));
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future<void> deleteOldEntries() async {
    final query = _db.query<Job>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion);
    await _db.deleteWithQuery<Job>(query);
  }
}

/// Tracks the cached results of the latest available Job query.
class _AvailablePool {
  final _jobs = <Job>[];
  DateTime _queried = clock.now();
  int _race = 0;

  /// Update pool with a fresh list of jobs.
  void update(List<Job> jobs) {
    _jobs.clear();
    _jobs.addAll(jobs);
    _queried = clock.now();
    _race = 0;
  }

  /// Returns whether a [Job] is available in the current pool.
  bool get hasAvailable {
    if (_jobs.isEmpty) return false;
    // expire list after 15 minutes
    if (clock.now().difference(_queried).inMinutes >= 15) return false;
    // force expire if there are too many races compared to the remaining items
    if (_race * 10 > _jobs.length) return false;
    // otherwise a Job should be available
    return true;
  }

  /// Select one [Job] randomly, with preference to the beginning of the list.
  Job select() {
    // prioritize latest stables vs everything else
    final latestStables = _jobs.where((j) => j.isLatestStable).toList();
    final candidates = latestStables.isNotEmpty ? latestStables : _jobs;

    final r1 = _random.nextInt(candidates.length);
    final r2 = _random.nextInt(candidates.length);
    return _jobs.removeAt(math.min(r1, r2));
  }

  void markRace() {
    _race++;
  }
}

class _Stat {
  final _stateMap = <String, int>{};
  final _statusMap = <String, int>{};
  final bool _collectFailed;
  final _failedPackages = <String>{};
  int _totalCount = 0;
  int _availableCount = 0;

  _Stat({bool collectFailed = false}) : _collectFailed = collectFailed;

  int get totalCount => _totalCount;
  int get availableCount => _availableCount;

  void add(Job job) {
    _totalCount++;
    if (job.state == JobState.available) {
      _availableCount++;
    }
    final stateKey = jobStateAsString(job.state!);
    final statusKey = jobStatusAsString(job.lastStatus!);
    _stateMap[stateKey] = (_stateMap[stateKey] ?? 0) + 1;
    _statusMap[statusKey] = (_statusMap[statusKey] ?? 0) + 1;

    final bool isError = job.lastStatus == JobStatus.failed ||
        job.lastStatus == JobStatus.aborted;
    if (_collectFailed && isError) {
      _failedPackages.add(job.packageName!);
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'total': _totalCount,
      'state': _stateMap,
      'status': _statusMap,
    };
    if (_collectFailed) {
      map['failed'] = _failedPackages.toList()..sort();
    }
    return map;
  }
}

class _AllStats {
  final DateTime timestamp = clock.now().toUtc();
  final _Stat all = _Stat();
  final _Stat latest = _Stat();
  final _Stat last90 = _Stat(collectFailed: true);
  String? _estimate;

  void add(Job job) {
    all.add(job);
    if (job.isLatestStable) {
      latest.add(job);
    }
    final age = timestamp.difference(job.packageVersionUpdated!).abs();
    if (age.inDays <= 90) {
      last90.add(job);
    }
  }

  void updateEstimates(_AllStats? prev) {
    if (prev == null) {
      _estimate = 'no estimate yet';
      return;
    }
    final doneCount = prev.all.availableCount - all.availableCount;
    if (doneCount < 0) {
      _estimate = '# of jobs to do increasing, not able to estimate';
      return;
    }
    if (doneCount == 0) {
      _estimate = 'no change in # of jobs to do, nothing to estimate';
      return;
    }
    final diff = timestamp.difference(prev.timestamp).abs();
    final Duration timePerJob = diff ~/ doneCount;
    final allRemaining = formatDuration(timePerJob * all.availableCount);
    final jobsPerMinute = (doneCount * 60 / diff.inSeconds).toStringAsFixed(2);
    _estimate =
        '$jobsPerMinute jobs/minutes (estimated to complete in $allRemaining)';
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'estimate': _estimate,
      'all': all.toMap(),
      'latest': latest.toMap(),
      'last90': last90.toMap(),
    };
  }
}
