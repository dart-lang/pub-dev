// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Simple delegating wrapper around an [EventSink].
///
/// Subclasses can override individual methods, or use this to expose only the
/// [EventSink] methods of a subclass.
class DelegatingEventSink<T> implements EventSink<T> {
  final EventSink _sink;

  /// Create a delegating sink forwarding calls to [sink].
  DelegatingEventSink(EventSink<T> sink) : _sink = sink;

  DelegatingEventSink._(this._sink);

  /// Creates a wrapper that coerces the type of [sink].
  ///
  /// Unlike [new DelegatingEventSink], this only requires its argument to be an
  /// instance of `EventSink`, not `EventSink<T>`. This means that calls to
  /// [add] may throw a [CastError] if the argument type doesn't match the
  /// reified type of [sink].
  static EventSink<T> typed<T>(EventSink sink) =>
      sink is EventSink<T> ? sink : new DelegatingEventSink._(sink);

  void add(T data) {
    _sink.add(data);
  }

  void addError(error, [StackTrace stackTrace]) {
    _sink.addError(error, stackTrace);
  }

  void close() {
    _sink.close();
  }
}
