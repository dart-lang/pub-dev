//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/serviceusage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum for service identity state.
class GetServiceIdentityResponse_IdentityState extends $pb.ProtobufEnum {
  static const GetServiceIdentityResponse_IdentityState
      IDENTITY_STATE_UNSPECIFIED = GetServiceIdentityResponse_IdentityState._(
          0, _omitEnumNames ? '' : 'IDENTITY_STATE_UNSPECIFIED');
  static const GetServiceIdentityResponse_IdentityState ACTIVE =
      GetServiceIdentityResponse_IdentityState._(
          1, _omitEnumNames ? '' : 'ACTIVE');

  static const $core.List<GetServiceIdentityResponse_IdentityState> values =
      <GetServiceIdentityResponse_IdentityState>[
    IDENTITY_STATE_UNSPECIFIED,
    ACTIVE,
  ];

  static final $core.Map<$core.int, GetServiceIdentityResponse_IdentityState>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetServiceIdentityResponse_IdentityState? valueOf($core.int value) =>
      _byValue[value];

  const GetServiceIdentityResponse_IdentityState._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
