///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_resources_pbenum;

import 'package:protobuf/protobuf.dart';

class OperationMetadata_Status extends ProtobufEnum {
  static const OperationMetadata_Status STATUS_UNSPECIFIED = const OperationMetadata_Status._(0, 'STATUS_UNSPECIFIED');
  static const OperationMetadata_Status DONE = const OperationMetadata_Status._(1, 'DONE');
  static const OperationMetadata_Status NOT_STARTED = const OperationMetadata_Status._(2, 'NOT_STARTED');
  static const OperationMetadata_Status IN_PROGRESS = const OperationMetadata_Status._(3, 'IN_PROGRESS');
  static const OperationMetadata_Status FAILED = const OperationMetadata_Status._(4, 'FAILED');
  static const OperationMetadata_Status CANCELLED = const OperationMetadata_Status._(5, 'CANCELLED');

  static const List<OperationMetadata_Status> values = const <OperationMetadata_Status> [
    STATUS_UNSPECIFIED,
    DONE,
    NOT_STARTED,
    IN_PROGRESS,
    FAILED,
    CANCELLED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static OperationMetadata_Status valueOf(int value) => _byValue[value] as OperationMetadata_Status;
  static void $checkItem(OperationMetadata_Status v) {
    if (v is !OperationMetadata_Status) checkItemFailed(v, 'OperationMetadata_Status');
  }

  const OperationMetadata_Status._(int v, String n) : super(v, n);
}

class Diagnostic_Kind extends ProtobufEnum {
  static const Diagnostic_Kind WARNING = const Diagnostic_Kind._(0, 'WARNING');
  static const Diagnostic_Kind ERROR = const Diagnostic_Kind._(1, 'ERROR');

  static const List<Diagnostic_Kind> values = const <Diagnostic_Kind> [
    WARNING,
    ERROR,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Diagnostic_Kind valueOf(int value) => _byValue[value] as Diagnostic_Kind;
  static void $checkItem(Diagnostic_Kind v) {
    if (v is !Diagnostic_Kind) checkItemFailed(v, 'Diagnostic_Kind');
  }

  const Diagnostic_Kind._(int v, String n) : super(v, n);
}

class ConfigFile_FileType extends ProtobufEnum {
  static const ConfigFile_FileType FILE_TYPE_UNSPECIFIED = const ConfigFile_FileType._(0, 'FILE_TYPE_UNSPECIFIED');
  static const ConfigFile_FileType SERVICE_CONFIG_YAML = const ConfigFile_FileType._(1, 'SERVICE_CONFIG_YAML');
  static const ConfigFile_FileType OPEN_API_JSON = const ConfigFile_FileType._(2, 'OPEN_API_JSON');
  static const ConfigFile_FileType OPEN_API_YAML = const ConfigFile_FileType._(3, 'OPEN_API_YAML');
  static const ConfigFile_FileType FILE_DESCRIPTOR_SET_PROTO = const ConfigFile_FileType._(4, 'FILE_DESCRIPTOR_SET_PROTO');

  static const List<ConfigFile_FileType> values = const <ConfigFile_FileType> [
    FILE_TYPE_UNSPECIFIED,
    SERVICE_CONFIG_YAML,
    OPEN_API_JSON,
    OPEN_API_YAML,
    FILE_DESCRIPTOR_SET_PROTO,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ConfigFile_FileType valueOf(int value) => _byValue[value] as ConfigFile_FileType;
  static void $checkItem(ConfigFile_FileType v) {
    if (v is !ConfigFile_FileType) checkItemFailed(v, 'ConfigFile_FileType');
  }

  const ConfigFile_FileType._(int v, String n) : super(v, n);
}

class Rollout_RolloutStatus extends ProtobufEnum {
  static const Rollout_RolloutStatus ROLLOUT_STATUS_UNSPECIFIED = const Rollout_RolloutStatus._(0, 'ROLLOUT_STATUS_UNSPECIFIED');
  static const Rollout_RolloutStatus IN_PROGRESS = const Rollout_RolloutStatus._(1, 'IN_PROGRESS');
  static const Rollout_RolloutStatus SUCCESS = const Rollout_RolloutStatus._(2, 'SUCCESS');
  static const Rollout_RolloutStatus CANCELLED = const Rollout_RolloutStatus._(3, 'CANCELLED');
  static const Rollout_RolloutStatus FAILED = const Rollout_RolloutStatus._(4, 'FAILED');
  static const Rollout_RolloutStatus PENDING = const Rollout_RolloutStatus._(5, 'PENDING');

  static const List<Rollout_RolloutStatus> values = const <Rollout_RolloutStatus> [
    ROLLOUT_STATUS_UNSPECIFIED,
    IN_PROGRESS,
    SUCCESS,
    CANCELLED,
    FAILED,
    PENDING,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static Rollout_RolloutStatus valueOf(int value) => _byValue[value] as Rollout_RolloutStatus;
  static void $checkItem(Rollout_RolloutStatus v) {
    if (v is !Rollout_RolloutStatus) checkItemFailed(v, 'Rollout_RolloutStatus');
  }

  const Rollout_RolloutStatus._(int v, String n) : super(v, n);
}

