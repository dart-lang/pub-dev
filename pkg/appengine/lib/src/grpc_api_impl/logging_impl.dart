// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library grpc_logging;

import 'dart:io';
import 'dart:async';

import '../logging.dart';

import '../grpc_api/logging_api.dart' as api;
import '../grpc_api/dart/google/appengine/logging/v1/request_log.pb.dart'
    as gae_log;
import 'grpc.dart' as grpc;
import '../logging_impl.dart';

const List<String> OAuth2Scopes = const <String>[
  "https://www.googleapis.com/auth/cloud-platform",
  "https://www.googleapis.com/auth/logging.write",
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
  final int _startTimestamp;
  final List<gae_log.LogLine> _gaeLogLines = <gae_log.LogLine>[];

  api.LogSeverity _currentSeverity;
  int _estimatedSize;
  bool _isFirst;

  GrpcRequestLoggingImpl(this._sharedLoggingService, this._httpMethod,
      this._httpResource, this._userAgent, this._host, this._ip)
      : _startTimestamp = new DateTime.now().toUtc().millisecondsSinceEpoch {
    _resetState();
  }

  void log(LogLevel level, String message, {DateTime timestamp}) {
    api.LogSeverity severity = _severityFromLogLevel(level);

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
        (timestamp ?? new DateTime.now().toUtc()).millisecondsSinceEpoch;
    final api.Timestamp startTimestamp =
        _protobufTimestampFromMilliseconds(timestampInMs);

    final logLine = new gae_log.LogLine()
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
  Future flush() async {
    if (_gaeLogLines.length > 0) {
      _enqueue(finish: false);
    }
  }

  /// Finishes the request-specific logs with the given HTTP [responseStatus]
  /// and [responseSize].
  void finish(int responseStatus, int responseSize) {
    if (_gaeLogLines.length > 0) {
      _enqueue(
          finish: true,
          responseStatus: responseStatus,
          responseSize: responseSize);
    }
  }

  /// Builds up the combined [api.LogEntry] and enqueues it in the underlying
  /// [SharedLoggingService].
  void _enqueue({bool finish: false, int responseStatus, int responseSize}) {
    final api.Timestamp startTimestamp =
        _protobufTimestampFromMilliseconds(_startTimestamp);

    final int now = new DateTime.now().toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final appengineRequestLog = new gae_log.RequestLog()
      ..appId = 's~${_sharedLoggingService.projectId}'
      ..versionId = _sharedLoggingService.versionId
      ..method = _httpMethod
      ..resource = _httpResource
      ..startTime = startTimestamp
      ..userAgent = _userAgent ?? ''
      ..host = _host
      ..ip = _ip
      ..line.addAll(_gaeLogLines)
      ..first = _isFirst
      ..finished = finish;

    final protoPayload = new api.Any()
      ..typeUrl = 'type.googleapis.com/google.appengine.logging.v1.RequestLog';

    final gaeResource = new api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = new api.LogEntry()
      ..protoPayload = protoPayload
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = _currentSeverity
      ..logName = _sharedLoggingService.requestLogName;

    _resetState();

    if (finish) {
      final int diff = now - _startTimestamp;
      final latency = new api.Duration()
        ..seconds = new api.Int64(diff ~/ 1000)
        ..nanos = 1000 * 1000 * (diff % 1000);

      appengineRequestLog
        ..endTime = nowTimestamp
        ..latency = latency
        ..status = responseStatus;

      if (responseSize != null) {
        appengineRequestLog.responseSize = new api.Int64(responseSize);
      }

      final httpRequest = new api.HttpRequest()..status = responseStatus;

      logEntry..httpRequest = httpRequest;
    }
    protoPayload..value = appengineRequestLog.writeToBuffer();

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
class GrpcBackgroundLoggingImpl extends Logging {
  final SharedLoggingService _sharedLoggingService;

  GrpcBackgroundLoggingImpl(this._sharedLoggingService);

  void log(LogLevel level, String message, {DateTime timestamp}) {
    api.LogSeverity severity = _severityFromLogLevel(level);

    final int now = new DateTime.now().toUtc().millisecondsSinceEpoch;
    final api.Timestamp nowTimestamp = _protobufTimestampFromMilliseconds(now);

    final gaeResource = new api.MonitoredResource()
      ..type = 'gae_app'
      ..labels.addAll(_sharedLoggingService.resourceLabels);

    final logEntry = new api.LogEntry()
      ..textPayload = message
      ..resource = gaeResource
      ..timestamp = nowTimestamp
      ..severity = severity
      ..logName = _sharedLoggingService.backgroundLogName;

    _sharedLoggingService.enqueue(logEntry);
  }

  Future flush() => new Future.value();
}

/// A [appengine.Logging] adapter which uses the gRPC logging API to send
/// logs asynchronously to the Stackdriver logging service.
class SharedLoggingService {
  static const Duration FLUSH_DURATION = const Duration(seconds: 3);
  static const int MAX_LOGENTRIES = 25;

  final api.LoggingServiceV2Api _clientStub;
  final String projectId;
  final String versionId;
  final List<api.MonitoredResource_LabelsEntry> resourceLabels;
  final String requestLogName;
  final String backgroundLogName;

  final List<api.LogEntry> _entries = <api.LogEntry>[];
  Timer _timer;

  Completer _closeCompleter;
  int _outstandingRequests = 0;

  SharedLoggingService(grpc.Client client, String projectId, String serviceId,
      String versionId, String zoneId)
      : _clientStub = new api.LoggingServiceV2Api(
            new grpc.Channel('google.logging.v2', client)),
        projectId = projectId,
        versionId = versionId,
        resourceLabels = <api.MonitoredResource_LabelsEntry>[
          _makeLabel('project_id', projectId),
          _makeLabel('version_id', versionId),
          _makeLabel('module_id', serviceId),
          _makeLabel('zone', zoneId),
        ],
        requestLogName =
            'projects/$projectId/logs/appengine.googleapis.com%2Frequest_log',
        backgroundLogName =
            'projects/$projectId/logs/appengine.googleapis.com%2Fstderr';

  static _makeLabel(String key, String value) {
    return new api.MonitoredResource_LabelsEntry()
      ..key = key
      ..value = value;
  }

  void enqueue(api.LogEntry entry) {
    _entries.add(entry);

    // If all entries have maximum size we should send them once we have 25 in
    // order to avoid hitting the size limit for the RPC request.
    if (_entries.length > 25) {
      flush();
    } else if (_timer == null) {
      _timer = new Timer(FLUSH_DURATION, flush);
    }
  }

  void flush() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    if (_entries.length == 0) {
      return;
    }

    _outstandingRequests++;
    final request = new api.WriteLogEntriesRequest()
      ..entries.addAll(_entries)
      ..partialSuccess =
          false /* for now we want to get notified if something goes wrong */;
    _entries.clear();
    _clientStub.writeLogEntries(null, request).catchError((error, stack) {
      // In case the logging API failed, we'll write the error message to
      // stderr.  The logging daemon on the VM will make another attempt at
      // uploading stderr via the logging API.
      stderr.writeln('An error occured while writing log entries:\n'
          'Error:$error\n'
          '$stack');
    }).whenComplete(() {
      _outstandingRequests--;
      _maybeClose();
    });
  }

  Future close() {
    assert(_closeCompleter == null);
    _closeCompleter = new Completer();

    // Trigger a last flush which will write out remaining data (if necessary)
    // and try to complete the completer if all work was already done.
    flush();
    _maybeClose();

    return _closeCompleter.future;
  }

  void _maybeClose() {
    if (_outstandingRequests == 0 &&
        _closeCompleter != null &&
        !_closeCompleter.isCompleted) {
      _closeCompleter.complete(null);
    }
  }
}

api.Timestamp _protobufTimestampFromMilliseconds(int ms) {
  return new api.Timestamp()
    ..seconds = new api.Int64(ms ~/ 1000)
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
  throw new ArgumentError('Unknown logevel $level');
}
