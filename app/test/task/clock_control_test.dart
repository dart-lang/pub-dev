// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:pub_dev/task/clock_control.dart';
import 'package:test/test.dart';

void testWithClockControl(
  String name,
  FutureOr<void> Function(ClockController clockControl) fn,
) {
  test(name, () async {
    await withClockControl(fn);
  });
}

void main() {
  testWithClockControl('elapse', (clockControl) async {
    final ts1 = clock.now();
    clockControl.elapse(hours: 1);
    expect(clock.now().difference(ts1).inMinutes, 60);
  });

  testWithClockControl('elapseUntil timeout', (clockControl) async {
    final ts1 = clock.now();
    final f = clockControl.elapseUntil(
      () async => false,
      minimumStep: Duration(minutes: 15),
      timeout: Duration(days: 1),
    );
    await expectLater(f, throwsA(isA<TimeoutException>()));
    expect(clock.now().difference(ts1).inHours, 24);
  });

  testWithClockControl('elapseUntil', (clockControl) async {
    final ts1 = clock.now();
    int counter = 0;
    await clockControl.elapseUntil(
      () async => counter++ > 12,
      minimumStep: Duration(minutes: 15),
      timeout: Duration(days: 1),
    );
    expect(clock.now().difference(ts1).inHours, 3);
  });
}
