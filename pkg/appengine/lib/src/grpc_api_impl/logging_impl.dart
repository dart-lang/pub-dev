// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart' as grpc;
import 'package:stack_trace/stack_trace.dart' show Trace;

import '../grpc_api/dart/google/appengine/logging/v1/request_log.pb.dart'
    as gae_log;
import '../grpc_api/logging_api.dart' as api;
import '../logging.dart';
import '../logging_impl.dart';

const List<String> OAuth2Scopes = <String>[
  'https://www.googleapis.com/auth/cloud-platform',
  'https://www.googleapis.com/auth/logging.write',
];

/// A [appengine.Logging] adapter which groups request-specific logging
/// entries and sends them off via the [SharedLoggingService].
///
/// The `package:appengine` framework is responsible for calling [finish]
/// once the request is done in order to flush all logs and send the combined
/// log entry.
///
/// It uses an embedded AppEngine-compatible protobuf message in order to group
/// logging messages together.
class GrpcRequestLoggingImpl extends LoggingImpl {
  static const int logEntryBaseLimit = 150;
  static const int logEntrySizeLimit = 40 * 1024;

  final SharedLoggingService _sharedLoggingService;
  final String _httpMethod;
  final String _httpResource;
  final String _userAgent;
  final String _host;
  final String _ip;
  final String? _traceId;
  final String _referrer;
  final int _startTimestamp;
  final List<gae_log.LogLine> _gaeLogLines = <gae_log.LogLine>[];

  late api.LogSeverity _currentSeverity;
  late int _estimatedSize;
  late bool _isFirst;

  GrpcRequestLoggingImpl(
      this._sharedLoggingService,
      this._httpMethod,
      this._httpResource,
      this._userAgent,
      this._host,
      this._ip,
      this._traceId,
      this._referrer)
      : _startTimestamp = DateTime.now().toUtc().millisecondsSinceEpoch {
    _resetState();
    _isFirst = true;
  }

  @override
  void log(
    LogLevel level,
    String message, {
    DateTime? timestamp,
  }) {
    final api.LogSeverity severity = _severityFromLogLevel(level);

    // The severity of the combined log entry will be the highest severity
    // of the individual log lines.
    if (severity.value > _currentSeverity.value) {
      _currentSeverity = severity;
    }

    // We'll send out not-yet-finished entries if they become too big (there
    // are limits on how big individual log entries and combined log-write RPCs
    // can be, we're using conservative estimates).
    _estimatedSize += 25 + message.length;

    final timestampInMs =
        (timestamp ?? DateTime.now().toUtc()).millisecondsSinceEpoch;
    final api.Timestamp startTimestamp =
        _protobufTimestampFromMilliseconds(timestampInMs);

    final logLine = gae_log.LogLine()
      ..time = startTimestamp
      ..severity = _currentSeverity
      ..logMessage = message;

    _gaeLogLines.add(logLine);

    // NOTE: We could consider starting a timer here, so we're guaranteed
    // to flush the logs. Currently we assume that the framework will call
    // [finish] when the http request is done.
    if (_estimatedSize > logEntrySizeLimit) {
      _enqueue(finish: false);
    }
  }

  /// Flushes the so-far collected loglines to the underlying
  /// [SharedLoggingService]. There is no guarantee that it will immediately be
  /// sent to the server.
  @override
  Future flush() async {
    if (_gaeLogLines.isNotEmpty) {
      _enqueue(finish: false);
    }
  }

  /// Finishes the request-specific logs with the given HTTP [responseStatus]
  /// and [responseSize].
  @override
  void finish(int responseStatus, int responseSize) {
    if (_gaeLogLines.isNotEmpty) {
      _enqueue(
          finish: true,
          responseStatus: responseStatus,
          responseSize: responseSize);
    }
  }

  @override
  void reportError(
    LogLevel level,
    Object error,
    StackTrace stackTrace, {
    DateTime? timestamp,
  }) {
    final api.LogSeverity severity = _severityFromLogLevel(level);
    timestamp ??= DateTime.now();

    final int now = timestamp.toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final gaeResource = api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = api.LogEntry()
      ..textPayload = _formatStackTrace(error, stackTrace)
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = severity
      // Write to stderr log, see:
      // https://cloud.google.com/error-reporting/docs/setup/app-engine-flexible-environment
      ..logName = _sharedLoggingService.backgroundLogName;

    if (_traceId != null) {
      _addLabel(logEntry, 'appengine.googleapis.com/trace_id', _traceId!);
    }

    _sharedLoggingService.enqueue(logEntry);
  }

