// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io' as io;

import '../logging.dart';
import '../logging_impl.dart';

class StderrRequestLoggingImpl extends LoggingImpl {
  final String _httpMethod;
  final String _httpResource;
  final DateTime _startTimestamp = DateTime.now().toUtc();
  final List<_LogLine> _gaeLogLines = <_LogLine>[];

  LogLevel _currentLogLevel = LogLevel.DEBUG;

  StderrRequestLoggingImpl(this._httpMethod, this._httpResource) {
    _resetState();
  }

  @override
  void log(LogLevel level, String message, {DateTime? timestamp}) {
    if (level.level > _currentLogLevel.level) {
      _currentLogLevel = level;
    }
    _gaeLogLines
        .add(_LogLine(level, message, timestamp ?? DateTime.now().toUtc()));
  }

  @override
  Future flush() async {
    if (_gaeLogLines.isNotEmpty) {
      _enqueue(finish: false);
    }
  }

  @override
  void finish(int responseStatus, int responseSize) {
    _enqueue(
        finish: true,
        responseStatus: responseStatus,
        responseSize: responseSize);
  }

  void _enqueue({bool finish = false, int? responseStatus, int? responseSize}) {
    final now = DateTime.now().toUtc();
    final buffer = StringBuffer();

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

class StderrBackgroundLoggingImpl extends LoggingBase {
  @override
  void log(LogLevel level, String message, {DateTime? timestamp}) {
    final logLine =
        _LogLine(level, message, timestamp ?? DateTime.now().toUtc());
    io.stderr.writeln(logLine.format(null));
  }

  @override
  Future flush() => Future.value();
}

class _LogLine {
  final LogLevel level;
  final String message;
  final DateTime timestamp;

  _LogLine(this.level, this.message, this.timestamp);

  String format(DateTime? start) {
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
