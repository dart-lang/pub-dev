//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/quota_controller.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Supported quota modes.
class QuotaOperation_QuotaMode extends $pb.ProtobufEnum {
  static const QuotaOperation_QuotaMode UNSPECIFIED =
      QuotaOperation_QuotaMode._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const QuotaOperation_QuotaMode NORMAL =
      QuotaOperation_QuotaMode._(1, _omitEnumNames ? '' : 'NORMAL');
  static const QuotaOperation_QuotaMode BEST_EFFORT =
      QuotaOperation_QuotaMode._(2, _omitEnumNames ? '' : 'BEST_EFFORT');
  static const QuotaOperation_QuotaMode CHECK_ONLY =
      QuotaOperation_QuotaMode._(3, _omitEnumNames ? '' : 'CHECK_ONLY');
  static const QuotaOperation_QuotaMode QUERY_ONLY =
      QuotaOperation_QuotaMode._(4, _omitEnumNames ? '' : 'QUERY_ONLY');
  static const QuotaOperation_QuotaMode ADJUST_ONLY =
      QuotaOperation_QuotaMode._(5, _omitEnumNames ? '' : 'ADJUST_ONLY');

  static const $core.List<QuotaOperation_QuotaMode> values =
      <QuotaOperation_QuotaMode>[
    UNSPECIFIED,
    NORMAL,
    BEST_EFFORT,
    CHECK_ONLY,
    QUERY_ONLY,
    ADJUST_ONLY,
  ];

  static final $core.Map<$core.int, QuotaOperation_QuotaMode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaOperation_QuotaMode? valueOf($core.int value) => _byValue[value];

  const QuotaOperation_QuotaMode._($core.int v, $core.String n) : super(v, n);
}

/// Error codes related to project config validations are deprecated since the
/// quota controller methods do not perform these validations. Instead services
/// have to call the Check method, without quota_properties field, to perform
/// these validations before calling the quota controller methods. These
/// methods check only for project deletion to be wipe out compliant.
class QuotaError_Code extends $pb.ProtobufEnum {
  static const QuotaError_Code UNSPECIFIED =
      QuotaError_Code._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const QuotaError_Code RESOURCE_EXHAUSTED =
      QuotaError_Code._(8, _omitEnumNames ? '' : 'RESOURCE_EXHAUSTED');
  static const QuotaError_Code BILLING_NOT_ACTIVE =
      QuotaError_Code._(107, _omitEnumNames ? '' : 'BILLING_NOT_ACTIVE');
  static const QuotaError_Code PROJECT_DELETED =
      QuotaError_Code._(108, _omitEnumNames ? '' : 'PROJECT_DELETED');
  static const QuotaError_Code API_KEY_INVALID =
      QuotaError_Code._(105, _omitEnumNames ? '' : 'API_KEY_INVALID');
  static const QuotaError_Code API_KEY_EXPIRED =
      QuotaError_Code._(112, _omitEnumNames ? '' : 'API_KEY_EXPIRED');

  static const $core.List<QuotaError_Code> values = <QuotaError_Code>[
    UNSPECIFIED,
    RESOURCE_EXHAUSTED,
    BILLING_NOT_ACTIVE,
    PROJECT_DELETED,
    API_KEY_INVALID,
    API_KEY_EXPIRED,
  ];

  static final $core.Map<$core.int, QuotaError_Code> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaError_Code? valueOf($core.int value) => _byValue[value];

  const QuotaError_Code._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
