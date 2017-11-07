///
//  Generated code. Do not modify.
///
library google.iam.v1_policy_pbenum;

import 'package:protobuf/protobuf.dart';

class BindingDelta_Action extends ProtobufEnum {
  static const BindingDelta_Action ACTION_UNSPECIFIED = const BindingDelta_Action._(0, 'ACTION_UNSPECIFIED');
  static const BindingDelta_Action ADD = const BindingDelta_Action._(1, 'ADD');
  static const BindingDelta_Action REMOVE = const BindingDelta_Action._(2, 'REMOVE');

  static const List<BindingDelta_Action> values = const <BindingDelta_Action> [
    ACTION_UNSPECIFIED,
    ADD,
    REMOVE,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static BindingDelta_Action valueOf(int value) => _byValue[value] as BindingDelta_Action;
  static void $checkItem(BindingDelta_Action v) {
    if (v is !BindingDelta_Action) checkItemFailed(v, 'BindingDelta_Action');
  }

  const BindingDelta_Action._(int v, String n) : super(v, n);
}

