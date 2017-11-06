///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_error_stats_service;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../../protobuf/duration.pb.dart' as google$protobuf;
import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import 'common.pb.dart';

import 'error_stats_service.pbenum.dart';

export 'error_stats_service.pbenum.dart';

class ListGroupStatsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupStatsRequest')
    ..a/*<String>*/(1, 'projectName', PbFieldType.OS)
    ..p/*<String>*/(2, 'groupId', PbFieldType.PS)
    ..a/*<ServiceContextFilter>*/(3, 'serviceFilter', PbFieldType.OM, ServiceContextFilter.getDefault, ServiceContextFilter.create)
    ..a/*<QueryTimeRange>*/(5, 'timeRange', PbFieldType.OM, QueryTimeRange.getDefault, QueryTimeRange.create)
    ..a/*<google$protobuf.Duration>*/(6, 'timedCountDuration', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..e/*<TimedCountAlignment>*/(7, 'alignment', PbFieldType.OE, TimedCountAlignment.ERROR_COUNT_ALIGNMENT_UNSPECIFIED, TimedCountAlignment.valueOf)
    ..a/*<google$protobuf.Timestamp>*/(8, 'alignmentTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..e/*<ErrorGroupOrder>*/(9, 'order', PbFieldType.OE, ErrorGroupOrder.GROUP_ORDER_UNSPECIFIED, ErrorGroupOrder.valueOf)
    ..a/*<int>*/(11, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(12, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListGroupStatsRequest() : super();
  ListGroupStatsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupStatsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupStatsRequest clone() => new ListGroupStatsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupStatsRequest create() => new ListGroupStatsRequest();
  static PbList<ListGroupStatsRequest> createRepeated() => new PbList<ListGroupStatsRequest>();
  static ListGroupStatsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupStatsRequest();
    return _defaultInstance;
  }
  static ListGroupStatsRequest _defaultInstance;
  static void $checkItem(ListGroupStatsRequest v) {
    if (v is !ListGroupStatsRequest) checkItemFailed(v, 'ListGroupStatsRequest');
  }

  String get projectName => $_get(0, 1, '');
  void set projectName(String v) { $_setString(0, 1, v); }
  bool hasProjectName() => $_has(0, 1);
  void clearProjectName() => clearField(1);

  List<String> get groupId => $_get(1, 2, null);

  ServiceContextFilter get serviceFilter => $_get(2, 3, null);
  void set serviceFilter(ServiceContextFilter v) { setField(3, v); }
  bool hasServiceFilter() => $_has(2, 3);
  void clearServiceFilter() => clearField(3);

  QueryTimeRange get timeRange => $_get(3, 5, null);
  void set timeRange(QueryTimeRange v) { setField(5, v); }
  bool hasTimeRange() => $_has(3, 5);
  void clearTimeRange() => clearField(5);

  google$protobuf.Duration get timedCountDuration => $_get(4, 6, null);
  void set timedCountDuration(google$protobuf.Duration v) { setField(6, v); }
  bool hasTimedCountDuration() => $_has(4, 6);
  void clearTimedCountDuration() => clearField(6);

  TimedCountAlignment get alignment => $_get(5, 7, null);
  void set alignment(TimedCountAlignment v) { setField(7, v); }
  bool hasAlignment() => $_has(5, 7);
  void clearAlignment() => clearField(7);

  google$protobuf.Timestamp get alignmentTime => $_get(6, 8, null);
  void set alignmentTime(google$protobuf.Timestamp v) { setField(8, v); }
  bool hasAlignmentTime() => $_has(6, 8);
  void clearAlignmentTime() => clearField(8);

  ErrorGroupOrder get order => $_get(7, 9, null);
  void set order(ErrorGroupOrder v) { setField(9, v); }
  bool hasOrder() => $_has(7, 9);
  void clearOrder() => clearField(9);

  int get pageSize => $_get(8, 11, 0);
  void set pageSize(int v) { $_setUnsignedInt32(8, 11, v); }
  bool hasPageSize() => $_has(8, 11);
  void clearPageSize() => clearField(11);

  String get pageToken => $_get(9, 12, '');
  void set pageToken(String v) { $_setString(9, 12, v); }
  bool hasPageToken() => $_has(9, 12);
  void clearPageToken() => clearField(12);
}

class _ReadonlyListGroupStatsRequest extends ListGroupStatsRequest with ReadonlyMessageMixin {}

class ListGroupStatsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListGroupStatsResponse')
    ..pp/*<ErrorGroupStats>*/(1, 'errorGroupStats', PbFieldType.PM, ErrorGroupStats.$checkItem, ErrorGroupStats.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'timeRangeBegin', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ListGroupStatsResponse() : super();
  ListGroupStatsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListGroupStatsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListGroupStatsResponse clone() => new ListGroupStatsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListGroupStatsResponse create() => new ListGroupStatsResponse();
  static PbList<ListGroupStatsResponse> createRepeated() => new PbList<ListGroupStatsResponse>();
  static ListGroupStatsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListGroupStatsResponse();
    return _defaultInstance;
  }
  static ListGroupStatsResponse _defaultInstance;
  static void $checkItem(ListGroupStatsResponse v) {
    if (v is !ListGroupStatsResponse) checkItemFailed(v, 'ListGroupStatsResponse');
  }

  List<ErrorGroupStats> get errorGroupStats => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);

  google$protobuf.Timestamp get timeRangeBegin => $_get(2, 4, null);
  void set timeRangeBegin(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasTimeRangeBegin() => $_has(2, 4);
  void clearTimeRangeBegin() => clearField(4);
}

class _ReadonlyListGroupStatsResponse extends ListGroupStatsResponse with ReadonlyMessageMixin {}

class ErrorGroupStats extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ErrorGroupStats')
    ..a/*<ErrorGroup>*/(1, 'group', PbFieldType.OM, ErrorGroup.getDefault, ErrorGroup.create)
    ..a/*<Int64>*/(2, 'count', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(3, 'affectedUsersCount', PbFieldType.O6, Int64.ZERO)
    ..pp/*<TimedCount>*/(4, 'timedCounts', PbFieldType.PM, TimedCount.$checkItem, TimedCount.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'firstSeenTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(6, 'lastSeenTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..pp/*<ServiceContext>*/(7, 'affectedServices', PbFieldType.PM, ServiceContext.$checkItem, ServiceContext.create)
    ..a/*<int>*/(8, 'numAffectedServices', PbFieldType.O3)
    ..a/*<ErrorEvent>*/(9, 'representative', PbFieldType.OM, ErrorEvent.getDefault, ErrorEvent.create)
    ..hasRequiredFields = false
  ;

  ErrorGroupStats() : super();
  ErrorGroupStats.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ErrorGroupStats.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ErrorGroupStats clone() => new ErrorGroupStats()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ErrorGroupStats create() => new ErrorGroupStats();
  static PbList<ErrorGroupStats> createRepeated() => new PbList<ErrorGroupStats>();
  static ErrorGroupStats getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyErrorGroupStats();
    return _defaultInstance;
  }
  static ErrorGroupStats _defaultInstance;
  static void $checkItem(ErrorGroupStats v) {
    if (v is !ErrorGroupStats) checkItemFailed(v, 'ErrorGroupStats');
  }

  ErrorGroup get group => $_get(0, 1, null);
  void set group(ErrorGroup v) { setField(1, v); }
  bool hasGroup() => $_has(0, 1);
  void clearGroup() => clearField(1);

  Int64 get count => $_get(1, 2, null);
  void set count(Int64 v) { $_setInt64(1, 2, v); }
  bool hasCount() => $_has(1, 2);
  void clearCount() => clearField(2);

  Int64 get affectedUsersCount => $_get(2, 3, null);
  void set affectedUsersCount(Int64 v) { $_setInt64(2, 3, v); }
  bool hasAffectedUsersCount() => $_has(2, 3);
  void clearAffectedUsersCount() => clearField(3);

  List<TimedCount> get timedCounts => $_get(3, 4, null);

  google$protobuf.Timestamp get firstSeenTime => $_get(4, 5, null);
  void set firstSeenTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasFirstSeenTime() => $_has(4, 5);
  void clearFirstSeenTime() => clearField(5);

  google$protobuf.Timestamp get lastSeenTime => $_get(5, 6, null);
  void set lastSeenTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasLastSeenTime() => $_has(5, 6);
  void clearLastSeenTime() => clearField(6);

  List<ServiceContext> get affectedServices => $_get(6, 7, null);

  int get numAffectedServices => $_get(7, 8, 0);
  void set numAffectedServices(int v) { $_setUnsignedInt32(7, 8, v); }
  bool hasNumAffectedServices() => $_has(7, 8);
  void clearNumAffectedServices() => clearField(8);

  ErrorEvent get representative => $_get(8, 9, null);
  void set representative(ErrorEvent v) { setField(9, v); }
  bool hasRepresentative() => $_has(8, 9);
  void clearRepresentative() => clearField(9);
}

class _ReadonlyErrorGroupStats extends ErrorGroupStats with ReadonlyMessageMixin {}

class TimedCount extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TimedCount')
    ..a/*<Int64>*/(1, 'count', PbFieldType.O6, Int64.ZERO)
    ..a/*<google$protobuf.Timestamp>*/(2, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(3, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TimedCount() : super();
  TimedCount.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TimedCount.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TimedCount clone() => new TimedCount()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TimedCount create() => new TimedCount();
  static PbList<TimedCount> createRepeated() => new PbList<TimedCount>();
  static TimedCount getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTimedCount();
    return _defaultInstance;
  }
  static TimedCount _defaultInstance;
  static void $checkItem(TimedCount v) {
    if (v is !TimedCount) checkItemFailed(v, 'TimedCount');
  }

  Int64 get count => $_get(0, 1, null);
  void set count(Int64 v) { $_setInt64(0, 1, v); }
  bool hasCount() => $_has(0, 1);
  void clearCount() => clearField(1);

  google$protobuf.Timestamp get startTime => $_get(1, 2, null);
  void set startTime(google$protobuf.Timestamp v) { setField(2, v); }
  bool hasStartTime() => $_has(1, 2);
  void clearStartTime() => clearField(2);

  google$protobuf.Timestamp get endTime => $_get(2, 3, null);
  void set endTime(google$protobuf.Timestamp v) { setField(3, v); }
  bool hasEndTime() => $_has(2, 3);
  void clearEndTime() => clearField(3);
}

class _ReadonlyTimedCount extends TimedCount with ReadonlyMessageMixin {}

class ListEventsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListEventsRequest')
    ..a/*<String>*/(1, 'projectName', PbFieldType.OS)
    ..a/*<String>*/(2, 'groupId', PbFieldType.OS)
    ..a/*<ServiceContextFilter>*/(3, 'serviceFilter', PbFieldType.OM, ServiceContextFilter.getDefault, ServiceContextFilter.create)
    ..a/*<QueryTimeRange>*/(4, 'timeRange', PbFieldType.OM, QueryTimeRange.getDefault, QueryTimeRange.create)
    ..a/*<int>*/(6, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(7, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListEventsRequest() : super();
  ListEventsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListEventsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListEventsRequest clone() => new ListEventsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListEventsRequest create() => new ListEventsRequest();
  static PbList<ListEventsRequest> createRepeated() => new PbList<ListEventsRequest>();
  static ListEventsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListEventsRequest();
    return _defaultInstance;
  }
  static ListEventsRequest _defaultInstance;
  static void $checkItem(ListEventsRequest v) {
    if (v is !ListEventsRequest) checkItemFailed(v, 'ListEventsRequest');
  }

  String get projectName => $_get(0, 1, '');
  void set projectName(String v) { $_setString(0, 1, v); }
  bool hasProjectName() => $_has(0, 1);
  void clearProjectName() => clearField(1);

  String get groupId => $_get(1, 2, '');
  void set groupId(String v) { $_setString(1, 2, v); }
  bool hasGroupId() => $_has(1, 2);
  void clearGroupId() => clearField(2);

  ServiceContextFilter get serviceFilter => $_get(2, 3, null);
  void set serviceFilter(ServiceContextFilter v) { setField(3, v); }
  bool hasServiceFilter() => $_has(2, 3);
  void clearServiceFilter() => clearField(3);

  QueryTimeRange get timeRange => $_get(3, 4, null);
  void set timeRange(QueryTimeRange v) { setField(4, v); }
  bool hasTimeRange() => $_has(3, 4);
  void clearTimeRange() => clearField(4);

  int get pageSize => $_get(4, 6, 0);
  void set pageSize(int v) { $_setUnsignedInt32(4, 6, v); }
  bool hasPageSize() => $_has(4, 6);
  void clearPageSize() => clearField(6);

  String get pageToken => $_get(5, 7, '');
  void set pageToken(String v) { $_setString(5, 7, v); }
  bool hasPageToken() => $_has(5, 7);
  void clearPageToken() => clearField(7);
}

class _ReadonlyListEventsRequest extends ListEventsRequest with ReadonlyMessageMixin {}

class ListEventsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListEventsResponse')
    ..pp/*<ErrorEvent>*/(1, 'errorEvents', PbFieldType.PM, ErrorEvent.$checkItem, ErrorEvent.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'timeRangeBegin', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ListEventsResponse() : super();
  ListEventsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListEventsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListEventsResponse clone() => new ListEventsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListEventsResponse create() => new ListEventsResponse();
  static PbList<ListEventsResponse> createRepeated() => new PbList<ListEventsResponse>();
  static ListEventsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListEventsResponse();
    return _defaultInstance;
  }
  static ListEventsResponse _defaultInstance;
  static void $checkItem(ListEventsResponse v) {
    if (v is !ListEventsResponse) checkItemFailed(v, 'ListEventsResponse');
  }

  List<ErrorEvent> get errorEvents => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);

  google$protobuf.Timestamp get timeRangeBegin => $_get(2, 4, null);
  void set timeRangeBegin(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasTimeRangeBegin() => $_has(2, 4);
  void clearTimeRangeBegin() => clearField(4);
}

