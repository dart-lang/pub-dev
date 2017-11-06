///
//  Generated code. Do not modify.
///
library google.cloud.functions.v1beta2_operations_pbenum;

import 'package:protobuf/protobuf.dart';

class OperationType extends ProtobufEnum {
  static const OperationType OPERATION_UNSPECIFIED = const OperationType._(0, 'OPERATION_UNSPECIFIED');
  static const OperationType CREATE_FUNCTION = const OperationType._(1, 'CREATE_FUNCTION');
  static const OperationType UPDATE_FUNCTION = const OperationType._(2, 'UPDATE_FUNCTION');
  static const OperationType DELETE_FUNCTION = const OperationType._(3, 'DELETE_FUNCTION');

  static const List<OperationType> values = const <OperationType> [
    OPERATION_UNSPECIFIED,
    CREATE_FUNCTION,
    UPDATE_FUNCTION,
    DELETE_FUNCTION,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static OperationType valueOf(int value) => _byValue[value] as OperationType;
  static void $checkItem(OperationType v) {
    if (v is !OperationType) checkItemFailed(v, 'OperationType');
  }

  const OperationType._(int v, String n) : super(v, n);
}

