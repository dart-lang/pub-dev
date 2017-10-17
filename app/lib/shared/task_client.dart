// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:isolate';

import 'task_scheduler.dart' show Task;

SendPort _taskSendPort;

// Temporary queue until the isolate comes online.
List<Task> _taskQueue = [];

void registerTaskSendPort(SendPort taskSendPort) {
  _taskSendPort = taskSendPort;
  if (_taskQueue != null) {
    for (Task task in _taskQueue) {
      _taskSendPort.send(task);
    }
    _taskQueue = null;
  }
}

/// Triggers task processing via sending tasks to the [Scheduler] in the other
/// isolate.
void triggerTask(
    String package, String version, List<String> dependentPackages) {
  // TODO: Make use of [dependentPackages].

  final Task task = new Task.now(package, version);
  if (_taskSendPort == null) {
    _taskQueue.add(task);
  } else {
    _taskSendPort.send(task);
  }
}
