// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:gcloud/db.dart';

import '../frontend/models.dart';
import '../shared/task_scheduler.dart';

import 'models.dart';

/// Creates a task when a version uploaded in the past hour has no analysis yet.
class DatastoreHeadTaskSource extends PollingTaskSource {
  final DatastoreDB _db;
  DateTime _lastTs;
  DatastoreHeadTaskSource(this._db) : super(const Duration(minutes: 10));

  @override
  Stream<Task> pollTasks() {
    final DateTime now = new DateTime.now().toUtc();
    final DateTime oneHourAgo = now.subtract(new Duration(hours: 1));
    DateTime minCreated;
    if (_lastTs == null) {
      minCreated = oneHourAgo;
    } else if (_lastTs.isBefore(oneHourAgo)) {
      // more than an hour passed since the last poll
      minCreated = _lastTs;
    } else {
      minCreated = oneHourAgo;
    }
    _lastTs = oneHourAgo;
    final Query q = _db.query(PackageVersion)..filter('created >=', minCreated);
    return q.run().asyncMap(_mapPackageVersion).where((v) => v != null);
  }

  Future<Task> _mapPackageVersion(Model m) async {
    final PackageVersion pv = m;
    final List<PackageVersionAnalysis> items = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: pv.package)
          .append(PackageVersionAnalysis, id: pv.version)
    ]);
    if (items.first == null) {
      return null;
    } else {
      return new Task(pv.package, pv.version);
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
  final int _batchSize = 10;
  int _offset = 0;

  DatastoreHistoryTaskSource(this._db,
      {this.afterDays: 30, this.analysisVersion})
      : super(const Duration(minutes: 10));

  @override
  Stream<Task> pollTasks() {
    final StreamCompleter<Task> resultCompleter = new StreamCompleter();
    final Query q = _db.query(PackageVersion)
      ..order('-created')
      ..offset(_offset)
      ..limit(_batchSize);
    _offset += _batchSize;

    q.run().asyncMap(_mapPackage).toList().then(
      (List<Task> list) {
        if (list.isEmpty) {
          // Query results were empty, we have no further versions,
          // restart history scanning.
          _offset = 0;
          resultCompleter.setEmpty();
        } else {
          resultCompleter.setSourceStream(
              new Stream.fromIterable(list.where((t) => t != null)));
        }
      },
      onError: (e, st) {
        resultCompleter.setError(e, st);
      },
    );

    return resultCompleter.stream;
  }

  Future<Task> _mapPackage(Model m) async {
    final PackageVersion pv = m;
    final List<PackageVersionAnalysis> list = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: pv.package)
          .append(PackageVersionAnalysis, id: pv.version)
    ]);
    if (list.first == null) {
      return new Task(pv.package, pv.version);
    }

    final PackageVersionAnalysis version = list.first;
    final Duration diff =
        new DateTime.now().toUtc().difference(version.analysisTimestamp);
    final bool versionDiffers =
        analysisVersion != null && version.analysisVersion != analysisVersion;

    if (versionDiffers || diff.inDays >= afterDays) {
      return new Task(version.packageName, version.packageVersion);
    } else {
      return null;
    }
  }
}
