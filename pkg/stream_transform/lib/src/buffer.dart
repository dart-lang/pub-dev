// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

/// Creates a [StreamTransformer] which collects values and emits when it sees a
/// value on [trigger].
///
/// If there are no pending values when [trigger] emits, the next value on the
/// source Stream will immediately flow through. Otherwise, the pending values
/// are released when [trigger] emits.
///
/// Errors from the source stream or the trigger are immediately forwarded to
/// the output.
StreamTransformer<T, List<T>> buffer<T>(Stream trigger) => new _Buffer(trigger);

/// A StreamTransformer which aggregates values and emits when it sees a value
/// on [_trigger].
///
/// If there are no pending values when [_trigger] emits the first value on the
/// source Stream will immediately flow through. Otherwise, the pending values
/// and released when [_trigger] emits.
///
/// Errors from the source stream or the trigger are immediately forwarded to
/// the output.
class _Buffer<T> implements StreamTransformer<T, List<T>> {
  final Stream _trigger;

  _Buffer(this._trigger);

  @override
  Stream<List<T>> bind(Stream<T> values) {
    var controller = values.isBroadcast
        ? new StreamController<List<T>>.broadcast(sync: true)
        : new StreamController<List<T>>(sync: true);

    List<T> currentResults;
    bool waitingForTrigger = true;
    bool isTriggerDone = false;
    bool isValueDone = false;
    StreamSubscription valueSub;
    StreamSubscription triggerSub;

    emit() {
      controller.add(currentResults);
      currentResults = null;
      waitingForTrigger = true;
    }

    onValue(T value) {
      (currentResults ??= <T>[]).add(value);

      if (!waitingForTrigger) emit();

      if (isTriggerDone) {
        valueSub.cancel();
        controller.close();
      }
    }

    onValuesDone() {
      isValueDone = true;
      if (currentResults == null) {
        triggerSub?.cancel();
        controller.close();
      }
    }

    onTrigger(_) {
      waitingForTrigger = false;

      if (currentResults != null) emit();

      if (isValueDone) {
        triggerSub.cancel();
        controller.close();
      }
    }

    onTriggerDone() {
      isTriggerDone = true;
      if (waitingForTrigger) {
        valueSub?.cancel();
        controller.close();
      }
    }

    controller.onListen = () {
      if (valueSub != null) return;
      valueSub = values.listen(onValue,
          onError: controller.addError, onDone: onValuesDone);
      if (triggerSub != null) {
        if (triggerSub.isPaused) triggerSub.resume();
      } else {
        triggerSub = _trigger.listen(onTrigger,
            onError: controller.addError, onDone: onTriggerDone);
      }
      if (!values.isBroadcast) {
        controller.onPause = () {
          valueSub?.pause();
          triggerSub?.pause();
        };
        controller.onResume = () {
          valueSub?.resume();
          triggerSub?.resume();
        };
      }
      controller.onCancel = () {
        var toCancel = <StreamSubscription>[];
        if (!isValueDone) toCancel.add(valueSub);
        valueSub = null;
        if (_trigger.isBroadcast || !values.isBroadcast) {
          if (!isTriggerDone) toCancel.add(triggerSub);
          triggerSub = null;
        } else {
          triggerSub.pause();
        }
        if (toCancel.isEmpty) return null;
        return Future.wait(toCancel.map((s) => s.cancel()));
      };
    };
    return controller.stream;
  }
}
