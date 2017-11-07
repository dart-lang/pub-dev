// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:isolate";

import "package:stream_channel/stream_channel.dart";

import "../runner/plugin/remote_platform_helpers.dart";
import "../runner/vm/catch_isolate_errors.dart";

/// Bootstraps a vm test to communicate with the test runner.
///
/// This should NOT be used directly, instead use the `test/pub_serve`
/// transformer which will bootstrap your test and call this method.
void internalBootstrapVmTest(Function getMain(), SendPort sendPort) {
  var channel = serializeSuite(() {
    catchIsolateErrors();
    return getMain();
  });
  new IsolateChannel.connectSend(sendPort).pipe(channel);
}
