///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_model_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../longrunning/operations.pb.dart' as google$longrunning;

class Model extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Model')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<Version>*/(3, 'defaultVersion', PbFieldType.OM, Version.getDefault, Version.create)
    ..hasRequiredFields = false
  ;

  Model() : super();
  Model.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Model.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Model clone() => new Model()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Model create() => new Model();
  static PbList<Model> createRepeated() => new PbList<Model>();
  static Model getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyModel();
    return _defaultInstance;
  }
  static Model _defaultInstance;
  static void $checkItem(Model v) {
    if (v is !Model) checkItemFailed(v, 'Model');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  Version get defaultVersion => $_get(2, 3, null);
  void set defaultVersion(Version v) { setField(3, v); }
  bool hasDefaultVersion() => $_has(2, 3);
  void clearDefaultVersion() => clearField(3);
}

class _ReadonlyModel extends Model with ReadonlyMessageMixin {}

class Version extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Version')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<bool>*/(3, 'isDefault', PbFieldType.OB)
    ..a/*<String>*/(4, 'deploymentUri', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(5, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(6, 'lastUseTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Version() : super();
  Version.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Version.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Version clone() => new Version()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Version create() => new Version();
  static PbList<Version> createRepeated() => new PbList<Version>();
  static Version getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVersion();
    return _defaultInstance;
  }
  static Version _defaultInstance;
  static void $checkItem(Version v) {
    if (v is !Version) checkItemFailed(v, 'Version');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  bool get isDefault => $_get(2, 3, false);
  void set isDefault(bool v) { $_setBool(2, 3, v); }
  bool hasIsDefault() => $_has(2, 3);
  void clearIsDefault() => clearField(3);

  String get deploymentUri => $_get(3, 4, '');
  void set deploymentUri(String v) { $_setString(3, 4, v); }
  bool hasDeploymentUri() => $_has(3, 4);
  void clearDeploymentUri() => clearField(4);

  google$protobuf.Timestamp get createTime => $_get(4, 5, null);
  void set createTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasCreateTime() => $_has(4, 5);
  void clearCreateTime() => clearField(5);

  google$protobuf.Timestamp get lastUseTime => $_get(5, 6, null);
  void set lastUseTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasLastUseTime() => $_has(5, 6);
  void clearLastUseTime() => clearField(6);
}

class _ReadonlyVersion extends Version with ReadonlyMessageMixin {}

class CreateModelRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateModelRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<Model>*/(2, 'model', PbFieldType.OM, Model.getDefault, Model.create)
    ..hasRequiredFields = false
  ;

  CreateModelRequest() : super();
  CreateModelRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateModelRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateModelRequest clone() => new CreateModelRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateModelRequest create() => new CreateModelRequest();
  static PbList<CreateModelRequest> createRepeated() => new PbList<CreateModelRequest>();
  static CreateModelRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateModelRequest();
    return _defaultInstance;
  }
  static CreateModelRequest _defaultInstance;
  static void $checkItem(CreateModelRequest v) {
    if (v is !CreateModelRequest) checkItemFailed(v, 'CreateModelRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  Model get model => $_get(1, 2, null);
  void set model(Model v) { setField(2, v); }
  bool hasModel() => $_has(1, 2);
  void clearModel() => clearField(2);
}

class _ReadonlyCreateModelRequest extends CreateModelRequest with ReadonlyMessageMixin {}

class ListModelsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListModelsRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListModelsRequest() : super();
  ListModelsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListModelsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListModelsRequest clone() => new ListModelsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListModelsRequest create() => new ListModelsRequest();
  static PbList<ListModelsRequest> createRepeated() => new PbList<ListModelsRequest>();
  static ListModelsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListModelsRequest();
    return _defaultInstance;
  }
  static ListModelsRequest _defaultInstance;
  static void $checkItem(ListModelsRequest v) {
    if (v is !ListModelsRequest) checkItemFailed(v, 'ListModelsRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get pageToken => $_get(1, 4, '');
  void set pageToken(String v) { $_setString(1, 4, v); }
  bool hasPageToken() => $_has(1, 4);
  void clearPageToken() => clearField(4);

  int get pageSize => $_get(2, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 5, v); }
  bool hasPageSize() => $_has(2, 5);
  void clearPageSize() => clearField(5);
}

class _ReadonlyListModelsRequest extends ListModelsRequest with ReadonlyMessageMixin {}

class ListModelsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListModelsResponse')
    ..pp/*<Model>*/(1, 'models', PbFieldType.PM, Model.$checkItem, Model.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListModelsResponse() : super();
  ListModelsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListModelsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListModelsResponse clone() => new ListModelsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListModelsResponse create() => new ListModelsResponse();
  static PbList<ListModelsResponse> createRepeated() => new PbList<ListModelsResponse>();
  static ListModelsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListModelsResponse();
    return _defaultInstance;
  }
  static ListModelsResponse _defaultInstance;
  static void $checkItem(ListModelsResponse v) {
    if (v is !ListModelsResponse) checkItemFailed(v, 'ListModelsResponse');
  }

  List<Model> get models => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListModelsResponse extends ListModelsResponse with ReadonlyMessageMixin {}

class GetModelRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetModelRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetModelRequest() : super();
  GetModelRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetModelRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetModelRequest clone() => new GetModelRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetModelRequest create() => new GetModelRequest();
  static PbList<GetModelRequest> createRepeated() => new PbList<GetModelRequest>();
  static GetModelRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetModelRequest();
    return _defaultInstance;
  }
  static GetModelRequest _defaultInstance;
  static void $checkItem(GetModelRequest v) {
    if (v is !GetModelRequest) checkItemFailed(v, 'GetModelRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetModelRequest extends GetModelRequest with ReadonlyMessageMixin {}

class DeleteModelRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteModelRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteModelRequest() : super();
  DeleteModelRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteModelRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteModelRequest clone() => new DeleteModelRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteModelRequest create() => new DeleteModelRequest();
  static PbList<DeleteModelRequest> createRepeated() => new PbList<DeleteModelRequest>();
  static DeleteModelRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteModelRequest();
    return _defaultInstance;
  }
  static DeleteModelRequest _defaultInstance;
  static void $checkItem(DeleteModelRequest v) {
    if (v is !DeleteModelRequest) checkItemFailed(v, 'DeleteModelRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteModelRequest extends DeleteModelRequest with ReadonlyMessageMixin {}

class CreateVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateVersionRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<Version>*/(2, 'version', PbFieldType.OM, Version.getDefault, Version.create)
    ..hasRequiredFields = false
  ;

  CreateVersionRequest() : super();
  CreateVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateVersionRequest clone() => new CreateVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateVersionRequest create() => new CreateVersionRequest();
  static PbList<CreateVersionRequest> createRepeated() => new PbList<CreateVersionRequest>();
  static CreateVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateVersionRequest();
    return _defaultInstance;
  }
  static CreateVersionRequest _defaultInstance;
  static void $checkItem(CreateVersionRequest v) {
    if (v is !CreateVersionRequest) checkItemFailed(v, 'CreateVersionRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  Version get version => $_get(1, 2, null);
  void set version(Version v) { setField(2, v); }
  bool hasVersion() => $_has(1, 2);
  void clearVersion() => clearField(2);
}

class _ReadonlyCreateVersionRequest extends CreateVersionRequest with ReadonlyMessageMixin {}

class ListVersionsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListVersionsRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(5, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListVersionsRequest() : super();
  ListVersionsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListVersionsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListVersionsRequest clone() => new ListVersionsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListVersionsRequest create() => new ListVersionsRequest();
  static PbList<ListVersionsRequest> createRepeated() => new PbList<ListVersionsRequest>();
  static ListVersionsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListVersionsRequest();
    return _defaultInstance;
  }
  static ListVersionsRequest _defaultInstance;
  static void $checkItem(ListVersionsRequest v) {
    if (v is !ListVersionsRequest) checkItemFailed(v, 'ListVersionsRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get pageToken => $_get(1, 4, '');
  void set pageToken(String v) { $_setString(1, 4, v); }
  bool hasPageToken() => $_has(1, 4);
  void clearPageToken() => clearField(4);

  int get pageSize => $_get(2, 5, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 5, v); }
  bool hasPageSize() => $_has(2, 5);
  void clearPageSize() => clearField(5);
}

class _ReadonlyListVersionsRequest extends ListVersionsRequest with ReadonlyMessageMixin {}

class ListVersionsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListVersionsResponse')
    ..pp/*<Version>*/(1, 'versions', PbFieldType.PM, Version.$checkItem, Version.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListVersionsResponse() : super();
  ListVersionsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListVersionsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListVersionsResponse clone() => new ListVersionsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListVersionsResponse create() => new ListVersionsResponse();
  static PbList<ListVersionsResponse> createRepeated() => new PbList<ListVersionsResponse>();
  static ListVersionsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListVersionsResponse();
    return _defaultInstance;
  }
  static ListVersionsResponse _defaultInstance;
  static void $checkItem(ListVersionsResponse v) {
    if (v is !ListVersionsResponse) checkItemFailed(v, 'ListVersionsResponse');
  }

  List<Version> get versions => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListVersionsResponse extends ListVersionsResponse with ReadonlyMessageMixin {}

class GetVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetVersionRequest() : super();
  GetVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetVersionRequest clone() => new GetVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetVersionRequest create() => new GetVersionRequest();
  static PbList<GetVersionRequest> createRepeated() => new PbList<GetVersionRequest>();
  static GetVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetVersionRequest();
    return _defaultInstance;
  }
  static GetVersionRequest _defaultInstance;
  static void $checkItem(GetVersionRequest v) {
    if (v is !GetVersionRequest) checkItemFailed(v, 'GetVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetVersionRequest extends GetVersionRequest with ReadonlyMessageMixin {}

class DeleteVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteVersionRequest() : super();
  DeleteVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteVersionRequest clone() => new DeleteVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteVersionRequest create() => new DeleteVersionRequest();
  static PbList<DeleteVersionRequest> createRepeated() => new PbList<DeleteVersionRequest>();
  static DeleteVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteVersionRequest();
    return _defaultInstance;
  }
  static DeleteVersionRequest _defaultInstance;
  static void $checkItem(DeleteVersionRequest v) {
    if (v is !DeleteVersionRequest) checkItemFailed(v, 'DeleteVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteVersionRequest extends DeleteVersionRequest with ReadonlyMessageMixin {}

class SetDefaultVersionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SetDefaultVersionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SetDefaultVersionRequest() : super();
  SetDefaultVersionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SetDefaultVersionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SetDefaultVersionRequest clone() => new SetDefaultVersionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SetDefaultVersionRequest create() => new SetDefaultVersionRequest();
  static PbList<SetDefaultVersionRequest> createRepeated() => new PbList<SetDefaultVersionRequest>();
  static SetDefaultVersionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySetDefaultVersionRequest();
    return _defaultInstance;
  }
  static SetDefaultVersionRequest _defaultInstance;
  static void $checkItem(SetDefaultVersionRequest v) {
    if (v is !SetDefaultVersionRequest) checkItemFailed(v, 'SetDefaultVersionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlySetDefaultVersionRequest extends SetDefaultVersionRequest with ReadonlyMessageMixin {}

class ModelServiceApi {
  RpcClient _client;
  ModelServiceApi(this._client);

  Future<Model> createModel(ClientContext ctx, CreateModelRequest request) {
    var emptyResponse = new Model();
    return _client.invoke(ctx, 'ModelService', 'CreateModel', request, emptyResponse);
  }
  Future<ListModelsResponse> listModels(ClientContext ctx, ListModelsRequest request) {
    var emptyResponse = new ListModelsResponse();
    return _client.invoke(ctx, 'ModelService', 'ListModels', request, emptyResponse);
  }
  Future<Model> getModel(ClientContext ctx, GetModelRequest request) {
    var emptyResponse = new Model();
    return _client.invoke(ctx, 'ModelService', 'GetModel', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteModel(ClientContext ctx, DeleteModelRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ModelService', 'DeleteModel', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createVersion(ClientContext ctx, CreateVersionRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ModelService', 'CreateVersion', request, emptyResponse);
  }
  Future<ListVersionsResponse> listVersions(ClientContext ctx, ListVersionsRequest request) {
    var emptyResponse = new ListVersionsResponse();
    return _client.invoke(ctx, 'ModelService', 'ListVersions', request, emptyResponse);
  }
  Future<Version> getVersion(ClientContext ctx, GetVersionRequest request) {
    var emptyResponse = new Version();
    return _client.invoke(ctx, 'ModelService', 'GetVersion', request, emptyResponse);
  }
  Future<google$longrunning.Operation> deleteVersion(ClientContext ctx, DeleteVersionRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'ModelService', 'DeleteVersion', request, emptyResponse);
  }
  Future<Version> setDefaultVersion(ClientContext ctx, SetDefaultVersionRequest request) {
    var emptyResponse = new Version();
    return _client.invoke(ctx, 'ModelService', 'SetDefaultVersion', request, emptyResponse);
  }
}

