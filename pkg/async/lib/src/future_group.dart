// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// A collection of futures waits until all added [Future]s complete.
///
/// Futures are added to the group with [add]. Once you're finished adding
/// futures, signal that by calling [close]. Then, once all added futures have
/// completed, [future] will complete with a list of values from the futures in
/// the group, in the order they were added.
///
/// If any added future completes with an error, [future] will emit that error
/// and the group will be closed, regardless of the state of other futures in
/// the group.
///
/// This is similar to [Future.wait] with `eagerError` set to `true`, except
/// that a [FutureGroup] can have futures added gradually over time rather than
/// needing them all at once.
class FutureGroup<T> implements Sink<Future<T>> {
  /// The number of futures that have yet to complete.
  var _pending = 0;

  /// Whether [close] has been called.
  var _closed = false;

  /// The future that fires once [close] has been called and all futures in the
  /// group have completed.
  ///
  /// This will also complete with an error if any of the futures in the group
  /// fails, regardless of whether [close] was called.
  Future<List<T>> get future => _completer.future;
  final _completer = new Completer<List<T>>();

  /// Whether this group has no pending futures.
  bool get isIdle => _pending == 0;

  /// A broadcast stream that emits a `null` event whenever the last pending
  /// future in this group completes.
  ///
  /// Once this group isn't waiting on any futures *and* [close] has been
  /// called, this stream will close.
  Stream get onIdle {
    if (_onIdleController == null) {
      _onIdleController = new StreamController.broadcast(sync: true);
    }
    return _onIdleController.stream;
  }

  StreamController _onIdleController;

  /// The values emitted by the futures that have been added to the group, in
  /// the order they were added.
  ///
  /// The slots for futures that haven't completed yet are `null`.
  final _values = new List<T>();

  /// Wait for [task] to complete.
  void add(Future<T> task) {
    if (_closed) throw new StateError("The FutureGroup is closed.");

    // Ensure that future values are put into [values] in the same order they're
    // added to the group by pre-allocating a slot for them and recording its
    // index.
    var index = _values.length;
    _values.add(null);

    _pending++;
    task.then((value) {
      if (_completer.isCompleted) return null;

      _pending--;
      _values[index] = value;

      if (_pending != 0) return null;
      if (_onIdleController != null) _onIdleController.add(null);

      if (!_closed) return null;
      if (_onIdleController != null) _onIdleController.close();
      _completer.complete(_values);
    }).catchError((error, stackTrace) {
      if (_completer.isCompleted) return null;
      _completer.completeError(error, stackTrace);
    });
  }

  /// Signals to the group that the caller is done adding futures, and so
  /// [future] should fire once all added futures have completed.
  void close() {
    _closed = true;
    if (_pending != 0) return;
    if (_completer.isCompleted) return;
    _completer.complete(_values);
  }
}
