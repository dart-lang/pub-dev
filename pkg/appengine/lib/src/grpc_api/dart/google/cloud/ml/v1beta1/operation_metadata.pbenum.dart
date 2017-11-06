///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_operation_metadata_pbenum;

import 'package:protobuf/protobuf.dart';

class OperationMetadata_OperationType extends ProtobufEnum {
  static const OperationMetadata_OperationType OPERATION_TYPE_UNSPECIFIED = const OperationMetadata_OperationType._(0, 'OPERATION_TYPE_UNSPECIFIED');
  static const OperationMetadata_OperationType CREATE_VERSION = const OperationMetadata_OperationType._(1, 'CREATE_VERSION');
  static const OperationMetadata_OperationType DELETE_VERSION = const OperationMetadata_OperationType._(2, 'DELETE_VERSION');
  static const OperationMetadata_OperationType DELETE_MODEL = const OperationMetadata_OperationType._(3, 'DELETE_MODEL');

  static const List<OperationMetadata_OperationType> values = const <OperationMetadata_OperationType> [
    OPERATION_TYPE_UNSPECIFIED,
    CREATE_VERSION,
    DELETE_VERSION,
    DELETE_MODEL,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static OperationMetadata_OperationType valueOf(int value) => _byValue[value] as OperationMetadata_OperationType;
  static void $checkItem(OperationMetadata_OperationType v) {
    if (v is !OperationMetadata_OperationType) checkItemFailed(v, 'OperationMetadata_OperationType');
  }

  const OperationMetadata_OperationType._(int v, String n) : super(v, n);
}

