//
//  Generated code. Do not modify.
//  source: google/protobuf/cpp_features.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CppFeatures_StringType extends $pb.ProtobufEnum {
  static const CppFeatures_StringType STRING_TYPE_UNKNOWN =
      CppFeatures_StringType._(0, _omitEnumNames ? '' : 'STRING_TYPE_UNKNOWN');
  static const CppFeatures_StringType VIEW =
      CppFeatures_StringType._(1, _omitEnumNames ? '' : 'VIEW');
  static const CppFeatures_StringType CORD =
      CppFeatures_StringType._(2, _omitEnumNames ? '' : 'CORD');
  static const CppFeatures_StringType STRING =
      CppFeatures_StringType._(3, _omitEnumNames ? '' : 'STRING');

  static const $core.List<CppFeatures_StringType> values =
      <CppFeatures_StringType>[
    STRING_TYPE_UNKNOWN,
    VIEW,
    CORD,
    STRING,
  ];

  static final $core.Map<$core.int, CppFeatures_StringType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CppFeatures_StringType? valueOf($core.int value) => _byValue[value];

  const CppFeatures_StringType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
