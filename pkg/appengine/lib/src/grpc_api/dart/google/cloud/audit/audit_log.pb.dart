///
//  Generated code. Do not modify.
///
library google.cloud.audit_audit_log;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../rpc/status.pb.dart' as google$rpc;
import '../../protobuf/any.pb.dart' as google$protobuf;
import '../../protobuf/struct.pb.dart' as google$protobuf;

class AuditLog extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuditLog')
    ..a/*<google$rpc.Status>*/(2, 'status', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..a/*<AuthenticationInfo>*/(3, 'authenticationInfo', PbFieldType.OM, AuthenticationInfo.getDefault, AuthenticationInfo.create)
    ..a/*<RequestMetadata>*/(4, 'requestMetadata', PbFieldType.OM, RequestMetadata.getDefault, RequestMetadata.create)
    ..a/*<String>*/(7, 'serviceName', PbFieldType.OS)
    ..a/*<String>*/(8, 'methodName', PbFieldType.OS)
    ..pp/*<AuthorizationInfo>*/(9, 'authorizationInfo', PbFieldType.PM, AuthorizationInfo.$checkItem, AuthorizationInfo.create)
    ..a/*<String>*/(11, 'resourceName', PbFieldType.OS)
    ..a/*<Int64>*/(12, 'numResponseItems', PbFieldType.O6, Int64.ZERO)
    ..a/*<google$protobuf.Any>*/(15, 'serviceData', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..a/*<google$protobuf.Struct>*/(16, 'request', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..a/*<google$protobuf.Struct>*/(17, 'response', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..hasRequiredFields = false
  ;

  AuditLog() : super();
  AuditLog.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuditLog.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuditLog clone() => new AuditLog()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuditLog create() => new AuditLog();
  static PbList<AuditLog> createRepeated() => new PbList<AuditLog>();
  static AuditLog getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuditLog();
    return _defaultInstance;
  }
  static AuditLog _defaultInstance;
  static void $checkItem(AuditLog v) {
    if (v is !AuditLog) checkItemFailed(v, 'AuditLog');
  }

  google$rpc.Status get status => $_get(0, 2, null);
  void set status(google$rpc.Status v) { setField(2, v); }
  bool hasStatus() => $_has(0, 2);
  void clearStatus() => clearField(2);

  AuthenticationInfo get authenticationInfo => $_get(1, 3, null);
  void set authenticationInfo(AuthenticationInfo v) { setField(3, v); }
  bool hasAuthenticationInfo() => $_has(1, 3);
  void clearAuthenticationInfo() => clearField(3);

  RequestMetadata get requestMetadata => $_get(2, 4, null);
  void set requestMetadata(RequestMetadata v) { setField(4, v); }
  bool hasRequestMetadata() => $_has(2, 4);
  void clearRequestMetadata() => clearField(4);

  String get serviceName => $_get(3, 7, '');
  void set serviceName(String v) { $_setString(3, 7, v); }
  bool hasServiceName() => $_has(3, 7);
  void clearServiceName() => clearField(7);

  String get methodName => $_get(4, 8, '');
  void set methodName(String v) { $_setString(4, 8, v); }
  bool hasMethodName() => $_has(4, 8);
  void clearMethodName() => clearField(8);

  List<AuthorizationInfo> get authorizationInfo => $_get(5, 9, null);

  String get resourceName => $_get(6, 11, '');
  void set resourceName(String v) { $_setString(6, 11, v); }
  bool hasResourceName() => $_has(6, 11);
  void clearResourceName() => clearField(11);

  Int64 get numResponseItems => $_get(7, 12, null);
  void set numResponseItems(Int64 v) { $_setInt64(7, 12, v); }
  bool hasNumResponseItems() => $_has(7, 12);
  void clearNumResponseItems() => clearField(12);

  google$protobuf.Any get serviceData => $_get(8, 15, null);
  void set serviceData(google$protobuf.Any v) { setField(15, v); }
  bool hasServiceData() => $_has(8, 15);
  void clearServiceData() => clearField(15);

  google$protobuf.Struct get request => $_get(9, 16, null);
  void set request(google$protobuf.Struct v) { setField(16, v); }
  bool hasRequest() => $_has(9, 16);
  void clearRequest() => clearField(16);

  google$protobuf.Struct get response => $_get(10, 17, null);
  void set response(google$protobuf.Struct v) { setField(17, v); }
  bool hasResponse() => $_has(10, 17);
  void clearResponse() => clearField(17);
}

class _ReadonlyAuditLog extends AuditLog with ReadonlyMessageMixin {}

class AuthenticationInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthenticationInfo')
    ..a/*<String>*/(1, 'principalEmail', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AuthenticationInfo() : super();
  AuthenticationInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthenticationInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthenticationInfo clone() => new AuthenticationInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthenticationInfo create() => new AuthenticationInfo();
  static PbList<AuthenticationInfo> createRepeated() => new PbList<AuthenticationInfo>();
  static AuthenticationInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthenticationInfo();
    return _defaultInstance;
  }
  static AuthenticationInfo _defaultInstance;
  static void $checkItem(AuthenticationInfo v) {
    if (v is !AuthenticationInfo) checkItemFailed(v, 'AuthenticationInfo');
  }

  String get principalEmail => $_get(0, 1, '');
  void set principalEmail(String v) { $_setString(0, 1, v); }
  bool hasPrincipalEmail() => $_has(0, 1);
  void clearPrincipalEmail() => clearField(1);
}

class _ReadonlyAuthenticationInfo extends AuthenticationInfo with ReadonlyMessageMixin {}

class AuthorizationInfo extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthorizationInfo')
    ..a/*<String>*/(1, 'resource', PbFieldType.OS)
    ..a/*<String>*/(2, 'permission', PbFieldType.OS)
    ..a/*<bool>*/(3, 'granted', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  AuthorizationInfo() : super();
  AuthorizationInfo.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthorizationInfo.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthorizationInfo clone() => new AuthorizationInfo()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthorizationInfo create() => new AuthorizationInfo();
  static PbList<AuthorizationInfo> createRepeated() => new PbList<AuthorizationInfo>();
  static AuthorizationInfo getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthorizationInfo();
    return _defaultInstance;
  }
  static AuthorizationInfo _defaultInstance;
  static void $checkItem(AuthorizationInfo v) {
    if (v is !AuthorizationInfo) checkItemFailed(v, 'AuthorizationInfo');
  }

  String get resource => $_get(0, 1, '');
  void set resource(String v) { $_setString(0, 1, v); }
  bool hasResource() => $_has(0, 1);
  void clearResource() => clearField(1);

  String get permission => $_get(1, 2, '');
  void set permission(String v) { $_setString(1, 2, v); }
  bool hasPermission() => $_has(1, 2);
  void clearPermission() => clearField(2);

  bool get granted => $_get(2, 3, false);
  void set granted(bool v) { $_setBool(2, 3, v); }
  bool hasGranted() => $_has(2, 3);
  void clearGranted() => clearField(3);
}

