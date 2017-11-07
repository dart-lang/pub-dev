// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'from_handlers.dart';

/// Creates a StreamTransformer which only emits once per [duration], at the
/// beginning of the period.
StreamTransformer<T, T> throttle<T>(Duration duration) {
  Timer timer;

  return fromHandlers(handleData: (data, sink) {
    if (timer == null) {
      sink.add(data);
      timer = new Timer(duration, () {
        timer = null;
      });
    }
  });
}
