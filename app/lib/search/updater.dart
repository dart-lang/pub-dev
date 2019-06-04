// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';

import 'backend.dart';
import 'index_simple.dart';

final Logger _logger = Logger('pub.search.updater');

class IndexUpdateTaskSource extends DatastoreHeadTaskSource {
  final BatchIndexUpdater _batchIndexUpdater;
  IndexUpdateTaskSource(DatastoreDB db, this._batchIndexUpdater)
      : super(db, TaskSourceModel.package, sleep: const Duration(minutes: 30));

  @override
  Future dbScanComplete(int count) async {
    _batchIndexUpdater.reportScanCount(count);
  }
}

class BatchIndexUpdater implements TaskRunner {
  int _taskCount = 0;
  SearchSnapshot _snapshot;
  DateTime _lastSnapshotWrite = DateTime.now();

  // Used by [IndexUpdateTaskSource] to indicating how many packages were
  // yielded in the first run of the index update.
  // When [BatchIndexUpdater] processes more than this number of tasks, it will
  // start do the index merges, making sure that the index is marked as ready.
  int _firstScanCount;

  /// Loads the package index snapshot, or if it fails, creates a minimal
  /// package index with only package names and minimal information.
  Future init() async {
    await _initSnapshot();

    if (!packageIndex.isReady) {
      _logger.info('Loading minimum package index...');
      int cnt = 0;
      await for (final pd in searchBackend.loadMinimumPackageIndex()) {
        await packageIndex.addPackage(pd);
        cnt++;
        if (cnt % 500 == 0) {
          _logger.info('Loaded $cnt minimum package data (${pd.package})');
        }
      }
      await packageIndex.merge();
      _logger.info('Minimum package index loaded with $cnt packages.');
    }
  }

  TaskSource get periodicUpdateTaskSource {
    assert(_snapshot != null);
    return _PeriodicUpdateTaskSource(_snapshot);
  }

  void reportScanCount(int count) {
    if (_firstScanCount != null) return;
    _firstScanCount = count;
  }

  Future _initSnapshot() async {
    if (_snapshot != null) return;
    try {
      _logger.info('Loading snapshot...');
      _snapshot = await snapshotStorage.fetch();
      if (_snapshot != null) {
        final int count = _snapshot.documents.length;
        _logger
            .info('Got $count packages from snapshot at ${_snapshot.updated}');
        await packageIndex.addPackages(_snapshot.documents.values);
        // Arbitrary sanity check that the snapshot is not entirely bogus.
        // Index merge will enable search.
        if (count > 10) {
          _logger.info('Merging index after snapshot.');
          await packageIndex.merge();
          _logger.info('Snapshot load completed.');
          // the first scan is no longer relevant, enabling frequent index merges
          _firstScanCount = 0;
        }
      }
    } catch (e, st) {
      _logger.warning('Error while fetching snapshot.', e, st);
    }
    // Create an empty snapshot if the above failed. This will be populated with
    // package data via a separate update process.
    _snapshot ??= SearchSnapshot();
  }

  @override
  Future runTask(Task task) async {
    _taskCount++;
    try {
      // The index requires the analysis results in most of the cases, except:
      // - when a new package is created, and it is not in the snapshot yet, or
      // - when the last timestamp is older than 7 days in the snapshot.
      //
      // The later requirement is working on the assumption that normally the
      // index will update the packages in the snapshot every day, but if the
      // analysis won't complete for some reason, we still want to update the
      // index with a potential update to the package.
      final now = DateTime.now().toUtc();
      final sd = _snapshot.documents[task.package];
      final requireAnalysis =
          sd != null && now.difference(sd.timestamp).inDays < 7;

      final doc = await searchBackend.loadDocument(task.package,
          requireAnalysis: requireAnalysis);
      _snapshot.add(doc);
      await packageIndex.addPackage(doc);
    } on RemovedPackageException catch (_) {
      _logger.info('Removing: ${task.package}');
      _snapshot.remove(task.package);
      await packageIndex.removePackage(task.package);
    } on MissingAnalysisException catch (_) {
      // Nothing to do yet, keeping old version if it exists.
    }
    if (_firstScanCount != null && _taskCount >= _firstScanCount) {
      _logger.info('Merging index after $_taskCount updates.');
      await packageIndex.merge();
      _logger.info('Merge completed.');
      await _updateSnapshotIfNeeded();
    }
  }

  Future _updateSnapshotIfNeeded() async {
    final DateTime now = DateTime.now();
    if (now.difference(_lastSnapshotWrite).inHours > 12) {
      _lastSnapshotWrite = now;
      try {
        _logger.info('Updating search snapshot...');
        await snapshotStorage.store(_snapshot);
        _logger.info('Search snapshot update completed.');
      } catch (e, st) {
        _logger.warning('Unable to update search snapshot.', e, st);
      }
    }
  }
}

/// A task source that generates an update task for stale documents.
///
/// It scans the current search snapshot every two hours, and selects the
/// packages that have not been updated in the last 24 hours.
class _PeriodicUpdateTaskSource implements TaskSource {
  final SearchSnapshot _snapshot;
  _PeriodicUpdateTaskSource(this._snapshot);

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      await Future.delayed(Duration(hours: 2));
      final now = DateTime.now();
      final tasks = _snapshot.documents.values
          .where((pd) =>
              pd.timestamp == null ||
              now.difference(pd.timestamp).inHours >= 24)
          .map((pd) => Task(pd.package, pd.version, now))
          .toList();
      for (Task task in tasks) {
        yield task;
      }
    }
  }
}
