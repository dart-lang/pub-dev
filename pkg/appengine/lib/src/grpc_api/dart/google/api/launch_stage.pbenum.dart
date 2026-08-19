//
//  Generated code. Do not modify.
//  source: google/api/launch_stage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The launch stage as defined by [Google Cloud Platform
/// Launch Stages](https://cloud.google.com/terms/launch-stages).
class LaunchStage extends $pb.ProtobufEnum {
  static const LaunchStage LAUNCH_STAGE_UNSPECIFIED =
      LaunchStage._(0, _omitEnumNames ? '' : 'LAUNCH_STAGE_UNSPECIFIED');
  static const LaunchStage UNIMPLEMENTED =
      LaunchStage._(6, _omitEnumNames ? '' : 'UNIMPLEMENTED');
  static const LaunchStage PRELAUNCH =
      LaunchStage._(7, _omitEnumNames ? '' : 'PRELAUNCH');
  static const LaunchStage EARLY_ACCESS =
      LaunchStage._(1, _omitEnumNames ? '' : 'EARLY_ACCESS');
  static const LaunchStage ALPHA =
      LaunchStage._(2, _omitEnumNames ? '' : 'ALPHA');
  static const LaunchStage BETA =
      LaunchStage._(3, _omitEnumNames ? '' : 'BETA');
  static const LaunchStage GA = LaunchStage._(4, _omitEnumNames ? '' : 'GA');
  static const LaunchStage DEPRECATED =
      LaunchStage._(5, _omitEnumNames ? '' : 'DEPRECATED');

  static const $core.List<LaunchStage> values = <LaunchStage>[
    LAUNCH_STAGE_UNSPECIFIED,
    UNIMPLEMENTED,
    PRELAUNCH,
    EARLY_ACCESS,
    ALPHA,
    BETA,
    GA,
    DEPRECATED,
  ];

  static final $core.Map<$core.int, LaunchStage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LaunchStage? valueOf($core.int value) => _byValue[value];

  const LaunchStage._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
