// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';

import 'utils.dart';

/// An asynchronous operation that can be cancelled.
///
/// The value of this operation is exposed as [value]. When this operation is
/// cancelled, [value] won't complete either successfully or with an error. If
/// [value] has already completed, cancelling the operation does nothing.
class CancelableOperation<T> {
  /// The completer that produced this operation.
  ///
  /// This is canceled when [cancel] is called.
  final CancelableCompleter<T> _completer;

  CancelableOperation._(this._completer);

  /// Creates a [CancelableOperation] wrapping [inner].
  ///
  /// When this operation is canceled, [onCancel] will be called and any value
  /// or error produced by [inner] will be discarded. If [onCancel] returns a
  /// [Future], it will be forwarded to [cancel].
  ///
  /// [onCancel] will be called synchronously when the operation is canceled.
  /// It's guaranteed to only be called once.
  factory CancelableOperation.fromFuture(Future<T> inner,
      {FutureOr onCancel()}) {
    var completer = new CancelableCompleter<T>(onCancel: onCancel);
    completer.complete(inner);
    return completer.operation;
  }

  /// The value returned by the operation.
  Future<T> get value => _completer._inner.future;

  /// Creates a [Stream] containing the result of this operation.
  ///
  /// This is like `value.asStream()`, but if a subscription to the stream is
  /// canceled, this is as well.
  Stream<T> asStream() {
    var controller =
        new StreamController<T>(sync: true, onCancel: _completer._cancel);

    value.then((value) {
      controller.add(value);
      controller.close();
    }, onError: (error, stackTrace) {
      controller.addError(error, stackTrace);
      controller.close();
    });
    return controller.stream;
  }

  /// Creates a [Future] that completes when this operation completes *or* when
  /// it's cancelled.
  ///
  /// If this operation completes, this completes to the same result as [value].
  /// If this operation is cancelled, the returned future waits for the future
  /// returned by [cancel], then completes to [cancellationValue].
  Future valueOrCancellation([T cancellationValue]) {
    var completer = new Completer<T>.sync();
    value.then((result) => completer.complete(result),
        onError: completer.completeError);

    _completer._cancelMemo.future.then((_) {
      completer.complete(cancellationValue);
    }, onError: completer.completeError);

    return completer.future;
  }

  /// Cancels this operation.
  ///
  /// This returns the [Future] returned by the [CancelableCompleter]'s
  /// `onCancel` callback. Unlike [Stream.cancel], it never returns `null`.
  Future cancel() => _completer._cancel();
}

/// A completer for a [CancelableOperation].
class CancelableCompleter<T> {
  /// The completer for the wrapped future.
  final Completer<T> _inner;

  /// The callback to call if the future is canceled.
  final FutureOrCallback _onCancel;

  /// Creates a new completer for a [CancelableOperation].
  ///
  /// When the future operation canceled, as long as the completer hasn't yet
  /// completed, [onCancel] is called. If [onCancel] returns a [Future], it's
  /// forwarded to [CancelableOperation.cancel].
  ///
  /// [onCancel] will be called synchronously when the operation is canceled.
  /// It's guaranteed to only be called once.
  CancelableCompleter({FutureOr onCancel()})
      : _onCancel = onCancel,
        _inner = new Completer<T>() {
    _operation = new CancelableOperation<T>._(this);
  }

  /// The operation controlled by this completer.
  CancelableOperation<T> get operation => _operation;
  CancelableOperation<T> _operation;

  /// Whether the completer has completed.
  bool get isCompleted => _isCompleted;
  bool _isCompleted = false;

  /// Whether the completer was canceled before being completed.
  bool get isCanceled => _isCanceled;
  bool _isCanceled = false;

  /// The memoizer for [_cancel].
  final _cancelMemo = new AsyncMemoizer();

  /// Completes [operation] to [value].
  ///
  /// If [value] is a [Future], this will complete to the result of that
  /// [Future] once it completes.
  void complete([value]) {
    if (_isCompleted) throw new StateError("Operation already completed");
    _isCompleted = true;

    if (value is! Future) {
      if (_isCanceled) return;
      _inner.complete(value);
      return;
    }

    if (_isCanceled) {
      // Make sure errors from [value] aren't top-leveled.
      value.catchError((_) {});
      return;
    }

    value.then((result) {
      if (_isCanceled) return;
      _inner.complete(result);
    }, onError: (error, stackTrace) {
      if (_isCanceled) return;
      _inner.completeError(error, stackTrace);
    });
  }

  /// Completes [operation] to [error].
  void completeError(Object error, [StackTrace stackTrace]) {
    if (_isCompleted) throw new StateError("Operation already completed");
    _isCompleted = true;

    if (_isCanceled) return;
    _inner.completeError(error, stackTrace);
  }

  /// Cancel the completer.
  Future _cancel() {
    if (_inner.isCompleted) return new Future.value();

    return _cancelMemo.runOnce(() {
      _isCanceled = true;
      if (_onCancel != null) return _onCancel();
    });
  }
}
