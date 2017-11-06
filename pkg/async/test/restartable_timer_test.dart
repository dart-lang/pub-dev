// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:async/async.dart';
import 'package:fake_async/fake_async.dart';
import 'package:test/test.dart';

main() {
  test("runs the callback once the duration has elapsed", () {
    new FakeAsync().run((async) {
      var fired = false;
      new RestartableTimer(new Duration(seconds: 5), () {
        fired = true;
      });

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);

      async.elapse(new Duration(seconds: 1));
      expect(fired, isTrue);
    });
  });

  test("doesn't run the callback if the timer is canceled", () {
    new FakeAsync().run((async) {
      var fired = false;
      var timer = new RestartableTimer(new Duration(seconds: 5), () {
        fired = true;
      });

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);
      timer.cancel();

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);
    });
  });

  test("resets the duration if the timer is reset before it fires", () {
    new FakeAsync().run((async) {
      var fired = false;
      var timer = new RestartableTimer(new Duration(seconds: 5), () {
        fired = true;
      });

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);
      timer.reset();

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);

      async.elapse(new Duration(seconds: 1));
      expect(fired, isTrue);
    });
  });

  test("re-runs the callback if the timer is reset after firing", () {
    new FakeAsync().run((async) {
      var fired = 0;
      var timer = new RestartableTimer(new Duration(seconds: 5), () {
        fired++;
      });

      async.elapse(new Duration(seconds: 5));
      expect(fired, equals(1));
      timer.reset();

      async.elapse(new Duration(seconds: 5));
      expect(fired, equals(2));
      timer.reset();

      async.elapse(new Duration(seconds: 5));
      expect(fired, equals(3));
    });
  });

  test("runs the callback if the timer is reset after being canceled", () {
    new FakeAsync().run((async) {
      var fired = false;
      var timer = new RestartableTimer(new Duration(seconds: 5), () {
        fired = true;
      });

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);
      timer.cancel();

      async.elapse(new Duration(seconds: 4));
      expect(fired, isFalse);
      timer.reset();

      async.elapse(new Duration(seconds: 5));
      expect(fired, isTrue);
    });
  });

  test("only runs the callback once if the timer isn't reset", () {
    new FakeAsync().run((async) {
      new RestartableTimer(
          new Duration(seconds: 5), expectAsync0(() {}, count: 1));
      async.elapse(new Duration(seconds: 10));
    });
  });
}
