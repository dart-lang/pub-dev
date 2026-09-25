import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../frontend/request_context.dart';
import '../../shared/env_config.dart';

final Map<Level, String?> _loggingLevel2CloudLoggingSeverity = {
  Level.OFF: null,
  Level.ALL: 'DEBUG',
  Level.FINEST: 'DEBUG',
  Level.FINER: 'DEBUG',
  Level.FINE: 'DEBUG',
  Level.CONFIG: 'INFO',
  Level.INFO: 'INFO',
  Level.WARNING: 'WARNING',
  Level.SEVERE: 'ERROR',
  Level.SHOUT: 'CRITICAL',
};

var _setupAppEngineLogging = false;
void setupAppEngineLogging() {
  if (_setupAppEngineLogging) {
    return;
  }
  _setupAppEngineLogging = true;
  Logger.root.onRecord.listen((LogRecord record) {
    record.zone!.run(() {
      final severity = _loggingLevel2CloudLoggingSeverity[record.level];
      if (severity == null) {
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

      // Truncated messages over 64kb
      if (message.length > 64 * 1024) {
        message =
            message.substring(0, 32 * 1024) +
            '...\n[truncated due to size]\n...' +
            message.substring(message.length - 16 * 1024);
      }

      final traceId = requestContext.traceId;
      final projectId = envConfig.googleCloudProject;
      print(
        jsonEncode({
          'severity': severity,
          'message': message,
          'logging.googleapis.com/labels': {'logger': record.loggerName},
          'time': record.time.toUtc().toIso8601String(),
          if (traceId != null && projectId != null)
            'logging.googleapis.com/trace':
                'projects/$projectId/traces/$traceId',
        }),
      );
    });
  });
}
