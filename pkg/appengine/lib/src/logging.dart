// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

class LogLevel {
  static const LogLevel CRITICAL = LogLevel._('Critical', 4);
  static const LogLevel ERROR = LogLevel._('Error', 3);
  static const LogLevel WARNING = LogLevel._('Warning', 2);
  static const LogLevel INFO = LogLevel._('Info', 1);
  static const LogLevel DEBUG = LogLevel._('Debug', 0);

  final String name;
  final int level;

  const LogLevel._(this.name, this.level);

  @override
  String toString() => name;
}

abstract class Logging {
  void critical(String string, {DateTime timestamp});
  void error(String string, {DateTime timestamp});
  void warning(String string, {DateTime timestamp});
  void info(String string, {DateTime timestamp});
  void debug(String string, {DateTime timestamp});

  /// Report an error, may print the error to log or report it to stackdriver
  /// error reporting if [stackTrace] is given and running on appengine, not
  /// localhost.
  ///
  /// Notice that Stackdriver Error Reporting only collects errors if [level] is
  /// either [LogLevel.ERROR] or [LogLevel.CRITICAL].
  void reportError(
    LogLevel level,
    Object error,
    StackTrace stackTrace, {
    DateTime timestamp,
  });

  void log(
    LogLevel level,
    String message, {
    DateTime timestamp,
  });

  Future<void> flush();
}

/// Register a new [Logging] object.
///
/// Calling this outside of a service scope or calling it more than once inside
/// the same service scope will result in an error.
///
/// See the `package:gcloud/service_scope.dart` library for more information.
void registerLoggingService(Logging service) {
  ss.register(#appengine.logging, service);
}

/// The logging service.
///
/// Request handlers will be run inside a service scope which contains the
/// modules service.
Logging get loggingService => ss.lookup(#appengine.logging) as Logging;
