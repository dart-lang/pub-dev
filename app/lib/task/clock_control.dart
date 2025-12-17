// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';

final _clockCtrlKey = #_clockCtrlKey;

Future<T> withClockControl<T>(
  FutureOr<T> Function(ClockController clockCtrl) fn, {
  DateTime? initialTime,
}) async {
  final now = clock.now();
  initialTime ??= now;

  final clockCtrl = ClockController._(clock.now, initialTime.difference(now));
  return await runZoned(
    () => withClock(
      Clock(clockCtrl._controlledTime),
      () async => await fn(clockCtrl),
    ),
    zoneValues: {_clockCtrlKey: clockCtrl},
  );
}

extension FutureTimeout<T> on Future<T> {
  /// Create a [Future] that will timeout after [timeLimit], and controllable
  /// by [ClockController].
  ///
  /// This is the same as [timeout], except [ClockController.elapse] will also
  /// trigger this timeout, but will not trigger [timeout].
  ///
  /// Use this if you need a timeout that will be fired when [clock] is advanced
  /// during testing. In production this should have no effect.
  Future<T> timeoutWithClock(
    Duration timeLimit, {
    FutureOr<T> Function()? onTimeout,
  }) {
    final clockCtrl = Zone.current[_clockCtrlKey];
    if (clockCtrl is ClockController) {
      final c = Completer<T>();
      final timer = clockCtrl._createTimer(timeLimit, () {
        if (!c.isCompleted) {
          if (onTimeout != null) {
            c.complete(onTimeout());
          } else {
            c.completeError(TimeoutException('Timeout exceeded', timeLimit));
          }
        }
      });
      scheduleMicrotask(() async {
        try {
          final value = await this;
          if (!c.isCompleted) {
            c.complete(value);
          }
        } catch (error, stackTrace) {
          if (!c.isCompleted) {
            c.completeError(error, stackTrace);
          }
        } finally {
          timer.cancel();
        }
      });
      return c.future;
    } else {
      return timeout(timeLimit, onTimeout: onTimeout);
    }
  }
}

extension ClockDelayed on Clock {
  /// Create a [Future] that is resolved after [delay], and controllable by
  /// [ClockController].
  ///
  /// This is the same as [Future.delayed], except [ClockController.elapse] will
  /// also resolve this future, but will not resolve [Future.delayed].
  ///
  /// Use this if you need a delay that will be fired when [clock] is advanced
  /// during testing. In production this should have no effect.
  Future<void> delayed(Duration delay) {
    final clockCtrl = Zone.current[_clockCtrlKey];
    if (clockCtrl is ClockController) {
      final c = Completer<void>();
      clockCtrl._createTimer(delay, c.complete);
      return c.future;
    } else {
      return Future.delayed(delay);
    }
  }
}

final class ClockController {
  final DateTime Function() _originalTime;
  Duration _offset;

  ClockController._(this._originalTime, this._offset);

  DateTime _controlledTime() => _originalTime().add(_offset);

  /// [PriorityQueue] of pending timers.
  ///
  /// **Invariant**, if the [_pendingTimers] is non-empty then a [Timer] for
  /// the [_TravelingTimer._elapsesAtInFakeTime] is scheduled and held in
  /// [_timerForFirstPendingTimer].
  final _pendingTimers = PriorityQueue<_TravelingTimer>(
    (t1, t2) =>
        t1._elapsesAtInFakeTime.microsecondsSinceEpoch -
        t2._elapsesAtInFakeTime.microsecondsSinceEpoch,
  );

  /// [Timer] created in [_TravelingTimer._zone] zone, for the first pending
  /// timer in [_pendingTimers].
  ///
  /// This value is `null` when [_pendingTimers] is empty.
  Timer? _timerForFirstPendingTimer;

  _TravelingTimer _createTimer(Duration duration, void Function() fn) {
    final timer = _TravelingTimer(
      owner: this,
      createdInControlledTime: _controlledTime(),
      zone: Zone.current,
      duration: duration,
      trigger: fn,
    );

    _pendingTimers.add(timer);

    // If the newly added [timer] is the first timer in the queue, then we have
    // to create a new [_timerForFirstPendingTimer] timer.
    if (_pendingTimers.first == timer) {
      _timerForFirstPendingTimer?.cancel();
      _timerForFirstPendingTimer = timer._zone.createTimer(
        timer._duration,
        _triggerPendingTimers,
      );
    }

    return timer;
  }

