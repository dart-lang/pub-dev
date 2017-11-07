// Copyright 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';

/// A shared singleton instance of `dart:io`'s [stdin] stream.
///
/// _Unlike_ the normal [stdin] stream, [sharedStdIn] may switch subscribers
/// as long as the previous subscriber cancels before the new subscriber starts
/// listening.
///
/// [SharedStdIn.terminate] *must* be invoked in order to close the underlying
/// connection to [stdin], allowing your program to close automatically without
/// hanging.
final SharedStdIn sharedStdIn = new SharedStdIn(stdin);

/// A singleton wrapper around `stdin` that allows new subscribers.
///
/// This class is visible in order to be used as a test harness for mock
/// implementations of `stdin`. In normal programs, [sharedStdIn] should be
/// used directly.
@visibleForTesting
class SharedStdIn extends Stream<List<int>> {
  StreamController<List<int>> _current;
  StreamSubscription<List<int>> _sub;

  SharedStdIn([Stream<List<int>> stream]) {
    _sub = (stream ??= stdin).listen(_onInput);
  }

  void _onInput(List<int> event) => _getCurrent().add(event);

  StreamController<List<int>> _getCurrent() {
    if (_current == null) {
      _current = new StreamController<List<int>>(
          onCancel: () {
            _current = null;
          },
          sync: true);
    }
    return _current;
  }

  @override
  StreamSubscription<List<int>> listen(
    void onData(List<int> event), {
    Function onError,
    void onDone(),
    bool cancelOnError,
  }) {
    if (_sub == null) {
      throw new StateError('Stdin has already been terminated.');
    }
    final controller = _getCurrent();
    if (controller.hasListener) {
      throw new StateError(''
          'Subscriber already listening. The existing subscriber must cancel '
          'before another may be added.');
    }
    return controller.stream.listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }

  /// Terminates the connection to `stdin`, closing all subscription.
  Future<Null> terminate() async {
    if (_sub == null) {
      throw new StateError('Stdin has already been terminated.');
    }
    await _sub.cancel();
    await _current?.close();
    _sub = null;
  }
}
