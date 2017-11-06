// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

/// Emits values from the source stream and [other] in any order as they arrive.
///
/// If the source stream is a broadcast stream, the result stream will be as
/// well, regardless of [other]'s type. If a single subscription stream is
/// merged into a broadcast stream it may never be canceled.
StreamTransformer<T, T> merge<T>(Stream<T> other) => new _Merge<T>([other]);

/// Emits values from the source stream and all streams in [others] in any order
/// as they arrive.
///
/// If the source stream is a broadcast stream, the result stream will be as
/// well, regardless of the types of streams in [others]. If single
/// subscription streams are merged into a broadcast stream they may never be
/// canceled.
StreamTransformer<T, T> mergeAll<T>(List<Stream<T>> others) =>
    new _Merge<T>(others);

class _Merge<T> implements StreamTransformer<T, T> {
  final List<Stream<T>> _others;

  _Merge(this._others);

  @override
  Stream<T> bind(Stream<T> first) {
    var controller = first.isBroadcast
        ? new StreamController<T>.broadcast(sync: true)
        : new StreamController<T>(sync: true);

    List<Stream<T>> allStreams = [first]..addAll(_others);
    if (first.isBroadcast) {
      allStreams = allStreams
          .map((s) => s.isBroadcast ? s : s.asBroadcastStream())
          .toList();
    }

    List<StreamSubscription> subscriptions;

    controller.onListen = () {
      if (subscriptions != null) return;
      var activeStreamCount = 0;
      subscriptions = allStreams.map((stream) {
        activeStreamCount++;
        return stream.listen(controller.add, onError: controller.addError,
            onDone: () {
          if (--activeStreamCount <= 0) controller.close();
        });
      }).toList();
      if (!first.isBroadcast) {
        controller.onPause = () {
          for (var subscription in subscriptions) {
            subscription.pause();
          }
        };
        controller.onResume = () {
          for (var subscription in subscriptions) {
            subscription.resume();
          }
        };
      }
      controller.onCancel = () {
        var toCancel = subscriptions;
        subscriptions = null;
        if (activeStreamCount <= 0) return null;
        return Future.wait(toCancel.map((s) => s.cancel()));
      };
    };
    return controller.stream;
  }
}
