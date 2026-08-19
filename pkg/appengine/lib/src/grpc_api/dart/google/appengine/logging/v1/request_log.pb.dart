//
//  Generated code. Do not modify.
//  source: google/appengine/logging/v1/request_log.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../logging/type/log_severity.pbenum.dart' as $64;
import '../../../protobuf/duration.pb.dart' as $51;
import '../../../protobuf/timestamp.pb.dart' as $50;

/// Application log line emitted while processing a request.
class LogLine extends $pb.GeneratedMessage {
  factory LogLine({
    $50.Timestamp? time,
    $64.LogSeverity? severity,
    $core.String? logMessage,
    SourceLocation? sourceLocation,
  }) {
    final $result = create();
    if (time != null) {
      $result.time = time;
    }
    if (severity != null) {
      $result.severity = severity;
    }
    if (logMessage != null) {
      $result.logMessage = logMessage;
    }
    if (sourceLocation != null) {
      $result.sourceLocation = sourceLocation;
    }
    return $result;
  }
  LogLine._() : super();
  factory LogLine.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogLine.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogLine',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.logging.v1'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'time',
        subBuilder: $50.Timestamp.create)
    ..e<$64.LogSeverity>(
        2, _omitFieldNames ? '' : 'severity', $pb.PbFieldType.OE,
        defaultOrMaker: $64.LogSeverity.DEFAULT,
        valueOf: $64.LogSeverity.valueOf,
        enumValues: $64.LogSeverity.values)
    ..aOS(3, _omitFieldNames ? '' : 'logMessage')
    ..aOM<SourceLocation>(4, _omitFieldNames ? '' : 'sourceLocation',
        subBuilder: SourceLocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogLine clone() => LogLine()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogLine copyWith(void Function(LogLine) updates) =>
      super.copyWith((message) => updates(message as LogLine)) as LogLine;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogLine create() => LogLine._();
  LogLine createEmptyInstance() => create();
  static $pb.PbList<LogLine> createRepeated() => $pb.PbList<LogLine>();
  @$core.pragma('dart2js:noInline')
  static LogLine getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogLine>(create);
  static LogLine? _defaultInstance;

  /// Approximate time when this log entry was made.
  @$pb.TagNumber(1)
  $50.Timestamp get time => $_getN(0);
  @$pb.TagNumber(1)
  set time($50.Timestamp v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => clearField(1);
  @$pb.TagNumber(1)
  $50.Timestamp ensureTime() => $_ensure(0);

  /// Severity of this log entry.
  @$pb.TagNumber(2)
  $64.LogSeverity get severity => $_getN(1);
  @$pb.TagNumber(2)
  set severity($64.LogSeverity v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSeverity() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeverity() => clearField(2);

  /// App-provided log message.
  @$pb.TagNumber(3)
  $core.String get logMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set logMessage($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLogMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogMessage() => clearField(3);

  /// Where in the source code this log message was written.
  @$pb.TagNumber(4)
  SourceLocation get sourceLocation => $_getN(3);
  @$pb.TagNumber(4)
  set sourceLocation(SourceLocation v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSourceLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceLocation() => clearField(4);
  @$pb.TagNumber(4)
  SourceLocation ensureSourceLocation() => $_ensure(3);
}

/// Specifies a location in a source code file.
class SourceLocation extends $pb.GeneratedMessage {
  factory SourceLocation({
    $core.String? file,
    $fixnum.Int64? line,
    $core.String? functionName,
  }) {
    final $result = create();
    if (file != null) {
      $result.file = file;
    }
    if (line != null) {
      $result.line = line;
    }
    if (functionName != null) {
      $result.functionName = functionName;
    }
    return $result;
  }
  SourceLocation._() : super();
  factory SourceLocation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceLocation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceLocation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.logging.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'file')
    ..aInt64(2, _omitFieldNames ? '' : 'line')
    ..aOS(3, _omitFieldNames ? '' : 'functionName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceLocation clone() => SourceLocation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceLocation copyWith(void Function(SourceLocation) updates) =>
      super.copyWith((message) => updates(message as SourceLocation))
          as SourceLocation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceLocation create() => SourceLocation._();
  SourceLocation createEmptyInstance() => create();
  static $pb.PbList<SourceLocation> createRepeated() =>
      $pb.PbList<SourceLocation>();
  @$core.pragma('dart2js:noInline')
  static SourceLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceLocation>(create);
  static SourceLocation? _defaultInstance;

  /// Source file name. Depending on the runtime environment, this might be a
  /// simple name or a fully-qualified name.
  @$pb.TagNumber(1)
  $core.String get file => $_getSZ(0);
  @$pb.TagNumber(1)
  set file($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFile() => $_has(0);
  @$pb.TagNumber(1)
  void clearFile() => clearField(1);

  /// Line within the source file.
  @$pb.TagNumber(2)
  $fixnum.Int64 get line => $_getI64(1);
  @$pb.TagNumber(2)
  set line($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLine() => $_has(1);
  @$pb.TagNumber(2)
  void clearLine() => clearField(2);

  /// Human-readable name of the function or method being invoked, with optional
  /// context such as the class or package name. This information is used in
  /// contexts such as the logs viewer, where a file and line number are less
  /// meaningful. The format can vary by language. For example:
  /// `qual.if.ied.Class.method` (Java), `dir/package.func` (Go), `function`
  /// (Python).
  @$pb.TagNumber(3)
  $core.String get functionName => $_getSZ(2);
  @$pb.TagNumber(3)
  set functionName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFunctionName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunctionName() => clearField(3);
}

/// A reference to a particular snapshot of the source tree used to build and
/// deploy an application.
class SourceReference extends $pb.GeneratedMessage {
  factory SourceReference({
    $core.String? repository,
    $core.String? revisionId,
  }) {
    final $result = create();
    if (repository != null) {
      $result.repository = repository;
    }
    if (revisionId != null) {
      $result.revisionId = revisionId;
    }
    return $result;
  }
  SourceReference._() : super();
  factory SourceReference.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceReference.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceReference',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.logging.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'repository')
    ..aOS(2, _omitFieldNames ? '' : 'revisionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceReference clone() => SourceReference()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceReference copyWith(void Function(SourceReference) updates) =>
      super.copyWith((message) => updates(message as SourceReference))
          as SourceReference;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceReference create() => SourceReference._();
  SourceReference createEmptyInstance() => create();
  static $pb.PbList<SourceReference> createRepeated() =>
      $pb.PbList<SourceReference>();
  @$core.pragma('dart2js:noInline')
  static SourceReference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceReference>(create);
  static SourceReference? _defaultInstance;

  /// Optional. A URI string identifying the repository.
  /// Example: "https://github.com/GoogleCloudPlatform/kubernetes.git"
  @$pb.TagNumber(1)
  $core.String get repository => $_getSZ(0);
  @$pb.TagNumber(1)
  set repository($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRepository() => $_has(0);
  @$pb.TagNumber(1)
  void clearRepository() => clearField(1);

  /// The canonical and persistent identifier of the deployed revision.
  /// Example (git): "0035781c50ec7aa23385dc841529ce8a4b70db1b"
  @$pb.TagNumber(2)
  $core.String get revisionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set revisionId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRevisionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRevisionId() => clearField(2);
}

/// Complete log information about a single HTTP request to an App Engine
/// application.
class RequestLog extends $pb.GeneratedMessage {
  factory RequestLog({
    $core.String? appId,
    $core.String? versionId,
    $core.String? requestId,
    $core.String? ip,
    $50.Timestamp? startTime,
    $50.Timestamp? endTime,
    $51.Duration? latency,
    $fixnum.Int64? megaCycles,
    $core.String? method,
    $core.String? resource,
    $core.String? httpVersion,
    $core.int? status,
    $fixnum.Int64? responseSize,
    $core.String? referrer,
    $core.String? userAgent,
    $core.String? urlMapEntry,
    $core.String? host,
    $core.double? cost,
    $core.String? taskQueueName,
    $core.String? taskName,
    $core.bool? wasLoadingRequest,
    $51.Duration? pendingTime,
    $core.int? instanceIndex,
    $core.bool? finished,
    $core.String? instanceId,
    $core.Iterable<LogLine>? line,
    $core.String? moduleId,
    $core.String? appEngineRelease,
    $core.String? traceId,
    $core.String? nickname,
    $core.Iterable<SourceReference>? sourceReference,
    $core.bool? first,
    $core.bool? traceSampled,
  }) {
    final $result = create();
    if (appId != null) {
      $result.appId = appId;
    }
    if (versionId != null) {
      $result.versionId = versionId;
    }
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (ip != null) {
      $result.ip = ip;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (latency != null) {
      $result.latency = latency;
    }
    if (megaCycles != null) {
      $result.megaCycles = megaCycles;
    }
    if (method != null) {
      $result.method = method;
    }
    if (resource != null) {
      $result.resource = resource;
    }
    if (httpVersion != null) {
      $result.httpVersion = httpVersion;
    }
    if (status != null) {
      $result.status = status;
    }
    if (responseSize != null) {
      $result.responseSize = responseSize;
    }
    if (referrer != null) {
      $result.referrer = referrer;
    }
    if (userAgent != null) {
      $result.userAgent = userAgent;
    }
    if (urlMapEntry != null) {
      $result.urlMapEntry = urlMapEntry;
    }
    if (host != null) {
      $result.host = host;
    }
    if (cost != null) {
      $result.cost = cost;
    }
    if (taskQueueName != null) {
      $result.taskQueueName = taskQueueName;
    }
    if (taskName != null) {
      $result.taskName = taskName;
    }
    if (wasLoadingRequest != null) {
      $result.wasLoadingRequest = wasLoadingRequest;
    }
    if (pendingTime != null) {
      $result.pendingTime = pendingTime;
    }
    if (instanceIndex != null) {
      $result.instanceIndex = instanceIndex;
    }
    if (finished != null) {
      $result.finished = finished;
    }
    if (instanceId != null) {
      $result.instanceId = instanceId;
    }
    if (line != null) {
      $result.line.addAll(line);
    }
    if (moduleId != null) {
      $result.moduleId = moduleId;
    }
    if (appEngineRelease != null) {
      $result.appEngineRelease = appEngineRelease;
    }
    if (traceId != null) {
      $result.traceId = traceId;
    }
    if (nickname != null) {
      $result.nickname = nickname;
    }
    if (sourceReference != null) {
      $result.sourceReference.addAll(sourceReference);
    }
    if (first != null) {
      $result.first = first;
    }
    if (traceSampled != null) {
      $result.traceSampled = traceSampled;
    }
    return $result;
  }
  RequestLog._() : super();
  factory RequestLog.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RequestLog.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestLog',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.logging.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appId')
    ..aOS(2, _omitFieldNames ? '' : 'versionId')
    ..aOS(3, _omitFieldNames ? '' : 'requestId')
    ..aOS(4, _omitFieldNames ? '' : 'ip')
    ..aOM<$50.Timestamp>(6, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(7, _omitFieldNames ? '' : 'endTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$51.Duration>(8, _omitFieldNames ? '' : 'latency',
        subBuilder: $51.Duration.create)
    ..aInt64(9, _omitFieldNames ? '' : 'megaCycles')
    ..aOS(10, _omitFieldNames ? '' : 'method')
    ..aOS(11, _omitFieldNames ? '' : 'resource')
    ..aOS(12, _omitFieldNames ? '' : 'httpVersion')
    ..a<$core.int>(13, _omitFieldNames ? '' : 'status', $pb.PbFieldType.O3)
    ..aInt64(14, _omitFieldNames ? '' : 'responseSize')
    ..aOS(15, _omitFieldNames ? '' : 'referrer')
    ..aOS(16, _omitFieldNames ? '' : 'userAgent')
    ..aOS(17, _omitFieldNames ? '' : 'urlMapEntry')
    ..aOS(20, _omitFieldNames ? '' : 'host')
    ..a<$core.double>(21, _omitFieldNames ? '' : 'cost', $pb.PbFieldType.OD)
    ..aOS(22, _omitFieldNames ? '' : 'taskQueueName')
    ..aOS(23, _omitFieldNames ? '' : 'taskName')
    ..aOB(24, _omitFieldNames ? '' : 'wasLoadingRequest')
    ..aOM<$51.Duration>(25, _omitFieldNames ? '' : 'pendingTime',
        subBuilder: $51.Duration.create)
    ..a<$core.int>(
        26, _omitFieldNames ? '' : 'instanceIndex', $pb.PbFieldType.O3)
    ..aOB(27, _omitFieldNames ? '' : 'finished')
    ..aOS(28, _omitFieldNames ? '' : 'instanceId')
    ..pc<LogLine>(29, _omitFieldNames ? '' : 'line', $pb.PbFieldType.PM,
        subBuilder: LogLine.create)
    ..aOS(37, _omitFieldNames ? '' : 'moduleId')
    ..aOS(38, _omitFieldNames ? '' : 'appEngineRelease')
    ..aOS(39, _omitFieldNames ? '' : 'traceId')
    ..aOS(40, _omitFieldNames ? '' : 'nickname')
    ..pc<SourceReference>(
        41, _omitFieldNames ? '' : 'sourceReference', $pb.PbFieldType.PM,
        subBuilder: SourceReference.create)
    ..aOB(42, _omitFieldNames ? '' : 'first')
    ..aOB(43, _omitFieldNames ? '' : 'traceSampled')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RequestLog clone() => RequestLog()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RequestLog copyWith(void Function(RequestLog) updates) =>
      super.copyWith((message) => updates(message as RequestLog)) as RequestLog;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestLog create() => RequestLog._();
  RequestLog createEmptyInstance() => create();
  static $pb.PbList<RequestLog> createRepeated() => $pb.PbList<RequestLog>();
  @$core.pragma('dart2js:noInline')
  static RequestLog getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestLog>(create);
  static RequestLog? _defaultInstance;

  /// Application that handled this request.
  @$pb.TagNumber(1)
  $core.String get appId => $_getSZ(0);
  @$pb.TagNumber(1)
  set appId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAppId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppId() => clearField(1);

  /// Version of the application that handled this request.
  @$pb.TagNumber(2)
  $core.String get versionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set versionId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersionId() => clearField(2);

  /// Globally unique identifier for a request, which is based on the request
  /// start time.  Request IDs for requests which started later will compare
  /// greater as strings than those for requests which started earlier.
  @$pb.TagNumber(3)
  $core.String get requestId => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRequestId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestId() => clearField(3);

  /// Origin IP address.
  @$pb.TagNumber(4)
  $core.String get ip => $_getSZ(3);
  @$pb.TagNumber(4)
  set ip($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIp() => $_has(3);
  @$pb.TagNumber(4)
  void clearIp() => clearField(4);

  /// Time when the request started.
  @$pb.TagNumber(6)
  $50.Timestamp get startTime => $_getN(4);
  @$pb.TagNumber(6)
  set startTime($50.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasStartTime() => $_has(4);
  @$pb.TagNumber(6)
  void clearStartTime() => clearField(6);
  @$pb.TagNumber(6)
  $50.Timestamp ensureStartTime() => $_ensure(4);

  /// Time when the request finished.
  @$pb.TagNumber(7)
  $50.Timestamp get endTime => $_getN(5);
  @$pb.TagNumber(7)
  set endTime($50.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasEndTime() => $_has(5);
  @$pb.TagNumber(7)
  void clearEndTime() => clearField(7);
  @$pb.TagNumber(7)
  $50.Timestamp ensureEndTime() => $_ensure(5);

  /// Latency of the request.
  @$pb.TagNumber(8)
  $51.Duration get latency => $_getN(6);
  @$pb.TagNumber(8)
  set latency($51.Duration v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasLatency() => $_has(6);
  @$pb.TagNumber(8)
  void clearLatency() => clearField(8);
  @$pb.TagNumber(8)
  $51.Duration ensureLatency() => $_ensure(6);

  /// Number of CPU megacycles used to process request.
  @$pb.TagNumber(9)
  $fixnum.Int64 get megaCycles => $_getI64(7);
  @$pb.TagNumber(9)
  set megaCycles($fixnum.Int64 v) {
    $_setInt64(7, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasMegaCycles() => $_has(7);
  @$pb.TagNumber(9)
  void clearMegaCycles() => clearField(9);

  /// Request method. Example: `"GET"`, `"HEAD"`, `"PUT"`, `"POST"`, `"DELETE"`.
  @$pb.TagNumber(10)
  $core.String get method => $_getSZ(8);
  @$pb.TagNumber(10)
  set method($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasMethod() => $_has(8);
  @$pb.TagNumber(10)
  void clearMethod() => clearField(10);

  /// Contains the path and query portion of the URL that was requested. For
  /// example, if the URL was "http://example.com/app?name=val", the resource
  /// would be "/app?name=val".  The fragment identifier, which is identified by
  /// the `#` character, is not included.
  @$pb.TagNumber(11)
  $core.String get resource => $_getSZ(9);
  @$pb.TagNumber(11)
  set resource($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasResource() => $_has(9);
  @$pb.TagNumber(11)
  void clearResource() => clearField(11);

  /// HTTP version of request. Example: `"HTTP/1.1"`.
  @$pb.TagNumber(12)
  $core.String get httpVersion => $_getSZ(10);
  @$pb.TagNumber(12)
  set httpVersion($core.String v) {
    $_setString(10, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasHttpVersion() => $_has(10);
  @$pb.TagNumber(12)
  void clearHttpVersion() => clearField(12);

  /// HTTP response status code. Example: 200, 404.
  @$pb.TagNumber(13)
  $core.int get status => $_getIZ(11);
  @$pb.TagNumber(13)
  set status($core.int v) {
    $_setSignedInt32(11, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  /// Size in bytes sent back to client by request.
  @$pb.TagNumber(14)
  $fixnum.Int64 get responseSize => $_getI64(12);
  @$pb.TagNumber(14)
  set responseSize($fixnum.Int64 v) {
    $_setInt64(12, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasResponseSize() => $_has(12);
  @$pb.TagNumber(14)
  void clearResponseSize() => clearField(14);

  /// Referrer URL of request.
  @$pb.TagNumber(15)
  $core.String get referrer => $_getSZ(13);
  @$pb.TagNumber(15)
  set referrer($core.String v) {
    $_setString(13, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasReferrer() => $_has(13);
  @$pb.TagNumber(15)
  void clearReferrer() => clearField(15);

  /// User agent that made the request.
  @$pb.TagNumber(16)
  $core.String get userAgent => $_getSZ(14);
  @$pb.TagNumber(16)
  set userAgent($core.String v) {
    $_setString(14, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasUserAgent() => $_has(14);
  @$pb.TagNumber(16)
  void clearUserAgent() => clearField(16);

  /// File or class that handled the request.
  @$pb.TagNumber(17)
  $core.String get urlMapEntry => $_getSZ(15);
  @$pb.TagNumber(17)
  set urlMapEntry($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasUrlMapEntry() => $_has(15);
  @$pb.TagNumber(17)
  void clearUrlMapEntry() => clearField(17);

  /// Internet host and port number of the resource being requested.
  @$pb.TagNumber(20)
  $core.String get host => $_getSZ(16);
  @$pb.TagNumber(20)
  set host($core.String v) {
    $_setString(16, v);
  }

  @$pb.TagNumber(20)
  $core.bool hasHost() => $_has(16);
  @$pb.TagNumber(20)
  void clearHost() => clearField(20);

  /// An indication of the relative cost of serving this request.
  @$pb.TagNumber(21)
  $core.double get cost => $_getN(17);
  @$pb.TagNumber(21)
  set cost($core.double v) {
    $_setDouble(17, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasCost() => $_has(17);
  @$pb.TagNumber(21)
  void clearCost() => clearField(21);

  /// Queue name of the request, in the case of an offline request.
  @$pb.TagNumber(22)
  $core.String get taskQueueName => $_getSZ(18);
  @$pb.TagNumber(22)
  set taskQueueName($core.String v) {
    $_setString(18, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasTaskQueueName() => $_has(18);
  @$pb.TagNumber(22)
  void clearTaskQueueName() => clearField(22);

  /// Task name of the request, in the case of an offline request.
  @$pb.TagNumber(23)
  $core.String get taskName => $_getSZ(19);
  @$pb.TagNumber(23)
  set taskName($core.String v) {
    $_setString(19, v);
  }

  @$pb.TagNumber(23)
  $core.bool hasTaskName() => $_has(19);
  @$pb.TagNumber(23)
  void clearTaskName() => clearField(23);

  /// Whether this was a loading request for the instance.
  @$pb.TagNumber(24)
  $core.bool get wasLoadingRequest => $_getBF(20);
  @$pb.TagNumber(24)
  set wasLoadingRequest($core.bool v) {
    $_setBool(20, v);
  }

  @$pb.TagNumber(24)
  $core.bool hasWasLoadingRequest() => $_has(20);
  @$pb.TagNumber(24)
  void clearWasLoadingRequest() => clearField(24);

  /// Time this request spent in the pending request queue.
  @$pb.TagNumber(25)
  $51.Duration get pendingTime => $_getN(21);
  @$pb.TagNumber(25)
  set pendingTime($51.Duration v) {
    setField(25, v);
  }

  @$pb.TagNumber(25)
  $core.bool hasPendingTime() => $_has(21);
  @$pb.TagNumber(25)
  void clearPendingTime() => clearField(25);
  @$pb.TagNumber(25)
  $51.Duration ensurePendingTime() => $_ensure(21);

  /// If the instance processing this request belongs to a manually scaled
  /// module, then this is the 0-based index of the instance. Otherwise, this
  /// value is -1.
  @$pb.TagNumber(26)
  $core.int get instanceIndex => $_getIZ(22);
  @$pb.TagNumber(26)
  set instanceIndex($core.int v) {
    $_setSignedInt32(22, v);
  }

  @$pb.TagNumber(26)
  $core.bool hasInstanceIndex() => $_has(22);
  @$pb.TagNumber(26)
  void clearInstanceIndex() => clearField(26);

  /// Whether this request is finished or active.
  @$pb.TagNumber(27)
  $core.bool get finished => $_getBF(23);
  @$pb.TagNumber(27)
  set finished($core.bool v) {
    $_setBool(23, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasFinished() => $_has(23);
  @$pb.TagNumber(27)
  void clearFinished() => clearField(27);

  /// An identifier for the instance that handled the request.
  @$pb.TagNumber(28)
  $core.String get instanceId => $_getSZ(24);
  @$pb.TagNumber(28)
  set instanceId($core.String v) {
    $_setString(24, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasInstanceId() => $_has(24);
  @$pb.TagNumber(28)
  void clearInstanceId() => clearField(28);

  /// A list of log lines emitted by the application while serving this request.
  @$pb.TagNumber(29)
  $core.List<LogLine> get line => $_getList(25);

  /// Module of the application that handled this request.
  @$pb.TagNumber(37)
  $core.String get moduleId => $_getSZ(26);
  @$pb.TagNumber(37)
  set moduleId($core.String v) {
    $_setString(26, v);
  }

  @$pb.TagNumber(37)
  $core.bool hasModuleId() => $_has(26);
  @$pb.TagNumber(37)
  void clearModuleId() => clearField(37);

  /// App Engine release version.
  @$pb.TagNumber(38)
  $core.String get appEngineRelease => $_getSZ(27);
  @$pb.TagNumber(38)
  set appEngineRelease($core.String v) {
    $_setString(27, v);
  }

  @$pb.TagNumber(38)
  $core.bool hasAppEngineRelease() => $_has(27);
  @$pb.TagNumber(38)
  void clearAppEngineRelease() => clearField(38);

  /// Stackdriver Trace identifier for this request.
  @$pb.TagNumber(39)
  $core.String get traceId => $_getSZ(28);
  @$pb.TagNumber(39)
  set traceId($core.String v) {
    $_setString(28, v);
  }

  @$pb.TagNumber(39)
  $core.bool hasTraceId() => $_has(28);
  @$pb.TagNumber(39)
  void clearTraceId() => clearField(39);

  ///  The logged-in user who made the request.
  ///
  ///  Most likely, this is the part of the user's email before the `@` sign.  The
  ///  field value is the same for different requests from the same user, but
  ///  different users can have similar names.  This information is also
  ///  available to the application via the App Engine Users API.
  ///
  ///  This field will be populated starting with App Engine 1.9.21.
  @$pb.TagNumber(40)
  $core.String get nickname => $_getSZ(29);
  @$pb.TagNumber(40)
  set nickname($core.String v) {
    $_setString(29, v);
  }

  @$pb.TagNumber(40)
  $core.bool hasNickname() => $_has(29);
  @$pb.TagNumber(40)
  void clearNickname() => clearField(40);

  /// Source code for the application that handled this request. There can be
  /// more than one source reference per deployed application if source code is
  /// distributed among multiple repositories.
  @$pb.TagNumber(41)
  $core.List<SourceReference> get sourceReference => $_getList(30);

  /// Whether this is the first `RequestLog` entry for this request.  If an
  /// active request has several `RequestLog` entries written to Stackdriver
  /// Logging, then this field will be set for one of them.
  @$pb.TagNumber(42)
  $core.bool get first => $_getBF(31);
  @$pb.TagNumber(42)
  set first($core.bool v) {
    $_setBool(31, v);
  }

  @$pb.TagNumber(42)
  $core.bool hasFirst() => $_has(31);
  @$pb.TagNumber(42)
  void clearFirst() => clearField(42);

  /// If true, the value in the 'trace_id' field was sampled for storage in a
  /// trace backend.
  @$pb.TagNumber(43)
  $core.bool get traceSampled => $_getBF(32);
  @$pb.TagNumber(43)
  set traceSampled($core.bool v) {
    $_setBool(32, v);
  }

  @$pb.TagNumber(43)
  $core.bool hasTraceSampled() => $_has(32);
  @$pb.TagNumber(43)
  void clearTraceSampled() => clearField(43);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
