///
//  Generated code. Do not modify.
///
library google.genomics.v1_datasets;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../protobuf/field_mask.pb.dart' as google$protobuf;
import '../../protobuf/empty.pb.dart' as google$protobuf;
import '../../iam/v1/iam_policy.pb.dart' as google$iam$v1;
import '../../iam/v1/policy.pb.dart' as google$iam$v1;

class Dataset extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Dataset')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'createTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Dataset() : super();
  Dataset.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Dataset.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Dataset clone() => new Dataset()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Dataset create() => new Dataset();
  static PbList<Dataset> createRepeated() => new PbList<Dataset>();
  static Dataset getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDataset();
    return _defaultInstance;
  }
  static Dataset _defaultInstance;
  static void $checkItem(Dataset v) {
    if (v is !Dataset) checkItemFailed(v, 'Dataset');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get projectId => $_get(1, 2, '');
  void set projectId(String v) { $_setString(1, 2, v); }
  bool hasProjectId() => $_has(1, 2);
  void clearProjectId() => clearField(2);

  String get name => $_get(2, 3, '');
  void set name(String v) { $_setString(2, 3, v); }
  bool hasName() => $_has(2, 3);
  void clearName() => clearField(3);

  google$protobuf.Timestamp get createTime => $_get(3, 4, null);
  void set createTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasCreateTime() => $_has(3, 4);
  void clearCreateTime() => clearField(4);
}

class _ReadonlyDataset extends Dataset with ReadonlyMessageMixin {}

class ListDatasetsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDatasetsRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListDatasetsRequest() : super();
  ListDatasetsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDatasetsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDatasetsRequest clone() => new ListDatasetsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDatasetsRequest create() => new ListDatasetsRequest();
  static PbList<ListDatasetsRequest> createRepeated() => new PbList<ListDatasetsRequest>();
  static ListDatasetsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDatasetsRequest();
    return _defaultInstance;
  }
  static ListDatasetsRequest _defaultInstance;
  static void $checkItem(ListDatasetsRequest v) {
    if (v is !ListDatasetsRequest) checkItemFailed(v, 'ListDatasetsRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListDatasetsRequest extends ListDatasetsRequest with ReadonlyMessageMixin {}

class ListDatasetsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListDatasetsResponse')
    ..pp/*<Dataset>*/(1, 'datasets', PbFieldType.PM, Dataset.$checkItem, Dataset.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListDatasetsResponse() : super();
  ListDatasetsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListDatasetsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListDatasetsResponse clone() => new ListDatasetsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListDatasetsResponse create() => new ListDatasetsResponse();
  static PbList<ListDatasetsResponse> createRepeated() => new PbList<ListDatasetsResponse>();
  static ListDatasetsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListDatasetsResponse();
    return _defaultInstance;
  }
  static ListDatasetsResponse _defaultInstance;
  static void $checkItem(ListDatasetsResponse v) {
    if (v is !ListDatasetsResponse) checkItemFailed(v, 'ListDatasetsResponse');
  }

  List<Dataset> get datasets => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListDatasetsResponse extends ListDatasetsResponse with ReadonlyMessageMixin {}

class CreateDatasetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateDatasetRequest')
    ..a/*<Dataset>*/(1, 'dataset', PbFieldType.OM, Dataset.getDefault, Dataset.create)
    ..hasRequiredFields = false
  ;

  CreateDatasetRequest() : super();
  CreateDatasetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateDatasetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateDatasetRequest clone() => new CreateDatasetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateDatasetRequest create() => new CreateDatasetRequest();
  static PbList<CreateDatasetRequest> createRepeated() => new PbList<CreateDatasetRequest>();
  static CreateDatasetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateDatasetRequest();
    return _defaultInstance;
  }
  static CreateDatasetRequest _defaultInstance;
  static void $checkItem(CreateDatasetRequest v) {
    if (v is !CreateDatasetRequest) checkItemFailed(v, 'CreateDatasetRequest');
  }

  Dataset get dataset => $_get(0, 1, null);
  void set dataset(Dataset v) { setField(1, v); }
  bool hasDataset() => $_has(0, 1);
  void clearDataset() => clearField(1);
}

