//
//  Generated code. Do not modify.
//  source: google/iam/v1beta/workload_identity_pool.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The current state of the pool.
class WorkloadIdentityPool_State extends $pb.ProtobufEnum {
  static const WorkloadIdentityPool_State STATE_UNSPECIFIED =
      WorkloadIdentityPool_State._(
          0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');
  static const WorkloadIdentityPool_State ACTIVE =
      WorkloadIdentityPool_State._(1, _omitEnumNames ? '' : 'ACTIVE');
  static const WorkloadIdentityPool_State DELETED =
      WorkloadIdentityPool_State._(2, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<WorkloadIdentityPool_State> values =
      <WorkloadIdentityPool_State>[
    STATE_UNSPECIFIED,
    ACTIVE,
    DELETED,
  ];

  static final $core.Map<$core.int, WorkloadIdentityPool_State> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static WorkloadIdentityPool_State? valueOf($core.int value) =>
      _byValue[value];

  const WorkloadIdentityPool_State._($core.int v, $core.String n) : super(v, n);
}

/// The current state of the provider.
class WorkloadIdentityPoolProvider_State extends $pb.ProtobufEnum {
  static const WorkloadIdentityPoolProvider_State STATE_UNSPECIFIED =
      WorkloadIdentityPoolProvider_State._(
          0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');
  static const WorkloadIdentityPoolProvider_State ACTIVE =
      WorkloadIdentityPoolProvider_State._(1, _omitEnumNames ? '' : 'ACTIVE');
  static const WorkloadIdentityPoolProvider_State DELETED =
      WorkloadIdentityPoolProvider_State._(2, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<WorkloadIdentityPoolProvider_State> values =
      <WorkloadIdentityPoolProvider_State>[
    STATE_UNSPECIFIED,
    ACTIVE,
    DELETED,
  ];

  static final $core.Map<$core.int, WorkloadIdentityPoolProvider_State>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static WorkloadIdentityPoolProvider_State? valueOf($core.int value) =>
      _byValue[value];

  const WorkloadIdentityPoolProvider_State._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
