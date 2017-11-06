///
//  Generated code. Do not modify.
///
library google.storagetransfer.v1_transfer;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'transfer_types.pb.dart';
import '../../protobuf/field_mask.pb.dart' as google$protobuf;
import '../../protobuf/empty.pb.dart' as google$protobuf;

class GetGoogleServiceAccountRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetGoogleServiceAccountRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetGoogleServiceAccountRequest() : super();
  GetGoogleServiceAccountRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetGoogleServiceAccountRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetGoogleServiceAccountRequest clone() => new GetGoogleServiceAccountRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetGoogleServiceAccountRequest create() => new GetGoogleServiceAccountRequest();
  static PbList<GetGoogleServiceAccountRequest> createRepeated() => new PbList<GetGoogleServiceAccountRequest>();
  static GetGoogleServiceAccountRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetGoogleServiceAccountRequest();
    return _defaultInstance;
  }
  static GetGoogleServiceAccountRequest _defaultInstance;
  static void $checkItem(GetGoogleServiceAccountRequest v) {
    if (v is !GetGoogleServiceAccountRequest) checkItemFailed(v, 'GetGoogleServiceAccountRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);
}

class _ReadonlyGetGoogleServiceAccountRequest extends GetGoogleServiceAccountRequest with ReadonlyMessageMixin {}

class CreateTransferJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTransferJobRequest')
    ..a/*<TransferJob>*/(1, 'transferJob', PbFieldType.OM, TransferJob.getDefault, TransferJob.create)
    ..hasRequiredFields = false
  ;

  CreateTransferJobRequest() : super();
  CreateTransferJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateTransferJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateTransferJobRequest clone() => new CreateTransferJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateTransferJobRequest create() => new CreateTransferJobRequest();
  static PbList<CreateTransferJobRequest> createRepeated() => new PbList<CreateTransferJobRequest>();
  static CreateTransferJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateTransferJobRequest();
    return _defaultInstance;
  }
  static CreateTransferJobRequest _defaultInstance;
  static void $checkItem(CreateTransferJobRequest v) {
    if (v is !CreateTransferJobRequest) checkItemFailed(v, 'CreateTransferJobRequest');
  }

  TransferJob get transferJob => $_get(0, 1, null);
  void set transferJob(TransferJob v) { setField(1, v); }
  bool hasTransferJob() => $_has(0, 1);
  void clearTransferJob() => clearField(1);
}

class _ReadonlyCreateTransferJobRequest extends CreateTransferJobRequest with ReadonlyMessageMixin {}

class UpdateTransferJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateTransferJobRequest')
    ..a/*<String>*/(1, 'jobName', PbFieldType.OS)
    ..a/*<String>*/(2, 'projectId', PbFieldType.OS)
    ..a/*<TransferJob>*/(3, 'transferJob', PbFieldType.OM, TransferJob.getDefault, TransferJob.create)
    ..a/*<google$protobuf.FieldMask>*/(4, 'updateTransferJobFieldMask', PbFieldType.OM, google$protobuf.FieldMask.getDefault, google$protobuf.FieldMask.create)
    ..hasRequiredFields = false
  ;

  UpdateTransferJobRequest() : super();
  UpdateTransferJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateTransferJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateTransferJobRequest clone() => new UpdateTransferJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateTransferJobRequest create() => new UpdateTransferJobRequest();
  static PbList<UpdateTransferJobRequest> createRepeated() => new PbList<UpdateTransferJobRequest>();
  static UpdateTransferJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateTransferJobRequest();
    return _defaultInstance;
  }
  static UpdateTransferJobRequest _defaultInstance;
  static void $checkItem(UpdateTransferJobRequest v) {
    if (v is !UpdateTransferJobRequest) checkItemFailed(v, 'UpdateTransferJobRequest');
  }

  String get jobName => $_get(0, 1, '');
  void set jobName(String v) { $_setString(0, 1, v); }
  bool hasJobName() => $_has(0, 1);
  void clearJobName() => clearField(1);

  String get projectId => $_get(1, 2, '');
  void set projectId(String v) { $_setString(1, 2, v); }
  bool hasProjectId() => $_has(1, 2);
  void clearProjectId() => clearField(2);

  TransferJob get transferJob => $_get(2, 3, null);
  void set transferJob(TransferJob v) { setField(3, v); }
  bool hasTransferJob() => $_has(2, 3);
  void clearTransferJob() => clearField(3);

  google$protobuf.FieldMask get updateTransferJobFieldMask => $_get(3, 4, null);
  void set updateTransferJobFieldMask(google$protobuf.FieldMask v) { setField(4, v); }
  bool hasUpdateTransferJobFieldMask() => $_has(3, 4);
  void clearUpdateTransferJobFieldMask() => clearField(4);
}