class _ReadonlyCreateDatasetRequest extends CreateDatasetRequest with ReadonlyMessageMixin {}

class UpdateDatasetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateDatasetRequest')
    ..a/*<String>*/(1, 'datasetId', PbFieldType.OS)
    ..a/*<Dataset>*/(2, 'dataset', PbFieldType.OM, Dataset.getDefault, Dataset.create)
    ..a/*<google$protobuf.FieldMask>*/(3, 'updateMask', PbFieldType.OM, google$protobuf.FieldMask.getDefault, google$protobuf.FieldMask.create)
    ..hasRequiredFields = false
  ;

  UpdateDatasetRequest() : super();
  UpdateDatasetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateDatasetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateDatasetRequest clone() => new UpdateDatasetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateDatasetRequest create() => new UpdateDatasetRequest();
  static PbList<UpdateDatasetRequest> createRepeated() => new PbList<UpdateDatasetRequest>();
  static UpdateDatasetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateDatasetRequest();
    return _defaultInstance;
  }
  static UpdateDatasetRequest _defaultInstance;
  static void $checkItem(UpdateDatasetRequest v) {
    if (v is !UpdateDatasetRequest) checkItemFailed(v, 'UpdateDatasetRequest');
  }

  String get datasetId => $_get(0, 1, '');
  void set datasetId(String v) { $_setString(0, 1, v); }
  bool hasDatasetId() => $_has(0, 1);
  void clearDatasetId() => clearField(1);

  Dataset get dataset => $_get(1, 2, null);
  void set dataset(Dataset v) { setField(2, v); }
  bool hasDataset() => $_has(1, 2);
  void clearDataset() => clearField(2);

  google$protobuf.FieldMask get updateMask => $_get(2, 3, null);
  void set updateMask(google$protobuf.FieldMask v) { setField(3, v); }
  bool hasUpdateMask() => $_has(2, 3);
  void clearUpdateMask() => clearField(3);
}

class _ReadonlyUpdateDatasetRequest extends UpdateDatasetRequest with ReadonlyMessageMixin {}

class DeleteDatasetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteDatasetRequest')
    ..a/*<String>*/(1, 'datasetId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteDatasetRequest() : super();
  DeleteDatasetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteDatasetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteDatasetRequest clone() => new DeleteDatasetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteDatasetRequest create() => new DeleteDatasetRequest();
  static PbList<DeleteDatasetRequest> createRepeated() => new PbList<DeleteDatasetRequest>();
  static DeleteDatasetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteDatasetRequest();
    return _defaultInstance;
  }
  static DeleteDatasetRequest _defaultInstance;
  static void $checkItem(DeleteDatasetRequest v) {
    if (v is !DeleteDatasetRequest) checkItemFailed(v, 'DeleteDatasetRequest');
  }

  String get datasetId => $_get(0, 1, '');
  void set datasetId(String v) { $_setString(0, 1, v); }
  bool hasDatasetId() => $_has(0, 1);
  void clearDatasetId() => clearField(1);
}

class _ReadonlyDeleteDatasetRequest extends DeleteDatasetRequest with ReadonlyMessageMixin {}

class UndeleteDatasetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UndeleteDatasetRequest')
    ..a/*<String>*/(1, 'datasetId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  UndeleteDatasetRequest() : super();
  UndeleteDatasetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UndeleteDatasetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UndeleteDatasetRequest clone() => new UndeleteDatasetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UndeleteDatasetRequest create() => new UndeleteDatasetRequest();
  static PbList<UndeleteDatasetRequest> createRepeated() => new PbList<UndeleteDatasetRequest>();
  static UndeleteDatasetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUndeleteDatasetRequest();
    return _defaultInstance;
  }
  static UndeleteDatasetRequest _defaultInstance;
  static void $checkItem(UndeleteDatasetRequest v) {
    if (v is !UndeleteDatasetRequest) checkItemFailed(v, 'UndeleteDatasetRequest');
  }

  String get datasetId => $_get(0, 1, '');
  void set datasetId(String v) { $_setString(0, 1, v); }
  bool hasDatasetId() => $_has(0, 1);
  void clearDatasetId() => clearField(1);
}

