///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_metrics;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../protobuf/empty.pb.dart' as google$protobuf;

import 'logging_metrics.pbenum.dart';

export 'logging_metrics.pbenum.dart';

class LogMetric extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogMetric')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'description', PbFieldType.OS)
    ..a/*<String>*/(3, 'filter', PbFieldType.OS)
    ..e/*<LogMetric_ApiVersion>*/(4, 'version', PbFieldType.OE, LogMetric_ApiVersion.V2, LogMetric_ApiVersion.valueOf)
    ..hasRequiredFields = false
  ;

  LogMetric() : super();
  LogMetric.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogMetric.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogMetric clone() => new LogMetric()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogMetric create() => new LogMetric();
  static PbList<LogMetric> createRepeated() => new PbList<LogMetric>();
  static LogMetric getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogMetric();
    return _defaultInstance;
  }
  static LogMetric _defaultInstance;
  static void $checkItem(LogMetric v) {
    if (v is !LogMetric) checkItemFailed(v, 'LogMetric');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get description => $_get(1, 2, '');
  void set description(String v) { $_setString(1, 2, v); }
  bool hasDescription() => $_has(1, 2);
  void clearDescription() => clearField(2);

  String get filter => $_get(2, 3, '');
  void set filter(String v) { $_setString(2, 3, v); }
  bool hasFilter() => $_has(2, 3);
  void clearFilter() => clearField(3);

  LogMetric_ApiVersion get version => $_get(3, 4, null);
  void set version(LogMetric_ApiVersion v) { setField(4, v); }
  bool hasVersion() => $_has(3, 4);
  void clearVersion() => clearField(4);
}

class _ReadonlyLogMetric extends LogMetric with ReadonlyMessageMixin {}

class ListLogMetricsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogMetricsRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListLogMetricsRequest() : super();
  ListLogMetricsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogMetricsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogMetricsRequest clone() => new ListLogMetricsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogMetricsRequest create() => new ListLogMetricsRequest();
  static PbList<ListLogMetricsRequest> createRepeated() => new PbList<ListLogMetricsRequest>();
  static ListLogMetricsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogMetricsRequest();
    return _defaultInstance;
  }
  static ListLogMetricsRequest _defaultInstance;
  static void $checkItem(ListLogMetricsRequest v) {
    if (v is !ListLogMetricsRequest) checkItemFailed(v, 'ListLogMetricsRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);

  int get pageSize => $_get(2, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasPageSize() => $_has(2, 3);
  void clearPageSize() => clearField(3);
}

class _ReadonlyListLogMetricsRequest extends ListLogMetricsRequest with ReadonlyMessageMixin {}

class ListLogMetricsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogMetricsResponse')
    ..pp/*<LogMetric>*/(1, 'metrics', PbFieldType.PM, LogMetric.$checkItem, LogMetric.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListLogMetricsResponse() : super();
  ListLogMetricsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogMetricsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogMetricsResponse clone() => new ListLogMetricsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogMetricsResponse create() => new ListLogMetricsResponse();
  static PbList<ListLogMetricsResponse> createRepeated() => new PbList<ListLogMetricsResponse>();
  static ListLogMetricsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogMetricsResponse();
    return _defaultInstance;
  }
  static ListLogMetricsResponse _defaultInstance;
  static void $checkItem(ListLogMetricsResponse v) {
    if (v is !ListLogMetricsResponse) checkItemFailed(v, 'ListLogMetricsResponse');
  }

  List<LogMetric> get metrics => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListLogMetricsResponse extends ListLogMetricsResponse with ReadonlyMessageMixin {}

class GetLogMetricRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetLogMetricRequest')
    ..a/*<String>*/(1, 'metricName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetLogMetricRequest() : super();
  GetLogMetricRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetLogMetricRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetLogMetricRequest clone() => new GetLogMetricRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetLogMetricRequest create() => new GetLogMetricRequest();
  static PbList<GetLogMetricRequest> createRepeated() => new PbList<GetLogMetricRequest>();
  static GetLogMetricRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetLogMetricRequest();
    return _defaultInstance;
  }
  static GetLogMetricRequest _defaultInstance;
  static void $checkItem(GetLogMetricRequest v) {
    if (v is !GetLogMetricRequest) checkItemFailed(v, 'GetLogMetricRequest');
  }

  String get metricName => $_get(0, 1, '');
  void set metricName(String v) { $_setString(0, 1, v); }
  bool hasMetricName() => $_has(0, 1);
  void clearMetricName() => clearField(1);
}

class _ReadonlyGetLogMetricRequest extends GetLogMetricRequest with ReadonlyMessageMixin {}

class CreateLogMetricRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateLogMetricRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<LogMetric>*/(2, 'metric', PbFieldType.OM, LogMetric.getDefault, LogMetric.create)
    ..hasRequiredFields = false
  ;

  CreateLogMetricRequest() : super();
  CreateLogMetricRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateLogMetricRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateLogMetricRequest clone() => new CreateLogMetricRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateLogMetricRequest create() => new CreateLogMetricRequest();
  static PbList<CreateLogMetricRequest> createRepeated() => new PbList<CreateLogMetricRequest>();
  static CreateLogMetricRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateLogMetricRequest();
    return _defaultInstance;
  }
  static CreateLogMetricRequest _defaultInstance;
  static void $checkItem(CreateLogMetricRequest v) {
    if (v is !CreateLogMetricRequest) checkItemFailed(v, 'CreateLogMetricRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  LogMetric get metric => $_get(1, 2, null);
  void set metric(LogMetric v) { setField(2, v); }
  bool hasMetric() => $_has(1, 2);
  void clearMetric() => clearField(2);
}

class _ReadonlyCreateLogMetricRequest extends CreateLogMetricRequest with ReadonlyMessageMixin {}

class UpdateLogMetricRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateLogMetricRequest')
    ..a/*<String>*/(1, 'metricName', PbFieldType.OS)
    ..a/*<LogMetric>*/(2, 'metric', PbFieldType.OM, LogMetric.getDefault, LogMetric.create)
    ..hasRequiredFields = false
  ;

  UpdateLogMetricRequest() : super();
  UpdateLogMetricRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateLogMetricRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateLogMetricRequest clone() => new UpdateLogMetricRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateLogMetricRequest create() => new UpdateLogMetricRequest();
  static PbList<UpdateLogMetricRequest> createRepeated() => new PbList<UpdateLogMetricRequest>();
  static UpdateLogMetricRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateLogMetricRequest();
    return _defaultInstance;
  }
  static UpdateLogMetricRequest _defaultInstance;
  static void $checkItem(UpdateLogMetricRequest v) {
    if (v is !UpdateLogMetricRequest) checkItemFailed(v, 'UpdateLogMetricRequest');
  }

  String get metricName => $_get(0, 1, '');
  void set metricName(String v) { $_setString(0, 1, v); }
  bool hasMetricName() => $_has(0, 1);
  void clearMetricName() => clearField(1);

  LogMetric get metric => $_get(1, 2, null);
  void set metric(LogMetric v) { setField(2, v); }
  bool hasMetric() => $_has(1, 2);
  void clearMetric() => clearField(2);
}

