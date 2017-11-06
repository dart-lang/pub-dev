///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_log_entry;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/any.pb.dart' as google$protobuf;
import '../../../protobuf/struct.pb.dart' as google$protobuf;
import '../../../protobuf/timestamp.pb.dart' as google$protobuf;

import '../../../logging/type/log_severity.pbenum.dart' as google$logging$type;

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
    ..a/*<google$protobuf.Struct>*/(6, 'structPayload', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..a/*<String>*/(10, 'name', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(11, 'timestamp', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<google$logging$type.LogSeverity>*/(12, 'severity', PbFieldType.OE, google$logging$type.LogSeverity.DEFAULT, google$logging$type.LogSeverity.valueOf)
    ..pp/*<LogEntry_LabelsEntry>*/(13, 'labels', PbFieldType.PM, LogEntry_LabelsEntry.$checkItem, LogEntry_LabelsEntry.create)
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

  google$protobuf.Struct get structPayload => $_get(3, 6, null);
  void set structPayload(google$protobuf.Struct v) { setField(6, v); }
  bool hasStructPayload() => $_has(3, 6);
  void clearStructPayload() => clearField(6);

  String get name => $_get(4, 10, '');
  void set name(String v) { $_setString(4, 10, v); }
  bool hasName() => $_has(4, 10);
  void clearName() => clearField(10);

  google$protobuf.Timestamp get timestamp => $_get(5, 11, null);
  void set timestamp(google$protobuf.Timestamp v) { setField(11, v); }
  bool hasTimestamp() => $_has(5, 11);
  void clearTimestamp() => clearField(11);

  google$logging$type.LogSeverity get severity => $_get(6, 12, null);
  void set severity(google$logging$type.LogSeverity v) { setField(12, v); }
  bool hasSeverity() => $_has(6, 12);
  void clearSeverity() => clearField(12);

  List<LogEntry_LabelsEntry> get labels => $_get(7, 13, null);
}

class _ReadonlyLogEntry extends LogEntry with ReadonlyMessageMixin {}

