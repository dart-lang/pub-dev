///
//  Generated code. Do not modify.
///
library google.appengine.legacy_audit_data;

import 'package:protobuf/protobuf.dart';

class AuditData_EventDataEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuditData_EventDataEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AuditData_EventDataEntry() : super();
  AuditData_EventDataEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuditData_EventDataEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuditData_EventDataEntry clone() => new AuditData_EventDataEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuditData_EventDataEntry create() => new AuditData_EventDataEntry();
  static PbList<AuditData_EventDataEntry> createRepeated() => new PbList<AuditData_EventDataEntry>();
  static AuditData_EventDataEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuditData_EventDataEntry();
    return _defaultInstance;
  }
  static AuditData_EventDataEntry _defaultInstance;
  static void $checkItem(AuditData_EventDataEntry v) {
    if (v is !AuditData_EventDataEntry) checkItemFailed(v, 'AuditData_EventDataEntry');
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

class _ReadonlyAuditData_EventDataEntry extends AuditData_EventDataEntry with ReadonlyMessageMixin {}

class AuditData extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuditData')
    ..a/*<String>*/(1, 'eventMessage', PbFieldType.OS)
    ..pp/*<AuditData_EventDataEntry>*/(2, 'eventData', PbFieldType.PM, AuditData_EventDataEntry.$checkItem, AuditData_EventDataEntry.create)
    ..hasRequiredFields = false
  ;

  AuditData() : super();
  AuditData.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuditData.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuditData clone() => new AuditData()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuditData create() => new AuditData();
  static PbList<AuditData> createRepeated() => new PbList<AuditData>();
  static AuditData getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuditData();
    return _defaultInstance;
  }
  static AuditData _defaultInstance;
  static void $checkItem(AuditData v) {
    if (v is !AuditData) checkItemFailed(v, 'AuditData');
  }

  String get eventMessage => $_get(0, 1, '');
  void set eventMessage(String v) { $_setString(0, 1, v); }
  bool hasEventMessage() => $_has(0, 1);
  void clearEventMessage() => clearField(1);

  List<AuditData_EventDataEntry> get eventData => $_get(1, 2, null);
}

class _ReadonlyAuditData extends AuditData with ReadonlyMessageMixin {}

