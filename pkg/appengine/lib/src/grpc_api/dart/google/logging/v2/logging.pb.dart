///
//  Generated code. Do not modify.
///
library google.logging.v2_logging;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/monitored_resource.pb.dart' as google$api;
import 'log_entry.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;

class DeleteLogRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteLogRequest')
    ..a/*<String>*/(1, 'logName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteLogRequest() : super();
  DeleteLogRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteLogRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteLogRequest clone() => new DeleteLogRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteLogRequest create() => new DeleteLogRequest();
  static PbList<DeleteLogRequest> createRepeated() => new PbList<DeleteLogRequest>();
  static DeleteLogRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteLogRequest();
    return _defaultInstance;
  }
  static DeleteLogRequest _defaultInstance;
  static void $checkItem(DeleteLogRequest v) {
    if (v is !DeleteLogRequest) checkItemFailed(v, 'DeleteLogRequest');
  }

  String get logName => $_get(0, 1, '');
  void set logName(String v) { $_setString(0, 1, v); }
  bool hasLogName() => $_has(0, 1);
  void clearLogName() => clearField(1);
}

class _ReadonlyDeleteLogRequest extends DeleteLogRequest with ReadonlyMessageMixin {}

class WriteLogEntriesRequest_LabelsEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WriteLogEntriesRequest_LabelsEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<String>*/(2, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  WriteLogEntriesRequest_LabelsEntry() : super();
  WriteLogEntriesRequest_LabelsEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WriteLogEntriesRequest_LabelsEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WriteLogEntriesRequest_LabelsEntry clone() => new WriteLogEntriesRequest_LabelsEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesRequest_LabelsEntry create() => new WriteLogEntriesRequest_LabelsEntry();
  static PbList<WriteLogEntriesRequest_LabelsEntry> createRepeated() => new PbList<WriteLogEntriesRequest_LabelsEntry>();
  static WriteLogEntriesRequest_LabelsEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWriteLogEntriesRequest_LabelsEntry();
    return _defaultInstance;
  }
  static WriteLogEntriesRequest_LabelsEntry _defaultInstance;
  static void $checkItem(WriteLogEntriesRequest_LabelsEntry v) {
    if (v is !WriteLogEntriesRequest_LabelsEntry) checkItemFailed(v, 'WriteLogEntriesRequest_LabelsEntry');
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

class _ReadonlyWriteLogEntriesRequest_LabelsEntry extends WriteLogEntriesRequest_LabelsEntry with ReadonlyMessageMixin {}

class WriteLogEntriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WriteLogEntriesRequest')
    ..a/*<String>*/(1, 'logName', PbFieldType.OS)
    ..a/*<google$api.MonitoredResource>*/(2, 'resource', PbFieldType.OM, google$api.MonitoredResource.getDefault, google$api.MonitoredResource.create)
    ..pp/*<WriteLogEntriesRequest_LabelsEntry>*/(3, 'labels', PbFieldType.PM, WriteLogEntriesRequest_LabelsEntry.$checkItem, WriteLogEntriesRequest_LabelsEntry.create)
    ..pp/*<LogEntry>*/(4, 'entries', PbFieldType.PM, LogEntry.$checkItem, LogEntry.create)
    ..a/*<bool>*/(5, 'partialSuccess', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  WriteLogEntriesRequest() : super();
  WriteLogEntriesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WriteLogEntriesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WriteLogEntriesRequest clone() => new WriteLogEntriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesRequest create() => new WriteLogEntriesRequest();
  static PbList<WriteLogEntriesRequest> createRepeated() => new PbList<WriteLogEntriesRequest>();
  static WriteLogEntriesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWriteLogEntriesRequest();
    return _defaultInstance;
  }
  static WriteLogEntriesRequest _defaultInstance;
  static void $checkItem(WriteLogEntriesRequest v) {
    if (v is !WriteLogEntriesRequest) checkItemFailed(v, 'WriteLogEntriesRequest');
  }

  String get logName => $_get(0, 1, '');
  void set logName(String v) { $_setString(0, 1, v); }
  bool hasLogName() => $_has(0, 1);
  void clearLogName() => clearField(1);

  google$api.MonitoredResource get resource => $_get(1, 2, null);
  void set resource(google$api.MonitoredResource v) { setField(2, v); }
  bool hasResource() => $_has(1, 2);
  void clearResource() => clearField(2);

  List<WriteLogEntriesRequest_LabelsEntry> get labels => $_get(2, 3, null);

  List<LogEntry> get entries => $_get(3, 4, null);

  bool get partialSuccess => $_get(4, 5, false);
  void set partialSuccess(bool v) { $_setBool(4, 5, v); }
  bool hasPartialSuccess() => $_has(4, 5);
  void clearPartialSuccess() => clearField(5);
}

