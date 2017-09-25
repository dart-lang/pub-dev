// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart';
import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';
import '../shared/utils.dart';

import 'models.dart';
import 'versions.dart';

final Logger _logger = new Logger('pub.analyzer.source');

/// Creates a task when a version uploaded in the past 10 minutes has no
/// analysis yet.
class DatastoreHeadTaskSource extends DatastoreVersionsHeadTaskSource {
  final DatastoreDB _db;
  DatastoreHeadTaskSource(DatastoreDB db)
      : _db = db,
        super(db, skipHistory: true);

  @override
  Future<bool> shouldYieldTask(Task task) async {
    final List<PackageVersionAnalysis> items = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: task.package)
          .append(PackageVersionAnalysis, id: task.version)
    ]);
    return items.first == null;
  }
}

/// Creates a task when the most recent analysis is older than [afterDays] days.
///
/// When [analysisVersion] is set, it also checks whether the current one is
/// newer and creates a task if needed.
class DatastoreHistoryTaskSource implements TaskSource {
  final DatastoreDB _db;
  final int afterDays;

  DatastoreHistoryTaskSource(
    this._db, {
    this.afterDays: 30,
  });

  @override
  Stream<Task> startStreaming() => randomizeStream(_startStreaming());

  Stream<Task> _startStreaming() async* {
    for (;;) {
      try {
        // Check and schedule the latest stable version of each package.
        final Query packageQuery = _db.query(Package)..order('-updated');
        await for (Package p in packageQuery.run()) {
          if (await _requiresUpdate(p.name, p.latestVersion)) {
            yield new Task(p.name, p.latestVersion, p.updated);
          }

          if (p.latestVersion != p.latestDevVersion &&
              await _requiresUpdate(p.name, p.latestDevVersion)) {
            yield new Task(p.name, p.latestDevVersion, p.updated);
          }
        }

        // After we are done with the most important versions, let's check all
        // of the older versions too.
        final Query versionQuery = _db.query(PackageVersion)..order('-created');
        await for (PackageVersion pv in versionQuery.run()) {
          if (await _requiresUpdate(pv.package, pv.version)) {
            yield new Task(pv.package, pv.version, pv.created);
          }
        }
      } catch (e, st) {
        _logger.severe('Error polling history.', e, st);
      }
      await new Future.delayed(const Duration(days: 1));
    }
  }

  Future<bool> _requiresUpdate(
      String packageName, String packageVersion) async {
    final List<PackageVersionAnalysis> list = await _db.lookup([
      _db.emptyKey
          .append(PackageAnalysis, id: packageName)
          .append(PackageVersionAnalysis, id: packageVersion)
    ]);
    final PackageVersionAnalysis version = list.first;
    if (version == null) return true;

    if (version.panaVersion != panaVersion ||
        version.flutterVersion != flutterVersion) {
      return true;
    }

    final Duration diff =
        new DateTime.now().toUtc().difference(version.analysisTimestamp);
    if (diff.inDays >= afterDays) return true;

    return false;
  }
}
