// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';

class LoggingMock extends Logging {
  Function _logFunctionMock;

  LoggingMock();

  void log(LogLevel level, String message, {DateTime timestamp}) {
    _logFunctionMock(level, message, timestamp);
  }

  void expect(void func(LogLevel a, String b, DateTime c)) {
    _logFunctionMock = expectAsync3(func);
  }

  void expectNoCall() {
    _logFunctionMock = (_, __, ___) {
      throw new StateError('Unexpected log() call');
    };
  }

  Future flush() { throw "Unexpected method call"; }
}

class CustomStackTrace implements StackTrace {
  String toString() => 'custom-stack-trace';
}

void main() {
  group('enable_logging_package_test', () {
    test('not_registered', () {
      fork(expectAsync0(() async {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();

        mock.expectNoCall();
        logger.info('abc');

        return new Future.value();
      }));
    });

    test('logging_adaptor_not_enabled', () {
      fork(expectAsync0(() async {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();
        registerLoggingService(mock);

        mock.expectNoCall();
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
        var mock = new LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);

          var level = Level.INFO;
          var appengineLevel = LogLevel.INFO;

          mock.expect((LogLevel level, String message, DateTime ts) {
            expect(level, equals(appengineLevel));
            expect(message, equals('abc'));
          });
          logger.log(level, 'abc');
        }));
      });

      test('different_zone', () {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();

        var testZone = Zone.current;
        fork(expectAsync0(() async {
          registerLoggingService(mock);

          mock.expectNoCall();
          return testZone.run(() {
            logger.info('abc');
          });
        }));
      });

      test('test_level', () {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);

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
                mock.expect((LogLevel level, String message, DateTime ts) {
                  expect(level, equals(appengineLevel));
                  expect(message, equals('a.b: abc'));
                });
              }
            } else {
              mock.expectNoCall();
            }
            logger.log(level, 'abc');
          });
        }));
      });

      test('test_error', () {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);
          mock.expect((LogLevel level, String message, DateTime ts) {
            expect(level, equals(LogLevel.INFO));
            expect(message, equals('a.b: abc\n\nError:\n    error'));
          });
          logger.log(Level.INFO, 'abc', 'error');
        }));
      });


      test('test_error_stack', () {
        var logger = new Logger('a.b');
        var mock = new LoggingMock();

        return fork(expectAsync0(() async {
          registerLoggingService(mock);
          mock.expect((LogLevel level, String message, DateTime ts) {
            expect(level, equals(LogLevel.INFO));
            expect(message, equals('a.b: abc\n\n'
                                   'Error:\n    error\n\n'
                                   'Stack:\n    custom-stack-trace'));
          });
          logger.log(Level.INFO, 'abc', 'error', new CustomStackTrace());
        }));
      });
    });
  });
}