  /// This will cancel [_timerForFirstPendingTimer] if active, and trigger all
  /// [_pendingTimers] that are pending according to [_controlledTime].
  ///
  /// This will always create a new [Timer] for [_timerForFirstPendingTimer],
  /// recovering from any elapse of time, whether as a result of waiting for a
  /// [Timer] or as a result of jumping in time.
  void _triggerPendingTimers() {
    // Grab any actual timer, we'll cancel it later.
    final actualTimer = _timerForFirstPendingTimer;
    _timerForFirstPendingTimer = null;

    final controlledNow = _controlledTime();

    // Take all pending timers that are scheduled to be triggered now.
    // Notice that we take timers that are not after [controlledNow], that means
    // that if we move time forward to exactly the point in time where a timer
    // becomes we will trigger it.
    final triggeredTimers = <_TravelingTimer>[];
    while (_pendingTimers.isNotEmpty &&
        !_pendingTimers.first._elapsesAtInFakeTime.isAfter(controlledNow)) {
      triggeredTimers.add(_pendingTimers.removeFirst());
    }

    // Schedule the next actual timer, if [_pendingTimers] is not empty
    if (_pendingTimers.isNotEmpty) {
      final nextTimer = _pendingTimers.first;

      var delay = nextTimer._elapsesAtInFakeTime.difference(_controlledTime());
      if (delay.isNegative) {
        delay = Duration.zero;
      }

      _timerForFirstPendingTimer = nextTimer._zone.createTimer(
        delay,
        _triggerPendingTimers,
      );
    }

    // Cancel any actual timer. We do this after we've restored our invariant
    // because we don't know what this call can trigger. It really shouldn't
    // trigger changes in a child zone, but you never know what is going on.
    actualTimer?.cancel();

    // Trigger the callback for the pending timer.
    for (final triggeredTimer in triggeredTimers) {
      try {
        triggeredTimer._zone.runUnary(triggeredTimer._trigger, triggeredTimer);
      } catch (error, stackTrace) {
        // Documentation is unclear about whether or not an exception can be
        // thrown here.
        triggeredTimer._zone.handleUncaughtError(error, stackTrace);
      }
    }
  }

  void _cancelPendingTimer(_TravelingTimer timer) {
    if (_pendingTimers.isEmpty) {
      return;
    }

    // If the timer being cancelled is the next timer to run
    if (_pendingTimers.first == timer) {
      // Remove the timer, and cancel the actual timer.
      _pendingTimers.removeFirst();
      final actualTimer = _timerForFirstPendingTimer;

      // If there are more pending timers, then create a new actual timer.
      // This restores our invariant.
      if (_pendingTimers.isNotEmpty) {
        final nextTimer = _pendingTimers.first;

        var delay = nextTimer._elapsesAtInFakeTime.difference(
          _controlledTime(),
        );
        if (delay.isNegative) {
          delay = Duration.zero;
        }

        _timerForFirstPendingTimer = nextTimer._zone.createTimer(
          delay,
          _triggerPendingTimers,
        );
      }

      // Cancel any actual timer. We do this after we've restored our invariant
      // because we don't know what this call can trigger. It really shouldn't
      // trigger changes in a child zone, but you never know what is going on.
      actualTimer?.cancel();

      return;
    }

    // If [timer] isn't the next timer to run, then we just removed it.
    _pendingTimers.remove(timer);
  }

  void elapse({int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    _offset += Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  Future<void> elapseUntil(
    FutureOr<bool> Function() condition, {
    Duration? timeout,
    Duration? minimumStep,
  }) async {
    final deadline = timeout != null ? clock.fromNowBy(timeout) : null;

    bool shouldLoop() => deadline == null || clock.now().isBefore(deadline);

    while (shouldLoop()) {
      if (await condition()) {
        return;
      }
      _offset += minimumStep ?? Duration(minutes: 1);
    }
    throw TimeoutException(
      'Condition given to ClockController.incrUntil was not satisfied'
      ' before timeout: $timeout',
    );
  }
}

final class _TravelingTimer {
  /// [ClockController] to which this [_TravelingTimer] belongs.
  final ClockController _owner;

  /// [DateTime] when this [_TravelingTimer] was created in
  /// [ClockController._controlledTime].
  final DateTime _createdInControlledTime;

  /// Zone, for creation of timers.
  final Zone _zone;

  /// Duration for the timer to trigger.
  final Duration _duration;

  /// Callback to be invoked when this [_TravelingTimer] is triggered.
  final void Function(_TravelingTimer timer) _trigger;

  /// [DateTime] when this [_TravelingTimer] is supposed to be triggered,
  /// measured in [ClockController._controlledTime].
  DateTime get _elapsesAtInFakeTime => _createdInControlledTime.add(_duration);

  _TravelingTimer({
    required ClockController owner,
    required DateTime createdInControlledTime,
    required Zone zone,
    required Duration duration,
    required void Function() trigger,
  }) : _owner = owner,
       _createdInControlledTime = createdInControlledTime,
       _zone = zone,
       _duration = duration,
       _trigger = ((_) => trigger());

  void cancel() => _owner._cancelPendingTimer(this);
}
