///
//  Generated code. Do not modify.
///
library google.cloud.functions.v1beta2_operations;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/any.pb.dart' as google$protobuf;

import 'operations.pbenum.dart';

export 'operations.pbenum.dart';

class OperationMetadataV1Beta2 extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadataV1Beta2')
    ..a/*<String>*/(1, 'target', PbFieldType.OS)
    ..e/*<OperationType>*/(2, 'type', PbFieldType.OE, OperationType.OPERATION_UNSPECIFIED, OperationType.valueOf)
    ..a/*<google$protobuf.Any>*/(3, 'request', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..hasRequiredFields = false
  ;

  OperationMetadataV1Beta2() : super();
  OperationMetadataV1Beta2.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OperationMetadataV1Beta2.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OperationMetadataV1Beta2 clone() => new OperationMetadataV1Beta2()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OperationMetadataV1Beta2 create() => new OperationMetadataV1Beta2();
  static PbList<OperationMetadataV1Beta2> createRepeated() => new PbList<OperationMetadataV1Beta2>();
  static OperationMetadataV1Beta2 getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperationMetadataV1Beta2();
    return _defaultInstance;
  }
  static OperationMetadataV1Beta2 _defaultInstance;
  static void $checkItem(OperationMetadataV1Beta2 v) {
    if (v is !OperationMetadataV1Beta2) checkItemFailed(v, 'OperationMetadataV1Beta2');
  }

  String get target => $_get(0, 1, '');
  void set target(String v) { $_setString(0, 1, v); }
  bool hasTarget() => $_has(0, 1);
  void clearTarget() => clearField(1);

  OperationType get type => $_get(1, 2, null);
  void set type(OperationType v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);

  google$protobuf.Any get request => $_get(2, 3, null);
  void set request(google$protobuf.Any v) { setField(3, v); }
  bool hasRequest() => $_has(2, 3);
  void clearRequest() => clearField(3);
}

class _ReadonlyOperationMetadataV1Beta2 extends OperationMetadataV1Beta2 with ReadonlyMessageMixin {}

