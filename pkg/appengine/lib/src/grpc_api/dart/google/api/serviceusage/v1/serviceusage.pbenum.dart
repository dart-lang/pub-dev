//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/serviceusage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum to determine if service usage should be checked when disabling a
/// service.
class DisableServiceRequest_CheckIfServiceHasUsage extends $pb.ProtobufEnum {
  static const DisableServiceRequest_CheckIfServiceHasUsage
      CHECK_IF_SERVICE_HAS_USAGE_UNSPECIFIED =
      DisableServiceRequest_CheckIfServiceHasUsage._(
          0, _omitEnumNames ? '' : 'CHECK_IF_SERVICE_HAS_USAGE_UNSPECIFIED');
  static const DisableServiceRequest_CheckIfServiceHasUsage SKIP =
      DisableServiceRequest_CheckIfServiceHasUsage._(
          1, _omitEnumNames ? '' : 'SKIP');
  static const DisableServiceRequest_CheckIfServiceHasUsage CHECK =
      DisableServiceRequest_CheckIfServiceHasUsage._(
          2, _omitEnumNames ? '' : 'CHECK');

  static const $core.List<DisableServiceRequest_CheckIfServiceHasUsage> values =
      <DisableServiceRequest_CheckIfServiceHasUsage>[
    CHECK_IF_SERVICE_HAS_USAGE_UNSPECIFIED,
    SKIP,
    CHECK,
  ];

  static final $core
      .Map<$core.int, DisableServiceRequest_CheckIfServiceHasUsage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static DisableServiceRequest_CheckIfServiceHasUsage? valueOf(
          $core.int value) =>
      _byValue[value];

  const DisableServiceRequest_CheckIfServiceHasUsage._(
      $core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
