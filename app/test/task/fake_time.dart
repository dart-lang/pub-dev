// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart' show sealed;

// TODO(jonasfj): Document this concept, maybe give it a better name and see if
//                we can publish it as a separate package. Maybe, it should be
//                called FakeClock instead, TimeMachine, or maybe Tardis, or
//                TimeTraveling.run((timeMachine) => timeMachine.travel(..))
//                Or something else clever, without being too clever!
//                Or maybe we should rename _TravelingTimer to _FakeTimer.

@sealed
abstract class FakeTime {
  FakeTime._();

  Future<void> elapse({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) =>
      elapseTime(Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds,
      ));

  void elapseSync({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) =>
      elapseTimeSync(Duration(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        milliseconds: milliseconds,
        microseconds: microseconds,
      ));

  Future<void> elapseTime(Duration duration);
  Future<void> elapseTo(DateTime futureTime);
  void elapseTimeSync(Duration duration);
  void elapseToSync(DateTime futureTime);

  /// Elapse fake time until [condition] returns `true`.
  ///
  /// Throws [TimeoutException], if [condition] is not satisfied with-in
  /// [timeout],
  Future<void> elapseUntil(
    FutureOr<bool> Function() condition, {
    Duration timeout,
    Duration minimumStep,
  });

  static Future<T> run<T>(
    FutureOr<T> Function(FakeTime fakeTime) fn, {
    DateTime? initialTime,
  }) async {
    final now = clock.now();
    initialTime ??= now;

    final tm = _FakeTime(clock.now, initialTime.difference(now));
    return await runZoned(
      () => withClock(Clock(tm._fakeTime), () async => await fn(tm)),
      zoneSpecification: ZoneSpecification(
        createTimer: tm._createTimer,
        createPeriodicTimer: tm._createPeriodicTimer,
        scheduleMicrotask: tm._scheduleMicrotask,
      ),
    );
  }
}

class _FakeTime extends FakeTime {
  final DateTime Function() _originalTime;
  Duration _offset;

  _FakeTime(
    this._originalTime,
    this._offset,
  ) : super._();

  DateTime _fakeTime() => _originalTime().add(_offset);

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

  /// [Timer] created in [_TravelingTimer._parent] zone, for the first pending
  /// timer in [_pendingTimers].
  ///
  /// This value is `null` when [_pendingTimers] is empty.
  Timer? _timerForFirstPendingTimer;

  Timer _createTimer(
    Zone self,
    ZoneDelegate parent,
    Zone zone,
    Duration duration,
    void Function() fn,
  ) {
    final timer = _TravelingTimer(
      owner: this,
      createdInFakeTime: _fakeTime(),
      parent: parent,
      zone: zone,
      duration: duration,
      trigger: fn,
    );

    _pendingTimers.add(timer);

    // If the newly added [timer] is the first timer in the queue, then we have
    // to create a new [_timerForFirstPendingTimer] timer.
    if (_pendingTimers.first == timer) {
      _timerForFirstPendingTimer?.cancel();
      _timerForFirstPendingTimer = timer._parent.createTimer(
        timer._zone,
        timer._duration,
        _triggerPendingTimers,
      );
    }

    return timer;
  }

  Timer _createPeriodicTimer(
    Zone self,
    ZoneDelegate parent,
    Zone zone,
    Duration duration,
    void Function(Timer timer) fn,
  ) {
    final timer = _TravelingTimer.periodic(
      owner: this,
      createdInFakeTime: _fakeTime(),
      parent: parent,
      zone: zone,
      duration: duration,
      trigger: fn,
    );

    _pendingTimers.add(timer);

    // If the newly added [timer] is the first timer in the queue, then we have
    // to create a new [_timerForFirstPendingTimer] timer.
    if (_pendingTimers.first == timer) {
      _timerForFirstPendingTimer?.cancel();
      _timerForFirstPendingTimer = timer._parent.createTimer(
        timer._zone,
        timer._duration,
        _triggerPendingTimers,
      );
    }

    return timer;
  }

