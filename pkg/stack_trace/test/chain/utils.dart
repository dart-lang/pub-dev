// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

/// Runs [callback] in a microtask callback.
void inMicrotask(callback()) => scheduleMicrotask(callback);

/// Runs [callback] in a one-shot timer callback.
void inOneShotTimer(callback()) => Timer.run(callback);

/// Runs [callback] once in a periodic timer callback.
void inPeriodicTimer(callback()) {
  var count = 0;
  new Timer.periodic(new Duration(milliseconds: 1), (timer) {
    count++;
    if (count != 5) return;
    timer.cancel();
    callback();
  });
}

/// Runs [callback] within a long asynchronous Future chain.
void inFutureChain(callback()) {
  new Future(() {})
      .then((_) => new Future(() {}))
      .then((_) => new Future(() {}))
      .then((_) => new Future(() {}))
      .then((_) => new Future(() {}))
      .then((_) => callback())
      .then((_) => new Future(() {}));
}

void inNewFuture(callback()) {
  new Future(callback);
}

void inSyncFuture(callback()) {
  new Future.sync(callback);
}

/// Returns a Future that completes to an error using a completer.
///
/// If [trace] is passed, it's used as the stack trace for the error.
Future completerErrorFuture([StackTrace trace]) {
  var completer = new Completer();
  completer.completeError('error', trace);
  return completer.future;
}

/// Returns a Stream that emits an error using a controller.
///
/// If [trace] is passed, it's used as the stack trace for the error.
Stream controllerErrorStream([StackTrace trace]) {
  var controller = new StreamController();
  controller.addError('error', trace);
  return controller.stream;
}

/// Runs [callback] within [asyncFn], then converts any errors raised into a
/// [Chain] with [Chain.forTrace].
Future<Chain> chainForTrace(asyncFn(callback()), callback()) {
  var completer = new Completer();
  asyncFn(() {
    // We use `new Future.value().then(...)` here as opposed to [new Future] or
    // [new Future.sync] because those methods don't pass the exception through
    // the zone specification before propagating it, so there's no chance to
    // attach a chain to its stack trace. See issue 15105.
    new Future.value()
        .then((_) => callback())
        .catchError(completer.completeError);
  });

  // TODO(rnystrom): Remove this cast if catchError() gets a better type.
  return completer.future
          .catchError((_, stackTrace) => new Chain.forTrace(stackTrace))
      as Future<Chain>;
}

/// Runs [callback] in a [Chain.capture] zone and returns a Future that
/// completes to the stack chain for an error thrown by [callback].
///
/// [callback] is expected to throw the string `"error"`.
Future<Chain> captureFuture(callback()) {
  var completer = new Completer<Chain>();
  Chain.capture(callback, onError: (error, chain) {
    expect(error, equals('error'));
    completer.complete(chain);
  });
  return completer.future;
}
