//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/checked.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// CEL primitive types.
class Type_PrimitiveType extends $pb.ProtobufEnum {
  static const Type_PrimitiveType PRIMITIVE_TYPE_UNSPECIFIED =
      Type_PrimitiveType._(
          0, _omitEnumNames ? '' : 'PRIMITIVE_TYPE_UNSPECIFIED');
  static const Type_PrimitiveType BOOL =
      Type_PrimitiveType._(1, _omitEnumNames ? '' : 'BOOL');
  static const Type_PrimitiveType INT64 =
      Type_PrimitiveType._(2, _omitEnumNames ? '' : 'INT64');
  static const Type_PrimitiveType UINT64 =
      Type_PrimitiveType._(3, _omitEnumNames ? '' : 'UINT64');
  static const Type_PrimitiveType DOUBLE =
      Type_PrimitiveType._(4, _omitEnumNames ? '' : 'DOUBLE');
  static const Type_PrimitiveType STRING =
      Type_PrimitiveType._(5, _omitEnumNames ? '' : 'STRING');
  static const Type_PrimitiveType BYTES =
      Type_PrimitiveType._(6, _omitEnumNames ? '' : 'BYTES');

  static const $core.List<Type_PrimitiveType> values = <Type_PrimitiveType>[
    PRIMITIVE_TYPE_UNSPECIFIED,
    BOOL,
    INT64,
    UINT64,
    DOUBLE,
    STRING,
    BYTES,
  ];

  static final $core.Map<$core.int, Type_PrimitiveType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Type_PrimitiveType? valueOf($core.int value) => _byValue[value];

  const Type_PrimitiveType._($core.int v, $core.String n) : super(v, n);
}

/// Well-known protobuf types treated with first-class support in CEL.
class Type_WellKnownType extends $pb.ProtobufEnum {
  static const Type_WellKnownType WELL_KNOWN_TYPE_UNSPECIFIED =
      Type_WellKnownType._(
          0, _omitEnumNames ? '' : 'WELL_KNOWN_TYPE_UNSPECIFIED');
  static const Type_WellKnownType ANY =
      Type_WellKnownType._(1, _omitEnumNames ? '' : 'ANY');
  static const Type_WellKnownType TIMESTAMP =
      Type_WellKnownType._(2, _omitEnumNames ? '' : 'TIMESTAMP');
  static const Type_WellKnownType DURATION =
      Type_WellKnownType._(3, _omitEnumNames ? '' : 'DURATION');

  static const $core.List<Type_WellKnownType> values = <Type_WellKnownType>[
    WELL_KNOWN_TYPE_UNSPECIFIED,
    ANY,
    TIMESTAMP,
    DURATION,
  ];

  static final $core.Map<$core.int, Type_WellKnownType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Type_WellKnownType? valueOf($core.int value) => _byValue[value];

  const Type_WellKnownType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
