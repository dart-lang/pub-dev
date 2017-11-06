// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
@Tags(const ["node"])

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/test.dart';

import '../../io.dart';

final _success = """
  import 'package:test/test.dart';

  void main() {
    test("success", () {});
  }
""";

final _failure = """
  import 'package:test/test.dart';

  void main() {
    test("failure", () => throw new TestFailure("oh no"));
  }
""";

void main() {
  group("fails gracefully if", () {
    test("a test file fails to compile", () async {
      await d.file("test.dart", "invalid Dart file").create();
      var test = await runTest(["-p", "node", "test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            "Expected a declaration, but got 'invalid'",
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": dart2js failed.'
          ]));
      await test.shouldExit(1);
    });

    test("a test file throws", () async {
      await d.file("test.dart", "void main() => throw 'oh no';").create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": oh no'
          ]));
      await test.shouldExit(1);
    });

    test("a test file doesn't have a main defined", () async {
      await d.file("test.dart", "void foo() {}").create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": No top-level main() function defined.'
          ]));
      await test.shouldExit(1);
    });

    test("a test file has a non-function main", () async {
      await d.file("test.dart", "int main;").create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": Top-level main getter is not a function.'
          ]));
      await test.shouldExit(1);
    });

    test("a test file has a main with arguments", () async {
      await d.file("test.dart", "void main(arg) {}").create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": Top-level main() function takes arguments.'
          ]));
      await test.shouldExit(1);
    });
  });

  group("runs successful tests", () {
    test("on Node and the VM", () async {
      await d.file("test.dart", _success).create();
      var test = await runTest(["-p", "node", "-p", "vm", "test.dart"]);

      expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
      await test.shouldExit(0);
    });

    // Regression test; this broke in 0.12.0-beta.9.
    test("on a file in a subdirectory", () async {
      await d.dir("dir", [d.file("test.dart", _success)]).create();

      var test = await runTest(["-p", "node", "dir/test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });

  test("defines a node environment constant", () async {
    await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("test", () {
            expect(const bool.fromEnvironment("node"), isTrue);
          });
        }
      """).create();

    var test = await runTest(["-p", "node", "test.dart"]);
    expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
    await test.shouldExit(0);
  });

  test("runs failing tests that fail only on node", () async {
    await d.file("test.dart", """
        import 'package:path/path.dart' as p;
        import 'package:test/test.dart';

        void main() {
          test("test", () {
            if (const bool.fromEnvironment("node")) {
              throw new TestFailure("oh no");
            }
          });
        }
      """).create();

    var test = await runTest(["-p", "node", "-p", "vm", "test.dart"]);
    expect(test.stdout, emitsThrough(contains("+1 -1: Some tests failed.")));
    await test.shouldExit(1);
  });

  test("forwards prints from the Node test", () async {
    await d.file("test.dart", """
      import 'dart:async';

      import 'package:test/test.dart';

      void main() {
        test("test", () {
          print("Hello,");
          return new Future(() => print("world!"));
        });
      }
    """).create();

    var test = await runTest(["-p", "node", "test.dart"]);
    expect(test.stdout, emitsInOrder([emitsThrough("Hello,"), "world!"]));
    await test.shouldExit(0);
  });

  test("dartifies stack traces for JS-compiled tests by default", () async {
    await d.file("test.dart", _failure).create();

    var test = await runTest(["-p", "node", "--verbose-trace", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            [" main.<fn>", "package:test", "dart:async/zone.dart"]));
    await test.shouldExit(1);
  });

  test("doesn't dartify stack traces for JS-compiled tests with --js-trace",
      () async {
    await d.file("test.dart", _failure).create();

    var test = await runTest(
        ["-p", "node", "--verbose-trace", "--js-trace", "test.dart"]);
    expect(test.stdoutStream(), neverEmits(endsWith(" main.<fn>")));
    expect(test.stdoutStream(), neverEmits(contains("package:test")));
    expect(test.stdoutStream(), neverEmits(contains("dart:async/zone.dart")));
    expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
    await test.shouldExit(1);
  });

  group("with onPlatform", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
        import 'dart:async';

        import 'package:test/test.dart';

        void main() {
          test("fail", () => throw 'oh no', onPlatform: {"node": new Skip()});
        }
      ''').create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+0 ~1: All tests skipped.")));
      await test.shouldExit(0);
    });

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
        import 'dart:async';

        import 'package:test/test.dart';

        void main() {
          test("success", () {}, onPlatform: {"browser": new Skip()});
        }
      ''').create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });

  group("with an @OnPlatform annotation", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
        @OnPlatform(const {"js": const Skip()})

        import 'dart:async';

        import 'package:test/test.dart';

        void main() {
          test("fail", () => throw 'oh no');
        }
      ''').create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("~1: All tests skipped.")));
      await test.shouldExit(0);
    });

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
        @OnPlatform(const {"vm": const Skip()})

        import 'dart:async';

        import 'package:test/test.dart';

        void main() {
          test("success", () {});
        }
      ''').create();

      var test = await runTest(["-p", "node", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });
  });
}
