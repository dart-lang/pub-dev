// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import '../../backend/live_test.dart';
import '../../backend/message.dart';
import '../../backend/state.dart';
import '../../utils.dart';
import '../engine.dart';
import '../load_exception.dart';
import '../load_suite.dart';
import '../reporter.dart';

/// The maximum console line length.
///
/// Lines longer than this will be cropped.
const _lineLength = 100;

/// A reporter that prints each test on its own line.
///
/// This is currently used in place of [CompactReporter] by `lib/test.dart`,
/// which can't transitively import `dart:io` but still needs access to a runner
/// so that test files can be run directly. This means that until issue 6943 is
/// fixed, this must not import `dart:io`.
class ExpandedReporter implements Reporter {
  /// Whether the reporter should emit terminal color escapes.
  final bool _color;

  /// The terminal escape for green text, or the empty string if this is Windows
  /// or not outputting to a terminal.
  final String _green;

  /// The terminal escape for red text, or the empty string if this is Windows
  /// or not outputting to a terminal.
  final String _red;

  /// The terminal escape for yellow text, or the empty string if this is
  /// Windows or not outputting to a terminal.
  final String _yellow;

  /// The terminal escape for gray text, or the empty string if this is
  /// Windows or not outputting to a terminal.
  final String _gray;

  /// The terminal escape for bold text, or the empty string if this is
  /// Windows or not outputting to a terminal.
  final String _bold;

  /// The terminal escape for removing test coloring, or the empty string if
  /// this is Windows or not outputting to a terminal.
  final String _noColor;

  /// The engine used to run the tests.
  final Engine _engine;

  /// Whether the path to each test's suite should be printed.
  final bool _printPath;

  /// Whether the platform each test is running on should be printed.
  final bool _printPlatform;

  /// A stopwatch that tracks the duration of the full run.
  final _stopwatch = new Stopwatch();

  /// The size of `_engine.passed` last time a progress notification was
  /// printed.
  int _lastProgressPassed;

  /// The size of `_engine.skipped` last time a progress notification was
  /// printed.
  int _lastProgressSkipped;

  /// The size of `_engine.failed` last time a progress notification was
  /// printed.
  int _lastProgressFailed;

  /// The message printed for the last progress notification.
  String _lastProgressMessage;

  /// The suffix added to the last progress notification.
  String _lastProgressSuffix;

  /// Whether the reporter is paused.
  var _paused = false;

  /// The set of all subscriptions to various streams.
  final _subscriptions = new Set<StreamSubscription>();

  // TODO(nweiz): Get configuration from [Configuration.current] once we have
  // cross-platform imports.
  /// Watches the tests run by [engine] and prints their results to the
  /// terminal.
  ///
  /// If [color] is `true`, this will use terminal colors; if it's `false`, it
  /// won't. If [printPath] is `true`, this will print the path name as part of
  /// the test description. Likewise, if [printPlatform] is `true`, this will
  /// print the platform as part of the test description.
  static ExpandedReporter watch(Engine engine,
      {bool color: true, bool printPath: true, bool printPlatform: true}) {
    return new ExpandedReporter._(engine,
        color: color, printPath: printPath, printPlatform: printPlatform);
  }

  ExpandedReporter._(this._engine,
      {bool color: true, bool printPath: true, bool printPlatform: true})
      : _printPath = printPath,
        _printPlatform = printPlatform,
        _color = color,
        _green = color ? '\u001b[32m' : '',
        _red = color ? '\u001b[31m' : '',
        _yellow = color ? '\u001b[33m' : '',
        _gray = color ? '\u001b[1;30m' : '',
        _bold = color ? '\u001b[1m' : '',
        _noColor = color ? '\u001b[0m' : '' {
    _subscriptions.add(_engine.onTestStarted.listen(_onTestStarted));

    /// Convert the future to a stream so that the subscription can be paused or
    /// canceled.
    _subscriptions.add(_engine.success.asStream().listen(_onDone));
  }

  void pause() {
    if (_paused) return;
    _paused = true;

    _stopwatch.stop();

    for (var subscription in _subscriptions) {
      subscription.pause();
    }
  }

  void resume() {
    if (!_paused) return;
    _stopwatch.start();

    for (var subscription in _subscriptions) {
      subscription.resume();
    }
  }

