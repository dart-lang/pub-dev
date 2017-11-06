///
//  Generated code. Do not modify.
///
library google.logging.v2_log_entry;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../protobuf/any.pb.dart' as google$protobuf;
import '../../protobuf/struct.pb.dart' as google$protobuf;
import '../type/http_request.pb.dart' as google$logging$type;
import '../../api/monitored_resource.pb.dart' as google$api;
import '../../protobuf/timestamp.pb.dart' as google$protobuf;

import '../type/log_severity.pbenum.dart' as google$logging$type;

class LogEntry_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogEntry_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LogEntry_LabelsEntry() : super();
  LogEntry_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogEntry_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogEntry_LabelsEntry clone() => new LogEntry_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntry_LabelsEntry create() => new LogEntry_LabelsEntry();
  static PbList<LogEntry_LabelsEntry> createRepeated() => new PbList<LogEntry_LabelsEntry>();
  static LogEntry_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogEntry_LabelsEntry();
    return _defaultInstance;
  }
  static LogEntry_LabelsEntry _defaultInstance;
  static void $checkItem(LogEntry_LabelsEntry v) {
    if (v is !LogEntry_LabelsEntry) checkItemFailed(v, 'LogEntry_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyLogEntry_LabelsEntry extends LogEntry_LabelsEntry with ReadonlyMessageMixin {}

class LogEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogEntry')
    ..a/*<google$protobuf.Any>*/(2, 'protoPayload', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..a/*<String>*/(3, 'textPayload', PbFieldType.OS)
    ..a/*<String>*/(4, 'insertId', PbFieldType.OS)
    ..a/*<google$protobuf.Struct>*/(6, 'jsonPayload', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..a/*<google$logging$type.HttpRequest>*/(7, 'httpRequest', PbFieldType.OM, google$logging$type.HttpRequest.getDefault, google$logging$type.HttpRequest.create)
    ..a/*<google$api.MonitoredResource>*/(8, 'resource', PbFieldType.OM, google$api.MonitoredResource.getDefault, google$api.MonitoredResource.create)
    ..a/*<google$protobuf.Timestamp>*/(9, 'timestamp', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<google$logging$type.LogSeverity>*/(10, 'severity', PbFieldType.OE, google$logging$type.LogSeverity.DEFAULT, google$logging$type.LogSeverity.valueOf)
    ..pp/*<LogEntry_LabelsEntry>*/(11, 'labels', PbFieldType.PM, LogEntry_LabelsEntry.$checkItem, LogEntry_LabelsEntry.create)
    ..a/*<String>*/(12, 'logName', PbFieldType.OS)
    ..a/*<LogEntryOperation>*/(15, 'operation', PbFieldType.OM, LogEntryOperation.getDefault, LogEntryOperation.create)
    ..a/*<String>*/(22, 'trace', PbFieldType.OS)
    ..a/*<LogEntrySourceLocation>*/(23, 'sourceLocation', PbFieldType.OM, LogEntrySourceLocation.getDefault, LogEntrySourceLocation.create)
    ..hasRequiredFields = false
  ;

  LogEntry() : super();
  LogEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogEntry clone() => new LogEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntry create() => new LogEntry();
  static PbList<LogEntry> createRepeated() => new PbList<LogEntry>();
  static LogEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogEntry();
    return _defaultInstance;
  }
  static LogEntry _defaultInstance;
  static void $checkItem(LogEntry v) {
    if (v is !LogEntry) checkItemFailed(v, 'LogEntry');
  }

  google$protobuf.Any get protoPayload => $_get(0, 2, null);
  void set protoPayload(google$protobuf.Any v) { setField(2, v); }
  bool hasProtoPayload() => $_has(0, 2);
  void clearProtoPayload() => clearField(2);

  String get textPayload => $_get(1, 3, '');
  void set textPayload(String v) { $_setString(1, 3, v); }
  bool hasTextPayload() => $_has(1, 3);
  void clearTextPayload() => clearField(3);

  String get insertId => $_get(2, 4, '');
  void set insertId(String v) { $_setString(2, 4, v); }
  bool hasInsertId() => $_has(2, 4);
  void clearInsertId() => clearField(4);

  google$protobuf.Struct get jsonPayload => $_get(3, 6, null);
  void set jsonPayload(google$protobuf.Struct v) { setField(6, v); }
  bool hasJsonPayload() => $_has(3, 6);
  void clearJsonPayload() => clearField(6);

  google$logging$type.HttpRequest get httpRequest => $_get(4, 7, null);
  void set httpRequest(google$logging$type.HttpRequest v) { setField(7, v); }
  bool hasHttpRequest() => $_has(4, 7);
  void clearHttpRequest() => clearField(7);

  google$api.MonitoredResource get resource => $_get(5, 8, null);
  void set resource(google$api.MonitoredResource v) { setField(8, v); }
  bool hasResource() => $_has(5, 8);
  void clearResource() => clearField(8);

  google$protobuf.Timestamp get timestamp => $_get(6, 9, null);
  void set timestamp(google$protobuf.Timestamp v) { setField(9, v); }
  bool hasTimestamp() => $_has(6, 9);
  void clearTimestamp() => clearField(9);

  google$logging$type.LogSeverity get severity => $_get(7, 10, null);
  void set severity(google$logging$type.LogSeverity v) { setField(10, v); }
  bool hasSeverity() => $_has(7, 10);
  void clearSeverity() => clearField(10);

  List<LogEntry_LabelsEntry> get labels => $_get(8, 11, null);

  String get logName => $_get(9, 12, '');
  void set logName(String v) { $_setString(9, 12, v); }
  bool hasLogName() => $_has(9, 12);
  void clearLogName() => clearField(12);

  LogEntryOperation get operation => $_get(10, 15, null);
  void set operation(LogEntryOperation v) { setField(15, v); }
  bool hasOperation() => $_has(10, 15);
  void clearOperation() => clearField(15);

  String get trace => $_get(11, 22, '');
  void set trace(String v) { $_setString(11, 22, v); }
  bool hasTrace() => $_has(11, 22);
  void clearTrace() => clearField(22);

  LogEntrySourceLocation get sourceLocation => $_get(12, 23, null);
  void set sourceLocation(LogEntrySourceLocation v) { setField(23, v); }
  bool hasSourceLocation() => $_has(12, 23);
  void clearSourceLocation() => clearField(23);
}

class _ReadonlyLogEntry extends LogEntry with ReadonlyMessageMixin {}

class LogEntryOperation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogEntryOperation')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'producer', PbFieldType.OS)
    ..a/*<bool>*/(3, 'first', PbFieldType.OB)
    ..a/*<bool>*/(4, 'last', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  LogEntryOperation() : super();
  LogEntryOperation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogEntryOperation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogEntryOperation clone() => new LogEntryOperation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntryOperation create() => new LogEntryOperation();
  static PbList<LogEntryOperation> createRepeated() => new PbList<LogEntryOperation>();
  static LogEntryOperation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogEntryOperation();
    return _defaultInstance;
  }
  static LogEntryOperation _defaultInstance;
  static void $checkItem(LogEntryOperation v) {
    if (v is !LogEntryOperation) checkItemFailed(v, 'LogEntryOperation');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get producer => $_get(1, 2, '');
  void set producer(String v) { $_setString(1, 2, v); }
  bool hasProducer() => $_has(1, 2);
  void clearProducer() => clearField(2);

  bool get first => $_get(2, 3, false);
  void set first(bool v) { $_setBool(2, 3, v); }
  bool hasFirst() => $_has(2, 3);
  void clearFirst() => clearField(3);

  bool get last => $_get(3, 4, false);
  void set last(bool v) { $_setBool(3, 4, v); }
  bool hasLast() => $_has(3, 4);
  void clearLast() => clearField(4);
}

class _ReadonlyLogEntryOperation extends LogEntryOperation with ReadonlyMessageMixin {}

class LogEntrySourceLocation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogEntrySourceLocation')
    ..a/*<String>*/(1, 'file', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'line', PbFieldType.O6, Int64.ZERO)
    ..a/*<String>*/(3, 'function', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LogEntrySourceLocation() : super();
  LogEntrySourceLocation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogEntrySourceLocation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogEntrySourceLocation clone() => new LogEntrySourceLocation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogEntrySourceLocation create() => new LogEntrySourceLocation();
  static PbList<LogEntrySourceLocation> createRepeated() => new PbList<LogEntrySourceLocation>();
  static LogEntrySourceLocation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogEntrySourceLocation();
    return _defaultInstance;
  }
  static LogEntrySourceLocation _defaultInstance;
  static void $checkItem(LogEntrySourceLocation v) {
    if (v is !LogEntrySourceLocation) checkItemFailed(v, 'LogEntrySourceLocation');
  }

  String get file => $_get(0, 1, '');
  void set file(String v) { $_setString(0, 1, v); }
  bool hasFile() => $_has(0, 1);
  void clearFile() => clearField(1);

  Int64 get line => $_get(1, 2, null);
  void set line(Int64 v) { $_setInt64(1, 2, v); }
  bool hasLine() => $_has(1, 2);
  void clearLine() => clearField(2);

  String get function => $_get(2, 3, '');
  void set function(String v) { $_setString(2, 3, v); }
  bool hasFunction() => $_has(2, 3);
  void clearFunction() => clearField(3);
}

class _ReadonlyLogEntrySourceLocation extends LogEntrySourceLocation with ReadonlyMessageMixin {}

