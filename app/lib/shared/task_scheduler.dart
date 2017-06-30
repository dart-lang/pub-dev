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
  Stream<Task> startStreaming();
}

/// Tasks coming from through the isolate's receivePort, originating from a
/// HTTP handler that received a ping after a new upload.
class ManualTriggerTaskSource implements TaskSource {
  final Stream _taskReceivePort;
  ManualTriggerTaskSource(this._taskReceivePort);

  @override
  Stream<Task> startStreaming() async* {
    await for (final Task task in _taskReceivePort) {
      yield task;
      await new Future.delayed(const Duration(seconds: 10));
    }
  }
}

/// Schedules and executes package analysis.
class TaskScheduler {
  final TaskRunner taskRunner;
  final List<TaskSource> sources;

  TaskScheduler(this.taskRunner, this.sources);

  Future run() async {
    final Stream<Task> stream =
        StreamGroup.merge(sources.map((source) => source.startStreaming()));

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
