// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'from_handlers.dart';

/// Creates a StreamTransformer which only emits once per [duration], at the
/// end of the period.
///
/// Always introduces a delay of at most [duration].
///
/// Differs from `throttle` in that it always emits the most recently received
/// event rather than the first in the period.
///
/// Differs from `debounce` in that a value will always be emitted after
/// [duration], the output will not be starved by values coming in repeatedly
/// within [duration].
StreamTransformer<T, T> audit<T>(Duration duration) {
  Timer timer;
  bool shouldClose = false;
  T recentData;

  return fromHandlers(handleData: (T data, EventSink<T> sink) {
    recentData = data;
    timer ??= new Timer(duration, () {
      sink.add(recentData);
      timer = null;
      if (shouldClose) {
        sink.close();
      }
    });
  }, handleDone: (EventSink<T> sink) {
    if (timer != null) {
      shouldClose = true;
    } else {
      sink.close();
    }
  });
}
