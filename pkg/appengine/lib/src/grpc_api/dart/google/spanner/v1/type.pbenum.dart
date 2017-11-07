///
//  Generated code. Do not modify.
///
library google.spanner.v1_type_pbenum;

import 'package:protobuf/protobuf.dart';

class TypeCode extends ProtobufEnum {
  static const TypeCode TYPE_CODE_UNSPECIFIED = const TypeCode._(0, 'TYPE_CODE_UNSPECIFIED');
  static const TypeCode BOOL = const TypeCode._(1, 'BOOL');
  static const TypeCode INT64 = const TypeCode._(2, 'INT64');
  static const TypeCode FLOAT64 = const TypeCode._(3, 'FLOAT64');
  static const TypeCode TIMESTAMP = const TypeCode._(4, 'TIMESTAMP');
  static const TypeCode DATE = const TypeCode._(5, 'DATE');
  static const TypeCode STRING = const TypeCode._(6, 'STRING');
  static const TypeCode BYTES = const TypeCode._(7, 'BYTES');
  static const TypeCode ARRAY = const TypeCode._(8, 'ARRAY');
  static const TypeCode STRUCT = const TypeCode._(9, 'STRUCT');

  static const List<TypeCode> values = const <TypeCode> [
    TYPE_CODE_UNSPECIFIED,
    BOOL,
    INT64,
    FLOAT64,
    TIMESTAMP,
    DATE,
    STRING,
    BYTES,
    ARRAY,
    STRUCT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static TypeCode valueOf(int value) => _byValue[value] as TypeCode;
  static void $checkItem(TypeCode v) {
    if (v is !TypeCode) checkItemFailed(v, 'TypeCode');
  }

  const TypeCode._(int v, String n) : super(v, n);
}