class _ReadonlyUpdateLogMetricRequest extends UpdateLogMetricRequest with ReadonlyMessageMixin {}

class DeleteLogMetricRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteLogMetricRequest')
    ..a/*<String>*/(1, 'metricName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteLogMetricRequest() : super();
  DeleteLogMetricRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteLogMetricRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteLogMetricRequest clone() => new DeleteLogMetricRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteLogMetricRequest create() => new DeleteLogMetricRequest();
  static PbList<DeleteLogMetricRequest> createRepeated() => new PbList<DeleteLogMetricRequest>();
  static DeleteLogMetricRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteLogMetricRequest();
    return _defaultInstance;
  }
  static DeleteLogMetricRequest _defaultInstance;
  static void $checkItem(DeleteLogMetricRequest v) {
    if (v is !DeleteLogMetricRequest) checkItemFailed(v, 'DeleteLogMetricRequest');
  }

  String get metricName => $_get(0, 1, '');
  void set metricName(String v) { $_setString(0, 1, v); }
  bool hasMetricName() => $_has(0, 1);
  void clearMetricName() => clearField(1);
}

class _ReadonlyDeleteLogMetricRequest extends DeleteLogMetricRequest with ReadonlyMessageMixin {}

class MetricsServiceV2Api {
  RpcClient _client;
  MetricsServiceV2Api(this._client);

  Future<ListLogMetricsResponse> listLogMetrics(ClientContext ctx, ListLogMetricsRequest request) {
    var emptyResponse = new ListLogMetricsResponse();
    return _client.invoke(ctx, 'MetricsServiceV2', 'ListLogMetrics', request, emptyResponse);
  }
  Future<LogMetric> getLogMetric(ClientContext ctx, GetLogMetricRequest request) {
    var emptyResponse = new LogMetric();
    return _client.invoke(ctx, 'MetricsServiceV2', 'GetLogMetric', request, emptyResponse);
  }
  Future<LogMetric> createLogMetric(ClientContext ctx, CreateLogMetricRequest request) {
    var emptyResponse = new LogMetric();
    return _client.invoke(ctx, 'MetricsServiceV2', 'CreateLogMetric', request, emptyResponse);
  }
  Future<LogMetric> updateLogMetric(ClientContext ctx, UpdateLogMetricRequest request) {
    var emptyResponse = new LogMetric();
    return _client.invoke(ctx, 'MetricsServiceV2', 'UpdateLogMetric', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteLogMetric(ClientContext ctx, DeleteLogMetricRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'MetricsServiceV2', 'DeleteLogMetric', request, emptyResponse);
  }
}

