// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:async/async.dart';
import 'package:stack_trace/stack_trace.dart';

import '../stream_channel.dart';

/// A [StreamChannel] that communicates over a [ReceivePort]/[SendPort] pair,
/// presumably with another isolate.
///
/// The remote endpoint doesn't necessarily need to be running an
/// [IsolateChannel]. This can be used with any two ports, although the
/// [StreamChannel] semantics mean that this class will treat them as being
/// paired (for example, closing the [sink] will cause the [stream] to stop
/// emitting events).
///
/// The underlying isolate ports have no notion of closing connections. This
/// means that [stream] won't close unless [sink] is closed, and that closing
/// [sink] won't cause the remote endpoint to close. Users should take care to
/// ensure that they always close the [sink] of every [IsolateChannel] they use
/// to avoid leaving dangling [ReceivePort]s.
class IsolateChannel<T> extends StreamChannelMixin<T> {
  final Stream<T> stream;
  final StreamSink<T> sink;

  /// Connects to a remote channel that was created with
  /// [IsolateChannel.connectSend].
  ///
  /// These constructors establish a connection using only a single
  /// [SendPort]/[ReceivePort] pair, as long as each side uses one of the
  /// connect constructors.
  ///
  /// The connection protocol is guaranteed to remain compatible across versions
  /// at least until the next major version release. If the protocol is
  /// violated, the resulting channel will emit a single value on its stream and
  /// then close.
  factory IsolateChannel.connectReceive(ReceivePort receivePort) {
    // We can't use a [StreamChannelCompleter] here because we need the return
    // value to be an [IsolateChannel].
    var streamCompleter = new StreamCompleter<T>();
    var sinkCompleter = new StreamSinkCompleter<T>();
    var channel =
        new IsolateChannel<T>._(streamCompleter.stream, sinkCompleter.sink);

    // The first message across the ReceivePort should be a SendPort pointing to
    // the remote end. If it's not, we'll make the stream emit an error
    // complaining.
    var subscription;
    subscription = receivePort.listen((message) {
      if (message is SendPort) {
        var controller = new StreamChannelController<T>(
            allowForeignErrors: false, sync: true);
        new SubscriptionStream(subscription).pipe(controller.local.sink);
        controller.local.stream
            .listen((data) => message.send(data), onDone: receivePort.close);

        streamCompleter.setSourceStream(controller.foreign.stream);
        sinkCompleter.setDestinationSink(controller.foreign.sink);
        return;
      }

      streamCompleter.setError(
          new StateError('Unexpected Isolate response "$message".'),
          new Trace.current());
      sinkCompleter.setDestinationSink(new NullStreamSink<T>());
      subscription.cancel();
    });

    return channel;
  }

  /// Connects to a remote channel that was created with
  /// [IsolateChannel.connectReceive].
  ///
  /// These constructors establish a connection using only a single
  /// [SendPort]/[ReceivePort] pair, as long as each side uses one of the
  /// connect constructors.
  ///
  /// The connection protocol is guaranteed to remain compatible across versions
  /// at least until the next major version release.
  factory IsolateChannel.connectSend(SendPort sendPort) {
    var receivePort = new ReceivePort();
    sendPort.send(receivePort.sendPort);
    return new IsolateChannel(receivePort, sendPort);
  }

  /// Creates a stream channel that receives messages from [receivePort] and
  /// sends them over [sendPort].
  factory IsolateChannel(ReceivePort receivePort, SendPort sendPort) {
    var controller =
        new StreamChannelController<T>(allowForeignErrors: false, sync: true);
    receivePort.pipe(controller.local.sink);
    controller.local.stream
        .listen((data) => sendPort.send(data), onDone: receivePort.close);
    return new IsolateChannel._(
        controller.foreign.stream, controller.foreign.sink);
  }

  IsolateChannel._(this.stream, this.sink);
}
