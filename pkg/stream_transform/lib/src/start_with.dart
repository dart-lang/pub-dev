// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'bind.dart';
import 'concat.dart';

/// Emits [initial] before any values from the original stream.
///
/// If the original stream is a broadcast stream the result will be as well.
StreamTransformer<T, T> startWith<T>(T initial) =>
    startWithStream<T>(new Future.value(initial).asStream());

/// Emits all values in [initial] before any values from the original stream.
///
/// If the original stream is a broadcast stream the result will be as well. If
/// the original stream is a broadcast stream it will miss any events which
/// occur before the initial values are all emitted.
StreamTransformer<T, T> startWithMany<T>(Iterable<T> initial) =>
    startWithStream<T>(new Stream.fromIterable(initial));

/// Emits all values in [initial] before any values from the original stream.
///
/// If the original stream is a broadcast stream the result will be as well. If
/// the original stream is a broadcast stream it will miss any events which
/// occur before [initial] closes.
StreamTransformer<T, T> startWithStream<T>(Stream<T> initial) =>
    fromBind((values) {
      if (values.isBroadcast && !initial.isBroadcast) {
        initial = initial.asBroadcastStream();
      }
      return initial.transform(concat(values));
    });
