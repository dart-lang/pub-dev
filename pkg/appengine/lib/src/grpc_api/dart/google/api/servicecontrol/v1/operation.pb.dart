///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_operation;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import 'metric_value.pb.dart';
import 'log_entry.pb.dart';

import 'operation.pbenum.dart';

export 'operation.pbenum.dart';

class Operation_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Operation_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Operation_LabelsEntry() : super();
  Operation_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Operation_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Operation_LabelsEntry clone() => new Operation_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Operation_LabelsEntry create() => new Operation_LabelsEntry();
  static PbList<Operation_LabelsEntry> createRepeated() => new PbList<Operation_LabelsEntry>();
  static Operation_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperation_LabelsEntry();
    return _defaultInstance;
  }
  static Operation_LabelsEntry _defaultInstance;
  static void $checkItem(Operation_LabelsEntry v) {
    if (v is !Operation_LabelsEntry) checkItemFailed(v, 'Operation_LabelsEntry');
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

class _ReadonlyOperation_LabelsEntry extends Operation_LabelsEntry with ReadonlyMessageMixin {}

class Operation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Operation')
    ..a/*<String>*/(1, 'operationId', PbFieldType.OS)
    ..a/*<String>*/(2, 'operationName', PbFieldType.OS)
    ..a/*<String>*/(3, 'consumerId', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..pp/*<Operation_LabelsEntry>*/(6, 'labels', PbFieldType.PM, Operation_LabelsEntry.$checkItem, Operation_LabelsEntry.create)
    ..pp/*<MetricValueSet>*/(7, 'metricValueSets', PbFieldType.PM, MetricValueSet.$checkItem, MetricValueSet.create)
    ..pp/*<LogEntry>*/(8, 'logEntries', PbFieldType.PM, LogEntry.$checkItem, LogEntry.create)
    ..e/*<Operation_Importance>*/(11, 'importance', PbFieldType.OE, Operation_Importance.LOW, Operation_Importance.valueOf)
    ..hasRequiredFields = false
  ;

  Operation() : super();
  Operation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Operation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Operation clone() => new Operation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Operation create() => new Operation();
  static PbList<Operation> createRepeated() => new PbList<Operation>();
  static Operation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperation();
    return _defaultInstance;
  }
  static Operation _defaultInstance;
  static void $checkItem(Operation v) {
    if (v is !Operation) checkItemFailed(v, 'Operation');
  }

  String get operationId => $_get(0, 1, '');
  void set operationId(String v) { $_setString(0, 1, v); }
  bool hasOperationId() => $_has(0, 1);
  void clearOperationId() => clearField(1);

  String get operationName => $_get(1, 2, '');
  void set operationName(String v) { $_setString(1, 2, v); }
  bool hasOperationName() => $_has(1, 2);
  void clearOperationName() => clearField(2);

  String get consumerId => $_get(2, 3, '');
  void set consumerId(String v) { $_setString(2, 3, v); }
  bool hasConsumerId() => $_has(2, 3);
  void clearConsumerId() => clearField(3);

  google$protobuf.Timestamp get startTime => $_get(3, 4, null);
  void set startTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasStartTime() => $_has(3, 4);
  void clearStartTime() => clearField(4);

  google$protobuf.Timestamp get endTime => $_get(4, 5, null);
  void set endTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasEndTime() => $_has(4, 5);
  void clearEndTime() => clearField(5);

  List<Operation_LabelsEntry> get labels => $_get(5, 6, null);

  List<MetricValueSet> get metricValueSets => $_get(6, 7, null);

  List<LogEntry> get logEntries => $_get(7, 8, null);

  Operation_Importance get importance => $_get(8, 11, null);
  void set importance(Operation_Importance v) { setField(11, v); }
  bool hasImportance() => $_has(8, 11);
  void clearImportance() => clearField(11);
}

class _ReadonlyOperation extends Operation with ReadonlyMessageMixin {}

