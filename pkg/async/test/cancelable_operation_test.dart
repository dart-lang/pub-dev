// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  group("without being canceled", () {
    var completer;
    setUp(() {
      completer =
          new CancelableCompleter(onCancel: expectAsync0(() {}, count: 0));
    });

    test("sends values to the future", () {
      expect(completer.operation.value, completion(equals(1)));
      expect(completer.isCompleted, isFalse);
      completer.complete(1);
      expect(completer.isCompleted, isTrue);
    });

    test("sends errors to the future", () {
      expect(completer.operation.value, throwsA("error"));
      expect(completer.isCompleted, isFalse);
      completer.completeError("error");
      expect(completer.isCompleted, isTrue);
    });

    test("sends values in a future to the future", () {
      expect(completer.operation.value, completion(equals(1)));
      expect(completer.isCompleted, isFalse);
      completer.complete(new Future.value(1));
      expect(completer.isCompleted, isTrue);
    });

    test("sends errors in a future to the future", () {
      expect(completer.operation.value, throwsA("error"));
      expect(completer.isCompleted, isFalse);
      completer.complete(new Future.error("error"));
      expect(completer.isCompleted, isTrue);
    });

    test("sends values to valueOrCancellation", () {
      expect(completer.operation.valueOrCancellation(), completion(equals(1)));
      completer.complete(1);
    });

    test("sends errors to valueOrCancellation", () {
      expect(completer.operation.valueOrCancellation(), throwsA("error"));
      completer.completeError("error");
    });

    group("throws a StateError if completed", () {
      test("successfully twice", () {
        completer.complete(1);
        expect(() => completer.complete(1), throwsStateError);
      });

      test("successfully then unsuccessfully", () {
        completer.complete(1);
        expect(() => completer.completeError("error"), throwsStateError);
      });

      test("unsuccessfully twice", () {
        expect(completer.operation.value, throwsA("error"));
        completer.completeError("error");
        expect(() => completer.completeError("error"), throwsStateError);
      });

      test("successfully then with a future", () {
        completer.complete(1);
        expect(
            () => completer.complete(new Completer().future), throwsStateError);
      });

      test("with a future then successfully", () {
        completer.complete(new Completer().future);
        expect(() => completer.complete(1), throwsStateError);
      });

      test("with a future twice", () {
        completer.complete(new Completer().future);
        expect(
            () => completer.complete(new Completer().future), throwsStateError);
      });
    });

    group("CancelableOperation.fromFuture", () {
      test("forwards values", () {
        var operation = new CancelableOperation.fromFuture(new Future.value(1));
        expect(operation.value, completion(equals(1)));
      });

      test("forwards errors", () {
        var operation =
            new CancelableOperation.fromFuture(new Future.error("error"));
        expect(operation.value, throwsA("error"));
      });
    });
  });

  group("when canceled", () {
    test("causes the future never to fire", () async {
      var completer = new CancelableCompleter();
      completer.operation.value.whenComplete(expectAsync0(() {}, count: 0));
      completer.operation.cancel();

      // Give the future plenty of time to fire if it's going to.
      await flushMicrotasks();
      completer.complete();
      await flushMicrotasks();
    });

    test("fires onCancel", () {
      var canceled = false;
      var completer;
      completer = new CancelableCompleter(onCancel: expectAsync0(() {
        expect(completer.isCanceled, isTrue);
        canceled = true;
      }));

      expect(canceled, isFalse);
      expect(completer.isCanceled, isFalse);
      expect(completer.isCompleted, isFalse);
      completer.operation.cancel();
      expect(canceled, isTrue);
      expect(completer.isCanceled, isTrue);
      expect(completer.isCompleted, isFalse);
    });

    test("returns the onCancel future each time cancel is called", () {
      var completer = new CancelableCompleter(onCancel: expectAsync0(() {
        return new Future.value(1);
      }));
      expect(completer.operation.cancel(), completion(equals(1)));
      expect(completer.operation.cancel(), completion(equals(1)));
      expect(completer.operation.cancel(), completion(equals(1)));
    });

    test("returns a future even if onCancel doesn't", () {
      var completer = new CancelableCompleter(onCancel: expectAsync0(() {}));
      expect(completer.operation.cancel(), completes);
    });

    test("doesn't call onCancel if the completer has completed", () {
      var completer =
          new CancelableCompleter(onCancel: expectAsync0(() {}, count: 0));
      completer.complete(1);
      expect(completer.operation.value, completion(equals(1)));
      expect(completer.operation.cancel(), completes);
    });

    test(
        "does call onCancel if the completer has completed to an unfired "
        "Future", () {
      var completer = new CancelableCompleter(onCancel: expectAsync0(() {}));
      completer.complete(new Completer().future);
      expect(completer.operation.cancel(), completes);
    });

    test(
        "doesn't call onCancel if the completer has completed to a fired "
        "Future", () async {
      var completer =
          new CancelableCompleter(onCancel: expectAsync0(() {}, count: 0));
      completer.complete(new Future.value(1));
      await completer.operation.value;
      expect(completer.operation.cancel(), completes);
    });

    test("can be completed once after being canceled", () async {
      var completer = new CancelableCompleter();
      completer.operation.value.whenComplete(expectAsync0(() {}, count: 0));
      await completer.operation.cancel();
      completer.complete(1);
      expect(() => completer.complete(1), throwsStateError);
    });

    test("fires valueOrCancellation with the given value", () {
      var completer = new CancelableCompleter();
      expect(completer.operation.valueOrCancellation(1), completion(equals(1)));
      completer.operation.cancel();
    });

    test("pipes an error through valueOrCancellation", () {
      var completer = new CancelableCompleter(onCancel: () {
        throw "error";
      });
      expect(completer.operation.valueOrCancellation(1), throwsA("error"));
      completer.operation.cancel();
    });

    test("valueOrCancellation waits on the onCancel future", () async {
      var innerCompleter = new Completer();
      var completer =
          new CancelableCompleter(onCancel: () => innerCompleter.future);

      var fired = false;
      completer.operation.valueOrCancellation().then((_) {
        fired = true;
      });

      completer.operation.cancel();
      await flushMicrotasks();
      expect(fired, isFalse);

      innerCompleter.complete();
      await flushMicrotasks();
      expect(fired, isTrue);
    });
  });

  group("asStream()", () {
    test("emits a value and then closes", () {
      var completer = new CancelableCompleter();
      expect(completer.operation.asStream().toList(), completion(equals([1])));
      completer.complete(1);
    });

    test("emits an error and then closes", () {
      var completer = new CancelableCompleter();
      var queue = new StreamQueue(completer.operation.asStream());
      expect(queue.next, throwsA("error"));
      expect(queue.hasNext, completion(isFalse));
      completer.completeError("error");
    });

    test("cancels the completer when the subscription is canceled", () {
      var completer = new CancelableCompleter(onCancel: expectAsync0(() {}));
      var sub =
          completer.operation.asStream().listen(expectAsync1((_) {}, count: 0));
      completer.operation.value.whenComplete(expectAsync0(() {}, count: 0));
      sub.cancel();
      expect(completer.isCanceled, isTrue);
    });
  });
}
