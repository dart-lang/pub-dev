///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_operation_pbenum;

import 'package:protobuf/protobuf.dart';

class Operation_Importance extends ProtobufEnum {
  static const Operation_Importance LOW = const Operation_Importance._(0, 'LOW');
  static const Operation_Importance HIGH = const Operation_Importance._(1, 'HIGH');

  static const List<Operation_Importance> values = const <Operation_Importance> [
    LOW,
    HIGH,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Operation_Importance valueOf(int value) => _byValue[value] as Operation_Importance;
  static void $checkItem(Operation_Importance v) {
    if (v is !Operation_Importance) checkItemFailed(v, 'Operation_Importance');
  }

  const Operation_Importance._(int v, String n) : super(v, n);
}

