// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../shared/task_scheduler.dart';

class DatastoreHeadTaskSource extends PollingTaskSource {
  DatastoreHeadTaskSource() : super(new Duration(minutes: 10));

  @override
  Stream<Task> pollTasks() {
    // TODO: implement pollTasks
    return new Stream.empty();
  }
}

class DatastoreHistoryTaskSource extends PollingTaskSource {
  DatastoreHistoryTaskSource() : super(new Duration(hours: 1));

  @override
  Stream<Task> pollTasks() {
    // TODO: implement pollTasks
    return new Stream.empty();
  }
}
