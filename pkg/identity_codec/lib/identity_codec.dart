// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

class _IdentityConverter<T> extends Converter<T, T> {
  @override
  T convert(T input) => input;
}

/// A [Codec] that converts from T to T doing absolutely nothing.
///
/// This is the identity codec, the one that passes input to output when
/// decoding and encoding. This codec is mostly useful when implementing generic
/// code that can be fused with a [Codec] and you need an identity codec for the
/// base case.
///
/// Note, that when fused with another [Codec] the identity codec disppears.
class IdentityCodec<T> extends Codec<T, T> {
  const IdentityCodec();

  @override
  Converter<T, T> get decoder => _IdentityConverter();
  @override
  Converter<T, T> get encoder => _IdentityConverter();

  /// Fuse with an other codec.
  ///
  /// This will return the [other] codec, as the identity codec is trivial.
  @override
  Codec<T, R> fuse<R>(Codec<T, R> other) => other;
}
