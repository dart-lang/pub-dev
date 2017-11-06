// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../result.dart';
import 'release_sink.dart';

/// Use [Result.releaseTransformer] instead.
@Deprecated("Will be removed in async 2.0.0.")
class ReleaseStreamTransformer<T> implements StreamTransformer<Result<T>, T> {
  const ReleaseStreamTransformer();

  Stream<T> bind(Stream<Result<T>> source) {
    return new Stream<T>.eventTransformed(source, _createSink);
  }

  static EventSink<Result> _createSink(EventSink sink) {
    return new ReleaseSink(sink);
  }
}
