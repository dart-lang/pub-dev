//
//  Generated code. Do not modify.
//  source: google/datastore/admin/v1/migration.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// States for a migration.
class MigrationState extends $pb.ProtobufEnum {
  static const MigrationState MIGRATION_STATE_UNSPECIFIED =
      MigrationState._(0, _omitEnumNames ? '' : 'MIGRATION_STATE_UNSPECIFIED');
  static const MigrationState RUNNING =
      MigrationState._(1, _omitEnumNames ? '' : 'RUNNING');
  static const MigrationState PAUSED =
      MigrationState._(2, _omitEnumNames ? '' : 'PAUSED');
  static const MigrationState COMPLETE =
      MigrationState._(3, _omitEnumNames ? '' : 'COMPLETE');

  static const $core.List<MigrationState> values = <MigrationState>[
    MIGRATION_STATE_UNSPECIFIED,
    RUNNING,
    PAUSED,
    COMPLETE,
  ];

  static final $core.Map<$core.int, MigrationState> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MigrationState? valueOf($core.int value) => _byValue[value];

  const MigrationState._($core.int v, $core.String n) : super(v, n);
}

/// Steps in a migration.
class MigrationStep extends $pb.ProtobufEnum {
  static const MigrationStep MIGRATION_STEP_UNSPECIFIED =
      MigrationStep._(0, _omitEnumNames ? '' : 'MIGRATION_STEP_UNSPECIFIED');
  static const MigrationStep PREPARE =
      MigrationStep._(6, _omitEnumNames ? '' : 'PREPARE');
  static const MigrationStep START =
      MigrationStep._(1, _omitEnumNames ? '' : 'START');
  static const MigrationStep APPLY_WRITES_SYNCHRONOUSLY =
      MigrationStep._(7, _omitEnumNames ? '' : 'APPLY_WRITES_SYNCHRONOUSLY');
  static const MigrationStep COPY_AND_VERIFY =
      MigrationStep._(2, _omitEnumNames ? '' : 'COPY_AND_VERIFY');
  static const MigrationStep REDIRECT_EVENTUALLY_CONSISTENT_READS =
      MigrationStep._(
          3, _omitEnumNames ? '' : 'REDIRECT_EVENTUALLY_CONSISTENT_READS');
  static const MigrationStep REDIRECT_STRONGLY_CONSISTENT_READS =
      MigrationStep._(
          4, _omitEnumNames ? '' : 'REDIRECT_STRONGLY_CONSISTENT_READS');
  static const MigrationStep REDIRECT_WRITES =
      MigrationStep._(5, _omitEnumNames ? '' : 'REDIRECT_WRITES');

  static const $core.List<MigrationStep> values = <MigrationStep>[
    MIGRATION_STEP_UNSPECIFIED,
    PREPARE,
    START,
    APPLY_WRITES_SYNCHRONOUSLY,
    COPY_AND_VERIFY,
    REDIRECT_EVENTUALLY_CONSISTENT_READS,
    REDIRECT_STRONGLY_CONSISTENT_READS,
    REDIRECT_WRITES,
  ];

  static final $core.Map<$core.int, MigrationStep> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MigrationStep? valueOf($core.int value) => _byValue[value];

  const MigrationStep._($core.int v, $core.String n) : super(v, n);
}

/// Concurrency modes for transactions in Cloud Firestore.
class MigrationProgressEvent_ConcurrencyMode extends $pb.ProtobufEnum {
  static const MigrationProgressEvent_ConcurrencyMode
      CONCURRENCY_MODE_UNSPECIFIED = MigrationProgressEvent_ConcurrencyMode._(
          0, _omitEnumNames ? '' : 'CONCURRENCY_MODE_UNSPECIFIED');
  static const MigrationProgressEvent_ConcurrencyMode PESSIMISTIC =
      MigrationProgressEvent_ConcurrencyMode._(
          1, _omitEnumNames ? '' : 'PESSIMISTIC');
  static const MigrationProgressEvent_ConcurrencyMode OPTIMISTIC =
      MigrationProgressEvent_ConcurrencyMode._(
          2, _omitEnumNames ? '' : 'OPTIMISTIC');
  static const MigrationProgressEvent_ConcurrencyMode
      OPTIMISTIC_WITH_ENTITY_GROUPS = MigrationProgressEvent_ConcurrencyMode._(
          3, _omitEnumNames ? '' : 'OPTIMISTIC_WITH_ENTITY_GROUPS');

  static const $core.List<MigrationProgressEvent_ConcurrencyMode> values =
      <MigrationProgressEvent_ConcurrencyMode>[
    CONCURRENCY_MODE_UNSPECIFIED,
    PESSIMISTIC,
    OPTIMISTIC,
    OPTIMISTIC_WITH_ENTITY_GROUPS,
  ];

  static final $core.Map<$core.int, MigrationProgressEvent_ConcurrencyMode>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static MigrationProgressEvent_ConcurrencyMode? valueOf($core.int value) =>
      _byValue[value];

  const MigrationProgressEvent_ConcurrencyMode._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
