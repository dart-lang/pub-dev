// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:logging/logging.dart';

final Logger _logger = new Logger('pub.scheduler');

/// Interface for task execution.
typedef Future TaskRunner(Task task);

// ignore: one_member_abstracts
abstract class TaskSource {
  final StreamController<Task> _controller = new StreamController();

  /// Returns a stream of currently available tasks at the time of the call.
  Stream<Task> start() => _controller.stream;

  void addTask(Task task) {
    _controller.add(task);
  }
}

/// Tasks coming from through the isolate's receivePort, originating from a
/// HTTP handler that received a ping after a new upload.
class ManualTriggerTaskSource extends TaskSource {
  final Set<Task> _triggered = new Set();
  StreamSubscription<Task> _subscription;
  Timer _timer;

  ManualTriggerTaskSource(Stream taskReceivePort, {int capacity: 100}) {
    _subscription = taskReceivePort.listen((Task task) {
      // protect against spamming the manual trigger
      if (_triggered.length < capacity) {
        _triggered.add(task);
      }
      if (_timer == null) {
        _timer = new Timer(const Duration(minutes: 1), () {
          _timer = null;
          for (Task task in _triggered) {
            _controller.add(task);
          }
          _triggered.clear();
        });
      }
    });
  }

  void close() {
    // It is unlikely that we will close this, but cancelling the subscription
    // makes dartanalyzer happy.
    _subscription.cancel();
  }
}

/// Task source that has a limit on how frequently it will poll its data source.
abstract class PollingTaskSource extends TaskSource {
  final Duration _period;
  Timer _timer;
  PollingTaskSource(Duration period):_period = period;

  @override
  Stream<Task> start() {
    _scheduleTimer();
    return super.start();
  }

  Future poll();

  void _scheduleTimer() {
    if (_timer != null) return;
    _timer = new Timer(_period, () async {
      _timer = null;
      await poll();
      _scheduleTimer();
    });
  }
}

/// Schedules and executes package analysis.
class TaskScheduler {
  final TaskRunner taskRunner;
  final List<TaskSource> sources;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    final Stream<Task> stream =
        StreamGroup.merge(sources.map((source) => source.start()));

    await for (Task task in stream) {
      try {
        await taskRunner(task);
      } catch (e, st) {
        _logger.severe('Error processing task: $task', e, st);
      }
    }
  }
}

/// A task for a given package and version.
class Task {
  final String package;
  final String version;

  Task(this.package, this.version);

  @override
  String toString() => '$package $version';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          version == other.version;

  @override
  int get hashCode => version.hashCode;
}
