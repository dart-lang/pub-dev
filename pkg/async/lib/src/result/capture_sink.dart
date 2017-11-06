// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../result.dart';

/// Use [Result.captureSinkTransformer].
@Deprecated("Will be removed in async 2.0.0.")
class CaptureSink<T> implements EventSink<T> {
  final EventSink _sink;

  CaptureSink(EventSink<Result<T>> sink) : _sink = sink;

  void add(T value) {
    _sink.add(new Result.value(value));
  }

  void addError(Object error, [StackTrace stackTrace]) {
    _sink.add(new Result.error(error, stackTrace));
  }

  void close() {
    _sink.close();
  }
}