class _ReadonlyAuthorizationInfo extends AuthorizationInfo with ReadonlyMessageMixin {}

class RequestMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RequestMetadata')
    ..a/*<String>*/(1, 'callerIp', PbFieldType.OS)
    ..a/*<String>*/(2, 'callerSuppliedUserAgent', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RequestMetadata() : super();
  RequestMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RequestMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RequestMetadata clone() => new RequestMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RequestMetadata create() => new RequestMetadata();
  static PbList<RequestMetadata> createRepeated() => new PbList<RequestMetadata>();
  static RequestMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRequestMetadata();
    return _defaultInstance;
  }
  static RequestMetadata _defaultInstance;
  static void $checkItem(RequestMetadata v) {
    if (v is !RequestMetadata) checkItemFailed(v, 'RequestMetadata');
  }

  String get callerIp => $_get(0, 1, '');
  void set callerIp(String v) { $_setString(0, 1, v); }
  bool hasCallerIp() => $_has(0, 1);
  void clearCallerIp() => clearField(1);

  String get callerSuppliedUserAgent => $_get(1, 2, '');
  void set callerSuppliedUserAgent(String v) { $_setString(1, 2, v); }
  bool hasCallerSuppliedUserAgent() => $_has(1, 2);
  void clearCallerSuppliedUserAgent() => clearField(2);
}

class _ReadonlyRequestMetadata extends RequestMetadata with ReadonlyMessageMixin {}

