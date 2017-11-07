// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';

import '../stream_channel.dart';

/// A class that multiplexes multiple virtual channels across a single
/// underlying transport layer.
///
/// This should be connected to another [MultiChannel] on the other end of the
/// underlying channel. It starts with a single default virtual channel,
/// accessible via [stream] and [sink]. Additional virtual channels can be
/// created with [virtualChannel].
///
/// When a virtual channel is created by one endpoint, the other must connect to
/// it before messages may be sent through it. The first endpoint passes its
/// [VirtualChannel.id] to the second, which then creates a channel from that id
/// also using [virtualChannel]. For example:
///
/// ```dart
/// // First endpoint
/// var virtual = multiChannel.virtualChannel();
/// multiChannel.sink.add({
///   "channel": virtual.id
/// });
///
/// // Second endpoint
/// multiChannel.stream.listen((message) {
///   var virtual = multiChannel.virtualChannel(message["channel"]);
///   // ...
/// });
/// ```
///
/// Sending errors across a [MultiChannel] is not supported. Any errors from the
/// underlying stream will be reported only via the default
/// [MultiChannel.stream].
///
/// Each virtual channel may be closed individually. When all of them are
/// closed, the underlying [StreamSink] is closed automatically.
abstract class MultiChannel implements StreamChannel {
  /// The default input stream.
  ///
  /// This connects to the remote [sink].
  Stream get stream;

  /// The default output stream.
  ///
  /// This connects to the remote [stream]. If this is closed, the remote
  /// [stream] will close, but other virtual channels will remain open and new
  /// virtual channels may be opened.
  StreamSink get sink;

  /// Creates a new [MultiChannel] that sends and receives messages over
  /// [inner].
  ///
  /// The inner channel must take JSON-like objects.
  factory MultiChannel(StreamChannel inner) => new _MultiChannel(inner);

  /// Creates a new virtual channel.
  ///
  /// If [id] is not passed, this creates a virtual channel from scratch. Before
  /// it's used, its [VirtualChannel.id] must be sent to the remote endpoint
  /// where [virtualChannel] should be called with that id.
  ///
  /// If [id] is passed, this creates a virtual channel corresponding to the
  /// channel with that id on the remote channel.
  ///
  /// Throws an [ArgumentError] if a virtual channel already exists for [id].
  /// Throws a [StateError] if the underlying channel is closed.
  VirtualChannel virtualChannel([id]);
}

/// The implementation of [MultiChannel].
///
/// This is private so that [VirtualChannel] can inherit from [MultiChannel]
/// without having to implement all the private members.
class _MultiChannel extends StreamChannelMixin implements MultiChannel {
  /// The inner channel over which all communication is conducted.
  ///
  /// This will be `null` if the underlying communication channel is closed.
  StreamChannel _inner;

  /// The subscription to [_inner.stream].
  StreamSubscription _innerStreamSubscription;

  Stream get stream => _mainController.foreign.stream;
  StreamSink get sink => _mainController.foreign.sink;

  /// The controller for this channel.
  final _mainController = new StreamChannelController(sync: true);

  /// A map from virtual channel ids to [StreamChannelController]s that should
  /// be used to communicate over those channels.
  final _controllers = <int, StreamChannelController>{};

  /// The next id to use for a local virtual channel.
  ///
  /// Ids are used to identify virtual channels. Each message is tagged with an
  /// id; the receiving [MultiChannel] uses this id to look up which
  /// [VirtualChannel] the message should be dispatched to.
  ///
  /// The id scheme for virtual channels is somewhat complicated. This is
  /// necessary to ensure that there are no conflicts even when both endpoints
  /// have virtual channels with the same id; since both endpoints can send and
  /// receive messages across each virtual channel, a naïve scheme would make it
  /// impossible to tell whether a message was from a channel that originated in
  /// the remote endpoint or a reply on a channel that originated in the local
  /// endpoint.
  ///
  /// The trick is that each endpoint only uses odd ids for its own channels.
  /// When sending a message over a channel that was created by the remote
  /// endpoint, the channel's id plus one is used. This way each [MultiChannel]
  /// knows that if an incoming message has an odd id, it's using the local id
  /// scheme, but if it has an even id, it's using the remote id scheme.
  var _nextId = 1;