  /// Builds up the combined [api.LogEntry] and enqueues it in the underlying
  /// [SharedLoggingService].
  void _enqueue({bool finish = false, int? responseStatus, int? responseSize}) {
    final api.Timestamp startTimestamp =
        _protobufTimestampFromMilliseconds(_startTimestamp);

    final int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final protoPayload = api.Any()
      ..typeUrl = 'type.googleapis.com/google.appengine.logging.v1.RequestLog';

    final gaeResource = api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = api.LogEntry()
      ..protoPayload = protoPayload
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = _currentSeverity
      ..logName = _sharedLoggingService.requestLogName;

    final appengineRequestLog = gae_log.RequestLog()
      ..appId = 's~${_sharedLoggingService.projectId}'
      ..versionId = _sharedLoggingService.versionId
      ..method = _httpMethod
      ..resource = _httpResource
      ..startTime = startTimestamp
      ..userAgent = _userAgent
      ..host = _host
      ..ip = _ip
      ..line.addAll(_gaeLogLines)
      ..first = _isFirst
      ..finished = finish;

    if (_sharedLoggingService.instanceId != null) {
      appengineRequestLog.instanceId = _sharedLoggingService.instanceId!;
    }

    if (_traceId != null) {
      appengineRequestLog.traceId = _traceId!;
      _addLabel(logEntry, 'appengine.googleapis.com/trace_id', _traceId!);
    }

    appengineRequestLog.referrer = _referrer;
    _resetState();

    if (finish) {
      final int diff = now - _startTimestamp;
      final latency = api.Duration()
        ..seconds = api.Int64(diff ~/ 1000)
        ..nanos = 1000 * 1000 * (diff % 1000);

      appengineRequestLog
        ..endTime = nowTimestamp
        ..latency = latency
        ..status = responseStatus!;

      if (responseSize != null) {
        appengineRequestLog.responseSize = api.Int64(responseSize);
      }

      final httpRequest = api.HttpRequest()..status = responseStatus;

      logEntry.httpRequest = httpRequest;
    }

    protoPayload.value = appengineRequestLog.writeToBuffer();

    _sharedLoggingService.enqueue(logEntry);
  }

  void _resetState() {
    _isFirst = false;
    _gaeLogLines.clear();
    _currentSeverity = api.LogSeverity.DEBUG;
    _estimatedSize = logEntryBaseLimit;
  }
}

/// A [appengine.Logging] adapter which sends log entries off via the
/// [SharedLoggingService].
class GrpcBackgroundLoggingImpl extends LoggingBase {
  final SharedLoggingService _sharedLoggingService;

  GrpcBackgroundLoggingImpl(this._sharedLoggingService);

  @override
  void log(LogLevel level, String message, {DateTime? timestamp}) {
    final api.LogSeverity severity = _severityFromLogLevel(level);

    final int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final gaeResource = api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = api.LogEntry()
      ..textPayload = message
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = severity
      ..logName = _sharedLoggingService.backgroundLogName;

    _sharedLoggingService.enqueue(logEntry);
  }

  @override
  void reportError(
    LogLevel level,
    Object error,
    StackTrace stackTrace, {
    DateTime? timestamp,
  }) {
    final api.LogSeverity severity = _severityFromLogLevel(level);
    timestamp ??= DateTime.now();

    final int now = timestamp.toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final gaeResource = api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = api.LogEntry()
      ..textPayload = _formatStackTrace(error, stackTrace)
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = severity
      // Write to stderr log, see:
      // https://cloud.google.com/error-reporting/docs/setup/app-engine-flexible-environment
      ..logName = _sharedLoggingService.backgroundLogName;

    _sharedLoggingService.enqueue(logEntry);
  }

  @override
  Future flush() => Future.value();
}

/// A [appengine.Logging] adapter which uses the gRPC logging API to send
/// logs asynchronously to the Stackdriver logging service.
class SharedLoggingService {
  static const Duration FLUSH_DURATION = Duration(seconds: 3);
  static const int MAX_LOGENTRIES = 25;

  final api.LoggingServiceV2Client _clientStub;
  final String projectId;
  final String serviceId;
  final String versionId;
  final String? instanceId;
  final String _instanceName;
  final Map<String, String> resourceLabels;
  final String requestLogName;
  final String backgroundLogName;

  final List<api.LogEntry> _entries = <api.LogEntry>[];
  Timer? _timer;

  Completer? _closeCompleter;
  int _outstandingRequests = 0;

