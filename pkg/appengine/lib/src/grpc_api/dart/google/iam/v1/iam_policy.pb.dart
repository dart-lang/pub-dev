///
//  Generated code. Do not modify.
///
library google.iam.v1_iam_policy;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'policy.pb.dart';

class SetIamPolicyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetIamPolicyRequest')
    ..a/*<String>*/(1, 'resource', PbFieldType.OS)
    ..a/*<Policy>*/(2, 'policy', PbFieldType.OM, Policy.getDefault, Policy.create)
    ..hasRequiredFields = false
  ;

  SetIamPolicyRequest() : super();
  SetIamPolicyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetIamPolicyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetIamPolicyRequest clone() => new SetIamPolicyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SetIamPolicyRequest create() => new SetIamPolicyRequest();
  static PbList<SetIamPolicyRequest> createRepeated() => new PbList<SetIamPolicyRequest>();
  static SetIamPolicyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetIamPolicyRequest();
    return _defaultInstance;
  }
  static SetIamPolicyRequest _defaultInstance;
  static void $checkItem(SetIamPolicyRequest v) {
    if (v is !SetIamPolicyRequest) checkItemFailed(v, 'SetIamPolicyRequest');
  }

  String get resource => $_get(0, 1, '');
  void set resource(String v) { $_setString(0, 1, v); }
  bool hasResource() => $_has(0, 1);
  void clearResource() => clearField(1);

  Policy get policy => $_get(1, 2, null);
  void set policy(Policy v) { setField(2, v); }
  bool hasPolicy() => $_has(1, 2);
  void clearPolicy() => clearField(2);
}

class _ReadonlySetIamPolicyRequest extends SetIamPolicyRequest with ReadonlyMessageMixin {}

class GetIamPolicyRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetIamPolicyRequest')
    ..a/*<String>*/(1, 'resource', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetIamPolicyRequest() : super();
  GetIamPolicyRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetIamPolicyRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetIamPolicyRequest clone() => new GetIamPolicyRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetIamPolicyRequest create() => new GetIamPolicyRequest();
  static PbList<GetIamPolicyRequest> createRepeated() => new PbList<GetIamPolicyRequest>();
  static GetIamPolicyRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetIamPolicyRequest();
    return _defaultInstance;
  }
  static GetIamPolicyRequest _defaultInstance;
  static void $checkItem(GetIamPolicyRequest v) {
    if (v is !GetIamPolicyRequest) checkItemFailed(v, 'GetIamPolicyRequest');
  }

  String get resource => $_get(0, 1, '');
  void set resource(String v) { $_setString(0, 1, v); }
  bool hasResource() => $_has(0, 1);
  void clearResource() => clearField(1);
}

class _ReadonlyGetIamPolicyRequest extends GetIamPolicyRequest with ReadonlyMessageMixin {}

class TestIamPermissionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestIamPermissionsRequest')
    ..a/*<String>*/(1, 'resource', PbFieldType.OS)
    ..p/*<String>*/(2, 'permissions', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  TestIamPermissionsRequest() : super();
  TestIamPermissionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestIamPermissionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestIamPermissionsRequest clone() => new TestIamPermissionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestIamPermissionsRequest create() => new TestIamPermissionsRequest();
  static PbList<TestIamPermissionsRequest> createRepeated() => new PbList<TestIamPermissionsRequest>();
  static TestIamPermissionsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestIamPermissionsRequest();
    return _defaultInstance;
  }
  static TestIamPermissionsRequest _defaultInstance;
  static void $checkItem(TestIamPermissionsRequest v) {
    if (v is !TestIamPermissionsRequest) checkItemFailed(v, 'TestIamPermissionsRequest');
  }

  String get resource => $_get(0, 1, '');
  void set resource(String v) { $_setString(0, 1, v); }
  bool hasResource() => $_has(0, 1);
  void clearResource() => clearField(1);

  List<String> get permissions => $_get(1, 2, null);
}

class _ReadonlyTestIamPermissionsRequest extends TestIamPermissionsRequest with ReadonlyMessageMixin {}

class TestIamPermissionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TestIamPermissionsResponse')
    ..p/*<String>*/(1, 'permissions', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  TestIamPermissionsResponse() : super();
  TestIamPermissionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TestIamPermissionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TestIamPermissionsResponse clone() => new TestIamPermissionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TestIamPermissionsResponse create() => new TestIamPermissionsResponse();
  static PbList<TestIamPermissionsResponse> createRepeated() => new PbList<TestIamPermissionsResponse>();
  static TestIamPermissionsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTestIamPermissionsResponse();
    return _defaultInstance;
  }
  static TestIamPermissionsResponse _defaultInstance;
  static void $checkItem(TestIamPermissionsResponse v) {
    if (v is !TestIamPermissionsResponse) checkItemFailed(v, 'TestIamPermissionsResponse');
  }

  List<String> get permissions => $_get(0, 1, null);
}

class _ReadonlyTestIamPermissionsResponse extends TestIamPermissionsResponse with ReadonlyMessageMixin {}

class IAMPolicyApi {
  RpcClient _client;
  IAMPolicyApi(this._client);

  Future<Policy> setIamPolicy(ClientContext ctx, SetIamPolicyRequest request) {
    var emptyResponse = new Policy();
    return _client.invoke(ctx, 'IAMPolicy', 'SetIamPolicy', request, emptyResponse);
  }
  Future<Policy> getIamPolicy(ClientContext ctx, GetIamPolicyRequest request) {
    var emptyResponse = new Policy();
    return _client.invoke(ctx, 'IAMPolicy', 'GetIamPolicy', request, emptyResponse);
  }
  Future<TestIamPermissionsResponse> testIamPermissions(ClientContext ctx, TestIamPermissionsRequest request) {
    var emptyResponse = new TestIamPermissionsResponse();
    return _client.invoke(ctx, 'IAMPolicy', 'TestIamPermissions', request, emptyResponse);
  }
}

