///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_instance_admin;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'instance.pb.dart';
import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../protobuf/empty.pb.dart' as google$protobuf;

class CreateInstanceRequest_ClustersEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateInstanceRequest_ClustersEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<Cluster>*/(2, 'value', PbFieldType.OM, Cluster.getDefault, Cluster.create)
    ..hasRequiredFields = false
  ;

  CreateInstanceRequest_ClustersEntry() : super();
  CreateInstanceRequest_ClustersEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateInstanceRequest_ClustersEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateInstanceRequest_ClustersEntry clone() => new CreateInstanceRequest_ClustersEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateInstanceRequest_ClustersEntry create() => new CreateInstanceRequest_ClustersEntry();
  static PbList<CreateInstanceRequest_ClustersEntry> createRepeated() => new PbList<CreateInstanceRequest_ClustersEntry>();
  static CreateInstanceRequest_ClustersEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateInstanceRequest_ClustersEntry();
    return _defaultInstance;
  }
  static CreateInstanceRequest_ClustersEntry _defaultInstance;
  static void $checkItem(CreateInstanceRequest_ClustersEntry v) {
    if (v is !CreateInstanceRequest_ClustersEntry) checkItemFailed(v, 'CreateInstanceRequest_ClustersEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Cluster get value => $_get(1, 2, null);
  void set value(Cluster v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyCreateInstanceRequest_ClustersEntry extends CreateInstanceRequest_ClustersEntry with ReadonlyMessageMixin {}

class CreateInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateInstanceRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'instanceId', PbFieldType.OS)
    ..a/*<Instance>*/(3, 'instance', PbFieldType.OM, Instance.getDefault, Instance.create)
    ..pp/*<CreateInstanceRequest_ClustersEntry>*/(4, 'clusters', PbFieldType.PM, CreateInstanceRequest_ClustersEntry.$checkItem, CreateInstanceRequest_ClustersEntry.create)
    ..hasRequiredFields = false
  ;

  CreateInstanceRequest() : super();
  CreateInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateInstanceRequest clone() => new CreateInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateInstanceRequest create() => new CreateInstanceRequest();
  static PbList<CreateInstanceRequest> createRepeated() => new PbList<CreateInstanceRequest>();
  static CreateInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateInstanceRequest();
    return _defaultInstance;
  }
  static CreateInstanceRequest _defaultInstance;
  static void $checkItem(CreateInstanceRequest v) {
    if (v is !CreateInstanceRequest) checkItemFailed(v, 'CreateInstanceRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get instanceId => $_get(1, 2, '');
  void set instanceId(String v) { $_setString(1, 2, v); }
  bool hasInstanceId() => $_has(1, 2);
  void clearInstanceId() => clearField(2);

  Instance get instance => $_get(2, 3, null);
  void set instance(Instance v) { setField(3, v); }
  bool hasInstance() => $_has(2, 3);
  void clearInstance() => clearField(3);

  List<CreateInstanceRequest_ClustersEntry> get clusters => $_get(3, 4, null);
}

class _ReadonlyCreateInstanceRequest extends CreateInstanceRequest with ReadonlyMessageMixin {}

class GetInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetInstanceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetInstanceRequest() : super();
  GetInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetInstanceRequest clone() => new GetInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetInstanceRequest create() => new GetInstanceRequest();
  static PbList<GetInstanceRequest> createRepeated() => new PbList<GetInstanceRequest>();
  static GetInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetInstanceRequest();
    return _defaultInstance;
  }
  static GetInstanceRequest _defaultInstance;
  static void $checkItem(GetInstanceRequest v) {
    if (v is !GetInstanceRequest) checkItemFailed(v, 'GetInstanceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetInstanceRequest extends GetInstanceRequest with ReadonlyMessageMixin {}

class ListInstancesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListInstancesRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListInstancesRequest() : super();
  ListInstancesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListInstancesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListInstancesRequest clone() => new ListInstancesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListInstancesRequest create() => new ListInstancesRequest();
  static PbList<ListInstancesRequest> createRepeated() => new PbList<ListInstancesRequest>();
  static ListInstancesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListInstancesRequest();
    return _defaultInstance;
  }
  static ListInstancesRequest _defaultInstance;
  static void $checkItem(ListInstancesRequest v) {
    if (v is !ListInstancesRequest) checkItemFailed(v, 'ListInstancesRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);
}

class _ReadonlyListInstancesRequest extends ListInstancesRequest with ReadonlyMessageMixin {}

class ListInstancesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListInstancesResponse')
    ..pp/*<Instance>*/(1, 'instances', PbFieldType.PM, Instance.$checkItem, Instance.create)
    ..p/*<String>*/(2, 'failedLocations', PbFieldType.PS)
    ..a/*<String>*/(3, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListInstancesResponse() : super();
  ListInstancesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListInstancesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListInstancesResponse clone() => new ListInstancesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListInstancesResponse create() => new ListInstancesResponse();
  static PbList<ListInstancesResponse> createRepeated() => new PbList<ListInstancesResponse>();
  static ListInstancesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListInstancesResponse();
    return _defaultInstance;
  }
  static ListInstancesResponse _defaultInstance;
  static void $checkItem(ListInstancesResponse v) {
    if (v is !ListInstancesResponse) checkItemFailed(v, 'ListInstancesResponse');
  }

  List<Instance> get instances => $_get(0, 1, null);

  List<String> get failedLocations => $_get(1, 2, null);

  String get nextPageToken => $_get(2, 3, '');
  void set nextPageToken(String v) { $_setString(2, 3, v); }
  bool hasNextPageToken() => $_has(2, 3);
  void clearNextPageToken() => clearField(3);
}

class _ReadonlyListInstancesResponse extends ListInstancesResponse with ReadonlyMessageMixin {}

class DeleteInstanceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteInstanceRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteInstanceRequest() : super();
  DeleteInstanceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteInstanceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteInstanceRequest clone() => new DeleteInstanceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteInstanceRequest create() => new DeleteInstanceRequest();
  static PbList<DeleteInstanceRequest> createRepeated() => new PbList<DeleteInstanceRequest>();
  static DeleteInstanceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteInstanceRequest();
    return _defaultInstance;
  }
  static DeleteInstanceRequest _defaultInstance;
  static void $checkItem(DeleteInstanceRequest v) {
    if (v is !DeleteInstanceRequest) checkItemFailed(v, 'DeleteInstanceRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteInstanceRequest extends DeleteInstanceRequest with ReadonlyMessageMixin {}

class CreateClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateClusterRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'clusterId', PbFieldType.OS)
    ..a/*<Cluster>*/(3, 'cluster', PbFieldType.OM, Cluster.getDefault, Cluster.create)
    ..hasRequiredFields = false
  ;

  CreateClusterRequest() : super();
  CreateClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateClusterRequest clone() => new CreateClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateClusterRequest create() => new CreateClusterRequest();
  static PbList<CreateClusterRequest> createRepeated() => new PbList<CreateClusterRequest>();
  static CreateClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateClusterRequest();
    return _defaultInstance;
  }
  static CreateClusterRequest _defaultInstance;
  static void $checkItem(CreateClusterRequest v) {
    if (v is !CreateClusterRequest) checkItemFailed(v, 'CreateClusterRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get clusterId => $_get(1, 2, '');
  void set clusterId(String v) { $_setString(1, 2, v); }
  bool hasClusterId() => $_has(1, 2);
  void clearClusterId() => clearField(2);

  Cluster get cluster => $_get(2, 3, null);
  void set cluster(Cluster v) { setField(3, v); }
  bool hasCluster() => $_has(2, 3);
  void clearCluster() => clearField(3);
}

class _ReadonlyCreateClusterRequest extends CreateClusterRequest with ReadonlyMessageMixin {}

class GetClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetClusterRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetClusterRequest() : super();
  GetClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetClusterRequest clone() => new GetClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetClusterRequest create() => new GetClusterRequest();
  static PbList<GetClusterRequest> createRepeated() => new PbList<GetClusterRequest>();
  static GetClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetClusterRequest();
    return _defaultInstance;
  }
  static GetClusterRequest _defaultInstance;
  static void $checkItem(GetClusterRequest v) {
    if (v is !GetClusterRequest) checkItemFailed(v, 'GetClusterRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetClusterRequest extends GetClusterRequest with ReadonlyMessageMixin {}

class ListClustersRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListClustersRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListClustersRequest() : super();
  ListClustersRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListClustersRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListClustersRequest clone() => new ListClustersRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListClustersRequest create() => new ListClustersRequest();
  static PbList<ListClustersRequest> createRepeated() => new PbList<ListClustersRequest>();
  static ListClustersRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListClustersRequest();
    return _defaultInstance;
  }
  static ListClustersRequest _defaultInstance;
  static void $checkItem(ListClustersRequest v) {
    if (v is !ListClustersRequest) checkItemFailed(v, 'ListClustersRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);
}

class _ReadonlyListClustersRequest extends ListClustersRequest with ReadonlyMessageMixin {}

class ListClustersResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListClustersResponse')
    ..pp/*<Cluster>*/(1, 'clusters', PbFieldType.PM, Cluster.$checkItem, Cluster.create)
    ..p/*<String>*/(2, 'failedLocations', PbFieldType.PS)
    ..a/*<String>*/(3, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListClustersResponse() : super();
  ListClustersResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListClustersResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListClustersResponse clone() => new ListClustersResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListClustersResponse create() => new ListClustersResponse();
  static PbList<ListClustersResponse> createRepeated() => new PbList<ListClustersResponse>();
  static ListClustersResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListClustersResponse();
    return _defaultInstance;
  }
  static ListClustersResponse _defaultInstance;
  static void $checkItem(ListClustersResponse v) {
    if (v is !ListClustersResponse) checkItemFailed(v, 'ListClustersResponse');
  }

  List<Cluster> get clusters => $_get(0, 1, null);

  List<String> get failedLocations => $_get(1, 2, null);

  String get nextPageToken => $_get(2, 3, '');
  void set nextPageToken(String v) { $_setString(2, 3, v); }
  bool hasNextPageToken() => $_has(2, 3);
  void clearNextPageToken() => clearField(3);
}

class _ReadonlyListClustersResponse extends ListClustersResponse with ReadonlyMessageMixin {}

class DeleteClusterRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteClusterRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteClusterRequest() : super();
  DeleteClusterRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteClusterRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteClusterRequest clone() => new DeleteClusterRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteClusterRequest create() => new DeleteClusterRequest();
  static PbList<DeleteClusterRequest> createRepeated() => new PbList<DeleteClusterRequest>();
  static DeleteClusterRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteClusterRequest();
    return _defaultInstance;
  }
  static DeleteClusterRequest _defaultInstance;
  static void $checkItem(DeleteClusterRequest v) {
    if (v is !DeleteClusterRequest) checkItemFailed(v, 'DeleteClusterRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteClusterRequest extends DeleteClusterRequest with ReadonlyMessageMixin {}

class CreateInstanceMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateInstanceMetadata')
    ..a/*<CreateInstanceRequest>*/(1, 'originalRequest', PbFieldType.OM, CreateInstanceRequest.getDefault, CreateInstanceRequest.create)
    ..a/*<google$protobuf.Timestamp>*/(2, 'requestTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'finishTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CreateInstanceMetadata() : super();
  CreateInstanceMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateInstanceMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateInstanceMetadata clone() => new CreateInstanceMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateInstanceMetadata create() => new CreateInstanceMetadata();
  static PbList<CreateInstanceMetadata> createRepeated() => new PbList<CreateInstanceMetadata>();
  static CreateInstanceMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateInstanceMetadata();
    return _defaultInstance;
  }
  static CreateInstanceMetadata _defaultInstance;
  static void $checkItem(CreateInstanceMetadata v) {
    if (v is !CreateInstanceMetadata) checkItemFailed(v, 'CreateInstanceMetadata');
  }

  CreateInstanceRequest get originalRequest => $_get(0, 1, null);
  void set originalRequest(CreateInstanceRequest v) { setField(1, v); }
  bool hasOriginalRequest() => $_has(0, 1);
  void clearOriginalRequest() => clearField(1);

  google$protobuf.Timestamp get requestTime => $_get(1, 2, null);
  void set requestTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasRequestTime() => $_has(1, 2);
  void clearRequestTime() => clearField(2);

  google$protobuf.Timestamp get finishTime => $_get(2, 3, null);
  void set finishTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasFinishTime() => $_has(2, 3);
  void clearFinishTime() => clearField(3);
}

class _ReadonlyCreateInstanceMetadata extends CreateInstanceMetadata with ReadonlyMessageMixin {}

class UpdateClusterMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateClusterMetadata')
    ..a/*<Cluster>*/(1, 'originalRequest', PbFieldType.OM, Cluster.getDefault, Cluster.create)
    ..a/*<google$protobuf.Timestamp>*/(2, 'requestTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'finishTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  UpdateClusterMetadata() : super();
  UpdateClusterMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateClusterMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateClusterMetadata clone() => new UpdateClusterMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateClusterMetadata create() => new UpdateClusterMetadata();
  static PbList<UpdateClusterMetadata> createRepeated() => new PbList<UpdateClusterMetadata>();
  static UpdateClusterMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateClusterMetadata();
    return _defaultInstance;
  }
  static UpdateClusterMetadata _defaultInstance;
  static void $checkItem(UpdateClusterMetadata v) {
    if (v is !UpdateClusterMetadata) checkItemFailed(v, 'UpdateClusterMetadata');
  }

  Cluster get originalRequest => $_get(0, 1, null);
  void set originalRequest(Cluster v) { setField(1, v); }
  bool hasOriginalRequest() => $_has(0, 1);
  void clearOriginalRequest() => clearField(1);

  google$protobuf.Timestamp get requestTime => $_get(1, 2, null);
  void set requestTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasRequestTime() => $_has(1, 2);
  void clearRequestTime() => clearField(2);

  google$protobuf.Timestamp get finishTime => $_get(2, 3, null);
  void set finishTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasFinishTime() => $_has(2, 3);
  void clearFinishTime() => clearField(3);
}

class _ReadonlyUpdateClusterMetadata extends UpdateClusterMetadata with ReadonlyMessageMixin {}

class BigtableInstanceAdminApi {
  RpcClient _client;
  BigtableInstanceAdminApi(this._client);

  Future<google$longrunning.Operation> createInstance(ClientContext ctx, CreateInstanceRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'CreateInstance', request, emptyResponse);
  }
  Future<Instance> getInstance(ClientContext ctx, GetInstanceRequest request) {
    var emptyResponse = new Instance();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'GetInstance', request, emptyResponse);
  }
  Future<ListInstancesResponse> listInstances(ClientContext ctx, ListInstancesRequest request) {
    var emptyResponse = new ListInstancesResponse();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'ListInstances', request, emptyResponse);
  }
  Future<Instance> updateInstance(ClientContext ctx, Instance request) {
    var emptyResponse = new Instance();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'UpdateInstance', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteInstance(ClientContext ctx, DeleteInstanceRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'DeleteInstance', request, emptyResponse);
  }
  Future<google$longrunning.Operation> createCluster(ClientContext ctx, CreateClusterRequest request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'CreateCluster', request, emptyResponse);
  }
  Future<Cluster> getCluster(ClientContext ctx, GetClusterRequest request) {
    var emptyResponse = new Cluster();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'GetCluster', request, emptyResponse);
  }
  Future<ListClustersResponse> listClusters(ClientContext ctx, ListClustersRequest request) {
    var emptyResponse = new ListClustersResponse();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'ListClusters', request, emptyResponse);
  }
  Future<google$longrunning.Operation> updateCluster(ClientContext ctx, Cluster request) {
    var emptyResponse = new google$longrunning.Operation();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'UpdateCluster', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteCluster(ClientContext ctx, DeleteClusterRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableInstanceAdmin', 'DeleteCluster', request, emptyResponse);
  }
}

