///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_operation_metadata;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import 'model_service.pb.dart';

import 'operation_metadata.pbenum.dart';

export 'operation_metadata.pbenum.dart';

class OperationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OperationMetadata')
    ..a/*<google$protobuf.Timestamp>*/(1, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(2, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<bool>*/(4, 'isCancellationRequested', PbFieldType.OB)
    ..e/*<OperationMetadata_OperationType>*/(5, 'operationType', PbFieldType.OE, OperationMetadata_OperationType.OPERATION_TYPE_UNSPECIFIED, OperationMetadata_OperationType.valueOf)
    ..a/*<String>*/(6, 'modelName', PbFieldType.OS)
    ..a/*<Version>*/(7, 'version', PbFieldType.OM, Version.getDefault, Version.create)
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

  google$protobuf.Timestamp get createTime => $_get(0, 1, null);
  void set createTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasCreateTime() => $_has(0, 1);
  void clearCreateTime() => clearField(1);

  google$protobuf.Timestamp get startTime => $_get(1, 2, null);
  void set startTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasStartTime() => $_has(1, 2);
  void clearStartTime() => clearField(2);

  google$protobuf.Timestamp get endTime => $_get(2, 3, null);
  void set endTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasEndTime() => $_has(2, 3);
  void clearEndTime() => clearField(3);

  bool get isCancellationRequested => $_get(3, 4, false);
  void set isCancellationRequested(bool v) { $_setBool(3, 4, v); }
  bool hasIsCancellationRequested() => $_has(3, 4);
  void clearIsCancellationRequested() => clearField(4);

  OperationMetadata_OperationType get operationType => $_get(4, 5, null);
  void set operationType(OperationMetadata_OperationType v) { setField(5, v); }
  bool hasOperationType() => $_has(4, 5);
  void clearOperationType() => clearField(5);

  String get modelName => $_get(5, 6, '');
  void set modelName(String v) { $_setString(5, 6, v); }
  bool hasModelName() => $_has(5, 6);
  void clearModelName() => clearField(6);

  Version get version => $_get(6, 7, null);
  void set version(Version v) { setField(7, v); }
  bool hasVersion() => $_has(6, 7);
  void clearVersion() => clearField(7);
}

class _ReadonlyOperationMetadata extends OperationMetadata with ReadonlyMessageMixin {}

