///
//  Generated code. Do not modify.
///
library google.monitoring.v3_metric_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/monitored_resource.pb.dart' as google$api;
import '../../api/metric.pb.dart' as google$api;
import 'common.pb.dart';
import 'metric.pb.dart';
import '../../rpc/status.pb.dart' as google$rpc;
import '../../protobuf/empty.pb.dart' as google$protobuf;

import 'metric_service.pbenum.dart';

export 'metric_service.pbenum.dart';

class ListMonitoredResourceDescriptorsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListMonitoredResourceDescriptorsRequest')
    ..a/*<String>*/(2, 'filter', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(5, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListMonitoredResourceDescriptorsRequest() : super();
  ListMonitoredResourceDescriptorsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListMonitoredResourceDescriptorsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListMonitoredResourceDescriptorsRequest clone() => new ListMonitoredResourceDescriptorsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMonitoredResourceDescriptorsRequest create() => new ListMonitoredResourceDescriptorsRequest();
  static PbList<ListMonitoredResourceDescriptorsRequest> createRepeated() => new PbList<ListMonitoredResourceDescriptorsRequest>();
  static ListMonitoredResourceDescriptorsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListMonitoredResourceDescriptorsRequest();
    return _defaultInstance;
  }
  static ListMonitoredResourceDescriptorsRequest _defaultInstance;
  static void $checkItem(ListMonitoredResourceDescriptorsRequest v) {
    if (v is !ListMonitoredResourceDescriptorsRequest) checkItemFailed(v, 'ListMonitoredResourceDescriptorsRequest');
  }

  String get filter => $_get(0, 2, '');
  void set filter(String v) { $_setString(0, 2, v); }
  bool hasFilter() => $_has(0, 2);
  void clearFilter() => clearField(2);

  int get pageSize => $_get(1, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 3, v); }
  bool hasPageSize() => $_has(1, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(2, 4, '');
  void set pageToken(String v) { $_setString(2, 4, v); }
  bool hasPageToken() => $_has(2, 4);
  void clearPageToken() => clearField(4);

  String get name => $_get(3, 5, '');
  void set name(String v) { $_setString(3, 5, v); }
  bool hasName() => $_has(3, 5);
  void clearName() => clearField(5);
}

class _ReadonlyListMonitoredResourceDescriptorsRequest extends ListMonitoredResourceDescriptorsRequest with ReadonlyMessageMixin {}

class ListMonitoredResourceDescriptorsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListMonitoredResourceDescriptorsResponse')
    ..pp/*<google$api.MonitoredResourceDescriptor>*/(1, 'resourceDescriptors', PbFieldType.PM, google$api.MonitoredResourceDescriptor.$checkItem, google$api.MonitoredResourceDescriptor.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListMonitoredResourceDescriptorsResponse() : super();
  ListMonitoredResourceDescriptorsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListMonitoredResourceDescriptorsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListMonitoredResourceDescriptorsResponse clone() => new ListMonitoredResourceDescriptorsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMonitoredResourceDescriptorsResponse create() => new ListMonitoredResourceDescriptorsResponse();
  static PbList<ListMonitoredResourceDescriptorsResponse> createRepeated() => new PbList<ListMonitoredResourceDescriptorsResponse>();
  static ListMonitoredResourceDescriptorsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListMonitoredResourceDescriptorsResponse();
    return _defaultInstance;
  }
  static ListMonitoredResourceDescriptorsResponse _defaultInstance;
  static void $checkItem(ListMonitoredResourceDescriptorsResponse v) {
    if (v is !ListMonitoredResourceDescriptorsResponse) checkItemFailed(v, 'ListMonitoredResourceDescriptorsResponse');
  }

  List<google$api.MonitoredResourceDescriptor> get resourceDescriptors => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListMonitoredResourceDescriptorsResponse extends ListMonitoredResourceDescriptorsResponse with ReadonlyMessageMixin {}

class GetMonitoredResourceDescriptorRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetMonitoredResourceDescriptorRequest')
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetMonitoredResourceDescriptorRequest() : super();
  GetMonitoredResourceDescriptorRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetMonitoredResourceDescriptorRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetMonitoredResourceDescriptorRequest clone() => new GetMonitoredResourceDescriptorRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetMonitoredResourceDescriptorRequest create() => new GetMonitoredResourceDescriptorRequest();
  static PbList<GetMonitoredResourceDescriptorRequest> createRepeated() => new PbList<GetMonitoredResourceDescriptorRequest>();
  static GetMonitoredResourceDescriptorRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetMonitoredResourceDescriptorRequest();
    return _defaultInstance;
  }
  static GetMonitoredResourceDescriptorRequest _defaultInstance;
  static void $checkItem(GetMonitoredResourceDescriptorRequest v) {
    if (v is !GetMonitoredResourceDescriptorRequest) checkItemFailed(v, 'GetMonitoredResourceDescriptorRequest');
  }

  String get name => $_get(0, 3, '');
  void set name(String v) { $_setString(0, 3, v); }
  bool hasName() => $_has(0, 3);
  void clearName() => clearField(3);
}

class _ReadonlyGetMonitoredResourceDescriptorRequest extends GetMonitoredResourceDescriptorRequest with ReadonlyMessageMixin {}

class ListMetricDescriptorsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListMetricDescriptorsRequest')
    ..a/*<String>*/(2, 'filter', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(5, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListMetricDescriptorsRequest() : super();
  ListMetricDescriptorsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListMetricDescriptorsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListMetricDescriptorsRequest clone() => new ListMetricDescriptorsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMetricDescriptorsRequest create() => new ListMetricDescriptorsRequest();
  static PbList<ListMetricDescriptorsRequest> createRepeated() => new PbList<ListMetricDescriptorsRequest>();
  static ListMetricDescriptorsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListMetricDescriptorsRequest();
    return _defaultInstance;
  }
  static ListMetricDescriptorsRequest _defaultInstance;
  static void $checkItem(ListMetricDescriptorsRequest v) {
    if (v is !ListMetricDescriptorsRequest) checkItemFailed(v, 'ListMetricDescriptorsRequest');
  }

  String get filter => $_get(0, 2, '');
  void set filter(String v) { $_setString(0, 2, v); }
  bool hasFilter() => $_has(0, 2);
  void clearFilter() => clearField(2);

  int get pageSize => $_get(1, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 3, v); }
  bool hasPageSize() => $_has(1, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(2, 4, '');
  void set pageToken(String v) { $_setString(2, 4, v); }
  bool hasPageToken() => $_has(2, 4);
  void clearPageToken() => clearField(4);

  String get name => $_get(3, 5, '');
  void set name(String v) { $_setString(3, 5, v); }
  bool hasName() => $_has(3, 5);
  void clearName() => clearField(5);
}

class _ReadonlyListMetricDescriptorsRequest extends ListMetricDescriptorsRequest with ReadonlyMessageMixin {}

class ListMetricDescriptorsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListMetricDescriptorsResponse')
    ..pp/*<google$api.MetricDescriptor>*/(1, 'metricDescriptors', PbFieldType.PM, google$api.MetricDescriptor.$checkItem, google$api.MetricDescriptor.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListMetricDescriptorsResponse() : super();
  ListMetricDescriptorsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListMetricDescriptorsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListMetricDescriptorsResponse clone() => new ListMetricDescriptorsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListMetricDescriptorsResponse create() => new ListMetricDescriptorsResponse();
  static PbList<ListMetricDescriptorsResponse> createRepeated() => new PbList<ListMetricDescriptorsResponse>();
  static ListMetricDescriptorsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListMetricDescriptorsResponse();
    return _defaultInstance;
  }
  static ListMetricDescriptorsResponse _defaultInstance;
  static void $checkItem(ListMetricDescriptorsResponse v) {
    if (v is !ListMetricDescriptorsResponse) checkItemFailed(v, 'ListMetricDescriptorsResponse');
  }

  List<google$api.MetricDescriptor> get metricDescriptors => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListMetricDescriptorsResponse extends ListMetricDescriptorsResponse with ReadonlyMessageMixin {}

class GetMetricDescriptorRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetMetricDescriptorRequest')
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetMetricDescriptorRequest() : super();
  GetMetricDescriptorRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetMetricDescriptorRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetMetricDescriptorRequest clone() => new GetMetricDescriptorRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetMetricDescriptorRequest create() => new GetMetricDescriptorRequest();
  static PbList<GetMetricDescriptorRequest> createRepeated() => new PbList<GetMetricDescriptorRequest>();
  static GetMetricDescriptorRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetMetricDescriptorRequest();
    return _defaultInstance;
  }
  static GetMetricDescriptorRequest _defaultInstance;
  static void $checkItem(GetMetricDescriptorRequest v) {
    if (v is !GetMetricDescriptorRequest) checkItemFailed(v, 'GetMetricDescriptorRequest');
  }

  String get name => $_get(0, 3, '');
  void set name(String v) { $_setString(0, 3, v); }
  bool hasName() => $_has(0, 3);
  void clearName() => clearField(3);
}

