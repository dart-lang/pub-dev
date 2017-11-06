// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:async/async.dart';
import 'package:test/test.dart';

import '../utils.dart';

void main() {
  test("runs after the test body", () {
    return expectTestsPass(() {
      var test1Run = false;
      var tearDownRun = false;
      test("test 1", () {
        addTearDown(() {
          expect(test1Run, isTrue);
          expect(tearDownRun, isFalse);
          tearDownRun = true;
        });

        expect(tearDownRun, isFalse);
        test1Run = true;
      });

      test("test 2", () {
        expect(tearDownRun, isTrue);
      });
    });
  });

  test("multiples run in reverse order", () {
    return expectTestsPass(() {
      var tearDown1Run = false;
      var tearDown2Run = false;
      var tearDown3Run = false;

      test("test 1", () {
        addTearDown(() {
          expect(tearDown1Run, isFalse);
          expect(tearDown2Run, isTrue);
          expect(tearDown3Run, isTrue);
          tearDown1Run = true;
        });

        addTearDown(() {
          expect(tearDown1Run, isFalse);
          expect(tearDown2Run, isFalse);
          expect(tearDown3Run, isTrue);
          tearDown2Run = true;
        });

        addTearDown(() {
          expect(tearDown1Run, isFalse);
          expect(tearDown2Run, isFalse);
          expect(tearDown3Run, isFalse);
          tearDown3Run = true;
        });

        expect(tearDown1Run, isFalse);
        expect(tearDown2Run, isFalse);
        expect(tearDown3Run, isFalse);
      });

      test("test 2", () {
        expect(tearDown1Run, isTrue);
        expect(tearDown2Run, isTrue);
        expect(tearDown3Run, isTrue);
      });
    });
  });

  test("can be called in addTearDown", () {
    return expectTestsPass(() {
      var tearDown2Run = false;
      var tearDown3Run = false;

      test("test 1", () {
        addTearDown(() {
          expect(tearDown2Run, isTrue);
          expect(tearDown3Run, isFalse);
          tearDown3Run = true;
        });

        addTearDown(() {
          addTearDown(() {
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isFalse);
            tearDown2Run = true;
          });
        });
      });

      test("test 2", () {
        expect(tearDown2Run, isTrue);
        expect(tearDown3Run, isTrue);
      });
    });
  });

  test("can be called in tearDown", () {
    return expectTestsPass(() {
      var tearDown2Run = false;
      var tearDown3Run = false;

      tearDown(() {
        expect(tearDown2Run, isTrue);
        expect(tearDown3Run, isFalse);
        tearDown3Run = true;
      });

      tearDown(() {
        tearDown2Run = false;
        tearDown3Run = false;

        addTearDown(() {
          expect(tearDown2Run, isFalse);
          expect(tearDown3Run, isFalse);
          tearDown2Run = true;
        });
      });

      test("test 1", () {});

      test("test 2", () {
        expect(tearDown2Run, isTrue);
        expect(tearDown3Run, isTrue);
      });
    });
  });

  test("runs before a normal tearDown", () {
    return expectTestsPass(() {
      var groupTearDownRun = false;
      var testTearDownRun = false;
      group("group", () {
        tearDown(() {
          expect(testTearDownRun, isTrue);
          expect(groupTearDownRun, isFalse);
          groupTearDownRun = true;
        });

        test("test 1", () {
          addTearDown(() {
            expect(groupTearDownRun, isFalse);
            expect(testTearDownRun, isFalse);
            testTearDownRun = true;
          });

          expect(groupTearDownRun, isFalse);
          expect(testTearDownRun, isFalse);
        });
      });

      test("test 2", () {
        expect(groupTearDownRun, isTrue);
        expect(testTearDownRun, isTrue);
      });
    });
  });

  test("runs in the same error zone as the test", () {
    return expectTestsPass(() {
      test("test", () {
        var future = new Future.error("oh no");
        expect(future, throwsA("oh no"));

        addTearDown(() {
          // If the tear-down is in a different error zone than the test, the
          // error will try to cross the zone boundary and get top-leveled.
          expect(future, throwsA("oh no"));
        });
      });
    });
  });

  group("asynchronously", () {
    test("blocks additional test tearDowns on in-band async", () {
      return expectTestsPass(() {
        var tearDown1Run = false;
        var tearDown2Run = false;
        var tearDown3Run = false;
        test("test", () {
          addTearDown(() async {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isTrue);
            expect(tearDown3Run, isTrue);
            await pumpEventQueue();
            tearDown1Run = true;
          });

          addTearDown(() async {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isTrue);
            await pumpEventQueue();
            tearDown2Run = true;
          });

          addTearDown(() async {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isFalse);
            await pumpEventQueue();
            tearDown3Run = true;
          });

          expect(tearDown1Run, isFalse);
          expect(tearDown2Run, isFalse);
          expect(tearDown3Run, isFalse);
        });
      });
    });

    test("doesn't block additional test tearDowns on out-of-band async", () {
      return expectTestsPass(() {
        var tearDown1Run = false;
        var tearDown2Run = false;
        var tearDown3Run = false;
        test("test", () {
          addTearDown(() {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isFalse);

            expect(new Future(() {
              tearDown1Run = true;
            }), completes);
          });

          addTearDown(() {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isFalse);

            expect(new Future(() {
              tearDown2Run = true;
            }), completes);
          });

          addTearDown(() {
            expect(tearDown1Run, isFalse);
            expect(tearDown2Run, isFalse);
            expect(tearDown3Run, isFalse);

            expect(new Future(() {
              tearDown3Run = true;
            }), completes);
          });

          expect(tearDown1Run, isFalse);
          expect(tearDown2Run, isFalse);
          expect(tearDown3Run, isFalse);
        });
      });
    });

    test("blocks additional group tearDowns on in-band async", () {
      return expectTestsPass(() {
        var groupTearDownRun = false;
        var testTearDownRun = false;
        tearDown(() async {
          expect(groupTearDownRun, isFalse);
          expect(testTearDownRun, isTrue);
          await pumpEventQueue();
          groupTearDownRun = true;
        });

        test("test", () {
          addTearDown(() async {
            expect(groupTearDownRun, isFalse);
            expect(testTearDownRun, isFalse);
            await pumpEventQueue();
            testTearDownRun = true;
          });

          expect(groupTearDownRun, isFalse);
          expect(testTearDownRun, isFalse);
        });
      });
    });

    test("doesn't block additional group tearDowns on out-of-band async", () {
      return expectTestsPass(() {
        var groupTearDownRun = false;
        var testTearDownRun = false;
        tearDown(() {
          expect(groupTearDownRun, isFalse);
          expect(testTearDownRun, isFalse);

          expect(new Future(() {
            groupTearDownRun = true;
          }), completes);
        });

        test("test", () {
          addTearDown(() {
            expect(groupTearDownRun, isFalse);
            expect(testTearDownRun, isFalse);

            expect(new Future(() {
              testTearDownRun = true;
            }), completes);
          });

          expect(groupTearDownRun, isFalse);
          expect(testTearDownRun, isFalse);
        });
      });
    });

    test("blocks further tests on in-band async", () {
      return expectTestsPass(() {
        var tearDownRun = false;
        test("test 1", () {
          addTearDown(() async {
            expect(tearDownRun, isFalse);
            await pumpEventQueue();
            tearDownRun = true;
          });
        });

        test("test 2", () {
          expect(tearDownRun, isTrue);
        });
      });
    });

    test("blocks further tests on out-of-band async", () {
      return expectTestsPass(() {
        var tearDownRun = false;
        test("test 1", () {
          addTearDown(() async {
            expect(tearDownRun, isFalse);
            expect(
                pumpEventQueue().then((_) {
                  tearDownRun = true;
                }),
                completes);
          });
        });

        test("after", () {
          expect(tearDownRun, isTrue);
        });
      });
    });
  });

  group("with an error", () {
    test("reports the error", () async {
      var engine = declareEngine(() {
        test("test", () {
          addTearDown(() => throw new TestFailure("fail"));
        });
      });

      var queue = new StreamQueue(engine.onTestStarted);
      var liveTestFuture = queue.next;

      expect(await engine.run(), isFalse);

      var liveTest = await liveTestFuture;
      expect(liveTest.test.name, equals("test"));
      expectTestFailed(liveTest, "fail");
    });

    test("runs further test tearDowns", () async {
      // Declare this in the outer test so if it doesn't run, the outer test
      // will fail.
      var shouldRun = expectAsync0(() {});

      var engine = declareEngine(() {
        test("test", () {
          addTearDown(() => throw "error");
          addTearDown(shouldRun);
        });
      });

      expect(await engine.run(), isFalse);
    });

    test("runs further group tearDowns", () async {
      // Declare this in the outer test so if it doesn't run, the outer test
      // will fail.
      var shouldRun = expectAsync0(() {});

      var engine = declareEngine(() {
        tearDown(shouldRun);

        test("test", () {
          addTearDown(() => throw "error");
        });
      });

      expect(await engine.run(), isFalse);
    });
  });
}
