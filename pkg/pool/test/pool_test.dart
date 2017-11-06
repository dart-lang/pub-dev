// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:pool/pool.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

void main() {
  group("request()", () {
    test("resources can be requested freely up to the limit", () {
      var pool = new Pool(50);
      for (var i = 0; i < 50; i++) {
        expect(pool.request(), completes);
      }
    });

    test("resources block past the limit", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50);
        for (var i = 0; i < 50; i++) {
          expect(pool.request(), completes);
        }
        expect(pool.request(), doesNotComplete);

        async.elapse(new Duration(seconds: 1));
      });
    });

    test("a blocked resource is allocated when another is released", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50);
        for (var i = 0; i < 49; i++) {
          expect(pool.request(), completes);
        }

        pool.request().then((lastAllocatedResource) {
          // This will only complete once [lastAllocatedResource] is released.
          expect(pool.request(), completes);

          new Future.delayed(new Duration(microseconds: 1)).then((_) {
            lastAllocatedResource.release();
          });
        });

        async.elapse(new Duration(seconds: 1));
      });
    });
  });

  group("withResource()", () {
    test("can be called freely up to the limit", () {
      var pool = new Pool(50);
      for (var i = 0; i < 50; i++) {
        pool.withResource(expectAsync(() => new Completer().future));
      }
    });

    test("blocks the callback past the limit", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50);
        for (var i = 0; i < 50; i++) {
          pool.withResource(expectAsync(() => new Completer().future));
        }
        pool.withResource(expectNoAsync());

        async.elapse(new Duration(seconds: 1));
      });
    });

    test("a blocked resource is allocated when another is released", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50);
        for (var i = 0; i < 49; i++) {
          pool.withResource(expectAsync(() => new Completer().future));
        }

        var completer = new Completer();
        pool.withResource(() => completer.future);
        var blockedResourceAllocated = false;
        pool.withResource(() {
          blockedResourceAllocated = true;
        });

        new Future.delayed(new Duration(microseconds: 1)).then((_) {
          expect(blockedResourceAllocated, isFalse);
          completer.complete();
          return new Future.delayed(new Duration(microseconds: 1));
        }).then((_) {
          expect(blockedResourceAllocated, isTrue);
        });

        async.elapse(new Duration(seconds: 1));
      });
    });

    // Regression test for #3.
    test("can be called immediately before close()", () async {
      var pool = new Pool(1);
      pool.withResource(expectAsync(() {}));
      await pool.close();
    });
  });

  group("with a timeout", () {
    test("doesn't time out if there are no pending requests", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50, timeout: new Duration(seconds: 5));
        for (var i = 0; i < 50; i++) {
          expect(pool.request(), completes);
        }

        async.elapse(new Duration(seconds: 6));
      });
    });

    test("resets the timer if a resource is returned", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50, timeout: new Duration(seconds: 5));
        for (var i = 0; i < 49; i++) {
          expect(pool.request(), completes);
        }

        pool.request().then((lastAllocatedResource) {
          // This will only complete once [lastAllocatedResource] is released.
          expect(pool.request(), completes);

          new Future.delayed(new Duration(seconds: 3)).then((_) {
            lastAllocatedResource.release();
            expect(pool.request(), doesNotComplete);
          });
        });

        async.elapse(new Duration(seconds: 6));
      });
    });

    test("resets the timer if a resource is requested", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50, timeout: new Duration(seconds: 5));
        for (var i = 0; i < 50; i++) {
          expect(pool.request(), completes);
        }
        expect(pool.request(), doesNotComplete);

        new Future.delayed(new Duration(seconds: 3)).then((_) {
          expect(pool.request(), doesNotComplete);
        });

        async.elapse(new Duration(seconds: 6));
      });
    });

    test("times out if nothing happens", () {
      new FakeAsync().run((async) {
        var pool = new Pool(50, timeout: new Duration(seconds: 5));
        for (var i = 0; i < 50; i++) {
          expect(pool.request(), completes);
        }
        expect(pool.request(), throwsA(new isInstanceOf<TimeoutException>()));

        async.elapse(new Duration(seconds: 6));
      });
    });
  });

  group("allowRelease()", () {
    test("runs the callback once the resource limit is exceeded", () async {
      var pool = new Pool(50);
      for (var i = 0; i < 49; i++) {
        expect(pool.request(), completes);
      }

      var resource = await pool.request();
      var onReleaseCalled = false;
      resource.allowRelease(() => onReleaseCalled = true);
      await new Future.delayed(Duration.ZERO);
      expect(onReleaseCalled, isFalse);

      expect(pool.request(), completes);
      await new Future.delayed(Duration.ZERO);
      expect(onReleaseCalled, isTrue);
    });

    test("runs the callback immediately if there are blocked requests",
        () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      // This will be blocked until [resource.allowRelease] is called.
      expect(pool.request(), completes);

      var onReleaseCalled = false;
      resource.allowRelease(() => onReleaseCalled = true);
      await new Future.delayed(Duration.ZERO);
      expect(onReleaseCalled, isTrue);
    });

    test("blocks the request until the callback completes", () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      var requestComplete = false;
      pool.request().then((_) => requestComplete = true);

      var completer = new Completer();
      resource.allowRelease(() => completer.future);
      await new Future.delayed(Duration.ZERO);
      expect(requestComplete, isFalse);

      completer.complete();
      await new Future.delayed(Duration.ZERO);
      expect(requestComplete, isTrue);
    });

    test("completes requests in request order regardless of callback order",
        () async {
      var pool = new Pool(2);
      var resource1 = await pool.request();
      var resource2 = await pool.request();

      var request1Complete = false;
      pool.request().then((_) => request1Complete = true);
      var request2Complete = false;
      pool.request().then((_) => request2Complete = true);

      var onRelease1Called = false;
      var completer1 = new Completer();
      resource1.allowRelease(() {
        onRelease1Called = true;
        return completer1.future;
      });
      await new Future.delayed(Duration.ZERO);
      expect(onRelease1Called, isTrue);

      var onRelease2Called = false;
      var completer2 = new Completer();
      resource2.allowRelease(() {
        onRelease2Called = true;
        return completer2.future;
      });
      await new Future.delayed(Duration.ZERO);
      expect(onRelease2Called, isTrue);
      expect(request1Complete, isFalse);
      expect(request2Complete, isFalse);

      // Complete the second resource's onRelease callback first. Even though it
      // was triggered by the second blocking request, it should complete the
      // first one to preserve ordering.
      completer2.complete();
      await new Future.delayed(Duration.ZERO);
      expect(request1Complete, isTrue);
      expect(request2Complete, isFalse);

      completer1.complete();
      await new Future.delayed(Duration.ZERO);
      expect(request1Complete, isTrue);
      expect(request2Complete, isTrue);
    });

    test("runs onRequest in the zone it was created", () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      var outerZone = Zone.current;
      runZoned(() {
        var innerZone = Zone.current;
        expect(innerZone, isNot(equals(outerZone)));

        resource.allowRelease(expectAsync(() {
          expect(Zone.current, equals(innerZone));
        }));
      });

      pool.request();
    });
  });

  test("done doesn't complete without close", () async {
    var pool = new Pool(1);
    pool.done.then(expectAsync1((_) {}, count: 0));

    var resource = await pool.request();
    resource.release();

    await new Future.delayed(Duration.ZERO);
  });

  group("close()", () {
    test("disallows request() and withResource()", () {
      var pool = new Pool(1)..close();
      expect(pool.request, throwsStateError);
      expect(() => pool.withResource(() {}), throwsStateError);
    });

    test("pending requests are fulfilled", () async {
      var pool = new Pool(1);
      var resource1 = await pool.request();
      expect(
          pool.request().then((resource2) {
            resource2.release();
          }),
          completes);
      expect(pool.done, completes);
      expect(pool.close(), completes);
      resource1.release();
    });

    test("pending requests are fulfilled with allowRelease", () async {
      var pool = new Pool(1);
      var resource1 = await pool.request();

      var completer = new Completer();
      expect(
          pool.request().then((resource2) {
            expect(completer.isCompleted, isTrue);
            resource2.release();
          }),
          completes);
      expect(pool.close(), completes);

      resource1.allowRelease(() => completer.future);
      await new Future.delayed(Duration.ZERO);

      completer.complete();
    });

    test("doesn't complete until all resources are released", () async {
      var pool = new Pool(2);
      var resource1 = await pool.request();
      var resource2 = await pool.request();
      var resource3Future = pool.request();

      var resource1Released = false;
      var resource2Released = false;
      var resource3Released = false;
      expect(
          pool.close().then((_) {
            expect(resource1Released, isTrue);
            expect(resource2Released, isTrue);
            expect(resource3Released, isTrue);
          }),
          completes);

      resource1Released = true;
      resource1.release();
      await new Future.delayed(Duration.ZERO);

      resource2Released = true;
      resource2.release();
      await new Future.delayed(Duration.ZERO);

      var resource3 = await resource3Future;
      resource3Released = true;
      resource3.release();
    });

    test("active onReleases complete as usual", () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      // Set up an onRelease callback whose completion is controlled by
      // [completer].
      var completer = new Completer();
      resource.allowRelease(() => completer.future);
      expect(
          pool.request().then((_) {
            expect(completer.isCompleted, isTrue);
          }),
          completes);

      await new Future.delayed(Duration.ZERO);
      pool.close();

      await new Future.delayed(Duration.ZERO);
      completer.complete();
    });

    test("inactive onReleases fire", () async {
      var pool = new Pool(2);
      var resource1 = await pool.request();
      var resource2 = await pool.request();

      var completer1 = new Completer();
      resource1.allowRelease(() => completer1.future);
      var completer2 = new Completer();
      resource2.allowRelease(() => completer2.future);

      expect(
          pool.close().then((_) {
            expect(completer1.isCompleted, isTrue);
            expect(completer2.isCompleted, isTrue);
          }),
          completes);

      await new Future.delayed(Duration.ZERO);
      completer1.complete();

      await new Future.delayed(Duration.ZERO);
      completer2.complete();
    });

    test("new allowReleases fire immediately", () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      var completer = new Completer();
      expect(
          pool.close().then((_) {
            expect(completer.isCompleted, isTrue);
          }),
          completes);

      await new Future.delayed(Duration.ZERO);
      resource.allowRelease(() => completer.future);

      await new Future.delayed(Duration.ZERO);
      completer.complete();
    });

    test("an onRelease error is piped to the return value", () async {
      var pool = new Pool(1);
      var resource = await pool.request();

      var completer = new Completer();
      resource.allowRelease(() => completer.future);

      expect(pool.done, throwsA("oh no!"));
      expect(pool.close(), throwsA("oh no!"));

      await new Future.delayed(Duration.ZERO);
      completer.completeError("oh no!");
    });
  });
}

/// Returns a function that will cause the test to fail if it's called.
///
/// This should only be called within a [FakeAsync.run] zone.
Function expectNoAsync() {
  var stack = new Trace.current(1);
  return () => registerException(
      new TestFailure("Expected function not to be called."), stack);
}

/// A matcher for Futures that asserts that they don't complete.
///
/// This should only be called within a [FakeAsync.run] zone.
Matcher get doesNotComplete => predicate((future) {
      expect(future, new isInstanceOf<Future>());

      var stack = new Trace.current(1);
      future.then((_) => registerException(
          new TestFailure("Expected future not to complete."), stack));
      return true;
    });
