//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/instance.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Availability of the instance.
class Instance_Availability extends $pb.ProtobufEnum {
  static const Instance_Availability UNSPECIFIED =
      Instance_Availability._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const Instance_Availability RESIDENT =
      Instance_Availability._(1, _omitEnumNames ? '' : 'RESIDENT');
  static const Instance_Availability DYNAMIC =
      Instance_Availability._(2, _omitEnumNames ? '' : 'DYNAMIC');

  static const $core.List<Instance_Availability> values =
      <Instance_Availability>[
    UNSPECIFIED,
    RESIDENT,
    DYNAMIC,
  ];

  static final $core.Map<$core.int, Instance_Availability> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Instance_Availability? valueOf($core.int value) => _byValue[value];

  const Instance_Availability._($core.int v, $core.String n) : super(v, n);
}

/// Liveness health check status for Flex instances.
class Instance_Liveness_LivenessState extends $pb.ProtobufEnum {
  static const Instance_Liveness_LivenessState LIVENESS_STATE_UNSPECIFIED =
      Instance_Liveness_LivenessState._(
          0, _omitEnumNames ? '' : 'LIVENESS_STATE_UNSPECIFIED');
  static const Instance_Liveness_LivenessState UNKNOWN =
      Instance_Liveness_LivenessState._(1, _omitEnumNames ? '' : 'UNKNOWN');
  static const Instance_Liveness_LivenessState HEALTHY =
      Instance_Liveness_LivenessState._(2, _omitEnumNames ? '' : 'HEALTHY');
  static const Instance_Liveness_LivenessState UNHEALTHY =
      Instance_Liveness_LivenessState._(3, _omitEnumNames ? '' : 'UNHEALTHY');
  static const Instance_Liveness_LivenessState DRAINING =
      Instance_Liveness_LivenessState._(4, _omitEnumNames ? '' : 'DRAINING');
  static const Instance_Liveness_LivenessState TIMEOUT =
      Instance_Liveness_LivenessState._(5, _omitEnumNames ? '' : 'TIMEOUT');

  static const $core.List<Instance_Liveness_LivenessState> values =
      <Instance_Liveness_LivenessState>[
    LIVENESS_STATE_UNSPECIFIED,
    UNKNOWN,
    HEALTHY,
    UNHEALTHY,
    DRAINING,
    TIMEOUT,
  ];

  static final $core.Map<$core.int, Instance_Liveness_LivenessState> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Instance_Liveness_LivenessState? valueOf($core.int value) =>
      _byValue[value];

  const Instance_Liveness_LivenessState._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
