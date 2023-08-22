// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../package/backend.dart';
import '../package/models.dart';
import '../task/models.dart';

import 'datastore.dart';
import 'task_scheduler.dart';
import 'utils.dart';
import 'versions.dart';

final Logger _logger = Logger('pub.shared.task_sources');

const Duration _defaultWindow = Duration(minutes: 5);
const Duration _defaultSleep = Duration(minutes: 1);

enum TaskSourceModel { package, version, packageState }

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
    Duration? window,

    /// Inactivity duration between two polls.
    Duration? sleep,
  })  : _window = window ?? _defaultWindow,
        _sleep = sleep ?? _defaultSleep,
        _lastTs = skipHistory
            ? clock.now().toUtc().subtract(window ?? _defaultWindow)
            : DateTime.utc(2000);

  @override
  Stream<Task> startStreaming() async* {
    for (;;) {
      try {
        yield* pollOnce();
      } catch (e, st) {
        _logger.severe('Error polling head.', e, st);
      }
      await Future.delayed(_sleep);
    }
  }

  @visibleForTesting
  Stream<Task> pollOnce() async* {
    final now = clock.now().toUtc();
    switch (_model) {
      case TaskSourceModel.package:
        yield* _pollModel<Package>('updated', _packageToTask);
        break;
      case TaskSourceModel.version:
        yield* _pollModel<PackageVersion>('created', _versionToTask);
        break;
      case TaskSourceModel.packageState:
        yield* _pollModel<PackageState>('updated', _packageStateToTask);
        break;
    }
    _lastTs = now.subtract(_window);
  }

  Stream<Task> _pollModel<M extends Model>(
      String field, FutureOr<Task?> Function(M model) modelToTask) async* {
    final q = _db.query<M>()
      ..filter('$field >=', _lastTs)
      ..order('-$field');
    await for (M model in q.run().cast<M>()) {
      final task = await modelToTask(model);
      if (task != null) {
        yield task;
      }
    }
  }

  Future<Task> _packageToTask(Package p) async {
    final releases = await packageBackend.latestReleases(p);
    return Task(p.name!, releases.stable.version, p.updated!);
  }

  Task _versionToTask(PackageVersion pv) =>
      Task(pv.package, pv.version!, pv.created!);

  Task? _packageStateToTask(PackageState s) {
    if (s.runtimeVersion == runtimeVersion) {
      return Task(s.package, null, s.finished ?? clock.now());
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
        await for (final p in packageQuery.run().cast<Package>()) {
          final releases = await packageBackend.latestReleases(p);
          if (await requiresUpdate(p.name!, releases.stable.version,
              retryFailed: true)) {
            yield Task(p.name!, releases.stable.version, p.updated!);
          }

          if (releases.showPrerelease &&
              await requiresUpdate(p.name!, releases.prerelease!.version)) {
            yield Task(p.name!, releases.prerelease!.version, p.updated!);
          }

          if (releases.showPreview &&
              await requiresUpdate(p.name!, releases.preview!.version)) {
            yield Task(p.name!, releases.preview!.version, p.updated!);
          }
        }

        // After we are done with the most important versions, let's check all
        // of the older versions too.
        final Query versionQuery = _db.query<PackageVersion>()
          ..order('-created');
        await for (PackageVersion pv
            in versionQuery.run().cast<PackageVersion>()) {
          if (await requiresUpdate(pv.package, pv.version!)) {
            yield Task(pv.package, pv.version!, pv.created!);
          }
        }
      } catch (e, st) {
        _logger.severe('Error polling history.', e, st);
      }
      await Future.delayed(const Duration(days: 1));
    }
  }
}
