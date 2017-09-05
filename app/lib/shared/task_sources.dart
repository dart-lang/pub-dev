// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart';

import 'task_scheduler.dart';

final Logger _logger = new Logger('pub.shared.task_sources');

const Duration _defaultWindow = const Duration(minutes: 5);
const Duration _defaultSleep = const Duration(minutes: 1);

/// Creates tasks by polling the datastore for new versions.
class DatastoreVersionsHeadTaskSource implements TaskSource {
  final DatastoreDB _db;
  final Duration _window;
  final Duration _sleep;
  final bool _onlyLatest;
  DateTime _lastTs;

  DatastoreVersionsHeadTaskSource(
    this._db, {

    /// Whether to return only the latest versions of the packages.
    bool onlyLatest: false,

    /// Whether to scan the entire datastore in the first run or skip old ones.
    bool skipHistory: false,

    /// Tolerance window for eventually consistency in Datastore.
    Duration window,

    /// Inactivity duration between two polls.
    Duration sleep,
  })
      : _window = window ?? _defaultWindow,
        _sleep = sleep ?? _defaultSleep,
        _onlyLatest = onlyLatest,
        _lastTs = skipHistory
            ? new DateTime.now().toUtc().subtract(window ?? _defaultWindow)
            : null;

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      try {
        final DateTime now = new DateTime.now().toUtc();
        if (_onlyLatest) {
          yield* _pollPackages();
        } else {
          yield* _pollPackageVersions();
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

  Stream<Task> _pollPackages() async* {
    final Query q = _db.query(Package);
    if (_lastTs != null) {
      q.filter('updated >=', _lastTs);
    }
    int count = 0;
    await for (Package p in q.run()) {
      final task = new Task(p.name, p.latestVersion ?? p.latestDevVersion);
      if (await shouldYieldTask(task)) {
        count++;
        yield task;
      }
    }
    await dbScanComplete(count);
  }

  Stream<Task> _pollPackageVersions() async* {
    final Query q = _db.query(PackageVersion);
    if (_lastTs != null) {
      q.filter('created >=', _lastTs);
    }
    int count = 0;
    await for (PackageVersion pv in q.run()) {
      final task = new Task(pv.package, pv.version);
      if (await shouldYieldTask(task)) {
        count++;
        yield task;
      }
    }
    await dbScanComplete(count);
  }
}
