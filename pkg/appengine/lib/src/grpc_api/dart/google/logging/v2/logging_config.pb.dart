///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_config;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../protobuf/empty.pb.dart' as google$protobuf;

import 'logging_config.pbenum.dart';

export 'logging_config.pbenum.dart';

class LogSink extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LogSink')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(3, 'destination', PbFieldType.OS)
    ..a/*<String>*/(5, 'filter', PbFieldType.OS)
    ..e/*<LogSink_VersionFormat>*/(6, 'outputVersionFormat', PbFieldType.OE, LogSink_VersionFormat.VERSION_FORMAT_UNSPECIFIED, LogSink_VersionFormat.valueOf)
    ..a/*<String>*/(8, 'writerIdentity', PbFieldType.OS)
    ..a/*<google$protobuf.Timestamp>*/(10, 'startTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..a/*<google$protobuf.Timestamp>*/(11, 'endTime', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  LogSink() : super();
  LogSink.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LogSink.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LogSink clone() => new LogSink()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LogSink create() => new LogSink();
  static PbList<LogSink> createRepeated() => new PbList<LogSink>();
  static LogSink getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLogSink();
    return _defaultInstance;
  }
  static LogSink _defaultInstance;
  static void $checkItem(LogSink v) {
    if (v is !LogSink) checkItemFailed(v, 'LogSink');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get destination => $_get(1, 3, '');
  void set destination(String v) { $_setString(1, 3, v); }
  bool hasDestination() => $_has(1, 3);
  void clearDestination() => clearField(3);

  String get filter => $_get(2, 5, '');
  void set filter(String v) { $_setString(2, 5, v); }
  bool hasFilter() => $_has(2, 5);
  void clearFilter() => clearField(5);

  LogSink_VersionFormat get outputVersionFormat => $_get(3, 6, null);
  void set outputVersionFormat(LogSink_VersionFormat v) { setField(6, v); }
  bool hasOutputVersionFormat() => $_has(3, 6);
  void clearOutputVersionFormat() => clearField(6);

  String get writerIdentity => $_get(4, 8, '');
  void set writerIdentity(String v) { $_setString(4, 8, v); }
  bool hasWriterIdentity() => $_has(4, 8);
  void clearWriterIdentity() => clearField(8);

  google$protobuf.Timestamp get startTime => $_get(5, 10, null);
  void set startTime(google$protobuf.Timestamp v) { setField(10, v); }
  bool hasStartTime() => $_has(5, 10);
  void clearStartTime() => clearField(10);

  google$protobuf.Timestamp get endTime => $_get(6, 11, null);
  void set endTime(google$protobuf.Timestamp v) { setField(11, v); }
  bool hasEndTime() => $_has(6, 11);
  void clearEndTime() => clearField(11);
}

class _ReadonlyLogSink extends LogSink with ReadonlyMessageMixin {}

class ListSinksRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListSinksRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<String>*/(2, 'pageToken', PbFieldType.OS)
    ..a/*<int>*/(3, 'pageSize', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListSinksRequest() : super();
  ListSinksRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListSinksRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListSinksRequest clone() => new ListSinksRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListSinksRequest create() => new ListSinksRequest();
  static PbList<ListSinksRequest> createRepeated() => new PbList<ListSinksRequest>();
  static ListSinksRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListSinksRequest();
    return _defaultInstance;
  }
  static ListSinksRequest _defaultInstance;
  static void $checkItem(ListSinksRequest v) {
    if (v is !ListSinksRequest) checkItemFailed(v, 'ListSinksRequest');
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

class _ReadonlyListSinksRequest extends ListSinksRequest with ReadonlyMessageMixin {}

class ListSinksResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ListSinksResponse')
    ..pp/*<LogSink>*/(1, 'sinks', PbFieldType.PM, LogSink.$checkItem, LogSink.create)
    ..a/*<String>*/(2, 'nextPageToken', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  ListSinksResponse() : super();
  ListSinksResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ListSinksResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ListSinksResponse clone() => new ListSinksResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ListSinksResponse create() => new ListSinksResponse();
  static PbList<ListSinksResponse> createRepeated() => new PbList<ListSinksResponse>();
  static ListSinksResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyListSinksResponse();
    return _defaultInstance;
  }
  static ListSinksResponse _defaultInstance;
  static void $checkItem(ListSinksResponse v) {
    if (v is !ListSinksResponse) checkItemFailed(v, 'ListSinksResponse');
  }

  List<LogSink> get sinks => $_get(0, 1, null);

  String get nextPageToken => $_get(1, 2, '');
  void set nextPageToken(String v) { $_setString(1, 2, v); }
  bool hasNextPageToken() => $_has(1, 2);
  void clearNextPageToken() => clearField(2);
}

class _ReadonlyListSinksResponse extends ListSinksResponse with ReadonlyMessageMixin {}

class GetSinkRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetSinkRequest')
    ..a/*<String>*/(1, 'sinkName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetSinkRequest() : super();
  GetSinkRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetSinkRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetSinkRequest clone() => new GetSinkRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetSinkRequest create() => new GetSinkRequest();
  static PbList<GetSinkRequest> createRepeated() => new PbList<GetSinkRequest>();
  static GetSinkRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetSinkRequest();
    return _defaultInstance;
  }
  static GetSinkRequest _defaultInstance;
  static void $checkItem(GetSinkRequest v) {
    if (v is !GetSinkRequest) checkItemFailed(v, 'GetSinkRequest');
  }

  String get sinkName => $_get(0, 1, '');
  void set sinkName(String v) { $_setString(0, 1, v); }
  bool hasSinkName() => $_has(0, 1);
  void clearSinkName() => clearField(1);
}

class _ReadonlyGetSinkRequest extends GetSinkRequest with ReadonlyMessageMixin {}

class CreateSinkRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateSinkRequest')
    ..a/*<String>*/(1, 'parent', PbFieldType.OS)
    ..a/*<LogSink>*/(2, 'sink', PbFieldType.OM, LogSink.getDefault, LogSink.create)
    ..a/*<bool>*/(3, 'uniqueWriterIdentity', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  CreateSinkRequest() : super();
  CreateSinkRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateSinkRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateSinkRequest clone() => new CreateSinkRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateSinkRequest create() => new CreateSinkRequest();
  static PbList<CreateSinkRequest> createRepeated() => new PbList<CreateSinkRequest>();
  static CreateSinkRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateSinkRequest();
    return _defaultInstance;
  }
  static CreateSinkRequest _defaultInstance;
  static void $checkItem(CreateSinkRequest v) {
    if (v is !CreateSinkRequest) checkItemFailed(v, 'CreateSinkRequest');
  }

  String get parent => $_get(0, 1, '');
  void set parent(String v) { $_setString(0, 1, v); }
  bool hasParent() => $_has(0, 1);
  void clearParent() => clearField(1);

  LogSink get sink => $_get(1, 2, null);
  void set sink(LogSink v) { setField(2, v); }
  bool hasSink() => $_has(1, 2);
  void clearSink() => clearField(2);

  bool get uniqueWriterIdentity => $_get(2, 3, false);
  void set uniqueWriterIdentity(bool v) { $_setBool(2, 3, v); }
  bool hasUniqueWriterIdentity() => $_has(2, 3);
  void clearUniqueWriterIdentity() => clearField(3);
}

class _ReadonlyCreateSinkRequest extends CreateSinkRequest with ReadonlyMessageMixin {}

class UpdateSinkRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UpdateSinkRequest')
    ..a/*<String>*/(1, 'sinkName', PbFieldType.OS)
    ..a/*<LogSink>*/(2, 'sink', PbFieldType.OM, LogSink.getDefault, LogSink.create)
    ..a/*<bool>*/(3, 'uniqueWriterIdentity', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  UpdateSinkRequest() : super();
  UpdateSinkRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UpdateSinkRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UpdateSinkRequest clone() => new UpdateSinkRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UpdateSinkRequest create() => new UpdateSinkRequest();
  static PbList<UpdateSinkRequest> createRepeated() => new PbList<UpdateSinkRequest>();
  static UpdateSinkRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUpdateSinkRequest();
    return _defaultInstance;
  }
  static UpdateSinkRequest _defaultInstance;
  static void $checkItem(UpdateSinkRequest v) {
    if (v is !UpdateSinkRequest) checkItemFailed(v, 'UpdateSinkRequest');
  }

  String get sinkName => $_get(0, 1, '');
  void set sinkName(String v) { $_setString(0, 1, v); }
  bool hasSinkName() => $_has(0, 1);
  void clearSinkName() => clearField(1);

  LogSink get sink => $_get(1, 2, null);
  void set sink(LogSink v) { setField(2, v); }
  bool hasSink() => $_has(1, 2);
  void clearSink() => clearField(2);

  bool get uniqueWriterIdentity => $_get(2, 3, false);
  void set uniqueWriterIdentity(bool v) { $_setBool(2, 3, v); }
  bool hasUniqueWriterIdentity() => $_has(2, 3);
  void clearUniqueWriterIdentity() => clearField(3);
}

class _ReadonlyUpdateSinkRequest extends UpdateSinkRequest with ReadonlyMessageMixin {}

class DeleteSinkRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteSinkRequest')
    ..a/*<String>*/(1, 'sinkName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteSinkRequest() : super();
  DeleteSinkRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteSinkRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteSinkRequest clone() => new DeleteSinkRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteSinkRequest create() => new DeleteSinkRequest();
  static PbList<DeleteSinkRequest> createRepeated() => new PbList<DeleteSinkRequest>();
  static DeleteSinkRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteSinkRequest();
    return _defaultInstance;
  }
  static DeleteSinkRequest _defaultInstance;
  static void $checkItem(DeleteSinkRequest v) {
    if (v is !DeleteSinkRequest) checkItemFailed(v, 'DeleteSinkRequest');
  }

  String get sinkName => $_get(0, 1, '');
  void set sinkName(String v) { $_setString(0, 1, v); }
  bool hasSinkName() => $_has(0, 1);
  void clearSinkName() => clearField(1);
}

class _ReadonlyDeleteSinkRequest extends DeleteSinkRequest with ReadonlyMessageMixin {}

class ConfigServiceV2Api {
  RpcClient _client;
  ConfigServiceV2Api(this._client);

  Future<ListSinksResponse> listSinks(ClientContext ctx, ListSinksRequest request) {
    var emptyResponse = new ListSinksResponse();
    return _client.invoke(ctx, 'ConfigServiceV2', 'ListSinks', request, emptyResponse);
  }
  Future<LogSink> getSink(ClientContext ctx, GetSinkRequest request) {
    var emptyResponse = new LogSink();
    return _client.invoke(ctx, 'ConfigServiceV2', 'GetSink', request, emptyResponse);
  }
  Future<LogSink> createSink(ClientContext ctx, CreateSinkRequest request) {
    var emptyResponse = new LogSink();
    return _client.invoke(ctx, 'ConfigServiceV2', 'CreateSink', request, emptyResponse);
  }
  Future<LogSink> updateSink(ClientContext ctx, UpdateSinkRequest request) {
    var emptyResponse = new LogSink();
    return _client.invoke(ctx, 'ConfigServiceV2', 'UpdateSink', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteSink(ClientContext ctx, DeleteSinkRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'ConfigServiceV2', 'DeleteSink', request, emptyResponse);
  }
}

