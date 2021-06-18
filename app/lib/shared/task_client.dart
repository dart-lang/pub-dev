// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart=2.12

import 'dart:isolate';

import 'task_scheduler.dart' show Task, TaskScheduler;

final _taskSendPorts = <SendPort>[];
int _taskSendIndex = 0;

// Temporary queue until the isolate comes online.
final _taskQueue = <Task>[];

void registerTaskSendPort(SendPort taskSendPort) {
  _taskSendPorts.add(taskSendPort);
  if (_taskQueue.isNotEmpty) {
    final queued = List<Task>.from(_taskQueue);
    _taskQueue.clear();
    for (Task task in queued) {
      _send(task);
    }
  }
}

void unregisterTaskSendPort(SendPort taskSendPort) {
  _taskSendPorts.remove(taskSendPort);
}

/// Triggers task processing via sending tasks to the [TaskScheduler] in the
/// other isolate.
void triggerTask(String package, String version) {
  _send(Task.now(package, version));
}

void _send(Task task) {
  if (_taskSendPorts.isEmpty) {
    _taskQueue.add(task);
    return;
  }
  _taskSendIndex++;
  if (_taskSendIndex >= _taskSendPorts.length) {
    _taskSendIndex = 0;
  }
  _taskSendPorts[_taskSendIndex].send(task);
}
