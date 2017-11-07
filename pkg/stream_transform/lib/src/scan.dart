// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'bind.dart';

/// Scan is like fold, but instead of producing a single value it yields
/// each intermediate accumulation.
StreamTransformer<S, T> scan<S, T>(
        T initialValue, T combine(T previousValue, S element)) =>
    fromBind((stream) {
      T accumulated = initialValue;
      return stream.map((value) => accumulated = combine(accumulated, value));
    });
