// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'from_handlers.dart';

/// Like [Stream.where] but allows the [test] to return a [Future].
StreamTransformer<T, T> asyncWhere<T>(FutureOr<bool> test(T element)) {
  var valuesWaiting = 0;
  var sourceDone = false;
  return fromHandlers(handleData: (element, sink) {
    valuesWaiting++;
    () async {
      if (await test(element)) sink.add(element);
      valuesWaiting--;
      if (valuesWaiting <= 0 && sourceDone) sink.close();
    }();
  }, handleDone: (sink) {
    sourceDone = true;
    if (valuesWaiting <= 0) sink.close();
  });
}
