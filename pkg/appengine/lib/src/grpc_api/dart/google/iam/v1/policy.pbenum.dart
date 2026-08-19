//
//  Generated code. Do not modify.
//  source: google/iam/v1/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The list of valid permission types for which logging can be configured.
/// Admin writes are always logged, and are not configurable.
class AuditLogConfig_LogType extends $pb.ProtobufEnum {
  static const AuditLogConfig_LogType LOG_TYPE_UNSPECIFIED =
      AuditLogConfig_LogType._(0, _omitEnumNames ? '' : 'LOG_TYPE_UNSPECIFIED');
  static const AuditLogConfig_LogType ADMIN_READ =
      AuditLogConfig_LogType._(1, _omitEnumNames ? '' : 'ADMIN_READ');
  static const AuditLogConfig_LogType DATA_WRITE =
      AuditLogConfig_LogType._(2, _omitEnumNames ? '' : 'DATA_WRITE');
  static const AuditLogConfig_LogType DATA_READ =
      AuditLogConfig_LogType._(3, _omitEnumNames ? '' : 'DATA_READ');

  static const $core.List<AuditLogConfig_LogType> values =
      <AuditLogConfig_LogType>[
    LOG_TYPE_UNSPECIFIED,
    ADMIN_READ,
    DATA_WRITE,
    DATA_READ,
  ];

  static final $core.Map<$core.int, AuditLogConfig_LogType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AuditLogConfig_LogType? valueOf($core.int value) => _byValue[value];

  const AuditLogConfig_LogType._($core.int v, $core.String n) : super(v, n);
}

/// The type of action performed on a Binding in a policy.
class BindingDelta_Action extends $pb.ProtobufEnum {
  static const BindingDelta_Action ACTION_UNSPECIFIED =
      BindingDelta_Action._(0, _omitEnumNames ? '' : 'ACTION_UNSPECIFIED');
  static const BindingDelta_Action ADD =
      BindingDelta_Action._(1, _omitEnumNames ? '' : 'ADD');
  static const BindingDelta_Action REMOVE =
      BindingDelta_Action._(2, _omitEnumNames ? '' : 'REMOVE');

  static const $core.List<BindingDelta_Action> values = <BindingDelta_Action>[
    ACTION_UNSPECIFIED,
    ADD,
    REMOVE,
  ];

  static final $core.Map<$core.int, BindingDelta_Action> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static BindingDelta_Action? valueOf($core.int value) => _byValue[value];

  const BindingDelta_Action._($core.int v, $core.String n) : super(v, n);
}

/// The type of action performed on an audit configuration in a policy.
class AuditConfigDelta_Action extends $pb.ProtobufEnum {
  static const AuditConfigDelta_Action ACTION_UNSPECIFIED =
      AuditConfigDelta_Action._(0, _omitEnumNames ? '' : 'ACTION_UNSPECIFIED');
  static const AuditConfigDelta_Action ADD =
      AuditConfigDelta_Action._(1, _omitEnumNames ? '' : 'ADD');
  static const AuditConfigDelta_Action REMOVE =
      AuditConfigDelta_Action._(2, _omitEnumNames ? '' : 'REMOVE');

  static const $core.List<AuditConfigDelta_Action> values =
      <AuditConfigDelta_Action>[
    ACTION_UNSPECIFIED,
    ADD,
    REMOVE,
  ];

  static final $core.Map<$core.int, AuditConfigDelta_Action> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AuditConfigDelta_Action? valueOf($core.int value) => _byValue[value];

  const AuditConfigDelta_Action._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