class _ReadonlyListEventsResponse extends ListEventsResponse with ReadonlyMessageMixin {}

class QueryTimeRange extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryTimeRange')
    ..e/*<QueryTimeRange_Period>*/(1, 'period', PbFieldType.OE, QueryTimeRange_Period.PERIOD_UNSPECIFIED, QueryTimeRange_Period.valueOf)
    ..hasRequiredFields = false
  ;

  QueryTimeRange() : super();
  QueryTimeRange.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryTimeRange.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryTimeRange clone() => new QueryTimeRange()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryTimeRange create() => new QueryTimeRange();
  static PbList<QueryTimeRange> createRepeated() => new PbList<QueryTimeRange>();
  static QueryTimeRange getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryTimeRange();
    return _defaultInstance;
  }
  static QueryTimeRange _defaultInstance;
  static void $checkItem(QueryTimeRange v) {
    if (v is !QueryTimeRange) checkItemFailed(v, 'QueryTimeRange');
  }

  QueryTimeRange_Period get period => $_get(0, 1, null);
  void set period(QueryTimeRange_Period v) { setField(1, v); }
  bool hasPeriod() => $_has(0, 1);
  void clearPeriod() => clearField(1);
}

class _ReadonlyQueryTimeRange extends QueryTimeRange with ReadonlyMessageMixin {}

