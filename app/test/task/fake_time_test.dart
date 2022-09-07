// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';
import 'fake_time.dart';

void main() {
  test('FakeTime.run() with sync callback', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      ok = true;
    });
    expect(ok, isTrue);
  });

  test('FakeTime.run() with async microtasks', () async {
    var ok1 = false;
    var ok2 = false;
    await FakeTime.run((tm) async {
      await Future.microtask(() {
        ok1 = true;
      });
      ok2 = true;
    });
    expect(ok1, isTrue);
    expect(ok2, isTrue);
  });

  test('nested microtasks', () async {
    var ok1 = false;
    var ok2 = false;
    await FakeTime.run((tm) async {
      await Future.microtask(() async {
        await Future.microtask(() {
          ok1 = true;
        });
      });
      ok2 = true;
    });
    expect(ok1, isTrue);
    expect(ok2, isTrue);
  });

  test('create a Timer with zero delay', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      await Future.delayed(Duration.zero);
      ok = true;
    });
    expect(ok, isTrue);
  });

  test('create a Timer with 1 ms delay', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      await Future.delayed(Duration(milliseconds: 1));
      ok = true;
    });
    expect(ok, isTrue);
  });

  test('elapse(zero) runs microtasks', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      scheduleMicrotask(() {
        ok = true;
      });
      expect(ok, isFalse);
      await tm.elapse();
      expect(ok, isTrue);
    });
    expect(ok, isTrue);
  });

  test('elapseSync(zero) does not run microtasks', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      scheduleMicrotask(() {
        ok = true;
      });
      expect(ok, isFalse);
      tm.elapseSync();
      expect(ok, isFalse);
    });
  });

  test('Timer.isActive becomes false after delay', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      final timer = Timer(Duration(milliseconds: 1), () {
        ok = true;
      });
      expect(timer.isActive, isTrue);
      await Future.delayed(Duration(milliseconds: 5));
      expect(timer.isActive, isFalse);
      expect(ok, isTrue);
    });
  });

  test('Timer.isActive becomes false after elapse(..)', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      final timer = Timer(Duration(milliseconds: 1), () {
        ok = true;
      });
      expect(timer.isActive, isTrue);
      await tm.elapse(milliseconds: 10);
      expect(timer.isActive, isFalse);
      expect(ok, isTrue);
    });
  });

  test('Timer can be cancelled', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      final timer = Timer(Duration(milliseconds: 1), () {
        ok = true;
      });
      expect(timer.isActive, isTrue);
      timer.cancel();
      expect(timer.isActive, isFalse);
      await tm.elapse(milliseconds: 10);
      expect(timer.isActive, isFalse);
      expect(ok, isFalse);
    });
  });

  test('Timer can be cancelled after elapse(1)', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      final timer = Timer(Duration(milliseconds: 100), () {
        ok = true;
      });
      expect(timer.isActive, isTrue);
      await tm.elapse(milliseconds: 1);
      timer.cancel();
      expect(timer.isActive, isFalse);
      expect(ok, isFalse);
    });
  });

  test('Timer can be cancelled after delay of 1 ms', () async {
    var ok = false;
    await FakeTime.run((tm) async {
      final timer = Timer(Duration(milliseconds: 100), () {
        ok = true;
      });
      expect(timer.isActive, isTrue);
      await Future.delayed(Duration(milliseconds: 1));
      timer.cancel();
      expect(timer.isActive, isFalse);
      expect(ok, isFalse);
    });
  });

  test('Periodic Timer.isActive is called multiple times', () async {
    var count = 0;
    await FakeTime.run((tm) async {
      final timer = Timer.periodic(Duration(milliseconds: 1), (_) {
        count += 1;
      });
      expect(timer.isActive, isTrue);
      expect(timer.tick, 0);
      expect(count, 0);

      await Future.delayed(Duration(milliseconds: 5));
      expect(timer.isActive, isTrue);
      expect(count, greaterThan(0));
      expect(timer.tick, greaterThan(0));

      await Future.delayed(Duration(milliseconds: 5));
      expect(count, lessThan(50));
      expect(count, greaterThan(2));
      expect(timer.tick, lessThan(50));
      expect(timer.tick, greaterThan(2));

      final currentCount = count;
      timer.cancel();
      await Future.delayed(Duration(milliseconds: 5));
      expect(count, currentCount);
      expect(timer.isActive, isFalse);
    });
  });
}
