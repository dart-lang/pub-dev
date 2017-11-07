///
//  Generated code. Do not modify.
///
library google.cloud.runtimeconfig.v1beta1_resources_pbenum;

import 'package:protobuf/protobuf.dart';

class VariableState extends ProtobufEnum {
  static const VariableState VARIABLE_STATE_UNSPECIFIED = const VariableState._(0, 'VARIABLE_STATE_UNSPECIFIED');
  static const VariableState UPDATED = const VariableState._(1, 'UPDATED');
  static const VariableState DELETED = const VariableState._(2, 'DELETED');

  static const List<VariableState> values = const <VariableState> [
    VARIABLE_STATE_UNSPECIFIED,
    UPDATED,
    DELETED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static VariableState valueOf(int value) => _byValue[value] as VariableState;
  static void $checkItem(VariableState v) {
    if (v is !VariableState) checkItemFailed(v, 'VariableState');
  }

  const VariableState._(int v, String n) : super(v, n);
}

