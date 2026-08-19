//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/app_yaml.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use authFailActionDescriptor instead')
const AuthFailAction$json = {
  '1': 'AuthFailAction',
  '2': [
    {'1': 'AUTH_FAIL_ACTION_UNSPECIFIED', '2': 0},
    {'1': 'AUTH_FAIL_ACTION_REDIRECT', '2': 1},
    {'1': 'AUTH_FAIL_ACTION_UNAUTHORIZED', '2': 2},
  ],
};

/// Descriptor for `AuthFailAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List authFailActionDescriptor = $convert.base64Decode(
    'Cg5BdXRoRmFpbEFjdGlvbhIgChxBVVRIX0ZBSUxfQUNUSU9OX1VOU1BFQ0lGSUVEEAASHQoZQV'
    'VUSF9GQUlMX0FDVElPTl9SRURJUkVDVBABEiEKHUFVVEhfRkFJTF9BQ1RJT05fVU5BVVRIT1JJ'
    'WkVEEAI=');

@$core.Deprecated('Use loginRequirementDescriptor instead')
const LoginRequirement$json = {
  '1': 'LoginRequirement',
  '2': [
    {'1': 'LOGIN_UNSPECIFIED', '2': 0},
    {'1': 'LOGIN_OPTIONAL', '2': 1},
    {'1': 'LOGIN_ADMIN', '2': 2},
    {'1': 'LOGIN_REQUIRED', '2': 3},
  ],
};

/// Descriptor for `LoginRequirement`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List loginRequirementDescriptor = $convert.base64Decode(
    'ChBMb2dpblJlcXVpcmVtZW50EhUKEUxPR0lOX1VOU1BFQ0lGSUVEEAASEgoOTE9HSU5fT1BUSU'
    '9OQUwQARIPCgtMT0dJTl9BRE1JThACEhIKDkxPR0lOX1JFUVVJUkVEEAM=');

@$core.Deprecated('Use securityLevelDescriptor instead')
const SecurityLevel$json = {
  '1': 'SecurityLevel',
  '2': [
    {'1': 'SECURE_UNSPECIFIED', '2': 0},
    {'1': 'SECURE_DEFAULT', '2': 0},
    {'1': 'SECURE_NEVER', '2': 1},
    {'1': 'SECURE_OPTIONAL', '2': 2},
    {'1': 'SECURE_ALWAYS', '2': 3},
  ],
  '3': {'2': true},
};

/// Descriptor for `SecurityLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List securityLevelDescriptor = $convert.base64Decode(
    'Cg1TZWN1cml0eUxldmVsEhYKElNFQ1VSRV9VTlNQRUNJRklFRBAAEhIKDlNFQ1VSRV9ERUZBVU'
    'xUEAASEAoMU0VDVVJFX05FVkVSEAESEwoPU0VDVVJFX09QVElPTkFMEAISEQoNU0VDVVJFX0FM'
    'V0FZUxADGgIQAQ==');

@$core.Deprecated('Use apiConfigHandlerDescriptor instead')
const ApiConfigHandler$json = {
  '1': 'ApiConfigHandler',
  '2': [
    {
      '1': 'auth_fail_action',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.AuthFailAction',
      '10': 'authFailAction'
    },
    {
      '1': 'login',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.LoginRequirement',
      '10': 'login'
    },
    {'1': 'script', '3': 3, '4': 1, '5': 9, '10': 'script'},
    {
      '1': 'security_level',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.SecurityLevel',
      '10': 'securityLevel'
    },
    {'1': 'url', '3': 5, '4': 1, '5': 9, '10': 'url'},
  ],
};

/// Descriptor for `ApiConfigHandler`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiConfigHandlerDescriptor = $convert.base64Decode(
    'ChBBcGlDb25maWdIYW5kbGVyElEKEGF1dGhfZmFpbF9hY3Rpb24YASABKA4yJy5nb29nbGUuYX'
    'BwZW5naW5lLnYxYmV0YS5BdXRoRmFpbEFjdGlvblIOYXV0aEZhaWxBY3Rpb24SPwoFbG9naW4Y'
    'AiABKA4yKS5nb29nbGUuYXBwZW5naW5lLnYxYmV0YS5Mb2dpblJlcXVpcmVtZW50UgVsb2dpbh'
    'IWCgZzY3JpcHQYAyABKAlSBnNjcmlwdBJNCg5zZWN1cml0eV9sZXZlbBgEIAEoDjImLmdvb2ds'
    'ZS5hcHBlbmdpbmUudjFiZXRhLlNlY3VyaXR5TGV2ZWxSDXNlY3VyaXR5TGV2ZWwSEAoDdXJsGA'
    'UgASgJUgN1cmw=');

