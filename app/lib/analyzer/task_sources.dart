// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' show max;

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

  DatastoreHistoryTaskSource(this._db);

  @override
  Stream<Task> startStreaming() => randomizeStream(_startStreaming());

  Stream<Task> _startStreaming() async* {
    final Duration packageScanPeriod = new Duration(hours: 1);
    final Duration versionScanPeriod = new Duration(days: 1);
    DateTime lastPackageScan;
    DateTime lastVersionScan;
    for (;;) {
      bool scanned = false;
      try {
        final bool shouldScanPackages = lastPackageScan == null ||
            new DateTime.now().difference(lastPackageScan) > packageScanPeriod;
        if (shouldScanPackages) {
          // Check and schedule the latest stable version of each package.
          final Query packageQuery = _db.query(Package)..order('-updated');
          await for (Package p in packageQuery.run()) {
            if (await _requiresUpdate(
                p.name, p.latestVersion, true, p.updated)) {
              yield new Task(p.name, p.latestVersion);
            }

            if (p.latestVersion != p.latestDevVersion &&
                await _requiresUpdate(
                    p.name, p.latestDevVersion, false, p.updated)) {
              yield new Task(p.name, p.latestDevVersion);
            }
          }
          scanned = true;
          lastPackageScan = new DateTime.now();
        }

        final bool shouldScanVersions = lastVersionScan == null ||
            new DateTime.now().difference(lastVersionScan) > versionScanPeriod;
        if (shouldScanVersions) {
          // After we are done with the most important versions, let's check all
          // of the older versions too.
          final Query versionQuery = _db.query(PackageVersion)
            ..order('-created');
          await for (PackageVersion pv in versionQuery.run()) {
            if (await _requiresUpdate(
                pv.package, pv.version, false, pv.created)) {
              yield new Task(pv.package, pv.version);
            }
          }
          scanned = true;
          lastVersionScan = new DateTime.now();
        }
      } catch (e, st) {
        _logger.severe('Error polling history.', e, st);
      }
      if (!scanned) {
        await new Future.delayed(const Duration(minutes: 20));
      }
    }
  }

  Future<bool> _requiresUpdate(String packageName, String packageVersion,
      bool isLatestStable, DateTime created) async {
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

    final DateTime now = new DateTime.now().toUtc();
    final DateTime threshold = now;
    // Latest stable versions have a one-day re-analysis cycle, while the rest
    // is done less frequently, depending on how old the package is.
    if (isLatestStable) {
      // Polling period is 1 hour, threshold of 23 hours keeps it within a day.
      threshold.subtract(const Duration(hours: 23));
    } else {
      // The older the package, the less frequent we want to re-analyze it.
      // With the current settings, the following periods will be set:
      // - 3 months old: around once a week
      // - 1 year old: once a month
      // - 2 years old: every two months
      final int ageInHours = now.difference(created).inHours;
      final int hoursToSubstract = max(24, ageInHours * 30 ~/ 365);
      threshold.subtract(new Duration(hours: hoursToSubstract));
    }
    if (version.analysisTimestamp.isBefore(threshold)) {
      return true;
    }

    return false;
  }
}
