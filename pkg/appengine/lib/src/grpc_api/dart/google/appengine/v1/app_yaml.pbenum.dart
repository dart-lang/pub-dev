///
//  Generated code. Do not modify.
///
library google.appengine.v1_app_yaml_pbenum;

import 'package:protobuf/protobuf.dart';

class AuthFailAction extends ProtobufEnum {
  static const AuthFailAction AUTH_FAIL_ACTION_UNSPECIFIED = const AuthFailAction._(0, 'AUTH_FAIL_ACTION_UNSPECIFIED');
  static const AuthFailAction AUTH_FAIL_ACTION_REDIRECT = const AuthFailAction._(1, 'AUTH_FAIL_ACTION_REDIRECT');
  static const AuthFailAction AUTH_FAIL_ACTION_UNAUTHORIZED = const AuthFailAction._(2, 'AUTH_FAIL_ACTION_UNAUTHORIZED');

  static const List<AuthFailAction> values = const <AuthFailAction> [
    AUTH_FAIL_ACTION_UNSPECIFIED,
    AUTH_FAIL_ACTION_REDIRECT,
    AUTH_FAIL_ACTION_UNAUTHORIZED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static AuthFailAction valueOf(int value) => _byValue[value] as AuthFailAction;
  static void $checkItem(AuthFailAction v) {
    if (v is !AuthFailAction) checkItemFailed(v, 'AuthFailAction');
  }

  const AuthFailAction._(int v, String n) : super(v, n);
}

class LoginRequirement extends ProtobufEnum {
  static const LoginRequirement LOGIN_UNSPECIFIED = const LoginRequirement._(0, 'LOGIN_UNSPECIFIED');
  static const LoginRequirement LOGIN_OPTIONAL = const LoginRequirement._(1, 'LOGIN_OPTIONAL');
  static const LoginRequirement LOGIN_ADMIN = const LoginRequirement._(2, 'LOGIN_ADMIN');
  static const LoginRequirement LOGIN_REQUIRED = const LoginRequirement._(3, 'LOGIN_REQUIRED');

  static const List<LoginRequirement> values = const <LoginRequirement> [
    LOGIN_UNSPECIFIED,
    LOGIN_OPTIONAL,
    LOGIN_ADMIN,
    LOGIN_REQUIRED,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static LoginRequirement valueOf(int value) => _byValue[value] as LoginRequirement;
  static void $checkItem(LoginRequirement v) {
    if (v is !LoginRequirement) checkItemFailed(v, 'LoginRequirement');
  }

  const LoginRequirement._(int v, String n) : super(v, n);
}

class SecurityLevel extends ProtobufEnum {
  static const SecurityLevel SECURE_UNSPECIFIED = const SecurityLevel._(0, 'SECURE_UNSPECIFIED');
  static const SecurityLevel SECURE_NEVER = const SecurityLevel._(1, 'SECURE_NEVER');
  static const SecurityLevel SECURE_OPTIONAL = const SecurityLevel._(2, 'SECURE_OPTIONAL');
  static const SecurityLevel SECURE_ALWAYS = const SecurityLevel._(3, 'SECURE_ALWAYS');

  static const SecurityLevel SECURE_DEFAULT = SECURE_UNSPECIFIED;

  static const List<SecurityLevel> values = const <SecurityLevel> [
    SECURE_UNSPECIFIED,
    SECURE_NEVER,
    SECURE_OPTIONAL,
    SECURE_ALWAYS,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static SecurityLevel valueOf(int value) => _byValue[value] as SecurityLevel;
  static void $checkItem(SecurityLevel v) {
    if (v is !SecurityLevel) checkItemFailed(v, 'SecurityLevel');
  }

  const SecurityLevel._(int v, String n) : super(v, n);
}

class ErrorHandler_ErrorCode extends ProtobufEnum {
  static const ErrorHandler_ErrorCode ERROR_CODE_UNSPECIFIED = const ErrorHandler_ErrorCode._(0, 'ERROR_CODE_UNSPECIFIED');
  static const ErrorHandler_ErrorCode ERROR_CODE_OVER_QUOTA = const ErrorHandler_ErrorCode._(1, 'ERROR_CODE_OVER_QUOTA');
  static const ErrorHandler_ErrorCode ERROR_CODE_DOS_API_DENIAL = const ErrorHandler_ErrorCode._(2, 'ERROR_CODE_DOS_API_DENIAL');
  static const ErrorHandler_ErrorCode ERROR_CODE_TIMEOUT = const ErrorHandler_ErrorCode._(3, 'ERROR_CODE_TIMEOUT');

  static const ErrorHandler_ErrorCode ERROR_CODE_DEFAULT = ERROR_CODE_UNSPECIFIED;

  static const List<ErrorHandler_ErrorCode> values = const <ErrorHandler_ErrorCode> [
    ERROR_CODE_UNSPECIFIED,
    ERROR_CODE_OVER_QUOTA,
    ERROR_CODE_DOS_API_DENIAL,
    ERROR_CODE_TIMEOUT,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static ErrorHandler_ErrorCode valueOf(int value) => _byValue[value] as ErrorHandler_ErrorCode;
  static void $checkItem(ErrorHandler_ErrorCode v) {
    if (v is !ErrorHandler_ErrorCode) checkItemFailed(v, 'ErrorHandler_ErrorCode');
  }

  const ErrorHandler_ErrorCode._(int v, String n) : super(v, n);
}

class UrlMap_RedirectHttpResponseCode extends ProtobufEnum {
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED = const UrlMap_RedirectHttpResponseCode._(0, 'REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_301 = const UrlMap_RedirectHttpResponseCode._(1, 'REDIRECT_HTTP_RESPONSE_CODE_301');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_302 = const UrlMap_RedirectHttpResponseCode._(2, 'REDIRECT_HTTP_RESPONSE_CODE_302');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_303 = const UrlMap_RedirectHttpResponseCode._(3, 'REDIRECT_HTTP_RESPONSE_CODE_303');
  static const UrlMap_RedirectHttpResponseCode REDIRECT_HTTP_RESPONSE_CODE_307 = const UrlMap_RedirectHttpResponseCode._(4, 'REDIRECT_HTTP_RESPONSE_CODE_307');

  static const List<UrlMap_RedirectHttpResponseCode> values = const <UrlMap_RedirectHttpResponseCode> [
    REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED,
    REDIRECT_HTTP_RESPONSE_CODE_301,
    REDIRECT_HTTP_RESPONSE_CODE_302,
    REDIRECT_HTTP_RESPONSE_CODE_303,
    REDIRECT_HTTP_RESPONSE_CODE_307,
  ];

  static final Map<int, dynamic> _byValue = ProtobufEnum.initByValue(values);
  static UrlMap_RedirectHttpResponseCode valueOf(int value) => _byValue[value] as UrlMap_RedirectHttpResponseCode;
  static void $checkItem(UrlMap_RedirectHttpResponseCode v) {
    if (v is !UrlMap_RedirectHttpResponseCode) checkItemFailed(v, 'UrlMap_RedirectHttpResponseCode');
  }

  const UrlMap_RedirectHttpResponseCode._(int v, String n) : super(v, n);
}