  _MultiChannel(this._inner) {
    // The default connection is a special case which has id 0 on both ends.
    // This allows it to begin connected without having to send over an id.
    _controllers[0] = _mainController;
    _mainController.local.stream.listen(
        (message) => _inner.sink.add([0, message]),
        onDone: () => _closeChannel(0, 0));

    _innerStreamSubscription = _inner.stream.listen((message) {
      var id = message[0];
      var controller = _controllers[id];

      // A controller might not exist if the channel was closed before an
      // incoming message was processed.
      if (controller == null) return;
      if (message.length > 1) {
        controller.local.sink.add(message[1]);
        return;
      }

      // A message without data indicates that the channel has been closed. We
      // can only close the sink here without doing any more cleanup, because
      // the sink closing will cause the stream to emit a done event which will
      // trigger more cleanup.
      controller.local.sink.close();
    },
        onDone: _closeInnerChannel,
        onError: _mainController.local.sink.addError);
  }

  VirtualChannel virtualChannel([id]) {
    var inputId;
    var outputId;
    if (id != null) {
      // Since the user is passing in an id, we're connected to a remote
      // VirtualChannel. This means messages they send over this channel will
      // have the original odd id, but our replies will have an even id.
      inputId = id;
      outputId = (id as int) + 1;
    } else {
      // Since we're generating an id, we originated this VirtualChannel. This
      // means messages we send over this channel will have the original odd id,
      // but the remote channel's replies will have an even id.
      inputId = _nextId + 1;
      outputId = _nextId;
      _nextId += 2;
    }

    // If the inner channel has already closed, create new virtual channels in a
    // closed state.
    if (_inner == null) {
      return new VirtualChannel._(
          this, inputId, new Stream.empty(), new NullStreamSink());
    }

    if (_controllers.containsKey(inputId)) {
      throw new ArgumentError("A virtual channel with id $id already exists.");
    }

    var controller = new StreamChannelController(sync: true);
    _controllers[inputId] = controller;
    controller.local.stream.listen(
        (message) => _inner.sink.add([outputId, message]),
        onDone: () => _closeChannel(inputId, outputId));

    return new VirtualChannel._(
        this, outputId, controller.foreign.stream, controller.foreign.sink);
  }

  /// Closes the virtual channel for which incoming messages have [inputId] and
  /// outgoing messages have [outputId].
  void _closeChannel(int inputId, int outputId) {
    var controller = _controllers.remove(inputId);
    controller.local.sink.close();

    if (_inner == null) return;

    // A message without data indicates that the virtual channel has been
    // closed.
    _inner.sink.add([outputId]);
    if (_controllers.isEmpty) _closeInnerChannel();
  }

  /// Closes the underlying communication channel.
  void _closeInnerChannel() {
    _inner.sink.close();
    _innerStreamSubscription.cancel();
    _inner = null;

    // Convert this to a list because the close is dispatched synchronously, and
    // that could conceivably remove a controller from [_controllers].
    for (var controller in new List.from(_controllers.values)) {
      controller.local.sink.close();
    }
    _controllers.clear();
  }
}

/// A virtual channel created by [MultiChannel].
///
/// This implements [MultiChannel] for convenience.
/// [VirtualChannel.virtualChannel] is semantically identical to the parent's
/// [MultiChannel.virtualChannel].
class VirtualChannel extends StreamChannelMixin implements MultiChannel {
  /// The [MultiChannel] that created this.
  final MultiChannel _parent;

  /// The identifier for this channel.
  ///
  /// This can be sent across the [MultiChannel] to provide the remote endpoint
  /// a means to connect to this channel. Nothing about this is guaranteed
  /// except that it will be JSON-serializable.
  final id;

  final Stream stream;
  final StreamSink sink;

  VirtualChannel._(this._parent, this.id, this.stream, this.sink);

  VirtualChannel virtualChannel([id]) => _parent.virtualChannel(id);
}