class ServiceContextFilter extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ServiceContextFilter')
    ..a/*<String>*/(2, 'service', PbFieldType.OS)
    ..a/*<String>*/(3, 'version', PbFieldType.OS)
    ..a/*<String>*/(4, 'resourceType', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ServiceContextFilter() : super();
  ServiceContextFilter.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceContextFilter.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceContextFilter clone() => new ServiceContextFilter()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ServiceContextFilter create() => new ServiceContextFilter();
  static PbList<ServiceContextFilter> createRepeated() => new PbList<ServiceContextFilter>();
  static ServiceContextFilter getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyServiceContextFilter();
    return _defaultInstance;
  }
  static ServiceContextFilter _defaultInstance;
  static void $checkItem(ServiceContextFilter v) {
    if (v is !ServiceContextFilter) checkItemFailed(v, 'ServiceContextFilter');
  }

  String get service => $_get(0, 2, '');
  void set service(String v) { $_setString(0, 2, v); }
  bool hasService() => $_has(0, 2);
  void clearService() => clearField(2);

  String get version => $_get(1, 3, '');
  void set version(String v) { $_setString(1, 3, v); }
  bool hasVersion() => $_has(1, 3);
  void clearVersion() => clearField(3);

  String get resourceType => $_get(2, 4, '');
  void set resourceType(String v) { $_setString(2, 4, v); }
  bool hasResourceType() => $_has(2, 4);
  void clearResourceType() => clearField(4);
}

