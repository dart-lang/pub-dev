// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library stderr_logging;

import 'dart:io' as io;
import 'dart:async';

import '../logging.dart';
import '../logging_impl.dart';

class StderrRequestLoggingImpl extends LoggingImpl {
  final String _httpMethod;
  final String _httpResource;
  final String _userAgent;
  final String _host;
  final String _ip;
  final DateTime _startTimestamp = new DateTime.now().toUtc();
  final List<_LogLine> _gaeLogLines = <_LogLine>[];

  LogLevel _currentLogLevel;

  StderrRequestLoggingImpl(this._httpMethod, this._httpResource,
      this._userAgent, this._host, this._ip) {
    _resetState();
  }

  void log(LogLevel level, String message, {DateTime timestamp}) {
    if (level.level > _currentLogLevel.level) {
      _currentLogLevel = level;
    }
    _gaeLogLines.add(
        new _LogLine(level, message, timestamp ?? new DateTime.now().toUtc()));
  }

  Future flush() async {
    if (_gaeLogLines.length > 0) {
      _enqueue(finish: false);
    }
  }

  void finish(int responseStatus, int responseSize) {
    _enqueue(
        finish: true,
        responseStatus: responseStatus,
        responseSize: responseSize);
  }

  void _enqueue({bool finish: false, int responseStatus, int responseSize}) {
    final now = new DateTime.now().toUtc();
    final buffer = new StringBuffer();

    if (finish) {
      buffer.writeln('$now $_httpMethod $responseStatus '
                     '${now.difference(_startTimestamp).inMilliseconds} ms'
                     ' $_httpResource');
    } else {
      buffer.writeln('$now $_httpMethod - - $_httpResource');
    }
    for (final _LogLine line in _gaeLogLines) {
      final indented = line.format(_startTimestamp).replaceAll('\n', '\n  ');
      buffer.writeln('  $indented');
    }

    io.stderr.write('$buffer');
    _resetState();
  }

  void _resetState() {
    _gaeLogLines.clear();
    _currentLogLevel = LogLevel.DEBUG;
  }
}

class StderrBackgroundLoggingImpl extends Logging {
  void log(LogLevel level, String message, {DateTime timestamp}) {
    final logLine =
        new _LogLine(level, message, timestamp ?? new DateTime.now().toUtc());
    io.stderr.writeln(logLine.format(null));
  }

  Future flush() => new Future.value();
}

class _LogLine {
  final LogLevel level;
  final String message;
  final DateTime timestamp;

  _LogLine(this.level, this.message, this.timestamp);

  String format(DateTime start) {
    String time;
    if (start != null) {
      final ms = timestamp.difference(start).inMilliseconds.toString();
      time = '${' ' * (5 - ms.length)}$ms ms';
    } else {
      time = '$timestamp';
    }
    return '$time ${level.name}: $message';
  }
}
