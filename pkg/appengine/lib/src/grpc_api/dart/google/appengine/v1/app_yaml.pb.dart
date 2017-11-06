///
//  Generated code. Do not modify.
///
library google.appengine.v1_app_yaml;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/duration.pb.dart' as google$protobuf;

import 'app_yaml.pbenum.dart';

export 'app_yaml.pbenum.dart';

class ApiConfigHandler extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ApiConfigHandler')
    ..e/*<AuthFailAction>*/(1, 'authFailAction', PbFieldType.OE, AuthFailAction.AUTH_FAIL_ACTION_UNSPECIFIED, AuthFailAction.valueOf)
    ..e/*<LoginRequirement>*/(2, 'login', PbFieldType.OE, LoginRequirement.LOGIN_UNSPECIFIED, LoginRequirement.valueOf)
    ..a/*<String>*/(3, 'script', PbFieldType.OS)
    ..e/*<SecurityLevel>*/(4, 'securityLevel', PbFieldType.OE, SecurityLevel.SECURE_UNSPECIFIED, SecurityLevel.valueOf)
    ..a/*<String>*/(5, 'url', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ApiConfigHandler() : super();
  ApiConfigHandler.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ApiConfigHandler.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ApiConfigHandler clone() => new ApiConfigHandler()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ApiConfigHandler create() => new ApiConfigHandler();
  static PbList<ApiConfigHandler> createRepeated() => new PbList<ApiConfigHandler>();
  static ApiConfigHandler getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyApiConfigHandler();
    return _defaultInstance;
  }
  static ApiConfigHandler _defaultInstance;
  static void $checkItem(ApiConfigHandler v) {
    if (v is !ApiConfigHandler) checkItemFailed(v, 'ApiConfigHandler');
  }

  AuthFailAction get authFailAction => $_get(0, 1, null);
  void set authFailAction(AuthFailAction v) { setField(1, v); }
  bool hasAuthFailAction() => $_has(0, 1);
  void clearAuthFailAction() => clearField(1);

  LoginRequirement get login => $_get(1, 2, null);
  void set login(LoginRequirement v) { setField(2, v); }
  bool hasLogin() => $_has(1, 2);
  void clearLogin() => clearField(2);

  String get script => $_get(2, 3, '');
  void set script(String v) { $_setString(2, 3, v); }
  bool hasScript() => $_has(2, 3);
  void clearScript() => clearField(3);

  SecurityLevel get securityLevel => $_get(3, 4, null);
  void set securityLevel(SecurityLevel v) { setField(4, v); }
  bool hasSecurityLevel() => $_has(3, 4);
  void clearSecurityLevel() => clearField(4);

  String get url => $_get(4, 5, '');
  void set url(String v) { $_setString(4, 5, v); }
  bool hasUrl() => $_has(4, 5);
  void clearUrl() => clearField(5);
}

class _ReadonlyApiConfigHandler extends ApiConfigHandler with ReadonlyMessageMixin {}

class ErrorHandler extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorHandler')
    ..e/*<ErrorHandler_ErrorCode>*/(1, 'errorCode', PbFieldType.OE, ErrorHandler_ErrorCode.ERROR_CODE_UNSPECIFIED, ErrorHandler_ErrorCode.valueOf)
    ..a/*<String>*/(2, 'staticFile', PbFieldType.OS)
    ..a/*<String>*/(3, 'mimeType', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ErrorHandler() : super();
  ErrorHandler.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorHandler.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorHandler clone() => new ErrorHandler()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorHandler create() => new ErrorHandler();
  static PbList<ErrorHandler> createRepeated() => new PbList<ErrorHandler>();
  static ErrorHandler getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorHandler();
    return _defaultInstance;
  }
  static ErrorHandler _defaultInstance;
  static void $checkItem(ErrorHandler v) {
    if (v is !ErrorHandler) checkItemFailed(v, 'ErrorHandler');
  }

  ErrorHandler_ErrorCode get errorCode => $_get(0, 1, null);
  void set errorCode(ErrorHandler_ErrorCode v) { setField(1, v); }
  bool hasErrorCode() => $_has(0, 1);
  void clearErrorCode() => clearField(1);

  String get staticFile => $_get(1, 2, '');
  void set staticFile(String v) { $_setString(1, 2, v); }
  bool hasStaticFile() => $_has(1, 2);
  void clearStaticFile() => clearField(2);

  String get mimeType => $_get(2, 3, '');
  void set mimeType(String v) { $_setString(2, 3, v); }
  bool hasMimeType() => $_has(2, 3);
  void clearMimeType() => clearField(3);
}

class _ReadonlyErrorHandler extends ErrorHandler with ReadonlyMessageMixin {}