class _ReadonlyGetMetricDescriptorRequest extends GetMetricDescriptorRequest with ReadonlyMessageMixin {}

class CreateMetricDescriptorRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateMetricDescriptorRequest')
    ..a/*<google$api.MetricDescriptor>*/(2, 'metricDescriptor', PbFieldType.OM, google$api.MetricDescriptor.getDefault, google$api.MetricDescriptor.create)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CreateMetricDescriptorRequest() : super();
  CreateMetricDescriptorRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateMetricDescriptorRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateMetricDescriptorRequest clone() => new CreateMetricDescriptorRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateMetricDescriptorRequest create() => new CreateMetricDescriptorRequest();
  static PbList<CreateMetricDescriptorRequest> createRepeated() => new PbList<CreateMetricDescriptorRequest>();
  static CreateMetricDescriptorRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateMetricDescriptorRequest();
    return _defaultInstance;
  }
  static CreateMetricDescriptorRequest _defaultInstance;
  static void $checkItem(CreateMetricDescriptorRequest v) {
    if (v is !CreateMetricDescriptorRequest) checkItemFailed(v, 'CreateMetricDescriptorRequest');
  }

  google$api.MetricDescriptor get metricDescriptor => $_get(0, 2, null);
  void set metricDescriptor(google$api.MetricDescriptor v) { setField(2, v); }
  bool hasMetricDescriptor() => $_has(0, 2);
  void clearMetricDescriptor() => clearField(2);

  String get name => $_get(1, 3, '');
  void set name(String v) { $_setString(1, 3, v); }
  bool hasName() => $_has(1, 3);
  void clearName() => clearField(3);
}

class _ReadonlyCreateMetricDescriptorRequest extends CreateMetricDescriptorRequest with ReadonlyMessageMixin {}

class DeleteMetricDescriptorRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteMetricDescriptorRequest')
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteMetricDescriptorRequest() : super();
  DeleteMetricDescriptorRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteMetricDescriptorRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteMetricDescriptorRequest clone() => new DeleteMetricDescriptorRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteMetricDescriptorRequest create() => new DeleteMetricDescriptorRequest();
  static PbList<DeleteMetricDescriptorRequest> createRepeated() => new PbList<DeleteMetricDescriptorRequest>();
  static DeleteMetricDescriptorRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteMetricDescriptorRequest();
    return _defaultInstance;
  }
  static DeleteMetricDescriptorRequest _defaultInstance;
  static void $checkItem(DeleteMetricDescriptorRequest v) {
    if (v is !DeleteMetricDescriptorRequest) checkItemFailed(v, 'DeleteMetricDescriptorRequest');
  }

  String get name => $_get(0, 3, '');
  void set name(String v) { $_setString(0, 3, v); }
  bool hasName() => $_has(0, 3);
  void clearName() => clearField(3);
}

class _ReadonlyDeleteMetricDescriptorRequest extends DeleteMetricDescriptorRequest with ReadonlyMessageMixin {}

class ListTimeSeriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTimeSeriesRequest')
    ..a/*<String>*/(2, 'filter', PbFieldType.OS)
    ..a/*<TimeInterval>*/(4, 'interval', PbFieldType.OM, TimeInterval.getDefault, TimeInterval.create)
    ..a/*<Aggregation>*/(5, 'aggregation', PbFieldType.OM, Aggregation.getDefault, Aggregation.create)
    ..a/*<String>*/(6, 'orderBy', PbFieldType.OS)
    ..e/*<ListTimeSeriesRequest_TimeSeriesView>*/(7, 'view', PbFieldType.OE, ListTimeSeriesRequest_TimeSeriesView.FULL, ListTimeSeriesRequest_TimeSeriesView.valueOf)
    ..a/*<int>*/(8, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(9, 'pageToken', PbFieldType.OS)
    ..a/*<String>*/(10, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTimeSeriesRequest() : super();
  ListTimeSeriesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTimeSeriesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTimeSeriesRequest clone() => new ListTimeSeriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTimeSeriesRequest create() => new ListTimeSeriesRequest();
  static PbList<ListTimeSeriesRequest> createRepeated() => new PbList<ListTimeSeriesRequest>();
  static ListTimeSeriesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTimeSeriesRequest();
    return _defaultInstance;
  }
  static ListTimeSeriesRequest _defaultInstance;
  static void $checkItem(ListTimeSeriesRequest v) {
    if (v is !ListTimeSeriesRequest) checkItemFailed(v, 'ListTimeSeriesRequest');
  }

  String get filter => $_get(0, 2, '');
  void set filter(String v) { $_setString(0, 2, v); }
  bool hasFilter() => $_has(0, 2);
  void clearFilter() => clearField(2);

  TimeInterval get interval => $_get(1, 4, null);
  void set interval(TimeInterval v) { setField(4, v); }
  bool hasInterval() => $_has(1, 4);
  void clearInterval() => clearField(4);

  Aggregation get aggregation => $_get(2, 5, null);
  void set aggregation(Aggregation v) { setField(5, v); }
  bool hasAggregation() => $_has(2, 5);
  void clearAggregation() => clearField(5);

  String get orderBy => $_get(3, 6, '');
  void set orderBy(String v) { $_setString(3, 6, v); }
  bool hasOrderBy() => $_has(3, 6);
  void clearOrderBy() => clearField(6);

  ListTimeSeriesRequest_TimeSeriesView get view => $_get(4, 7, null);
  void set view(ListTimeSeriesRequest_TimeSeriesView v) { setField(7, v); }
  bool hasView() => $_has(4, 7);
  void clearView() => clearField(7);

  int get pageSize => $_get(5, 8, 0);
  void set pageSize(int v) { $_setUnsignedInt32(5, 8, v); }
  bool hasPageSize() => $_has(5, 8);
  void clearPageSize() => clearField(8);

  String get pageToken => $_get(6, 9, '');
  void set pageToken(String v) { $_setString(6, 9, v); }
  bool hasPageToken() => $_has(6, 9);
  void clearPageToken() => clearField(9);

  String get name => $_get(7, 10, '');
  void set name(String v) { $_setString(7, 10, v); }
  bool hasName() => $_has(7, 10);
  void clearName() => clearField(10);
}

class _ReadonlyListTimeSeriesRequest extends ListTimeSeriesRequest with ReadonlyMessageMixin {}

class ListTimeSeriesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTimeSeriesResponse')
    ..pp/*<TimeSeries>*/(1, 'timeSeries', PbFieldType.PM, TimeSeries.$checkItem, TimeSeries.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTimeSeriesResponse() : super();
  ListTimeSeriesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTimeSeriesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTimeSeriesResponse clone() => new ListTimeSeriesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTimeSeriesResponse create() => new ListTimeSeriesResponse();
  static PbList<ListTimeSeriesResponse> createRepeated() => new PbList<ListTimeSeriesResponse>();
  static ListTimeSeriesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTimeSeriesResponse();
    return _defaultInstance;
  }
  static ListTimeSeriesResponse _defaultInstance;
  static void $checkItem(ListTimeSeriesResponse v) {
    if (v is !ListTimeSeriesResponse) checkItemFailed(v, 'ListTimeSeriesResponse');
  }

  List<TimeSeries> get timeSeries => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTimeSeriesResponse extends ListTimeSeriesResponse with ReadonlyMessageMixin {}

class CreateTimeSeriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTimeSeriesRequest')
    ..pp/*<TimeSeries>*/(2, 'timeSeries', PbFieldType.PM, TimeSeries.$checkItem, TimeSeries.create)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CreateTimeSeriesRequest() : super();
  CreateTimeSeriesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateTimeSeriesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateTimeSeriesRequest clone() => new CreateTimeSeriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateTimeSeriesRequest create() => new CreateTimeSeriesRequest();
  static PbList<CreateTimeSeriesRequest> createRepeated() => new PbList<CreateTimeSeriesRequest>();
  static CreateTimeSeriesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateTimeSeriesRequest();
    return _defaultInstance;
  }
  static CreateTimeSeriesRequest _defaultInstance;
  static void $checkItem(CreateTimeSeriesRequest v) {
    if (v is !CreateTimeSeriesRequest) checkItemFailed(v, 'CreateTimeSeriesRequest');
  }

  List<TimeSeries> get timeSeries => $_get(0, 2, null);

  String get name => $_get(1, 3, '');
  void set name(String v) { $_setString(1, 3, v); }
  bool hasName() => $_has(1, 3);
  void clearName() => clearField(3);
}

