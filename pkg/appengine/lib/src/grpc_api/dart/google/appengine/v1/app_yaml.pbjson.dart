///
//  Generated code. Do not modify.
///
library google.appengine.v1_app_yaml_pbjson;

const AuthFailAction$json = const {
  '1': 'AuthFailAction',
  '2': const [
    const {'1': 'AUTH_FAIL_ACTION_UNSPECIFIED', '2': 0},
    const {'1': 'AUTH_FAIL_ACTION_REDIRECT', '2': 1},
    const {'1': 'AUTH_FAIL_ACTION_UNAUTHORIZED', '2': 2},
  ],
};

const LoginRequirement$json = const {
  '1': 'LoginRequirement',
  '2': const [
    const {'1': 'LOGIN_UNSPECIFIED', '2': 0},
    const {'1': 'LOGIN_OPTIONAL', '2': 1},
    const {'1': 'LOGIN_ADMIN', '2': 2},
    const {'1': 'LOGIN_REQUIRED', '2': 3},
  ],
};

const SecurityLevel$json = const {
  '1': 'SecurityLevel',
  '2': const [
    const {'1': 'SECURE_UNSPECIFIED', '2': 0},
    const {'1': 'SECURE_DEFAULT', '2': 0},
    const {'1': 'SECURE_NEVER', '2': 1},
    const {'1': 'SECURE_OPTIONAL', '2': 2},
    const {'1': 'SECURE_ALWAYS', '2': 3},
  ],
  '3': const {'2': true},
};

const ApiConfigHandler$json = const {
  '1': 'ApiConfigHandler',
  '2': const [
    const {'1': 'auth_fail_action', '3': 1, '4': 1, '5': 14, '6': '.google.appengine.v1.AuthFailAction'},
    const {'1': 'login', '3': 2, '4': 1, '5': 14, '6': '.google.appengine.v1.LoginRequirement'},
    const {'1': 'script', '3': 3, '4': 1, '5': 9},
    const {'1': 'security_level', '3': 4, '4': 1, '5': 14, '6': '.google.appengine.v1.SecurityLevel'},
    const {'1': 'url', '3': 5, '4': 1, '5': 9},
  ],
};

const ErrorHandler$json = const {
  '1': 'ErrorHandler',
  '2': const [
    const {'1': 'error_code', '3': 1, '4': 1, '5': 14, '6': '.google.appengine.v1.ErrorHandler.ErrorCode'},
    const {'1': 'static_file', '3': 2, '4': 1, '5': 9},
    const {'1': 'mime_type', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [ErrorHandler_ErrorCode$json],
};

const ErrorHandler_ErrorCode$json = const {
  '1': 'ErrorCode',
  '2': const [
    const {'1': 'ERROR_CODE_UNSPECIFIED', '2': 0},
    const {'1': 'ERROR_CODE_DEFAULT', '2': 0},
    const {'1': 'ERROR_CODE_OVER_QUOTA', '2': 1},
    const {'1': 'ERROR_CODE_DOS_API_DENIAL', '2': 2},
    const {'1': 'ERROR_CODE_TIMEOUT', '2': 3},
  ],
  '3': const {'2': true},
};

const UrlMap$json = const {
  '1': 'UrlMap',
  '2': const [
    const {'1': 'url_regex', '3': 1, '4': 1, '5': 9},
    const {'1': 'static_files', '3': 2, '4': 1, '5': 11, '6': '.google.appengine.v1.StaticFilesHandler'},
    const {'1': 'script', '3': 3, '4': 1, '5': 11, '6': '.google.appengine.v1.ScriptHandler'},
    const {'1': 'api_endpoint', '3': 4, '4': 1, '5': 11, '6': '.google.appengine.v1.ApiEndpointHandler'},
    const {'1': 'security_level', '3': 5, '4': 1, '5': 14, '6': '.google.appengine.v1.SecurityLevel'},
    const {'1': 'login', '3': 6, '4': 1, '5': 14, '6': '.google.appengine.v1.LoginRequirement'},
    const {'1': 'auth_fail_action', '3': 7, '4': 1, '5': 14, '6': '.google.appengine.v1.AuthFailAction'},
    const {'1': 'redirect_http_response_code', '3': 8, '4': 1, '5': 14, '6': '.google.appengine.v1.UrlMap.RedirectHttpResponseCode'},
  ],
  '4': const [UrlMap_RedirectHttpResponseCode$json],
};

const UrlMap_RedirectHttpResponseCode$json = const {
  '1': 'RedirectHttpResponseCode',
  '2': const [
    const {'1': 'REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED', '2': 0},
    const {'1': 'REDIRECT_HTTP_RESPONSE_CODE_301', '2': 1},
    const {'1': 'REDIRECT_HTTP_RESPONSE_CODE_302', '2': 2},
    const {'1': 'REDIRECT_HTTP_RESPONSE_CODE_303', '2': 3},
    const {'1': 'REDIRECT_HTTP_RESPONSE_CODE_307', '2': 4},
  ],
};

const StaticFilesHandler$json = const {
  '1': 'StaticFilesHandler',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9},
    const {'1': 'upload_path_regex', '3': 2, '4': 1, '5': 9},
    const {'1': 'http_headers', '3': 3, '4': 3, '5': 11, '6': '.google.appengine.v1.StaticFilesHandler.HttpHeadersEntry'},
    const {'1': 'mime_type', '3': 4, '4': 1, '5': 9},
    const {'1': 'expiration', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'require_matching_file', '3': 6, '4': 1, '5': 8},
    const {'1': 'application_readable', '3': 7, '4': 1, '5': 8},
  ],
  '3': const [StaticFilesHandler_HttpHeadersEntry$json],
};

const StaticFilesHandler_HttpHeadersEntry$json = const {
  '1': 'HttpHeadersEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const ScriptHandler$json = const {
  '1': 'ScriptHandler',
  '2': const [
    const {'1': 'script_path', '3': 1, '4': 1, '5': 9},
  ],
};

const ApiEndpointHandler$json = const {
  '1': 'ApiEndpointHandler',
  '2': const [
    const {'1': 'script_path', '3': 1, '4': 1, '5': 9},
  ],
};

const HealthCheck$json = const {
  '1': 'HealthCheck',
  '2': const [
    const {'1': 'disable_health_check', '3': 1, '4': 1, '5': 8},
    const {'1': 'host', '3': 2, '4': 1, '5': 9},
    const {'1': 'healthy_threshold', '3': 3, '4': 1, '5': 13},
    const {'1': 'unhealthy_threshold', '3': 4, '4': 1, '5': 13},
    const {'1': 'restart_threshold', '3': 5, '4': 1, '5': 13},
    const {'1': 'check_interval', '3': 6, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'timeout', '3': 7, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
  ],
};

const Library$json = const {
  '1': 'Library',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'version', '3': 2, '4': 1, '5': 9},
  ],
};

