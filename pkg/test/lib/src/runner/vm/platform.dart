// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:stream_channel/stream_channel.dart';

import '../../backend/test_platform.dart';
import '../../util/dart.dart' as dart;
import '../configuration.dart';
import '../load_exception.dart';
import '../plugin/platform.dart';

/// A platform that loads tests in isolates spawned within this Dart process.
class VMPlatform extends PlatformPlugin {
  /// The test runner configuration.
  final _config = Configuration.current;

  VMPlatform();

  StreamChannel loadChannel(String path, TestPlatform platform) {
    assert(platform == TestPlatform.vm);

    var isolate;
    var channel = StreamChannelCompleter.fromFuture(() async {
      var receivePort = new ReceivePort();

      try {
        isolate = await _spawnIsolate(path, receivePort.sendPort);
      } catch (error) {
        receivePort.close();
        rethrow;
      }

      return new IsolateChannel.connectReceive(receivePort);
    }());

    // Once the connection is closed by either end, kill the isolate.
    return channel
        .transformStream(new StreamTransformer.fromHandlers(handleDone: (sink) {
      if (isolate != null) isolate.kill();
      sink.close();
    }));
  }

  /// Spawns an isolate and passes it [message].
  ///
  /// This isolate connects an [IsolateChannel] to [message] and sends the
  /// serialized tests over that channel.
  Future<Isolate> _spawnIsolate(String path, SendPort message) async {
    if (_config.pubServeUrl == null) {
      return await dart.runInIsolate('''
        import "dart:isolate";

        import "package:stream_channel/stream_channel.dart";

        import "package:test/src/runner/plugin/remote_platform_helpers.dart";
        import "package:test/src/runner/vm/catch_isolate_errors.dart";

        import "${p.toUri(p.absolute(path))}" as test;

        void main(_, SendPort message) {
          var channel = serializeSuite(() {
            catchIsolateErrors();
            return test.main;
          });
          new IsolateChannel.connectSend(message).pipe(channel);
        }
      ''', message, checked: true);
    }

    var url = _config.pubServeUrl
        .resolveUri(p.toUri(p.relative(path, from: 'test') + '.vm_test.dart'));

    try {
      return await Isolate.spawnUri(url, [], message, checked: true);
    } on IsolateSpawnException catch (error) {
      if (error.message.contains("OS Error: Connection refused") ||
          error.message.contains("The remote computer refused")) {
        throw new LoadException(
            path,
            "Error getting $url: Connection refused\n"
            'Make sure "pub serve" is running.');
      } else if (error.message.contains("404 Not Found")) {
        throw new LoadException(
            path,
            "Error getting $url: 404 Not Found\n"
            'Make sure "pub serve" is serving the test/ directory.');
      }

      throw new LoadException(path, error);
    }
  }
}
