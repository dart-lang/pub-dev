// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../typed/stream_subscription.dart';

/// Simple delegating wrapper around a [StreamSubscription].
///
/// Subclasses can override individual methods.
class DelegatingStreamSubscription<T> implements StreamSubscription<T> {
  final StreamSubscription _source;

  /// Create delegating subscription forwarding calls to [sourceSubscription].
  DelegatingStreamSubscription(StreamSubscription<T> sourceSubscription)
      : _source = sourceSubscription;

  /// Creates a wrapper which throws if [subscription]'s events aren't instances
  /// of `T`.
  ///
  /// This soundly converts a [StreamSubscription] to a `StreamSubscription<T>`,
  /// regardless of its original generic type, by asserting that its events are
  /// instances of `T` whenever they're provided. If they're not, the
  /// subscription throws a [CastError].
  static StreamSubscription<T> typed<T>(StreamSubscription subscription) =>
      subscription is StreamSubscription<T>
          ? subscription
          : new TypeSafeStreamSubscription<T>(subscription);

  void onData(void handleData(T data)) {
    _source.onData(handleData);
  }

  void onError(Function handleError) {
    _source.onError(handleError);
  }

  void onDone(void handleDone()) {
    _source.onDone(handleDone);
  }

  void pause([Future resumeFuture]) {
    _source.pause(resumeFuture);
  }

  void resume() {
    _source.resume();
  }

  Future cancel() => _source.cancel();

  Future<E> asFuture<E>([E futureValue]) => _source.asFuture(futureValue);

  bool get isPaused => _source.isPaused;
}
