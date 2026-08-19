//
//  Generated code. Do not modify.
//  source: google/api/consumer.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Supported data type of the property values
class Property_PropertyType extends $pb.ProtobufEnum {
  static const Property_PropertyType UNSPECIFIED =
      Property_PropertyType._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const Property_PropertyType INT64 =
      Property_PropertyType._(1, _omitEnumNames ? '' : 'INT64');
  static const Property_PropertyType BOOL =
      Property_PropertyType._(2, _omitEnumNames ? '' : 'BOOL');
  static const Property_PropertyType STRING =
      Property_PropertyType._(3, _omitEnumNames ? '' : 'STRING');
  static const Property_PropertyType DOUBLE =
      Property_PropertyType._(4, _omitEnumNames ? '' : 'DOUBLE');

  static const $core.List<Property_PropertyType> values =
      <Property_PropertyType>[
    UNSPECIFIED,
    INT64,
    BOOL,
    STRING,
    DOUBLE,
  ];

  static final $core.Map<$core.int, Property_PropertyType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Property_PropertyType? valueOf($core.int value) => _byValue[value];

  const Property_PropertyType._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
