///
//  Generated code. Do not modify.
///
library google.genomics.v1_operations;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../protobuf/any.pb.dart' as google$protobuf;

class OperationMetadata_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadata_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  OperationMetadata_LabelsEntry() : super();
  OperationMetadata_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadata_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadata_LabelsEntry clone() => new OperationMetadata_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadata_LabelsEntry create() => new OperationMetadata_LabelsEntry();
  static PbList<OperationMetadata_LabelsEntry> createRepeated() => new PbList<OperationMetadata_LabelsEntry>();
  static OperationMetadata_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadata_LabelsEntry();
    return _defaultInstance;
  }
  static OperationMetadata_LabelsEntry _defaultInstance;
  static void $checkItem(OperationMetadata_LabelsEntry v) {
    if (v is !OperationMetadata_LabelsEntry) checkItemFailed(v, 'OperationMetadata_LabelsEntry');
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

class _ReadonlyOperationMetadata_LabelsEntry extends OperationMetadata_LabelsEntry with ReadonlyMessageMixin {}

class OperationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadata')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(2, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(4, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Any>*/(5, 'request', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..pp/*<OperationEvent>*/(6, 'events', PbFieldType.PM, OperationEvent.$checkItem, OperationEvent.create)
    ..a/*<String>*/(7, 'clientId', PbFieldType.OS)
    ..a/*<google$protobuf.Any>*/(8, 'runtimeMetadata', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..pp/*<OperationMetadata_LabelsEntry>*/(9, 'labels', PbFieldType.PM, OperationMetadata_LabelsEntry.$checkItem, OperationMetadata_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  OperationMetadata() : super();
  OperationMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadata clone() => new OperationMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadata create() => new OperationMetadata();
  static PbList<OperationMetadata> createRepeated() => new PbList<OperationMetadata>();
  static OperationMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadata();
    return _defaultInstance;
  }
  static OperationMetadata _defaultInstance;
  static void $checkItem(OperationMetadata v) {
    if (v is !OperationMetadata) checkItemFailed(v, 'OperationMetadata');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  google$protobuf.Timestamp get createTime => $_get(1, 2, null);
  void set createTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasCreateTime() => $_has(1, 2);
  void clearCreateTime() => clearField(2);

  google$protobuf.Timestamp get startTime => $_get(2, 3, null);
  void set startTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasStartTime() => $_has(2, 3);
  void clearStartTime() => clearField(3);

  google$protobuf.Timestamp get endTime => $_get(3, 4, null);
  void set endTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasEndTime() => $_has(3, 4);
  void clearEndTime() => clearField(4);

  google$protobuf.Any get request => $_get(4, 5, null);
  void set request(google$protobuf.Any v) { setField(5, v); }
  bool hasRequest() => $_has(4, 5);
  void clearRequest() => clearField(5);

  List<OperationEvent> get events => $_get(5, 6, null);

  String get clientId => $_get(6, 7, '');
  void set clientId(String v) { $_setString(6, 7, v); }
  bool hasClientId() => $_has(6, 7);
  void clearClientId() => clearField(7);

  google$protobuf.Any get runtimeMetadata => $_get(7, 8, null);
  void set runtimeMetadata(google$protobuf.Any v) { setField(8, v); }
  bool hasRuntimeMetadata() => $_has(7, 8);
  void clearRuntimeMetadata() => clearField(8);

  List<OperationMetadata_LabelsEntry> get labels => $_get(8, 9, null);
}

class _ReadonlyOperationMetadata extends OperationMetadata with ReadonlyMessageMixin {}

class OperationEvent extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationEvent')
    ..a/*<google$protobuf.Timestamp>*/(1, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(2, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<String>*/(3, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  OperationEvent() : super();
  OperationEvent.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationEvent.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationEvent clone() => new OperationEvent()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationEvent create() => new OperationEvent();
  static PbList<OperationEvent> createRepeated() => new PbList<OperationEvent>();
  static OperationEvent getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationEvent();
    return _defaultInstance;
  }
  static OperationEvent _defaultInstance;
  static void $checkItem(OperationEvent v) {
    if (v is !OperationEvent) checkItemFailed(v, 'OperationEvent');
  }

  google$protobuf.Timestamp get startTime => $_get(0, 1, null);
  void set startTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasStartTime() => $_has(0, 1);
  void clearStartTime() => clearField(1);

  google$protobuf.Timestamp get endTime => $_get(1, 2, null);
  void set endTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasEndTime() => $_has(1, 2);
  void clearEndTime() => clearField(2);

  String get description => $_get(2, 3, '');
  void set description(String v) { $_setString(2, 3, v); }
  bool hasDescription() => $_has(2, 3);
  void clearDescription() => clearField(3);
}

class _ReadonlyOperationEvent extends OperationEvent with ReadonlyMessageMixin {}