class _ReadonlyUpdateTransferJobRequest extends UpdateTransferJobRequest with ReadonlyMessageMixin {}

class GetTransferJobRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetTransferJobRequest')
    ..a/*<String>*/(1, 'jobName', PbFieldType.OS)
    ..a/*<String>*/(2, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetTransferJobRequest() : super();
  GetTransferJobRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetTransferJobRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetTransferJobRequest clone() => new GetTransferJobRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetTransferJobRequest create() => new GetTransferJobRequest();
  static PbList<GetTransferJobRequest> createRepeated() => new PbList<GetTransferJobRequest>();
  static GetTransferJobRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetTransferJobRequest();
    return _defaultInstance;
  }
  static GetTransferJobRequest _defaultInstance;
  static void $checkItem(GetTransferJobRequest v) {
    if (v is !GetTransferJobRequest) checkItemFailed(v, 'GetTransferJobRequest');
  }

  String get jobName => $_get(0, 1, '');
  void set jobName(String v) { $_setString(0, 1, v); }
  bool hasJobName() => $_has(0, 1);
  void clearJobName() => clearField(1);

  String get projectId => $_get(1, 2, '');
  void set projectId(String v) { $_setString(1, 2, v); }
  bool hasProjectId() => $_has(1, 2);
  void clearProjectId() => clearField(2);
}

class _ReadonlyGetTransferJobRequest extends GetTransferJobRequest with ReadonlyMessageMixin {}

class ListTransferJobsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTransferJobsRequest')
    ..a/*<String>*/(1, 'filter', PbFieldType.OS)
    ..a/*<int>*/(4, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(5, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTransferJobsRequest() : super();
  ListTransferJobsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTransferJobsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTransferJobsRequest clone() => new ListTransferJobsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTransferJobsRequest create() => new ListTransferJobsRequest();
  static PbList<ListTransferJobsRequest> createRepeated() => new PbList<ListTransferJobsRequest>();
  static ListTransferJobsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTransferJobsRequest();
    return _defaultInstance;
  }
  static ListTransferJobsRequest _defaultInstance;
  static void $checkItem(ListTransferJobsRequest v) {
    if (v is !ListTransferJobsRequest) checkItemFailed(v, 'ListTransferJobsRequest');
  }

  String get filter => $_get(0, 1, '');
  void set filter(String v) { $_setString(0, 1, v); }
  bool hasFilter() => $_has(0, 1);
  void clearFilter() => clearField(1);

  int get pageSize => $_get(1, 4, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 4, v); }
  bool hasPageSize() => $_has(1, 4);
  void clearPageSize() => clearField(4);

  String get pageToken => $_get(2, 5, '');
  void set pageToken(String v) { $_setString(2, 5, v); }
  bool hasPageToken() => $_has(2, 5);
  void clearPageToken() => clearField(5);
}

class _ReadonlyListTransferJobsRequest extends ListTransferJobsRequest with ReadonlyMessageMixin {}

class ListTransferJobsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTransferJobsResponse')
    ..pp/*<TransferJob>*/(1, 'transferJobs', PbFieldType.PM, TransferJob.$checkItem, TransferJob.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTransferJobsResponse() : super();
  ListTransferJobsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTransferJobsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTransferJobsResponse clone() => new ListTransferJobsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTransferJobsResponse create() => new ListTransferJobsResponse();
  static PbList<ListTransferJobsResponse> createRepeated() => new PbList<ListTransferJobsResponse>();
  static ListTransferJobsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTransferJobsResponse();
    return _defaultInstance;
  }
  static ListTransferJobsResponse _defaultInstance;
  static void $checkItem(ListTransferJobsResponse v) {
    if (v is !ListTransferJobsResponse) checkItemFailed(v, 'ListTransferJobsResponse');
  }

  List<TransferJob> get transferJobs => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTransferJobsResponse extends ListTransferJobsResponse with ReadonlyMessageMixin {}

class PauseTransferOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PauseTransferOperationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  PauseTransferOperationRequest() : super();
  PauseTransferOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PauseTransferOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PauseTransferOperationRequest clone() => new PauseTransferOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PauseTransferOperationRequest create() => new PauseTransferOperationRequest();
  static PbList<PauseTransferOperationRequest> createRepeated() => new PbList<PauseTransferOperationRequest>();
  static PauseTransferOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPauseTransferOperationRequest();
    return _defaultInstance;
  }
  static PauseTransferOperationRequest _defaultInstance;
  static void $checkItem(PauseTransferOperationRequest v) {
    if (v is !PauseTransferOperationRequest) checkItemFailed(v, 'PauseTransferOperationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyPauseTransferOperationRequest extends PauseTransferOperationRequest with ReadonlyMessageMixin {}

class ResumeTransferOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResumeTransferOperationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ResumeTransferOperationRequest() : super();
  ResumeTransferOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResumeTransferOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResumeTransferOperationRequest clone() => new ResumeTransferOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResumeTransferOperationRequest create() => new ResumeTransferOperationRequest();
  static PbList<ResumeTransferOperationRequest> createRepeated() => new PbList<ResumeTransferOperationRequest>();
  static ResumeTransferOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResumeTransferOperationRequest();
    return _defaultInstance;
  }
  static ResumeTransferOperationRequest _defaultInstance;
  static void $checkItem(ResumeTransferOperationRequest v) {
    if (v is !ResumeTransferOperationRequest) checkItemFailed(v, 'ResumeTransferOperationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyResumeTransferOperationRequest extends ResumeTransferOperationRequest with ReadonlyMessageMixin {}

class StorageTransferServiceApi {
  RpcClient _client;
  StorageTransferServiceApi(this._client);

  Future<GoogleServiceAccount> getGoogleServiceAccount(ClientContext ctx, GetGoogleServiceAccountRequest request) {
    var emptyResponse = new GoogleServiceAccount();
    return _client.invoke(ctx, 'StorageTransferService', 'GetGoogleServiceAccount', request, emptyResponse);
  }
  Future<TransferJob> createTransferJob(ClientContext ctx, CreateTransferJobRequest request) {
    var emptyResponse = new TransferJob();
    return _client.invoke(ctx, 'StorageTransferService', 'CreateTransferJob', request, emptyResponse);
  }
  Future<TransferJob> updateTransferJob(ClientContext ctx, UpdateTransferJobRequest request) {
    var emptyResponse = new TransferJob();
    return _client.invoke(ctx, 'StorageTransferService', 'UpdateTransferJob', request, emptyResponse);
  }
  Future<TransferJob> getTransferJob(ClientContext ctx, GetTransferJobRequest request) {
    var emptyResponse = new TransferJob();
    return _client.invoke(ctx, 'StorageTransferService', 'GetTransferJob', request, emptyResponse);
  }
  Future<ListTransferJobsResponse> listTransferJobs(ClientContext ctx, ListTransferJobsRequest request) {
    var emptyResponse = new ListTransferJobsResponse();
    return _client.invoke(ctx, 'StorageTransferService', 'ListTransferJobs', request, emptyResponse);
  }
  Future<google$protobuf.Empty> pauseTransferOperation(ClientContext ctx, PauseTransferOperationRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'StorageTransferService', 'PauseTransferOperation', request, emptyResponse);
  }
  Future<google$protobuf.Empty> resumeTransferOperation(ClientContext ctx, ResumeTransferOperationRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'StorageTransferService', 'ResumeTransferOperation', request, emptyResponse);
  }
}

