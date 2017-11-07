///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_project_service;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class GetConfigRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetConfigRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetConfigRequest() : super();
  GetConfigRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetConfigRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetConfigRequest clone() => new GetConfigRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetConfigRequest create() => new GetConfigRequest();
  static PbList<GetConfigRequest> createRepeated() => new PbList<GetConfigRequest>();
  static GetConfigRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetConfigRequest();
    return _defaultInstance;
  }
  static GetConfigRequest _defaultInstance;
  static void $checkItem(GetConfigRequest v) {
    if (v is !GetConfigRequest) checkItemFailed(v, 'GetConfigRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetConfigRequest extends GetConfigRequest with ReadonlyMessageMixin {}

class GetConfigResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetConfigResponse')
    ..a/*<String>*/(1, 'serviceAccount', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'serviceAccountProject', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  GetConfigResponse() : super();
  GetConfigResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetConfigResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetConfigResponse clone() => new GetConfigResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetConfigResponse create() => new GetConfigResponse();
  static PbList<GetConfigResponse> createRepeated() => new PbList<GetConfigResponse>();
  static GetConfigResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetConfigResponse();
    return _defaultInstance;
  }
  static GetConfigResponse _defaultInstance;
  static void $checkItem(GetConfigResponse v) {
    if (v is !GetConfigResponse) checkItemFailed(v, 'GetConfigResponse');
  }

  String get serviceAccount => $_get(0, 1, '');
  void set serviceAccount(String v) { $_setString(0, 1, v); }
  bool hasServiceAccount() => $_has(0, 1);
  void clearServiceAccount() => clearField(1);

  Int64 get serviceAccountProject => $_get(1, 2, null);
  void set serviceAccountProject(Int64 v) { $_setInt64(1, 2, v); }
  bool hasServiceAccountProject() => $_has(1, 2);
  void clearServiceAccountProject() => clearField(2);
}

class _ReadonlyGetConfigResponse extends GetConfigResponse with ReadonlyMessageMixin {}

class ProjectManagementServiceApi {
  RpcClient _client;
  ProjectManagementServiceApi(this._client);

  Future<GetConfigResponse> getConfig(ClientContext ctx, GetConfigRequest request) {
    var emptyResponse = new GetConfigResponse();
    return _client.invoke(ctx, 'ProjectManagementService', 'GetConfig', request, emptyResponse);
  }
}

