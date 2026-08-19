//
//  Generated code. Do not modify.
//  source: google/api/field_info.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The standard format of a field value. The supported formats are all backed
/// by either an RFC defined by the IETF or a Google-defined AIP.
class FieldInfo_Format extends $pb.ProtobufEnum {
  static const FieldInfo_Format FORMAT_UNSPECIFIED =
      FieldInfo_Format._(0, _omitEnumNames ? '' : 'FORMAT_UNSPECIFIED');
  static const FieldInfo_Format UUID4 =
      FieldInfo_Format._(1, _omitEnumNames ? '' : 'UUID4');
  static const FieldInfo_Format IPV4 =
      FieldInfo_Format._(2, _omitEnumNames ? '' : 'IPV4');
  static const FieldInfo_Format IPV6 =
      FieldInfo_Format._(3, _omitEnumNames ? '' : 'IPV6');
  static const FieldInfo_Format IPV4_OR_IPV6 =
      FieldInfo_Format._(4, _omitEnumNames ? '' : 'IPV4_OR_IPV6');

  static const $core.List<FieldInfo_Format> values = <FieldInfo_Format>[
    FORMAT_UNSPECIFIED,
    UUID4,
    IPV4,
    IPV6,
    IPV4_OR_IPV6,
  ];

  static final $core.Map<$core.int, FieldInfo_Format> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldInfo_Format? valueOf($core.int value) => _byValue[value];

  const FieldInfo_Format._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
