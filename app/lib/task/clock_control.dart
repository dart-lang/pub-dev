// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';

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

final class ClockController {
  final DateTime Function() _originalTime;
  Duration _offset;

  ClockController._(this._originalTime, this._offset);

  DateTime _controlledTime() => _originalTime().add(_offset);

  /// Advance [clock] by given [days], [hours], [minutes] and [seconds].
  ///
  /// This makes a discrete jump in time as observed through [clock].
  void elapse({int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    _offset += Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  /// Elapse time in discrete increments of [step] until [condition] is `true`.
  ///
  /// This will call [elapse] with [step] until [condition] returns `true`.
  /// Throws [TimeoutException], if [condition] is not satisfied with-in
  /// [timeout].
  Future<void> elapseUntil(
    FutureOr<bool> Function() condition, {
    Duration? timeout,
    Duration? step,
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
