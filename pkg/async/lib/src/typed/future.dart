// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

class TypeSafeFuture<T> implements Future<T> {
  final Future _future;

  TypeSafeFuture(this._future);

  Stream<T> asStream() => _future.then((value) => value as T).asStream();

  Future<T> catchError(Function onError, {bool test(Object error)}) async =>
      new TypeSafeFuture<T>(_future.catchError(onError, test: test));

  Future<S> then<S>(dynamic onValue(T value), {Function onError}) =>
      _future.then((value) => onValue(value as T), onError: onError);

  Future<T> whenComplete(action()) =>
      new TypeSafeFuture<T>(_future.whenComplete(action));

  Future<T> timeout(Duration timeLimit, {onTimeout()}) =>
      new TypeSafeFuture<T>(_future.timeout(timeLimit, onTimeout: onTimeout));
}
