import 'dart:convert';

import 'package:appengine/appengine.dart';
// ignore: implementation_imports
import 'package:appengine/src/logging_impl.dart' show LoggingImpl;
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

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
        // pass
      }

      final level = _loggingLevel2AppengineLoggingLevel[record.level];
      if (level == null) {
        return;
      }
      var message = record.message;

      if (record.loggerName.isNotEmpty) {
        message = '${record.loggerName}: $message';
      }

      void addBlock(String header, String body) {
        body = body.replaceAll('\n', '\n    ');
        message = '$message\n\n$header:\n    $body';
      }

      final error = record.error;
      if (error != null) addBlock('Error', '$error');
      var stackTrace = record.stackTrace;
      if (stackTrace is Chain) {
        stackTrace = stackTrace.terse;
      }
      if (stackTrace != null) {
        addBlock('Stack', '$stackTrace');
      }

      // Truncated messages over 200kb
      if (message.length > 200 * 1024) {
        message = message.substring(0, 190 * 1024) +
            '...\n[truncated due to size]\n...' +
            message.substring(190 * 1024, 200 * 1024);
      }

      // Unless logging a request, we just log directly to stdout
      if (logging == null || logging is! LoggingImpl) {
        print(jsonEncode({
          'severity': level.name.toUpperCase(),
          'message': message,
          'logging.googleapis.com/labels': {
            'logger': record.loggerName,
          },
          'time': record.time.toUtc().toIso8601String(),
        }));
      } else {
        // If inside a request, we'll log using appengine logging service, this
        // ensures that our logs works with existing metrics. Eventually, we
        // can consider migrating to structured logging on stdout.
        logging.log(
          level,
          message,
          timestamp: record.time,
        );
        if (error != null && stackTrace != null) {
          logging.reportError(level, error, stackTrace);
        }
      }
    });
  });
}