  void cancel() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }

  /// A callback called when the engine begins running [liveTest].
  void _onTestStarted(LiveTest liveTest) {
    if (liveTest.suite is! LoadSuite) {
      if (!_stopwatch.isRunning) _stopwatch.start();

      // If this is the first non-load test to start, print a progress line so
      // the user knows what's running.
      if (_engine.active.length == 1) _progressLine(_description(liveTest));

      // The engine surfaces load tests when there are no other tests running,
      // but because the expanded reporter's output is always visible, we don't
      // emit information about them unless they fail.
      _subscriptions.add(liveTest.onStateChange
          .listen((state) => _onStateChange(liveTest, state)));
    } else if (_engine.active.length == 1 &&
        _engine.active.first == liveTest &&
        liveTest.test.name.startsWith("compiling ")) {
      // Print a progress line for load tests that come from compiling JS, since
      // that takes a long time.
      _progressLine(_description(liveTest));
    }

    _subscriptions.add(liveTest.onError
        .listen((error) => _onError(liveTest, error.error, error.stackTrace)));

    _subscriptions.add(liveTest.onMessage.listen((message) {
      _progressLine(_description(liveTest));
      var text = message.text;
      if (message.type == MessageType.skip) text = '  $_yellow$text$_noColor';
      print(text);
    }));
  }

  /// A callback called when [liveTest]'s state becomes [state].
  void _onStateChange(LiveTest liveTest, State state) {
    if (state.status != Status.complete) return;

    // If any tests are running, display the name of the oldest active
    // test.
    if (_engine.active.isNotEmpty) {
      _progressLine(_description(_engine.active.first));
    }
  }

  /// A callback called when [liveTest] throws [error].
  void _onError(LiveTest liveTest, error, StackTrace stackTrace) {
    if (liveTest.state.status != Status.complete) return;

    _progressLine(_description(liveTest), suffix: " $_bold$_red[E]$_noColor");

    if (error is! LoadException) {
      print(indent(error.toString()));
      print(indent('$stackTrace'));
      return;
    }

    print(indent(error.toString(color: _color)));

    // Only print stack traces for load errors that come from the user's code.
    if (error.innerError is! IsolateSpawnException &&
        error.innerError is! FormatException &&
        error.innerError is! String) {
      print(indent('$stackTrace'));
    }
  }

  /// A callback called when the engine is finished running tests.
  ///
  /// [success] will be `true` if all tests passed, `false` if some tests
  /// failed, and `null` if the engine was closed prematurely.
  void _onDone(bool success) {
    // A null success value indicates that the engine was closed before the
    // tests finished running, probably because of a signal from the user, in
    // which case we shouldn't print summary information.
    if (success == null) return;

    if (_engine.liveTests.isEmpty) {
      print("No tests ran.");
    } else if (!success) {
      _progressLine('Some tests failed.', color: _red);
    } else if (_engine.passed.isEmpty) {
      _progressLine("All tests skipped.");
    } else {
      _progressLine("All tests passed!");
    }
  }

  /// Prints a line representing the current state of the tests.
  ///
  /// [message] goes after the progress report, and may be truncated to fit the
  /// entire line within [_lineLength]. If [color] is passed, it's used as the
  /// color for [message]. If [suffix] is passed, it's added to the end of
  /// [message].
  void _progressLine(String message, {String color, String suffix}) {
    // Print nothing if nothing has changed since the last progress line.
    if (_engine.passed.length == _lastProgressPassed &&
        _engine.skipped.length == _lastProgressSkipped &&
        _engine.failed.length == _lastProgressFailed &&
        message == _lastProgressMessage &&
        // Don't re-print just because a suffix was removed.
        (suffix == null || suffix == _lastProgressSuffix)) {
      return;
    }

    _lastProgressPassed = _engine.passed.length;
    _lastProgressSkipped = _engine.skipped.length;
    _lastProgressFailed = _engine.failed.length;
    _lastProgressMessage = message;
    _lastProgressSuffix = suffix;

    if (suffix != null) message += suffix;
    if (color == null) color = '';
    var duration = _stopwatch.elapsed;
    var buffer = new StringBuffer();

    // \r moves back to the beginning of the current line.
    buffer.write('${_timeString(duration)} ');
    buffer.write(_green);
    buffer.write('+');
    buffer.write(_engine.passed.length);
    buffer.write(_noColor);

    if (_engine.skipped.isNotEmpty) {
      buffer.write(_yellow);
      buffer.write(' ~');
      buffer.write(_engine.skipped.length);
      buffer.write(_noColor);
    }

    if (_engine.failed.isNotEmpty) {
      buffer.write(_red);
      buffer.write(' -');
      buffer.write(_engine.failed.length);
      buffer.write(_noColor);
    }

    buffer.write(': ');
    buffer.write(color);
    buffer.write(message);
    buffer.write(_noColor);

    print(buffer.toString());
  }

  /// Returns a representation of [duration] as `MM:SS`.
  String _timeString(Duration duration) {
    return "${duration.inMinutes.toString().padLeft(2, '0')}:"
        "${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  /// Returns a description of [liveTest].
  ///
  /// This differs from the test's own description in that it may also include
  /// the suite's name.
  String _description(LiveTest liveTest) {
    var name = liveTest.test.name;

    if (_printPath &&
        liveTest.suite is! LoadSuite &&
        liveTest.suite.path != null) {
      name = "${liveTest.suite.path}: $name";
    }

    if (_printPlatform && liveTest.suite.platform != null) {
      name = "[${liveTest.suite.platform.name}] $name";
    }

    if (liveTest.suite is LoadSuite) name = "$_bold$_gray$name$_noColor";

    return name;
  }
}
