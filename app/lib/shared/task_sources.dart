// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../analyzer/models.dart';
import '../frontend/models.dart';

import 'task_scheduler.dart';

final Logger _logger = new Logger('pub.shared.task_sources');

const Duration _defaultWindow = const Duration(minutes: 5);
const Duration _defaultSleep = const Duration(minutes: 1);

enum TaskSourceModel { package, version, analysis }

/// Creates tasks by polling the datastore for new versions.
class DatastoreVersionsHeadTaskSource implements TaskSource {
  final DatastoreDB _db;
  final Duration _window;
  final Duration _sleep;
  final TaskSourceModel _model;
  DateTime _lastTs;

  DatastoreVersionsHeadTaskSource(
    this._db,
    this._model, {

    /// Whether to scan the entire datastore in the first run or skip old ones.
    bool skipHistory: false,

    /// Tolerance window for eventually consistency in Datastore.
    Duration window,

    /// Inactivity duration between two polls.
    Duration sleep,
  })
      : _window = window ?? _defaultWindow,
        _sleep = sleep ?? _defaultSleep,
        _lastTs = skipHistory
            ? new DateTime.now().toUtc().subtract(window ?? _defaultWindow)
            : null;

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      try {
        final DateTime now = new DateTime.now().toUtc();
        switch (_model) {
          case TaskSourceModel.package:
            yield* _poll(Package, 'updated', _packageToTask);
            break;
          case TaskSourceModel.version:
            yield* _poll(PackageVersion, 'created', _versionToTask);
            break;
          case TaskSourceModel.analysis:
            yield* _poll(Analysis, 'timestamp', _analysisToTask);
            break;
        }
        _lastTs = now.subtract(_window);
      } catch (e, st) {
        _logger.severe('Error polling head.', e, st);
      }
      await new Future.delayed(_sleep);
    }
  }

  Future<bool> shouldYieldTask(Task task) async => true;

  Future dbScanComplete(int count) async {}

  Stream<Task> _poll<M extends Model>(
      Type type, String field, Task modelToTask(M model)) async* {
    final Query q = _db.query(type);
    if (_lastTs != null) {
      q.filter('$field >=', _lastTs);
    }
    int count = 0;
    await for (M model in q.run()) {
      final Task task = modelToTask(model);
      if (await shouldYieldTask(task)) {
        count++;
        yield task;
      }
    }
    await dbScanComplete(count);
  }

  Task _packageToTask(Package p) =>
      new Task(p.name, p.latestVersion ?? p.latestDevVersion, p.updated);

  Task _versionToTask(PackageVersion pv) =>
      new Task(pv.package, pv.version, pv.created);

  Task _analysisToTask(Analysis a) =>
      new Task(a.packageName, a.packageVersion, a.timestamp);
}
