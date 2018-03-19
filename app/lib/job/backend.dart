// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:uuid/uuid.dart';

import '../shared/utils.dart';
import '../shared/versions.dart' as versions;

import 'model.dart';

export 'model.dart';

const _defaultLockDuration = const Duration(hours: 1);
const _extendDuration = const Duration(hours: 12);

final _logger = new Logger('pub.job.backend');
final _random = new math.Random.secure();
final _uuid = new Uuid();

typedef Future<bool> ShouldProcess(
    String package, String version, DateTime updated);

/// Sets the active job backend.
void registerJobBackend(JobBackend backend) =>
    ss.register(#_job_backend, backend);

/// The active job backend.
JobBackend get jobBackend => ss.lookup(#_job_backend);

class JobBackend {
  final db.DatastoreDB _db;
  JobBackend(this._db);

  String _id(JobService service, String package, String version) => new Uri(
        pathSegments: [
          service.toString().split('.').last,
          package,
          version,
        ],
      ).toString();

  Future createOrUpdate(JobService service, String package, String version,
      bool isLatestStable, DateTime updated, bool shouldProcess) async {
    final id = _id(service, package, version);
    final state = shouldProcess ? JobState.available : JobState.idle;
    final lockedUntil =
        shouldProcess ? null : new DateTime.now().add(_extendDuration);
    await _db.withTransaction((tx) async {
      final list = await tx.lookup([_db.emptyKey.append(Job, id: id)]);
      final current = list.single as Job;
      if (current != null) {
        if (current.isLatestStable == isLatestStable &&
            current.packageVersionUpdated == updated &&
            current.runtimeVersion == versions.runtimeVersion) {
          return;
        }
        if (isNewer(
            versions.semanticRuntimeVersion, current.semanticRuntimeVersion)) {
          return;
        }
        _logger.info('Updating job: $id');
        current
          ..isLatestStable = isLatestStable
          ..packageVersionUpdated = updated
          ..runtimeVersion = versions.runtimeVersion
          ..state = state
          ..lockedUntil = lockedUntil
          ..processingKey = null // drops ongoing processing
          ..updatePriority();
        tx.queueMutations(inserts: [current]);
        await tx.commit();
        return;
      } else {
        _logger.info('Creating job: $id');
        final job = new Job()
          ..id = id
          ..service = service
          ..packageName = package
          ..packageVersion = version
          ..isLatestStable = isLatestStable
          ..packageVersionUpdated = updated
          ..state = state
          ..lockedUntil = lockedUntil
          ..lastStatus = JobStatus.none
          ..runtimeVersion = versions.runtimeVersion
          ..errorCount = 0
          ..updatePriority();
        tx.queueMutations(inserts: [job]);
        await tx.commit();
        return;
      }
    });
  }

  Future<Job> lockAvailable(JobService service, {Duration lockDuration}) async {
    final query = _db.query(Job)
      ..filter('service =', service)
      ..filter('state =', JobState.available)
      ..order('priority')
      ..limit(100);
    final List<Job> list = await query.run().toList();

    bool isApplicable(Job job) {
      if (job == null) return false;
      if (job.state != JobState.available) return false;
      if (job.runtimeVersion != versions.runtimeVersion) return false;
      return true;
    }

    list.removeWhere((job) => !isApplicable(job));
    if (list.isEmpty) return null;

    final selectedId = list[_random.nextInt(list.length)].id;
    return _db.withTransaction((tx) async {
      final items = await tx.lookup([_db.emptyKey.append(Job, id: selectedId)]);
      final Job selected = items.single;
      if (!isApplicable(selected)) return null;
      final now = new DateTime.now().toUtc();
      selected
        ..state = JobState.processing
        ..processingKey = _uuid.v4()
        ..lockedUntil = now.add(lockDuration ?? _defaultLockDuration);
      tx.queueMutations(inserts: [selected]);
      await tx.commit();
      return selected;
    });
  }

  Future unlockStaleProcessing(JobService service) async {
    Future _unlock(Job job) {
      return _db.withTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final Job current = list.single;
        if (current.state == JobState.processing &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..state = JobState.idle
            ..processingKey = null
            ..errorCount = current.errorCount + 1
            ..lastStatus = JobStatus.aborted
            ..lockedUntil = null
            ..updatePriority();
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        }
      });
    }

    final query = _db.query(Job)
      ..filter('service =', service)
      ..filter('state =', JobState.processing)
      ..filter('lockedUntil <', new DateTime.now().toUtc());
    await for (Job job in query.run()) {
      try {
        await _unlock(job);
      } catch (e, st) {
        _logger.warning('Unlock of $job failed.', e, st);
      }
    }
  }

  Future checkIdle(JobService service, ShouldProcess shouldProcess) async {
    Future _schedule(Job job) async {
      return _db.withTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final Job current = list.single;
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

    Future _extend(Job job) async {
      return _db.withTransaction((tx) async {
        final list = await tx.lookup([job.key]);
        final Job current = list.single;
        if (current.state == JobState.idle &&
            current.lockedUntil == job.lockedUntil) {
          current
            ..processingKey = null
            ..lockedUntil = new DateTime.now().toUtc().add(_extendDuration);
          tx.queueMutations(inserts: [current]);
          await tx.commit();
        }
      });
    }

    final query = _db.query(Job)
      ..filter('service =', service)
      ..filter('state =', JobState.idle)
      ..filter('lockedUntil <', new DateTime.now().toUtc());
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
        _logger.warning('Idle check of $job failed.', e, st);
      }
    }
  }

  Future complete(Job job, JobStatus status, {Duration extendDuration}) async {
    return _db.withTransaction((tx) async {
      final items = await tx.lookup([_db.emptyKey.append(Job, id: job.id)]);
      final Job selected = items.single;
      if (selected != null && selected.processingKey == job.processingKey) {
        _logger.info('Updating $job with $status');
        final errorCount =
            status == JobStatus.success ? 0 : selected.errorCount + 1;
        selected
          ..state = JobState.idle
          ..lastStatus = status
          ..processingKey = null
          ..errorCount = errorCount
          ..lockedUntil =
              new DateTime.now().toUtc().add(extendDuration ?? _extendDuration)
          ..updatePriority();
        tx.queueMutations(inserts: [selected]);
        await tx.commit();
      } else {
        _logger
            .info('Job $job completion aborted. isNull: ${selected == null}');
      }
    });
  }

  Future<Map> stats(JobService service) async {
    final allState = <String, int>{};
    final allStatus = <String, int>{};
    final latestState = <String, int>{};
    final latestStatus = <String, int>{};

    final query = _db.query(Job)..filter('service =', service);
    await for (Job job in query.run()) {
      final stateKey = jobStateAsString(job.state);
      final statusKey = jobStatusAsString(job.lastStatus);
      allState[stateKey] = (allState[stateKey] ?? 0) + 1;
      allStatus[statusKey] = (allStatus[statusKey] ?? 0) + 1;
      if (job.isLatestStable) {
        latestState[stateKey] = (latestState[stateKey] ?? 0) + 1;
        latestStatus[statusKey] = (latestStatus[statusKey] ?? 0) + 1;
      }
    }

    return {
      'all': {
        'state': allState,
        'status': allStatus,
      },
      'latest': {
        'state': latestState,
        'status': latestStatus,
      },
    };
  }
}
