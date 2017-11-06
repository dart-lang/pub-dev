///
//  Generated code. Do not modify.
///
library google.devtools.cloudtrace.v1_trace;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import '../../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../../protobuf/empty.pb.dart' as google$protobuf;

import 'trace.pbenum.dart';

export 'trace.pbenum.dart';

class Trace extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Trace')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'traceId', PbFieldType.OS)
    ..pp/*<TraceSpan>*/(3, 'spans', PbFieldType.PM, TraceSpan.$checkItem, TraceSpan.create)
    ..hasRequiredFields = false
  ;

  Trace() : super();
  Trace.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Trace.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Trace clone() => new Trace()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Trace create() => new Trace();
  static PbList<Trace> createRepeated() => new PbList<Trace>();
  static Trace getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTrace();
    return _defaultInstance;
  }
  static Trace _defaultInstance;
  static void $checkItem(Trace v) {
    if (v is !Trace) checkItemFailed(v, 'Trace');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get traceId => $_get(1, 2, '');
  void set traceId(String v) { $_setString(1, 2, v); }
  bool hasTraceId() => $_has(1, 2);
  void clearTraceId() => clearField(2);

  List<TraceSpan> get spans => $_get(2, 3, null);
}

class _ReadonlyTrace extends Trace with ReadonlyMessageMixin {}

class Traces extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Traces')
    ..pp/*<Trace>*/(1, 'traces', PbFieldType.PM, Trace.$checkItem, Trace.create)
    ..hasRequiredFields = false
  ;

  Traces() : super();
  Traces.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Traces.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Traces clone() => new Traces()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Traces create() => new Traces();
  static PbList<Traces> createRepeated() => new PbList<Traces>();
  static Traces getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTraces();
    return _defaultInstance;
  }
  static Traces _defaultInstance;
  static void $checkItem(Traces v) {
    if (v is !Traces) checkItemFailed(v, 'Traces');
  }

  List<Trace> get traces => $_get(0, 1, null);
}

class _ReadonlyTraces extends Traces with ReadonlyMessageMixin {}

