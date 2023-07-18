import 'dart:convert';

import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';

final Map<Level, LogLevel?> _loggingLevel2AppengineLoggingLevel = {
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

var _setupAppEngineLogging = false;
void setupAppEngineLogging() {
  if (_setupAppEngineLogging) {
    return;
  }
  _setupAppEngineLogging = true;
  Logger.root.onRecord.listen((LogRecord record) {
    record.zone!.run(() {
      Logging? logging;
      try {
        logging = loggingService;
      } on StateError {
        final level = _loggingLevel2AppengineLoggingLevel[record.level];
        if (level != null) {
          var message = record.message;

          if (record.loggerName.isNotEmpty) {
            message = '${record.loggerName}: $message';
          }

          void addBlock(String header, String body) {
            body = body.replaceAll('\n', '\n    ');
            message = '$message\n\n$header:\n    $body';
          }

          if (record.error != null) addBlock('Error', '${record.error}');
          if (record.stackTrace != null) {
            addBlock('Stack', '${record.stackTrace}');
          }

          print(jsonEncode({
            'severity': level.name.toUpperCase(),
            'message': message,
            'logging.googleapis.com/labels': {
              'logger': record.loggerName,
            },
            'time': record.time.toUtc().toIso8601String(),
          }));
          return;
        }
      }

      if (logging != null) {
        final level = _loggingLevel2AppengineLoggingLevel[record.level];
        if (level != null) {
          var message = record.message;

          if (record.loggerName.isNotEmpty) {
            message = '${record.loggerName}: $message';
          }

          void addBlock(String header, String body) {
            body = body.replaceAll('\n', '\n    ');
            message = '$message\n\n$header:\n    $body';
          }

          if (record.error != null) addBlock('Error', '${record.error}');
          if (record.stackTrace != null) {
            addBlock('Stack', '${record.stackTrace}');
          }

          logging.log(
            level,
            message,
            timestamp: record.time,
          );
          if (record.error != null && record.stackTrace != null) {
            logging.reportError(level, record.error!, record.stackTrace!);
          }
        }
      }
    });
  });
}
