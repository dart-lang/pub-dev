///
//  Generated code. Do not modify.
///
library google.longrunning_operations;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../protobuf/any.pb.dart' as google$protobuf;
import '../rpc/status.pb.dart' as google$rpc;
import '../protobuf/empty.pb.dart' as google$protobuf;

class Operation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Operation')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<google$protobuf.Any>*/(2, 'metadata', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..a/*<bool>*/(3, 'done', PbFieldType.OB)
    ..a/*<google$rpc.Status>*/(4, 'error', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..a/*<google$protobuf.Any>*/(5, 'response', PbFieldType.OM, google$protobuf.Any.getDefault, google$protobuf.Any.create)
    ..hasRequiredFields = false
  ;

  Operation() : super();
  Operation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Operation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Operation clone() => new Operation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Operation create() => new Operation();
  static PbList<Operation> createRepeated() => new PbList<Operation>();
  static Operation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOperation();
    return _defaultInstance;
  }
  static Operation _defaultInstance;
  static void $checkItem(Operation v) {
    if (v is !Operation) checkItemFailed(v, 'Operation');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  google$protobuf.Any get metadata => $_get(1, 2, null);
  void set metadata(google$protobuf.Any v) { setField(2, v); }
  bool hasMetadata() => $_has(1, 2);
  void clearMetadata() => clearField(2);

  bool get done => $_get(2, 3, false);
  void set done(bool v) { $_setBool(2, 3, v); }
  bool hasDone() => $_has(2, 3);
  void clearDone() => clearField(3);

  google$rpc.Status get error => $_get(3, 4, null);
  void set error(google$rpc.Status v) { setField(4, v); }
  bool hasError() => $_has(3, 4);
  void clearError() => clearField(4);

  google$protobuf.Any get response => $_get(4, 5, null);
  void set response(google$protobuf.Any v) { setField(5, v); }
  bool hasResponse() => $_has(4, 5);
  void clearResponse() => clearField(5);
}

class _ReadonlyOperation extends Operation with ReadonlyMessageMixin {}

class GetOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetOperationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetOperationRequest() : super();
  GetOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetOperationRequest clone() => new GetOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetOperationRequest create() => new GetOperationRequest();
  static PbList<GetOperationRequest> createRepeated() => new PbList<GetOperationRequest>();
  static GetOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetOperationRequest();
    return _defaultInstance;
  }
  static GetOperationRequest _defaultInstance;
  static void $checkItem(GetOperationRequest v) {
    if (v is !GetOperationRequest) checkItemFailed(v, 'GetOperationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetOperationRequest extends GetOperationRequest with ReadonlyMessageMixin {}

class ListOperationsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListOperationsRequest')
    ..a/*<String>*/(1, 'filter', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(4, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListOperationsRequest() : super();
  ListOperationsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListOperationsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListOperationsRequest clone() => new ListOperationsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListOperationsRequest create() => new ListOperationsRequest();
  static PbList<ListOperationsRequest> createRepeated() => new PbList<ListOperationsRequest>();
  static ListOperationsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListOperationsRequest();
    return _defaultInstance;
  }
  static ListOperationsRequest _defaultInstance;
  static void $checkItem(ListOperationsRequest v) {
    if (v is !ListOperationsRequest) checkItemFailed(v, 'ListOperationsRequest');
  }

  String get filter => $_get(0, 1, '');
  void set filter(String v) { $_setString(0, 1, v); }
  bool hasFilter() => $_has(0, 1);
  void clearFilter() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);

  String get name => $_get(3, 4, '');
  void set name(String v) { $_setString(3, 4, v); }
  bool hasName() => $_has(3, 4);
  void clearName() => clearField(4);
}

class _ReadonlyListOperationsRequest extends ListOperationsRequest with ReadonlyMessageMixin {}

class ListOperationsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListOperationsResponse')
    ..pp/*<Operation>*/(1, 'operations', PbFieldType.PM, Operation.$checkItem, Operation.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListOperationsResponse() : super();
  ListOperationsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListOperationsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListOperationsResponse clone() => new ListOperationsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListOperationsResponse create() => new ListOperationsResponse();
  static PbList<ListOperationsResponse> createRepeated() => new PbList<ListOperationsResponse>();
  static ListOperationsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListOperationsResponse();
    return _defaultInstance;
  }
  static ListOperationsResponse _defaultInstance;
  static void $checkItem(ListOperationsResponse v) {
    if (v is !ListOperationsResponse) checkItemFailed(v, 'ListOperationsResponse');
  }

  List<Operation> get operations => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListOperationsResponse extends ListOperationsResponse with ReadonlyMessageMixin {}

class CancelOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CancelOperationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CancelOperationRequest() : super();
  CancelOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CancelOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CancelOperationRequest clone() => new CancelOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CancelOperationRequest create() => new CancelOperationRequest();
  static PbList<CancelOperationRequest> createRepeated() => new PbList<CancelOperationRequest>();
  static CancelOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCancelOperationRequest();
    return _defaultInstance;
  }
  static CancelOperationRequest _defaultInstance;
  static void $checkItem(CancelOperationRequest v) {
    if (v is !CancelOperationRequest) checkItemFailed(v, 'CancelOperationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyCancelOperationRequest extends CancelOperationRequest with ReadonlyMessageMixin {}

class DeleteOperationRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteOperationRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteOperationRequest() : super();
  DeleteOperationRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteOperationRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteOperationRequest clone() => new DeleteOperationRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteOperationRequest create() => new DeleteOperationRequest();
  static PbList<DeleteOperationRequest> createRepeated() => new PbList<DeleteOperationRequest>();
  static DeleteOperationRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteOperationRequest();
    return _defaultInstance;
  }
  static DeleteOperationRequest _defaultInstance;
  static void $checkItem(DeleteOperationRequest v) {
    if (v is !DeleteOperationRequest) checkItemFailed(v, 'DeleteOperationRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteOperationRequest extends DeleteOperationRequest with ReadonlyMessageMixin {}

class OperationsApi {
  RpcClient _client;
  OperationsApi(this._client);

  Future<ListOperationsResponse> listOperations(ClientContext ctx, ListOperationsRequest request) {
    var emptyResponse = new ListOperationsResponse();
    return _client.invoke(ctx, 'Operations', 'ListOperations', request, emptyResponse);
  }
  Future<Operation> getOperation(ClientContext ctx, GetOperationRequest request) {
    var emptyResponse = new Operation();
    return _client.invoke(ctx, 'Operations', 'GetOperation', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteOperation(ClientContext ctx, DeleteOperationRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Operations', 'DeleteOperation', request, emptyResponse);
  }
  Future<google$protobuf.Empty> cancelOperation(ClientContext ctx, CancelOperationRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Operations', 'CancelOperation', request, emptyResponse);
  }
}

