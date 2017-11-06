///
//  Generated code. Do not modify.
///
library google.api_label_pbenum;

import 'package:protobuf/protobuf.dart';

class LabelDescriptor_ValueType extends ProtobufEnum {
  static const LabelDescriptor_ValueType STRING = const LabelDescriptor_ValueType._(0, 'STRING');
  static const LabelDescriptor_ValueType BOOL = const LabelDescriptor_ValueType._(1, 'BOOL');
  static const LabelDescriptor_ValueType INT64 = const LabelDescriptor_ValueType._(2, 'INT64');

  static const List<LabelDescriptor_ValueType> values = const <LabelDescriptor_ValueType> [
    STRING,
    BOOL,
    INT64,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static LabelDescriptor_ValueType valueOf(int value) => _byValue[value] as LabelDescriptor_ValueType;
  static void $checkItem(LabelDescriptor_ValueType v) {
    if (v is !LabelDescriptor_ValueType) checkItemFailed(v, 'LabelDescriptor_ValueType');
  }

  const LabelDescriptor_ValueType._(int v, String n) : super(v, n);
}

