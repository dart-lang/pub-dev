///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_common;

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;

class ErrorGroup extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorGroup')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'groupId', PbFieldType.OS)
    ..pp/*<TrackingIssue>*/(3, 'trackingIssues', PbFieldType.PM, TrackingIssue.$checkItem, TrackingIssue.create)
    ..hasRequiredFields = false
  ;

  ErrorGroup() : super();
  ErrorGroup.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorGroup.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorGroup clone() => new ErrorGroup()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorGroup create() => new ErrorGroup();
  static PbList<ErrorGroup> createRepeated() => new PbList<ErrorGroup>();
  static ErrorGroup getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorGroup();
    return _defaultInstance;
  }
  static ErrorGroup _defaultInstance;
  static void $checkItem(ErrorGroup v) {
    if (v is !ErrorGroup) checkItemFailed(v, 'ErrorGroup');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get groupId => $_get(1, 2, '');
  void set groupId(String v) { $_setString(1, 2, v); }
  bool hasGroupId() => $_has(1, 2);
  void clearGroupId() => clearField(2);

  List<TrackingIssue> get trackingIssues => $_get(2, 3, null);
}

class _ReadonlyErrorGroup extends ErrorGroup with ReadonlyMessageMixin {}

class TrackingIssue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TrackingIssue')
    ..a/*<String>*/(1, 'url', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TrackingIssue() : super();
  TrackingIssue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TrackingIssue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TrackingIssue clone() => new TrackingIssue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TrackingIssue create() => new TrackingIssue();
  static PbList<TrackingIssue> createRepeated() => new PbList<TrackingIssue>();
  static TrackingIssue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTrackingIssue();
    return _defaultInstance;
  }
  static TrackingIssue _defaultInstance;
  static void $checkItem(TrackingIssue v) {
    if (v is !TrackingIssue) checkItemFailed(v, 'TrackingIssue');
  }

  String get url => $_get(0, 1, '');
  void set url(String v) { $_setString(0, 1, v); }
  bool hasUrl() => $_has(0, 1);
  void clearUrl() => clearField(1);
}

class _ReadonlyTrackingIssue extends TrackingIssue with ReadonlyMessageMixin {}

class ErrorEvent extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorEvent')
    ..a/*<google$protobuf.Timestamp>*/(1, 'eventTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<ServiceContext>*/(2, 'serviceContext', PbFieldType.OM, ServiceContext.getDefault, ServiceContext.create)
    ..a/*<String>*/(3, 'message', PbFieldType.OS)
    ..a/*<ErrorContext>*/(5, 'context', PbFieldType.OM, ErrorContext.getDefault, ErrorContext.create)
    ..hasRequiredFields = false
  ;

  ErrorEvent() : super();
  ErrorEvent.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorEvent.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorEvent clone() => new ErrorEvent()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorEvent create() => new ErrorEvent();
  static PbList<ErrorEvent> createRepeated() => new PbList<ErrorEvent>();
  static ErrorEvent getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorEvent();
    return _defaultInstance;
  }
  static ErrorEvent _defaultInstance;
  static void $checkItem(ErrorEvent v) {
    if (v is !ErrorEvent) checkItemFailed(v, 'ErrorEvent');
  }

  google$protobuf.Timestamp get eventTime => $_get(0, 1, null);
  void set eventTime(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasEventTime() => $_has(0, 1);
  void clearEventTime() => clearField(1);

  ServiceContext get serviceContext => $_get(1, 2, null);
  void set serviceContext(ServiceContext v) { setField(2, v); }
  bool hasServiceContext() => $_has(1, 2);
  void clearServiceContext() => clearField(2);

  String get message => $_get(2, 3, '');
  void set message(String v) { $_setString(2, 3, v); }
  bool hasMessage() => $_has(2, 3);
  void clearMessage() => clearField(3);

  ErrorContext get context => $_get(3, 5, null);
  void set context(ErrorContext v) { setField(5, v); }
  bool hasContext() => $_has(3, 5);
  void clearContext() => clearField(5);
}

class _ReadonlyErrorEvent extends ErrorEvent with ReadonlyMessageMixin {}

class ServiceContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServiceContext')
    ..a/*<String>*/(2, 'service', PbFieldType.OS)
    ..a/*<String>*/(3, 'version', PbFieldType.OS)
    ..a/*<String>*/(4, 'resourceType', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ServiceContext() : super();
  ServiceContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceContext clone() => new ServiceContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServiceContext create() => new ServiceContext();
  static PbList<ServiceContext> createRepeated() => new PbList<ServiceContext>();
  static ServiceContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServiceContext();
    return _defaultInstance;
  }
  static ServiceContext _defaultInstance;
  static void $checkItem(ServiceContext v) {
    if (v is !ServiceContext) checkItemFailed(v, 'ServiceContext');
  }

  String get service => $_get(0, 2, '');
  void set service(String v) { $_setString(0, 2, v); }
  bool hasService() => $_has(0, 2);
  void clearService() => clearField(2);

  String get version => $_get(1, 3, '');
  void set version(String v) { $_setString(1, 3, v); }
  bool hasVersion() => $_has(1, 3);
  void clearVersion() => clearField(3);

  String get resourceType => $_get(2, 4, '');
  void set resourceType(String v) { $_setString(2, 4, v); }
  bool hasResourceType() => $_has(2, 4);
  void clearResourceType() => clearField(4);
}

class _ReadonlyServiceContext extends ServiceContext with ReadonlyMessageMixin {}

class ErrorContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorContext')
    ..a/*<HttpRequestContext>*/(1, 'httpRequest', PbFieldType.OM, HttpRequestContext.getDefault, HttpRequestContext.create)
    ..a/*<String>*/(2, 'user', PbFieldType.OS)
    ..a/*<SourceLocation>*/(3, 'reportLocation', PbFieldType.OM, SourceLocation.getDefault, SourceLocation.create)
    ..hasRequiredFields = false
  ;

  ErrorContext() : super();
  ErrorContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorContext clone() => new ErrorContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorContext create() => new ErrorContext();
  static PbList<ErrorContext> createRepeated() => new PbList<ErrorContext>();
  static ErrorContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorContext();
    return _defaultInstance;
  }
  static ErrorContext _defaultInstance;
  static void $checkItem(ErrorContext v) {
    if (v is !ErrorContext) checkItemFailed(v, 'ErrorContext');
  }

  HttpRequestContext get httpRequest => $_get(0, 1, null);
  void set httpRequest(HttpRequestContext v) { setField(1, v); }
  bool hasHttpRequest() => $_has(0, 1);
  void clearHttpRequest() => clearField(1);

  String get user => $_get(1, 2, '');
  void set user(String v) { $_setString(1, 2, v); }
  bool hasUser() => $_has(1, 2);
  void clearUser() => clearField(2);

  SourceLocation get reportLocation => $_get(2, 3, null);
  void set reportLocation(SourceLocation v) { setField(3, v); }
  bool hasReportLocation() => $_has(2, 3);
  void clearReportLocation() => clearField(3);
}

class _ReadonlyErrorContext extends ErrorContext with ReadonlyMessageMixin {}

class HttpRequestContext extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('HttpRequestContext')
    ..a/*<String>*/(1, 'method', PbFieldType.OS)
    ..a/*<String>*/(2, 'url', PbFieldType.OS)
    ..a/*<String>*/(3, 'userAgent', PbFieldType.OS)
    ..a/*<String>*/(4, 'referrer', PbFieldType.OS)
    ..a/*<int>*/(5, 'responseStatusCode', PbFieldType.O3)
    ..a/*<String>*/(6, 'remoteIp', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  HttpRequestContext() : super();
  HttpRequestContext.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  HttpRequestContext.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  HttpRequestContext clone() => new HttpRequestContext()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static HttpRequestContext create() => new HttpRequestContext();
  static PbList<HttpRequestContext> createRepeated() => new PbList<HttpRequestContext>();
  static HttpRequestContext getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHttpRequestContext();
    return _defaultInstance;
  }
  static HttpRequestContext _defaultInstance;
  static void $checkItem(HttpRequestContext v) {
    if (v is !HttpRequestContext) checkItemFailed(v, 'HttpRequestContext');
  }

  String get method => $_get(0, 1, '');
  void set method(String v) { $_setString(0, 1, v); }
  bool hasMethod() => $_has(0, 1);
  void clearMethod() => clearField(1);

  String get url => $_get(1, 2, '');
  void set url(String v) { $_setString(1, 2, v); }
  bool hasUrl() => $_has(1, 2);
  void clearUrl() => clearField(2);

  String get userAgent => $_get(2, 3, '');
  void set userAgent(String v) { $_setString(2, 3, v); }
  bool hasUserAgent() => $_has(2, 3);
  void clearUserAgent() => clearField(3);

  String get referrer => $_get(3, 4, '');
  void set referrer(String v) { $_setString(3, 4, v); }
  bool hasReferrer() => $_has(3, 4);
  void clearReferrer() => clearField(4);

  int get responseStatusCode => $_get(4, 5, 0);
  void set responseStatusCode(int v) { $_setUnsignedInt32(4, 5, v); }
  bool hasResponseStatusCode() => $_has(4, 5);
  void clearResponseStatusCode() => clearField(5);

  String get remoteIp => $_get(5, 6, '');
  void set remoteIp(String v) { $_setString(5, 6, v); }
  bool hasRemoteIp() => $_has(5, 6);
  void clearRemoteIp() => clearField(6);
}

class _ReadonlyHttpRequestContext extends HttpRequestContext with ReadonlyMessageMixin {}

class SourceLocation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SourceLocation')
    ..a/*<String>*/(1, 'filePath', PbFieldType.OS)
    ..a/*<int>*/(2, 'lineNumber', PbFieldType.O3)
    ..a/*<String>*/(4, 'functionName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SourceLocation() : super();
  SourceLocation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SourceLocation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SourceLocation clone() => new SourceLocation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SourceLocation create() => new SourceLocation();
  static PbList<SourceLocation> createRepeated() => new PbList<SourceLocation>();
  static SourceLocation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySourceLocation();
    return _defaultInstance;
  }
  static SourceLocation _defaultInstance;
  static void $checkItem(SourceLocation v) {
    if (v is !SourceLocation) checkItemFailed(v, 'SourceLocation');
  }

  String get filePath => $_get(0, 1, '');
  void set filePath(String v) { $_setString(0, 1, v); }
  bool hasFilePath() => $_has(0, 1);
  void clearFilePath() => clearField(1);

  int get lineNumber => $_get(1, 2, 0);
  void set lineNumber(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasLineNumber() => $_has(1, 2);
  void clearLineNumber() => clearField(2);

  String get functionName => $_get(2, 4, '');
  void set functionName(String v) { $_setString(2, 4, v); }
  bool hasFunctionName() => $_has(2, 4);
  void clearFunctionName() => clearField(4);
}

class _ReadonlySourceLocation extends SourceLocation with ReadonlyMessageMixin {}