@$core.Deprecated('Use errorHandlerDescriptor instead')
const ErrorHandler$json = {
  '1': 'ErrorHandler',
  '2': [
    {
      '1': 'error_code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.ErrorHandler.ErrorCode',
      '10': 'errorCode'
    },
    {'1': 'static_file', '3': 2, '4': 1, '5': 9, '10': 'staticFile'},
    {'1': 'mime_type', '3': 3, '4': 1, '5': 9, '10': 'mimeType'},
  ],
  '4': [ErrorHandler_ErrorCode$json],
};

@$core.Deprecated('Use errorHandlerDescriptor instead')
const ErrorHandler_ErrorCode$json = {
  '1': 'ErrorCode',
  '2': [
    {'1': 'ERROR_CODE_UNSPECIFIED', '2': 0},
    {'1': 'ERROR_CODE_DEFAULT', '2': 0},
    {'1': 'ERROR_CODE_OVER_QUOTA', '2': 1},
    {'1': 'ERROR_CODE_DOS_API_DENIAL', '2': 2},
    {'1': 'ERROR_CODE_TIMEOUT', '2': 3},
  ],
  '3': {'2': true},
};

/// Descriptor for `ErrorHandler`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorHandlerDescriptor = $convert.base64Decode(
    'CgxFcnJvckhhbmRsZXISTgoKZXJyb3JfY29kZRgBIAEoDjIvLmdvb2dsZS5hcHBlbmdpbmUudj'
    'FiZXRhLkVycm9ySGFuZGxlci5FcnJvckNvZGVSCWVycm9yQ29kZRIfCgtzdGF0aWNfZmlsZRgC'
    'IAEoCVIKc3RhdGljRmlsZRIbCgltaW1lX3R5cGUYAyABKAlSCG1pbWVUeXBlIpUBCglFcnJvck'
    'NvZGUSGgoWRVJST1JfQ09ERV9VTlNQRUNJRklFRBAAEhYKEkVSUk9SX0NPREVfREVGQVVMVBAA'
    'EhkKFUVSUk9SX0NPREVfT1ZFUl9RVU9UQRABEh0KGUVSUk9SX0NPREVfRE9TX0FQSV9ERU5JQU'
    'wQAhIWChJFUlJPUl9DT0RFX1RJTUVPVVQQAxoCEAE=');

@$core.Deprecated('Use urlMapDescriptor instead')
const UrlMap$json = {
  '1': 'UrlMap',
  '2': [
    {'1': 'url_regex', '3': 1, '4': 1, '5': 9, '10': 'urlRegex'},
    {
      '1': 'static_files',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.StaticFilesHandler',
      '9': 0,
      '10': 'staticFiles'
    },
    {
      '1': 'script',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.ScriptHandler',
      '9': 0,
      '10': 'script'
    },
    {
      '1': 'api_endpoint',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.appengine.v1beta.ApiEndpointHandler',
      '9': 0,
      '10': 'apiEndpoint'
    },
    {
      '1': 'security_level',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.SecurityLevel',
      '10': 'securityLevel'
    },
    {
      '1': 'login',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.LoginRequirement',
      '10': 'login'
    },
    {
      '1': 'auth_fail_action',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.AuthFailAction',
      '10': 'authFailAction'
    },
    {
      '1': 'redirect_http_response_code',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.google.appengine.v1beta.UrlMap.RedirectHttpResponseCode',
      '10': 'redirectHttpResponseCode'
    },
  ],
  '4': [UrlMap_RedirectHttpResponseCode$json],
  '8': [
    {'1': 'handler_type'},
  ],
};

