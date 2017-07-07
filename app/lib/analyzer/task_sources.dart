// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart';
import '../shared/task_scheduler.dart';

import 'models.dart';

final Logger _logger = new Logger('pub.analyzer.source');

/// Creates a task when a version uploaded in the past 10 minutes has no
/// analysis yet.
class DatastoreHeadTaskSource implements TaskSource {
  final DatastoreDB _db;
  DateTime _lastTs;
  DatastoreHeadTaskSource(this._db);

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      try {
        final DateTime now = new DateTime.now().toUtc();
        final DateTime tenMinutesAgo =
            now.subtract(const Duration(minutes: 10));
        _lastTs ??= tenMinutesAgo;
        final DateTime minCreated =
            _lastTs.isBefore(tenMinutesAgo) ? _lastTs : tenMinutesAgo;

        final Query q = _db.query(PackageVersion)
          ..filter('created >=', minCreated)
          ..order('created');
        await for (PackageVersion pv in q.run()) {
          if (_lastTs == null || _lastTs.isBefore(pv.created)) {
            _lastTs = pv.created;
          }
          final List<PackageVersionAnalysis> items = await _db.lookup([
            _db.emptyKey
                .append(PackageAnalysis, id: pv.package)
                .append(PackageVersionAnalysis, id: pv.version)
          ]);
          if (items.first == null) {
            yield new Task(pv.package, pv.version);
          }
        }
      } catch (e, st) {
        _logger.severe('Error polling head.', e, st);
      }
      await new Future.delayed(const Duration(minutes: 1));
    }
  }
}

/// Creates a task when the most recent analysis is older than [afterDays] days.
///
/// When [analysisVersion] is set, it also checks whether the current one is
/// newer and creates a task if needed.
class DatastoreHistoryTaskSource implements TaskSource {
  final DatastoreDB _db;
  final int afterDays;
  final String analysisVersion;
  final Duration period;

  DatastoreHistoryTaskSource(
    this._db, {
    this.afterDays: 30,
    this.analysisVersion,
    this.period: const Duration(seconds: 30),
  });

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      try {
        final Query query = _db.query(PackageVersion)..order('-created');
        await for (PackageVersion pv in query.run()) {
          final List<PackageVersionAnalysis> list = await _db.lookup([
            _db.emptyKey
                .append(PackageAnalysis, id: pv.package)
                .append(PackageVersionAnalysis, id: pv.version)
          ]);
          if (list.first == null) {
            // Waiting to throttle the historical tasks. If there is a newly
            // uploaded package, give it a chance before continuing with these.
            await new Future.delayed(const Duration(seconds: 30));
            yield new Task(pv.package, pv.version);
            continue;
          }

          final PackageVersionAnalysis version = list.first;
          final Duration diff =
              new DateTime.now().toUtc().difference(version.analysisTimestamp);
          final bool versionDiffers = analysisVersion != null &&
              version.analysisVersion != analysisVersion;

          if (versionDiffers || diff.inDays >= afterDays) {
            // Waiting to throttle the historical tasks. If there is a newly
            // uploaded package, give it a chance before continuing with these.
            await new Future.delayed(const Duration(seconds: 30));
            yield new Task(version.packageName, version.packageVersion);
          }
        }
      } catch (e, st) {
        _logger.severe('Error polling history.', e, st);
      }
      await new Future.delayed(const Duration(days: 1));
    }
  }
}
