// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async";
import "dart:isolate";

import "package:async/async.dart";
import "package:stack_trace/stack_trace.dart";
import "package:stream_channel/stream_channel.dart";

import "../util/remote_exception.dart";
import "../utils.dart";

/// A sink transformer that wraps data and error events so that errors can be
/// decoded after being JSON-serialized.
final _transformer =
    new StreamSinkTransformer.fromHandlers(handleData: (data, sink) {
  ensureJsonEncodable(data);
  sink.add({"type": "data", "data": data});
}, handleError: (error, stackTrace, sink) {
  sink.add(
      {"type": "error", "error": RemoteException.serialize(error, stackTrace)});
});

/// Runs the body of a hybrid isolate and communicates its messages, errors, and
/// prints to the main isolate.
///
/// The [getMain] function returns the `hybridMain()` method. It's wrapped in a
/// closure so that, if the method undefined, we can catch the error and notify
/// the caller of it.
///
/// The [data] argument contains two values: a [SendPort] that communicates with
/// the main isolate, and a message to pass to `hybridMain()`.
void listen(AsyncFunction getMain(), List data) {
  var channel = new IsolateChannel.connectSend(data.first as SendPort);
  var message = data.last;

  Chain.capture(() {
    runZoned(() {
      var main;
      try {
        main = getMain();
      } on NoSuchMethodError catch (_) {
        _sendError(channel, "No top-level hybridMain() function defined.");
        return;
      } catch (error, stackTrace) {
        _sendError(channel, error, stackTrace);
        return;
      }

      if (main is! Function) {
        _sendError(channel, "Top-level hybridMain is not a function.");
        return;
      } else if (main is! ZoneUnaryCallback && main is! ZoneBinaryCallback) {
        _sendError(channel,
            "Top-level hybridMain() function must take one or two arguments.");
        return;
      }

      // Wrap [channel] before passing it to user code so that we can wrap
      // errors and distinguish user data events from control events sent by the
      // listener.
      var transformedChannel = channel.transformSink(_transformer);
      if (main is ZoneUnaryCallback) {
        main(transformedChannel);
      } else {
        main(transformedChannel, message);
      }
    }, zoneSpecification: new ZoneSpecification(print: (_, __, ___, line) {
      channel.sink.add({"type": "print", "line": line});
    }));
  }, onError: (error, stackTrace) async {
    _sendError(channel, error, stackTrace);
    await channel.sink.close();
    Zone.current.handleUncaughtError(error, stackTrace);
  });
}

/// Sends a message over [channel] indicating an error from user code.
void _sendError(StreamChannel channel, error, [StackTrace stackTrace]) {
  channel.sink.add({
    "type": "error",
    "error": RemoteException.serialize(error, stackTrace ?? new Chain.current())
  });
}
