///
//  Generated code. Do not modify.
///
library google.appengine.v1_operation;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;

class OperationMetadataV1 extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadataV1')
    ..a/*<String>*/(1, 'method', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(2, 'insertTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<String>*/(4, 'user', PbFieldType.OS)
    ..a/*<String>*/(5, 'target', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  OperationMetadataV1() : super();
  OperationMetadataV1.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadataV1.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadataV1 clone() => new OperationMetadataV1()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadataV1 create() => new OperationMetadataV1();
  static PbList<OperationMetadataV1> createRepeated() => new PbList<OperationMetadataV1>();
  static OperationMetadataV1 getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadataV1();
    return _defaultInstance;
  }
  static OperationMetadataV1 _defaultInstance;
  static void $checkItem(OperationMetadataV1 v) {
    if (v is !OperationMetadataV1) checkItemFailed(v, 'OperationMetadataV1');
  }

  String get method => $_get(0, 1, '');
  void set method(String v) { $_setString(0, 1, v); }
  bool hasMethod() => $_has(0, 1);
  void clearMethod() => clearField(1);

  google$protobuf.Timestamp get insertTime => $_get(1, 2, null);
  void set insertTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasInsertTime() => $_has(1, 2);
  void clearInsertTime() => clearField(2);

  google$protobuf.Timestamp get endTime => $_get(2, 3, null);
  void set endTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasEndTime() => $_has(2, 3);
  void clearEndTime() => clearField(3);

  String get user => $_get(3, 4, '');
  void set user(String v) { $_setString(3, 4, v); }
  bool hasUser() => $_has(3, 4);
  void clearUser() => clearField(4);

  String get target => $_get(4, 5, '');
  void set target(String v) { $_setString(4, 5, v); }
  bool hasTarget() => $_has(4, 5);
  void clearTarget() => clearField(5);
}

class _ReadonlyOperationMetadataV1 extends OperationMetadataV1 with ReadonlyMessageMixin {}

