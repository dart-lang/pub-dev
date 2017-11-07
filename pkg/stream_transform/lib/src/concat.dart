// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Starts emitting values from [next] after the original stream is complete.
///
/// If the initial stream never finishes, the [next] stream will never be
/// listened to.
///
/// If a single-subscription is concatted to the end of a broadcast stream it
/// may be listened to and never canceled.
///
/// If a broadcast stream is concatted to any other stream it will miss any
/// events which occur before the first stream is done. If a broadcast stream is
/// concatted to a single-subscription stream, pausing the stream while it is
/// listening to the second stream will cause events to be dropped rather than
/// buffered.
StreamTransformer<T, T> concat<T>(Stream<T> next) => new _Concat<T>(next);

class _Concat<T> implements StreamTransformer<T, T> {
  final Stream _next;

  _Concat(this._next);

  @override
  Stream<T> bind(Stream<T> first) {
    var controller = first.isBroadcast
        ? new StreamController<T>.broadcast(sync: true)
        : new StreamController<T>(sync: true);

    var next = first.isBroadcast && !_next.isBroadcast
        ? _next.asBroadcastStream()
        : _next;

    StreamSubscription subscription;
    var currentStream = first;
    var firstDone = false;
    var secondDone = false;

    Function currentDoneHandler;

    listen() {
      subscription = currentStream.listen(controller.add,
          onError: controller.addError, onDone: () => currentDoneHandler());
    }

    onSecondDone() {
      secondDone = true;
      controller.close();
    }

    onFirstDone() {
      firstDone = true;
      currentStream = next;
      currentDoneHandler = onSecondDone;
      listen();
    }

    currentDoneHandler = onFirstDone;

    controller.onListen = () {
      if (subscription != null) return;
      listen();
      if (!first.isBroadcast) {
        controller.onPause = () {
          if (!firstDone || !next.isBroadcast) return subscription.pause();
          subscription.cancel();
          subscription = null;
        };
        controller.onResume = () {
          if (!firstDone || !next.isBroadcast) return subscription.resume();
          listen();
        };
      }
      controller.onCancel = () {
        if (secondDone) return null;
        var toCancel = subscription;
        subscription = null;
        return toCancel.cancel();
      };
    };
    return controller.stream;
  }
}
