///
//  Generated code. Do not modify.
///
library google.protobuf_type_pbenum;

import 'package:protobuf/protobuf.dart';

class Syntax extends ProtobufEnum {
  static const Syntax SYNTAX_PROTO2 = const Syntax._(0, 'SYNTAX_PROTO2');
  static const Syntax SYNTAX_PROTO3 = const Syntax._(1, 'SYNTAX_PROTO3');

  static const List<Syntax> values = const <Syntax> [
    SYNTAX_PROTO2,
    SYNTAX_PROTO3,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Syntax valueOf(int value) => _byValue[value] as Syntax;
  static void $checkItem(Syntax v) {
    if (v is !Syntax) checkItemFailed(v, 'Syntax');
  }

  const Syntax._(int v, String n) : super(v, n);
}

class Field_Kind extends ProtobufEnum {
  static const Field_Kind TYPE_UNKNOWN = const Field_Kind._(0, 'TYPE_UNKNOWN');
  static const Field_Kind TYPE_DOUBLE = const Field_Kind._(1, 'TYPE_DOUBLE');
  static const Field_Kind TYPE_FLOAT = const Field_Kind._(2, 'TYPE_FLOAT');
  static const Field_Kind TYPE_INT64 = const Field_Kind._(3, 'TYPE_INT64');
  static const Field_Kind TYPE_UINT64 = const Field_Kind._(4, 'TYPE_UINT64');
  static const Field_Kind TYPE_INT32 = const Field_Kind._(5, 'TYPE_INT32');
  static const Field_Kind TYPE_FIXED64 = const Field_Kind._(6, 'TYPE_FIXED64');
  static const Field_Kind TYPE_FIXED32 = const Field_Kind._(7, 'TYPE_FIXED32');
  static const Field_Kind TYPE_BOOL = const Field_Kind._(8, 'TYPE_BOOL');
  static const Field_Kind TYPE_STRING = const Field_Kind._(9, 'TYPE_STRING');
  static const Field_Kind TYPE_GROUP = const Field_Kind._(10, 'TYPE_GROUP');
  static const Field_Kind TYPE_MESSAGE = const Field_Kind._(11, 'TYPE_MESSAGE');
  static const Field_Kind TYPE_BYTES = const Field_Kind._(12, 'TYPE_BYTES');
  static const Field_Kind TYPE_UINT32 = const Field_Kind._(13, 'TYPE_UINT32');
  static const Field_Kind TYPE_ENUM = const Field_Kind._(14, 'TYPE_ENUM');
  static const Field_Kind TYPE_SFIXED32 = const Field_Kind._(15, 'TYPE_SFIXED32');
  static const Field_Kind TYPE_SFIXED64 = const Field_Kind._(16, 'TYPE_SFIXED64');
  static const Field_Kind TYPE_SINT32 = const Field_Kind._(17, 'TYPE_SINT32');
  static const Field_Kind TYPE_SINT64 = const Field_Kind._(18, 'TYPE_SINT64');

  static const List<Field_Kind> values = const <Field_Kind> [
    TYPE_UNKNOWN,
    TYPE_DOUBLE,
    TYPE_FLOAT,
    TYPE_INT64,
    TYPE_UINT64,
    TYPE_INT32,
    TYPE_FIXED64,
    TYPE_FIXED32,
    TYPE_BOOL,
    TYPE_STRING,
    TYPE_GROUP,
    TYPE_MESSAGE,
    TYPE_BYTES,
    TYPE_UINT32,
    TYPE_ENUM,
    TYPE_SFIXED32,
    TYPE_SFIXED64,
    TYPE_SINT32,
    TYPE_SINT64,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Field_Kind valueOf(int value) => _byValue[value] as Field_Kind;
  static void $checkItem(Field_Kind v) {
    if (v is !Field_Kind) checkItemFailed(v, 'Field_Kind');
  }

  const Field_Kind._(int v, String n) : super(v, n);
}

class Field_Cardinality extends ProtobufEnum {
  static const Field_Cardinality CARDINALITY_UNKNOWN = const Field_Cardinality._(0, 'CARDINALITY_UNKNOWN');
  static const Field_Cardinality CARDINALITY_OPTIONAL = const Field_Cardinality._(1, 'CARDINALITY_OPTIONAL');
  static const Field_Cardinality CARDINALITY_REQUIRED = const Field_Cardinality._(2, 'CARDINALITY_REQUIRED');
  static const Field_Cardinality CARDINALITY_REPEATED = const Field_Cardinality._(3, 'CARDINALITY_REPEATED');

  static const List<Field_Cardinality> values = const <Field_Cardinality> [
    CARDINALITY_UNKNOWN,
    CARDINALITY_OPTIONAL,
    CARDINALITY_REQUIRED,
    CARDINALITY_REPEATED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Field_Cardinality valueOf(int value) => _byValue[value] as Field_Cardinality;
  static void $checkItem(Field_Cardinality v) {
    if (v is !Field_Cardinality) checkItemFailed(v, 'Field_Cardinality');
  }

  const Field_Cardinality._(int v, String n) : super(v, n);
}

