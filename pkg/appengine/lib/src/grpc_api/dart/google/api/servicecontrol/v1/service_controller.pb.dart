///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_service_controller;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'operation.pb.dart';
import 'check_error.pb.dart';
import '../../../rpc/status.pb.dart' as google$rpc;

class CheckRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..a/*<Operation>*/(2, 'operation', PbFieldType.OM, Operation.getDefault, Operation.create)
    ..a/*<String>*/(4, 'serviceConfigId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CheckRequest() : super();
  CheckRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckRequest clone() => new CheckRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CheckRequest create() => new CheckRequest();
  static PbList<CheckRequest> createRepeated() => new PbList<CheckRequest>();
  static CheckRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCheckRequest();
    return _defaultInstance;
  }
  static CheckRequest _defaultInstance;
  static void $checkItem(CheckRequest v) {
    if (v is !CheckRequest) checkItemFailed(v, 'CheckRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  Operation get operation => $_get(1, 2, null);
  void set operation(Operation v) { setField(2, v); }
  bool hasOperation() => $_has(1, 2);
  void clearOperation() => clearField(2);

  String get serviceConfigId => $_get(2, 4, '');
  void set serviceConfigId(String v) { $_setString(2, 4, v); }
  bool hasServiceConfigId() => $_has(2, 4);
  void clearServiceConfigId() => clearField(4);
}

class _ReadonlyCheckRequest extends CheckRequest with ReadonlyMessageMixin {}

class CheckResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckResponse')
    ..a/*<String>*/(1, 'operationId', PbFieldType.OS)
    ..pp/*<CheckError>*/(2, 'checkErrors', PbFieldType.PM, CheckError.$checkItem, CheckError.create)
    ..a/*<String>*/(5, 'serviceConfigId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CheckResponse() : super();
  CheckResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckResponse clone() => new CheckResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CheckResponse create() => new CheckResponse();
  static PbList<CheckResponse> createRepeated() => new PbList<CheckResponse>();
  static CheckResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCheckResponse();
    return _defaultInstance;
  }
  static CheckResponse _defaultInstance;
  static void $checkItem(CheckResponse v) {
    if (v is !CheckResponse) checkItemFailed(v, 'CheckResponse');
  }

  String get operationId => $_get(0, 1, '');
  void set operationId(String v) { $_setString(0, 1, v); }
  bool hasOperationId() => $_has(0, 1);
  void clearOperationId() => clearField(1);

  List<CheckError> get checkErrors => $_get(1, 2, null);

  String get serviceConfigId => $_get(2, 5, '');
  void set serviceConfigId(String v) { $_setString(2, 5, v); }
  bool hasServiceConfigId() => $_has(2, 5);
  void clearServiceConfigId() => clearField(5);
}

class _ReadonlyCheckResponse extends CheckResponse with ReadonlyMessageMixin {}

class ReportRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportRequest')
    ..a/*<String>*/(1, 'serviceName', PbFieldType.OS)
    ..pp/*<Operation>*/(2, 'operations', PbFieldType.PM, Operation.$checkItem, Operation.create)
    ..a/*<String>*/(3, 'serviceConfigId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ReportRequest() : super();
  ReportRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportRequest clone() => new ReportRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportRequest create() => new ReportRequest();
  static PbList<ReportRequest> createRepeated() => new PbList<ReportRequest>();
  static ReportRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportRequest();
    return _defaultInstance;
  }
  static ReportRequest _defaultInstance;
  static void $checkItem(ReportRequest v) {
    if (v is !ReportRequest) checkItemFailed(v, 'ReportRequest');
  }

  String get serviceName => $_get(0, 1, '');
  void set serviceName(String v) { $_setString(0, 1, v); }
  bool hasServiceName() => $_has(0, 1);
  void clearServiceName() => clearField(1);

  List<Operation> get operations => $_get(1, 2, null);

  String get serviceConfigId => $_get(2, 3, '');
  void set serviceConfigId(String v) { $_setString(2, 3, v); }
  bool hasServiceConfigId() => $_has(2, 3);
  void clearServiceConfigId() => clearField(3);
}

class _ReadonlyReportRequest extends ReportRequest with ReadonlyMessageMixin {}

class ReportResponse_ReportError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportResponse_ReportError')
    ..a/*<String>*/(1, 'operationId', PbFieldType.OS)
    ..a/*<google$rpc.Status>*/(2, 'status', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..hasRequiredFields = false
  ;

  ReportResponse_ReportError() : super();
  ReportResponse_ReportError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportResponse_ReportError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportResponse_ReportError clone() => new ReportResponse_ReportError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportResponse_ReportError create() => new ReportResponse_ReportError();
  static PbList<ReportResponse_ReportError> createRepeated() => new PbList<ReportResponse_ReportError>();
  static ReportResponse_ReportError getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportResponse_ReportError();
    return _defaultInstance;
  }
  static ReportResponse_ReportError _defaultInstance;
  static void $checkItem(ReportResponse_ReportError v) {
    if (v is !ReportResponse_ReportError) checkItemFailed(v, 'ReportResponse_ReportError');
  }

  String get operationId => $_get(0, 1, '');
  void set operationId(String v) { $_setString(0, 1, v); }
  bool hasOperationId() => $_has(0, 1);
  void clearOperationId() => clearField(1);

  google$rpc.Status get status => $_get(1, 2, null);
  void set status(google$rpc.Status v) { setField(2, v); }
  bool hasStatus() => $_has(1, 2);
  void clearStatus() => clearField(2);
}

class _ReadonlyReportResponse_ReportError extends ReportResponse_ReportError with ReadonlyMessageMixin {}

class ReportResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReportResponse')
    ..pp/*<ReportResponse_ReportError>*/(1, 'reportErrors', PbFieldType.PM, ReportResponse_ReportError.$checkItem, ReportResponse_ReportError.create)
    ..a/*<String>*/(2, 'serviceConfigId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ReportResponse() : super();
  ReportResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReportResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReportResponse clone() => new ReportResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReportResponse create() => new ReportResponse();
  static PbList<ReportResponse> createRepeated() => new PbList<ReportResponse>();
  static ReportResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReportResponse();
    return _defaultInstance;
  }
  static ReportResponse _defaultInstance;
  static void $checkItem(ReportResponse v) {
    if (v is !ReportResponse) checkItemFailed(v, 'ReportResponse');
  }

  List<ReportResponse_ReportError> get reportErrors => $_get(0, 1, null);

  String get serviceConfigId => $_get(1, 2, '');
  void set serviceConfigId(String v) { $_setString(1, 2, v); }
  bool hasServiceConfigId() => $_has(1, 2);
  void clearServiceConfigId() => clearField(2);
}

class _ReadonlyReportResponse extends ReportResponse with ReadonlyMessageMixin {}

class ServiceControllerApi {
  RpcClient _client;
  ServiceControllerApi(this._client);

  Future<CheckResponse> check(ClientContext ctx, CheckRequest request) {
    var emptyResponse = new CheckResponse();
    return _client.invoke(ctx, 'ServiceController', 'Check', request, emptyResponse);
  }
  Future<ReportResponse> report(ClientContext ctx, ReportRequest request) {
    var emptyResponse = new ReportResponse();
    return _client.invoke(ctx, 'ServiceController', 'Report', request, emptyResponse);
  }
}

