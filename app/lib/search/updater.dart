// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show DetailedApiRequestError;
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../dartdoc/backend.dart';
import '../package/models.dart' show Package;
import '../shared/exceptions.dart';
import '../shared/scheduler_stats.dart';
import '../shared/task_scheduler.dart';
import '../shared/task_sources.dart';

import 'backend.dart';
import 'index_simple.dart';

final Logger _logger = Logger('pub.search.updater');

/// Sets the index updater.
void registerIndexUpdater(IndexUpdater updater) =>
    ss.register(#_indexUpdater, updater);

/// The active index updater.
IndexUpdater get indexUpdater => ss.lookup(#_indexUpdater) as IndexUpdater;

class IndexUpdater implements TaskRunner {
  final DatastoreDB _db;
  SearchSnapshot _snapshot;
  DateTime _lastSnapshotWrite = DateTime.now();
  Timer _statsTimer;

  IndexUpdater(this._db);

  /// Loads the package index snapshot, or if it fails, creates a minimal
  /// package index with only package names and minimal information.
  Future<void> init() async {
    final isReady = await _initSnapshot();
    if (!isReady) {
      _logger.info('Loading minimum package index...');
      int cnt = 0;
      await for (final pd in searchBackend.loadMinimumPackageIndex()) {
        await packageIndex.addPackage(pd);
        cnt++;
        if (cnt % 500 == 0) {
          _logger.info('Loaded $cnt minimum package data (${pd.package})');
        }
      }
      await packageIndex.markReady();
      _logger.info('Minimum package index loaded with $cnt packages.');
    }
  }

  /// Updates all packages in the index.
  /// It is slower than searchBackend.loadMinimumPackageIndex, but provides a
  /// complete document for the index.
  @visibleForTesting
  Future<void> updateAllPackages() async {
    await for (final p in _db.query<Package>().run()) {
      final doc = await searchBackend.loadDocument(p.name);
      await packageIndex.addPackage(doc);
    }
    await packageIndex.markReady();
  }

  /// Returns whether the snapshot was initialized and loaded properly.
  Future<bool> _initSnapshot() async {
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
          await packageIndex.markReady();
          _logger.info('Snapshot load completed.');
          return true;
        }
      }
    } catch (e, st) {
      _logger.warning('Error while fetching snapshot.', e, st);
    }
    // Create an empty snapshot if the above failed. This will be populated with
    // package data via a separate update process.
    _snapshot ??= SearchSnapshot();
    return false;
  }

  /// Starts the scheduler to update the package index.
  void runScheduler({Stream<Task> manualTriggerTasks}) {
    manualTriggerTasks ??= Stream<Task>.empty();
    final scheduler = TaskScheduler(
      this,
      [
        ManualTriggerTaskSource(manualTriggerTasks),
        DatastoreHeadTaskSource(
          _db,
          TaskSourceModel.package,
          sleep: const Duration(minutes: 10),
        ),
        DatastoreHeadTaskSource(
          _db,
          TaskSourceModel.scorecard,
          sleep: const Duration(minutes: 10),
          skipHistory: true,
        ),
        _PeriodicUpdateTaskSource(_snapshot),
      ],
    );
    scheduler.run();

    _statsTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      updateLatestStats(scheduler.stats());
    });
  }

  Future<void> close() async {
    _statsTimer?.cancel();
    _statsTimer = null;
    // TODO: close scheduler
  }

  @override
  Future<void> runTask(Task task) async {
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
    await _updateSnapshotIfNeeded();
  }

  Future<void> _updateSnapshotIfNeeded() async {
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

  /// Triggers the load of the SDK index from the dartdoc storage bucket.
  void initDartSdkIndex() {
    // Don't block on SDK index updates, as it may take several minutes before
    // the dartdoc service produces the required output.
    _updateDartSdkIndex().whenComplete(() {});
  }

  Future<void> _updateDartSdkIndex() async {
    for (int i = 0;; i++) {
      try {
        _logger.info('Trying to load SDK index.');
        final data = await dartdocBackend.getDartSdkDartdocData();
        if (data != null) {
          final docs = splitLibraries(data)
              .map((lib) => createSdkDocument(lib))
              .toList();
          await dartSdkIndex.addPackages(docs);
          await dartSdkIndex.markReady();
          _logger.info('Dart SDK index loaded successfully.');
          return;
        }
      } on DetailedApiRequestError catch (e, st) {
        if (e.status == 404) {
          _logger.info('Error loading Dart SDK index.', e, st);
        } else {
          _logger.warning('Error loading Dart SDK index.', e, st);
        }
      } catch (e, st) {
        _logger.warning('Error loading Dart SDK index.', e, st);
      }
      if (i % 10 == 0) {
        _logger.warning('Unable to load Dart SDK index. Attempt: $i');
      }
      await Future.delayed(const Duration(minutes: 1));
    }
  }
}

/// A task source that generates an update task for stale documents.
///
/// It scans the current search snapshot every two hours, and selects the
/// packages that have not been updated in the last 24 hours.
class _PeriodicUpdateTaskSource implements TaskSource {
  final SearchSnapshot _snapshot;
  _PeriodicUpdateTaskSource(this._snapshot) {
    assert(_snapshot != null);
  }

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