class _ReadonlyWriteLogEntriesRequest extends WriteLogEntriesRequest with ReadonlyMessageMixin {}

class WriteLogEntriesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WriteLogEntriesResponse')
    ..hasRequiredFields = false
  ;

  WriteLogEntriesResponse() : super();
  WriteLogEntriesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WriteLogEntriesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WriteLogEntriesResponse clone() => new WriteLogEntriesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteLogEntriesResponse create() => new WriteLogEntriesResponse();
  static PbList<WriteLogEntriesResponse> createRepeated() => new PbList<WriteLogEntriesResponse>();
  static WriteLogEntriesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWriteLogEntriesResponse();
    return _defaultInstance;
  }
  static WriteLogEntriesResponse _defaultInstance;
  static void $checkItem(WriteLogEntriesResponse v) {
    if (v is !WriteLogEntriesResponse) checkItemFailed(v, 'WriteLogEntriesResponse');
  }
}

class _ReadonlyWriteLogEntriesResponse extends WriteLogEntriesResponse with ReadonlyMessageMixin {}

class ListLogEntriesRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogEntriesRequest')
    ..p/*<String>*/(1, 'projectIds', PbFieldType.PS)
    ..a/*<String>*/(2, 'filter', PbFieldType.OS)
    ..a/*<String>*/(3, 'orderBy', PbFieldType.OS)
    ..a/*<int>*/(4, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(5, 'pageToken', PbFieldType.OS)
    ..p/*<String>*/(8, 'resourceNames', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ListLogEntriesRequest() : super();
  ListLogEntriesRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogEntriesRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogEntriesRequest clone() => new ListLogEntriesRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogEntriesRequest create() => new ListLogEntriesRequest();
  static PbList<ListLogEntriesRequest> createRepeated() => new PbList<ListLogEntriesRequest>();
  static ListLogEntriesRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogEntriesRequest();
    return _defaultInstance;
  }
  static ListLogEntriesRequest _defaultInstance;
  static void $checkItem(ListLogEntriesRequest v) {
    if (v is !ListLogEntriesRequest) checkItemFailed(v, 'ListLogEntriesRequest');
  }

  List<String> get projectIds => $_get(0, 1, null);

  String get filter => $_get(1, 2, '');
  void set filter(String v) { $_setString(1, 2, v); }
  bool hasFilter() => $_has(1, 2);
  void clearFilter() => clearField(2);

  String get orderBy => $_get(2, 3, '');
  void set orderBy(String v) { $_setString(2, 3, v); }
  bool hasOrderBy() => $_has(2, 3);
  void clearOrderBy() => clearField(3);

  int get pageSize => $_get(3, 4, 0);
  void set pageSize(int v) { $_setUnsignedInt32(3, 4, v); }
  bool hasPageSize() => $_has(3, 4);
  void clearPageSize() => clearField(4);

  String get pageToken => $_get(4, 5, '');
  void set pageToken(String v) { $_setString(4, 5, v); }
  bool hasPageToken() => $_has(4, 5);
  void clearPageToken() => clearField(5);

  List<String> get resourceNames => $_get(5, 8, null);
}

class _ReadonlyListLogEntriesRequest extends ListLogEntriesRequest with ReadonlyMessageMixin {}

class ListLogEntriesResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogEntriesResponse')
    ..pp/*<LogEntry>*/(1, 'entries', PbFieldType.PM, LogEntry.$checkItem, LogEntry.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListLogEntriesResponse() : super();
  ListLogEntriesResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogEntriesResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogEntriesResponse clone() => new ListLogEntriesResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogEntriesResponse create() => new ListLogEntriesResponse();
  static PbList<ListLogEntriesResponse> createRepeated() => new PbList<ListLogEntriesResponse>();
  static ListLogEntriesResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogEntriesResponse();
    return _defaultInstance;
  }
  static ListLogEntriesResponse _defaultInstance;
  static void $checkItem(ListLogEntriesResponse v) {
    if (v is !ListLogEntriesResponse) checkItemFailed(v, 'ListLogEntriesResponse');
  }

  List<LogEntry> get entries => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListLogEntriesResponse extends ListLogEntriesResponse with ReadonlyMessageMixin {}

class ListMonitoredResourceDescriptorsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListMonitoredResourceDescriptorsRequest')
    ..a/*<int>*/(1, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
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

  int get pageSize => $_get(0, 1, 0);
  void set pageSize(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasPageSize() => $_has(0, 1);
  void clearPageSize() => clearField(1);

  String get pageToken => $_get(1, 2, '');
  void set pageToken(String v) { $_setString(1, 2, v); }
  bool hasPageToken() => $_has(1, 2);
  void clearPageToken() => clearField(2);
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

class ListLogsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogsRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<int>*/(2, 'pageSize', PbFieldType.O3)
    ..a/*<String>*/(3, 'pageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListLogsRequest() : super();
  ListLogsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogsRequest clone() => new ListLogsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogsRequest create() => new ListLogsRequest();
  static PbList<ListLogsRequest> createRepeated() => new PbList<ListLogsRequest>();
  static ListLogsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogsRequest();
    return _defaultInstance;
  }
  static ListLogsRequest _defaultInstance;
  static void $checkItem(ListLogsRequest v) {
    if (v is !ListLogsRequest) checkItemFailed(v, 'ListLogsRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  int get pageSize => $_get(1, 2, 0);
  void set pageSize(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasPageSize() => $_has(1, 2);
  void clearPageSize() => clearField(2);

  String get pageToken => $_get(2, 3, '');
  void set pageToken(String v) { $_setString(2, 3, v); }
  bool hasPageToken() => $_has(2, 3);
  void clearPageToken() => clearField(3);
}

class _ReadonlyListLogsRequest extends ListLogsRequest with ReadonlyMessageMixin {}

class ListLogsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListLogsResponse')
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..p/*<String>*/(3, 'logNames', PbFieldType.PS)
    ..hasRequiredFields = false
  ;

  ListLogsResponse() : super();
  ListLogsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListLogsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListLogsResponse clone() => new ListLogsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListLogsResponse create() => new ListLogsResponse();
  static PbList<ListLogsResponse> createRepeated() => new PbList<ListLogsResponse>();
  static ListLogsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListLogsResponse();
    return _defaultInstance;
  }
  static ListLogsResponse _defaultInstance;
  static void $checkItem(ListLogsResponse v) {
    if (v is !ListLogsResponse) checkItemFailed(v, 'ListLogsResponse');
  }

  String get nextPageToken => $_get(0, 2, '');
  void set nextPageToken(String v) { $_setString(0, 2, v); }
  bool hasNextPageToken() => $_has(0, 2);
  void clearNextPageToken() => clearField(2);

  List<String> get logNames => $_get(1, 3, null);
}

class _ReadonlyListLogsResponse extends ListLogsResponse with ReadonlyMessageMixin {}

class LoggingServiceV2Api {
  RpcClient _client;
  LoggingServiceV2Api(this._client);

  Future<google$protobuf.Empty> deleteLog(ClientContext ctx, DeleteLogRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'LoggingServiceV2', 'DeleteLog', request, emptyResponse);
  }
  Future<WriteLogEntriesResponse> writeLogEntries(ClientContext ctx, WriteLogEntriesRequest request) {
    var emptyResponse = new WriteLogEntriesResponse();
    return _client.invoke(ctx, 'LoggingServiceV2', 'WriteLogEntries', request, emptyResponse);
  }
  Future<ListLogEntriesResponse> listLogEntries(ClientContext ctx, ListLogEntriesRequest request) {
    var emptyResponse = new ListLogEntriesResponse();
    return _client.invoke(ctx, 'LoggingServiceV2', 'ListLogEntries', request, emptyResponse);
  }
  Future<ListMonitoredResourceDescriptorsResponse> listMonitoredResourceDescriptors(ClientContext ctx, ListMonitoredResourceDescriptorsRequest request) {
    var emptyResponse = new ListMonitoredResourceDescriptorsResponse();
    return _client.invoke(ctx, 'LoggingServiceV2', 'ListMonitoredResourceDescriptors', request, emptyResponse);
  }
  Future<ListLogsResponse> listLogs(ClientContext ctx, ListLogsRequest request) {
    var emptyResponse = new ListLogsResponse();
    return _client.invoke(ctx, 'LoggingServiceV2', 'ListLogs', request, emptyResponse);
  }
}

