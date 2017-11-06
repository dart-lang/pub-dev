// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../stream_sink_transformer.dart';
import '../delegate/stream_sink.dart';

/// The type of the callback for handling data events.
typedef void HandleData<S, T>(S data, EventSink<T> sink);

/// The type of the callback for handling error events.
typedef void HandleError<T>(
    Object error, StackTrace stackTrace, EventSink<T> sink);

/// The type of the callback for handling done events.
typedef void HandleDone<T>(EventSink<T> sink);

/// A [StreamSinkTransformer] that delegates events to the given handlers.
class HandlerTransformer<S, T> implements StreamSinkTransformer<S, T> {
  /// The handler for data events.
  final HandleData<S, T> _handleData;

  /// The handler for error events.
  final HandleError<T> _handleError;

  /// The handler for done events.
  final HandleDone<T> _handleDone;

  HandlerTransformer(this._handleData, this._handleError, this._handleDone);

  StreamSink<S> bind(StreamSink<T> sink) => new _HandlerSink<S, T>(this, sink);
}

/// A sink created by [HandlerTransformer].
class _HandlerSink<S, T> implements StreamSink<S> {
  /// The transformer that created this sink.
  final HandlerTransformer<S, T> _transformer;

  /// The original sink that's being transformed.
  final StreamSink<T> _inner;

  /// The wrapper for [_inner] whose [StreamSink.close] method can't emit
  /// errors.
  final StreamSink<T> _safeCloseInner;

  Future get done => _inner.done;

  _HandlerSink(this._transformer, StreamSink<T> inner)
      : _inner = inner,
        _safeCloseInner = new _SafeCloseSink<T>(inner);

  void add(S event) {
    if (_transformer._handleData == null) {
      _inner.add(event as T);
    } else {
      _transformer._handleData(event, _safeCloseInner);
    }
  }

  void addError(error, [StackTrace stackTrace]) {
    if (_transformer._handleError == null) {
      _inner.addError(error, stackTrace);
    } else {
      _transformer._handleError(error, stackTrace, _safeCloseInner);
    }
  }

  Future addStream(Stream<S> stream) {
    return _inner.addStream(stream.transform(
        new StreamTransformer<S, T>.fromHandlers(
            handleData: _transformer._handleData,
            handleError: _transformer._handleError,
            handleDone: _closeSink)));
  }

  Future close() {
    if (_transformer._handleDone == null) return _inner.close();

    _transformer._handleDone(_safeCloseInner);
    return _inner.done;
  }
}

/// A wrapper for [StreamSink]s that swallows any errors returned by [close].
///
/// [HandlerTransformer] passes this to its handlers to ensure that when they
/// call [close], they don't leave any dangling [Future]s behind that might emit
/// unhandleable errors.
class _SafeCloseSink<T> extends DelegatingStreamSink<T> {
  _SafeCloseSink(StreamSink<T> inner) : super(inner);

  Future close() => super.close().catchError((_) {});
}

/// A function to pass as a [StreamTransformer]'s `handleDone` callback.
void _closeSink(EventSink sink) {
  sink.close();
}
