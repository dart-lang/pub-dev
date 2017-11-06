// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:test/src/backend/group.dart';
import 'package:test/src/backend/invoker.dart';
import 'package:test/src/backend/message.dart';
import 'package:test/src/backend/metadata.dart';
import 'package:test/src/backend/state.dart';
import 'package:test/src/backend/suite.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  var suite;
  setUp(() {
    lastState = null;
    suite = new Suite(new Group.root([]));
  });

  group("Invoker.current", () {
    var invoker = Invoker.current;
    test("returns null outside of a test body", () {
      expect(invoker, isNull);
    });

    test("returns the current invoker in a test body", () async {
      var invoker;
      var liveTest = _localTest(() {
        invoker = Invoker.current;
      }).load(suite);
      liveTest.onError.listen(expectAsync1((_) {}, count: 0));

      await liveTest.run();
      expect(invoker.liveTest, equals(liveTest));
    });

    test("returns the current invoker in a test body after the test completes",
        () async {
      var status;
      var completer = new Completer();
      var liveTest = _localTest(() {
        // Use [new Future] in particular to wait longer than a microtask for
        // the test to complete.
        new Future(() {
          status = Invoker.current.liveTest.state.status;
          completer.complete(Invoker.current);
        });
      }).load(suite);
      liveTest.onError.listen(expectAsync1((_) {}, count: 0));

      expect(liveTest.run(), completes);
      var invoker = await completer.future;
      expect(invoker.liveTest, equals(liveTest));
      expect(status, equals(Status.complete));
    });
  });

  group("in a successful test,", () {
    test("the state changes from pending to running to complete", () async {
      var stateInTest;
      var liveTest;
      liveTest = _localTest(() {
        stateInTest = liveTest.state;
      }).load(suite);
      liveTest.onError.listen(expectAsync1((_) {}, count: 0));

      expect(liveTest.state.status, equals(Status.pending));
      expect(liveTest.state.result, equals(Result.success));

      var future = liveTest.run();

      expect(liveTest.state.status, equals(Status.running));
      expect(liveTest.state.result, equals(Result.success));

      await future;

      expect(stateInTest.status, equals(Status.running));
      expect(stateInTest.result, equals(Result.success));

      expect(liveTest.state.status, equals(Status.complete));
      expect(liveTest.state.result, equals(Result.success));
    });

    test("onStateChange fires for each state change", () {
      var liveTest = _localTest(() {}).load(suite);
      liveTest.onError.listen(expectAsync1((_) {}, count: 0));

      var first = true;
      liveTest.onStateChange.listen(expectAsync1((state) {
        if (first) {
          expect(state.status, equals(Status.running));
          first = false;
        } else {
          expect(state.status, equals(Status.complete));
        }
        expect(state.result, equals(Result.success));
      }, count: 2, max: 2));

      return liveTest.run();
    });

    test("onComplete completes once the test body is done", () {
      var testRun = false;
      var liveTest = _localTest(() {
        testRun = true;
      }).load(suite);

      expect(liveTest.onComplete.then((_) {
        expect(testRun, isTrue);
      }), completes);

      return liveTest.run();
    });
  });

  group("in a test with failures,", () {
    test("a synchronous throw is reported and causes the test to fail", () {
      var liveTest = _localTest(() {
        throw new TestFailure('oh no');
      }).load(suite);

      expectSingleFailure(liveTest);
      return liveTest.run();
    });

    test("a synchronous reported failure causes the test to fail", () {
      var liveTest = _localTest(() {
        registerException(new TestFailure("oh no"));
      }).load(suite);

      expectSingleFailure(liveTest);
      return liveTest.run();
    });

    test("a failure reported asynchronously during the test causes it to fail",
        () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => registerException(new TestFailure("oh no")));
      }).load(suite);

      expectSingleFailure(liveTest);
      return liveTest.run();
    });

    test("a failure thrown asynchronously during the test causes it to fail",
        () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => throw new TestFailure("oh no"));
      }).load(suite);

      expectSingleFailure(liveTest);
      return liveTest.run();
    });

    test("a failure reported asynchronously after the test causes it to error",
        () {
      var liveTest = _localTest(() {
        new Future(() => registerException(new TestFailure("oh no")));
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.success),
        const State(Status.complete, Result.failure),
        const State(Status.complete, Result.error)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(
              lastState, equals(const State(Status.complete, Result.failure)));
          expect(error, isTestFailure("oh no"));
        },
        (error) {
          expect(lastState, equals(const State(Status.complete, Result.error)));
          expect(
              error,
              equals(
                  "This test failed after it had already completed. Make sure to "
                  "use [expectAsync]\n"
                  "or the [completes] matcher when testing async code."));
        }
      ]);

      return liveTest.run();
    });

    test("multiple asynchronous failures are reported", () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => throw new TestFailure("one"));
        new Future(() => throw new TestFailure("two"));
        new Future(() => throw new TestFailure("three"));
        new Future(() => throw new TestFailure("four"));
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.failure)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(lastState.status, equals(Status.complete));
          expect(error, isTestFailure("one"));
        },
        (error) {
          expect(error, isTestFailure("two"));
        },
        (error) {
          expect(error, isTestFailure("three"));
        },
        (error) {
          expect(error, isTestFailure("four"));
        }
      ]);

      return liveTest.run();
    });

    test("a failure after an error doesn't change the state of the test", () {
      var liveTest = _localTest(() {
        new Future(() => throw new TestFailure("fail"));
        throw "error";
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.error)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(lastState, equals(const State(Status.complete, Result.error)));
          expect(error, equals("error"));
        },
        (error) {
          expect(error, isTestFailure("fail"));
        }
      ]);

      return liveTest.run();
    });
  });

  group("in a test with errors,", () {
    test("a synchronous throw is reported and causes the test to error", () {
      var liveTest = _localTest(() {
        throw 'oh no';
      }).load(suite);

      expectSingleError(liveTest);
      return liveTest.run();
    });

    test("a synchronous reported error causes the test to error", () {
      var liveTest = _localTest(() {
        registerException("oh no");
      }).load(suite);

      expectSingleError(liveTest);
      return liveTest.run();
    });

    test("an error reported asynchronously during the test causes it to error",
        () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => registerException("oh no"));
      }).load(suite);

      expectSingleError(liveTest);
      return liveTest.run();
    });

    test("an error thrown asynchronously during the test causes it to error",
        () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => throw "oh no");
      }).load(suite);

      expectSingleError(liveTest);
      return liveTest.run();
    });

    test("an error reported asynchronously after the test causes it to error",
        () {
      var liveTest = _localTest(() {
        new Future(() => registerException("oh no"));
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.success),
        const State(Status.complete, Result.error)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(lastState, equals(const State(Status.complete, Result.error)));
          expect(error, equals("oh no"));
        },
        (error) {
          expect(
              error,
              equals(
                  "This test failed after it had already completed. Make sure to "
                  "use [expectAsync]\n"
                  "or the [completes] matcher when testing async code."));
        }
      ]);

      return liveTest.run();
    });

    test("multiple asynchronous errors are reported", () {
      var liveTest = _localTest(() {
        Invoker.current.addOutstandingCallback();
        new Future(() => throw "one");
        new Future(() => throw "two");
        new Future(() => throw "three");
        new Future(() => throw "four");
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.error)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(lastState.status, equals(Status.complete));
          expect(error, equals("one"));
        },
        (error) {
          expect(error, equals("two"));
        },
        (error) {
          expect(error, equals("three"));
        },
        (error) {
          expect(error, equals("four"));
        }
      ]);

      return liveTest.run();
    });

    test("an error after a failure changes the state of the test", () {
      var liveTest = _localTest(() {
        new Future(() => throw "error");
        throw new TestFailure("fail");
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.failure),
        const State(Status.complete, Result.error)
      ]);

      expectErrors(liveTest, [
        (error) {
          expect(
              lastState, equals(const State(Status.complete, Result.failure)));
          expect(error, isTestFailure("fail"));
        },
        (error) {
          expect(lastState, equals(const State(Status.complete, Result.error)));
          expect(error, equals("error"));
        }
      ]);

      return liveTest.run();
    });
  });

  test("a test doesn't complete until there are no outstanding callbacks",
      () async {
    var outstandingCallbackRemoved = false;
    var liveTest = _localTest(() {
      Invoker.current.addOutstandingCallback();

      // Pump the event queue to make sure the test isn't coincidentally
      // completing after the outstanding callback is removed.
      pumpEventQueue().then((_) {
        outstandingCallbackRemoved = true;
        Invoker.current.removeOutstandingCallback();
      });
    }).load(suite);

    liveTest.onError.listen(expectAsync1((_) {}, count: 0));

    await liveTest.run();
    expect(outstandingCallbackRemoved, isTrue);
  });

  test("a test's prints are captured and reported", () {
    expect(() {
      var liveTest = _localTest(() {
        print("Hello,");
        return new Future(() => print("world!"));
      }).load(suite);

      expect(
          liveTest.onMessage.take(2).toList().then((messages) {
            expect(messages[0].type, equals(MessageType.print));
            expect(messages[0].text, equals("Hello,"));
            expect(messages[1].type, equals(MessageType.print));
            expect(messages[1].text, equals("world!"));
          }),
          completes);

      return liveTest.run();
    }, prints(isEmpty));
  });

  group("timeout:", () {
    test("a test times out after 30 seconds by default", () {
      new FakeAsync().run((async) {
        var liveTest = _localTest(() {
          Invoker.current.addOutstandingCallback();
        }).load(suite);

        expectStates(liveTest, [
          const State(Status.running, Result.success),
          const State(Status.complete, Result.error)
        ]);

        expectErrors(liveTest, [
          (error) {
            expect(lastState.status, equals(Status.complete));
            expect(error, new isInstanceOf<TimeoutException>());
          }
        ]);

        liveTest.run();
        async.elapse(new Duration(seconds: 30));
      });
    });

    test("a test's custom timeout takes precedence", () {
      new FakeAsync().run((async) {
        var liveTest = _localTest(() {
          Invoker.current.addOutstandingCallback();
        },
                metadata: new Metadata(
                    timeout: new Timeout(new Duration(seconds: 15))))
            .load(suite);

        expectStates(liveTest, [
          const State(Status.running, Result.success),
          const State(Status.complete, Result.error)
        ]);

        expectErrors(liveTest, [
          (error) {
            expect(lastState.status, equals(Status.complete));
            expect(error, new isInstanceOf<TimeoutException>());
          }
        ]);

        liveTest.run();
        async.elapse(new Duration(seconds: 15));
      });
    });

    test("a timeout factor is applied on top of the 30s default", () {
      new FakeAsync().run((async) {
        var liveTest = _localTest(() {
          Invoker.current.addOutstandingCallback();
        }, metadata: new Metadata(timeout: new Timeout.factor(0.5)))
            .load(suite);

        expectStates(liveTest, [
          const State(Status.running, Result.success),
          const State(Status.complete, Result.error)
        ]);

        expectErrors(liveTest, [
          (error) {
            expect(lastState.status, equals(Status.complete));
            expect(error, new isInstanceOf<TimeoutException>());
          }
        ]);

        liveTest.run();
        async.elapse(new Duration(seconds: 15));
      });
    });

    test("a test with Timeout.none never times out", () {
      new FakeAsync().run((async) {
        var liveTest = _localTest(() {
          Invoker.current.addOutstandingCallback();
        }, metadata: new Metadata(timeout: Timeout.none))
            .load(suite);

        expectStates(liveTest, [const State(Status.running, Result.success)]);

        liveTest.run();
        async.elapse(new Duration(hours: 10));
        expect(liveTest.state.status, equals(Status.running));
      });
    });
  });

  group("waitForOutstandingCallbacks:", () {
    test("waits for the wrapped function to complete", () async {
      var functionCompleted = false;
      await Invoker.current.waitForOutstandingCallbacks(() async {
        await pumpEventQueue();
        functionCompleted = true;
      });

      expect(functionCompleted, isTrue);
    });

    test("waits for registered callbacks in the wrapped function to run",
        () async {
      var callbackRun = false;
      await Invoker.current.waitForOutstandingCallbacks(() {
        pumpEventQueue().then(expectAsync1((_) {
          callbackRun = true;
        }));
      });

      expect(callbackRun, isTrue);
    });

    test("doesn't automatically block the enclosing context", () async {
      var innerFunctionCompleted = false;
      await Invoker.current.waitForOutstandingCallbacks(() {
        Invoker.current.waitForOutstandingCallbacks(() async {
          await pumpEventQueue();
          innerFunctionCompleted = true;
        });
      });

      expect(innerFunctionCompleted, isFalse);
    });

    test(
        "forwards errors to the enclosing test but doesn't remove its "
        "outstanding callbacks", () async {
      var liveTest = _localTest(() async {
        Invoker.current.addOutstandingCallback();
        await Invoker.current.waitForOutstandingCallbacks(() {
          throw 'oh no';
        });
      }).load(suite);

      expectStates(liveTest, [
        const State(Status.running, Result.success),
        const State(Status.complete, Result.error)
      ]);

      var isComplete = false;
      liveTest.run().then((_) => isComplete = true);
      await pumpEventQueue();
      expect(liveTest.state.status, equals(Status.complete));
      expect(isComplete, isFalse);
    });
  });

  group("chainStackTraces", () {
    test(
        "if disabled, directs users to run with the flag enabled when "
        "failures occur", () {
      expect(() async {
        var liveTest = _localTest(() {
          expect(true, isFalse);
        }, metadata: new Metadata(chainStackTraces: false))
            .load(suite);
        liveTest.onError.listen(expectAsync1((_) {}, count: 1));

        await liveTest.run();
      },
          prints("Consider enabling the flag chain-stack-traces to "
              "receive more detailed exceptions.\n"
              "For example, 'pub run test --chain-stack-traces'.\n"));
    });
  });

  group("printOnFailure:", () {
    test("doesn't print anything if the test succeeds", () {
      expect(() async {
        var liveTest = _localTest(() {
          Invoker.current.printOnFailure("only on failure");
        }).load(suite);
        liveTest.onError.listen(expectAsync1((_) {}, count: 0));

        await liveTest.run();
      }, prints(isEmpty));
    });

    test("prints if the test fails", () {
      expect(() async {
        var liveTest = _localTest(() {
          Invoker.current.printOnFailure("only on failure");
          expect(true, isFalse);
        }).load(suite);
        liveTest.onError.listen(expectAsync1((_) {}, count: 1));

        await liveTest.run();
      }, prints("only on failure\n"));
    });
  });
}

LocalTest _localTest(body(), {Metadata metadata}) {
  if (metadata == null) metadata = new Metadata();
  return new LocalTest("test", metadata, body);
}
