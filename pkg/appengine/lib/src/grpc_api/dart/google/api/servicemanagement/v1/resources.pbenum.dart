//
//  Generated code. Do not modify.
//  source: google/api/servicemanagement/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Code describes the status of the operation (or one of its steps).
class OperationMetadata_Status extends $pb.ProtobufEnum {
  static const OperationMetadata_Status STATUS_UNSPECIFIED =
      OperationMetadata_Status._(0, _omitEnumNames ? '' : 'STATUS_UNSPECIFIED');
  static const OperationMetadata_Status DONE =
      OperationMetadata_Status._(1, _omitEnumNames ? '' : 'DONE');
  static const OperationMetadata_Status NOT_STARTED =
      OperationMetadata_Status._(2, _omitEnumNames ? '' : 'NOT_STARTED');
  static const OperationMetadata_Status IN_PROGRESS =
      OperationMetadata_Status._(3, _omitEnumNames ? '' : 'IN_PROGRESS');
  static const OperationMetadata_Status FAILED =
      OperationMetadata_Status._(4, _omitEnumNames ? '' : 'FAILED');
  static const OperationMetadata_Status CANCELLED =
      OperationMetadata_Status._(5, _omitEnumNames ? '' : 'CANCELLED');

  static const $core.List<OperationMetadata_Status> values =
      <OperationMetadata_Status>[
    STATUS_UNSPECIFIED,
    DONE,
    NOT_STARTED,
    IN_PROGRESS,
    FAILED,
    CANCELLED,
  ];

  static final $core.Map<$core.int, OperationMetadata_Status> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static OperationMetadata_Status? valueOf($core.int value) => _byValue[value];

  const OperationMetadata_Status._($core.int v, $core.String n) : super(v, n);
}

/// The kind of diagnostic information possible.
class Diagnostic_Kind extends $pb.ProtobufEnum {
  static const Diagnostic_Kind WARNING =
      Diagnostic_Kind._(0, _omitEnumNames ? '' : 'WARNING');
  static const Diagnostic_Kind ERROR =
      Diagnostic_Kind._(1, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<Diagnostic_Kind> values = <Diagnostic_Kind>[
    WARNING,
    ERROR,
  ];

  static final $core.Map<$core.int, Diagnostic_Kind> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Diagnostic_Kind? valueOf($core.int value) => _byValue[value];

  const Diagnostic_Kind._($core.int v, $core.String n) : super(v, n);
}

class ConfigFile_FileType extends $pb.ProtobufEnum {
  static const ConfigFile_FileType FILE_TYPE_UNSPECIFIED =
      ConfigFile_FileType._(0, _omitEnumNames ? '' : 'FILE_TYPE_UNSPECIFIED');
  static const ConfigFile_FileType SERVICE_CONFIG_YAML =
      ConfigFile_FileType._(1, _omitEnumNames ? '' : 'SERVICE_CONFIG_YAML');
  static const ConfigFile_FileType OPEN_API_JSON =
      ConfigFile_FileType._(2, _omitEnumNames ? '' : 'OPEN_API_JSON');
  static const ConfigFile_FileType OPEN_API_YAML =
      ConfigFile_FileType._(3, _omitEnumNames ? '' : 'OPEN_API_YAML');
  static const ConfigFile_FileType FILE_DESCRIPTOR_SET_PROTO =
      ConfigFile_FileType._(
          4, _omitEnumNames ? '' : 'FILE_DESCRIPTOR_SET_PROTO');
  static const ConfigFile_FileType PROTO_FILE =
      ConfigFile_FileType._(6, _omitEnumNames ? '' : 'PROTO_FILE');

  static const $core.List<ConfigFile_FileType> values = <ConfigFile_FileType>[
    FILE_TYPE_UNSPECIFIED,
    SERVICE_CONFIG_YAML,
    OPEN_API_JSON,
    OPEN_API_YAML,
    FILE_DESCRIPTOR_SET_PROTO,
    PROTO_FILE,
  ];

  static final $core.Map<$core.int, ConfigFile_FileType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ConfigFile_FileType? valueOf($core.int value) => _byValue[value];

  const ConfigFile_FileType._($core.int v, $core.String n) : super(v, n);
}

/// Status of a Rollout.
class Rollout_RolloutStatus extends $pb.ProtobufEnum {
  static const Rollout_RolloutStatus ROLLOUT_STATUS_UNSPECIFIED =
      Rollout_RolloutStatus._(
          0, _omitEnumNames ? '' : 'ROLLOUT_STATUS_UNSPECIFIED');
  static const Rollout_RolloutStatus IN_PROGRESS =
      Rollout_RolloutStatus._(1, _omitEnumNames ? '' : 'IN_PROGRESS');
  static const Rollout_RolloutStatus SUCCESS =
      Rollout_RolloutStatus._(2, _omitEnumNames ? '' : 'SUCCESS');
  static const Rollout_RolloutStatus CANCELLED =
      Rollout_RolloutStatus._(3, _omitEnumNames ? '' : 'CANCELLED');
  static const Rollout_RolloutStatus FAILED =
      Rollout_RolloutStatus._(4, _omitEnumNames ? '' : 'FAILED');
  static const Rollout_RolloutStatus PENDING =
      Rollout_RolloutStatus._(5, _omitEnumNames ? '' : 'PENDING');
  static const Rollout_RolloutStatus FAILED_ROLLED_BACK =
      Rollout_RolloutStatus._(6, _omitEnumNames ? '' : 'FAILED_ROLLED_BACK');

  static const $core.List<Rollout_RolloutStatus> values =
      <Rollout_RolloutStatus>[
    ROLLOUT_STATUS_UNSPECIFIED,
    IN_PROGRESS,
    SUCCESS,
    CANCELLED,
    FAILED,
    PENDING,
    FAILED_ROLLED_BACK,
  ];

  static final $core.Map<$core.int, Rollout_RolloutStatus> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Rollout_RolloutStatus? valueOf($core.int value) => _byValue[value];

  const Rollout_RolloutStatus._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
