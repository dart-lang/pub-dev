//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1beta1/datastore_admin.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Operation types.
class OperationType extends $pb.ProtobufEnum {
  static const OperationType OPERATION_TYPE_UNSPECIFIED =
      OperationType._(0, _omitEnumNames ? '' : 'OPERATION_TYPE_UNSPECIFIED');
  static const OperationType EXPORT_ENTITIES =
      OperationType._(1, _omitEnumNames ? '' : 'EXPORT_ENTITIES');
  static const OperationType IMPORT_ENTITIES =
      OperationType._(2, _omitEnumNames ? '' : 'IMPORT_ENTITIES');

  static const $core.List<OperationType> values = <OperationType>[
    OPERATION_TYPE_UNSPECIFIED,
    EXPORT_ENTITIES,
    IMPORT_ENTITIES,
  ];

  static final $core.Map<$core.int, OperationType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static OperationType? valueOf($core.int value) => _byValue[value];

  const OperationType._($core.int v, $core.String n) : super(v, n);
}

/// The various possible states for an ongoing Operation.
class CommonMetadata_State extends $pb.ProtobufEnum {
  static const CommonMetadata_State STATE_UNSPECIFIED =
      CommonMetadata_State._(0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');
  static const CommonMetadata_State INITIALIZING =
      CommonMetadata_State._(1, _omitEnumNames ? '' : 'INITIALIZING');
  static const CommonMetadata_State PROCESSING =
      CommonMetadata_State._(2, _omitEnumNames ? '' : 'PROCESSING');
  static const CommonMetadata_State CANCELLING =
      CommonMetadata_State._(3, _omitEnumNames ? '' : 'CANCELLING');
  static const CommonMetadata_State FINALIZING =
      CommonMetadata_State._(4, _omitEnumNames ? '' : 'FINALIZING');
  static const CommonMetadata_State SUCCESSFUL =
      CommonMetadata_State._(5, _omitEnumNames ? '' : 'SUCCESSFUL');
  static const CommonMetadata_State FAILED =
      CommonMetadata_State._(6, _omitEnumNames ? '' : 'FAILED');
  static const CommonMetadata_State CANCELLED =
      CommonMetadata_State._(7, _omitEnumNames ? '' : 'CANCELLED');

  static const $core.List<CommonMetadata_State> values = <CommonMetadata_State>[
    STATE_UNSPECIFIED,
    INITIALIZING,
    PROCESSING,
    CANCELLING,
    FINALIZING,
    SUCCESSFUL,
    FAILED,
    CANCELLED,
  ];

  static final $core.Map<$core.int, CommonMetadata_State> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static CommonMetadata_State? valueOf($core.int value) => _byValue[value];

  const CommonMetadata_State._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
