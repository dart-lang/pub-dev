// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';

import '../stream_channel.dart';
import 'transformer/typed.dart';

/// A [StreamChannelTransformer] transforms the events being passed to and
/// emitted by a [StreamChannel].
///
/// This works on the same principle as [StreamTransformer] and
/// [StreamSinkTransformer]. Each transformer defines a [bind] method that takes
/// in the original [StreamChannel] and returns the transformed version.
///
/// Transformers must be able to have [bind] called multiple times. If a
/// subclass implements [bind] explicitly, it should be sure that the returned
/// stream follows the second stream channel guarantee: closing the sink causes
/// the stream to close before it emits any more events. This guarantee is
/// invalidated when an asynchronous gap is added between the original stream's
/// event dispatch and the returned stream's, for example by transforming it
/// with a [StreamTransformer]. The guarantee can be easily preserved using [new
/// StreamChannel.withCloseGuarantee].
class StreamChannelTransformer<S, T> {
  /// The transformer to use on the channel's stream.
  final StreamTransformer<T, S> _streamTransformer;

  /// The transformer to use on the channel's sink.
  final StreamSinkTransformer<S, T> _sinkTransformer;

  /// Creates a wrapper that coerces the type of [transformer].
  ///
  /// This soundly converts a [StreamChannelTransformer] to a
  /// `StreamChannelTransformer<S, T>`, regardless of its original generic type,
  /// by asserting that the events emitted by the transformed channel's stream
  /// are instances of `T` whenever they're provided. If they're not, the stream
  /// throws a [CastError]. This also means that calls to [StreamSink.add] on
  /// the transformed channel's sink may throw a [CastError] if the argument
  /// type doesn't match the reified type of the sink.
  static StreamChannelTransformer<S, T> typed<S, T>(
          StreamChannelTransformer transformer) =>
      transformer is StreamChannelTransformer<S, T>
          ? transformer
          : new TypeSafeStreamChannelTransformer(transformer);

  /// Creates a [StreamChannelTransformer] from existing stream and sink
  /// transformers.
  const StreamChannelTransformer(
      this._streamTransformer, this._sinkTransformer);

  /// Creates a [StreamChannelTransformer] from a codec's encoder and decoder.
  ///
  /// All input to the inner channel's sink is encoded using [Codec.encoder],
  /// and all output from its stream is decoded using [Codec.decoder].
  StreamChannelTransformer.fromCodec(Codec<S, T> codec)
      : this(
            typedStreamTransformer(codec.decoder),
            StreamSinkTransformer.typed(
                new StreamSinkTransformer.fromStreamTransformer(
                    codec.encoder)));

  /// Transforms the events sent to and emitted by [channel].
  ///
  /// Creates a new channel. When events are passed to the returned channel's
  /// sink, the transformer will transform them and pass the transformed
  /// versions to `channel.sink`. When events are emitted from the
  /// `channel.straem`, the transformer will transform them and pass the
  /// transformed versions to the returned channel's stream.
  StreamChannel<S> bind(StreamChannel<T> channel) =>
      new StreamChannel<S>.withCloseGuarantee(
          channel.stream.transform(_streamTransformer),
          _sinkTransformer.bind(channel.sink));
}
