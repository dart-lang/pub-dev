// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Simple delegating wrapper around a [StreamConsumer].
///
/// Subclasses can override individual methods, or use this to expose only the
/// [StreamConsumer] methods of a subclass.
class DelegatingStreamConsumer<T> implements StreamConsumer<T> {
  final StreamConsumer _consumer;

  /// Create a delegating consumer forwarding calls to [consumer].
  DelegatingStreamConsumer(StreamConsumer<T> consumer) : _consumer = consumer;

  DelegatingStreamConsumer._(this._consumer);

  /// Creates a wrapper that coerces the type of [consumer].
  ///
  /// Unlike [new StreamConsumer], this only requires its argument to be an
  /// instance of `StreamConsumer`, not `StreamConsumer<T>`. This means that
  /// calls to [addStream] may throw a [CastError] if the argument type doesn't
  /// match the reified type of [consumer].
  static StreamConsumer<T> typed<T>(StreamConsumer consumer) =>
      consumer is StreamConsumer<T>
          ? consumer
          : new DelegatingStreamConsumer._(consumer);

  Future addStream(Stream<T> stream) => _consumer.addStream(stream);

  Future close() => _consumer.close();
}
