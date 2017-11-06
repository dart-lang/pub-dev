// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

class TypeSafeStreamSubscription<T> implements StreamSubscription<T> {
  final StreamSubscription _subscription;

  bool get isPaused => _subscription.isPaused;

  TypeSafeStreamSubscription(this._subscription);

  void onData(void handleData(T data)) {
    _subscription.onData((data) => handleData(data as T));
  }

  void onError(Function handleError) {
    _subscription.onError(handleError);
  }

  void onDone(void handleDone()) {
    _subscription.onDone(handleDone);
  }

  void pause([Future resumeFuture]) {
    _subscription.pause(resumeFuture);
  }

  void resume() {
    _subscription.resume();
  }

  Future cancel() => _subscription.cancel();

  Future<E> asFuture<E>([E futureValue]) => _subscription.asFuture(futureValue);
}
