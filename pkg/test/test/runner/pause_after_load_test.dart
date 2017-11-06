// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'dart:async';
import 'dart:io';

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/test.dart';

import '../io.dart';

void main() {
  test("pauses the test runner for each file until the user presses enter",
      () async {
    await d.file("test1.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test 1!');

  test("success", () {});
}
""").create();

    await d.file("test2.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test 2!');

  test("success", () {});
}
""").create();

    var test = await runTest(
        ["--pause-after-load", "-p", "dartium", "test1.dart", "test2.dart"]);
    await expectLater(test.stdout, emitsThrough("loaded test 1!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    var nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+0: test1.dart: success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();

    await expectLater(test.stdout, emitsThrough("loaded test 2!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+1: test2.dart: success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();
    await expectLater(
        test.stdout, emitsThrough(contains("+2: All tests passed!")));
    await test.shouldExit(0);
  }, tags: 'dartium');

  test("pauses the test runner for each platform until the user presses enter",
      () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test!');

  test("success", () {});
}
""").create();

    var test = await runTest(
        ["--pause-after-load", "-p", "dartium", "-p", "chrome", "test.dart"]);
    await expectLater(test.stdout, emitsThrough("loaded test!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    var nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+0: [Dartium] success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();

    await expectLater(test.stdout, emitsThrough("loaded test!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          "The test runner is paused. Open the dev console in Chrome and set "
              "breakpoints. Once you're finished,",
          "return to this terminal and press Enter."
        ])));

    nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+1: [Chrome] success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();
    await expectLater(
        test.stdout, emitsThrough(contains("+2: All tests passed!")));
    await test.shouldExit(0);
  }, tags: ['dartium', 'chrome']);

  test("prints a warning and doesn't pause for unsupported platforms",
      () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  test("success", () {});
}
""").create();

    var test = await runTest(["--pause-after-load", "-p", "vm", "test.dart"]);
    await expectLater(test.stderr,
        emits("Warning: Debugging is currently unsupported on the Dart VM."));
    await expectLater(
        test.stdout, emitsThrough(contains("+1: All tests passed!")));
    await test.shouldExit(0);
  });

  test("can mix supported and unsupported platforms", () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test!');

  test("success", () {});
}
""").create();

    var test = await runTest(
        ["--pause-after-load", "-p", "dartium", "-p", "vm", "test.dart"]);
    await expectLater(test.stderr,
        emits("Warning: Debugging is currently unsupported on the Dart VM."));

    await expectLater(test.stdout, emitsThrough("loaded test!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    var nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+0: [Dartium] success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();

    await expectLater(
        test.stdout,
        containsInOrder(
            ["loaded test!", "+1: [VM] success", "+2: All tests passed!"]));
    await test.shouldExit(0);
  }, tags: 'dartium');

  test("stops immediately if killed while paused", () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test!');

  test("success", () {});
}
""").create();

    var test =
        await runTest(["--pause-after-load", "-p", "dartium", "test.dart"]);
    await expectLater(test.stdout, emitsThrough("loaded test!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    test.signal(ProcessSignal.SIGTERM);
    await test.shouldExit();
    await expectLater(test.stderr, emitsDone);
  }, tags: 'dartium', testOn: "!windows");

  test("disables timeouts", () async {
    await d.file("test.dart", """
import 'dart:async';

import 'package:test/test.dart';

void main() {
  print('loaded test 1!');

  test("success", () async {
    await new Future.delayed(Duration.ZERO);
  }, timeout: new Timeout(Duration.ZERO));
}
""").create();

    var test = await runTest(
        ["--pause-after-load", "-p", "dartium", "-n", "success", "test.dart"]);
    await expectLater(test.stdout, emitsThrough("loaded test 1!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    var nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+0: success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();
    await expectLater(
        test.stdout, emitsThrough(contains("+1: All tests passed!")));
    await test.shouldExit(0);
  }, tags: 'dartium');

  // Regression test for #304.
  test("supports test name patterns", () async {
    await d.file("test.dart", """
import 'package:test/test.dart';

void main() {
  print('loaded test 1!');

  test("failure 1", () {});
  test("success", () {});
  test("failure 2", () {});
}
""").create();

    var test = await runTest(
        ["--pause-after-load", "-p", "dartium", "-n", "success", "test.dart"]);
    await expectLater(test.stdout, emitsThrough("loaded test 1!"));
    await expectLater(
        test.stdout,
        emitsThrough(emitsInOrder([
          startsWith("Observatory URL: "),
          "The test runner is paused. Open the dev console in Dartium or the "
              "Observatory and set breakpoints.",
          "Once you're finished, return to this terminal and press Enter."
        ])));

    var nextLineFired = false;
    test.stdout.next.then(expectAsync1((line) {
      expect(line, contains("+0: success"));
      nextLineFired = true;
    }));

    // Wait a little bit to be sure that the tests don't start running without
    // our input.
    await new Future.delayed(new Duration(seconds: 2));
    expect(nextLineFired, isFalse);

    test.stdin.writeln();
    await expectLater(
        test.stdout, emitsThrough(contains("+1: All tests passed!")));
    await test.shouldExit(0);
  }, tags: 'dartium');
}
