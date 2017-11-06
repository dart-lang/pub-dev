// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart' as p;

import 'package:test_descriptor/test_descriptor.dart' as d;

import 'package:test/src/runner/version.dart';
import 'package:test/test.dart';

import '../io.dart';

/// The first event emitted by the JSON reporter.
final _start = {
  "type": "start",
  "protocolVersion": "0.1.0",
  "runnerVersion": testVersion
};

void main() {
  test("runs several successful tests and reports when each completes", () {
    return _expectReport("""
      test('success 1', () {});
      test('success 2', () {});
      test('success 3', () {});
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 3),
      _testStart(3, "success 1", line: 6, column: 7),
      _testDone(3),
      _testStart(4, "success 2", line: 7, column: 7),
      _testDone(4),
      _testStart(5, "success 3", line: 8, column: 7),
      _testDone(5),
      _done()
    ]);
  });

  test("runs several failing tests and reports when each fails", () {
    return _expectReport("""
      test('failure 1', () => throw new TestFailure('oh no'));
      test('failure 2', () => throw new TestFailure('oh no'));
      test('failure 3', () => throw new TestFailure('oh no'));
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 3),
      _testStart(3, "failure 1", line: 6, column: 7),
      _error(3, "oh no", isFailure: true),
      _testDone(3, result: "failure"),
      _testStart(4, "failure 2", line: 7, column: 7),
      _error(4, "oh no", isFailure: true),
      _testDone(4, result: "failure"),
      _testStart(5, "failure 3", line: 8, column: 7),
      _error(5, "oh no", isFailure: true),
      _testDone(5, result: "failure"),
      _done(success: false)
    ]);
  });

  test("includes the full stack trace with --verbose-trace", () async {
    await d.file("test.dart", """
      import 'dart:async';

      import 'package:test/test.dart';

      void main() {
        test("failure", () => throw "oh no");
      }
    """).create();

    var test =
        await runTest(["--verbose-trace", "test.dart"], reporter: "json");
    expect(test.stdout, emitsThrough(contains("dart:isolate-patch")));
    await test.shouldExit(1);
  });

  test("runs failing tests along with successful tests", () {
    return _expectReport("""
      test('failure 1', () => throw new TestFailure('oh no'));
      test('success 1', () {});
      test('failure 2', () => throw new TestFailure('oh no'));
      test('success 2', () {});
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 4),
      _testStart(3, "failure 1", line: 6, column: 7),
      _error(3, "oh no", isFailure: true),
      _testDone(3, result: "failure"),
      _testStart(4, "success 1", line: 7, column: 7),
      _testDone(4),
      _testStart(5, "failure 2", line: 8, column: 7),
      _error(5, "oh no", isFailure: true),
      _testDone(5, result: "failure"),
      _testStart(6, "success 2", line: 9, column: 7),
      _testDone(6),
      _done(success: false)
    ]);
  });

  test("gracefully handles multiple test failures in a row", () {
    return _expectReport("""
      // This completer ensures that the test isolate isn't killed until all
      // errors have been thrown.
      var completer = new Completer();
      test('failures', () {
        new Future.microtask(() => throw 'first error');
        new Future.microtask(() => throw 'second error');
        new Future.microtask(() => throw 'third error');
        new Future.microtask(completer.complete);
      });
      test('wait', () => completer.future);
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 2),
      _testStart(3, "failures", line: 9, column: 7),
      _error(3, "first error"),
      _error(3, "second error"),
      _error(3, "third error"),
      _testDone(3, result: "error"),
      _testStart(4, "wait", line: 15, column: 7),
      _testDone(4),
      _done(success: false)
    ]);
  });

  test("gracefully handles a test failing after completion", () {
    return _expectReport("""
      // These completers ensure that the first test won't fail until the second
      // one is running, and that the test isolate isn't killed until all errors
      // have been thrown.
      var waitStarted = new Completer();
      var testDone = new Completer();
      test('failure', () {
        waitStarted.future.then((_) {
          new Future.microtask(testDone.complete);
          throw 'oh no';
        });
      });
      test('wait', () {
        waitStarted.complete();
        return testDone.future;
      });
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 2),
      _testStart(3, "failure", line: 11, column: 7),
      _testDone(3),
      _testStart(4, "wait", line: 17, column: 7),
      _error(3, "oh no"),
      _error(
          3,
          "This test failed after it had already completed. Make sure to "
          "use [expectAsync]\n"
          "or the [completes] matcher when testing async code."),
      _testDone(4),
      _done(success: false)
    ]);
  });

  test("reports each test in its proper groups", () {
    return _expectReport("""
      group('group 1', () {
        group('.2', () {
          group('.3', () {
            test('success', () {});
          });
        });

        test('success', () {});
        test('success', () {});
      });
    """, [
      _start,
      _allSuites(),
      _suite(0),
      _testStart(1, "loading test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 3),
      _group(3, name: "group 1", parentID: 2, testCount: 3, line: 6, column: 7),
      _group(4, name: "group 1 .2", parentID: 3, line: 7, column: 9),
      _group(5, name: "group 1 .2 .3", parentID: 4, line: 8, column: 11),
      _testStart(6, 'group 1 .2 .3 success',
          groupIDs: [2, 3, 4, 5], line: 9, column: 13),
      _testDone(6),
      _testStart(7, 'group 1 success', groupIDs: [2, 3], line: 13, column: 9),
      _testDone(7),
      _testStart(8, 'group 1 success', groupIDs: [2, 3], line: 14, column: 9),
      _testDone(8),
      _done()
    ]);
  });

  group("print:", () {
    test("handles multiple prints", () {
      return _expectReport("""
        test('test', () {
          print("one");
          print("two");
          print("three");
          print("four");
        });
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2),
        _testStart(3, 'test', line: 6, column: 9),
        _print(3, "one"),
        _print(3, "two"),
        _print(3, "three"),
        _print(3, "four"),
        _testDone(3),
        _done()
      ]);
    });

    test("handles a print after the test completes", () {
      return _expectReport("""
        // This completer ensures that the test isolate isn't killed until all
        // prints have happened.
        var testDone = new Completer();
        var waitStarted = new Completer();
        test('test', () async {
          waitStarted.future.then((_) {
            new Future(() => print("one"));
            new Future(() => print("two"));
            new Future(() => print("three"));
            new Future(() => print("four"));
            new Future(testDone.complete);
          });
        });

        test('wait', () {
          waitStarted.complete();
          return testDone.future;
        });
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 2),
        _testStart(3, 'test', line: 10, column: 9),
        _testDone(3),
        _testStart(4, 'wait', line: 20, column: 9),
        _print(3, "one"),
        _print(3, "two"),
        _print(3, "three"),
        _print(3, "four"),
        _testDone(4),
        _done()
      ]);
    });

    test("interleaves prints and errors", () {
      return _expectReport("""
        // This completer ensures that the test isolate isn't killed until all
        // prints have happened.
        var completer = new Completer();
        test('test', () {
          scheduleMicrotask(() {
            print("three");
            print("four");
            throw "second error";
          });

          scheduleMicrotask(() {
            print("five");
            print("six");
            completer.complete();
          });

          print("one");
          print("two");
          throw "first error";
        });

        test('wait', () => completer.future);
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 2),
        _testStart(3, 'test', line: 9, column: 9),
        _print(3, "one"),
        _print(3, "two"),
        _error(3, "first error"),
        _print(3, "three"),
        _print(3, "four"),
        _error(3, "second error"),
        _print(3, "five"),
        _print(3, "six"),
        _testDone(3, result: "error"),
        _testStart(4, 'wait', line: 27, column: 9),
        _testDone(4),
        _done(success: false)
      ]);
    });
  });

  group("skip:", () {
    test("reports skipped tests", () {
      return _expectReport("""
        test('skip 1', () {}, skip: true);
        test('skip 2', () {}, skip: true);
        test('skip 3', () {}, skip: true);
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 3),
        _testStart(3, "skip 1", skip: true, line: 6, column: 9),
        _testDone(3, skipped: true),
        _testStart(4, "skip 2", skip: true, line: 7, column: 9),
        _testDone(4, skipped: true),
        _testStart(5, "skip 3", skip: true, line: 8, column: 9),
        _testDone(5, skipped: true),
        _done()
      ]);
    });

    test("reports skipped groups", () {
      return _expectReport("""
        group('skip', () {
          test('success 1', () {});
          test('success 2', () {});
          test('success 3', () {});
        }, skip: true);
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 3),
        _group(3,
            name: "skip",
            parentID: 2,
            skip: true,
            testCount: 3,
            line: 6,
            column: 9),
        _testStart(4, "skip success 1",
            groupIDs: [2, 3], skip: true, line: 7, column: 11),
        _testDone(4, skipped: true),
        _testStart(5, "skip success 2",
            groupIDs: [2, 3], skip: true, line: 8, column: 11),
        _testDone(5, skipped: true),
        _testStart(6, "skip success 3",
            groupIDs: [2, 3], skip: true, line: 9, column: 11),
        _testDone(6, skipped: true),
        _done()
      ]);
    });

    test("reports the skip reason if available", () {
      return _expectReport("""
        test('skip 1', () {}, skip: 'some reason');
        test('skip 2', () {}, skip: 'or another');
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 2),
        _testStart(3, "skip 1", skip: "some reason", line: 6, column: 9),
        _print(3, "Skip: some reason", type: "skip"),
        _testDone(3, skipped: true),
        _testStart(4, "skip 2", skip: "or another", line: 7, column: 9),
        _print(4, "Skip: or another", type: "skip"),
        _testDone(4, skipped: true),
        _done()
      ]);
    });

    test("runs skipped tests with --run-skipped", () {
      return _expectReport("""
        test('skip 1', () {}, skip: 'some reason');
        test('skip 2', () {}, skip: 'or another');
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 2),
        _testStart(3, "skip 1", line: 6, column: 9),
        _testDone(3),
        _testStart(4, "skip 2", line: 7, column: 9),
        _testDone(4),
        _done()
      ], args: [
        "--run-skipped"
      ]);
    });
  });

  group("reports line and column numbers for", () {
    test("the first call to setUpAll()", () {
      return _expectReport("""
        setUpAll(() {});
        setUpAll(() {});
        setUpAll(() {});
        test('success', () {});
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 1),
        _testStart(3, "(setUpAll)", line: 6, column: 9),
        _testDone(3, hidden: true),
        _testStart(4, "success", line: 9, column: 9),
        _testDone(4),
        _done()
      ]);
    });

    test("the first call to tearDownAll()", () {
      return _expectReport("""
        tearDownAll(() {});
        tearDownAll(() {});
        tearDownAll(() {});
        test('success', () {});
      """, [
        _start,
        _allSuites(),
        _suite(0),
        _testStart(1, "loading test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 1),
        _testStart(3, "success", line: 9, column: 9),
        _testDone(3),
        _testStart(4, "(tearDownAll)", line: 6, column: 9),
        _testDone(4, hidden: true),
        _done()
      ]);
    });

    test("a test compiled to JS", () {
      return _expectReport("""
        test('success', () {});
      """, [
        _start,
        _allSuites(),
        _suite(0, platform: "chrome"),
        _testStart(1, "compiling test.dart", groupIDs: []),
        _testDone(1, hidden: true),
        _group(2, testCount: 1),
        _testStart(3, "success", line: 6, column: 9),
        _testDone(3),
        _done()
      ], args: [
        "-p",
        "chrome"
      ]);
    }, tags: ["chrome"], skip: "Broken by sdk#29693.");
  });

  test(
      "doesn't report line and column information for a test compiled to JS "
      "with --js-trace", () {
    return _expectReport("""
      test('success', () {});
    """, [
      _start,
      _allSuites(),
      _suite(0, platform: "chrome"),
      _testStart(1, "compiling test.dart", groupIDs: []),
      _testDone(1, hidden: true),
      _group(2, testCount: 1),
      _testStart(3, "success"),
      _testDone(3),
      _done()
    ], args: [
      "-p",
      "chrome",
      "--js-trace"
    ]);
  }, tags: ["chrome"], skip: "Broken by sdk#29693.");
}

/// Asserts that the tests defined by [tests] produce the JSON events in
/// [expected].
Future _expectReport(String tests, List<Map> expected,
    {List<String> args}) async {
  d.file("test.dart", """
    import 'dart:async';

    import 'package:test/test.dart';

    void main() {
$tests
    }
  """).create();

  var test = await runTest(["test.dart"]..addAll(args ?? []), reporter: "json");
  await test.shouldExit();

  var stdoutLines = await test.stdoutStream().toList();

  expect(stdoutLines.length, equals(expected.length),
      reason: "Expected $stdoutLines to match ${JSON.encode(expected)}.");

  // TODO(nweiz): validate each event against the JSON schema when
  // patefacio/json_schema#4 is merged.

  // Remove excess trailing whitespace.
  for (var i = 0; i < stdoutLines.length; i++) {
    var event = JSON.decode(stdoutLines[i]);
    expect(event.remove("time"), new isInstanceOf<int>());
    event.remove("stackTrace");
    expect(event, equals(expected[i]));
  }
}

/// Returns the event emitted by the JSON reporter providing information about
/// all suites.
///
/// The [count] defaults to 1.
Map _allSuites({int count}) {
  return {"type": "allSuites", "count": count ?? 1};
}

/// Returns the event emitted by the JSON reporter indicating that a suite has
/// begun running.
///
/// The [platform] defaults to `"vm"`, the [path] defaults to `"test.dart"`.
Map _suite(int id, {String platform, String path}) {
  return {
    "type": "suite",
    "suite": {
      "id": id,
      "platform": platform ?? "vm",
      "path": path ?? "test.dart"
    }
  };
}

/// Returns the event emitted by the JSON reporter indicating that a group has
/// begun running.
///
/// If [skip] is `true`, the group is expected to be marked as skipped without a
/// reason. If it's a [String], the group is expected to be marked as skipped
/// with that reason.
///
/// The [testCount] parameter indicates the number of tests in the group. It
/// defaults to 1.
Map _group(int id,
    {String name,
    int suiteID,
    int parentID,
    skip,
    int testCount,
    int line,
    int column}) {
  if ((line == null) != (column == null)) {
    throw new ArgumentError(
        "line and column must either both be null or both be passed");
  }

  return {
    "type": "group",
    "group": {
      "id": id,
      "name": name,
      "suiteID": suiteID ?? 0,
      "parentID": parentID,
      "metadata": _metadata(skip: skip),
      "testCount": testCount ?? 1,
      "line": line,
      "column": column,
      "url": line == null
          ? null
          : p.toUri(p.join(d.sandbox, "test.dart")).toString()
    }
  };
}

/// Returns the event emitted by the JSON reporter indicating that a test has
/// begun running.
///
/// If [parentIDs] is passed, it's the IDs of groups containing this test. If
/// [skip] is `true`, the test is expected to be marked as skipped without a
/// reason. If it's a [String], the test is expected to be marked as skipped
/// with that reason.
Map _testStart(int id, String name,
    {int suiteID, Iterable<int> groupIDs, int line, int column, skip}) {
  if ((line == null) != (column == null)) {
    throw new ArgumentError(
        "line and column must either both be null or both be passed");
  }

  return {
    "type": "testStart",
    "test": {
      "id": id,
      "name": name,
      "suiteID": suiteID ?? 0,
      "groupIDs": groupIDs ?? [2],
      "metadata": _metadata(skip: skip),
      "line": line,
      "column": column,
      "url": line == null
          ? null
          : p.toUri(p.join(d.sandbox, "test.dart")).toString()
    }
  };
}

/// Returns the event emitted by the JSON reporter indicating that a test
/// printed [message].
Map _print(int id, String message, {String type}) {
  return {
    "type": "print",
    "testID": id,
    "message": message,
    "messageType": type ?? "print"
  };
}

/// Returns the event emitted by the JSON reporter indicating that a test
/// emitted [error].
///
/// The [isFailure] parameter indicates whether the error was a [TestFailure] or
/// not.
Map _error(int id, String error, {bool isFailure: false}) {
  return {
    "type": "error",
    "testID": id,
    "error": error,
    "isFailure": isFailure
  };
}

/// Returns the event emitted by the JSON reporter indicating that a test
/// finished.
///
/// The [result] parameter indicates the result of the test. It defaults to
/// `"success"`.
///
/// The [hidden] parameter indicates whether the test should not be displayed
/// after finishing. The [skipped] parameter indicates whether the test was
/// skipped.
Map _testDone(int id,
    {String result, bool hidden: false, bool skipped: false}) {
  result ??= "success";
  return {
    "type": "testDone",
    "testID": id,
    "result": result,
    "hidden": hidden,
    "skipped": skipped
  };
}

/// Returns the event emitted by the JSON reporter indicating that the entire
/// run finished.
Map _done({bool success: true}) => {"type": "done", "success": success};

/// Returns the serialized metadata corresponding to [skip].
Map _metadata({skip}) {
  if (skip == true) {
    return {"skip": true, "skipReason": null};
  } else if (skip is String) {
    return {"skip": true, "skipReason": skip};
  } else {
    return {"skip": false, "skipReason": null};
  }
}
