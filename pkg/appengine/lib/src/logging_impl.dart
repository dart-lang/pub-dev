// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'logging.dart';

abstract class LoggingBase extends Logging {
  @override
  void critical(String string, {DateTime? timestamp}) {
    if (timestamp != null) {
      log(LogLevel.CRITICAL, string, timestamp: timestamp);
    } else {
      log(LogLevel.CRITICAL, string);
    }
  }

  @override
  void error(String string, {DateTime? timestamp}) {
    if (timestamp != null) {
      log(LogLevel.ERROR, string, timestamp: timestamp);
    } else {
      log(LogLevel.ERROR, string);
    }
  }

  @override
  void warning(String string, {DateTime? timestamp}) {
    if (timestamp != null) {
      log(LogLevel.WARNING, string, timestamp: timestamp);
    } else {
      log(LogLevel.WARNING, string);
    }
  }

  @override
  void info(String string, {DateTime? timestamp}) {
    if (timestamp != null) {
      log(LogLevel.INFO, string, timestamp: timestamp);
    } else {
      log(LogLevel.INFO, string);
    }
  }

  @override
  void debug(String string, {DateTime? timestamp}) {
    if (timestamp != null) {
      log(LogLevel.DEBUG, string, timestamp: timestamp);
    } else {
      log(LogLevel.DEBUG, string);
    }
  }

  /// Report an error, may print the error to log or report it to stackdriver
  /// error reporting if [stackTrace] is given and running on appengine, not
  /// localhost.
  ///
  /// Notice that Stackdriver Error Reporting only collects errors if [level] is
  /// either [LogLevel.ERROR] or [LogLevel.CRITICAL].
  @override
  void reportError(
    LogLevel level,
    Object error,
    StackTrace stackTrace, {
    DateTime? timestamp,
  }) {
    if (timestamp != null) {
      log(level, 'Error: $error\n$stackTrace', timestamp: timestamp);
    } else {
      log(level, 'Error: $error\n$stackTrace');
    }
  }
}

abstract class LoggingImpl extends LoggingBase {
  void finish(int responseStatus, int responseSize);
}
