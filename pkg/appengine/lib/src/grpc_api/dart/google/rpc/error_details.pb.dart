///
//  Generated code. Do not modify.
///
library google.rpc_error_details;

import 'package:protobuf/protobuf.dart';

import '../protobuf/duration.pb.dart' as google$protobuf;

class RetryInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RetryInfo')
    ..a/*<google$protobuf.Duration>*/(1, 'retryDelay', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..hasRequiredFields = false
  ;

  RetryInfo() : super();
  RetryInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RetryInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RetryInfo clone() => new RetryInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RetryInfo create() => new RetryInfo();
  static PbList<RetryInfo> createRepeated() => new PbList<RetryInfo>();
  static RetryInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRetryInfo();
    return _defaultInstance;
  }
  static RetryInfo _defaultInstance;
  static void $checkItem(RetryInfo v) {
    if (v is !RetryInfo) checkItemFailed(v, 'RetryInfo');
  }

  google$protobuf.Duration get retryDelay => $_get(0, 1, null);
  void set retryDelay(google$protobuf.Duration v) { setField(1, v); }
  bool hasRetryDelay() => $_has(0, 1);
  void clearRetryDelay() => clearField(1);
}

class _ReadonlyRetryInfo extends RetryInfo with ReadonlyMessageMixin {}

class DebugInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DebugInfo')
    ..p/*<String>*/(1, 'stackEntries', PbFieldType.PS)
    ..a/*<String>*/(2, 'detail', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DebugInfo() : super();
  DebugInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DebugInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DebugInfo clone() => new DebugInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DebugInfo create() => new DebugInfo();
  static PbList<DebugInfo> createRepeated() => new PbList<DebugInfo>();
  static DebugInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDebugInfo();
    return _defaultInstance;
  }
  static DebugInfo _defaultInstance;
  static void $checkItem(DebugInfo v) {
    if (v is !DebugInfo) checkItemFailed(v, 'DebugInfo');
  }

  List<String> get stackEntries => $_get(0, 1, null);

  String get detail => $_get(1, 2, '');
  void set detail(String v) { $_setString(1, 2, v); }
  bool hasDetail() => $_has(1, 2);
  void clearDetail() => clearField(2);
}

class _ReadonlyDebugInfo extends DebugInfo with ReadonlyMessageMixin {}

class QuotaFailure_Violation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QuotaFailure_Violation')
    ..a/*<String>*/(1, 'subject', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  QuotaFailure_Violation() : super();
  QuotaFailure_Violation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QuotaFailure_Violation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QuotaFailure_Violation clone() => new QuotaFailure_Violation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QuotaFailure_Violation create() => new QuotaFailure_Violation();
  static PbList<QuotaFailure_Violation> createRepeated() => new PbList<QuotaFailure_Violation>();
  static QuotaFailure_Violation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQuotaFailure_Violation();
    return _defaultInstance;
  }
  static QuotaFailure_Violation _defaultInstance;
  static void $checkItem(QuotaFailure_Violation v) {
    if (v is !QuotaFailure_Violation) checkItemFailed(v, 'QuotaFailure_Violation');
  }

  String get subject => $_get(0, 1, '');
  void set subject(String v) { $_setString(0, 1, v); }
  bool hasSubject() => $_has(0, 1);
  void clearSubject() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);
}

class _ReadonlyQuotaFailure_Violation extends QuotaFailure_Violation with ReadonlyMessageMixin {}

class QuotaFailure extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QuotaFailure')
    ..pp/*<QuotaFailure_Violation>*/(1, 'violations', PbFieldType.PM, QuotaFailure_Violation.$checkItem, QuotaFailure_Violation.create)
    ..hasRequiredFields = false
  ;

  QuotaFailure() : super();
  QuotaFailure.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QuotaFailure.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QuotaFailure clone() => new QuotaFailure()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QuotaFailure create() => new QuotaFailure();
  static PbList<QuotaFailure> createRepeated() => new PbList<QuotaFailure>();
  static QuotaFailure getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQuotaFailure();
    return _defaultInstance;
  }
  static QuotaFailure _defaultInstance;
  static void $checkItem(QuotaFailure v) {
    if (v is !QuotaFailure) checkItemFailed(v, 'QuotaFailure');
  }

  List<QuotaFailure_Violation> get violations => $_get(0, 1, null);
}