class _ReadonlyServiceContextFilter extends ServiceContextFilter with ReadonlyMessageMixin {}

class DeleteEventsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteEventsRequest')
    ..a/*<String>*/(1, 'projectName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteEventsRequest() : super();
  DeleteEventsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteEventsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteEventsRequest clone() => new DeleteEventsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteEventsRequest create() => new DeleteEventsRequest();
  static PbList<DeleteEventsRequest> createRepeated() => new PbList<DeleteEventsRequest>();
  static DeleteEventsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteEventsRequest();
    return _defaultInstance;
  }
  static DeleteEventsRequest _defaultInstance;
  static void $checkItem(DeleteEventsRequest v) {
    if (v is !DeleteEventsRequest) checkItemFailed(v, 'DeleteEventsRequest');
  }

  String get projectName => $_get(0, 1, '');
  void set projectName(String v) { $_setString(0, 1, v); }
  bool hasProjectName() => $_has(0, 1);
  void clearProjectName() => clearField(1);
}

class _ReadonlyDeleteEventsRequest extends DeleteEventsRequest with ReadonlyMessageMixin {}

class DeleteEventsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteEventsResponse')
    ..hasRequiredFields = false
  ;

  DeleteEventsResponse() : super();
  DeleteEventsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteEventsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteEventsResponse clone() => new DeleteEventsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteEventsResponse create() => new DeleteEventsResponse();
  static PbList<DeleteEventsResponse> createRepeated() => new PbList<DeleteEventsResponse>();
  static DeleteEventsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteEventsResponse();
    return _defaultInstance;
  }
  static DeleteEventsResponse _defaultInstance;
  static void $checkItem(DeleteEventsResponse v) {
    if (v is !DeleteEventsResponse) checkItemFailed(v, 'DeleteEventsResponse');
  }
}

class _ReadonlyDeleteEventsResponse extends DeleteEventsResponse with ReadonlyMessageMixin {}

class ErrorStatsServiceApi {
  RpcClient _client;
  ErrorStatsServiceApi(this._client);

  Future<ListGroupStatsResponse> listGroupStats(ClientContext ctx, ListGroupStatsRequest request) {
    var emptyResponse = new ListGroupStatsResponse();
    return _client.invoke(ctx, 'ErrorStatsService', 'ListGroupStats', request, emptyResponse);
  }
  Future<ListEventsResponse> listEvents(ClientContext ctx, ListEventsRequest request) {
    var emptyResponse = new ListEventsResponse();
    return _client.invoke(ctx, 'ErrorStatsService', 'ListEvents', request, emptyResponse);
  }
  Future<DeleteEventsResponse> deleteEvents(ClientContext ctx, DeleteEventsRequest request) {
    var emptyResponse = new DeleteEventsResponse();
    return _client.invoke(ctx, 'ErrorStatsService', 'DeleteEvents', request, emptyResponse);
  }
}

