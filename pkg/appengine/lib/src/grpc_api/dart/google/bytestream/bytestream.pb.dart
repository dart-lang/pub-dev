///
//  Generated code. Do not modify.
///
library google.bytestream_bytestream;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class ReadRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRequest')
    ..a/*<String>*/(1, 'resourceName', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'readOffset', PbFieldType.O6, Int64.ZERO)
    ..a/*<Int64>*/(3, 'readLimit', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ReadRequest() : super();
  ReadRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadRequest clone() => new ReadRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadRequest create() => new ReadRequest();
  static PbList<ReadRequest> createRepeated() => new PbList<ReadRequest>();
  static ReadRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadRequest();
    return _defaultInstance;
  }
  static ReadRequest _defaultInstance;
  static void $checkItem(ReadRequest v) {
    if (v is !ReadRequest) checkItemFailed(v, 'ReadRequest');
  }

  String get resourceName => $_get(0, 1, '');
  void set resourceName(String v) { $_setString(0, 1, v); }
  bool hasResourceName() => $_has(0, 1);
  void clearResourceName() => clearField(1);

  Int64 get readOffset => $_get(1, 2, null);
  void set readOffset(Int64 v) { $_setInt64(1, 2, v); }
  bool hasReadOffset() => $_has(1, 2);
  void clearReadOffset() => clearField(2);

  Int64 get readLimit => $_get(2, 3, null);
  void set readLimit(Int64 v) { $_setInt64(2, 3, v); }
  bool hasReadLimit() => $_has(2, 3);
  void clearReadLimit() => clearField(3);
}

class _ReadonlyReadRequest extends ReadRequest with ReadonlyMessageMixin {}

class ReadResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadResponse')
    ..a/*<List<int>>*/(10, 'data', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ReadResponse() : super();
  ReadResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadResponse clone() => new ReadResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadResponse create() => new ReadResponse();
  static PbList<ReadResponse> createRepeated() => new PbList<ReadResponse>();
  static ReadResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadResponse();
    return _defaultInstance;
  }
  static ReadResponse _defaultInstance;
  static void $checkItem(ReadResponse v) {
    if (v is !ReadResponse) checkItemFailed(v, 'ReadResponse');
  }

  List<int> get data => $_get(0, 10, null);
  void set data(List<int> v) { $_setBytes(0, 10, v); }
  bool hasData() => $_has(0, 10);
  void clearData() => clearField(10);
}

class _ReadonlyReadResponse extends ReadResponse with ReadonlyMessageMixin {}

class WriteRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WriteRequest')
    ..a/*<String>*/(1, 'resourceName', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'writeOffset', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(3, 'finishWrite', PbFieldType.OB)
    ..a/*<List<int>>*/(10, 'data', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  WriteRequest() : super();
  WriteRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WriteRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WriteRequest clone() => new WriteRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteRequest create() => new WriteRequest();
  static PbList<WriteRequest> createRepeated() => new PbList<WriteRequest>();
  static WriteRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWriteRequest();
    return _defaultInstance;
  }
  static WriteRequest _defaultInstance;
  static void $checkItem(WriteRequest v) {
    if (v is !WriteRequest) checkItemFailed(v, 'WriteRequest');
  }

  String get resourceName => $_get(0, 1, '');
  void set resourceName(String v) { $_setString(0, 1, v); }
  bool hasResourceName() => $_has(0, 1);
  void clearResourceName() => clearField(1);

  Int64 get writeOffset => $_get(1, 2, null);
  void set writeOffset(Int64 v) { $_setInt64(1, 2, v); }
  bool hasWriteOffset() => $_has(1, 2);
  void clearWriteOffset() => clearField(2);

  bool get finishWrite => $_get(2, 3, false);
  void set finishWrite(bool v) { $_setBool(2, 3, v); }
  bool hasFinishWrite() => $_has(2, 3);
  void clearFinishWrite() => clearField(3);

  List<int> get data => $_get(3, 10, null);
  void set data(List<int> v) { $_setBytes(3, 10, v); }
  bool hasData() => $_has(3, 10);
  void clearData() => clearField(10);
}

class _ReadonlyWriteRequest extends WriteRequest with ReadonlyMessageMixin {}

class WriteResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('WriteResponse')
    ..a/*<Int64>*/(1, 'committedSize', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  WriteResponse() : super();
  WriteResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  WriteResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  WriteResponse clone() => new WriteResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static WriteResponse create() => new WriteResponse();
  static PbList<WriteResponse> createRepeated() => new PbList<WriteResponse>();
  static WriteResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyWriteResponse();
    return _defaultInstance;
  }
  static WriteResponse _defaultInstance;
  static void $checkItem(WriteResponse v) {
    if (v is !WriteResponse) checkItemFailed(v, 'WriteResponse');
  }

  Int64 get committedSize => $_get(0, 1, null);
  void set committedSize(Int64 v) { $_setInt64(0, 1, v); }
  bool hasCommittedSize() => $_has(0, 1);
  void clearCommittedSize() => clearField(1);
}

class _ReadonlyWriteResponse extends WriteResponse with ReadonlyMessageMixin {}

class QueryWriteStatusRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryWriteStatusRequest')
    ..a/*<String>*/(1, 'resourceName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  QueryWriteStatusRequest() : super();
  QueryWriteStatusRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryWriteStatusRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryWriteStatusRequest clone() => new QueryWriteStatusRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryWriteStatusRequest create() => new QueryWriteStatusRequest();
  static PbList<QueryWriteStatusRequest> createRepeated() => new PbList<QueryWriteStatusRequest>();
  static QueryWriteStatusRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryWriteStatusRequest();
    return _defaultInstance;
  }
  static QueryWriteStatusRequest _defaultInstance;
  static void $checkItem(QueryWriteStatusRequest v) {
    if (v is !QueryWriteStatusRequest) checkItemFailed(v, 'QueryWriteStatusRequest');
  }

  String get resourceName => $_get(0, 1, '');
  void set resourceName(String v) { $_setString(0, 1, v); }
  bool hasResourceName() => $_has(0, 1);
  void clearResourceName() => clearField(1);
}

class _ReadonlyQueryWriteStatusRequest extends QueryWriteStatusRequest with ReadonlyMessageMixin {}

class QueryWriteStatusResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('QueryWriteStatusResponse')
    ..a/*<Int64>*/(1, 'committedSize', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(2, 'complete', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  QueryWriteStatusResponse() : super();
  QueryWriteStatusResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  QueryWriteStatusResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  QueryWriteStatusResponse clone() => new QueryWriteStatusResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static QueryWriteStatusResponse create() => new QueryWriteStatusResponse();
  static PbList<QueryWriteStatusResponse> createRepeated() => new PbList<QueryWriteStatusResponse>();
  static QueryWriteStatusResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyQueryWriteStatusResponse();
    return _defaultInstance;
  }
  static QueryWriteStatusResponse _defaultInstance;
  static void $checkItem(QueryWriteStatusResponse v) {
    if (v is !QueryWriteStatusResponse) checkItemFailed(v, 'QueryWriteStatusResponse');
  }

  Int64 get committedSize => $_get(0, 1, null);
  void set committedSize(Int64 v) { $_setInt64(0, 1, v); }
  bool hasCommittedSize() => $_has(0, 1);
  void clearCommittedSize() => clearField(1);

  bool get complete => $_get(1, 2, false);
  void set complete(bool v) { $_setBool(1, 2, v); }
  bool hasComplete() => $_has(1, 2);
  void clearComplete() => clearField(2);
}

class _ReadonlyQueryWriteStatusResponse extends QueryWriteStatusResponse with ReadonlyMessageMixin {}

class ByteStreamApi {
  RpcClient _client;
  ByteStreamApi(this._client);

  Future<ReadResponse> read(ClientContext ctx, ReadRequest request) {
    var emptyResponse = new ReadResponse();
    return _client.invoke(ctx, 'ByteStream', 'Read', request, emptyResponse);
  }
  Future<WriteResponse> write(ClientContext ctx, WriteRequest request) {
    var emptyResponse = new WriteResponse();
    return _client.invoke(ctx, 'ByteStream', 'Write', request, emptyResponse);
  }
  Future<QueryWriteStatusResponse> queryWriteStatus(ClientContext ctx, QueryWriteStatusRequest request) {
    var emptyResponse = new QueryWriteStatusResponse();
    return _client.invoke(ctx, 'ByteStream', 'QueryWriteStatus', request, emptyResponse);
  }
}