class _ReadonlyUndeleteDatasetRequest extends UndeleteDatasetRequest with ReadonlyMessageMixin {}

class GetDatasetRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetDatasetRequest')
    ..a/*<String>*/(1, 'datasetId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetDatasetRequest() : super();
  GetDatasetRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetDatasetRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetDatasetRequest clone() => new GetDatasetRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetDatasetRequest create() => new GetDatasetRequest();
  static PbList<GetDatasetRequest> createRepeated() => new PbList<GetDatasetRequest>();
  static GetDatasetRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetDatasetRequest();
    return _defaultInstance;
  }
  static GetDatasetRequest _defaultInstance;
  static void $checkItem(GetDatasetRequest v) {
    if (v is !GetDatasetRequest) checkItemFailed(v, 'GetDatasetRequest');
  }

  String get datasetId => $_get(0, 1, '');
  void set datasetId(String v) { $_setString(0, 1, v); }
  bool hasDatasetId() => $_has(0, 1);
  void clearDatasetId() => clearField(1);
}

class _ReadonlyGetDatasetRequest extends GetDatasetRequest with ReadonlyMessageMixin {}

class DatasetServiceV1Api {
  RpcClient _client;
  DatasetServiceV1Api(this._client);

  Future<ListDatasetsResponse> listDatasets(ClientContext ctx, ListDatasetsRequest request) {
    var emptyResponse = new ListDatasetsResponse();
    return _client.invoke(ctx, 'DatasetServiceV1', 'ListDatasets', request, emptyResponse);
  }
  Future<Dataset> createDataset(ClientContext ctx, CreateDatasetRequest request) {
    var emptyResponse = new Dataset();
    return _client.invoke(ctx, 'DatasetServiceV1', 'CreateDataset', request, emptyResponse);
  }
  Future<Dataset> getDataset(ClientContext ctx, GetDatasetRequest request) {
    var emptyResponse = new Dataset();
    return _client.invoke(ctx, 'DatasetServiceV1', 'GetDataset', request, emptyResponse);
  }
  Future<Dataset> updateDataset(ClientContext ctx, UpdateDatasetRequest request) {
    var emptyResponse = new Dataset();
    return _client.invoke(ctx, 'DatasetServiceV1', 'UpdateDataset', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteDataset(ClientContext ctx, DeleteDatasetRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'DatasetServiceV1', 'DeleteDataset', request, emptyResponse);
  }
  Future<Dataset> undeleteDataset(ClientContext ctx, UndeleteDatasetRequest request) {
    var emptyResponse = new Dataset();
    return _client.invoke(ctx, 'DatasetServiceV1', 'UndeleteDataset', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> setIamPolicy(ClientContext ctx, google$iam$v1.SetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'DatasetServiceV1', 'SetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.Policy> getIamPolicy(ClientContext ctx, google$iam$v1.GetIamPolicyRequest request) {
    var emptyResponse = new google$iam$v1.Policy();
    return _client.invoke(ctx, 'DatasetServiceV1', 'GetIamPolicy', request, emptyResponse);
  }
  Future<google$iam$v1.TestIamPermissionsResponse> testIamPermissions(ClientContext ctx, google$iam$v1.TestIamPermissionsRequest request) {
    var emptyResponse = new google$iam$v1.TestIamPermissionsResponse();
    return _client.invoke(ctx, 'DatasetServiceV1', 'TestIamPermissions', request, emptyResponse);
  }
}