class _ReadonlyQuotaFailure extends QuotaFailure with ReadonlyMessageMixin {}

class BadRequest_FieldViolation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BadRequest_FieldViolation')
    ..a/*<String>*/(1, 'field_1', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  BadRequest_FieldViolation() : super();
  BadRequest_FieldViolation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BadRequest_FieldViolation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BadRequest_FieldViolation clone() => new BadRequest_FieldViolation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BadRequest_FieldViolation create() => new BadRequest_FieldViolation();
  static PbList<BadRequest_FieldViolation> createRepeated() => new PbList<BadRequest_FieldViolation>();
  static BadRequest_FieldViolation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBadRequest_FieldViolation();
    return _defaultInstance;
  }
  static BadRequest_FieldViolation _defaultInstance;
  static void $checkItem(BadRequest_FieldViolation v) {
    if (v is !BadRequest_FieldViolation) checkItemFailed(v, 'BadRequest_FieldViolation');
  }

  String get field_1 => $_get(0, 1, '');
  void set field_1(String v) { $_setString(0, 1, v); }
  bool hasField_1() => $_has(0, 1);
  void clearField_1() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);
}

class _ReadonlyBadRequest_FieldViolation extends BadRequest_FieldViolation with ReadonlyMessageMixin {}

class BadRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BadRequest')
    ..pp/*<BadRequest_FieldViolation>*/(1, 'fieldViolations', PbFieldType.PM, BadRequest_FieldViolation.$checkItem, BadRequest_FieldViolation.create)
    ..hasRequiredFields = false
  ;

  BadRequest() : super();
  BadRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BadRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BadRequest clone() => new BadRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BadRequest create() => new BadRequest();
  static PbList<BadRequest> createRepeated() => new PbList<BadRequest>();
  static BadRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBadRequest();
    return _defaultInstance;
  }
  static BadRequest _defaultInstance;
  static void $checkItem(BadRequest v) {
    if (v is !BadRequest) checkItemFailed(v, 'BadRequest');
  }

  List<BadRequest_FieldViolation> get fieldViolations => $_get(0, 1, null);
}

class _ReadonlyBadRequest extends BadRequest with ReadonlyMessageMixin {}

class RequestInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RequestInfo')
    ..a/*<String>*/(1, 'requestId', PbFieldType.OS)
    ..a/*<String>*/(2, 'servingData', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RequestInfo() : super();
  RequestInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RequestInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RequestInfo clone() => new RequestInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RequestInfo create() => new RequestInfo();
  static PbList<RequestInfo> createRepeated() => new PbList<RequestInfo>();
  static RequestInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRequestInfo();
    return _defaultInstance;
  }
  static RequestInfo _defaultInstance;
  static void $checkItem(RequestInfo v) {
    if (v is !RequestInfo) checkItemFailed(v, 'RequestInfo');
  }

  String get requestId => $_get(0, 1, '');
  void set requestId(String v) { $_setString(0, 1, v); }
  bool hasRequestId() => $_has(0, 1);
  void clearRequestId() => clearField(1);

  String get servingData => $_get(1, 2, '');
  void set servingData(String v) { $_setString(1, 2, v); }
  bool hasServingData() => $_has(1, 2);
  void clearServingData() => clearField(2);
}

class _ReadonlyRequestInfo extends RequestInfo with ReadonlyMessageMixin {}

class ResourceInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResourceInfo')
    ..a/*<String>*/(1, 'resourceType', PbFieldType.OS)
    ..a/*<String>*/(2, 'resourceName', PbFieldType.OS)
    ..a/*<String>*/(3, 'owner', PbFieldType.OS)
    ..a/*<String>*/(4, 'description', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ResourceInfo() : super();
  ResourceInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResourceInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResourceInfo clone() => new ResourceInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResourceInfo create() => new ResourceInfo();
  static PbList<ResourceInfo> createRepeated() => new PbList<ResourceInfo>();
  static ResourceInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResourceInfo();
    return _defaultInstance;
  }
  static ResourceInfo _defaultInstance;
  static void $checkItem(ResourceInfo v) {
    if (v is !ResourceInfo) checkItemFailed(v, 'ResourceInfo');
  }

  String get resourceType => $_get(0, 1, '');
  void set resourceType(String v) { $_setString(0, 1, v); }
  bool hasResourceType() => $_has(0, 1);
  void clearResourceType() => clearField(1);

  String get resourceName => $_get(1, 2, '');
  void set resourceName(String v) { $_setString(1, 2, v); }
  bool hasResourceName() => $_has(1, 2);
  void clearResourceName() => clearField(2);

  String get owner => $_get(2, 3, '');
  void set owner(String v) { $_setString(2, 3, v); }
  bool hasOwner() => $_has(2, 3);
  void clearOwner() => clearField(3);

  String get description => $_get(3, 4, '');
  void set description(String v) { $_setString(3, 4, v); }
  bool hasDescription() => $_has(3, 4);
  void clearDescription() => clearField(4);
}

class _ReadonlyResourceInfo extends ResourceInfo with ReadonlyMessageMixin {}

class Help_Link extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Help_Link')
    ..a/*<String>*/(1, 'description', PbFieldType.OS)
    ..a/*<String>*/(2, 'url', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Help_Link() : super();
  Help_Link.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Help_Link.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Help_Link clone() => new Help_Link()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Help_Link create() => new Help_Link();
  static PbList<Help_Link> createRepeated() => new PbList<Help_Link>();
  static Help_Link getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHelp_Link();
    return _defaultInstance;
  }
  static Help_Link _defaultInstance;
  static void $checkItem(Help_Link v) {
    if (v is !Help_Link) checkItemFailed(v, 'Help_Link');
  }

  String get description => $_get(0, 1, '');
  void set description(String v) { $_setString(0, 1, v); }
  bool hasDescription() => $_has(0, 1);
  void clearDescription() => clearField(1);

  String get url => $_get(1, 2, '');
  void set url(String v) { $_setString(1, 2, v); }
  bool hasUrl() => $_has(1, 2);
  void clearUrl() => clearField(2);
}

class _ReadonlyHelp_Link extends Help_Link with ReadonlyMessageMixin {}

class Help extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Help')
    ..pp/*<Help_Link>*/(1, 'links', PbFieldType.PM, Help_Link.$checkItem, Help_Link.create)
    ..hasRequiredFields = false
  ;

  Help() : super();
  Help.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Help.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Help clone() => new Help()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Help create() => new Help();
  static PbList<Help> createRepeated() => new PbList<Help>();
  static Help getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyHelp();
    return _defaultInstance;
  }
  static Help _defaultInstance;
  static void $checkItem(Help v) {
    if (v is !Help) checkItemFailed(v, 'Help');
  }

  List<Help_Link> get links => $_get(0, 1, null);
}

class _ReadonlyHelp extends Help with ReadonlyMessageMixin {}

class LocalizedMessage extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LocalizedMessage')
    ..a/*<String>*/(1, 'locale', PbFieldType.OS)
    ..a/*<String>*/(2, 'message', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LocalizedMessage() : super();
  LocalizedMessage.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LocalizedMessage.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LocalizedMessage clone() => new LocalizedMessage()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LocalizedMessage create() => new LocalizedMessage();
  static PbList<LocalizedMessage> createRepeated() => new PbList<LocalizedMessage>();
  static LocalizedMessage getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLocalizedMessage();
    return _defaultInstance;
  }
  static LocalizedMessage _defaultInstance;
  static void $checkItem(LocalizedMessage v) {
    if (v is !LocalizedMessage) checkItemFailed(v, 'LocalizedMessage');
  }

  String get locale => $_get(0, 1, '');
  void set locale(String v) { $_setString(0, 1, v); }
  bool hasLocale() => $_has(0, 1);
  void clearLocale() => clearField(1);

  String get message => $_get(1, 2, '');
  void set message(String v) { $_setString(1, 2, v); }
  bool hasMessage() => $_has(1, 2);
  void clearMessage() => clearField(2);
}

class _ReadonlyLocalizedMessage extends LocalizedMessage with ReadonlyMessageMixin {}

