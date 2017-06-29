// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';

import '../frontend/models.dart';
import '../shared/task_scheduler.dart';

import 'models.dart';

/// Creates a task when a version uploaded in the past 10 minutes has no
/// analysis yet.
class DatastoreHeadTaskSource extends PollingTaskSource {
  final DatastoreDB _db;
  DateTime _lastTs;
  DatastoreHeadTaskSource(this._db) : super(const Duration(minutes: 1));

  @override
  Future poll() async {
    final DateTime now = new DateTime.now().toUtc();
    final DateTime tenMinutesAgo = now.subtract(const Duration(minutes: 10));
    DateTime minCreated;
    if (_lastTs == null) {
      minCreated = tenMinutesAgo;
    } else if (_lastTs.isBefore(tenMinutesAgo)) {
      // more than ten minutes passed since the last poll
      minCreated = _lastTs;
    } else {
      minCreated = tenMinutesAgo;
    }
    _lastTs = tenMinutesAgo;

    final Query q = _db.query(PackageVersion)..filter('created >=', minCreated);
    await for (PackageVersion pv in q.run()) {
      final List<PackageVersionAnalysis> items = await _db.lookup([
        _db.emptyKey
            .append(PackageAnalysis, id: pv.package)
            .append(PackageVersionAnalysis, id: pv.version)
      ]);
      if (items.first == null) {
        addTask(new Task(pv.package, pv.version));
      }
    }
  }
}

/// Creates a task when the most recent analysis is older than [afterDays] days.
///
/// When [analysisVersion] is set, it also checks whether the current one is
/// newer and creates a task if needed.
class DatastoreHistoryTaskSource extends PollingTaskSource {
  final DatastoreDB _db;
  final int afterDays;
  final String analysisVersion;
  final Duration period;

  DatastoreHistoryTaskSource(
    this._db, {
    this.afterDays: 30,
    this.analysisVersion,
    this.period: const Duration(seconds: 30),
  })
      : super(const Duration(days: 1));

  @override
  Future poll() async {
    final Query q = _db.query(PackageVersion);
    await for (PackageVersion pv in q.run().asyncMap(_delay)) {
      final List<PackageVersionAnalysis> list = await _db.lookup([
        _db.emptyKey
            .append(PackageAnalysis, id: pv.package)
            .append(PackageVersionAnalysis, id: pv.version)
      ]);
      if (list.first == null) {
        addTask(new Task(pv.package, pv.version));
        return;
      }

      final PackageVersionAnalysis version = list.first;
      final Duration diff =
          new DateTime.now().toUtc().difference(version.analysisTimestamp);
      final bool versionDiffers =
          analysisVersion != null && version.analysisVersion != analysisVersion;

      if (versionDiffers || diff.inDays >= afterDays) {
        addTask(new Task(version.packageName, version.packageVersion));
      }
    }
  }

  Future<PackageVersion> _delay(Model m) =>
      new Future.delayed(period, () => m as PackageVersion);
}
