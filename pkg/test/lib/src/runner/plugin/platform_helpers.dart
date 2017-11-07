// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:stack_trace/stack_trace.dart';
import 'package:stream_channel/stream_channel.dart';

import '../../backend/group.dart';
import '../../backend/metadata.dart';
import '../../backend/test.dart';
import '../../backend/test_platform.dart';
import '../../util/io.dart';
import '../../util/remote_exception.dart';
import '../../util/stack_trace_mapper.dart';
import '../application_exception.dart';
import '../configuration.dart';
import '../configuration/suite.dart';
import '../environment.dart';
import '../load_exception.dart';
import '../runner_suite.dart';
import '../runner_test.dart';

final _deserializeTimeout = new Duration(minutes: 8);

/// A helper method for creating a [RunnerSuiteController] containing tests
/// that communicate over [channel].
///
/// This returns a controller so that the caller has a chance to control the
/// runner suite's debugging state based on plugin-specific logic.
///
/// If the suite is closed, this will close [channel].
///
/// The [message] parameter is an opaque object passed from the runner to
/// [PlatformPlugin.load]. Plugins shouldn't interact with it other than to pass
/// it on to [deserializeSuite].
///
/// If [mapper] is passed, it will be used to adjust stack traces for any errors
/// emitted by tests.
Future<RunnerSuiteController> deserializeSuite(
    String path,
    TestPlatform platform,
    SuiteConfiguration suiteConfig,
    Environment environment,
    StreamChannel channel,
    Object message,
    {StackTraceMapper mapper}) async {
  var disconnector = new Disconnector();
  var suiteChannel = new MultiChannel(channel.transform(disconnector));

  suiteChannel.sink.add({
    'platform': platform.serialize(),
    'metadata': suiteConfig.metadata.serialize(),
    'os': platform == TestPlatform.vm ? currentOS.identifier : null,
    'asciiGlyphs': Platform.isWindows,
    'path': path,
    'collectTraces': Configuration.current.reporter == 'json',
    'noRetry': Configuration.current.noRetry,
    'stackTraceMapper': mapper?.serialize(),
    'foldTraceExcept': Configuration.current.foldTraceExcept.toList(),
    'foldTraceOnly': Configuration.current.foldTraceOnly.toList(),
  }..addAll(message as Map));

  var completer = new Completer();

  var loadSuiteZone = Zone.current;
  handleError(error, stackTrace) {
    disconnector.disconnect();

    if (completer.isCompleted) {
      // If we've already provided a controller, send the error to the
      // LoadSuite. This will cause the virtual load test to fail, which will
      // notify the user of the error.
      loadSuiteZone.handleUncaughtError(error, stackTrace);
    } else {
      completer.completeError(error, stackTrace);
    }
  }

  suiteChannel.stream.listen(
      (response) {
        switch (response["type"]) {
          case "print":
            print(response["line"]);
            break;

          case "loadException":
            handleError(new LoadException(path, response["message"]),
                new Trace.current());
            break;

          case "error":
            var asyncError = RemoteException.deserialize(response["error"]);
            handleError(new LoadException(path, asyncError.error),
                asyncError.stackTrace);
            break;

          case "success":
            var deserializer = new _Deserializer(suiteChannel);
            completer.complete(deserializer.deserializeGroup(response["root"]));
            break;
        }
      },
      onError: handleError,
      onDone: () {
        if (completer.isCompleted) return;
        completer.completeError(
            new LoadException(
                path, "Connection closed before test suite loaded."),
            new Trace.current());
      });

  return new RunnerSuiteController(
      environment,
      suiteConfig,
      await completer.future.timeout(_deserializeTimeout, onTimeout: () {
        throw new ApplicationException(
            "Timed out while loading the test suite.\n"
            "It's likely that there's a missing import or syntax error.");
      }),
      path: path,
      platform: platform,
      os: currentOS,
      onClose: () => disconnector.disconnect().catchError(handleError));
}

/// A utility class for storing state while deserializing tests.
class _Deserializer {
  /// The channel over which tests communicate.
  final MultiChannel _channel;

  _Deserializer(this._channel);

  /// Deserializes [group] into a concrete [Group].
  Group deserializeGroup(Map group) {
    var metadata = new Metadata.deserialize(group['metadata']);
    return new Group(
        group['name'],
        (group['entries'] as List).map((entry) {
          var map = entry as Map;
          if (map['type'] == 'group') return deserializeGroup(map);
          return _deserializeTest(map);
        }),
        metadata: metadata,
        trace: group['trace'] == null ? null : new Trace.parse(group['trace']),
        setUpAll: _deserializeTest(group['setUpAll']),
        tearDownAll: _deserializeTest(group['tearDownAll']));
  }

  /// Deserializes [test] into a concrete [Test] class.
  ///
  /// Returns `null` if [test] is `null`.
  Test _deserializeTest(Map test) {
    if (test == null) return null;

    var metadata = new Metadata.deserialize(test['metadata']);
    var trace = test['trace'] == null ? null : new Trace.parse(test['trace']);
    var testChannel = _channel.virtualChannel(test['channel']);
    return new RunnerTest(test['name'], metadata, trace, testChannel);
  }
}
