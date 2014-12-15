///
//  Generated code. Do not modify.
///
library appengine.log;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class LogServiceError_ErrorCode extends ProtobufEnum {
  static const LogServiceError_ErrorCode OK = const LogServiceError_ErrorCode._(0, 'OK');
  static const LogServiceError_ErrorCode INVALID_REQUEST = const LogServiceError_ErrorCode._(1, 'INVALID_REQUEST');
  static const LogServiceError_ErrorCode STORAGE_ERROR = const LogServiceError_ErrorCode._(2, 'STORAGE_ERROR');

  static const List<LogServiceError_ErrorCode> values = const <LogServiceError_ErrorCode> [
    OK,
    INVALID_REQUEST,
    STORAGE_ERROR,
  ];

  static final Map<int, LogServiceError_ErrorCode> _byValue = ProtobufEnum.initByValue(values);
  static LogServiceError_ErrorCode valueOf(int value) => _byValue[value];

  const LogServiceError_ErrorCode._(int v, String n) : super(v, n);
}

class LogServiceError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogServiceError')
    ..hasRequiredFields = false
  ;

  LogServiceError() : super();
  LogServiceError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogServiceError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogServiceError clone() => new LogServiceError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

class UserAppLogLine extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UserAppLogLine')
    ..a(1, 'timestampUsec', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(2, 'level', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(3, 'message', GeneratedMessage.QS)
  ;

  UserAppLogLine() : super();
  UserAppLogLine.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UserAppLogLine.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UserAppLogLine clone() => new UserAppLogLine()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get timestampUsec => getField(1);
  void set timestampUsec(Int64 v) { setField(1, v); }
  bool hasTimestampUsec() => hasField(1);
  void clearTimestampUsec() => clearField(1);

  Int64 get level => getField(2);
  void set level(Int64 v) { setField(2, v); }
  bool hasLevel() => hasField(2);
  void clearLevel() => clearField(2);

  String get message => getField(3);
  void set message(String v) { setField(3, v); }
  bool hasMessage() => hasField(3);
  void clearMessage() => clearField(3);
}

class UserAppLogGroup extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UserAppLogGroup')
    ..m(2, 'logLine', () => new UserAppLogLine(), () => new PbList<UserAppLogLine>())
  ;

  UserAppLogGroup() : super();
  UserAppLogGroup.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UserAppLogGroup.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UserAppLogGroup clone() => new UserAppLogGroup()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<UserAppLogLine> get logLine => getField(2);
}

class FlushRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('FlushRequest')
    ..a(1, 'logs', GeneratedMessage.OY)
    ..hasRequiredFields = false
  ;

  FlushRequest() : super();
  FlushRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FlushRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FlushRequest clone() => new FlushRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get logs => getField(1);
  void set logs(List<int> v) { setField(1, v); }
  bool hasLogs() => hasField(1);
  void clearLogs() => clearField(1);
}

class SetStatusRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetStatusRequest')
    ..a(1, 'status', GeneratedMessage.QS)
  ;

  SetStatusRequest() : super();
  SetStatusRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetStatusRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetStatusRequest clone() => new SetStatusRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get status => getField(1);
  void set status(String v) { setField(1, v); }
  bool hasStatus() => hasField(1);
  void clearStatus() => clearField(1);
}

class LogOffset extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogOffset')
    ..a(1, 'requestId', GeneratedMessage.OY)
    ..hasRequiredFields = false
  ;

  LogOffset() : super();
  LogOffset.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogOffset.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogOffset clone() => new LogOffset()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get requestId => getField(1);
  void set requestId(List<int> v) { setField(1, v); }
  bool hasRequestId() => hasField(1);
  void clearRequestId() => clearField(1);
}

class LogLine extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogLine')
    ..a(1, 'time', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(2, 'level', GeneratedMessage.Q3)
    ..a(3, 'logMessage', GeneratedMessage.QS)
  ;

  LogLine() : super();
  LogLine.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogLine.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogLine clone() => new LogLine()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get time => getField(1);
  void set time(Int64 v) { setField(1, v); }
  bool hasTime() => hasField(1);
  void clearTime() => clearField(1);

  int get level => getField(2);
  void set level(int v) { setField(2, v); }
  bool hasLevel() => hasField(2);
  void clearLevel() => clearField(2);

  String get logMessage => getField(3);
  void set logMessage(String v) { setField(3, v); }
  bool hasLogMessage() => hasField(3);
  void clearLogMessage() => clearField(3);
}

