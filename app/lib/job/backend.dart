// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:gcloud/datastore.dart' show DatastoreError;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/popularity_storage.dart';

import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'model.dart';

export 'model.dart';

const _defaultLockDuration = Duration(hours: 1);
const _extendDuration = Duration(hours: 12);

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
  JobBackend(this._db);

  String _id(JobService service, String package, String version) => Uri(
        pathSegments: [
          versions.runtimeVersion,
          service.toString().split('.').last,
          package,
          version,
        ],
      ).toString();

  /// Triggers analysis/dartdoc for [package]/[version] if older than [updated].
  Future<void> trigger(
    JobService service,
    String package, {
    String version,
    DateTime updated,
    bool isHighPriority = false,
  }) async {
    final pKey = _db.emptyKey.append(Package, id: package);
    final pList = await _db.lookup([pKey]);
    final p = pList[0] as Package;
    if (p == null) {
      _logger.info("Couldn't trigger $service job: $package not found.");
      return;
    }

    version ??= p.latestVersion;
    final pvKey = pKey.append(PackageVersion, id: version);
    final list = await _db.lookup([pvKey]);
    final pv = list[0] as PackageVersion;
    if (pv == null) {
      _logger
          .info("Couldn't trigger $service job: $package $version not found.");
      return;
    }

    final isLatestStable = p.latestVersion == version;
    final shouldProcess =
        isHighPriority || updated == null || updated.isAfter(pv.created);
    await createOrUpdate(
      service,
      package,
      version,
      isLatestStable,
      pv.created,
      shouldProcess,
      priority: isHighPriority ? 0 : null,
    );
  }

  Future<void> createOrUpdate(
    JobService service,
    String package,
    String version,
    bool isLatestStable,
    DateTime packageVersionUpdated,
    bool shouldProcess, {
    int priority,
  }) async {
    final id = _id(service, package, version);
    final state = shouldProcess ? JobState.available : JobState.idle;
    final lockedUntil =
        shouldProcess ? null : DateTime.now().add(_extendDuration);
    await _retryWithTransaction((tx) async {
      final list = await tx.lookup([_db.emptyKey.append(Job, id: id)]);
      final current = list.single as Job;
      if (current != null) {
        final hasNotChanged = current.isLatestStable == isLatestStable &&
            current.packageVersionUpdated == packageVersionUpdated &&
            priority == null;
        if (hasNotChanged) {
          if (!shouldProcess) {
            // no reason to re-schedule the job
            return;
          }
          if (current.state == JobState.available &&
              current.lockedUntil == null &&
              (priority == null || current.priority == priority)) {
            // already scheduled for processing
            return;
          }
        }
        _logger.info('Updating job: $id ($state, $lockedUntil)');
        current
          ..isLatestStable = isLatestStable
          ..packageVersionUpdated = packageVersionUpdated
          ..state = state
          ..lockedUntil = lockedUntil
          ..processingKey = null // drops ongoing processing
          ..updatePriority(
            popularityStorage.lookup(package),
            fixPriority: priority,
          );
        tx.queueMutations(inserts: [current]);
        await tx.commit();
        return;
      } else {
        _logger.info('Creating job: $id');
        final job = Job()
          ..id = id
          ..service = service
          ..packageName = package
          ..packageVersion = version
          ..isLatestStable = isLatestStable
          ..packageVersionUpdated = packageVersionUpdated
          ..state = state
          ..lockedUntil = lockedUntil
          ..lastStatus = JobStatus.none
          ..runtimeVersion = versions.runtimeVersion
          ..errorCount = 0
          ..updatePriority(
            popularityStorage.lookup(package),
            fixPriority: priority,
          );
        tx.queueMutations(inserts: [job]);
        await tx.commit();
        return;
      }
    });
  }

  Future<Job> lockAvailable(JobService service, {Duration lockDuration}) async {
    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service)
      ..filter('state =', JobState.available)
      ..order('priority')
      ..limit(100);
    final list = await query.run().toList();

    bool isApplicable(Job job) {
      if (job == null) return false;
      if (job.state != JobState.available) return false;
      if (job.runtimeVersion != versions.runtimeVersion) return false;
      return true;
    }

    list.removeWhere((job) => !isApplicable(job));
    if (list.isEmpty) return null;

    // if there are high-priority items, select only from those.
    if (list.first.priority == 0) {
      list.removeWhere((j) => j.priority > 0);
    }

    return await _retryWithTransaction((tx) async {
      final selectedId = list[_random.nextInt(list.length)].id;
      final items = await tx.lookup([_db.emptyKey.append(Job, id: selectedId)]);
      final selected = items.single as Job;
      if (!isApplicable(selected)) return null;
      final now = DateTime.now().toUtc();
      selected
        ..state = JobState.processing
        ..processingKey = createUuid()
        ..lockedUntil = now.add(lockDuration ?? _defaultLockDuration);
      tx.queueMutations(inserts: [selected]);
      await tx.commit();
      return selected;
    });
  }

  Future<void> unlockStaleProcessing(JobService service) async {
    Future<void> _unlock(Job job) async {
      await _retryWithTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final current = list.single as Job;
        if (current.state == JobState.processing &&
            current.lockedUntil == job.lockedUntil) {
          final errorCount = current.errorCount + 1;
          current
            ..state = JobState.idle
            ..processingKey = null
            ..errorCount = errorCount
            ..lastStatus = JobStatus.aborted
            ..lockedUntil = _extendLock(errorCount)
            ..updatePriority(popularityStorage.lookup(job.packageName));
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        }
      });
    }

    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service)
      ..filter('state =', JobState.processing)
      ..filter('lockedUntil <', DateTime.now().toUtc());
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
      await _retryWithTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final current = list.single as Job;
        if (current.state == JobState.idle &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..state = JobState.available
            ..processingKey = null
            ..lockedUntil = null;
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        }
      });
    }

    Future<void> _extend(Job job) async {
      await _retryWithTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final current = list.single as Job;
        if (current.state == JobState.idle &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..processingKey = null
            ..lockedUntil = DateTime.now().toUtc().add(_extendDuration);
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        }
      });
    }

    final query = _db.query<Job>()
      ..filter('runtimeVersion =', versions.runtimeVersion)
      ..filter('service =', service)
      ..filter('state =', JobState.idle)
      ..filter('lockedUntil <', DateTime.now().toUtc());
    await for (Job job in query.run()) {
      if (job.runtimeVersion != versions.runtimeVersion) continue;
      try {
        final process = await shouldProcess(
            job.packageName, job.packageVersion, job.packageVersionUpdated);
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

  Future<void> complete(Job job, JobStatus status,
      {Duration extendDuration}) async {
    await _retryWithTransaction((tx) async {
      final items = await tx.lookup([_db.emptyKey.append(Job, id: job.id)]);
      final selected = items.single as Job;
      if (selected != null && selected.processingKey == job.processingKey) {
        _logger.info('Updating $job with $status');
        final isError =
            (status == JobStatus.failed) || (status == JobStatus.aborted);
        final errorCount = isError ? selected.errorCount + 1 : 0;
        selected
          ..state = JobState.idle
          ..lastStatus = status
          ..processingKey = null
          ..errorCount = errorCount
          ..lockedUntil = _extendLock(errorCount, duration: extendDuration)
          ..updatePriority(popularityStorage.lookup(selected.packageName));
        tx.queueMutations(inserts: [selected]);
        await tx.commit();
      } else {
        _logger
            .info('Job $job completion aborted. isNull: ${selected == null}');
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

  DateTime _extendLock(int errorCount, {Duration duration}) {
    return DateTime.now()
        .toUtc()
        .add(duration ?? _extendDuration)
        .add(Duration(hours: math.min(errorCount, 168 /* one week */)));
  }

  Future<R> _retryWithTransaction<R>(
      Future<R> Function(db.Transaction tx) fn) async {
    return await retry(
      () async {
        final r = await _db.withTransaction<R>(fn);
        return r;
      },
      maxDelay: const Duration(seconds: 2),
      retryIf: (ex) => ex is DatastoreError,
    );
  }

  /// Deletes the old entries that predate [versions.gcBeforeRuntimeVersion].
  Future<void> deleteOldEntries() async {
    final query = _db.query<Job>()
      ..filter('runtimeVersion <', versions.gcBeforeRuntimeVersion);
    final deleteKeys = <db.Key>[];
    await for (Job job in query.run()) {
      deleteKeys.add(job.key);
      if (deleteKeys.length >= 20) {
        _logger.info('Deleting ${deleteKeys.length} old Job entries.');
        await _db.commit(deletes: deleteKeys);
        deleteKeys.clear();
      }
    }
    if (deleteKeys.isNotEmpty) {
      _logger.info('Deleting ${deleteKeys.length} old Job entries.');
      await _db.commit(deletes: deleteKeys);
    }
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
    final stateKey = jobStateAsString(job.state);
    final statusKey = jobStatusAsString(job.lastStatus);
    _stateMap[stateKey] = (_stateMap[stateKey] ?? 0) + 1;
    _statusMap[statusKey] = (_statusMap[statusKey] ?? 0) + 1;

    final bool isError = job.lastStatus == JobStatus.failed ||
        job.lastStatus == JobStatus.aborted;
    if (_collectFailed && isError) {
      _failedPackages.add(job.packageName);
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
  final DateTime timestamp = DateTime.now().toUtc();
  final _Stat all = _Stat();
  final _Stat latest = _Stat();
  final _Stat last90 = _Stat(collectFailed: true);
  String _estimate;

  void add(Job job) {
    all.add(job);
    if (job.isLatestStable) {
      latest.add(job);
    }
    final age = timestamp.difference(job.packageVersionUpdated).abs();
    if (age.inDays <= 90) {
      last90.add(job);
    }
  }

  void updateEstimates(_AllStats prev) {
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