class TraceSpan_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TraceSpan_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  TraceSpan_LabelsEntry() : super();
  TraceSpan_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TraceSpan_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TraceSpan_LabelsEntry clone() => new TraceSpan_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TraceSpan_LabelsEntry create() => new TraceSpan_LabelsEntry();
  static PbList<TraceSpan_LabelsEntry> createRepeated() => new PbList<TraceSpan_LabelsEntry>();
  static TraceSpan_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTraceSpan_LabelsEntry();
    return _defaultInstance;
  }
  static TraceSpan_LabelsEntry _defaultInstance;
  static void $checkItem(TraceSpan_LabelsEntry v) {
    if (v is !TraceSpan_LabelsEntry) checkItemFailed(v, 'TraceSpan_LabelsEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  String get value => $_get(1, 2, '');
  void set value(String v) { $_setString(1, 2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTraceSpan_LabelsEntry extends TraceSpan_LabelsEntry with ReadonlyMessageMixin {}

class TraceSpan extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('TraceSpan')
    ..a/*<Int64>*/(1, 'spanId', PbFieldType.OF6, Int64.ZERO)
    ..e/*<TraceSpan_SpanKind>*/(2, 'kind', PbFieldType.OE, TraceSpan_SpanKind.SPAN_KIND_UNSPECIFIED, TraceSpan_SpanKind.valueOf)
    ..a/*<String>*/(3, 'name', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(4, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(5, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<Int64>*/(6, 'parentSpanId', PbFieldType.OF6, Int64.ZERO)
    ..pp/*<TraceSpan_LabelsEntry>*/(7, 'labels', PbFieldType.PM, TraceSpan_LabelsEntry.$checkItem, TraceSpan_LabelsEntry.create)
    ..hasRequiredFields = false
  ;

  TraceSpan() : super();
  TraceSpan.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  TraceSpan.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  TraceSpan clone() => new TraceSpan()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static TraceSpan create() => new TraceSpan();
  static PbList<TraceSpan> createRepeated() => new PbList<TraceSpan>();
  static TraceSpan getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTraceSpan();
    return _defaultInstance;
  }
  static TraceSpan _defaultInstance;
  static void $checkItem(TraceSpan v) {
    if (v is !TraceSpan) checkItemFailed(v, 'TraceSpan');
  }

  Int64 get spanId => $_get(0, 1, null);
  void set spanId(Int64 v) { $_setInt64(0, 1, v); }
  bool hasSpanId() => $_has(0, 1);
  void clearSpanId() => clearField(1);

  TraceSpan_SpanKind get kind => $_get(1, 2, null);
  void set kind(TraceSpan_SpanKind v) { setField(2, v); }
  bool hasKind() => $_has(1, 2);
  void clearKind() => clearField(2);

  String get name => $_get(2, 3, '');
  void set name(String v) { $_setString(2, 3, v); }
  bool hasName() => $_has(2, 3);
  void clearName() => clearField(3);

  google$protobuf.Timestamp get startTime => $_get(3, 4, null);
  void set startTime(google$protobuf.Timestamp v) { setField(4, v); }
  bool hasStartTime() => $_has(3, 4);
  void clearStartTime() => clearField(4);

  google$protobuf.Timestamp get endTime => $_get(4, 5, null);
  void set endTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasEndTime() => $_has(4, 5);
  void clearEndTime() => clearField(5);

  Int64 get parentSpanId => $_get(5, 6, null);
  void set parentSpanId(Int64 v) { $_setInt64(5, 6, v); }
  bool hasParentSpanId() => $_has(5, 6);
  void clearParentSpanId() => clearField(6);

  List<TraceSpan_LabelsEntry> get labels => $_get(6, 7, null);
}

class _ReadonlyTraceSpan extends TraceSpan with ReadonlyMessageMixin {}

class ListTracesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTracesRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..e/*<ListTracesRequest_ViewType>*/(2, 'view', PbFieldType.OE, ListTracesRequest_ViewType.VIEW_TYPE_UNSPECIFIED, ListTracesRequest_ViewType.valueOf)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(4, 'pageToken', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(5, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(6, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<String>*/(7, 'filter', PbFieldType.OS)
    ..a/*<String>*/(8, 'orderBy', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTracesRequest() : super();
  ListTracesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTracesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTracesRequest clone() => new ListTracesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTracesRequest create() => new ListTracesRequest();
  static PbList<ListTracesRequest> createRepeated() => new PbList<ListTracesRequest>();
  static ListTracesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTracesRequest();
    return _defaultInstance;
  }
  static ListTracesRequest _defaultInstance;
  static void $checkItem(ListTracesRequest v) {
    if (v is !ListTracesRequest) checkItemFailed(v, 'ListTracesRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  ListTracesRequest_ViewType get view => $_get(1, 2, null);
  void set view(ListTracesRequest_ViewType v) { setField(2, v); }
  bool hasView() => $_has(1, 2);
  void clearView() => clearField(2);

  int get pageSize => $_get(2, 3, 0);
  void set pageSize(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasPageSize() => $_has(2, 3);
  void clearPageSize() => clearField(3);

  String get pageToken => $_get(3, 4, '');
  void set pageToken(String v) { $_setString(3, 4, v); }
  bool hasPageToken() => $_has(3, 4);
  void clearPageToken() => clearField(4);

  google$protobuf.Timestamp get startTime => $_get(4, 5, null);
  void set startTime(google$protobuf.Timestamp v) { setField(5, v); }
  bool hasStartTime() => $_has(4, 5);
  void clearStartTime() => clearField(5);

  google$protobuf.Timestamp get endTime => $_get(5, 6, null);
  void set endTime(google$protobuf.Timestamp v) { setField(6, v); }
  bool hasEndTime() => $_has(5, 6);
  void clearEndTime() => clearField(6);

  String get filter => $_get(6, 7, '');
  void set filter(String v) { $_setString(6, 7, v); }
  bool hasFilter() => $_has(6, 7);
  void clearFilter() => clearField(7);

  String get orderBy => $_get(7, 8, '');
  void set orderBy(String v) { $_setString(7, 8, v); }
  bool hasOrderBy() => $_has(7, 8);
  void clearOrderBy() => clearField(8);
}

class _ReadonlyListTracesRequest extends ListTracesRequest with ReadonlyMessageMixin {}

class ListTracesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListTracesResponse')
    ..pp/*<Trace>*/(1, 'traces', PbFieldType.PM, Trace.$checkItem, Trace.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListTracesResponse() : super();
  ListTracesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListTracesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListTracesResponse clone() => new ListTracesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListTracesResponse create() => new ListTracesResponse();
  static PbList<ListTracesResponse> createRepeated() => new PbList<ListTracesResponse>();
  static ListTracesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListTracesResponse();
    return _defaultInstance;
  }
  static ListTracesResponse _defaultInstance;
  static void $checkItem(ListTracesResponse v) {
    if (v is !ListTracesResponse) checkItemFailed(v, 'ListTracesResponse');
  }

  List<Trace> get traces => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListTracesResponse extends ListTracesResponse with ReadonlyMessageMixin {}

class GetTraceRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetTraceRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<String>*/(2, 'traceId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetTraceRequest() : super();
  GetTraceRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetTraceRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetTraceRequest clone() => new GetTraceRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetTraceRequest create() => new GetTraceRequest();
  static PbList<GetTraceRequest> createRepeated() => new PbList<GetTraceRequest>();
  static GetTraceRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetTraceRequest();
    return _defaultInstance;
  }
  static GetTraceRequest _defaultInstance;
  static void $checkItem(GetTraceRequest v) {
    if (v is !GetTraceRequest) checkItemFailed(v, 'GetTraceRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  String get traceId => $_get(1, 2, '');
  void set traceId(String v) { $_setString(1, 2, v); }
  bool hasTraceId() => $_has(1, 2);
  void clearTraceId() => clearField(2);
}

class _ReadonlyGetTraceRequest extends GetTraceRequest with ReadonlyMessageMixin {}

class PatchTracesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PatchTracesRequest')
    ..a/*<String>*/(1, 'projectId', PbFieldType.OS)
    ..a/*<Traces>*/(2, 'traces', PbFieldType.OM, Traces.getDefault, Traces.create)
    ..hasRequiredFields = false
  ;

  PatchTracesRequest() : super();
  PatchTracesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PatchTracesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PatchTracesRequest clone() => new PatchTracesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PatchTracesRequest create() => new PatchTracesRequest();
  static PbList<PatchTracesRequest> createRepeated() => new PbList<PatchTracesRequest>();
  static PatchTracesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPatchTracesRequest();
    return _defaultInstance;
  }
  static PatchTracesRequest _defaultInstance;
  static void $checkItem(PatchTracesRequest v) {
    if (v is !PatchTracesRequest) checkItemFailed(v, 'PatchTracesRequest');
  }

  String get projectId => $_get(0, 1, '');
  void set projectId(String v) { $_setString(0, 1, v); }
  bool hasProjectId() => $_has(0, 1);
  void clearProjectId() => clearField(1);

  Traces get traces => $_get(1, 2, null);
  void set traces(Traces v) { setField(2, v); }
  bool hasTraces() => $_has(1, 2);
  void clearTraces() => clearField(2);
}

class _ReadonlyPatchTracesRequest extends PatchTracesRequest with ReadonlyMessageMixin {}

class TraceServiceApi {
  RpcClient _client;
  TraceServiceApi(this._client);

  Future<ListTracesResponse> listTraces(ClientContext ctx, ListTracesRequest request) {
    var emptyResponse = new ListTracesResponse();
    return _client.invoke(ctx, 'TraceService', 'ListTraces', request, emptyResponse);
  }
  Future<Trace> getTrace(ClientContext ctx, GetTraceRequest request) {
    var emptyResponse = new Trace();
    return _client.invoke(ctx, 'TraceService', 'GetTrace', request, emptyResponse);
  }
  Future<google$protobuf.Empty> patchTraces(ClientContext ctx, PatchTracesRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'TraceService', 'PatchTraces', request, emptyResponse);
  }
}

