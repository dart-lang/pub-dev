// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import '../../utils.dart';

void main() {
  group("synchronous", () {
    test("passes with an expected print", () {
      expect(() => print("Hello, world!"), prints("Hello, world!\n"));
    });

    test("combines multiple prints", () {
      expect(() {
        print("Hello");
        print("World!");
      }, prints("Hello\nWorld!\n"));
    });

    test("works with a Matcher", () {
      expect(() => print("Hello, world!"), prints(contains("Hello")));
    });

    test("describes a failure nicely", () async {
      var closure = () => print("Hello, world!");
      var liveTest = await runTestBody(() {
        expect(closure, prints("Goodbye, world!\n"));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints 'Goodbye, world!\\n'\n"
                "            ''\n"
                "  Actual: <"),
            endsWith(">\n"
                "   Which: printed 'Hello, world!\\n'\n"
                "                    ''\n"
                "            which is different.\n"
                "                  Expected: Goodbye, w ...\n"
                "                    Actual: Hello, wor ...\n"
                "                            ^\n"
                "                   Differ at offset 0\n")
          ]));
    });

    test("describes a failure with a non-descriptive Matcher nicely", () async {
      var closure = () => print("Hello, world!");
      var liveTest = await runTestBody(() {
        expect(closure, prints(contains("Goodbye")));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints contains 'Goodbye'\n"
                "  Actual: <"),
            endsWith(">\n"
                "   Which: printed 'Hello, world!\\n'\n"
                "                    ''\n")
          ]));
    });

    test("describes a failure with no text nicely", () async {
      var closure = () {};
      var liveTest = await runTestBody(() {
        expect(closure, prints(contains("Goodbye")));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints contains 'Goodbye'\n"
                "  Actual: <"),
            endsWith(">\n"
                "   Which: printed nothing\n")
          ]));
    });

    test("with a non-function", () async {
      var liveTest = await runTestBody(() {
        expect(10, prints(contains("Goodbye")));
      });

      expectTestFailed(
          liveTest,
          "Expected: prints contains 'Goodbye'\n"
          "  Actual: <10>\n"
          "   Which: was not a Function\n");
    });
  });

  group('asynchronous', () {
    test("passes with an expected print", () {
      expect(() => new Future(() => print("Hello, world!")),
          prints("Hello, world!\n"));
    });

    test("combines multiple prints", () {
      expect(
          () => new Future(() {
                print("Hello");
                print("World!");
              }),
          prints("Hello\nWorld!\n"));
    });

    test("works with a Matcher", () {
      expect(() => new Future(() => print("Hello, world!")),
          prints(contains("Hello")));
    });

    test("describes a failure nicely", () async {
      var closure = () => new Future(() => print("Hello, world!"));
      var liveTest = await runTestBody(() {
        expect(closure, prints("Goodbye, world!\n"));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints 'Goodbye, world!\\n'\n"
                "            ''\n"
                "  Actual: <"),
            contains(">\n"
                "   Which: printed 'Hello, world!\\n'\n"
                "                    ''\n"
                "            which is different.\n"
                "                  Expected: Goodbye, w ...\n"
                "                    Actual: Hello, wor ...\n"
                "                            ^\n"
                "                   Differ at offset 0")
          ]));
    });

    test("describes a failure with a non-descriptive Matcher nicely", () async {
      var closure = () => new Future(() => print("Hello, world!"));
      var liveTest = await runTestBody(() {
        expect(closure, prints(contains("Goodbye")));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints contains 'Goodbye'\n"
                "  Actual: <"),
            contains(">\n"
                "   Which: printed 'Hello, world!\\n'\n"
                "                    ''")
          ]));
    });

    test("describes a failure with no text nicely", () async {
      var closure = () => new Future.value();
      var liveTest = await runTestBody(() {
        expect(closure, prints(contains("Goodbye")));
      });

      expectTestFailed(
          liveTest,
          allOf([
            startsWith("Expected: prints contains 'Goodbye'\n"
                "  Actual: <"),
            contains(">\n"
                "   Which: printed nothing")
          ]));
    });

    test("won't let the test end until the Future completes", () {
      return expectTestBlocks(() {
        var completer = new Completer();
        expect(() => completer.future, prints(isEmpty));
        return completer;
      }, (completer) => completer.complete());
    });

    test("blocks expectLater's Future", () async {
      var completer = new Completer();
      var fired = false;
      expectLater(() {
        scheduleMicrotask(() => print("hello!"));
        return completer.future;
      }, prints("hello!\n")).then((_) {
        fired = true;
      });

      await pumpEventQueue();
      expect(fired, isFalse);

      completer.complete();
      await pumpEventQueue();
      expect(fired, isTrue);
    });
  });
}
