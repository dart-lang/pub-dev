// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../stream_channel.dart';

/// A wrapper that coerces the generic type of the channel returned by an inner
/// transformer to `S`.
class TypeSafeStreamChannelTransformer<S, T>
    implements StreamChannelTransformer<S, T> {
  final StreamChannelTransformer _inner;

  TypeSafeStreamChannelTransformer(this._inner);

  StreamChannel<S> bind(StreamChannel<T> channel) =>
      _inner.bind(channel).cast();
}
