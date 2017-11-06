// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../stream_sink_transformer.dart';

/// A [StreamSinkTransformer] that wraps a pre-existing [StreamTransformer].
class StreamTransformerWrapper<S, T> implements StreamSinkTransformer<S, T> {
  /// The wrapped transformer.
  final StreamTransformer<S, T> _transformer;

  const StreamTransformerWrapper(this._transformer);

  StreamSink<S> bind(StreamSink<T> sink) =>
      new _StreamTransformerWrapperSink<S, T>(_transformer, sink);
}

/// A sink created by [StreamTransformerWrapper].
class _StreamTransformerWrapperSink<S, T> implements StreamSink<S> {
  /// The controller through which events are passed.
  ///
  /// This is used to create a stream that can be transformed by the wrapped
  /// transformer.
  final _controller = new StreamController<S>(sync: true);

  /// The original sink that's being transformed.
  final StreamSink<T> _inner;

  Future get done => _inner.done;

  _StreamTransformerWrapperSink(
      StreamTransformer<S, T> transformer, this._inner) {
    _controller.stream
        .transform(transformer)
        .listen(_inner.add, onError: _inner.addError, onDone: () {
      // Ignore any errors that come from this call to [_inner.close]. The
      // user can access them through [done] or the value returned from
      // [this.close], and we don't want them to get top-leveled.
      _inner.close().catchError((_) {});
    });
  }

  void add(S event) {
    _controller.add(event);
  }

  void addError(error, [StackTrace stackTrace]) {
    _controller.addError(error, stackTrace);
  }

  Future addStream(Stream<S> stream) => _controller.addStream(stream);

  Future close() {
    _controller.close();
    return _inner.done;
  }
}
