///
//  Generated code. Do not modify.
///
library google.appengine.logging.v1_request_log;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/duration.pb.dart' as google$protobuf;

import '../../../logging/type/log_severity.pbenum.dart' as google$logging$type;

class LogLine extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogLine')
    ..a/*<google$protobuf.Timestamp>*/(1, 'time', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<google$logging$type.LogSeverity>*/(2, 'severity', PbFieldType.OE, google$logging$type.LogSeverity.DEFAULT, google$logging$type.LogSeverity.valueOf)
    ..a/*<String>*/(3, 'logMessage', PbFieldType.OS)
    ..a/*<SourceLocation>*/(4, 'sourceLocation', PbFieldType.OM, SourceLocation.getDefault, SourceLocation.create)
    ..hasRequiredFields = false
  ;

  LogLine() : super();
  LogLine.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogLine.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogLine clone() => new LogLine()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogLine create() => new LogLine();
  static PbList<LogLine> createRepeated() => new PbList<LogLine>();
  static LogLine getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogLine();
    return _defaultInstance;
  }
  static LogLine _defaultInstance;
  static void $checkItem(LogLine v) {
    if (v is !LogLine) checkItemFailed(v, 'LogLine');
  }

  google$protobuf.Timestamp get time => $_get(0, 1, null);
  void set time(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasTime() => $_has(0, 1);
  void clearTime() => clearField(1);

  google$logging$type.LogSeverity get severity => $_get(1, 2, null);
  void set severity(google$logging$type.LogSeverity v) { setField(2, v); }
  bool hasSeverity() => $_has(1, 2);
  void clearSeverity() => clearField(2);

  String get logMessage => $_get(2, 3, '');
  void set logMessage(String v) { $_setString(2, 3, v); }
  bool hasLogMessage() => $_has(2, 3);
  void clearLogMessage() => clearField(3);

  SourceLocation get sourceLocation => $_get(3, 4, null);
  void set sourceLocation(SourceLocation v) { setField(4, v); }
  bool hasSourceLocation() => $_has(3, 4);
  void clearSourceLocation() => clearField(4);
}

class _ReadonlyLogLine extends LogLine with ReadonlyMessageMixin {}

class SourceLocation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceLocation')
    ..a/*<String>*/(1, 'file', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'line', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(3, 'functionName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SourceLocation() : super();
  SourceLocation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceLocation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceLocation clone() => new SourceLocation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceLocation create() => new SourceLocation();
  static PbList<SourceLocation> createRepeated() => new PbList<SourceLocation>();
  static SourceLocation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceLocation();
    return _defaultInstance;
  }
  static SourceLocation _defaultInstance;
  static void $checkItem(SourceLocation v) {
    if (v is !SourceLocation) checkItemFailed(v, 'SourceLocation');
  }

  String get file => $_get(0, 1, '');
  void set file(String v) { $_setString(0, 1, v); }
  bool hasFile() => $_has(0, 1);
  void clearFile() => clearField(1);

  Int64 get line => $_get(1, 2, null);
  void set line(Int64 v) { $_setInt64(1, 2, v); }
  bool hasLine() => $_has(1, 2);
  void clearLine() => clearField(2);

  String get functionName => $_get(2, 3, '');
  void set functionName(String v) { $_setString(2, 3, v); }
  bool hasFunctionName() => $_has(2, 3);
  void clearFunctionName() => clearField(3);
}

class _ReadonlySourceLocation extends SourceLocation with ReadonlyMessageMixin {}

class SourceReference extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceReference')
    ..a/*<String>*/(1, 'repository', PbFieldType.OS)
    ..a/*<String>*/(2, 'revisionId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SourceReference() : super();
  SourceReference.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceReference.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceReference clone() => new SourceReference()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceReference create() => new SourceReference();
  static PbList<SourceReference> createRepeated() => new PbList<SourceReference>();
  static SourceReference getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceReference();
    return _defaultInstance;
  }
  static SourceReference _defaultInstance;
  static void $checkItem(SourceReference v) {
    if (v is !SourceReference) checkItemFailed(v, 'SourceReference');
  }

  String get repository => $_get(0, 1, '');
  void set repository(String v) { $_setString(0, 1, v); }
  bool hasRepository() => $_has(0, 1);
  void clearRepository() => clearField(1);

  String get revisionId => $_get(1, 2, '');
  void set revisionId(String v) { $_setString(1, 2, v); }
  bool hasRevisionId() => $_has(1, 2);
  void clearRevisionId() => clearField(2);
}

class _ReadonlySourceReference extends SourceReference with ReadonlyMessageMixin {}

