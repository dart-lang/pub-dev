// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import 'packages_overrides.dart';
import 'utils.dart';

final Logger _logger = new Logger('pub.scheduler');

/// Interface for task execution.
// ignore: one_member_abstracts
abstract class TaskRunner {
  /// Run the task.
  Future runTask(Task task);
}

// ignore: one_member_abstracts
abstract class TaskSource {
  /// Returns a stream of currently available tasks at the time of the call.
  Stream<Task> startStreaming();
}

/// Tasks coming from through the isolate's receivePort, originating from a
/// HTTP handler that received a ping after a new upload.
class ManualTriggerTaskSource implements TaskSource {
  final Stream<Task> _taskReceivePort;
  ManualTriggerTaskSource(this._taskReceivePort);

  @override
  Stream<Task> startStreaming() => _taskReceivePort;
}

/// Schedules and executes package analysis.
class TaskScheduler {
  final TaskRunner taskRunner;
  final List<TaskSource> sources;
  final LastNTracker<String> _statusTracker = new LastNTracker();
  final LastNTracker<num> _latencyTracker = new LastNTracker();
  int _pendingCount = 0;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    Future runTask(Task task) async {
      final Stopwatch sw = new Stopwatch()..start();
      try {
        if (redirectPackagePages.containsKey(task.package)) {
          return;
        }
        await taskRunner.runTask(task);
        _statusTracker.add('normal');
      } catch (e, st) {
        _logger.severe('Error processing task: $task', e, st);
        _statusTracker.add('error');
      }
      _latencyTracker.add(sw.elapsedMilliseconds);
    }

    final Pool pool = new Pool(1);
    final futures = sources
        .map((TaskSource ts) {
          final stream = ts.startStreaming();
          return stream.listen((task) {
            _pendingCount++;
            final f = pool.withResource(() => runTask(task));
            f.whenComplete(() {
              _pendingCount--;
            });
          });
        })
        .map((subscription) => subscription.asFuture())
        .toList();
    await Future.wait(futures);
  }

  Map stats() {
    final Map<String, dynamic> stats = <String, dynamic>{
      'pending': _pendingCount,
      'status': _statusTracker.toCounts(),
    };
    final double avgMillis = _latencyTracker.average;
    if (avgMillis > 0.0) {
      final double tph = 60 * 60 * 1000.0 / avgMillis;
      stats['taskPerHour'] = tph;
      final remaining =
          new Duration(milliseconds: (_pendingCount * avgMillis).round());
      stats['remaining'] = formatDuration(remaining);
    }
    return stats;
  }
}

/// A task for a given package and version.
class Task {
  final String package;
  final String version;

  Task(this.package, this.version);

  Task.now(this.package, this.version);

  @override
  String toString() => '$package $version';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          package == other.package &&
          version == other.version;

  @override
  int get hashCode => package.hashCode ^ version.hashCode;
}

class TaskTargetStatus {
  final bool shouldSkip;
  final String reason;

  TaskTargetStatus(this.shouldSkip, this.reason);

  TaskTargetStatus.ok()
      : shouldSkip = false,
        reason = null;

  TaskTargetStatus.skip(this.reason) : shouldSkip = true;
}
