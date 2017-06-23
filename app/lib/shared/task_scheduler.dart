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
  /// Returns a stream of currently available tasks at the time of the call.
  Stream<Task> currentTasks();
}

/// Tasks coming from through the isolate's receivePort, originating from a
/// HTTP handler that received a ping after a new upload.
class ManualTriggerTaskSource implements TaskSource {
  final Stream taskReceivePort;
  final int capacity;
  StreamSubscription _subscription;
  final Set<Task> _triggered = new Set();

  ManualTriggerTaskSource(this.taskReceivePort, {this.capacity: 100}) {
    _subscription = taskReceivePort.listen((Task task) {
      // protect against spamming the manual trigger
      if (_triggered.length < capacity) {
        _triggered.add(task);
      }
    });
  }

  @override
  Stream<Task> currentTasks() {
    final List<Task> tasks = _triggered.toList();
    _triggered.clear();
    return new Stream.fromIterable(tasks);
  }

  void close() {
    // It is unlikely that we will close this, but cancelling the subscription
    // makes dartanalyzer happy.
    _subscription.cancel();
  }
}

/// Task source that has a limit on the polling frequency.
abstract class PollingTaskSource implements TaskSource {
  final Duration minimumPeriod;
  DateTime _lastPollTime;

  PollingTaskSource(this.minimumPeriod);

  @override
  Stream<Task> currentTasks() {
    final DateTime now = new DateTime.now();
    if (_lastPollTime == null ||
        now.difference(_lastPollTime) > minimumPeriod) {
      _lastPollTime = now;
      return pollTasks();
    }
    return new Stream.fromIterable([]);
  }

  Stream<Task> pollTasks();
}

/// Schedules and executes package analysis.
class TaskScheduler {
  final TaskRunner taskRunner;
  final List<TaskSource> sources;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    for (;;) {
      final Stream<Task> stream =
          StreamGroup.merge(sources.map((source) => source.currentTasks()));
      await for (Task task in stream) {
        try {
          await taskRunner(task);
        } catch (e, st) {
          _logger.severe('Error processing task: $task', e, st);
        }
        // taking a nap, GC may kick in?
        await new Future.delayed(new Duration(seconds: 5));
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
