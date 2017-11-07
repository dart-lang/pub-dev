// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'dart:io';
import 'dart:math' as math;

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/src/util/exit_codes.dart' as exit_codes;
import 'package:test/test.dart';

import '../io.dart';

final _success = """
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {});
}
""";

final _failure = """
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("failure", () => throw new TestFailure("oh no"));
}
""";

final _asyncFailure = """
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("failure", () async{
    await new Future((){});
    await new Future((){});
    throw "oh no";
  });
}
""";

final _defaultConcurrency = math.max(1, Platform.numberOfProcessors ~/ 2);

final _browsers =
    "[vm (default), dartium, content-shell, chrome, phantomjs, firefox" +
        (Platform.isMacOS ? ", safari" : "") +
        (Platform.isWindows ? ", ie" : "") +
        ", node]";

final _usage = """
Usage: pub run test [files or directories...]

-h, --help                       Shows this usage information.
    --version                    Shows the package's version.

======== Selecting Tests
-n, --name                       A substring of the name of the test to run.
                                 Regular expression syntax is supported.
                                 If passed multiple times, tests must match all substrings.

-N, --plain-name                 A plain-text substring of the name of the test to run.
                                 If passed multiple times, tests must match all substrings.

-t, --tags                       Run only tests with all of the specified tags.
                                 Supports boolean selector syntax.

-x, --exclude-tags               Don't run tests with any of the specified tags.
                                 Supports boolean selector syntax.

    --[no-]run-skipped           Run skipped tests instead of skipping them.

======== Running Tests
-p, --platform                   The platform(s) on which to run the tests.
                                 $_browsers

-P, --preset                     The configuration preset(s) to use.
-j, --concurrency=<threads>      The number of concurrent test suites run.
                                 (defaults to "$_defaultConcurrency")

    --pub-serve=<port>           The port of a pub serve instance serving "test/".
    --timeout                    The default test timeout. For example: 15s, 2x, none
                                 (defaults to "30s")

    --pause-after-load           Pauses for debugging before any tests execute.
                                 Implies --concurrency=1 and --timeout=none.
                                 Currently only supported for browser tests.

    --[no-]chain-stack-traces    Chained stack traces to provide greater exception details
                                 especially for asynchronous code. It may be useful to disable
                                 to provide improved test performance but at the cost of
                                 debuggability.
                                 (defaults to on)

    --no-retry                   Don't re-run tests that have retry set.

======== Output
-r, --reporter                   The runner used to print test results.

          [compact]              A single line, updated continuously.
          [expanded]             A separate line for each update.
          [json]                 A machine-readable format (see https://goo.gl/gBsV1a).

    --verbose-trace              Whether to emit stack traces with core library frames.
    --js-trace                   Whether to emit raw JavaScript stack traces for browser tests.
    --[no-]color                 Whether to use terminal colors.
                                 (auto-detected by default)
""";

