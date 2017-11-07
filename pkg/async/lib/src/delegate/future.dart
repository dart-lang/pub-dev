// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../typed/future.dart';

/// A wrapper that forwards calls to a [Future].
class DelegatingFuture<T> implements Future<T> {
  /// The wrapped [Future].
  final Future<T> _future;

  DelegatingFuture(this._future);

  /// Creates a wrapper which throws if [future]'s value isn't an instance of
  /// `T`.
  ///
  /// This soundly converts a [Future] to a `Future<T>`, regardless of its
  /// original generic type, by asserting that its value is an instance of `T`
  /// whenever it's provided. If it's not, the future throws a [CastError].
  static Future<T> typed<T>(Future future) =>
      future is Future<T> ? future : new TypeSafeFuture<T>(future);

  Stream<T> asStream() => _future.asStream();

  Future<T> catchError(Function onError, {bool test(Object error)}) =>
      _future.catchError(onError, test: test);

  Future<S> then<S>(FutureOr<S> onValue(T value), {Function onError}) =>
      _future.then(onValue, onError: onError);

  Future<T> whenComplete(action()) => _future.whenComplete(action);

  Future<T> timeout(Duration timeLimit, {onTimeout()}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);
}