class _ReadonlyCreateTimeSeriesRequest extends CreateTimeSeriesRequest with ReadonlyMessageMixin {}

class CreateTimeSeriesError extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateTimeSeriesError')
    ..a/*<TimeSeries>*/(1, 'timeSeries', PbFieldType.OM, TimeSeries.getDefault, TimeSeries.create)
    ..a/*<google$rpc.Status>*/(2, 'status', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..hasRequiredFields = false
  ;

  CreateTimeSeriesError() : super();
  CreateTimeSeriesError.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateTimeSeriesError.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateTimeSeriesError clone() => new CreateTimeSeriesError()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateTimeSeriesError create() => new CreateTimeSeriesError();
  static PbList<CreateTimeSeriesError> createRepeated() => new PbList<CreateTimeSeriesError>();
  static CreateTimeSeriesError getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateTimeSeriesError();
    return _defaultInstance;
  }
  static CreateTimeSeriesError _defaultInstance;
  static void $checkItem(CreateTimeSeriesError v) {
    if (v is !CreateTimeSeriesError) checkItemFailed(v, 'CreateTimeSeriesError');
  }

  TimeSeries get timeSeries => $_get(0, 1, null);
  void set timeSeries(TimeSeries v) { setField(1, v); }
  bool hasTimeSeries() => $_has(0, 1);
  void clearTimeSeries() => clearField(1);

  google$rpc.Status get status => $_get(1, 2, null);
  void set status(google$rpc.Status v) { setField(2, v); }
  bool hasStatus() => $_has(1, 2);
  void clearStatus() => clearField(2);
}

class _ReadonlyCreateTimeSeriesError extends CreateTimeSeriesError with ReadonlyMessageMixin {}

class MetricServiceApi {
  RpcClient _client;
  MetricServiceApi(this._client);

  Future<ListMonitoredResourceDescriptorsResponse> listMonitoredResourceDescriptors(ClientContext ctx, ListMonitoredResourceDescriptorsRequest request) {
    var emptyResponse = new ListMonitoredResourceDescriptorsResponse();
    return _client.invoke(ctx, 'MetricService', 'ListMonitoredResourceDescriptors', request, emptyResponse);
  }
  Future<google$api.MonitoredResourceDescriptor> getMonitoredResourceDescriptor(ClientContext ctx, GetMonitoredResourceDescriptorRequest request) {
    var emptyResponse = new google$api.MonitoredResourceDescriptor();
    return _client.invoke(ctx, 'MetricService', 'GetMonitoredResourceDescriptor', request, emptyResponse);
  }
  Future<ListMetricDescriptorsResponse> listMetricDescriptors(ClientContext ctx, ListMetricDescriptorsRequest request) {
    var emptyResponse = new ListMetricDescriptorsResponse();
    return _client.invoke(ctx, 'MetricService', 'ListMetricDescriptors', request, emptyResponse);
  }
  Future<google$api.MetricDescriptor> getMetricDescriptor(ClientContext ctx, GetMetricDescriptorRequest request) {
    var emptyResponse = new google$api.MetricDescriptor();
    return _client.invoke(ctx, 'MetricService', 'GetMetricDescriptor', request, emptyResponse);
  }
  Future<google$api.MetricDescriptor> createMetricDescriptor(ClientContext ctx, CreateMetricDescriptorRequest request) {
    var emptyResponse = new google$api.MetricDescriptor();
    return _client.invoke(ctx, 'MetricService', 'CreateMetricDescriptor', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteMetricDescriptor(ClientContext ctx, DeleteMetricDescriptorRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'MetricService', 'DeleteMetricDescriptor', request, emptyResponse);
  }
  Future<ListTimeSeriesResponse> listTimeSeries(ClientContext ctx, ListTimeSeriesRequest request) {
    var emptyResponse = new ListTimeSeriesResponse();
    return _client.invoke(ctx, 'MetricService', 'ListTimeSeries', request, emptyResponse);
  }
  Future<google$protobuf.Empty> createTimeSeries(ClientContext ctx, CreateTimeSeriesRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'MetricService', 'CreateTimeSeries', request, emptyResponse);
  }
}

