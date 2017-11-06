// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/src/util/exit_codes.dart' as exit_codes;
import 'package:test/test.dart';

import '../io.dart';

void main() {
  group("with the --name flag,", () {
    test("selects tests with matching names", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("selected 1", () {});
          test("nope", () => throw new TestFailure("oh no"));
          test("selected 2", () {});
        }
      """).create();

      var test = await runTest(["--name", "selected", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
      await test.shouldExit(0);
    });

    test("supports RegExp syntax", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("test 1", () {});
          test("test 2", () => throw new TestFailure("oh no"));
          test("test 3", () {});
        }
      """).create();

      var test = await runTest(["--name", "test [13]", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
      await test.shouldExit(0);
    });

    test("selects more narrowly when passed multiple times", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("selected 1", () {});
          test("nope", () => throw new TestFailure("oh no"));
          test("selected 2", () {});
        }
      """).create();

      var test =
          await runTest(["--name", "selected", "--name", "1", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("produces an error when no tests match", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("test", () {});
        }
      """).create();

      var test = await runTest(["--name", "no match", "test.dart"]);
      expect(
          test.stderr,
          emitsThrough(
              contains('No tests match regular expression "no match".')));
      await test.shouldExit(exit_codes.data);
    });

    test("doesn't filter out load exceptions", () async {
      var test = await runTest(["--name", "name", "file"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading file [E]',
            '  Failed to load "file": Does not exist.'
          ]));
      await test.shouldExit(1);
    });
  });

  group("with the --plain-name flag,", () {
    test("selects tests with matching names", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("selected 1", () {});
          test("nope", () => throw new TestFailure("oh no"));
          test("selected 2", () {});
        }
      """).create();

      var test = await runTest(["--plain-name", "selected", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
      await test.shouldExit(0);
    });

    test("doesn't support RegExp syntax", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("test 1", () => throw new TestFailure("oh no"));
          test("test 2", () => throw new TestFailure("oh no"));
          test("test [12]", () {});
        }
      """).create();

      var test = await runTest(["--plain-name", "test [12]", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("selects more narrowly when passed multiple times", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("selected 1", () {});
          test("nope", () => throw new TestFailure("oh no"));
          test("selected 2", () {});
        }
      """).create();

      var test = await runTest(
          ["--plain-name", "selected", "--plain-name", "1", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    });

    test("produces an error when no tests match", () async {
      await d.file("test.dart", """
        import 'package:test/test.dart';

        void main() {
          test("test", () {});
        }
      """).create();

      var test = await runTest(["--plain-name", "no match", "test.dart"]);
      expect(test.stderr, emitsThrough(contains('No tests match "no match".')));
      await test.shouldExit(exit_codes.data);
    });
  });

  test("--name and --plain-name together narrow the selection", () async {
    await d.file("test.dart", """
      import 'package:test/test.dart';

      void main() {
        test("selected 1", () {});
        test("nope", () => throw new TestFailure("oh no"));
        test("selected 2", () {});
      }
    """).create();

    var test =
        await runTest(["--name", ".....", "--plain-name", "e", "test.dart"]);
    expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
    await test.shouldExit(0);
  });
}
