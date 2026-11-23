import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

import '../../shared/env_config.dart';
import '../../shared/utils.dart';

const _maxMessageLength = 64 * 1024;
const _maxStackTraceLength = 32 * 1024;
const _maxStackTraceHeaderLength = 4 * 1024;

final _lineBreakPattern = RegExp(r'\s*\r?\n\s*');
final _invalidV8MemberChars = RegExp(r'[\s();\[\]`]+');

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
      final entry = formatCloudLogEntry(
        record,
        traceId: currentTraceId,
        projectId: envConfig.googleCloudProject,
      );
      if (entry != null) {
        print(jsonEncode(entry));
      }
    });
  });
}

/// Formats [record] as a structured JSON payload for Cloud Logging.
///
/// Returns `null` when [record]'s [LogRecord.level] is not mapped to a Cloud
/// Logging severity (such as [Level.OFF]).
///
/// For [Level.SEVERE] and [Level.SHOUT] records with a stack trace, includes a
/// V8-formatted `stack_trace` field so Google Cloud Error Reporting can parse
/// and group Dart exceptions while keeping `message` in Dart format.
@visibleForTesting
Map<String, Object?>? formatCloudLogEntry(
  LogRecord record, {
  String? traceId,
  String? projectId,
}) {
  final severity = _loggingLevel2CloudLoggingSeverity[record.level];
  if (severity == null) {
    return null;
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
  if (message.length > _maxMessageLength) {
    message =
        message.substring(0, 32 * 1024) +
        '...\n[truncated due to size]\n...' +
        message.substring(message.length - 16 * 1024);
  }

  String? v8StackTrace;
  if (record.level >= Level.SEVERE && stackTrace != null) {
    final fallbackMessage = record.loggerName.isNotEmpty
        ? '${record.loggerName}: ${record.message}'
        : record.message;
    v8StackTrace = formatV8StackTrace(
      error,
      stackTrace,
      fallbackMessage: fallbackMessage,
    );
  }

  return {
    'severity': severity,
    'message': message,
    if (v8StackTrace != null) 'stack_trace': v8StackTrace,
    'logging.googleapis.com/labels': {'logger': record.loggerName},
    'time': record.time.toUtc().toIso8601String(),
    if (traceId != null && projectId != null)
      'logging.googleapis.com/trace': 'projects/$projectId/traces/$traceId',
  };
}

/// Formats [error] and [stackTrace] using V8's `Error.stack` syntax for Google
/// Cloud Error Reporting.
///
/// Cloud Error Reporting checks the `stack_trace` JSON field before `message`
/// and does not natively recognize Dart stack traces; V8 frames
/// (`    at member (uri:line:col)`) are parsed by its JavaScript/Java parser.
///
/// Returns `null` if [stackTrace] contains no parseable frames.
@visibleForTesting
String? formatV8StackTrace(
  Object? error,
  StackTrace stackTrace, {
  String? fallbackMessage,
}) {
  final trace = Trace.from(stackTrace);
  var rawHeader = (error != null ? '$error' : (fallbackMessage ?? ''))
      .replaceAll(_lineBreakPattern, ' ')
      .trim();
  if (rawHeader.length > _maxStackTraceHeaderLength) {
    rawHeader = '${rawHeader.substring(0, _maxStackTraceHeaderLength)}...';
  }

  final buffer = StringBuffer(
    rawHeader.isEmpty ? 'Error\n' : 'Error: $rawHeader\n',
  );
  var frameCount = 0;

  for (final frame in trace.frames) {
    if (frame is UnparsedFrame) {
      continue;
    }

    final member = _formatV8Member(frame.member);
    final String location;
    if (frame.isCore) {
      location = 'native';
    } else if (frame.line != null) {
      location = '${frame.uri}:${frame.line}:${frame.column ?? 0}';
    } else if (frame.uri.toString().isNotEmpty) {
      location = '${frame.uri}';
    } else {
      location = 'unknown location';
    }

    final line = '    at $member ($location)\n';
    if (buffer.length + line.length > _maxStackTraceLength) {
      break;
    }
    buffer.write(line);
    frameCount++;
  }

  if (frameCount == 0) {
    return null;
  }
  return buffer.toString();
}

String _formatV8Member(String? rawMember) {
  var member = rawMember?.trim();
  if (member == null || member.isEmpty || member == '<fn>') {
    return '<anonymous>';
  }
  if (member.startsWith('new ')) {
    final rest = member.substring(4).trim();
    if (rest.isEmpty) {
      return '<anonymous>';
    }
    member = rest.contains('.') ? rest : '$rest.new';
  }
  return member
      .replaceAll('<fn>', '<anonymous>')
      .replaceAll(_invalidV8MemberChars, '_');
}
