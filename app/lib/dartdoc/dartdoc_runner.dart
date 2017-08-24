// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';

import '../shared/task_scheduler.dart' show Task, TaskRunner;

final Logger _logger = new Logger('pub.dartdoc.runner');

class DartdocRunner implements TaskRunner {
  @override
  Future<bool> hasCompletedRecently(Task task) async {
    // TODO: implement a metadata check
    return false;
  }

  @override
  Future<bool> runTask(Task task) async {
    // TODO: implement doc generation and upload
    return false; // no race detected
  }
}
