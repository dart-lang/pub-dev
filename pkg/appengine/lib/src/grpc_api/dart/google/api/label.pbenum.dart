//
//  Generated code. Do not modify.
//  source: google/api/label.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Value types that can be used as label values.
class LabelDescriptor_ValueType extends $pb.ProtobufEnum {
  static const LabelDescriptor_ValueType STRING =
      LabelDescriptor_ValueType._(0, _omitEnumNames ? '' : 'STRING');
  static const LabelDescriptor_ValueType BOOL =
      LabelDescriptor_ValueType._(1, _omitEnumNames ? '' : 'BOOL');
  static const LabelDescriptor_ValueType INT64 =
      LabelDescriptor_ValueType._(2, _omitEnumNames ? '' : 'INT64');

  static const $core.List<LabelDescriptor_ValueType> values =
      <LabelDescriptor_ValueType>[
    STRING,
    BOOL,
    INT64,
  ];

  static final $core.Map<$core.int, LabelDescriptor_ValueType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LabelDescriptor_ValueType? valueOf($core.int value) => _byValue[value];

  const LabelDescriptor_ValueType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
