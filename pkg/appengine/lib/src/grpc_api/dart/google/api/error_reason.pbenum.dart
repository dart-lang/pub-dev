//
//  Generated code. Do not modify.
//  source: google/api/error_reason.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Defines the supported values for `google.rpc.ErrorInfo.reason` for the
/// `googleapis.com` error domain. This error domain is reserved for [Service
/// Infrastructure](https://cloud.google.com/service-infrastructure/docs/overview).
/// For each error info of this domain, the metadata key "service" refers to the
/// logical identifier of an API service, such as "pubsub.googleapis.com". The
/// "consumer" refers to the entity that consumes an API Service. It typically is
/// a Google project that owns the client application or the server resource,
/// such as "projects/123". Other metadata keys are specific to each error
/// reason. For more information, see the definition of the specific error
/// reason.
class ErrorReason extends $pb.ProtobufEnum {
  static const ErrorReason ERROR_REASON_UNSPECIFIED =
      ErrorReason._(0, _omitEnumNames ? '' : 'ERROR_REASON_UNSPECIFIED');
  static const ErrorReason SERVICE_DISABLED =
      ErrorReason._(1, _omitEnumNames ? '' : 'SERVICE_DISABLED');
  static const ErrorReason BILLING_DISABLED =
      ErrorReason._(2, _omitEnumNames ? '' : 'BILLING_DISABLED');
  static const ErrorReason API_KEY_INVALID =
      ErrorReason._(3, _omitEnumNames ? '' : 'API_KEY_INVALID');
  static const ErrorReason API_KEY_SERVICE_BLOCKED =
      ErrorReason._(4, _omitEnumNames ? '' : 'API_KEY_SERVICE_BLOCKED');
  static const ErrorReason API_KEY_HTTP_REFERRER_BLOCKED =
      ErrorReason._(7, _omitEnumNames ? '' : 'API_KEY_HTTP_REFERRER_BLOCKED');
  static const ErrorReason API_KEY_IP_ADDRESS_BLOCKED =
      ErrorReason._(8, _omitEnumNames ? '' : 'API_KEY_IP_ADDRESS_BLOCKED');
  static const ErrorReason API_KEY_ANDROID_APP_BLOCKED =
      ErrorReason._(9, _omitEnumNames ? '' : 'API_KEY_ANDROID_APP_BLOCKED');
  static const ErrorReason API_KEY_IOS_APP_BLOCKED =
      ErrorReason._(13, _omitEnumNames ? '' : 'API_KEY_IOS_APP_BLOCKED');
  static const ErrorReason RATE_LIMIT_EXCEEDED =
      ErrorReason._(5, _omitEnumNames ? '' : 'RATE_LIMIT_EXCEEDED');
  static const ErrorReason RESOURCE_QUOTA_EXCEEDED =
      ErrorReason._(6, _omitEnumNames ? '' : 'RESOURCE_QUOTA_EXCEEDED');
  static const ErrorReason LOCATION_TAX_POLICY_VIOLATED =
      ErrorReason._(10, _omitEnumNames ? '' : 'LOCATION_TAX_POLICY_VIOLATED');
  static const ErrorReason USER_PROJECT_DENIED =
      ErrorReason._(11, _omitEnumNames ? '' : 'USER_PROJECT_DENIED');
  static const ErrorReason CONSUMER_SUSPENDED =
      ErrorReason._(12, _omitEnumNames ? '' : 'CONSUMER_SUSPENDED');
  static const ErrorReason CONSUMER_INVALID =
      ErrorReason._(14, _omitEnumNames ? '' : 'CONSUMER_INVALID');
  static const ErrorReason SECURITY_POLICY_VIOLATED =
      ErrorReason._(15, _omitEnumNames ? '' : 'SECURITY_POLICY_VIOLATED');
  static const ErrorReason ACCESS_TOKEN_EXPIRED =
      ErrorReason._(16, _omitEnumNames ? '' : 'ACCESS_TOKEN_EXPIRED');
  static const ErrorReason ACCESS_TOKEN_SCOPE_INSUFFICIENT = ErrorReason._(
      17, _omitEnumNames ? '' : 'ACCESS_TOKEN_SCOPE_INSUFFICIENT');
  static const ErrorReason ACCOUNT_STATE_INVALID =
      ErrorReason._(18, _omitEnumNames ? '' : 'ACCOUNT_STATE_INVALID');
  static const ErrorReason ACCESS_TOKEN_TYPE_UNSUPPORTED =
      ErrorReason._(19, _omitEnumNames ? '' : 'ACCESS_TOKEN_TYPE_UNSUPPORTED');
  static const ErrorReason CREDENTIALS_MISSING =
      ErrorReason._(20, _omitEnumNames ? '' : 'CREDENTIALS_MISSING');
  static const ErrorReason RESOURCE_PROJECT_INVALID =
      ErrorReason._(21, _omitEnumNames ? '' : 'RESOURCE_PROJECT_INVALID');
  static const ErrorReason SESSION_COOKIE_INVALID =
      ErrorReason._(23, _omitEnumNames ? '' : 'SESSION_COOKIE_INVALID');
  static const ErrorReason USER_BLOCKED_BY_ADMIN =
      ErrorReason._(24, _omitEnumNames ? '' : 'USER_BLOCKED_BY_ADMIN');
  static const ErrorReason RESOURCE_USAGE_RESTRICTION_VIOLATED = ErrorReason._(
      25, _omitEnumNames ? '' : 'RESOURCE_USAGE_RESTRICTION_VIOLATED');
  static const ErrorReason SYSTEM_PARAMETER_UNSUPPORTED =
      ErrorReason._(26, _omitEnumNames ? '' : 'SYSTEM_PARAMETER_UNSUPPORTED');
  static const ErrorReason ORG_RESTRICTION_VIOLATION =
      ErrorReason._(27, _omitEnumNames ? '' : 'ORG_RESTRICTION_VIOLATION');
  static const ErrorReason ORG_RESTRICTION_HEADER_INVALID =
      ErrorReason._(28, _omitEnumNames ? '' : 'ORG_RESTRICTION_HEADER_INVALID');
  static const ErrorReason SERVICE_NOT_VISIBLE =
      ErrorReason._(29, _omitEnumNames ? '' : 'SERVICE_NOT_VISIBLE');
  static const ErrorReason GCP_SUSPENDED =
      ErrorReason._(30, _omitEnumNames ? '' : 'GCP_SUSPENDED');
  static const ErrorReason LOCATION_POLICY_VIOLATED =
      ErrorReason._(31, _omitEnumNames ? '' : 'LOCATION_POLICY_VIOLATED');

