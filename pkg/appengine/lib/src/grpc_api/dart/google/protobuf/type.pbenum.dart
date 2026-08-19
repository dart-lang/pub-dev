//
//  Generated code. Do not modify.
//  source: google/protobuf/type.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The syntax in which a protocol buffer element is defined.
class Syntax extends $pb.ProtobufEnum {
  static const Syntax SYNTAX_PROTO2 =
      Syntax._(0, _omitEnumNames ? '' : 'SYNTAX_PROTO2');
  static const Syntax SYNTAX_PROTO3 =
      Syntax._(1, _omitEnumNames ? '' : 'SYNTAX_PROTO3');
  static const Syntax SYNTAX_EDITIONS =
      Syntax._(2, _omitEnumNames ? '' : 'SYNTAX_EDITIONS');

  static const $core.List<Syntax> values = <Syntax>[
    SYNTAX_PROTO2,
    SYNTAX_PROTO3,
    SYNTAX_EDITIONS,
  ];

  static final $core.Map<$core.int, Syntax> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Syntax? valueOf($core.int value) => _byValue[value];

  const Syntax._($core.int v, $core.String n) : super(v, n);
}

/// Basic field types.
class Field_Kind extends $pb.ProtobufEnum {
  static const Field_Kind TYPE_UNKNOWN =
      Field_Kind._(0, _omitEnumNames ? '' : 'TYPE_UNKNOWN');
  static const Field_Kind TYPE_DOUBLE =
      Field_Kind._(1, _omitEnumNames ? '' : 'TYPE_DOUBLE');
  static const Field_Kind TYPE_FLOAT =
      Field_Kind._(2, _omitEnumNames ? '' : 'TYPE_FLOAT');
  static const Field_Kind TYPE_INT64 =
      Field_Kind._(3, _omitEnumNames ? '' : 'TYPE_INT64');
  static const Field_Kind TYPE_UINT64 =
      Field_Kind._(4, _omitEnumNames ? '' : 'TYPE_UINT64');
  static const Field_Kind TYPE_INT32 =
      Field_Kind._(5, _omitEnumNames ? '' : 'TYPE_INT32');
  static const Field_Kind TYPE_FIXED64 =
      Field_Kind._(6, _omitEnumNames ? '' : 'TYPE_FIXED64');
  static const Field_Kind TYPE_FIXED32 =
      Field_Kind._(7, _omitEnumNames ? '' : 'TYPE_FIXED32');
  static const Field_Kind TYPE_BOOL =
      Field_Kind._(8, _omitEnumNames ? '' : 'TYPE_BOOL');
  static const Field_Kind TYPE_STRING =
      Field_Kind._(9, _omitEnumNames ? '' : 'TYPE_STRING');
  static const Field_Kind TYPE_GROUP =
      Field_Kind._(10, _omitEnumNames ? '' : 'TYPE_GROUP');
  static const Field_Kind TYPE_MESSAGE =
      Field_Kind._(11, _omitEnumNames ? '' : 'TYPE_MESSAGE');
  static const Field_Kind TYPE_BYTES =
      Field_Kind._(12, _omitEnumNames ? '' : 'TYPE_BYTES');
  static const Field_Kind TYPE_UINT32 =
      Field_Kind._(13, _omitEnumNames ? '' : 'TYPE_UINT32');
  static const Field_Kind TYPE_ENUM =
      Field_Kind._(14, _omitEnumNames ? '' : 'TYPE_ENUM');
  static const Field_Kind TYPE_SFIXED32 =
      Field_Kind._(15, _omitEnumNames ? '' : 'TYPE_SFIXED32');
  static const Field_Kind TYPE_SFIXED64 =
      Field_Kind._(16, _omitEnumNames ? '' : 'TYPE_SFIXED64');
  static const Field_Kind TYPE_SINT32 =
      Field_Kind._(17, _omitEnumNames ? '' : 'TYPE_SINT32');
  static const Field_Kind TYPE_SINT64 =
      Field_Kind._(18, _omitEnumNames ? '' : 'TYPE_SINT64');

  static const $core.List<Field_Kind> values = <Field_Kind>[
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

  static final $core.Map<$core.int, Field_Kind> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Field_Kind? valueOf($core.int value) => _byValue[value];

  const Field_Kind._($core.int v, $core.String n) : super(v, n);
}

/// Whether a field is optional, required, or repeated.
class Field_Cardinality extends $pb.ProtobufEnum {
  static const Field_Cardinality CARDINALITY_UNKNOWN =
      Field_Cardinality._(0, _omitEnumNames ? '' : 'CARDINALITY_UNKNOWN');
  static const Field_Cardinality CARDINALITY_OPTIONAL =
      Field_Cardinality._(1, _omitEnumNames ? '' : 'CARDINALITY_OPTIONAL');
  static const Field_Cardinality CARDINALITY_REQUIRED =
      Field_Cardinality._(2, _omitEnumNames ? '' : 'CARDINALITY_REQUIRED');
  static const Field_Cardinality CARDINALITY_REPEATED =
      Field_Cardinality._(3, _omitEnumNames ? '' : 'CARDINALITY_REPEATED');

  static const $core.List<Field_Cardinality> values = <Field_Cardinality>[
    CARDINALITY_UNKNOWN,
    CARDINALITY_OPTIONAL,
    CARDINALITY_REQUIRED,
    CARDINALITY_REPEATED,
  ];

  static final $core.Map<$core.int, Field_Cardinality> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Field_Cardinality? valueOf($core.int value) => _byValue[value];

  const Field_Cardinality._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
