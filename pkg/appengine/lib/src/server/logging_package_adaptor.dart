// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.server.logging_package_adaptor;

import 'package:logging/logging.dart';

import '../logging.dart';

final Map<Level, LogLevel> _loggingLevel2AppengineLoggingLevel = {
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

void setupAppEngineLogging() {
  Logger.root.onRecord.listen((LogRecord record) {
    record.zone.run(() {
      var logging;
      try {
        logging = loggingService;
      } on StateError {
        // If there is no active service scope, we'll get a `StateError` and we
        // will treat it the same way as if the logging service was `null`.
      }

      if (logging != null) {
        var level = _loggingLevel2AppengineLoggingLevel[record.level];
        if (level != null) {
          var message = record.message;

          if (record.loggerName != null && record.loggerName.isNotEmpty) {
            message = '${record.loggerName}: $message';
          }

          addBlock(String header, String body) {
            body = body.replaceAll('\n', '\n    ');
            message = '$message\n\n$header:\n    $body';
          }

          if (record.error != null) addBlock('Error', '${record.error}');
          if (record.stackTrace != null) {
            addBlock('Stack', '${record.stackTrace}');
          }

          logging.log(level, message, timestamp: record.time);
        }
      }
    });
  });
}
