// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';

import '../environment.dart';

/// The default environment for platform plugins.
class PluginEnvironment implements Environment {
  final supportsDebugging = false;
  Stream get onRestart => new StreamController.broadcast().stream;

  const PluginEnvironment();

  Uri get observatoryUrl => null;

  Uri get remoteDebuggerUrl => null;

  CancelableOperation displayPause() => throw new UnsupportedError(
      "PluginEnvironment.displayPause is not supported.");
}
