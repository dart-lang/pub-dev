// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:appengine/src/logging_impl.dart' show LoggingBase;
import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';

class LoggingMock extends LoggingBase {
  late Function _logFunctionMock;
  late Function _reportErrorFunctionMock;

  LoggingMock();

  @override
  void log(LogLevel level, String message, {DateTime? timestamp}) {
    _logFunctionMock(level, message, timestamp);
  }

  @override
  void reportError(LogLevel level, Object error, StackTrace stackTrace,
      {DateTime? timestamp}) {
    _reportErrorFunctionMock(
      level,
      error,
      stackTrace,
      timestamp ?? DateTime.now(),
    );
  }

  void expectReportError(
      void Function(
              LogLevel level, Object error, StackTrace stackTrace, DateTime c)
          func) {
    _reportErrorFunctionMock = expectAsync4(func);
  }

  void expectNoReportErrorCall() {
    _reportErrorFunctionMock = (_, __, ___, ____) {
      throw StateError('Unexpected reportError() call');
    };
  }

  void expectLog(void Function(LogLevel a, String b, DateTime c) func) {
    _logFunctionMock = expectAsync3(func);
  }

  void expectNoLogCall() {
    _logFunctionMock = (_, __, ___) {
      throw StateError('Unexpected log() call');
    };
  }

  @override
  Future flush() {
    throw "Unexpected method call";
  }
}

class CustomStackTrace implements StackTrace {
  @override
  String toString() => 'custom-stack-trace';
}

void main() {
  group('enable_logging_package_test', () {
    test('not_registered', () {
      fork(expectAsync0(() async {
        var logger = Logger('a.b');
        var mock = LoggingMock();

        mock.expectNoLogCall();
        mock.expectNoReportErrorCall();
        logger.info('abc');

        return Future.value();
      }));
    });

    test('logging_adaptor_not_enabled', () {
      fork(expectAsync0(() async {
        var logger = Logger('a.b');
        var mock = LoggingMock();
        registerLoggingService(mock);

        mock.expectNoLogCall();
        mock.expectNoReportErrorCall();
        logger.info('abc');
      }));
    });

    group('use_logging_adaptor', () {
      test('enable_logging_adaptor', () {
        // This is a global setting. We rely on the test runner executing tests
        // in sequence.
        useLoggingPackageAdaptor();
      });

      test('root logger', () {
        var logger = Logger.root;
        var mock = LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);

          var level = Level.INFO;
          var appengineLevel = LogLevel.INFO;

          mock.expectLog((LogLevel level, String message, DateTime ts) {
            expect(level, equals(appengineLevel));
            expect(message, equals('abc'));
          });
          mock.expectNoReportErrorCall();
          logger.log(level, 'abc');
        }));
      });

      test('different_zone', () {
        var logger = Logger('a.b');
        var mock = LoggingMock();

        var testZone = Zone.current;
        fork(expectAsync0(() async {
          registerLoggingService(mock);

          mock.expectNoLogCall();
          mock.expectNoReportErrorCall();
          return testZone.run(() {
            logger.info('abc');
          });
        }));
      });

      test('test_level', () {
        var logger = Logger('a.b');
        var mock = LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);

          mock.expectNoReportErrorCall();
          var logLevelMapping = {
            Level.OFF: null,
            Level.ALL: LogLevel.DEBUG,
            Level.FINEST: LogLevel.DEBUG,
            Level.FINER: LogLevel.DEBUG,
            Level.FINE: LogLevel.DEBUG,
            Level.CONFIG: LogLevel.INFO,
            Level.INFO: LogLevel.INFO,
            Level.WARNING: LogLevel.WARNING,
            Level.SEVERE: LogLevel.ERROR,
            Level.SHOUT: LogLevel.CRITICAL,
          };
          logLevelMapping.forEach((level, appengineLevel) {
            if (logger.isLoggable(level)) {
              if (appengineLevel != null) {
                mock.expectLog((LogLevel level, String message, DateTime ts) {
                  expect(level, equals(appengineLevel));
                  expect(message, equals('a.b: abc'));
                });
              }
            } else {
              mock.expectNoLogCall();
            }
            logger.log(level, 'abc');
          });
        }));
      });

      test('test_error', () {
        var logger = Logger('a.b');
        var mock = LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);
          mock.expectNoReportErrorCall();
          mock.expectLog((LogLevel level, String message, DateTime ts) {
            expect(level, equals(LogLevel.INFO));
            expect(message, equals('a.b: abc\n\nError:\n    error'));
          });
          logger.log(Level.INFO, 'abc', 'error');
        }));
      });

      test('test_error_stack', () {
        var logger = Logger('a.b');
        var mock = LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);
          mock.expectReportError((
            LogLevel level,
            Object e,
            StackTrace st,
            DateTime ts,
          ) {
            expect(level, equals(LogLevel.INFO));
            expect(e, equals('error'));
            expect(st, isA<CustomStackTrace>());
          });
          mock.expectLog((LogLevel level, String message, DateTime ts) {
            expect(level, equals(LogLevel.INFO));
            expect(
                message,
                equals('a.b: abc\n\n'
                    'Error:\n    error\n\n'
                    'Stack:\n    custom-stack-trace'));
          });
          logger.log(Level.INFO, 'abc', 'error', CustomStackTrace());
        }));
      });
    });
  });
}