  SharedLoggingService(
      grpc.ClientChannel clientChannel,
      grpc.HttpBasedAuthenticator authenticator,
      this.projectId,
      this.serviceId,
      this.versionId,
      String zoneId,
      this._instanceName,
      this.instanceId)
      : _clientStub = api.LoggingServiceV2Client(clientChannel,
            options: authenticator.toCallOptions),
        resourceLabels = {
          'project_id': projectId,
          'version_id': versionId,
          'module_id': serviceId,
          'zone': zoneId,
        },
        requestLogName =
            'projects/$projectId/logs/appengine.googleapis.com%2Frequest_log',
        backgroundLogName =
            'projects/$projectId/logs/appengine.googleapis.com%2Fstderr';

  void enqueue(api.LogEntry entry) {
    _addLabel(entry, 'appengine.googleapis.com/instance_name', _instanceName);

    _entries.add(entry);

    // If all entries have maximum size we should send them once we have 25 in
    // order to avoid hitting the size limit for the RPC request.
    if (_entries.length > 25) {
      flush();
    } else {
      _timer ??= Timer(FLUSH_DURATION, flush);
    }
  }

  void flush() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    if (_entries.isEmpty) {
      return;
    }

    _outstandingRequests++;
    final request = api.WriteLogEntriesRequest()
      ..entries.addAll(_entries)
      ..partialSuccess =
          false /* for now we want to get notified if something goes wrong */;
    _entries.clear();
    unawaited(() async {
      try {
        await _clientStub.writeLogEntries(request);
      } catch (error, stack) {
        // In case the logging API failed, we'll write the error message to
        // stderr.  The logging daemon on the VM will make another attempt at
        // uploading stderr via the logging API.
        stderr.writeln('An error occured while writing log entries:\n'
            'Error:$error\n'
            '$stack');
      } finally {
        _outstandingRequests--;
        _maybeClose();
      }
    }());
  }

  Future close() {
    assert(_closeCompleter == null);
    _closeCompleter = Completer();

    // Trigger a last flush which will write out remaining data (if necessary)
    // and try to complete the completer if all work was already done.
    flush();
    _maybeClose();

    return _closeCompleter!.future;
  }

  void _maybeClose() {
    if (_outstandingRequests == 0 &&
        _closeCompleter != null &&
        !_closeCompleter!.isCompleted) {
      _closeCompleter!.complete(null);
    }
  }
}

void _addLabel(api.LogEntry entry, String key, String value) {
  entry.labels[key] = value;
}

api.Timestamp _protobufTimestampFromMilliseconds(int ms) {
  return api.Timestamp()
    ..seconds = api.Int64(ms ~/ 1000)
    ..nanos = 1000 * 1000 * (ms % 1000);
}

api.LogSeverity _severityFromLogLevel(LogLevel level) {
  switch (level) {
    case LogLevel.CRITICAL:
      return api.LogSeverity.CRITICAL;
    case LogLevel.ERROR:
      return api.LogSeverity.ERROR;
    case LogLevel.WARNING:
      return api.LogSeverity.WARNING;
    case LogLevel.INFO:
      return api.LogSeverity.INFO;
    case LogLevel.DEBUG:
      return api.LogSeverity.DEBUG;
  }
  throw ArgumentError('Unknown logevel $level');
}

/// Returns a V8-style formatted stack trace.
///
/// This returns a [String] of the this [Trace] formatted using the stack
/// trace format used by V8 in `Error.stack`, regardless of what platform is
/// being used. The first line of this string will always be `'Error:\n'` as
/// this [Trace] doesn't know which [Exception] was thrown.
///
/// This can be useful for submitting stack traces to error correlation
/// services that can parse V8 stack traces, but no Dart stack traces.
/// Though it might be useful to replace the first line with
/// [Exception.toString()] or [Error.toString()] depending what is being
/// reported.
///
/// See: https://cloud.google.com/error-reporting/docs/formatting-error-messages
String _formatStackTrace(Object error, StackTrace stackTrace) =>
    'Error: $error\n${Trace.from(stackTrace).frames.map((f) {
      // Find member
      String? member = f.member;
      if (member == '<fn>') {
        member = '<anonymous>';
      }

      // Find a location
      String loc = 'unknown location';
      if (f.isCore) {
        loc = 'native';
      } else if (f.line != null) {
        loc = '${f.uri}:${f.line}:${f.column ?? 0}';
      }

      return '    at $member ($loc)\n';
    }).join('')}';