@$core.Deprecated('Use urlMapDescriptor instead')
const UrlMap_RedirectHttpResponseCode$json = {
  '1': 'RedirectHttpResponseCode',
  '2': [
    {'1': 'REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED', '2': 0},
    {'1': 'REDIRECT_HTTP_RESPONSE_CODE_301', '2': 1},
    {'1': 'REDIRECT_HTTP_RESPONSE_CODE_302', '2': 2},
    {'1': 'REDIRECT_HTTP_RESPONSE_CODE_303', '2': 3},
    {'1': 'REDIRECT_HTTP_RESPONSE_CODE_307', '2': 4},
  ],
};

/// Descriptor for `UrlMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List urlMapDescriptor = $convert.base64Decode(
    'CgZVcmxNYXASGwoJdXJsX3JlZ2V4GAEgASgJUgh1cmxSZWdleBJQCgxzdGF0aWNfZmlsZXMYAi'
    'ABKAsyKy5nb29nbGUuYXBwZW5naW5lLnYxYmV0YS5TdGF0aWNGaWxlc0hhbmRsZXJIAFILc3Rh'
    'dGljRmlsZXMSQAoGc2NyaXB0GAMgASgLMiYuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuU2NyaX'
    'B0SGFuZGxlckgAUgZzY3JpcHQSUAoMYXBpX2VuZHBvaW50GAQgASgLMisuZ29vZ2xlLmFwcGVu'
    'Z2luZS52MWJldGEuQXBpRW5kcG9pbnRIYW5kbGVySABSC2FwaUVuZHBvaW50Ek0KDnNlY3VyaX'
    'R5X2xldmVsGAUgASgOMiYuZ29vZ2xlLmFwcGVuZ2luZS52MWJldGEuU2VjdXJpdHlMZXZlbFIN'
    'c2VjdXJpdHlMZXZlbBI/CgVsb2dpbhgGIAEoDjIpLmdvb2dsZS5hcHBlbmdpbmUudjFiZXRhLk'
    'xvZ2luUmVxdWlyZW1lbnRSBWxvZ2luElEKEGF1dGhfZmFpbF9hY3Rpb24YByABKA4yJy5nb29n'
    'bGUuYXBwZW5naW5lLnYxYmV0YS5BdXRoRmFpbEFjdGlvblIOYXV0aEZhaWxBY3Rpb24Sdwobcm'
    'VkaXJlY3RfaHR0cF9yZXNwb25zZV9jb2RlGAggASgOMjguZ29vZ2xlLmFwcGVuZ2luZS52MWJl'
    'dGEuVXJsTWFwLlJlZGlyZWN0SHR0cFJlc3BvbnNlQ29kZVIYcmVkaXJlY3RIdHRwUmVzcG9uc2'
    'VDb2RlItsBChhSZWRpcmVjdEh0dHBSZXNwb25zZUNvZGUSKwonUkVESVJFQ1RfSFRUUF9SRVNQ'
    'T05TRV9DT0RFX1VOU1BFQ0lGSUVEEAASIwofUkVESVJFQ1RfSFRUUF9SRVNQT05TRV9DT0RFXz'
    'MwMRABEiMKH1JFRElSRUNUX0hUVFBfUkVTUE9OU0VfQ09ERV8zMDIQAhIjCh9SRURJUkVDVF9I'
    'VFRQX1JFU1BPTlNFX0NPREVfMzAzEAMSIwofUkVESVJFQ1RfSFRUUF9SRVNQT05TRV9DT0RFXz'
    'MwNxAEQg4KDGhhbmRsZXJfdHlwZQ==');

@$core.Deprecated('Use staticFilesHandlerDescriptor instead')
const StaticFilesHandler$json = {
  '1': 'StaticFilesHandler',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'upload_path_regex', '3': 2, '4': 1, '5': 9, '10': 'uploadPathRegex'},
    {
      '1': 'http_headers',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.google.appengine.v1beta.StaticFilesHandler.HttpHeadersEntry',
      '10': 'httpHeaders'
    },
    {'1': 'mime_type', '3': 4, '4': 1, '5': 9, '10': 'mimeType'},
    {
      '1': 'expiration',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'expiration'
    },
    {
      '1': 'require_matching_file',
      '3': 6,
      '4': 1,
      '5': 8,
      '10': 'requireMatchingFile'
    },
    {
      '1': 'application_readable',
      '3': 7,
      '4': 1,
      '5': 8,
      '10': 'applicationReadable'
    },
  ],
  '3': [StaticFilesHandler_HttpHeadersEntry$json],
};