class RequestLog extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RequestLog')
    ..a(1, 'appId', GeneratedMessage.QS)
    ..a(37, 'moduleId', GeneratedMessage.OS, () => 'default')
    ..a(2, 'versionId', GeneratedMessage.QS)
    ..a(3, 'requestId', GeneratedMessage.QY)
    ..a(35, 'offset', GeneratedMessage.OM, () => new LogOffset(), () => new LogOffset())
    ..a(4, 'ip', GeneratedMessage.QS)
    ..a(5, 'nickname', GeneratedMessage.OS)
    ..a(6, 'startTime', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(7, 'endTime', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(8, 'latency', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(9, 'mcycles', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(10, 'method', GeneratedMessage.QS)
    ..a(11, 'resource', GeneratedMessage.QS)
    ..a(12, 'httpVersion', GeneratedMessage.QS)
    ..a(13, 'status', GeneratedMessage.Q3)
    ..a(14, 'responseSize', GeneratedMessage.Q6, () => makeLongInt(0))
    ..a(15, 'referrer', GeneratedMessage.OS)
    ..a(16, 'userAgent', GeneratedMessage.OS)
    ..a(17, 'urlMapEntry', GeneratedMessage.QS)
    ..a(18, 'combined', GeneratedMessage.QS)
    ..a(19, 'apiMcycles', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(20, 'host', GeneratedMessage.OS)
    ..a(21, 'cost', GeneratedMessage.OD)
    ..a(22, 'taskQueueName', GeneratedMessage.OS)
    ..a(23, 'taskName', GeneratedMessage.OS)
    ..a(24, 'wasLoadingRequest', GeneratedMessage.OB)
    ..a(25, 'pendingTime', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(26, 'replicaIndex', GeneratedMessage.O3, () => -1)
    ..a(27, 'finished', GeneratedMessage.OB, () => true)
    ..a(28, 'cloneKey', GeneratedMessage.OY)
    ..m(29, 'line', () => new LogLine(), () => new PbList<LogLine>())
    ..a(36, 'linesIncomplete', GeneratedMessage.OB)
    ..a(38, 'appEngineRelease', GeneratedMessage.OY)
    ..a(30, 'exitReason', GeneratedMessage.O3)
    ..a(31, 'wasThrottledForTime', GeneratedMessage.OB)
    ..a(32, 'wasThrottledForRequests', GeneratedMessage.OB)
    ..a(33, 'throttledTime', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(34, 'serverName', GeneratedMessage.OY)
  ;

  RequestLog() : super();
  RequestLog.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RequestLog.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RequestLog clone() => new RequestLog()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get appId => getField(1);
  void set appId(String v) { setField(1, v); }
  bool hasAppId() => hasField(1);
  void clearAppId() => clearField(1);

  String get moduleId => getField(37);
  void set moduleId(String v) { setField(37, v); }
  bool hasModuleId() => hasField(37);
  void clearModuleId() => clearField(37);

  String get versionId => getField(2);
  void set versionId(String v) { setField(2, v); }
  bool hasVersionId() => hasField(2);
  void clearVersionId() => clearField(2);

  List<int> get requestId => getField(3);
  void set requestId(List<int> v) { setField(3, v); }
  bool hasRequestId() => hasField(3);
  void clearRequestId() => clearField(3);

  LogOffset get offset => getField(35);
  void set offset(LogOffset v) { setField(35, v); }
  bool hasOffset() => hasField(35);
  void clearOffset() => clearField(35);

  String get ip => getField(4);
  void set ip(String v) { setField(4, v); }
  bool hasIp() => hasField(4);
  void clearIp() => clearField(4);

  String get nickname => getField(5);
  void set nickname(String v) { setField(5, v); }
  bool hasNickname() => hasField(5);
  void clearNickname() => clearField(5);

  Int64 get startTime => getField(6);
  void set startTime(Int64 v) { setField(6, v); }
  bool hasStartTime() => hasField(6);
  void clearStartTime() => clearField(6);

  Int64 get endTime => getField(7);
  void set endTime(Int64 v) { setField(7, v); }
  bool hasEndTime() => hasField(7);
  void clearEndTime() => clearField(7);

  Int64 get latency => getField(8);
  void set latency(Int64 v) { setField(8, v); }
  bool hasLatency() => hasField(8);
  void clearLatency() => clearField(8);

  Int64 get mcycles => getField(9);
  void set mcycles(Int64 v) { setField(9, v); }
  bool hasMcycles() => hasField(9);
  void clearMcycles() => clearField(9);

  String get method => getField(10);
  void set method(String v) { setField(10, v); }
  bool hasMethod() => hasField(10);
  void clearMethod() => clearField(10);

  String get resource => getField(11);
  void set resource(String v) { setField(11, v); }
  bool hasResource() => hasField(11);
  void clearResource() => clearField(11);

  String get httpVersion => getField(12);
  void set httpVersion(String v) { setField(12, v); }
  bool hasHttpVersion() => hasField(12);
  void clearHttpVersion() => clearField(12);

  int get status => getField(13);
  void set status(int v) { setField(13, v); }
  bool hasStatus() => hasField(13);
  void clearStatus() => clearField(13);

  Int64 get responseSize => getField(14);
  void set responseSize(Int64 v) { setField(14, v); }
  bool hasResponseSize() => hasField(14);
  void clearResponseSize() => clearField(14);

  String get referrer => getField(15);
  void set referrer(String v) { setField(15, v); }
  bool hasReferrer() => hasField(15);
  void clearReferrer() => clearField(15);

  String get userAgent => getField(16);
  void set userAgent(String v) { setField(16, v); }
  bool hasUserAgent() => hasField(16);
  void clearUserAgent() => clearField(16);

  String get urlMapEntry => getField(17);
  void set urlMapEntry(String v) { setField(17, v); }
  bool hasUrlMapEntry() => hasField(17);
  void clearUrlMapEntry() => clearField(17);

  String get combined => getField(18);
  void set combined(String v) { setField(18, v); }
  bool hasCombined() => hasField(18);
  void clearCombined() => clearField(18);

  Int64 get apiMcycles => getField(19);
  void set apiMcycles(Int64 v) { setField(19, v); }
  bool hasApiMcycles() => hasField(19);
  void clearApiMcycles() => clearField(19);

  String get host => getField(20);
  void set host(String v) { setField(20, v); }
  bool hasHost() => hasField(20);
  void clearHost() => clearField(20);

  double get cost => getField(21);
  void set cost(double v) { setField(21, v); }
  bool hasCost() => hasField(21);
  void clearCost() => clearField(21);

  String get taskQueueName => getField(22);
  void set taskQueueName(String v) { setField(22, v); }
  bool hasTaskQueueName() => hasField(22);
  void clearTaskQueueName() => clearField(22);

  String get taskName => getField(23);
  void set taskName(String v) { setField(23, v); }
  bool hasTaskName() => hasField(23);
  void clearTaskName() => clearField(23);

  bool get wasLoadingRequest => getField(24);
  void set wasLoadingRequest(bool v) { setField(24, v); }
  bool hasWasLoadingRequest() => hasField(24);
  void clearWasLoadingRequest() => clearField(24);

  Int64 get pendingTime => getField(25);
  void set pendingTime(Int64 v) { setField(25, v); }
  bool hasPendingTime() => hasField(25);
  void clearPendingTime() => clearField(25);

  int get replicaIndex => getField(26);
  void set replicaIndex(int v) { setField(26, v); }
  bool hasReplicaIndex() => hasField(26);
  void clearReplicaIndex() => clearField(26);

  bool get finished => getField(27);
  void set finished(bool v) { setField(27, v); }
  bool hasFinished() => hasField(27);
  void clearFinished() => clearField(27);

  List<int> get cloneKey => getField(28);
  void set cloneKey(List<int> v) { setField(28, v); }
  bool hasCloneKey() => hasField(28);
  void clearCloneKey() => clearField(28);

  List<LogLine> get line => getField(29);

  bool get linesIncomplete => getField(36);
  void set linesIncomplete(bool v) { setField(36, v); }
  bool hasLinesIncomplete() => hasField(36);
  void clearLinesIncomplete() => clearField(36);

  List<int> get appEngineRelease => getField(38);
  void set appEngineRelease(List<int> v) { setField(38, v); }
  bool hasAppEngineRelease() => hasField(38);
  void clearAppEngineRelease() => clearField(38);

  int get exitReason => getField(30);
  void set exitReason(int v) { setField(30, v); }
  bool hasExitReason() => hasField(30);
  void clearExitReason() => clearField(30);

  bool get wasThrottledForTime => getField(31);
  void set wasThrottledForTime(bool v) { setField(31, v); }
  bool hasWasThrottledForTime() => hasField(31);
  void clearWasThrottledForTime() => clearField(31);

  bool get wasThrottledForRequests => getField(32);
  void set wasThrottledForRequests(bool v) { setField(32, v); }
  bool hasWasThrottledForRequests() => hasField(32);
  void clearWasThrottledForRequests() => clearField(32);

  Int64 get throttledTime => getField(33);
  void set throttledTime(Int64 v) { setField(33, v); }
  bool hasThrottledTime() => hasField(33);
  void clearThrottledTime() => clearField(33);

  List<int> get serverName => getField(34);
  void set serverName(List<int> v) { setField(34, v); }
  bool hasServerName() => hasField(34);
  void clearServerName() => clearField(34);
}

class LogModuleVersion extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogModuleVersion')
    ..a(1, 'moduleId', GeneratedMessage.OS, () => 'default')
    ..a(2, 'versionId', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  LogModuleVersion() : super();
  LogModuleVersion.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogModuleVersion.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogModuleVersion clone() => new LogModuleVersion()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get moduleId => getField(1);
  void set moduleId(String v) { setField(1, v); }
  bool hasModuleId() => hasField(1);
  void clearModuleId() => clearField(1);

  String get versionId => getField(2);
  void set versionId(String v) { setField(2, v); }
  bool hasVersionId() => hasField(2);
  void clearVersionId() => clearField(2);
}

class LogReadRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogReadRequest')
    ..a(1, 'appId', GeneratedMessage.QS)
    ..p(2, 'versionId', GeneratedMessage.PS)
    ..m(19, 'moduleVersion', () => new LogModuleVersion(), () => new PbList<LogModuleVersion>())
    ..a(3, 'startTime', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(4, 'endTime', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(5, 'offset', GeneratedMessage.OM, () => new LogOffset(), () => new LogOffset())
    ..p(6, 'requestId', GeneratedMessage.PY)
    ..a(7, 'minimumLogLevel', GeneratedMessage.O3)
    ..a(8, 'includeIncomplete', GeneratedMessage.OB)
    ..a(9, 'count', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(14, 'combinedLogRegex', GeneratedMessage.OS)
    ..a(15, 'hostRegex', GeneratedMessage.OS)
    ..a(16, 'replicaIndex', GeneratedMessage.O3)
    ..a(10, 'includeAppLogs', GeneratedMessage.OB)
    ..a(17, 'appLogsPerRequest', GeneratedMessage.O3)
    ..a(11, 'includeHost', GeneratedMessage.OB)
    ..a(12, 'includeAll', GeneratedMessage.OB)
    ..a(13, 'cacheIterator', GeneratedMessage.OB)
    ..a(18, 'numShards', GeneratedMessage.O3)
  ;

  LogReadRequest() : super();
  LogReadRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogReadRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogReadRequest clone() => new LogReadRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get appId => getField(1);
  void set appId(String v) { setField(1, v); }
  bool hasAppId() => hasField(1);
  void clearAppId() => clearField(1);

  List<String> get versionId => getField(2);

  List<LogModuleVersion> get moduleVersion => getField(19);

  Int64 get startTime => getField(3);
  void set startTime(Int64 v) { setField(3, v); }
  bool hasStartTime() => hasField(3);
  void clearStartTime() => clearField(3);

  Int64 get endTime => getField(4);
  void set endTime(Int64 v) { setField(4, v); }
  bool hasEndTime() => hasField(4);
  void clearEndTime() => clearField(4);

  LogOffset get offset => getField(5);
  void set offset(LogOffset v) { setField(5, v); }
  bool hasOffset() => hasField(5);
  void clearOffset() => clearField(5);

  List<List<int>> get requestId => getField(6);

  int get minimumLogLevel => getField(7);
  void set minimumLogLevel(int v) { setField(7, v); }
  bool hasMinimumLogLevel() => hasField(7);
  void clearMinimumLogLevel() => clearField(7);

  bool get includeIncomplete => getField(8);
  void set includeIncomplete(bool v) { setField(8, v); }
  bool hasIncludeIncomplete() => hasField(8);
  void clearIncludeIncomplete() => clearField(8);

  Int64 get count => getField(9);
  void set count(Int64 v) { setField(9, v); }
  bool hasCount() => hasField(9);
  void clearCount() => clearField(9);

  String get combinedLogRegex => getField(14);
  void set combinedLogRegex(String v) { setField(14, v); }
  bool hasCombinedLogRegex() => hasField(14);
  void clearCombinedLogRegex() => clearField(14);

  String get hostRegex => getField(15);
  void set hostRegex(String v) { setField(15, v); }
  bool hasHostRegex() => hasField(15);
  void clearHostRegex() => clearField(15);

  int get replicaIndex => getField(16);
  void set replicaIndex(int v) { setField(16, v); }
  bool hasReplicaIndex() => hasField(16);
  void clearReplicaIndex() => clearField(16);

  bool get includeAppLogs => getField(10);
  void set includeAppLogs(bool v) { setField(10, v); }
  bool hasIncludeAppLogs() => hasField(10);
  void clearIncludeAppLogs() => clearField(10);

  int get appLogsPerRequest => getField(17);
  void set appLogsPerRequest(int v) { setField(17, v); }
  bool hasAppLogsPerRequest() => hasField(17);
  void clearAppLogsPerRequest() => clearField(17);

  bool get includeHost => getField(11);
  void set includeHost(bool v) { setField(11, v); }
  bool hasIncludeHost() => hasField(11);
  void clearIncludeHost() => clearField(11);

  bool get includeAll => getField(12);
  void set includeAll(bool v) { setField(12, v); }
  bool hasIncludeAll() => hasField(12);
  void clearIncludeAll() => clearField(12);

  bool get cacheIterator => getField(13);
  void set cacheIterator(bool v) { setField(13, v); }
  bool hasCacheIterator() => hasField(13);
  void clearCacheIterator() => clearField(13);

  int get numShards => getField(18);
  void set numShards(int v) { setField(18, v); }
  bool hasNumShards() => hasField(18);
  void clearNumShards() => clearField(18);
}

class LogReadResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogReadResponse')
    ..m(1, 'log', () => new RequestLog(), () => new PbList<RequestLog>())
    ..a(2, 'offset', GeneratedMessage.OM, () => new LogOffset(), () => new LogOffset())
    ..a(3, 'lastEndTime', GeneratedMessage.O6, () => makeLongInt(0))
  ;

  LogReadResponse() : super();
  LogReadResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogReadResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogReadResponse clone() => new LogReadResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<RequestLog> get log => getField(1);

  LogOffset get offset => getField(2);
  void set offset(LogOffset v) { setField(2, v); }
  bool hasOffset() => hasField(2);
  void clearOffset() => clearField(2);

  Int64 get lastEndTime => getField(3);
  void set lastEndTime(Int64 v) { setField(3, v); }
  bool hasLastEndTime() => hasField(3);
  void clearLastEndTime() => clearField(3);
}

class LogUsageRecord extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogUsageRecord')
    ..a(1, 'versionId', GeneratedMessage.OS)
    ..a(2, 'startTime', GeneratedMessage.O3)
    ..a(3, 'endTime', GeneratedMessage.O3)
    ..a(4, 'count', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(5, 'totalSize', GeneratedMessage.O6, () => makeLongInt(0))
    ..a(6, 'records', GeneratedMessage.O3)
    ..hasRequiredFields = false
  ;

  LogUsageRecord() : super();
  LogUsageRecord.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogUsageRecord.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogUsageRecord clone() => new LogUsageRecord()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get versionId => getField(1);
  void set versionId(String v) { setField(1, v); }
  bool hasVersionId() => hasField(1);
  void clearVersionId() => clearField(1);

  int get startTime => getField(2);
  void set startTime(int v) { setField(2, v); }
  bool hasStartTime() => hasField(2);
  void clearStartTime() => clearField(2);

  int get endTime => getField(3);
  void set endTime(int v) { setField(3, v); }
  bool hasEndTime() => hasField(3);
  void clearEndTime() => clearField(3);

  Int64 get count => getField(4);
  void set count(Int64 v) { setField(4, v); }
  bool hasCount() => hasField(4);
  void clearCount() => clearField(4);

  Int64 get totalSize => getField(5);
  void set totalSize(Int64 v) { setField(5, v); }
  bool hasTotalSize() => hasField(5);
  void clearTotalSize() => clearField(5);

  int get records => getField(6);
  void set records(int v) { setField(6, v); }
  bool hasRecords() => hasField(6);
  void clearRecords() => clearField(6);
}

class LogUsageRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogUsageRequest')
    ..a(1, 'appId', GeneratedMessage.QS)
    ..p(2, 'versionId', GeneratedMessage.PS)
    ..a(3, 'startTime', GeneratedMessage.O3)
    ..a(4, 'endTime', GeneratedMessage.O3)
    ..a(5, 'resolutionHours', GeneratedMessage.OU3, () => 1)
    ..a(6, 'combineVersions', GeneratedMessage.OB)
    ..a(7, 'usageVersion', GeneratedMessage.O3)
    ..a(8, 'versionsOnly', GeneratedMessage.OB)
  ;

  LogUsageRequest() : super();
  LogUsageRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogUsageRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogUsageRequest clone() => new LogUsageRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get appId => getField(1);
  void set appId(String v) { setField(1, v); }
  bool hasAppId() => hasField(1);
  void clearAppId() => clearField(1);

  List<String> get versionId => getField(2);

  int get startTime => getField(3);
  void set startTime(int v) { setField(3, v); }
  bool hasStartTime() => hasField(3);
  void clearStartTime() => clearField(3);

  int get endTime => getField(4);
  void set endTime(int v) { setField(4, v); }
  bool hasEndTime() => hasField(4);
  void clearEndTime() => clearField(4);

  int get resolutionHours => getField(5);
  void set resolutionHours(int v) { setField(5, v); }
  bool hasResolutionHours() => hasField(5);
  void clearResolutionHours() => clearField(5);

  bool get combineVersions => getField(6);
  void set combineVersions(bool v) { setField(6, v); }
  bool hasCombineVersions() => hasField(6);
  void clearCombineVersions() => clearField(6);

  int get usageVersion => getField(7);
  void set usageVersion(int v) { setField(7, v); }
  bool hasUsageVersion() => hasField(7);
  void clearUsageVersion() => clearField(7);

  bool get versionsOnly => getField(8);
  void set versionsOnly(bool v) { setField(8, v); }
  bool hasVersionsOnly() => hasField(8);
  void clearVersionsOnly() => clearField(8);
}

class LogUsageResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogUsageResponse')
    ..m(1, 'usage', () => new LogUsageRecord(), () => new PbList<LogUsageRecord>())
    ..a(2, 'summary', GeneratedMessage.OM, () => new LogUsageRecord(), () => new LogUsageRecord())
    ..hasRequiredFields = false
  ;

  LogUsageResponse() : super();
  LogUsageResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogUsageResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogUsageResponse clone() => new LogUsageResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<LogUsageRecord> get usage => getField(1);

  LogUsageRecord get summary => getField(2);
  void set summary(LogUsageRecord v) { setField(2, v); }
  bool hasSummary() => hasField(2);
  void clearSummary() => clearField(2);
}

