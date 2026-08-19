//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enumerations of quota safety checks.
class QuotaSafetyCheck extends $pb.ProtobufEnum {
  static const QuotaSafetyCheck QUOTA_SAFETY_CHECK_UNSPECIFIED =
      QuotaSafetyCheck._(
          0, _omitEnumNames ? '' : 'QUOTA_SAFETY_CHECK_UNSPECIFIED');
  static const QuotaSafetyCheck QUOTA_DECREASE_BELOW_USAGE =
      QuotaSafetyCheck._(1, _omitEnumNames ? '' : 'QUOTA_DECREASE_BELOW_USAGE');
  static const QuotaSafetyCheck QUOTA_DECREASE_PERCENTAGE_TOO_HIGH =
      QuotaSafetyCheck._(
          2, _omitEnumNames ? '' : 'QUOTA_DECREASE_PERCENTAGE_TOO_HIGH');

  static const $core.List<QuotaSafetyCheck> values = <QuotaSafetyCheck>[
    QUOTA_SAFETY_CHECK_UNSPECIFIED,
    QUOTA_DECREASE_BELOW_USAGE,
    QUOTA_DECREASE_PERCENTAGE_TOO_HIGH,
  ];

  static final $core.Map<$core.int, QuotaSafetyCheck> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaSafetyCheck? valueOf($core.int value) => _byValue[value];

  const QuotaSafetyCheck._($core.int v, $core.String n) : super(v, n);
}

/// The enumeration of the types of a cloud resource container.
class QuotaInfo_ContainerType extends $pb.ProtobufEnum {
  static const QuotaInfo_ContainerType CONTAINER_TYPE_UNSPECIFIED =
      QuotaInfo_ContainerType._(
          0, _omitEnumNames ? '' : 'CONTAINER_TYPE_UNSPECIFIED');
  static const QuotaInfo_ContainerType PROJECT =
      QuotaInfo_ContainerType._(1, _omitEnumNames ? '' : 'PROJECT');
  static const QuotaInfo_ContainerType FOLDER =
      QuotaInfo_ContainerType._(2, _omitEnumNames ? '' : 'FOLDER');
  static const QuotaInfo_ContainerType ORGANIZATION =
      QuotaInfo_ContainerType._(3, _omitEnumNames ? '' : 'ORGANIZATION');

  static const $core.List<QuotaInfo_ContainerType> values =
      <QuotaInfo_ContainerType>[
    CONTAINER_TYPE_UNSPECIFIED,
    PROJECT,
    FOLDER,
    ORGANIZATION,
  ];

  static final $core.Map<$core.int, QuotaInfo_ContainerType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaInfo_ContainerType? valueOf($core.int value) => _byValue[value];

  const QuotaInfo_ContainerType._($core.int v, $core.String n) : super(v, n);
}

/// The enumeration of reasons when it is ineligible to request increase
/// adjustment.
class QuotaIncreaseEligibility_IneligibilityReason extends $pb.ProtobufEnum {
  static const QuotaIncreaseEligibility_IneligibilityReason
      INELIGIBILITY_REASON_UNSPECIFIED =
      QuotaIncreaseEligibility_IneligibilityReason._(
          0, _omitEnumNames ? '' : 'INELIGIBILITY_REASON_UNSPECIFIED');
  static const QuotaIncreaseEligibility_IneligibilityReason
      NO_VALID_BILLING_ACCOUNT = QuotaIncreaseEligibility_IneligibilityReason._(
          1, _omitEnumNames ? '' : 'NO_VALID_BILLING_ACCOUNT');
  static const QuotaIncreaseEligibility_IneligibilityReason OTHER =
      QuotaIncreaseEligibility_IneligibilityReason._(
          2, _omitEnumNames ? '' : 'OTHER');

  static const $core.List<QuotaIncreaseEligibility_IneligibilityReason> values =
      <QuotaIncreaseEligibility_IneligibilityReason>[
    INELIGIBILITY_REASON_UNSPECIFIED,
    NO_VALID_BILLING_ACCOUNT,
    OTHER,
  ];

  static final $core
      .Map<$core.int, QuotaIncreaseEligibility_IneligibilityReason> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaIncreaseEligibility_IneligibilityReason? valueOf(
          $core.int value) =>
      _byValue[value];

  const QuotaIncreaseEligibility_IneligibilityReason._(
      $core.int v, $core.String n)
      : super(v, n);
}

/// The enumeration of the origins of quota preference requests.
class QuotaConfig_Origin extends $pb.ProtobufEnum {
  static const QuotaConfig_Origin ORIGIN_UNSPECIFIED =
      QuotaConfig_Origin._(0, _omitEnumNames ? '' : 'ORIGIN_UNSPECIFIED');
  static const QuotaConfig_Origin CLOUD_CONSOLE =
      QuotaConfig_Origin._(1, _omitEnumNames ? '' : 'CLOUD_CONSOLE');
  static const QuotaConfig_Origin AUTO_ADJUSTER =
      QuotaConfig_Origin._(2, _omitEnumNames ? '' : 'AUTO_ADJUSTER');

  static const $core.List<QuotaConfig_Origin> values = <QuotaConfig_Origin>[
    ORIGIN_UNSPECIFIED,
    CLOUD_CONSOLE,
    AUTO_ADJUSTER,
  ];

  static final $core.Map<$core.int, QuotaConfig_Origin> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaConfig_Origin? valueOf($core.int value) => _byValue[value];

  const QuotaConfig_Origin._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
