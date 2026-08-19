//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/network_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// If unspecified, INGRESS_TRAFFIC_ALLOWED_ALL will be used.
class NetworkSettings_IngressTrafficAllowed extends $pb.ProtobufEnum {
  static const NetworkSettings_IngressTrafficAllowed
      INGRESS_TRAFFIC_ALLOWED_UNSPECIFIED =
      NetworkSettings_IngressTrafficAllowed._(
          0, _omitEnumNames ? '' : 'INGRESS_TRAFFIC_ALLOWED_UNSPECIFIED');
  static const NetworkSettings_IngressTrafficAllowed
      INGRESS_TRAFFIC_ALLOWED_ALL = NetworkSettings_IngressTrafficAllowed._(
          1, _omitEnumNames ? '' : 'INGRESS_TRAFFIC_ALLOWED_ALL');
  static const NetworkSettings_IngressTrafficAllowed
      INGRESS_TRAFFIC_ALLOWED_INTERNAL_ONLY =
      NetworkSettings_IngressTrafficAllowed._(
          2, _omitEnumNames ? '' : 'INGRESS_TRAFFIC_ALLOWED_INTERNAL_ONLY');
  static const NetworkSettings_IngressTrafficAllowed
      INGRESS_TRAFFIC_ALLOWED_INTERNAL_AND_LB =
      NetworkSettings_IngressTrafficAllowed._(
          3, _omitEnumNames ? '' : 'INGRESS_TRAFFIC_ALLOWED_INTERNAL_AND_LB');

  static const $core.List<NetworkSettings_IngressTrafficAllowed> values =
      <NetworkSettings_IngressTrafficAllowed>[
    INGRESS_TRAFFIC_ALLOWED_UNSPECIFIED,
    INGRESS_TRAFFIC_ALLOWED_ALL,
    INGRESS_TRAFFIC_ALLOWED_INTERNAL_ONLY,
    INGRESS_TRAFFIC_ALLOWED_INTERNAL_AND_LB,
  ];

  static final $core.Map<$core.int, NetworkSettings_IngressTrafficAllowed>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static NetworkSettings_IngressTrafficAllowed? valueOf($core.int value) =>
      _byValue[value];

  const NetworkSettings_IngressTrafficAllowed._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
