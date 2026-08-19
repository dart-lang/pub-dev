//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_config.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// List of different operation states.
/// High level state of the operation. This is used to report the job's
/// current state to the user. Once a long running operation is created,
/// the current state of the operation can be queried even before the
/// operation is finished and the final result is available.
class OperationState extends $pb.ProtobufEnum {
  static const OperationState OPERATION_STATE_UNSPECIFIED =
      OperationState._(0, _omitEnumNames ? '' : 'OPERATION_STATE_UNSPECIFIED');
  static const OperationState OPERATION_STATE_SCHEDULED =
      OperationState._(1, _omitEnumNames ? '' : 'OPERATION_STATE_SCHEDULED');
  static const OperationState OPERATION_STATE_WAITING_FOR_PERMISSIONS =
      OperationState._(
          2, _omitEnumNames ? '' : 'OPERATION_STATE_WAITING_FOR_PERMISSIONS');
  static const OperationState OPERATION_STATE_RUNNING =
      OperationState._(3, _omitEnumNames ? '' : 'OPERATION_STATE_RUNNING');
  static const OperationState OPERATION_STATE_SUCCEEDED =
      OperationState._(4, _omitEnumNames ? '' : 'OPERATION_STATE_SUCCEEDED');
  static const OperationState OPERATION_STATE_FAILED =
      OperationState._(5, _omitEnumNames ? '' : 'OPERATION_STATE_FAILED');
  static const OperationState OPERATION_STATE_CANCELLED =
      OperationState._(6, _omitEnumNames ? '' : 'OPERATION_STATE_CANCELLED');

  static const $core.List<OperationState> values = <OperationState>[
    OPERATION_STATE_UNSPECIFIED,
    OPERATION_STATE_SCHEDULED,
    OPERATION_STATE_WAITING_FOR_PERMISSIONS,
    OPERATION_STATE_RUNNING,
    OPERATION_STATE_SUCCEEDED,
    OPERATION_STATE_FAILED,
    OPERATION_STATE_CANCELLED,
  ];

  static final $core.Map<$core.int, OperationState> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static OperationState? valueOf($core.int value) => _byValue[value];

  const OperationState._($core.int v, $core.String n) : super(v, n);
}

/// LogBucket lifecycle states.
class LifecycleState extends $pb.ProtobufEnum {
  static const LifecycleState LIFECYCLE_STATE_UNSPECIFIED =
      LifecycleState._(0, _omitEnumNames ? '' : 'LIFECYCLE_STATE_UNSPECIFIED');
  static const LifecycleState ACTIVE =
      LifecycleState._(1, _omitEnumNames ? '' : 'ACTIVE');
  static const LifecycleState DELETE_REQUESTED =
      LifecycleState._(2, _omitEnumNames ? '' : 'DELETE_REQUESTED');
  static const LifecycleState UPDATING =
      LifecycleState._(3, _omitEnumNames ? '' : 'UPDATING');
  static const LifecycleState CREATING =
      LifecycleState._(4, _omitEnumNames ? '' : 'CREATING');
  static const LifecycleState FAILED =
      LifecycleState._(5, _omitEnumNames ? '' : 'FAILED');

  static const $core.List<LifecycleState> values = <LifecycleState>[
    LIFECYCLE_STATE_UNSPECIFIED,
    ACTIVE,
    DELETE_REQUESTED,
    UPDATING,
    CREATING,
    FAILED,
  ];

  static final $core.Map<$core.int, LifecycleState> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LifecycleState? valueOf($core.int value) => _byValue[value];

  const LifecycleState._($core.int v, $core.String n) : super(v, n);
}

/// IndexType is used for custom indexing. It describes the type of an indexed
/// field.
class IndexType extends $pb.ProtobufEnum {
  static const IndexType INDEX_TYPE_UNSPECIFIED =
      IndexType._(0, _omitEnumNames ? '' : 'INDEX_TYPE_UNSPECIFIED');
  static const IndexType INDEX_TYPE_STRING =
      IndexType._(1, _omitEnumNames ? '' : 'INDEX_TYPE_STRING');
  static const IndexType INDEX_TYPE_INTEGER =
      IndexType._(2, _omitEnumNames ? '' : 'INDEX_TYPE_INTEGER');

  static const $core.List<IndexType> values = <IndexType>[
    INDEX_TYPE_UNSPECIFIED,
    INDEX_TYPE_STRING,
    INDEX_TYPE_INTEGER,
  ];

  static final $core.Map<$core.int, IndexType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static IndexType? valueOf($core.int value) => _byValue[value];

  const IndexType._($core.int v, $core.String n) : super(v, n);
}

/// Deprecated. This is unused.
class LogSink_VersionFormat extends $pb.ProtobufEnum {
  static const LogSink_VersionFormat VERSION_FORMAT_UNSPECIFIED =
      LogSink_VersionFormat._(
          0, _omitEnumNames ? '' : 'VERSION_FORMAT_UNSPECIFIED');
  static const LogSink_VersionFormat V2 =
      LogSink_VersionFormat._(1, _omitEnumNames ? '' : 'V2');
  static const LogSink_VersionFormat V1 =
      LogSink_VersionFormat._(2, _omitEnumNames ? '' : 'V1');

  static const $core.List<LogSink_VersionFormat> values =
      <LogSink_VersionFormat>[
    VERSION_FORMAT_UNSPECIFIED,
    V2,
    V1,
  ];

  static final $core.Map<$core.int, LogSink_VersionFormat> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LogSink_VersionFormat? valueOf($core.int value) => _byValue[value];

  const LogSink_VersionFormat._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
