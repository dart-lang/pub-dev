// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';

import '../shared/search_service.dart';
import '../shared/task_scheduler.dart';

import 'backend.dart';
import 'index_ducene.dart';

Logger _logger = new Logger('pub.search.updater');

class IndexUpdateTaskSource implements TaskSource {
  final BatchIndexUpdater _batchIndexUpdater;
  DateTime _lastTs;
  IndexUpdateTaskSource(this._batchIndexUpdater);

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      final DateTime now = new DateTime.now().toUtc();
      int count = 0;
      await for (String package
          in searchBackend.listPackages(updatedAfter: _lastTs)) {
        count++;
        yield new Task(package, null);
      }
      _batchIndexUpdater.reportScanCount(count);
      _lastTs = now.subtract(const Duration(minutes: 10));
      await new Future.delayed(new Duration(minutes: 30));
    }
  }
}

class BatchIndexUpdater {
  final List<Task> _batch = [];
  Timer _batchUpdateTimer;
  Future _ongoingBatchUpdate;
  int _taskCount = 0;

  // Used by [IndexUpdateTaskSource] to indicating how many packages were
  // yielded in the first run of the index update.
  // When [BatchIndexUpdater] processes more than this number of tasks, it will
  // start do the index merges, making sure that the index is marked as ready.
  int _firstScanCount;

  void reportScanCount(int count) {
    if (_firstScanCount != null) return;
    _firstScanCount = count;
  }

  Future updateIndex(Task task) async {
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
      final List<PackageDocument> docs = await searchBackend
          .loadDocuments(tasks.map((t) => t.package).toList());
      await packageIndex.addAll(docs);
      final bool doMerge =
          _firstScanCount != null && _taskCount >= _firstScanCount;
      if (doMerge) {
        _logger.info('Merging index after $_taskCount updates.');
        await packageIndex.merge();
        _logger.info('Merge completed.');
      }
    } finally {
      completer.complete();
      _ongoingBatchUpdate = null;
    }
  }
}
