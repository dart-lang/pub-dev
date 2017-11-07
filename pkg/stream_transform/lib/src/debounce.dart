// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'from_handlers.dart';

/// Creates a StreamTransformer which only emits when the source stream does not
/// emit for [duration].
///
/// Source values will always be delayed by at least [duration], and values
/// which come within this time will replace the old values, only the most
/// recent value will be emitted.
StreamTransformer<T, T> debounce<T>(Duration duration) =>
    _debounceAggregate(duration, _dropPrevious);

/// Creates a StreamTransformer which collects values until the source stream
/// does not emit for [duration] then emits the collected values.
///
/// This differs from [debounce] in that values are aggregated instead of
/// skipped.
StreamTransformer<T, List<T>> debounceBuffer<T>(Duration duration) =>
    _debounceAggregate(duration, _collectToList);

List<T> _collectToList<T>(T element, List<T> soFar) {
  soFar ??= <T>[];
  soFar.add(element);
  return soFar;
}

T _dropPrevious<T>(T element, _) => element;

/// Creates a StreamTransformer which aggregates values until the source stream
/// does not emit for [duration], then emits the aggregated values.
StreamTransformer<T, R> _debounceAggregate<T, R>(
    Duration duration, R collect(T element, R soFar)) {
  Timer timer;
  R soFar;
  bool shouldClose = false;
  return fromHandlers(handleData: (T value, EventSink<R> sink) {
    timer?.cancel();
    timer = new Timer(duration, () {
      sink.add(soFar);
      if (shouldClose) {
        sink.close();
      }
      soFar = null;
      timer = null;
    });
    soFar = collect(value, soFar);
  }, handleDone: (EventSink<R> sink) {
    if (soFar != null) {
      shouldClose = true;
    } else {
      sink.close();
    }
  });
}
