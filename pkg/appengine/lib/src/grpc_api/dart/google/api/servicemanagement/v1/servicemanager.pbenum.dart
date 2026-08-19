//
//  Generated code. Do not modify.
//  source: google/api/servicemanagement/v1/servicemanager.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetServiceConfigRequest_ConfigView extends $pb.ProtobufEnum {
  static const GetServiceConfigRequest_ConfigView BASIC =
      GetServiceConfigRequest_ConfigView._(0, _omitEnumNames ? '' : 'BASIC');
  static const GetServiceConfigRequest_ConfigView FULL =
      GetServiceConfigRequest_ConfigView._(1, _omitEnumNames ? '' : 'FULL');

  static const $core.List<GetServiceConfigRequest_ConfigView> values =
      <GetServiceConfigRequest_ConfigView>[
    BASIC,
    FULL,
  ];

  static final $core.Map<$core.int, GetServiceConfigRequest_ConfigView>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetServiceConfigRequest_ConfigView? valueOf($core.int value) =>
      _byValue[value];

  const GetServiceConfigRequest_ConfigView._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
