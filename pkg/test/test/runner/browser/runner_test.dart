// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

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
      var test = await runTest(["-p", "chrome", "test.dart"]);

      expect(
          test.stdout,
          containsInOrder([
            "Expected a declaration, but got 'invalid'",
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": dart2js failed.'
          ]));
      await test.shouldExit(1);
    }, tags: 'chrome');

    test("a test file throws", () async {
      await d.file("test.dart", "void main() => throw 'oh no';").create();

      var test = await runTest(["-p", "chrome", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": oh no'
          ]));
      await test.shouldExit(1);
    }, tags: 'chrome');

    test("a test file doesn't have a main defined", () async {
      await d.file("test.dart", "void foo() {}").create();

      var test = await runTest(["-p", "chrome", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": No top-level main() function defined.'
          ]));
      await test.shouldExit(1);
    }, tags: 'chrome');

    test("a test file has a non-function main", () async {
      await d.file("test.dart", "int main;").create();

      var test = await runTest(["-p", "chrome", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": Top-level main getter is not a function.'
          ]));
      await test.shouldExit(1);
    }, tags: 'chrome');

    test("a test file has a main with arguments", () async {
      await d.file("test.dart", "void main(arg) {}").create();

      var test = await runTest(["-p", "chrome", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: compiling test.dart [E]',
            'Failed to load "test.dart": Top-level main() function takes arguments.'
          ]));
      await test.shouldExit(1);
    }, tags: 'chrome');

    test("a custom HTML file has no script tag", () async {
      await d.file("test.dart", "void main() {}").create();

      await d.file("test.html", """
<html>
<head>
  <link rel="x-dart-test" href="test.dart">
</head>
</html>
""").create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": "test.html" must contain '
                '<script src="packages/test/dart.js"></script>.'
          ]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("a custom HTML file has no link", () async {
      await d.file("test.dart", "void main() {}").create();

      await d.file("test.html", """
<html>
<head>
  <script src="packages/test/dart.js"></script>
</head>
</html>
""").create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Expected exactly 1 '
                '<link rel="x-dart-test"> in test.html, found 0.'
          ]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("a custom HTML file has too many links", () async {
      await d.file("test.dart", "void main() {}").create();

      await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test' href='test.dart'>
  <link rel='x-dart-test' href='test.dart'>
  <script src="packages/test/dart.js"></script>
</head>
</html>
""").create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Expected exactly 1 '
                '<link rel="x-dart-test"> in test.html, found 2.'
          ]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("a custom HTML file has no href in the link", () async {
      await d.file("test.dart", "void main() {}").create();

      await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test'>
  <script src="packages/test/dart.js"></script>
</head>
</html>
""").create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Expected <link rel="x-dart-test"> in '
                'test.html to have an "href" attribute.'
          ]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("a custom HTML file has an invalid test URL", () async {
      await d.file("test.dart", "void main() {}").create();

      await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test' href='wrong.dart'>
  <script src="packages/test/dart.js"></script>
</head>
</html>
""").create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder([
            '-1: loading test.dart [E]',
            'Failed to load "test.dart": Failed to load script at '
          ]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    // TODO(nweiz): test what happens when a test file is unreadable once issue
    // 15078 is fixed.
  });

  group("runs successful tests", () {
    test("on a JS and non-JS browser", () async {
      await d.file("test.dart", _success).create();
      var test =
          await runTest(["-p", "content-shell", "-p", "chrome", "test.dart"]);

      expect(test.stdoutStream(),
          neverEmits(contains("[Dartium Content Shell] compiling")));
      expect(test.stdout, emitsThrough(contains("[Chrome] compiling")));
      await test.shouldExit(0);
    }, tags: ['chrome', 'content-shell']);

    test("on a browser and the VM", () async {
      await d.file("test.dart", _success).create();
      var test =
          await runTest(["-p", "content-shell", "-p", "vm", "test.dart"]);

      expect(test.stdout, emitsThrough(contains("+2: All tests passed!")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("with setUpAll", () async {
      await d.file("test.dart", r"""
          import 'package:test/test.dart';

          void main() {
            setUpAll(() => print("in setUpAll"));

            test("test", () {});
          }
          """).create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains('+0: (setUpAll)')));
      expect(test.stdout, emits('in setUpAll'));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("with tearDownAll", () async {
      await d.file("test.dart", r"""
          import 'package:test/test.dart';

          void main() {
            tearDownAll(() => print("in tearDownAll"));

            test("test", () {});
          }
          """).create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains('+1: (tearDownAll)')));
      expect(test.stdout, emits('in tearDownAll'));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    // Regression test; this broke in 0.12.0-beta.9.
    test("on a file in a subdirectory", () async {
      await d.dir("dir", [d.file("test.dart", _success)]).create();

      var test = await runTest(["-p", "chrome", "dir/test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    }, tags: 'chrome');

    group("with a custom HTML file", () {
      setUp(() async {
        await d.file("test.dart", """
import 'dart:html';

import 'package:test/test.dart';

void main() {
  test("success", () {
    expect(document.query('#foo'), isNotNull);
  });
}
""").create();

        await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test' href='test.dart'>
  <script src="packages/test/dart.js"></script>
</head>
<body>
  <div id="foo"></div>
</body>
</html>
""").create();
      });

      test("on content shell", () async {
        var test = await runTest(["-p", "content-shell", "test.dart"]);
        expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
        await test.shouldExit(0);
      }, tags: 'content-shell');

      test("on Chrome", () async {
        var test = await runTest(["-p", "chrome", "test.dart"]);
        expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
        await test.shouldExit(0);
      }, tags: 'chrome');

      // Regression test for https://github.com/dart-lang/test/issues/82.
      test("ignores irrelevant link tags", () async {
        await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test-not'>
  <link rel='other' href='test.dart'>
  <link rel='x-dart-test' href='test.dart'>
  <script src="packages/test/dart.js"></script>
</head>
<body>
  <div id="foo"></div>
</body>
</html>
""").create();

        var test = await runTest(["-p", "content-shell", "test.dart"]);
        expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
        await test.shouldExit(0);
      }, tags: 'content-shell');
    });
  });

  group("runs failing tests", () {
    test("that fail only on the browser", () async {
      await d.file("test.dart", """
import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test("test", () {
    if (p.style == p.Style.url) throw new TestFailure("oh no");
  });
}
""").create();

      var test =
          await runTest(["-p", "content-shell", "-p", "vm", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1 -1: Some tests failed.")));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("that fail only on the VM", () async {
      await d.file("test.dart", """
import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  test("test", () {
    if (p.style != p.Style.url) throw new TestFailure("oh no");
  });
}
""").create();

      var test =
          await runTest(["-p", "content-shell", "-p", "vm", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1 -1: Some tests failed.")));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    group("with a custom HTML file", () {
      setUp(() async {
        await d.file("test.dart", """
import 'dart:html';

import 'package:test/test.dart';

void main() {
  test("failure", () {
    expect(document.query('#foo'), isNull);
  });
}
""").create();

        await d.file("test.html", """
<html>
<head>
  <link rel='x-dart-test' href='test.dart'>
  <script src="packages/test/dart.js"></script>
</head>
<body>
  <div id="foo"></div>
</body>
</html>
""").create();
      });

      test("on content shell", () async {
        var test = await runTest(["-p", "content-shell", "test.dart"]);
        expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
        await test.shouldExit(1);
      }, tags: 'content-shell');

      test("on Chrome", () async {
        var test = await runTest(["-p", "chrome", "test.dart"]);
        expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
        await test.shouldExit(1);
      }, tags: 'chrome');
    });
  });

  test("the compiler uses colors if the test runner uses colors", () async {
    await d.file("test.dart", "String main() => 12;\n").create();

    var test = await runTest(["--color", "-p", "chrome", "test.dart"]);
    expect(test.stdout, emitsThrough(contains('\u001b[35m')));
    await test.shouldExit(1);
  }, tags: 'chrome');

  test("forwards prints from the browser test", () async {
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

    var test = await runTest(["-p", "content-shell", "test.dart"]);
    expect(test.stdout, emitsInOrder([emitsThrough("Hello,"), "world!"]));
    await test.shouldExit(0);
  }, tags: 'content-shell');

  test("dartifies stack traces for JS-compiled tests by default", () async {
    await d.file("test.dart", _failure).create();

    var test = await runTest(["-p", "chrome", "--verbose-trace", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            [" main.<fn>", "package:test", "dart:async/zone.dart"]));
    await test.shouldExit(1);
  }, tags: 'chrome');

  test("doesn't dartify stack traces for JS-compiled tests with --js-trace",
      () async {
    await d.file("test.dart", _failure).create();

    var test = await runTest(
        ["-p", "chrome", "--verbose-trace", "--js-trace", "test.dart"]);
    expect(test.stdoutStream(), neverEmits(endsWith(" main.<fn>")));
    expect(test.stdoutStream(), neverEmits(contains("package:test")));
    expect(test.stdoutStream(), neverEmits(contains("dart:async/zone.dart")));
    expect(test.stdout, emitsThrough(contains("-1: Some tests failed.")));
    await test.shouldExit(1);
  }, tags: 'chrome');

  test("respects top-level @Timeout declarations", () async {
    await d.file("test.dart", '''
@Timeout(const Duration(seconds: 0))

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("timeout", () => new Future.delayed(Duration.ZERO));
}
''').create();

    var test = await runTest(["-p", "content-shell", "test.dart"]);
    expect(
        test.stdout,
        containsInOrder(
            ["Test timed out after 0 seconds.", "-1: Some tests failed."]));
    await test.shouldExit(1);
  }, tags: 'content-shell');

  group("with onPlatform", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () => throw 'oh no', onPlatform: {"browser": new Skip()});
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+0 ~1: All tests skipped.")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {"vm": new Skip()});
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("respects matching Timeouts", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () async {
    await new Future.delayed(Duration.ZERO);
    throw 'oh no';
  }, onPlatform: {
    "browser": new Timeout(Duration.ZERO)
  });
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder(
              ["Test timed out after 0 seconds.", "-1: Some tests failed."]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("ignores non-matching Timeouts", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {
    "vm": new Timeout(new Duration(seconds: 0))
  });
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("applies matching platforms in order", () async {
      await d.file("test.dart", '''
import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {}, onPlatform: {
    "browser": new Skip("first"),
    "browser || windows": new Skip("second"),
    "browser || linux": new Skip("third"),
    "browser || mac-os": new Skip("fourth"),
    "browser || android": new Skip("fifth")
  });
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdoutStream(), neverEmits(contains("Skip: first")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: second")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: third")));
      expect(test.stdoutStream(), neverEmits(contains("Skip: fourth")));
      expect(test.stdout, emitsThrough(contains("Skip: fifth")));
      await test.shouldExit(0);
    }, tags: 'content-shell');
  });

  group("with an @OnPlatform annotation", () {
    test("respects matching Skips", () async {
      await d.file("test.dart", '''
@OnPlatform(const {"browser": const Skip()})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("fail", () => throw 'oh no');
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("~1: All tests skipped.")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("ignores non-matching Skips", () async {
      await d.file("test.dart", '''
@OnPlatform(const {"vm": const Skip()})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {});
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(test.stdout, emitsThrough(contains("+1: All tests passed!")));
      await test.shouldExit(0);
    }, tags: 'content-shell');

    test("respects matching Timeouts", () async {
      await d.file("test.dart", '''
@OnPlatform(const {
  "browser": const Timeout(const Duration(seconds: 0))
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

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      expect(
          test.stdout,
          containsInOrder(
              ["Test timed out after 0 seconds.", "-1: Some tests failed."]));
      await test.shouldExit(1);
    }, tags: 'content-shell');

    test("ignores non-matching Timeouts", () async {
      await d.file("test.dart", '''
@OnPlatform(const {
  "vm": const Timeout(const Duration(seconds: 0))
})

import 'dart:async';

import 'package:test/test.dart';

void main() {
  test("success", () {});
}
''').create();

      var test = await runTest(["-p", "content-shell", "test.dart"]);
      await test.shouldExit(0);
    }, tags: 'content-shell');
  });
}