@$core.Deprecated('Use staticFilesHandlerDescriptor instead')
const StaticFilesHandler_HttpHeadersEntry$json = {
  '1': 'HttpHeadersEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `StaticFilesHandler`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List staticFilesHandlerDescriptor = $convert.base64Decode(
    'ChJTdGF0aWNGaWxlc0hhbmRsZXISEgoEcGF0aBgBIAEoCVIEcGF0aBIqChF1cGxvYWRfcGF0aF'
    '9yZWdleBgCIAEoCVIPdXBsb2FkUGF0aFJlZ2V4El8KDGh0dHBfaGVhZGVycxgDIAMoCzI8Lmdv'
    'b2dsZS5hcHBlbmdpbmUudjFiZXRhLlN0YXRpY0ZpbGVzSGFuZGxlci5IdHRwSGVhZGVyc0VudH'
    'J5UgtodHRwSGVhZGVycxIbCgltaW1lX3R5cGUYBCABKAlSCG1pbWVUeXBlEjkKCmV4cGlyYXRp'
    'b24YBSABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SCmV4cGlyYXRpb24SMgoVcmVxdW'
    'lyZV9tYXRjaGluZ19maWxlGAYgASgIUhNyZXF1aXJlTWF0Y2hpbmdGaWxlEjEKFGFwcGxpY2F0'
    'aW9uX3JlYWRhYmxlGAcgASgIUhNhcHBsaWNhdGlvblJlYWRhYmxlGj4KEEh0dHBIZWFkZXJzRW'
    '50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUYAiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use scriptHandlerDescriptor instead')
const ScriptHandler$json = {
  '1': 'ScriptHandler',
  '2': [
    {'1': 'script_path', '3': 1, '4': 1, '5': 9, '10': 'scriptPath'},
  ],
};

/// Descriptor for `ScriptHandler`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scriptHandlerDescriptor = $convert.base64Decode(
    'Cg1TY3JpcHRIYW5kbGVyEh8KC3NjcmlwdF9wYXRoGAEgASgJUgpzY3JpcHRQYXRo');

@$core.Deprecated('Use apiEndpointHandlerDescriptor instead')
const ApiEndpointHandler$json = {
  '1': 'ApiEndpointHandler',
  '2': [
    {'1': 'script_path', '3': 1, '4': 1, '5': 9, '10': 'scriptPath'},
  ],
};

/// Descriptor for `ApiEndpointHandler`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List apiEndpointHandlerDescriptor = $convert.base64Decode(
    'ChJBcGlFbmRwb2ludEhhbmRsZXISHwoLc2NyaXB0X3BhdGgYASABKAlSCnNjcmlwdFBhdGg=');

@$core.Deprecated('Use healthCheckDescriptor instead')
const HealthCheck$json = {
  '1': 'HealthCheck',
  '2': [
    {
      '1': 'disable_health_check',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'disableHealthCheck'
    },
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    {
      '1': 'healthy_threshold',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'healthyThreshold'
    },
    {
      '1': 'unhealthy_threshold',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'unhealthyThreshold'
    },
    {
      '1': 'restart_threshold',
      '3': 5,
      '4': 1,
      '5': 13,
      '10': 'restartThreshold'
    },
    {
      '1': 'check_interval',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'checkInterval'
    },
    {
      '1': 'timeout',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
  ],
};

/// Descriptor for `HealthCheck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckDescriptor = $convert.base64Decode(
    'CgtIZWFsdGhDaGVjaxIwChRkaXNhYmxlX2hlYWx0aF9jaGVjaxgBIAEoCFISZGlzYWJsZUhlYW'
    'x0aENoZWNrEhIKBGhvc3QYAiABKAlSBGhvc3QSKwoRaGVhbHRoeV90aHJlc2hvbGQYAyABKA1S'
    'EGhlYWx0aHlUaHJlc2hvbGQSLwoTdW5oZWFsdGh5X3RocmVzaG9sZBgEIAEoDVISdW5oZWFsdG'
    'h5VGhyZXNob2xkEisKEXJlc3RhcnRfdGhyZXNob2xkGAUgASgNUhByZXN0YXJ0VGhyZXNob2xk'
    'EkAKDmNoZWNrX2ludGVydmFsGAYgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUg1jaG'
    'Vja0ludGVydmFsEjMKB3RpbWVvdXQYByABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25S'
    'B3RpbWVvdXQ=');

