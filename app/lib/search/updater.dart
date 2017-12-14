// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../shared/search_service.dart';
import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';

import 'backend.dart';
import 'index_simple.dart';

final Logger _logger = new Logger('pub.search.updater');

class IndexUpdateTaskSource extends DatastoreVersionsHeadTaskSource {
  final BatchIndexUpdater _batchIndexUpdater;
  IndexUpdateTaskSource(DatastoreDB db, this._batchIndexUpdater)
      : super(db, TaskSourceModel.package, sleep: const Duration(minutes: 30));

  @override
  Future dbScanComplete(int count) async {
    _batchIndexUpdater.reportScanCount(count);
  }
}

class BatchIndexUpdater implements TaskRunner {
  final List<Task> _batch = [];
  Timer _batchUpdateTimer;
  Future _ongoingBatchUpdate;
  int _taskCount = 0;
  SearchSnapshot _snapshot;
  DateTime _lastSnapshotWrite = new DateTime.now();

  // Used by [IndexUpdateTaskSource] to indicating how many packages were
  // yielded in the first run of the index update.
  // When [BatchIndexUpdater] processes more than this number of tasks, it will
  // start do the index merges, making sure that the index is marked as ready.
  int _firstScanCount;

  void reportScanCount(int count) {
    if (_firstScanCount != null) return;
    _firstScanCount = count;
  }

  Future initSnapshot() async {
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
    if (_snapshot == null) {
      _snapshot = new SearchSnapshot();
      // making sure snapshot will be written as soon as the first scan is done
      _lastSnapshotWrite = new DateTime.now().subtract(new Duration(days: 1));
    }
  }

  @override
  Future<bool> shouldSkipTask(Task task) async => false;

  @override
  Future<bool> runTask(Task task) async {
    while (_ongoingBatchUpdate != null) {
      await _ongoingBatchUpdate;
    }
    _batch.add(task);
    if (_batch.length < 20) {
      _batchUpdateTimer ??= new Timer(const Duration(seconds: 10), () {
        _updateBatch();
      });
    } else {
      await _updateBatch();
    }
    // no race here
    return false;
  }

  Future _updateBatch() async {
    _batchUpdateTimer?.cancel();
    _batchUpdateTimer = null;

    while (_ongoingBatchUpdate != null) {
      await _ongoingBatchUpdate;
    }
    if (_batch.isEmpty) return;

    final Completer completer = new Completer();
    _ongoingBatchUpdate = completer.future;

    try {
      final List<Task> tasks = new List.from(_batch);
      _batch.clear();
      _taskCount += tasks.length;
      _logger.info('Updating index with ${tasks.length} packages '
          '[example: ${tasks.first.package}]');
      final List<PackageDocument> docs = (await searchBackend
              .loadDocuments(tasks.map((t) => t.package).toList()))
          .where((doc) => doc != null)
          .toList();
      _snapshot.addAll(docs);
      await packageIndex.addPackages(docs);
      final bool doMerge =
          _firstScanCount != null && _taskCount >= _firstScanCount;
      if (doMerge) {
        _logger.info('Merging index after $_taskCount updates.');
        await packageIndex.merge();
        _logger.info('Merge completed.');

        await _updateSnapshotIfNeeded(docs);
      }
    } finally {
      completer.complete();
      _ongoingBatchUpdate = null;
    }
  }

  Future _updateSnapshotIfNeeded(List<PackageDocument> docs) async {
    final DateTime now = new DateTime.now();
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
