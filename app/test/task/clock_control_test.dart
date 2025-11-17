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
  testWithClockControl('real + elapsed time', (clockControl) async {
    var counter = -1;
    final done = Completer();
    scheduleMicrotask(() async {
      counter++;
      for (var i = 0; i < 3; i++) {
        // assuming some latency cannot be controlled
        await Future.delayed(Duration(milliseconds: 10));

        counter++;

        // expected to speed time
        await clock.delayed(Duration(minutes: 1));
      }
      counter += 100;
      done.complete();
    });

    // microtask hasn't started
    expect(counter, -1);

    // starting microtask but before 10ms timeout happens
    await Future.delayed(Duration.zero);
    expect(counter, 0);

    // loop
    await Future.delayed(Duration(milliseconds: 20));
    expect(counter, 1);
    await clockControl.elapse(minutes: 1, seconds: 1);

    // loop
    await Future.delayed(Duration(milliseconds: 20));
    expect(counter, 2);
    await clockControl.elapse(minutes: 1, seconds: 1);

    // loop
    await Future.delayed(Duration(milliseconds: 20));
    expect(counter, 3);
    await clockControl.elapse(minutes: 1, seconds: 1);
    expect(counter, 103);

    await done.future;
  });

  testWithClockControl('wrapped real + elapsed time', (clockControl) async {
    var counter = -1;
    final done = Completer();
    scheduleMicrotask(() async {
      counter++;
      for (var i = 0; i < 3; i++) {
        await clock.instant(() async {
          // assuming some latency cannot be controlled
          await Future.delayed(Duration(milliseconds: 50));

          counter++;
        });
        // expected to speed time
        await clock.delayed(Duration(minutes: 1));
      }
      counter += 100;
      done.complete();
    });

    // microtask hasn't started
    expect(counter, -1);

    // starting microtask but before 10ms timeout happens
    await Future.delayed(Duration.zero);
    expect(counter, 0);

    // loop
    await clockControl.elapse(minutes: 1, seconds: 1);
    expect(counter, 2);

    // loop
    await clockControl.elapse(minutes: 1, seconds: 1);
    expect(counter, 3);

    // loop
    await clockControl.elapse(minutes: 5, seconds: 1);
    expect(counter, 103);

    await done.future;
  });

  testWithClockControl('simple run + delayed', (clockControl) async {
    var counter = -1;
    final done = Completer();
    scheduleMicrotask(() async {
      counter++;
      for (var i = 0; i < 3; i++) {
        await clock.instant(() async {
          // assuming some latency cannot be controlled
          await Future.delayed(Duration(milliseconds: 50));

          counter++;
        });
        // expected to speed time
        await clock.delayed(Duration(minutes: 1));
      }
      counter += 100;
      done.complete();
    });

    // microtask hasn't started
    expect(counter, -1);

    // loop
    await clockControl.elapse(minutes: 5, seconds: 1);
    expect(counter, 103);

    await done.future;
  });

  testWithClockControl('delayed 3 times', (clockControl) async {
    var counter = 0;

    final done = Future.microtask(() async {
      for (var i = 0; i < 30; i++) {
        await clock.delayed(Duration(seconds: 2));
        counter++;
      }

      print('done');
      counter = 1000;
    });

    await clockControl.elapse(minutes: 10);

    await done;
    expect(counter, 1000);
  });
}
