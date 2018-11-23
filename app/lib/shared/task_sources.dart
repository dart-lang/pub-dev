// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart';
import '../scorecard/models.dart';

import 'task_scheduler.dart';
import 'utils.dart';
import 'versions.dart';

final Logger _logger = new Logger('pub.shared.task_sources');

const Duration _defaultWindow = const Duration(minutes: 5);
const Duration _defaultSleep = const Duration(minutes: 1);

enum TaskSourceModel { package, version, scorecard }

/// Creates tasks by polling the datastore for new versions.
class DatastoreHeadTaskSource implements TaskSource {
  final DatastoreDB _db;
  final Duration _window;
  final Duration _sleep;
  final TaskSourceModel _model;
  DateTime _lastTs;

  DatastoreHeadTaskSource(
    this._db,
    this._model, {

    /// Whether to scan the entire datastore in the first run or skip old ones.
    bool skipHistory = false,

    /// Tolerance window for eventually consistency in Datastore.
    Duration window,

    /// Inactivity duration between two polls.
    Duration sleep,
  })  : _window = window ?? _defaultWindow,
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
            yield* _poll<Package>('updated', _packageToTask);
            break;
          case TaskSourceModel.version:
            yield* _poll<PackageVersion>('created', _versionToTask);
            break;
          case TaskSourceModel.scorecard:
            yield* _poll<ScoreCard>('timestamp', _scoreCardToTask);
            break;
        }
        _lastTs = now.subtract(_window);
      } catch (e, st) {
        _logger.severe('Error polling head.', e, st);
      }
      await new Future.delayed(_sleep);
    }
  }

  Future dbScanComplete(int count) async {}

  Stream<Task> _poll<M extends Model>(
      String field, Task modelToTask(M model)) async* {
    final Query q = _db.query<M>();
    if (_lastTs != null) {
      q.filter('$field >=', _lastTs);
    }
    int count = 0;
    Timer timer;
    await for (M model in q.run()) {
      timer?.cancel();
      timer = new Timer(const Duration(minutes: 5), () {
        _logger.warning(
            'More than 5 minutes elapsed between poll stream entries.');
      });
      final Task task = modelToTask(model);
      if (task != null) {
        count++;
        yield task;
      }
    }
    timer?.cancel();
    await dbScanComplete(count);
  }

  Task _packageToTask(Package p) =>
      new Task(p.name, p.latestVersion ?? p.latestDevVersion, p.updated);

  Task _versionToTask(PackageVersion pv) =>
      new Task(pv.package, pv.version, pv.created);

  Task _scoreCardToTask(ScoreCard s) {
    if (s.runtimeVersion == runtimeVersion) {
      return new Task(s.packageName, s.packageVersion, s.updated);
    } else {
      return null;
    }
  }
}

/// Creates a task when the most recent output requires an update (e.g. too old).
abstract class DatastoreHistoryTaskSource implements TaskSource {
  final DatastoreDB _db;

  DatastoreHistoryTaskSource(this._db);

  Future<bool> requiresUpdate(String packageName, String packageVersion,
      {bool retryFailed = false});

  @override
  Stream<Task> startStreaming() => randomizeStream(_startStreaming());

  Stream<Task> _startStreaming() async* {
    for (;;) {
      try {
        // Check and schedule the latest stable version of each package.
        final Query packageQuery = _db.query<Package>()..order('-updated');
        await for (Package p in packageQuery.run()) {
          if (await requiresUpdate(p.name, p.latestVersion,
              retryFailed: true)) {
            yield new Task(p.name, p.latestVersion, p.updated);
          }

          if (p.latestVersion != p.latestDevVersion &&
              await requiresUpdate(p.name, p.latestDevVersion)) {
            yield new Task(p.name, p.latestDevVersion, p.updated);
          }
        }

        // After we are done with the most important versions, let's check all
        // of the older versions too.
        final Query versionQuery = _db.query<PackageVersion>()
          ..order('-created');
        await for (PackageVersion pv in versionQuery.run()) {
          if (await requiresUpdate(pv.package, pv.version)) {
            yield new Task(pv.package, pv.version, pv.created);
          }
        }
      } catch (e, st) {
        _logger.severe('Error polling history.', e, st);
      }
      await new Future.delayed(const Duration(days: 1));
    }
  }
}
