// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'from_handlers.dart';

/// Taps into a Stream to allow additional handling on a single-subscriber
/// stream without first wrapping as a broadcast stream.
///
/// The callback will be called with every value from the stream before it is
/// forwarded to listeners on the stream. Errors from the callbacks are ignored.
///
/// The tapped stream may not emit any values until the result stream has a
/// listener, and may be canceled only by the listener.
StreamTransformer<T, T> tap<T>(void fn(T value),
        {void onError(error, stackTrace), void onDone()}) =>
    fromHandlers(handleData: (value, sink) {
      try {
        fn(value);
      } catch (_) {/*Ignore*/}
      sink.add(value);
    }, handleError: (error, stackTrace, sink) {
      try {
        onError?.call(error, stackTrace);
      } catch (_) {/*Ignore*/}
      sink.addError(error, stackTrace);
    }, handleDone: (sink) {
      try {
        onDone?.call();
      } catch (_) {/*Ignore*/}
      sink.close();
    });