class RequestLog extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RequestLog')
    ..a/*<String>*/(1, 'appId', PbFieldType.OS)
    ..a/*<String>*/(2, 'versionId', PbFieldType.OS)
    ..a/*<String>*/(3, 'requestId', PbFieldType.OS)
    ..a/*<String>*/(4, 'ip', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(6, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(7, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Duration>*/(8, 'latency', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<Int64>*/(9, 'megaCycles', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(10, 'method', PbFieldType.OS)
    ..a/*<String>*/(11, 'resource', PbFieldType.OS)
    ..a/*<String>*/(12, 'httpVersion', PbFieldType.OS)
    ..a/*<int>*/(13, 'status', PbFieldType.O3)
    ..a/*<Int64>*/(14, 'responseSize', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(15, 'referrer', PbFieldType.OS)
    ..a/*<String>*/(16, 'userAgent', PbFieldType.OS)
    ..a/*<String>*/(17, 'urlMapEntry', PbFieldType.OS)
    ..a/*<String>*/(20, 'host', PbFieldType.OS)
    ..a/*<double>*/(21, 'cost', PbFieldType.OD)
    ..a/*<String>*/(22, 'taskQueueName', PbFieldType.OS)
    ..a/*<String>*/(23, 'taskName', PbFieldType.OS)
    ..a/*<bool>*/(24, 'wasLoadingRequest', PbFieldType.OB)
    ..a/*<google$protobuf.Duration>*/(25, 'pendingTime', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<int>*/(26, 'instanceIndex', PbFieldType.O3)
    ..a/*<bool>*/(27, 'finished', PbFieldType.OB)
    ..a/*<String>*/(28, 'instanceId', PbFieldType.OS)
    ..pp/*<LogLine>*/(29, 'line', PbFieldType.PM, LogLine.$checkItem, LogLine.create)
    ..a/*<String>*/(37, 'moduleId', PbFieldType.OS)
    ..a/*<String>*/(38, 'appEngineRelease', PbFieldType.OS)
    ..a/*<String>*/(39, 'traceId', PbFieldType.OS)
    ..a/*<String>*/(40, 'nickname', PbFieldType.OS)
    ..pp/*<SourceReference>*/(41, 'sourceReference', PbFieldType.PM, SourceReference.$checkItem, SourceReference.create)
    ..a/*<bool>*/(42, 'first', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  RequestLog() : super();
  RequestLog.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RequestLog.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RequestLog clone() => new RequestLog()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RequestLog create() => new RequestLog();
  static PbList<RequestLog> createRepeated() => new PbList<RequestLog>();
  static RequestLog getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRequestLog();
    return _defaultInstance;
  }
  static RequestLog _defaultInstance;
  static void $checkItem(RequestLog v) {
    if (v is !RequestLog) checkItemFailed(v, 'RequestLog');
  }

  String get appId => $_get(0, 1, '');
  void set appId(String v) { $_setString(0, 1, v); }
  bool hasAppId() => $_has(0, 1);
  void clearAppId() => clearField(1);

  String get versionId => $_get(1, 2, '');
  void set versionId(String v) { $_setString(1, 2, v); }
  bool hasVersionId() => $_has(1, 2);
  void clearVersionId() => clearField(2);

  String get requestId => $_get(2, 3, '');
  void set requestId(String v) { $_setString(2, 3, v); }
  bool hasRequestId() => $_has(2, 3);
  void clearRequestId() => clearField(3);

  String get ip => $_get(3, 4, '');
  void set ip(String v) { $_setString(3, 4, v); }
  bool hasIp() => $_has(3, 4);
  void clearIp() => clearField(4);

  google$protobuf.Timestamp get startTime => $_get(4, 6, null);
  void set startTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasStartTime() => $_has(4, 6);
  void clearStartTime() => clearField(6);

  google$protobuf.Timestamp get endTime => $_get(5, 7, null);
  void set endTime(google$protobuf.Timestamp v) { setField(7, v); }
  bool hasEndTime() => $_has(5, 7);
  void clearEndTime() => clearField(7);

  google$protobuf.Duration get latency => $_get(6, 8, null);
  void set latency(google$protobuf.Duration v) { setField(8, v); }
  bool hasLatency() => $_has(6, 8);
  void clearLatency() => clearField(8);

  Int64 get megaCycles => $_get(7, 9, null);
  void set megaCycles(Int64 v) { $_setInt64(7, 9, v); }
  bool hasMegaCycles() => $_has(7, 9);
  void clearMegaCycles() => clearField(9);

  String get method => $_get(8, 10, '');
  void set method(String v) { $_setString(8, 10, v); }
  bool hasMethod() => $_has(8, 10);
  void clearMethod() => clearField(10);

  String get resource => $_get(9, 11, '');
  void set resource(String v) { $_setString(9, 11, v); }
  bool hasResource() => $_has(9, 11);
  void clearResource() => clearField(11);

  String get httpVersion => $_get(10, 12, '');
  void set httpVersion(String v) { $_setString(10, 12, v); }
  bool hasHttpVersion() => $_has(10, 12);
  void clearHttpVersion() => clearField(12);

  int get status => $_get(11, 13, 0);
  void set status(int v) { $_setUnsignedInt32(11, 13, v); }
  bool hasStatus() => $_has(11, 13);
  void clearStatus() => clearField(13);

  Int64 get responseSize => $_get(12, 14, null);
  void set responseSize(Int64 v) { $_setInt64(12, 14, v); }
  bool hasResponseSize() => $_has(12, 14);
  void clearResponseSize() => clearField(14);

  String get referrer => $_get(13, 15, '');
  void set referrer(String v) { $_setString(13, 15, v); }
  bool hasReferrer() => $_has(13, 15);
  void clearReferrer() => clearField(15);

  String get userAgent => $_get(14, 16, '');
  void set userAgent(String v) { $_setString(14, 16, v); }
  bool hasUserAgent() => $_has(14, 16);
  void clearUserAgent() => clearField(16);

  String get urlMapEntry => $_get(15, 17, '');
  void set urlMapEntry(String v) { $_setString(15, 17, v); }
  bool hasUrlMapEntry() => $_has(15, 17);
  void clearUrlMapEntry() => clearField(17);

  String get host => $_get(16, 20, '');
  void set host(String v) { $_setString(16, 20, v); }
  bool hasHost() => $_has(16, 20);
  void clearHost() => clearField(20);

  double get cost => $_get(17, 21, null);
  void set cost(double v) { $_setDouble(17, 21, v); }
  bool hasCost() => $_has(17, 21);
  void clearCost() => clearField(21);

  String get taskQueueName => $_get(18, 22, '');
  void set taskQueueName(String v) { $_setString(18, 22, v); }
  bool hasTaskQueueName() => $_has(18, 22);
  void clearTaskQueueName() => clearField(22);

  String get taskName => $_get(19, 23, '');
  void set taskName(String v) { $_setString(19, 23, v); }
  bool hasTaskName() => $_has(19, 23);
  void clearTaskName() => clearField(23);

  bool get wasLoadingRequest => $_get(20, 24, false);
  void set wasLoadingRequest(bool v) { $_setBool(20, 24, v); }
  bool hasWasLoadingRequest() => $_has(20, 24);
  void clearWasLoadingRequest() => clearField(24);

  google$protobuf.Duration get pendingTime => $_get(21, 25, null);
  void set pendingTime(google$protobuf.Duration v) { setField(25, v); }
  bool hasPendingTime() => $_has(21, 25);
  void clearPendingTime() => clearField(25);

  int get instanceIndex => $_get(22, 26, 0);
  void set instanceIndex(int v) { $_setUnsignedInt32(22, 26, v); }
  bool hasInstanceIndex() => $_has(22, 26);
  void clearInstanceIndex() => clearField(26);

  bool get finished => $_get(23, 27, false);
  void set finished(bool v) { $_setBool(23, 27, v); }
  bool hasFinished() => $_has(23, 27);
  void clearFinished() => clearField(27);

  String get instanceId => $_get(24, 28, '');
  void set instanceId(String v) { $_setString(24, 28, v); }
  bool hasInstanceId() => $_has(24, 28);
  void clearInstanceId() => clearField(28);

  List<LogLine> get line => $_get(25, 29, null);

  String get moduleId => $_get(26, 37, '');
  void set moduleId(String v) { $_setString(26, 37, v); }
  bool hasModuleId() => $_has(26, 37);
  void clearModuleId() => clearField(37);

  String get appEngineRelease => $_get(27, 38, '');
  void set appEngineRelease(String v) { $_setString(27, 38, v); }
  bool hasAppEngineRelease() => $_has(27, 38);
  void clearAppEngineRelease() => clearField(38);

  String get traceId => $_get(28, 39, '');
  void set traceId(String v) { $_setString(28, 39, v); }
  bool hasTraceId() => $_has(28, 39);
  void clearTraceId() => clearField(39);

  String get nickname => $_get(29, 40, '');
  void set nickname(String v) { $_setString(29, 40, v); }
  bool hasNickname() => $_has(29, 40);
  void clearNickname() => clearField(40);

  List<SourceReference> get sourceReference => $_get(30, 41, null);

  bool get first => $_get(31, 42, false);
  void set first(bool v) { $_setBool(31, 42, v); }
  bool hasFirst() => $_has(31, 42);
  void clearFirst() => clearField(42);
}

class _ReadonlyRequestLog extends RequestLog with ReadonlyMessageMixin {}

