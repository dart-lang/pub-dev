// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// A class that counts outstanding callbacks for a test and fires a future once
/// they reach zero.
///
/// The outstanding callback count automatically starts at 1.
class OutstandingCallbackCounter {
  /// The number of outstanding callbacks.
  var _count = 1;

  /// A future that fires when the oustanding callback count reaches 0.
  Future get noOutstandingCallbacks => _completer.future;
  final _completer = new Completer();

  /// Adds an outstanding callback.
  void addOutstandingCallback() {
    _count++;
  }

  /// Removes an outstanding callback.
  void removeOutstandingCallback() {
    _count--;
    if (_count != 0) return;
    if (_completer.isCompleted) return;
    _completer.complete();
  }

  /// Removes all outstanding callbacks, forcing [noOutstandingCallbacks] to
  /// fire.
  ///
  /// Future calls to [addOutstandingCallback] and [removeOutstandingCallback]
  /// will be ignored.
  void removeAllOutstandingCallbacks() {
    if (!_completer.isCompleted) _completer.complete();
  }
}