  static const $core.List<ErrorReason> values = <ErrorReason>[
    ERROR_REASON_UNSPECIFIED,
    SERVICE_DISABLED,
    BILLING_DISABLED,
    API_KEY_INVALID,
    API_KEY_SERVICE_BLOCKED,
    API_KEY_HTTP_REFERRER_BLOCKED,
    API_KEY_IP_ADDRESS_BLOCKED,
    API_KEY_ANDROID_APP_BLOCKED,
    API_KEY_IOS_APP_BLOCKED,
    RATE_LIMIT_EXCEEDED,
    RESOURCE_QUOTA_EXCEEDED,
    LOCATION_TAX_POLICY_VIOLATED,
    USER_PROJECT_DENIED,
    CONSUMER_SUSPENDED,
    CONSUMER_INVALID,
    SECURITY_POLICY_VIOLATED,
    ACCESS_TOKEN_EXPIRED,
    ACCESS_TOKEN_SCOPE_INSUFFICIENT,
    ACCOUNT_STATE_INVALID,
    ACCESS_TOKEN_TYPE_UNSUPPORTED,
    CREDENTIALS_MISSING,
    RESOURCE_PROJECT_INVALID,
    SESSION_COOKIE_INVALID,
    USER_BLOCKED_BY_ADMIN,
    RESOURCE_USAGE_RESTRICTION_VIOLATED,
    SYSTEM_PARAMETER_UNSUPPORTED,
    ORG_RESTRICTION_VIOLATION,
    ORG_RESTRICTION_HEADER_INVALID,
    SERVICE_NOT_VISIBLE,
    GCP_SUSPENDED,
    LOCATION_POLICY_VIOLATED,
  ];

  static final $core.Map<$core.int, ErrorReason> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ErrorReason? valueOf($core.int value) => _byValue[value];

  const ErrorReason._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