class UrlMap extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UrlMap')
    ..a/*<String>*/(1, 'urlRegex', PbFieldType.OS)
    ..a/*<StaticFilesHandler>*/(2, 'staticFiles', PbFieldType.OM, StaticFilesHandler.getDefault, StaticFilesHandler.create)
    ..a/*<ScriptHandler>*/(3, 'script', PbFieldType.OM, ScriptHandler.getDefault, ScriptHandler.create)
    ..a/*<ApiEndpointHandler>*/(4, 'apiEndpoint', PbFieldType.OM, ApiEndpointHandler.getDefault, ApiEndpointHandler.create)
    ..e/*<SecurityLevel>*/(5, 'securityLevel', PbFieldType.OE, SecurityLevel.SECURE_UNSPECIFIED, SecurityLevel.valueOf)
    ..e/*<LoginRequirement>*/(6, 'login', PbFieldType.OE, LoginRequirement.LOGIN_UNSPECIFIED, LoginRequirement.valueOf)
    ..e/*<AuthFailAction>*/(7, 'authFailAction', PbFieldType.OE, AuthFailAction.AUTH_FAIL_ACTION_UNSPECIFIED, AuthFailAction.valueOf)
    ..e/*<UrlMap_RedirectHttpResponseCode>*/(8, 'redirectHttpResponseCode', PbFieldType.OE, UrlMap_RedirectHttpResponseCode.REDIRECT_HTTP_RESPONSE_CODE_UNSPECIFIED, UrlMap_RedirectHttpResponseCode.valueOf)
    ..hasRequiredFields = false
  ;

  UrlMap() : super();
  UrlMap.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UrlMap.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UrlMap clone() => new UrlMap()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UrlMap create() => new UrlMap();
  static PbList<UrlMap> createRepeated() => new PbList<UrlMap>();
  static UrlMap getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUrlMap();
    return _defaultInstance;
  }
  static UrlMap _defaultInstance;
  static void $checkItem(UrlMap v) {
    if (v is !UrlMap) checkItemFailed(v, 'UrlMap');
  }

  String get urlRegex => $_get(0, 1, '');
  void set urlRegex(String v) { $_setString(0, 1, v); }
  bool hasUrlRegex() => $_has(0, 1);
  void clearUrlRegex() => clearField(1);

  StaticFilesHandler get staticFiles => $_get(1, 2, null);
  void set staticFiles(StaticFilesHandler v) { setField(2, v); }
  bool hasStaticFiles() => $_has(1, 2);
  void clearStaticFiles() => clearField(2);

  ScriptHandler get script => $_get(2, 3, null);
  void set script(ScriptHandler v) { setField(3, v); }
  bool hasScript() => $_has(2, 3);
  void clearScript() => clearField(3);

  ApiEndpointHandler get apiEndpoint => $_get(3, 4, null);
  void set apiEndpoint(ApiEndpointHandler v) { setField(4, v); }
  bool hasApiEndpoint() => $_has(3, 4);
  void clearApiEndpoint() => clearField(4);

  SecurityLevel get securityLevel => $_get(4, 5, null);
  void set securityLevel(SecurityLevel v) { setField(5, v); }
  bool hasSecurityLevel() => $_has(4, 5);
  void clearSecurityLevel() => clearField(5);

  LoginRequirement get login => $_get(5, 6, null);
  void set login(LoginRequirement v) { setField(6, v); }
  bool hasLogin() => $_has(5, 6);
  void clearLogin() => clearField(6);

  AuthFailAction get authFailAction => $_get(6, 7, null);
  void set authFailAction(AuthFailAction v) { setField(7, v); }
  bool hasAuthFailAction() => $_has(6, 7);
  void clearAuthFailAction() => clearField(7);

  UrlMap_RedirectHttpResponseCode get redirectHttpResponseCode => $_get(7, 8, null);
  void set redirectHttpResponseCode(UrlMap_RedirectHttpResponseCode v) { setField(8, v); }
  bool hasRedirectHttpResponseCode() => $_has(7, 8);
  void clearRedirectHttpResponseCode() => clearField(8);
}

class _ReadonlyUrlMap extends UrlMap with ReadonlyMessageMixin {}

