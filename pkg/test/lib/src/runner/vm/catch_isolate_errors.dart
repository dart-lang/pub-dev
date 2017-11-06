// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:stack_trace/stack_trace.dart';

/// Capture any top-level errors (mostly lazy syntax errors, since other are
/// caught below) and report them to the parent isolate.
void catchIsolateErrors() {
  var errorPort = new ReceivePort();
  // Treat errors non-fatal because otherwise they'll be double-printed.
  Isolate.current.setErrorsFatal(false);
  Isolate.current.addErrorListener(errorPort.sendPort);
  errorPort.listen((message) {
    // Masquerade as an IsolateSpawnException because that's what this would
    // be if the error had been detected statically.
    var error = new IsolateSpawnException(message[0]);
    var stackTrace =
        message[1] == null ? new Trace([]) : new Trace.parse(message[1]);
    Zone.current.handleUncaughtError(error, stackTrace);
  });
}
