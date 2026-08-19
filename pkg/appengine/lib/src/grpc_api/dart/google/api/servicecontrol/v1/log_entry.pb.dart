//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/log_entry.proto
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
import '../../../protobuf/any.pb.dart' as $49;
import '../../../protobuf/struct.pb.dart' as $48;
import '../../../protobuf/timestamp.pb.dart' as $50;
import 'http_request.pb.dart' as $107;

enum LogEntry_Payload { protoPayload, textPayload, structPayload, notSet }

/// An individual log entry.
class LogEntry extends $pb.GeneratedMessage {
  factory LogEntry({
    $49.Any? protoPayload,
    $core.String? textPayload,
    $core.String? insertId,
    $48.Struct? structPayload,
    $core.String? name,
    $50.Timestamp? timestamp,
    $64.LogSeverity? severity,
    $core.Map<$core.String, $core.String>? labels,
    $107.HttpRequest? httpRequest,
    $core.String? trace,
    LogEntryOperation? operation,
    LogEntrySourceLocation? sourceLocation,
  }) {
    final $result = create();
    if (protoPayload != null) {
      $result.protoPayload = protoPayload;
    }
    if (textPayload != null) {
      $result.textPayload = textPayload;
    }
    if (insertId != null) {
      $result.insertId = insertId;
    }
    if (structPayload != null) {
      $result.structPayload = structPayload;
    }
    if (name != null) {
      $result.name = name;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (severity != null) {
      $result.severity = severity;
    }
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (httpRequest != null) {
      $result.httpRequest = httpRequest;
    }
    if (trace != null) {
      $result.trace = trace;
    }
    if (operation != null) {
      $result.operation = operation;
    }
    if (sourceLocation != null) {
      $result.sourceLocation = sourceLocation;
    }
    return $result;
  }
  LogEntry._() : super();
  factory LogEntry.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntry.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LogEntry_Payload> _LogEntry_PayloadByTag = {
    2: LogEntry_Payload.protoPayload,
    3: LogEntry_Payload.textPayload,
    6: LogEntry_Payload.structPayload,
    0: LogEntry_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntry',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 6])
    ..aOM<$49.Any>(2, _omitFieldNames ? '' : 'protoPayload',
        subBuilder: $49.Any.create)
    ..aOS(3, _omitFieldNames ? '' : 'textPayload')
    ..aOS(4, _omitFieldNames ? '' : 'insertId')
    ..aOM<$48.Struct>(6, _omitFieldNames ? '' : 'structPayload',
        subBuilder: $48.Struct.create)
    ..aOS(10, _omitFieldNames ? '' : 'name')
    ..aOM<$50.Timestamp>(11, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $50.Timestamp.create)
    ..e<$64.LogSeverity>(
        12, _omitFieldNames ? '' : 'severity', $pb.PbFieldType.OE,
        defaultOrMaker: $64.LogSeverity.DEFAULT,
        valueOf: $64.LogSeverity.valueOf,
        enumValues: $64.LogSeverity.values)
    ..m<$core.String, $core.String>(13, _omitFieldNames ? '' : 'labels',
        entryClassName: 'LogEntry.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.servicecontrol.v1'))
    ..aOM<$107.HttpRequest>(14, _omitFieldNames ? '' : 'httpRequest',
        subBuilder: $107.HttpRequest.create)
    ..aOS(15, _omitFieldNames ? '' : 'trace')
    ..aOM<LogEntryOperation>(16, _omitFieldNames ? '' : 'operation',
        subBuilder: LogEntryOperation.create)
    ..aOM<LogEntrySourceLocation>(17, _omitFieldNames ? '' : 'sourceLocation',
        subBuilder: LogEntrySourceLocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogEntry clone() => LogEntry()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogEntry copyWith(void Function(LogEntry) updates) =>
      super.copyWith((message) => updates(message as LogEntry)) as LogEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntry create() => LogEntry._();
  LogEntry createEmptyInstance() => create();
  static $pb.PbList<LogEntry> createRepeated() => $pb.PbList<LogEntry>();
  @$core.pragma('dart2js:noInline')
  static LogEntry getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogEntry>(create);
  static LogEntry? _defaultInstance;

  LogEntry_Payload whichPayload() => _LogEntry_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => clearField($_whichOneof(0));

  /// The log entry payload, represented as a protocol buffer that is
  /// expressed as a JSON object. The only accepted type currently is
  /// [AuditLog][google.cloud.audit.AuditLog].
  @$pb.TagNumber(2)
  $49.Any get protoPayload => $_getN(0);
  @$pb.TagNumber(2)
  set protoPayload($49.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProtoPayload() => $_has(0);
  @$pb.TagNumber(2)
  void clearProtoPayload() => clearField(2);
  @$pb.TagNumber(2)
  $49.Any ensureProtoPayload() => $_ensure(0);

  /// The log entry payload, represented as a Unicode string (UTF-8).
  @$pb.TagNumber(3)
  $core.String get textPayload => $_getSZ(1);
  @$pb.TagNumber(3)
  set textPayload($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTextPayload() => $_has(1);
  @$pb.TagNumber(3)
  void clearTextPayload() => clearField(3);

  /// A unique ID for the log entry used for deduplication. If omitted,
  /// the implementation will generate one based on operation_id.
  @$pb.TagNumber(4)
  $core.String get insertId => $_getSZ(2);
  @$pb.TagNumber(4)
  set insertId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasInsertId() => $_has(2);
  @$pb.TagNumber(4)
  void clearInsertId() => clearField(4);

  /// The log entry payload, represented as a structure that
  /// is expressed as a JSON object.
  @$pb.TagNumber(6)
  $48.Struct get structPayload => $_getN(3);
  @$pb.TagNumber(6)
  set structPayload($48.Struct v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasStructPayload() => $_has(3);
  @$pb.TagNumber(6)
  void clearStructPayload() => clearField(6);
  @$pb.TagNumber(6)
  $48.Struct ensureStructPayload() => $_ensure(3);

  /// Required. The log to which this log entry belongs. Examples: `"syslog"`,
  /// `"book_log"`.
  @$pb.TagNumber(10)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(10)
  set name($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(10)
  void clearName() => clearField(10);

  /// The time the event described by the log entry occurred. If
  /// omitted, defaults to operation start time.
  @$pb.TagNumber(11)
  $50.Timestamp get timestamp => $_getN(5);
  @$pb.TagNumber(11)
  set timestamp($50.Timestamp v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(11)
  void clearTimestamp() => clearField(11);
  @$pb.TagNumber(11)
  $50.Timestamp ensureTimestamp() => $_ensure(5);

  /// The severity of the log entry. The default value is
  /// `LogSeverity.DEFAULT`.
  @$pb.TagNumber(12)
  $64.LogSeverity get severity => $_getN(6);
  @$pb.TagNumber(12)
  set severity($64.LogSeverity v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasSeverity() => $_has(6);
  @$pb.TagNumber(12)
  void clearSeverity() => clearField(12);

  /// A set of user-defined (key, value) data that provides additional
  /// information about the log entry.
  @$pb.TagNumber(13)
  $core.Map<$core.String, $core.String> get labels => $_getMap(7);

  /// Optional. Information about the HTTP request associated with this
  /// log entry, if applicable.
  @$pb.TagNumber(14)
  $107.HttpRequest get httpRequest => $_getN(8);
  @$pb.TagNumber(14)
  set httpRequest($107.HttpRequest v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasHttpRequest() => $_has(8);
  @$pb.TagNumber(14)
  void clearHttpRequest() => clearField(14);
  @$pb.TagNumber(14)
  $107.HttpRequest ensureHttpRequest() => $_ensure(8);

  /// Optional. Resource name of the trace associated with the log entry, if any.
  /// If this field contains a relative resource name, you can assume the name is
  /// relative to `//tracing.googleapis.com`. Example:
  /// `projects/my-projectid/traces/06796866738c859f2f19b7cfb3214824`
  @$pb.TagNumber(15)
  $core.String get trace => $_getSZ(9);
  @$pb.TagNumber(15)
  set trace($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasTrace() => $_has(9);
  @$pb.TagNumber(15)
  void clearTrace() => clearField(15);

  /// Optional. Information about an operation associated with the log entry, if
  /// applicable.
  @$pb.TagNumber(16)
  LogEntryOperation get operation => $_getN(10);
  @$pb.TagNumber(16)
  set operation(LogEntryOperation v) {
    setField(16, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasOperation() => $_has(10);
  @$pb.TagNumber(16)
  void clearOperation() => clearField(16);
  @$pb.TagNumber(16)
  LogEntryOperation ensureOperation() => $_ensure(10);

  /// Optional. Source code location information associated with the log entry,
  /// if any.
  @$pb.TagNumber(17)
  LogEntrySourceLocation get sourceLocation => $_getN(11);
  @$pb.TagNumber(17)
  set sourceLocation(LogEntrySourceLocation v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasSourceLocation() => $_has(11);
  @$pb.TagNumber(17)
  void clearSourceLocation() => clearField(17);
  @$pb.TagNumber(17)
  LogEntrySourceLocation ensureSourceLocation() => $_ensure(11);
}

/// Additional information about a potentially long-running operation with which
/// a log entry is associated.
class LogEntryOperation extends $pb.GeneratedMessage {
  factory LogEntryOperation({
    $core.String? id,
    $core.String? producer,
    $core.bool? first,
    $core.bool? last,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (producer != null) {
      $result.producer = producer;
    }
    if (first != null) {
      $result.first = first;
    }
    if (last != null) {
      $result.last = last;
    }
    return $result;
  }
  LogEntryOperation._() : super();
  factory LogEntryOperation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntryOperation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntryOperation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'producer')
    ..aOB(3, _omitFieldNames ? '' : 'first')
    ..aOB(4, _omitFieldNames ? '' : 'last')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogEntryOperation clone() => LogEntryOperation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogEntryOperation copyWith(void Function(LogEntryOperation) updates) =>
      super.copyWith((message) => updates(message as LogEntryOperation))
          as LogEntryOperation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntryOperation create() => LogEntryOperation._();
  LogEntryOperation createEmptyInstance() => create();
  static $pb.PbList<LogEntryOperation> createRepeated() =>
      $pb.PbList<LogEntryOperation>();
  @$core.pragma('dart2js:noInline')
  static LogEntryOperation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntryOperation>(create);
  static LogEntryOperation? _defaultInstance;

  /// Optional. An arbitrary operation identifier. Log entries with the
  /// same identifier are assumed to be part of the same operation.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// Optional. An arbitrary producer identifier. The combination of
  /// `id` and `producer` must be globally unique.  Examples for `producer`:
  /// `"MyDivision.MyBigCompany.com"`, `"github.com/MyProject/MyApplication"`.
  @$pb.TagNumber(2)
  $core.String get producer => $_getSZ(1);
  @$pb.TagNumber(2)
  set producer($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProducer() => $_has(1);
  @$pb.TagNumber(2)
  void clearProducer() => clearField(2);

  /// Optional. Set this to True if this is the first log entry in the operation.
  @$pb.TagNumber(3)
  $core.bool get first => $_getBF(2);
  @$pb.TagNumber(3)
  set first($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFirst() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirst() => clearField(3);

  /// Optional. Set this to True if this is the last log entry in the operation.
  @$pb.TagNumber(4)
  $core.bool get last => $_getBF(3);
  @$pb.TagNumber(4)
  set last($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLast() => $_has(3);
  @$pb.TagNumber(4)
  void clearLast() => clearField(4);
}

/// Additional information about the source code location that produced the log
/// entry.
class LogEntrySourceLocation extends $pb.GeneratedMessage {
  factory LogEntrySourceLocation({
    $core.String? file,
    $fixnum.Int64? line,
    $core.String? function,
  }) {
    final $result = create();
    if (file != null) {
      $result.file = file;
    }
    if (line != null) {
      $result.line = line;
    }
    if (function != null) {
      $result.function = function;
    }
    return $result;
  }
  LogEntrySourceLocation._() : super();
  factory LogEntrySourceLocation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogEntrySourceLocation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogEntrySourceLocation',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'file')
    ..aInt64(2, _omitFieldNames ? '' : 'line')
    ..aOS(3, _omitFieldNames ? '' : 'function')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogEntrySourceLocation clone() =>
      LogEntrySourceLocation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogEntrySourceLocation copyWith(
          void Function(LogEntrySourceLocation) updates) =>
      super.copyWith((message) => updates(message as LogEntrySourceLocation))
          as LogEntrySourceLocation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation create() => LogEntrySourceLocation._();
  LogEntrySourceLocation createEmptyInstance() => create();
  static $pb.PbList<LogEntrySourceLocation> createRepeated() =>
      $pb.PbList<LogEntrySourceLocation>();
  @$core.pragma('dart2js:noInline')
  static LogEntrySourceLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogEntrySourceLocation>(create);
  static LogEntrySourceLocation? _defaultInstance;

  /// Optional. Source file name. Depending on the runtime environment, this
  /// might be a simple name or a fully-qualified name.
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

  /// Optional. Line within the source file. 1-based; 0 indicates no line number
  /// available.
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

  /// Optional. Human-readable name of the function or method being invoked, with
  /// optional context such as the class or package name. This information may be
  /// used in contexts such as the logs viewer, where a file and line number are
  /// less meaningful. The format can vary by language. For example:
  /// `qual.if.ied.Class.method` (Java), `dir/package.func` (Go), `function`
  /// (Python).
  @$pb.TagNumber(3)
  $core.String get function => $_getSZ(2);
  @$pb.TagNumber(3)
  set function($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
