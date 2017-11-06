// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/test.dart';

import '../io.dart';

void main() {
  test("respects top-level @Timeout declarations", () async {
    await d.file("test.dart", '''
@Timeout(const Duration(seconds: 0))

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("timeout", () async {
    await new Future.delayed(Duration.ZERO);
  });
}
''').create();

    var test = await runTest(["test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            ["Test timed out after 0 seconds.", "-1: Some tests failed."]));
    await test.shouldExit(1);
  });

  test("respects the --timeout flag", () async {
    await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("timeout", () async {
    await new Future.delayed(Duration.ZERO);
  });
}
''').create();

    var test = await runTest(["--timeout=0s", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            ["Test timed out after 0 seconds.", "-1: Some tests failed."]));
    await test.shouldExit(1);
  });

  test("timeout is reset with each retry", () async {
    await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  var runCount = 0;
  test("timeout", () async {
    runCount++;
    if (runCount <=2) {
      await new Future.delayed(new Duration(milliseconds: 1000));
    }
  }, retry: 3);
}
''').create();

    var test = await runTest(["--timeout=400ms", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder([
          "Test timed out after 0.4 seconds.",
          "Test timed out after 0.4 seconds.",
          "+1: All tests passed!"
        ]));
    await test.shouldExit(0);
  });

  test("the --timeout flag applies on top of the default 30s timeout",
      () async {
    await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("no timeout", () async {
    await new Future.delayed(new Duration(milliseconds: 250));
  });

  test("timeout", () async {
    await new Future.delayed(new Duration(milliseconds: 750));
  });
}
''').create();

    // This should make the timeout about 500ms, which should cause exactly one
    // test to fail.
    var test = await runTest(["--timeout=0.016x", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            ["Test timed out after 0.4 seconds.", "-1: Some tests failed."]));
    await test.shouldExit(1);
  });
}