@$core.Deprecated('Use readinessCheckDescriptor instead')
const ReadinessCheck$json = {
  '1': 'ReadinessCheck',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    {
      '1': 'failure_threshold',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'failureThreshold'
    },
    {
      '1': 'success_threshold',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'successThreshold'
    },
    {
      '1': 'check_interval',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'checkInterval'
    },
    {
      '1': 'timeout',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
    {
      '1': 'app_start_timeout',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'appStartTimeout'
    },
  ],
};

/// Descriptor for `ReadinessCheck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readinessCheckDescriptor = $convert.base64Decode(
    'Cg5SZWFkaW5lc3NDaGVjaxISCgRwYXRoGAEgASgJUgRwYXRoEhIKBGhvc3QYAiABKAlSBGhvc3'
    'QSKwoRZmFpbHVyZV90aHJlc2hvbGQYAyABKA1SEGZhaWx1cmVUaHJlc2hvbGQSKwoRc3VjY2Vz'
    'c190aHJlc2hvbGQYBCABKA1SEHN1Y2Nlc3NUaHJlc2hvbGQSQAoOY2hlY2tfaW50ZXJ2YWwYBS'
    'ABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SDWNoZWNrSW50ZXJ2YWwSMwoHdGltZW91'
    'dBgGIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIHdGltZW91dBJFChFhcHBfc3Rhcn'
    'RfdGltZW91dBgHIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblIPYXBwU3RhcnRUaW1l'
    'b3V0');

@$core.Deprecated('Use livenessCheckDescriptor instead')
const LivenessCheck$json = {
  '1': 'LivenessCheck',
  '2': [
    {'1': 'path', '3': 1, '4': 1, '5': 9, '10': 'path'},
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
    {
      '1': 'failure_threshold',
      '3': 3,
      '4': 1,
      '5': 13,
      '10': 'failureThreshold'
    },
    {
      '1': 'success_threshold',
      '3': 4,
      '4': 1,
      '5': 13,
      '10': 'successThreshold'
    },
    {
      '1': 'check_interval',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'checkInterval'
    },
    {
      '1': 'timeout',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'timeout'
    },
    {
      '1': 'initial_delay',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '10': 'initialDelay'
    },
  ],
};

/// Descriptor for `LivenessCheck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List livenessCheckDescriptor = $convert.base64Decode(
    'Cg1MaXZlbmVzc0NoZWNrEhIKBHBhdGgYASABKAlSBHBhdGgSEgoEaG9zdBgCIAEoCVIEaG9zdB'
    'IrChFmYWlsdXJlX3RocmVzaG9sZBgDIAEoDVIQZmFpbHVyZVRocmVzaG9sZBIrChFzdWNjZXNz'
    'X3RocmVzaG9sZBgEIAEoDVIQc3VjY2Vzc1RocmVzaG9sZBJACg5jaGVja19pbnRlcnZhbBgFIA'
    'EoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJhdGlvblINY2hlY2tJbnRlcnZhbBIzCgd0aW1lb3V0'
    'GAYgASgLMhkuZ29vZ2xlLnByb3RvYnVmLkR1cmF0aW9uUgd0aW1lb3V0Ej4KDWluaXRpYWxfZG'
    'VsYXkYByABKAsyGS5nb29nbGUucHJvdG9idWYuRHVyYXRpb25SDGluaXRpYWxEZWxheQ==');

@$core.Deprecated('Use libraryDescriptor instead')
const Library$json = {
  '1': 'Library',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'version', '3': 2, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `Library`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List libraryDescriptor = $convert.base64Decode(
    'CgdMaWJyYXJ5EhIKBG5hbWUYASABKAlSBG5hbWUSGAoHdmVyc2lvbhgCIAEoCVIHdmVyc2lvbg'
    '==');
