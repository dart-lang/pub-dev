// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:async/async.dart';

import '../stream_channel.dart';
import 'stream_channel_transformer.dart';

/// The canonical instance of [JsonDocumentTransformer].
final jsonDocument = new JsonDocumentTransformer();

/// A [StreamChannelTransformer] that transforms JSON documents—strings that
/// contain individual objects encoded as JSON—into decoded Dart objects.
///
/// This decodes JSON that's emitted by the transformed channel's stream, and
/// encodes objects so that JSON is passed to the transformed channel's sink.
///
/// If the transformed channel emits invalid JSON, this emits a
/// [FormatException]. If an unencodable object is added to the sink, it
/// synchronously throws a [JsonUnsupportedObjectError].
class JsonDocumentTransformer
    implements StreamChannelTransformer<Object, String> {
  /// The underlying codec that implements the encoding and decoding logic.
  final JsonCodec _codec;

  /// Creates a new transformer.
  ///
  /// The [reviver] and [toEncodable] arguments work the same way as the
  /// corresponding arguments to [new JsonCodec].
  JsonDocumentTransformer({reviver(key, value), toEncodable(object)})
      : _codec = new JsonCodec(reviver: reviver, toEncodable: toEncodable);

  JsonDocumentTransformer._(this._codec);

  StreamChannel bind(StreamChannel<String> channel) {
    var stream = channel.stream.map(_codec.decode);
    var sink = new StreamSinkTransformer.fromHandlers(handleData: (data, sink) {
      sink.add(_codec.encode(data));
    }).bind(channel.sink);
    return new StreamChannel.withCloseGuarantee(stream, sink);
  }
}