void main() {
  test("prints help information", () async {
    var test = await runTest(["--help"]);
    expectStdoutEquals(test, """
Runs tests in this package.

$_usage""");
    await test.shouldExit(0);
  });

  group("fails gracefully if", () {
    test("an invalid option is passed", () async {
      var test = await runTest(["--asdf"]);
      expectStderrEquals(test, """
Could not find an option named "asdf".

$_usage""");
      await test.shouldExit(exit_codes.usage);
    });

    test("a non-existent file is passed", () async {
      var test = await runTest(["file"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading file [E]',
            'Failed to load "file": Does not exist.'
          ]));
      await test.shouldExit(1);
    });

    test("the default directory doesn't exist", () async {
      var test = await runTest([]);
      expectStderrEquals(test, """
No test files were passed and the default "test/" directory doesn't exist.

$_usage""");
      await test.shouldExit(exit_codes.data);
    });

    test("a test file fails to load", () async {
      await d.file("test.dart", "invalid Dart file").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart":',
            "line 1 pos 1: unexpected token 'invalid'",
            "invalid Dart file",
            "^"
          ]));
      await test.shouldExit(1);
    });

    // This syntax error is detected lazily, and so requires some extra
    // machinery to support.
    test("a test file fails to parse due to a missing semicolon", () async {
      await d.file("test.dart", "void main() {foo}").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart":',
            'line 1 pos 17: semicolon expected',
            'void main() {foo}',
            '                ^'
          ]));
      await test.shouldExit(1);
    });

    // This is slightly different from the above test because it's an error
    // that's caught first by the analyzer when it's used to parse the file.
    test("a test file fails to parse", () async {
      await d.file("test.dart", "@TestOn)").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart":',
            "line 1 pos 8: unexpected token ')'",
            "@TestOn)",
            "       ^"
          ]));
      await test.shouldExit(1);
    });

    test("an annotation's structure is invalid", () async {
      await d.file("test.dart", "@TestOn()\nlibrary foo;").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart":',
            "Error on line 1, column 8: TestOn takes 1 argument.",
            "@TestOn()",
            "       ^^"
          ]));
      await test.shouldExit(1);
    });

    test("an annotation's contents are invalid", () async {
      await d.file("test.dart", "@TestOn('zim')\nlibrary foo;").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart":',
            "Error on line 1, column 10: Undefined variable.",
            "@TestOn('zim')",
            "         ^^^"
          ]));
      await test.shouldExit(1);
    });

    test("a test file throws", () async {
      await d.file("test.dart", "void main() => throw 'oh no';").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": oh no'
          ]));
      await test.shouldExit(1);
    });

    test("a test file doesn't have a main defined", () async {
      await d.file("test.dart", "void foo() {}").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": No top-level main() function defined.'
          ]));
      await test.shouldExit(1);
    });

    test("a test file has a non-function main", () async {
      await d.file("test.dart", "int main;").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Top-level main getter is not a function.'
          ]));
      await test.shouldExit(1);
    });

    test("a test file has a main with arguments", () async {
      await d.file("test.dart", "void main(arg) {}").create();
      var test = await runTest(["test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Top-level main() function takes arguments.'
          ]));
      await test.shouldExit(1);
    });

    test("multiple load errors occur", () async {
      await d.file("test.dart", "invalid Dart file").create();
      var test = await runTest(["test.dart", "nonexistent.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            'loading nonexistent.dart',
            'Failed to load "nonexistent.dart": Does not exist.',
            'loading test.dart',
            'Failed to load "test.dart":',
            "line 1 pos 1: unexpected token 'invalid'",
            "invalid Dart file",
            "^"
          ]));
      await test.shouldExit(1);
    });

    // TODO(nweiz): test what happens when a test file is unreadable once issue
    // 15078 is fixed.
  });

  group("runs successful tests", () {
    test("defined in a single file", () async {
      await d.file("test.dart", _success).create();
      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("defined in a directory", () async {
      for (var i = 0; i < 3; i++) {
        await d.file("${i}_test.dart", _success).create();
      }

      var test = await runTest(["."]);
      expect(test.stdout, emitsThrough(contains("+3: All tests passed!")));
      await test.shouldExit(0);
    });

    test("defaulting to the test directory", () async {
      await d
          .dir(
              "test",
              new Iterable.generate(3, (i) {
                return d.file("${i}_test.dart", _success);
              }))
          .create();

      var test = await runTest([]);
      expect(test.stdout, emitsThrough(contains("+3: All tests passed!")));
      await test.shouldExit(0);
    });

    test("directly", () async {
      await d.file("test.dart", _success).create();
      var test = await runDart(["test.dart"]);

      expect(test.stdout, emitsThrough(contains("All tests passed!")));
      await test.shouldExit(0);
    });

    // Regression test; this broke in 0.12.0-beta.9.
    test("on a file in a subdirectory", () async {
      await d.dir("dir", [d.file("test.dart", _success)]).create();

      var test = await runTest(["dir/test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });

  group("runs failing tests", () {
    test("defaults to chaining stack traces", () async {
      await d.file("test.dart", _asyncFailure).create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("asynchronous gap")));
      await test.shouldExit(1);
    });

    test("respects the chain-stack-traces flag", () async {
      await d.file("test.dart", _asyncFailure).create();

      var test = await runTest(["test.dart", "--no-chain-stack-traces"]);
      expect(
          test.stdout,
          containsInOrder([
            "00:00 +0: failure",
            "00:00 +0 -1: failure [E]",
            "oh no",
            "test.dart 9:5  main.<fn>",
          ]));
      await test.shouldExit(1);
    });

    test("defined in a single file", () async {
      await d.file("test.dart", _failure).create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
      await test.shouldExit(1);
    });

    test("defined in a directory", () async {
      for (var i = 0; i < 3; i++) {
        await d.file("${i}_test.dart", _failure).create();
      }

      var test = await runTest(["."]);
      expect(test.stdout, emitsThrough(contains("-3: Some tests failed.")));
      await test.shouldExit(1);
    });

    test("defaulting to the test directory", () async {
      await d
          .dir(
              "test",
              new Iterable.generate(3, (i) {
                return d.file("${i}_test.dart", _failure);
              }))
          .create();

      var test = await runTest([]);
      expect(test.stdout, emitsThrough(contains("-3: Some tests failed.")));
      await test.shouldExit(1);
    });

    test("directly", () async {
      await d.file("test.dart", _failure).create();
      var test = await runDart(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("Some tests failed.")));
      await test.shouldExit(255);
    });
  });

  test("runs tests even when a file fails to load", () async {
    await d.file("test.dart", _success).create();

    var test = await runTest(["test.dart", "nonexistent.dart"]);
    expect(test.stdout, emitsThrough(contains("+1 -1: Some tests failed.")));
    await test.shouldExit(1);
  });

  group("with a top-level @Skip declaration", () {
    setUp(() async {
      await d.file("test.dart", '''
        @Skip()

        import 'dart:async';

        import 'package:test/test.dart';

        void main() {
          test("success", () {});
        }
      ''').create();
    });

    test("skips all tests", () async {
      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+0 ~1: All tests skipped.")));
      await test.shouldExit(0);
    });

    test("runs all tests with --run-skipped", () async {
      var test = await runTest(["--run-skipped", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });

  group("with onPlatform", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () => throw 'oh no', onPlatform: {"vm": new Skip()});
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+0 ~1: All tests skipped.")));
      await test.shouldExit(0);
    });

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {"chrome": new Skip()});
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("respects matching Timeouts", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () async {
    await new Future.delayed(Duration.ZERO);
    throw 'oh no';
  }, onPlatform: {
    "vm": new Timeout(Duration.ZERO)
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

    test("ignores non-matching Timeouts", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {
    "chrome": new Timeout(new Duration(seconds: 0))
  });
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("applies matching platforms in order", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {
    "vm": new Skip("first"),
    "vm || windows": new Skip("second"),
    "vm || linux": new Skip("third"),
    "vm || mac-os": new Skip("fourth"),
    "vm || android": new Skip("fifth")
  });
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdoutStream(), neverEmits(contains("Skip: first")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: second")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: third")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: fourth")));
      expect(test.stdout, emitsThrough(contains("Skip: fifth")));
      await test.shouldExit(0);
    });

    test("applies platforms to a group", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  group("group", () {
    test("success", () {});
  }, onPlatform: {
    "vm": new Skip()
  });
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("All tests skipped.")));
      await test.shouldExit(0);
    });
  });

  group("with an @OnPlatform annotation", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
@OnPlatform(const {"vm": const Skip()})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () => throw 'oh no');
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+0 ~1: All tests skipped.")));
      await test.shouldExit(0);
    });

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
@OnPlatform(const {"chrome": const Skip()})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {});
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("respects matching Timeouts", () async {
      await d.file("test.dart", '''
@OnPlatform(const {
  "vm": const Timeout(const Duration(seconds: 0))
})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () async {
    await new Future.delayed(Duration.ZERO);
    throw 'oh no';
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

    test("ignores non-matching Timeouts", () async {
      await d.file("test.dart", '''
@OnPlatform(const {
  "chrome": const Timeout(const Duration(seconds: 0))
})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {});
}
''').create();

      var test = await runTest(["test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });

  test("with the --color flag, uses colors", () async {
    await d.file("test.dart", _failure).create();
    var test = await runTest(["--color", "test.dart"]);
    // This is the color code for red.
    expect(test.stdout, emitsThrough(contains("\u001b[31m")));
    await test.shouldExit();
  });
}
