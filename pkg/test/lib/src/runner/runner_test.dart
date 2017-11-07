// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:stack_trace/stack_trace.dart';
import 'package:stream_channel/stream_channel.dart';

import '../backend/group.dart';
import '../backend/live_test.dart';
import '../backend/live_test_controller.dart';
import '../backend/message.dart';
import '../backend/metadata.dart';
import '../backend/operating_system.dart';
import '../backend/state.dart';
import '../backend/suite.dart';
import '../backend/test.dart';
import '../backend/test_platform.dart';
import '../util/remote_exception.dart';
import '../utils.dart';
import 'spawn_hybrid.dart';

/// A test running remotely, controlled by a stream channel.
class RunnerTest extends Test {
  final String name;
  final Metadata metadata;
  final Trace trace;

  /// The channel used to communicate with the test's [IframeListener].
  final MultiChannel _channel;

  RunnerTest(this.name, this.metadata, this.trace, this._channel);

  RunnerTest._(this.name, this.metadata, this.trace, this._channel);

  LiveTest load(Suite suite, {Iterable<Group> groups}) {
    var controller;
    var testChannel;
    controller = new LiveTestController(suite, this, () {
      controller.setState(const State(Status.running, Result.success));

      testChannel = _channel.virtualChannel();
      _channel.sink.add({'command': 'run', 'channel': testChannel.id});

      testChannel.stream.listen((message) {
        switch (message['type']) {
          case 'error':
            var asyncError = RemoteException.deserialize(message['error']);
            var stackTrace = asyncError.stackTrace;
            controller.addError(asyncError.error, stackTrace);
            break;

          case 'state-change':
            controller.setState(new State(new Status.parse(message['status']),
                new Result.parse(message['result'])));
            break;

          case 'message':
            controller.message(new Message(
                new MessageType.parse(message['message-type']),
                message['text']));
            break;

          case 'complete':
            controller.completer.complete();
            break;

          case 'spawn-hybrid-uri':
            // When we kill the isolate that the test lives in, that will close
            // this virtual channel and cause the spawned isolate to close as
            // well.
            spawnHybridUri(message['url'], message['message'])
                .pipe(testChannel.virtualChannel(message['channel']));
            break;
        }
      }, onDone: () {
        // When the test channel closes—presumably becuase the browser
        // closed—mark the test as complete no matter what.
        if (controller.completer.isCompleted) return;
        controller.completer.complete();
      });
    }, () {
      // If the test has finished running, just disconnect the channel.
      if (controller.completer.isCompleted) {
        testChannel.sink.close();
        return;
      }

      invoke(() async {
        // If the test is still running, send it a message telling it to shut
        // down ASAP. This causes the [Invoker] to eagerly throw exceptions
        // whenever the test touches it.
        testChannel.sink.add({'command': 'close'});
        await controller.completer.future;
        testChannel.sink.close();
      });
    }, groups: groups);
    return controller.liveTest;
  }

  Test forPlatform(TestPlatform platform, {OperatingSystem os}) {
    if (!metadata.testOn.evaluate(platform, os: os)) return null;
    return new RunnerTest._(
        name, metadata.forPlatform(platform, os: os), trace, _channel);
  }
}
