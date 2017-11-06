// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import "dart:async";

import "delegate/stream.dart";
import "stream_completer.dart";
import "utils.dart";

/// A [Stream] wrapper that forwards to another [Stream] that's initialized
/// lazily.
///
/// This class allows a concrete `Stream` to be created only once it has a
/// listener. It's useful to wrapping APIs that do expensive computation to
/// produce a `Stream`.
class LazyStream<T> extends Stream<T> {
  /// The callback that's called to create the inner stream.
  FutureOrCallback<Stream<T>> _callback;

  /// Creates a single-subscription `Stream` that calls [callback] when it gets
  /// a listener and forwards to the returned stream.
  LazyStream(FutureOr<Stream<T>> callback()) : _callback = callback {
    // Explicitly check for null because we null out [_callback] internally.
    if (_callback == null) throw new ArgumentError.notNull('callback');
  }

  StreamSubscription<T> listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    if (_callback == null) {
      throw new StateError("Stream has already been listened to.");
    }

    // Null out the callback before we invoke it to ensure that even while
    // running it, this can't be called twice.
    var callback = _callback;
    _callback = null;
    var result = callback();

    Stream<T> stream;
    if (result is Future<Stream<T>>) {
      stream = StreamCompleter.fromFuture(result.then((stream) {
        return DelegatingStream.typed<T>(stream);
      }));
    } else {
      stream = DelegatingStream.typed<T>(result as Stream);
    }

    return stream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