  /// This will cancel [_timerForFirstPendingTimer] if active, and trigger all
  /// [_pendingTimers] that are pending according to [_fakeTime].
  ///
  /// This will always create a new [Timer] for [_timerForFirstPendingTimer],
  /// recovering from any elapse of time, whether as a result of waiting for a
  /// [Timer] or as a result of jumping in time.
  void _triggerPendingTimers() {
    // Grab any actual timer, we'll cancel it later.
    final actualTimer = _timerForFirstPendingTimer;
    _timerForFirstPendingTimer = null;

    final fakeNow = _fakeTime();

    // Take all pending timers that are scheduled to be triggered now.
    // Notice that we take timers that are not after [fakeNow], that means that
    // if we move time forward to exactly the point in time where a timer
    // becomes we will trigger it.
    final triggeredTimers = <_TravelingTimer>[];
    while (_pendingTimers.isNotEmpty &&
        !_pendingTimers.first._elapsesAtInFakeTime.isAfter(fakeNow)) {
      triggeredTimers.add(_pendingTimers.removeFirst());
    }

    // Increase ticks and set active false as necessary for [triggeredTimers].
    for (final triggeredTimer in triggeredTimers) {
      // Increase ticks with the number of missed ticks, if duration is not zero
      if (triggeredTimer._duration > Duration.zero) {
        final delay = _fakeTime().difference(triggeredTimer._createdInFakeTime);
        final durationNs = triggeredTimer._duration.inMicroseconds;
        final ticks = (delay.inMicroseconds / durationNs).round();
        triggeredTimer._tick = max(
          triggeredTimer._tick + 1,
          ticks - triggeredTimer._tick,
        );
      } else {
        // Always increase tick by at-least one
        triggeredTimer._tick += 1;
      }

      // Insert [triggeredTimer] for it to be scheduled again
      if (triggeredTimer._isPeriodic) {
        _pendingTimers.add(triggeredTimer);
      } else {
        triggeredTimer._active = false;
      }
    }

    // Schedule the next actual timer, if [_pendingTimers] is not empty
    if (_pendingTimers.isNotEmpty) {
      final nextTimer = _pendingTimers.first;

      var delay = nextTimer._elapsesAtInFakeTime.difference(_fakeTime());
      if (delay.isNegative) {
        delay = Duration.zero;
      }

      _timerForFirstPendingTimer = nextTimer._parent.createTimer(
        nextTimer._zone,
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
      // Skip running periodic timers if they have been cancelled.
      // TODO: review/refactor trigger sequence so that this doesn't happen
      if (triggeredTimer._isPeriodic && !triggeredTimer.isActive) {
        continue;
      }
      try {
        triggeredTimer._parent.runUnary(
          triggeredTimer._zone,
          triggeredTimer._trigger,
          triggeredTimer,
        );
      } catch (error, stackTrace) {
        // Documentation is unclear about whether or not an exception can be
        // thrown here.
        triggeredTimer._parent.handleUncaughtError(
          triggeredTimer._zone,
          error,
          stackTrace,
        );
      }
    }
  }

  void _cancelPendingTimer(_TravelingTimer timer) {
    if (_pendingTimers.isEmpty) {
      // When cancelled a timer becomes in active, and it will never call
      // [_cancelPendingTimer] again.
      assert(!timer._active);
      assert(false);
      timer._active = false; // for sanity only
      return;
    }

    // Mark [timer] as no-longer active
    timer._active = false;

    // If the timer being cancelled is the next timer to run
    if (_pendingTimers.first == timer) {
      // Remove the timer, and cancel the actual timer.
      _pendingTimers.removeFirst();
      final actualTimer = _timerForFirstPendingTimer;

      // If there are more pending timers, then create a new actual timer.
      // This restores our invariant.
      if (_pendingTimers.isNotEmpty) {
        final nextTimer = _pendingTimers.first;

        var delay = nextTimer._elapsesAtInFakeTime.difference(_fakeTime());
        if (delay.isNegative) {
          delay = Duration.zero;
        }

        _timerForFirstPendingTimer = nextTimer._parent.createTimer(
          nextTimer._zone,
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
    final removed = _pendingTimers.remove(timer);
    assert(removed); // check that it was removed.
  }

  @override
  Future<void> elapseTime(Duration duration) {
    if (duration.isNegative) {
      throw ArgumentError.value(
        duration,
        'duration',
        'FakeTime.elapseTime can only move forward in time',
      );
    }
    return _elapseTo(_fakeTime().add(duration));
  }

  @override
  Future<void> elapseTo(DateTime futureTime) {
    if (_fakeTime().isAfter(futureTime)) {
      throw StateError(
        'FakeTime.elapseTo(futureTime) cannot travel backwards in time, '
        'futureTime > now cannot be allowed',
      );
    }
    return _elapseTo(futureTime);
  }

  @override
  Future<void> elapseUntil(
    FutureOr<bool> Function() condition, {
    Duration? timeout,
    Duration? minimumStep,
  }) async {
    final deadline = timeout != null ? clock.fromNowBy(timeout) : null;
    while (_pendingTimers.isNotEmpty &&
        (deadline == null ||
            _pendingTimers.first._elapsesAtInFakeTime.isBefore(deadline))) {
      if (await condition()) {
        return;
      }

      // Wait for all microtasks to run
      await _waitForMicroTasks();

      // Jump into the future, until the point in time that the next timer is
      // pending.
      final nextTimerElapsesAt = _pendingTimers.first._elapsesAtInFakeTime;
      _offset += nextTimerElapsesAt.difference(_fakeTime());

      // Trigger all timers that are pending, this cancels any actual timer
      // and creates a new pending timer.
      _triggerPendingTimers();
    }

    await _waitForMicroTasks();

    if (await condition()) {
      return;
    }

    if (deadline != null) {
      // Jump into the desired future point in time.
      _offset += deadline.difference(_fakeTime());

      // Ensure that we cancel the current actual timer, trigger any pending
      // timers, and create a new actual timer.
      _triggerPendingTimers();

      await _waitForMicroTasks();
    }

    if (!await condition()) {
      throw TimeoutException(
        'Condition given to FakeTime.elapseUntil was not satisfied'
        ' before timeout: $timeout',
      );
    }
  }

  /// Elapse time until [futureTime].
  ///
  /// This is an implementation of [elapseTo] without checks that we are not
  /// moving backwards in time. That allows [elapseTime] to be called with
  /// a zero duration.
  Future<void> _elapseTo(DateTime futureTime) async {
    while (_pendingTimers.isNotEmpty &&
        _pendingTimers.first._elapsesAtInFakeTime.isBefore(futureTime)) {
      // Wait for all microtasks to run
      await _waitForMicroTasks();

      // Jump into the future, until the point in time that the next timer is
      // pending.
      final nextTimerElapsesAt = _pendingTimers.first._elapsesAtInFakeTime;
      _offset += nextTimerElapsesAt.difference(_fakeTime());

      // Trigger all timers that are pending, this cancels any actual timer
      // and creates a new pending timer.
      _triggerPendingTimers();
    }

    await _waitForMicroTasks();

    // Jump into the desired future point in time.
    _offset += futureTime.difference(_fakeTime());
    // Ensure that we cancel the current actual timer, trigger any pending
    // timers, and create a new actual timer.
    _triggerPendingTimers();
  }

  @override
  void elapseTimeSync(Duration duration) {
    if (duration.isNegative) {
      throw ArgumentError.value(
        duration,
        'duration',
        'FakeTime.elapseTimeSync can only move forward in time',
      );
    }
    _offset += duration;
    // Ensure that we cancel the current actual timer, trigger any pending
    // timers, and create a new actual timer.
    _triggerPendingTimers();
  }

  @override
  void elapseToSync(DateTime futureTime) {
    if (_fakeTime().isAfter(futureTime)) {
      throw StateError(
        'FakeTime.elapseToSync(futureTime) cannot travel backwards in '
        'time, futureTime > now cannot be allowed',
      );
    }

    _offset += futureTime.difference(_fakeTime());
    // Ensure that we cancel the current actual timer, trigger any pending
    // timers, and create a new actual timer.
    _triggerPendingTimers();
  }

  int _pendingMicroTasks = 0;
  Completer<void> _microTasksDone = Completer.sync()..complete();

  /// Wait for all scheduled microtasks to be done.
  Future<void> _waitForMicroTasks() async {
    await _microTasksDone.future;
  }

  void _scheduleMicrotask(
    Zone self,
    ZoneDelegate parent,
    Zone zone,
    void Function() fn,
  ) {
    if (_pendingMicroTasks == 0) {
      _microTasksDone = Completer.sync();
    }
    _pendingMicroTasks += 1;
    parent.scheduleMicrotask(zone, () {
      // TODO: Test if a microtask scheduled inside a microtask also gets here!
      try {
        fn();
      } finally {
        _pendingMicroTasks -= 1;
        if (_pendingMicroTasks == 0) {
          _microTasksDone.complete();
        }
      }
    });
  }
}

class _TravelingTimer implements Timer {
  /// [_FakeTime] to which this [_TravelingTimer] belongs.
  final _FakeTime _owner;

  /// [DateTime] when this [_TravelingTimer] was created in
  /// [_FakeTime._fakeTime].
  final DateTime _createdInFakeTime;

  /// Parent zone, for creation of timers.
  final ZoneDelegate _parent;

  /// Zone, for creation of timers.
  final Zone _zone;

  /// Duration for the timer to trigger.
  final Duration _duration;

  /// Callback to be invoked when this [_TravelingTimer] is triggered.
  final void Function(Timer timer) _trigger;

  /// `true`, if this [_TravelingTimer] is periodic.
  final bool _isPeriodic;

  /// `true`, if this [_TravelingTimer] is still pending and have not been
  /// cancelled, or triggered (if this is not a periodic timer).
  bool _active = true;

  /// Number of times this [_TravelingTimer] should have been triggered.
  int _tick = 0;

  /// [DateTime] when this [_TravelingTimer] is supposed to be triggered,
  /// measured in [_FakeTime._fakeTime].
  DateTime get _elapsesAtInFakeTime =>
      _createdInFakeTime.add(_duration * (1 + tick));

  _TravelingTimer({
    required _FakeTime owner,
    required DateTime createdInFakeTime,
    required ZoneDelegate parent,
    required Zone zone,
    required Duration duration,
    required void Function() trigger,
  })  : _owner = owner,
        _createdInFakeTime = createdInFakeTime,
        _parent = parent,
        _zone = zone,
        _duration = duration,
        _trigger = ((_) => trigger()),
        _isPeriodic = false;

  _TravelingTimer.periodic({
    required _FakeTime owner,
    required DateTime createdInFakeTime,
    required ZoneDelegate parent,
    required Zone zone,
    required Duration duration,
    required void Function(Timer timer) trigger,
  })  : _owner = owner,
        _createdInFakeTime = createdInFakeTime,
        _parent = parent,
        _zone = zone,
        _duration = duration,
        _trigger = trigger,
        _isPeriodic = true;

  @override
  bool get isActive => _active;

  @override
  int get tick => _tick;

  @override
  void cancel() {
    if (isActive) {
      _owner._cancelPendingTimer(this);
    }
  }
}
