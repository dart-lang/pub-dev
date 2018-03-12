// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:uuid/uuid.dart';

import 'utils.dart';
import 'versions.dart' as versions;

const _defaultLockDuration = const Duration(minutes: 10);

final _logger = new Logger('pub.job');
final _random = new math.Random.secure();
final _uuid = new Uuid();

@db.Kind(name: 'Job', idType: db.IdType.String)
class Job extends db.ExpandoModel {
  @db.StringProperty()
  String service; // analyzer or dartdoc

  @db.StringProperty()
  String packageName;

  @db.StringProperty()
  String packageVersion;

  @db.StringProperty()
  String runtimeVersion;

  @db.IntProperty()
  int priority;

  @db.StringProperty()
  String lockedKey;

  @db.DateTimeProperty()
  DateTime lockedUntil;

  Version get semanticRuntimeVersion => new Version.parse(runtimeVersion);
}

/// Sets the active job backend.
void registerJobBackend(JobBackend backend) =>
    ss.register(#_job_backend, backend);

/// The active job backend.
JobBackend get jobBackend => ss.lookup(#_job_backend);

class JobBackend {
  final db.DatastoreDB _db;
  JobBackend(this._db);

  String _id(String service, String package, String version) =>
      new Uri(pathSegments: [service, package, version]).toString();

  Future create(
      String service, String package, String version, int priority) async {
    final id = _id(service, package, version);
    await _db.withTransaction((tx) async {
      final list = await tx.lookup([_db.emptyKey.append(Job, id: id)]);
      final current = list.single as Job;
      if (current != null) {
        if (current.runtimeVersion == versions.runtimeVersion) {
          // same runtime version, keeping current job
          return;
        } else if (isNewer(
            versions.semanticRuntimeVersion, current.semanticRuntimeVersion)) {
          // current job has newer runtime version
          return;
        } else {
          // updating job entry with new runtime version
          current.runtimeVersion = versions.runtimeVersion;
          current.lockedKey = null;
          current.lockedUntil = null;
          current.priority = math.min(current.priority, priority);
          tx.queueMutations(inserts: [current]);
          await tx.commit();
          return;
        }
      } else {
        final job = new Job()
          ..id = id
          ..service = service
          ..packageName = package
          ..packageVersion = version
          ..runtimeVersion = versions.runtimeVersion
          ..priority = priority;
        tx.queueMutations(inserts: [job]);
        await tx.commit();
        return;
      }
    });
  }

  Future<Job> pull(String service, {Duration lockDuration}) async {
    final now = new DateTime.now().toUtc();
    final lockThreshold = now.subtract(lockDuration ?? _defaultLockDuration);

    final query = _db.query(Job)
      ..filter('service =', service)
      ..order('priority')
      ..limit(100);
    final List<Job> list = await query.run().toList();

    bool isApplicable(Job job) {
      if (job == null) return false;
      if (job.lockedUntil != null && job.lockedUntil.isAfter(lockThreshold)) {
        return false;
      }
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
      selected.lockedUntil = now.add(lockDuration ?? _defaultLockDuration);
      selected.lockedKey = _uuid.v4();
      tx.queueMutations(inserts: [selected]);
      await tx.commit();
      return selected;
    });
  }

  Future complete(Job job) async {
    return _db.withTransaction((tx) async {
      final items = await tx.lookup([_db.emptyKey.append(Job, id: job.id)]);
      final Job selected = items.single;
      if (selected != null && selected.lockedKey == job.lockedKey) {
        tx.queueMutations(deletes: [selected.key]);
        await tx.commit();
      }
    });
  }
}

abstract class JobProcessor {
  String get service;

  Future process(Job job);

  Future run() async {
    int sleepSeconds = 0;
    for (;;) {
      sleepSeconds = math.min(sleepSeconds + 1, 60);
      String jobDescription = '[pull]';
      try {
        final job = await jobBackend.pull(service);
        if (job != null) {
          jobDescription = '${job.packageName} ${job.packageVersion}';
          _logger.info('$service job started: $jobDescription');
          sleepSeconds = 0;

          await process(job);
          await jobBackend.complete(job);

          _logger.info('$service job completed: $jobDescription');
        }
      } catch (e, st) {
        _logger.severe('$service job error $jobDescription', e, st);
      }
      await new Future.delayed(new Duration(seconds: sleepSeconds));
    }
  }
}