class StaticFilesHandler_HttpHeadersEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StaticFilesHandler_HttpHeadersEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  StaticFilesHandler_HttpHeadersEntry() : super();
  StaticFilesHandler_HttpHeadersEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StaticFilesHandler_HttpHeadersEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StaticFilesHandler_HttpHeadersEntry clone() => new StaticFilesHandler_HttpHeadersEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StaticFilesHandler_HttpHeadersEntry create() => new StaticFilesHandler_HttpHeadersEntry();
  static PbList<StaticFilesHandler_HttpHeadersEntry> createRepeated() => new PbList<StaticFilesHandler_HttpHeadersEntry>();
  static StaticFilesHandler_HttpHeadersEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStaticFilesHandler_HttpHeadersEntry();
    return _defaultInstance;
  }
  static StaticFilesHandler_HttpHeadersEntry _defaultInstance;
  static void $checkItem(StaticFilesHandler_HttpHeadersEntry v) {
    if (v is !StaticFilesHandler_HttpHeadersEntry) checkItemFailed(v, 'StaticFilesHandler_HttpHeadersEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyStaticFilesHandler_HttpHeadersEntry extends StaticFilesHandler_HttpHeadersEntry with ReadonlyMessageMixin {}

class StaticFilesHandler extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StaticFilesHandler')
    ..a/*<String>*/(1, 'path', PbFieldType.OS)
    ..a/*<String>*/(2, 'uploadPathRegex', PbFieldType.OS)
    ..pp/*<StaticFilesHandler_HttpHeadersEntry>*/(3, 'httpHeaders', PbFieldType.PM, StaticFilesHandler_HttpHeadersEntry.$checkItem, StaticFilesHandler_HttpHeadersEntry.create)
    ..a/*<String>*/(4, 'mimeType', PbFieldType.OS)
    ..a/*<google$protobuf.Duration>*/(5, 'expiration', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<bool>*/(6, 'requireMatchingFile', PbFieldType.OB)
    ..a/*<bool>*/(7, 'applicationReadable', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  StaticFilesHandler() : super();
  StaticFilesHandler.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StaticFilesHandler.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StaticFilesHandler clone() => new StaticFilesHandler()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StaticFilesHandler create() => new StaticFilesHandler();
  static PbList<StaticFilesHandler> createRepeated() => new PbList<StaticFilesHandler>();
  static StaticFilesHandler getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStaticFilesHandler();
    return _defaultInstance;
  }
  static StaticFilesHandler _defaultInstance;
  static void $checkItem(StaticFilesHandler v) {
    if (v is !StaticFilesHandler) checkItemFailed(v, 'StaticFilesHandler');
  }

  String get path => $_get(0, 1, '');
  void set path(String v) { $_setString(0, 1, v); }
  bool hasPath() => $_has(0, 1);
  void clearPath() => clearField(1);

  String get uploadPathRegex => $_get(1, 2, '');
  void set uploadPathRegex(String v) { $_setString(1, 2, v); }
  bool hasUploadPathRegex() => $_has(1, 2);
  void clearUploadPathRegex() => clearField(2);

  List<StaticFilesHandler_HttpHeadersEntry> get httpHeaders => $_get(2, 3, null);

  String get mimeType => $_get(3, 4, '');
  void set mimeType(String v) { $_setString(3, 4, v); }
  bool hasMimeType() => $_has(3, 4);
  void clearMimeType() => clearField(4);

  google$protobuf.Duration get expiration => $_get(4, 5, null);
  void set expiration(google$protobuf.Duration v) { setField(5, v); }
  bool hasExpiration() => $_has(4, 5);
  void clearExpiration() => clearField(5);

  bool get requireMatchingFile => $_get(5, 6, false);
  void set requireMatchingFile(bool v) { $_setBool(5, 6, v); }
  bool hasRequireMatchingFile() => $_has(5, 6);
  void clearRequireMatchingFile() => clearField(6);

  bool get applicationReadable => $_get(6, 7, false);
  void set applicationReadable(bool v) { $_setBool(6, 7, v); }
  bool hasApplicationReadable() => $_has(6, 7);
  void clearApplicationReadable() => clearField(7);
}

class _ReadonlyStaticFilesHandler extends StaticFilesHandler with ReadonlyMessageMixin {}

class ScriptHandler extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ScriptHandler')
    ..a/*<String>*/(1, 'scriptPath', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ScriptHandler() : super();
  ScriptHandler.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ScriptHandler.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ScriptHandler clone() => new ScriptHandler()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ScriptHandler create() => new ScriptHandler();
  static PbList<ScriptHandler> createRepeated() => new PbList<ScriptHandler>();
  static ScriptHandler getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyScriptHandler();
    return _defaultInstance;
  }
  static ScriptHandler _defaultInstance;
  static void $checkItem(ScriptHandler v) {
    if (v is !ScriptHandler) checkItemFailed(v, 'ScriptHandler');
  }

  String get scriptPath => $_get(0, 1, '');
  void set scriptPath(String v) { $_setString(0, 1, v); }
  bool hasScriptPath() => $_has(0, 1);
  void clearScriptPath() => clearField(1);
}

class _ReadonlyScriptHandler extends ScriptHandler with ReadonlyMessageMixin {}

class ApiEndpointHandler extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ApiEndpointHandler')
    ..a/*<String>*/(1, 'scriptPath', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ApiEndpointHandler() : super();
  ApiEndpointHandler.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ApiEndpointHandler.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ApiEndpointHandler clone() => new ApiEndpointHandler()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ApiEndpointHandler create() => new ApiEndpointHandler();
  static PbList<ApiEndpointHandler> createRepeated() => new PbList<ApiEndpointHandler>();
  static ApiEndpointHandler getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyApiEndpointHandler();
    return _defaultInstance;
  }
  static ApiEndpointHandler _defaultInstance;
  static void $checkItem(ApiEndpointHandler v) {
    if (v is !ApiEndpointHandler) checkItemFailed(v, 'ApiEndpointHandler');
  }

  String get scriptPath => $_get(0, 1, '');
  void set scriptPath(String v) { $_setString(0, 1, v); }
  bool hasScriptPath() => $_has(0, 1);
  void clearScriptPath() => clearField(1);
}

