//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Whether or not a service has been enabled for use by a consumer.
class State extends $pb.ProtobufEnum {
  static const State STATE_UNSPECIFIED =
      State._(0, _omitEnumNames ? '' : 'STATE_UNSPECIFIED');
  static const State DISABLED = State._(1, _omitEnumNames ? '' : 'DISABLED');
  static const State ENABLED = State._(2, _omitEnumNames ? '' : 'ENABLED');

  static const $core.List<State> values = <State>[
    STATE_UNSPECIFIED,
    DISABLED,
    ENABLED,
  ];

  static final $core.Map<$core.int, State> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static State? valueOf($core.int value) => _byValue[value];

  const State._($core.int v, $core.String n) : super(v, n);
}

/// Selected view of quota. Can be used to request more detailed quota
/// information when retrieving quota metrics and limits.
class QuotaView extends $pb.ProtobufEnum {
  static const QuotaView QUOTA_VIEW_UNSPECIFIED =
      QuotaView._(0, _omitEnumNames ? '' : 'QUOTA_VIEW_UNSPECIFIED');
  static const QuotaView BASIC = QuotaView._(1, _omitEnumNames ? '' : 'BASIC');
  static const QuotaView FULL = QuotaView._(2, _omitEnumNames ? '' : 'FULL');

  static const $core.List<QuotaView> values = <QuotaView>[
    QUOTA_VIEW_UNSPECIFIED,
    BASIC,
    FULL,
  ];

  static final $core.Map<$core.int, QuotaView> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaView? valueOf($core.int value) => _byValue[value];

  const QuotaView._($core.int v, $core.String n) : super(v, n);
}

/// Enumerations of quota safety checks.
class QuotaSafetyCheck extends $pb.ProtobufEnum {
  static const QuotaSafetyCheck QUOTA_SAFETY_CHECK_UNSPECIFIED =
      QuotaSafetyCheck._(
          0, _omitEnumNames ? '' : 'QUOTA_SAFETY_CHECK_UNSPECIFIED');
  static const QuotaSafetyCheck LIMIT_DECREASE_BELOW_USAGE =
      QuotaSafetyCheck._(1, _omitEnumNames ? '' : 'LIMIT_DECREASE_BELOW_USAGE');
  static const QuotaSafetyCheck LIMIT_DECREASE_PERCENTAGE_TOO_HIGH =
      QuotaSafetyCheck._(
          2, _omitEnumNames ? '' : 'LIMIT_DECREASE_PERCENTAGE_TOO_HIGH');

  static const $core.List<QuotaSafetyCheck> values = <QuotaSafetyCheck>[
    QUOTA_SAFETY_CHECK_UNSPECIFIED,
    LIMIT_DECREASE_BELOW_USAGE,
    LIMIT_DECREASE_PERCENTAGE_TOO_HIGH,
  ];

  static final $core.Map<$core.int, QuotaSafetyCheck> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static QuotaSafetyCheck? valueOf($core.int value) => _byValue[value];

  const QuotaSafetyCheck._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
