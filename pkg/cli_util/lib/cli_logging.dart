// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This library contains functionality to help command-line utilities to easily
/// create aesthetic output.
library cli_logging;

import 'dart:async';
import 'dart:io' as io;

/// A small utility class to make it easier to work with common ANSI escape
/// sequences.
class Ansi {
  /// Return whether the current stdout terminal supports ANSI escape sequences.
  static bool get terminalSupportsAnsi {
    return io.stdout.supportsAnsiEscapes &&
        io.stdioType(io.stdout) == io.StdioType.TERMINAL;
  }

  final bool useAnsi;

  Ansi(this.useAnsi);

  String get cyan => _code('\u001b[36m');
  String get green => _code('\u001b[32m');
  String get magenta => _code('\u001b[35m');
  String get red => _code('\u001b[31m');
  String get yellow => _code('\u001b[33m');
  String get blue => _code('\u001b[34m');
  String get gray => _code('\u001b[1;30m');
  String get noColor => _code('\u001b[39m');

  String get none => _code('\u001b[0m');

  String get bold => _code('\u001b[1m');

  String get backspace => '\b';

  String get bullet => io.stdout.supportsAnsiEscapes ? '•' : '-';

  /// Display [message] in an emphasized format.
  String emphasized(String message) => '$bold$message$none';

  /// Display [message] in an subtle (gray) format.
  String subtle(String message) => '$gray$message$none';

  /// Display [message] in an error (red) format.
  String error(String message) => '$red$message$none';

  String _code(String ansiCode) => useAnsi ? ansiCode : '';
}

/// An abstract representation of a [Logger] - used to pretty print errors,
/// standard status messages, trace level output, and indeterminate progress.
abstract class Logger {
  /// Create a normal [Logger]; this logger will not display trace level output.
  factory Logger.standard({Ansi ansi}) => new _StandardLogger(ansi: ansi);

  /// Create a [Logger] that will display trace level output.
  factory Logger.verbose({Ansi ansi}) => new _VerboseLogger(ansi: ansi);

  Ansi get ansi;

  bool get isVerbose;

  /// Print an error message.
  void stderr(String message);

  /// Print a standard status message.
  void stdout(String message);

  /// Print trace output.
  void trace(String message);

  /// Start an indeterminate progress display.
  Progress progress(String message);
  void _progressFinished(Progress progress);

  /// Flush any un-written output.
  void flush();
}

/// A handle to an indeterminate progress display.
abstract class Progress {
  final String message;
  final Stopwatch _stopwatch;

  Progress._(this.message) : _stopwatch = new Stopwatch()..start();

  Duration get elapsed => _stopwatch.elapsed;

  /// Finish the indeterminate progress display.
  void finish({String message, bool showTiming});

  /// Cancel the indeterminate progress display.
  void cancel();
}

class _StandardLogger implements Logger {
  Ansi ansi;

  _StandardLogger({this.ansi}) {
    ansi ??= new Ansi(Ansi.terminalSupportsAnsi);
  }

  bool get isVerbose => false;

  Progress _currentProgress;

  void stderr(String message) {
    io.stderr.writeln(message);
    _currentProgress?.cancel();
    _currentProgress = null;
  }

  void stdout(String message) {
    print(message);
    _currentProgress?.cancel();
    _currentProgress = null;
  }

  void trace(String message) {}

  Progress progress(String message) {
    _currentProgress?.cancel();
    _currentProgress = null;

    Progress progress = ansi.useAnsi
        ? new _AnsiProgress(this, ansi, message)
        : new _SimpleProgress(this, message);
    _currentProgress = progress;
    return progress;
  }

  void _progressFinished(Progress progress) {
    if (_currentProgress == progress) {
      _currentProgress = null;
    }
  }

  void flush() {}
}

class _SimpleProgress extends Progress {
  final Logger logger;

  _SimpleProgress(this.logger, String message) : super._(message) {
    logger.stdout('$message...');
  }

  @override
  void cancel() {
    logger._progressFinished(this);
  }

  @override
  void finish({String message, bool showTiming}) {
    logger._progressFinished(this);
  }
}

class _AnsiProgress extends Progress {
  static const List<String> kAnimationItems = const ['/', '-', '\\', '|'];

  final Logger logger;
  final Ansi ansi;

  int _index = 0;
  Timer _timer;

  _AnsiProgress(this.logger, this.ansi, String message) : super._(message) {
    io.stdout.write('${message}...  '.padRight(40));

    _timer = new Timer.periodic(new Duration(milliseconds: 80), (t) {
      _index++;
      _updateDisplay();
    });

    _updateDisplay();
  }

  @override
  void cancel() {
    if (_timer.isActive) {
      _timer.cancel();
      _updateDisplay(cancelled: true);
      logger._progressFinished(this);
    }
  }

  @override
  void finish({String message, bool showTiming: false}) {
    if (_timer.isActive) {
      _timer.cancel();
      _updateDisplay(isFinal: true, message: message, showTiming: showTiming);
      logger._progressFinished(this);
    }
  }

  void _updateDisplay(
      {bool isFinal: false,
      bool cancelled: false,
      String message,
      bool showTiming: false}) {
    String char = kAnimationItems[_index % kAnimationItems.length];
    if (isFinal || cancelled) {
      char = '';
    }
    io.stdout.write('${ansi.backspace}${char}');
    if (isFinal || cancelled) {
      if (message != null) {
        io.stdout.write(message.isEmpty ? ' ' : message);
      } else if (showTiming) {
        String time = (elapsed.inMilliseconds / 1000.0).toStringAsFixed(1);
        io.stdout.write('${time}s');
      } else {
        io.stdout.write(' ');
      }
      io.stdout.writeln();
    }
  }
}

class _VerboseLogger implements Logger {
  Ansi ansi;
  Stopwatch _timer;

  String _previousErr;
  String _previousMsg;

  _VerboseLogger({this.ansi}) {
    ansi ??= new Ansi(Ansi.terminalSupportsAnsi);
    _timer = new Stopwatch()..start();
  }

  bool get isVerbose => true;

  void stderr(String message) {
    flush();
    _previousErr = '${ansi.red}$message${ansi.none}';
  }

  void stdout(String message) {
    flush();
    _previousMsg = message;
  }

  void trace(String message) {
    flush();
    _previousMsg = '${ansi.gray}$message${ansi.none}';
  }

  Progress progress(String message) => new _SimpleProgress(this, message);

  void _progressFinished(Progress progress) {}

  void flush() {
    if (_previousErr != null) {
      io.stderr.writeln('${_createTag()} $_previousErr');
      _previousErr = null;
    } else if (_previousMsg != null) {
      io.stdout.writeln('${_createTag()} $_previousMsg');
      _previousMsg = null;
    }
  }

  String _createTag() {
    int millis = _timer.elapsedMilliseconds;
    _timer.reset();
    return '[${millis.toString().padLeft(4)} ms]';
  }
}