class _ReadonlyApiEndpointHandler extends ApiEndpointHandler with ReadonlyMessageMixin {}

class HealthCheck extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HealthCheck')
    ..a/*<bool>*/(1, 'disableHealthCheck', PbFieldType.OB)
    ..a/*<String>*/(2, 'host', PbFieldType.OS)
    ..a/*<int>*/(3, 'healthyThreshold', PbFieldType.OU3)
    ..a/*<int>*/(4, 'unhealthyThreshold', PbFieldType.OU3)
    ..a/*<int>*/(5, 'restartThreshold', PbFieldType.OU3)
    ..a/*<google$protobuf.Duration>*/(6, 'checkInterval', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<google$protobuf.Duration>*/(7, 'timeout', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..hasRequiredFields = false
  ;

  HealthCheck() : super();
  HealthCheck.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HealthCheck.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HealthCheck clone() => new HealthCheck()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HealthCheck create() => new HealthCheck();
  static PbList<HealthCheck> createRepeated() => new PbList<HealthCheck>();
  static HealthCheck getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHealthCheck();
    return _defaultInstance;
  }
  static HealthCheck _defaultInstance;
  static void $checkItem(HealthCheck v) {
    if (v is !HealthCheck) checkItemFailed(v, 'HealthCheck');
  }

  bool get disableHealthCheck => $_get(0, 1, false);
  void set disableHealthCheck(bool v) { $_setBool(0, 1, v); }
  bool hasDisableHealthCheck() => $_has(0, 1);
  void clearDisableHealthCheck() => clearField(1);

  String get host => $_get(1, 2, '');
  void set host(String v) { $_setString(1, 2, v); }
  bool hasHost() => $_has(1, 2);
  void clearHost() => clearField(2);

  int get healthyThreshold => $_get(2, 3, 0);
  void set healthyThreshold(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasHealthyThreshold() => $_has(2, 3);
  void clearHealthyThreshold() => clearField(3);

  int get unhealthyThreshold => $_get(3, 4, 0);
  void set unhealthyThreshold(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasUnhealthyThreshold() => $_has(3, 4);
  void clearUnhealthyThreshold() => clearField(4);

  int get restartThreshold => $_get(4, 5, 0);
  void set restartThreshold(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasRestartThreshold() => $_has(4, 5);
  void clearRestartThreshold() => clearField(5);

  google$protobuf.Duration get checkInterval => $_get(5, 6, null);
  void set checkInterval(google$protobuf.Duration v) { setField(6, v); }
  bool hasCheckInterval() => $_has(5, 6);
  void clearCheckInterval() => clearField(6);

  google$protobuf.Duration get timeout => $_get(6, 7, null);
  void set timeout(google$protobuf.Duration v) { setField(7, v); }
  bool hasTimeout() => $_has(6, 7);
  void clearTimeout() => clearField(7);
}

class _ReadonlyHealthCheck extends HealthCheck with ReadonlyMessageMixin {}

class Library extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Library')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'version', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Library() : super();
  Library.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Library.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Library clone() => new Library()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Library create() => new Library();
  static PbList<Library> createRepeated() => new PbList<Library>();
  static Library getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLibrary();
    return _defaultInstance;
  }
  static Library _defaultInstance;
  static void $checkItem(Library v) {
    if (v is !Library) checkItemFailed(v, 'Library');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get version => $_get(1, 2, '');
  void set version(String v) { $_setString(1, 2, v); }
  bool hasVersion() => $_has(1, 2);
  void clearVersion() => clearField(2);
}

class _ReadonlyLibrary extends Library with ReadonlyMessageMixin {}

