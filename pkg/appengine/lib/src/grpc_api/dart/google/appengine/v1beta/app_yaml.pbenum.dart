//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/app_yaml.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Actions to take when the user is not logged in.
class AuthFailAction extends $pb.ProtobufEnum {
  static const AuthFailAction AUTH_FAIL_ACTION_UNSPECIFIED =
      AuthFailAction._(0, _omitEnumNames ? '' : 'AUTH_FAIL_ACTION_UNSPECIFIED');
  static const AuthFailAction AUTH_FAIL_ACTION_REDIRECT =
      AuthFailAction._(1, _omitEnumNames ? '' : 'AUTH_FAIL_ACTION_REDIRECT');
  static const AuthFailAction AUTH_FAIL_ACTION_UNAUTHORIZED = AuthFailAction._(
      2, _omitEnumNames ? '' : 'AUTH_FAIL_ACTION_UNAUTHORIZED');

  static const $core.List<AuthFailAction> values = <AuthFailAction>[
    AUTH_FAIL_ACTION_UNSPECIFIED,
    AUTH_FAIL_ACTION_REDIRECT,
    AUTH_FAIL_ACTION_UNAUTHORIZED,
  ];

  static final $core.Map<$core.int, AuthFailAction> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AuthFailAction? valueOf($core.int value) => _byValue[value];

  const AuthFailAction._($core.int v, $core.String n) : super(v, n);
}

/// Methods to restrict access to a URL based on login status.
class LoginRequirement extends $pb.ProtobufEnum {
  static const LoginRequirement LOGIN_UNSPECIFIED =
      LoginRequirement._(0, _omitEnumNames ? '' : 'LOGIN_UNSPECIFIED');
  static const LoginRequirement LOGIN_OPTIONAL =
      LoginRequirement._(1, _omitEnumNames ? '' : 'LOGIN_OPTIONAL');
  static const LoginRequirement LOGIN_ADMIN =
      LoginRequirement._(2, _omitEnumNames ? '' : 'LOGIN_ADMIN');
  static const LoginRequirement LOGIN_REQUIRED =
      LoginRequirement._(3, _omitEnumNames ? '' : 'LOGIN_REQUIRED');

  static const $core.List<LoginRequirement> values = <LoginRequirement>[
    LOGIN_UNSPECIFIED,
    LOGIN_OPTIONAL,
    LOGIN_ADMIN,
    LOGIN_REQUIRED,
  ];

  static final $core.Map<$core.int, LoginRequirement> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LoginRequirement? valueOf($core.int value) => _byValue[value];

  const LoginRequirement._($core.int v, $core.String n) : super(v, n);
}

/// Methods to enforce security (HTTPS) on a URL.
class SecurityLevel extends $pb.ProtobufEnum {
  static const SecurityLevel SECURE_UNSPECIFIED =
      SecurityLevel._(0, _omitEnumNames ? '' : 'SECURE_UNSPECIFIED');
  static const SecurityLevel SECURE_NEVER =
      SecurityLevel._(1, _omitEnumNames ? '' : 'SECURE_NEVER');
  static const SecurityLevel SECURE_OPTIONAL =
      SecurityLevel._(2, _omitEnumNames ? '' : 'SECURE_OPTIONAL');
  static const SecurityLevel SECURE_ALWAYS =
      SecurityLevel._(3, _omitEnumNames ? '' : 'SECURE_ALWAYS');

  static const SecurityLevel SECURE_DEFAULT = SECURE_UNSPECIFIED;

  static const $core.List<SecurityLevel> values = <SecurityLevel>[
    SECURE_UNSPECIFIED,
    SECURE_NEVER,
    SECURE_OPTIONAL,
    SECURE_ALWAYS,
  ];

  static final $core.Map<$core.int, SecurityLevel> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static SecurityLevel? valueOf($core.int value) => _byValue[value];

  const SecurityLevel._($core.int v, $core.String n) : super(v, n);
}

/// Error codes.
class ErrorHandler_ErrorCode extends $pb.ProtobufEnum {
  static const ErrorHandler_ErrorCode ERROR_CODE_UNSPECIFIED =
      ErrorHandler_ErrorCode._(
          0, _omitEnumNames ? '' : 'ERROR_CODE_UNSPECIFIED');
  static const ErrorHandler_ErrorCode ERROR_CODE_OVER_QUOTA =
      ErrorHandler_ErrorCode._(
          1, _omitEnumNames ? '' : 'ERROR_CODE_OVER_QUOTA');
  static const ErrorHandler_ErrorCode ERROR_CODE_DOS_API_DENIAL =
      ErrorHandler_ErrorCode._(
          2, _omitEnumNames ? '' : 'ERROR_CODE_DOS_API_DENIAL');
  static const ErrorHandler_ErrorCode ERROR_CODE_TIMEOUT =
      ErrorHandler_ErrorCode._(3, _omitEnumNames ? '' : 'ERROR_CODE_TIMEOUT');

  static const ErrorHandler_ErrorCode ERROR_CODE_DEFAULT =
      ERROR_CODE_UNSPECIFIED;

  static const $core.List<ErrorHandler_ErrorCode> values =
      <ErrorHandler_ErrorCode>[
    ERROR_CODE_UNSPECIFIED,
    ERROR_CODE_OVER_QUOTA,
    ERROR_CODE_DOS_API_DENIAL,
    ERROR_CODE_TIMEOUT,
  ];

  static final $core.Map<$core.int, ErrorHandler_ErrorCode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ErrorHandler_ErrorCode? valueOf($core.int value) => _byValue[value];

  const ErrorHandler_ErrorCode._($core.int v, $core.String n) : super(v, n);
}

/// Redirect codes.
class UrlMap_RedirectHttpResponseCode extends $pb.ProtobufEnum {
  static const UrlMap_RedirectHttpResponseCode
      REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED =
      UrlMap_RedirectHttpResponseCode._(
          0, _omitEnumNames ? '' : 'REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_301 =
      UrlMap_RedirectHttpResponseCode._(
          1, _omitEnumNames ? '' : 'REDIRECT_HTTP_RESPONSE_CODE_301');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_302 =
      UrlMap_RedirectHttpResponseCode._(
          2, _omitEnumNames ? '' : 'REDIRECT_HTTP_RESPONSE_CODE_302');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_303 =
      UrlMap_RedirectHttpResponseCode._(
          3, _omitEnumNames ? '' : 'REDIRECT_HTTP_RESPONSE_CODE_303');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_307 =
      UrlMap_RedirectHttpResponseCode._(
          4, _omitEnumNames ? '' : 'REDIRECT_HTTP_RESPONSE_CODE_307');

  static const $core.List<UrlMap_RedirectHttpResponseCode> values =
      <UrlMap_RedirectHttpResponseCode>[
    REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED,
    REDIRECT_HTTP_RESPONSE_CODE_301,
    REDIRECT_HTTP_RESPONSE_CODE_302,
    REDIRECT_HTTP_RESPONSE_CODE_303,
    REDIRECT_HTTP_RESPONSE_CODE_307,
  ];

  static final $core.Map<$core.int, UrlMap_RedirectHttpResponseCode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static UrlMap_RedirectHttpResponseCode? valueOf($core.int value) =>
      _byValue[value];

  const UrlMap_RedirectHttpResponseCode._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
