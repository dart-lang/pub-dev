///
//  Generated code. Do not modify.
///
library google.spanner.v1_spanner;

import 'dart:async';
import 'dart:core' hide Type;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'transaction.pb.dart';
import '../../protobuf/struct.pb.dart' as google$protobuf;
import 'type.pb.dart';
import 'keys.pb.dart';
import 'mutation.pb.dart';
import '../../protobuf/timestamp.pb.dart' as google$protobuf;
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'result_set.pb.dart';

import 'spanner.pbenum.dart';

export 'spanner.pbenum.dart';

class CreateSessionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CreateSessionRequest')
    ..a/*<String>*/(1, 'database', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  CreateSessionRequest() : super();
  CreateSessionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CreateSessionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CreateSessionRequest clone() => new CreateSessionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CreateSessionRequest create() => new CreateSessionRequest();
  static PbList<CreateSessionRequest> createRepeated() => new PbList<CreateSessionRequest>();
  static CreateSessionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCreateSessionRequest();
    return _defaultInstance;
  }
  static CreateSessionRequest _defaultInstance;
  static void $checkItem(CreateSessionRequest v) {
    if (v is !CreateSessionRequest) checkItemFailed(v, 'CreateSessionRequest');
  }

  String get database => $_get(0, 1, '');
  void set database(String v) { $_setString(0, 1, v); }
  bool hasDatabase() => $_has(0, 1);
  void clearDatabase() => clearField(1);
}

class _ReadonlyCreateSessionRequest extends CreateSessionRequest with ReadonlyMessageMixin {}

class Session extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Session')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Session() : super();
  Session.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Session.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Session clone() => new Session()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Session create() => new Session();
  static PbList<Session> createRepeated() => new PbList<Session>();
  static Session getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySession();
    return _defaultInstance;
  }
  static Session _defaultInstance;
  static void $checkItem(Session v) {
    if (v is !Session) checkItemFailed(v, 'Session');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlySession extends Session with ReadonlyMessageMixin {}

class GetSessionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GetSessionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  GetSessionRequest() : super();
  GetSessionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GetSessionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GetSessionRequest clone() => new GetSessionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GetSessionRequest create() => new GetSessionRequest();
  static PbList<GetSessionRequest> createRepeated() => new PbList<GetSessionRequest>();
  static GetSessionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGetSessionRequest();
    return _defaultInstance;
  }
  static GetSessionRequest _defaultInstance;
  static void $checkItem(GetSessionRequest v) {
    if (v is !GetSessionRequest) checkItemFailed(v, 'GetSessionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyGetSessionRequest extends GetSessionRequest with ReadonlyMessageMixin {}

class DeleteSessionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DeleteSessionRequest')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  DeleteSessionRequest() : super();
  DeleteSessionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DeleteSessionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DeleteSessionRequest clone() => new DeleteSessionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DeleteSessionRequest create() => new DeleteSessionRequest();
  static PbList<DeleteSessionRequest> createRepeated() => new PbList<DeleteSessionRequest>();
  static DeleteSessionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDeleteSessionRequest();
    return _defaultInstance;
  }
  static DeleteSessionRequest _defaultInstance;
  static void $checkItem(DeleteSessionRequest v) {
    if (v is !DeleteSessionRequest) checkItemFailed(v, 'DeleteSessionRequest');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);
}

class _ReadonlyDeleteSessionRequest extends DeleteSessionRequest with ReadonlyMessageMixin {}

class ExecuteSqlRequest_ParamTypesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ExecuteSqlRequest_ParamTypesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<Type>*/(2, 'value', PbFieldType.OM, Type.getDefault, Type.create)
    ..hasRequiredFields = false
  ;

  ExecuteSqlRequest_ParamTypesEntry() : super();
  ExecuteSqlRequest_ParamTypesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ExecuteSqlRequest_ParamTypesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ExecuteSqlRequest_ParamTypesEntry clone() => new ExecuteSqlRequest_ParamTypesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ExecuteSqlRequest_ParamTypesEntry create() => new ExecuteSqlRequest_ParamTypesEntry();
  static PbList<ExecuteSqlRequest_ParamTypesEntry> createRepeated() => new PbList<ExecuteSqlRequest_ParamTypesEntry>();
  static ExecuteSqlRequest_ParamTypesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExecuteSqlRequest_ParamTypesEntry();
    return _defaultInstance;
  }
  static ExecuteSqlRequest_ParamTypesEntry _defaultInstance;
  static void $checkItem(ExecuteSqlRequest_ParamTypesEntry v) {
    if (v is !ExecuteSqlRequest_ParamTypesEntry) checkItemFailed(v, 'ExecuteSqlRequest_ParamTypesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  Type get value => $_get(1, 2, null);
  void set value(Type v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyExecuteSqlRequest_ParamTypesEntry extends ExecuteSqlRequest_ParamTypesEntry with ReadonlyMessageMixin {}

class ExecuteSqlRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ExecuteSqlRequest')
    ..a/*<String>*/(1, 'session', PbFieldType.OS)
    ..a/*<TransactionSelector>*/(2, 'transaction', PbFieldType.OM, TransactionSelector.getDefault, TransactionSelector.create)
    ..a/*<String>*/(3, 'sql', PbFieldType.OS)
    ..a/*<google$protobuf.Struct>*/(4, 'params', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..pp/*<ExecuteSqlRequest_ParamTypesEntry>*/(5, 'paramTypes', PbFieldType.PM, ExecuteSqlRequest_ParamTypesEntry.$checkItem, ExecuteSqlRequest_ParamTypesEntry.create)
    ..a/*<List<int>>*/(6, 'resumeToken', PbFieldType.OY)
    ..e/*<ExecuteSqlRequest_QueryMode>*/(7, 'queryMode', PbFieldType.OE, ExecuteSqlRequest_QueryMode.NORMAL, ExecuteSqlRequest_QueryMode.valueOf)
    ..hasRequiredFields = false
  ;

  ExecuteSqlRequest() : super();
  ExecuteSqlRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ExecuteSqlRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ExecuteSqlRequest clone() => new ExecuteSqlRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ExecuteSqlRequest create() => new ExecuteSqlRequest();
  static PbList<ExecuteSqlRequest> createRepeated() => new PbList<ExecuteSqlRequest>();
  static ExecuteSqlRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExecuteSqlRequest();
    return _defaultInstance;
  }
  static ExecuteSqlRequest _defaultInstance;
  static void $checkItem(ExecuteSqlRequest v) {
    if (v is !ExecuteSqlRequest) checkItemFailed(v, 'ExecuteSqlRequest');
  }

  String get session => $_get(0, 1, '');
  void set session(String v) { $_setString(0, 1, v); }
  bool hasSession() => $_has(0, 1);
  void clearSession() => clearField(1);

  TransactionSelector get transaction => $_get(1, 2, null);
  void set transaction(TransactionSelector v) { setField(2, v); }
  bool hasTransaction() => $_has(1, 2);
  void clearTransaction() => clearField(2);

  String get sql => $_get(2, 3, '');
  void set sql(String v) { $_setString(2, 3, v); }
  bool hasSql() => $_has(2, 3);
  void clearSql() => clearField(3);

  google$protobuf.Struct get params => $_get(3, 4, null);
  void set params(google$protobuf.Struct v) { setField(4, v); }
  bool hasParams() => $_has(3, 4);
  void clearParams() => clearField(4);

  List<ExecuteSqlRequest_ParamTypesEntry> get paramTypes => $_get(4, 5, null);

  List<int> get resumeToken => $_get(5, 6, null);
  void set resumeToken(List<int> v) { $_setBytes(5, 6, v); }
  bool hasResumeToken() => $_has(5, 6);
  void clearResumeToken() => clearField(6);

  ExecuteSqlRequest_QueryMode get queryMode => $_get(6, 7, null);
  void set queryMode(ExecuteSqlRequest_QueryMode v) { setField(7, v); }
  bool hasQueryMode() => $_has(6, 7);
  void clearQueryMode() => clearField(7);
}

class _ReadonlyExecuteSqlRequest extends ExecuteSqlRequest with ReadonlyMessageMixin {}

class ReadRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRequest')
    ..a/*<String>*/(1, 'session', PbFieldType.OS)
    ..a/*<TransactionSelector>*/(2, 'transaction', PbFieldType.OM, TransactionSelector.getDefault, TransactionSelector.create)
    ..a/*<String>*/(3, 'table', PbFieldType.OS)
    ..a/*<String>*/(4, 'index', PbFieldType.OS)
    ..p/*<String>*/(5, 'columns', PbFieldType.PS)
    ..a/*<KeySet>*/(6, 'keySet', PbFieldType.OM, KeySet.getDefault, KeySet.create)
    ..a/*<Int64>*/(8, 'limit', PbFieldType.O6, Int64.ZERO)
    ..a/*<List<int>>*/(9, 'resumeToken', PbFieldType.OY)
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

  String get session => $_get(0, 1, '');
  void set session(String v) { $_setString(0, 1, v); }
  bool hasSession() => $_has(0, 1);
  void clearSession() => clearField(1);

  TransactionSelector get transaction => $_get(1, 2, null);
  void set transaction(TransactionSelector v) { setField(2, v); }
  bool hasTransaction() => $_has(1, 2);
  void clearTransaction() => clearField(2);

  String get table => $_get(2, 3, '');
  void set table(String v) { $_setString(2, 3, v); }
  bool hasTable() => $_has(2, 3);
  void clearTable() => clearField(3);

  String get index => $_get(3, 4, '');
  void set index(String v) { $_setString(3, 4, v); }
  bool hasIndex() => $_has(3, 4);
  void clearIndex() => clearField(4);

  List<String> get columns => $_get(4, 5, null);

  KeySet get keySet => $_get(5, 6, null);
  void set keySet(KeySet v) { setField(6, v); }
  bool hasKeySet() => $_has(5, 6);
  void clearKeySet() => clearField(6);

  Int64 get limit => $_get(6, 8, null);
  void set limit(Int64 v) { $_setInt64(6, 8, v); }
  bool hasLimit() => $_has(6, 8);
  void clearLimit() => clearField(8);

  List<int> get resumeToken => $_get(7, 9, null);
  void set resumeToken(List<int> v) { $_setBytes(7, 9, v); }
  bool hasResumeToken() => $_has(7, 9);
  void clearResumeToken() => clearField(9);
}

class _ReadonlyReadRequest extends ReadRequest with ReadonlyMessageMixin {}

class BeginTransactionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionRequest')
    ..a/*<String>*/(1, 'session', PbFieldType.OS)
    ..a/*<TransactionOptions>*/(2, 'options', PbFieldType.OM, TransactionOptions.getDefault, TransactionOptions.create)
    ..hasRequiredFields = false
  ;

  BeginTransactionRequest() : super();
  BeginTransactionRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BeginTransactionRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BeginTransactionRequest clone() => new BeginTransactionRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BeginTransactionRequest create() => new BeginTransactionRequest();
  static PbList<BeginTransactionRequest> createRepeated() => new PbList<BeginTransactionRequest>();
  static BeginTransactionRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBeginTransactionRequest();
    return _defaultInstance;
  }
  static BeginTransactionRequest _defaultInstance;
  static void $checkItem(BeginTransactionRequest v) {
    if (v is !BeginTransactionRequest) checkItemFailed(v, 'BeginTransactionRequest');
  }

  String get session => $_get(0, 1, '');
  void set session(String v) { $_setString(0, 1, v); }
  bool hasSession() => $_has(0, 1);
  void clearSession() => clearField(1);

  TransactionOptions get options => $_get(1, 2, null);
  void set options(TransactionOptions v) { setField(2, v); }
  bool hasOptions() => $_has(1, 2);
  void clearOptions() => clearField(2);
}

class _ReadonlyBeginTransactionRequest extends BeginTransactionRequest with ReadonlyMessageMixin {}

class CommitRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitRequest')
    ..a/*<String>*/(1, 'session', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'transactionId', PbFieldType.OY)
    ..a/*<TransactionOptions>*/(3, 'singleUseTransaction', PbFieldType.OM, TransactionOptions.getDefault, TransactionOptions.create)
    ..pp/*<Mutation>*/(4, 'mutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..hasRequiredFields = false
  ;

  CommitRequest() : super();
  CommitRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitRequest clone() => new CommitRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CommitRequest create() => new CommitRequest();
  static PbList<CommitRequest> createRepeated() => new PbList<CommitRequest>();
  static CommitRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCommitRequest();
    return _defaultInstance;
  }
  static CommitRequest _defaultInstance;
  static void $checkItem(CommitRequest v) {
    if (v is !CommitRequest) checkItemFailed(v, 'CommitRequest');
  }

  String get session => $_get(0, 1, '');
  void set session(String v) { $_setString(0, 1, v); }
  bool hasSession() => $_has(0, 1);
  void clearSession() => clearField(1);

  List<int> get transactionId => $_get(1, 2, null);
  void set transactionId(List<int> v) { $_setBytes(1, 2, v); }
  bool hasTransactionId() => $_has(1, 2);
  void clearTransactionId() => clearField(2);

  TransactionOptions get singleUseTransaction => $_get(2, 3, null);
  void set singleUseTransaction(TransactionOptions v) { setField(3, v); }
  bool hasSingleUseTransaction() => $_has(2, 3);
  void clearSingleUseTransaction() => clearField(3);

  List<Mutation> get mutations => $_get(3, 4, null);
}

class _ReadonlyCommitRequest extends CommitRequest with ReadonlyMessageMixin {}

class CommitResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitResponse')
    ..a/*<google$protobuf.Timestamp>*/(1, 'commitTimestamp', PbFieldType.OM, google$protobuf.Timestamp.getDefault, google$protobuf.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CommitResponse() : super();
  CommitResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CommitResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CommitResponse clone() => new CommitResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CommitResponse create() => new CommitResponse();
  static PbList<CommitResponse> createRepeated() => new PbList<CommitResponse>();
  static CommitResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCommitResponse();
    return _defaultInstance;
  }
  static CommitResponse _defaultInstance;
  static void $checkItem(CommitResponse v) {
    if (v is !CommitResponse) checkItemFailed(v, 'CommitResponse');
  }

  google$protobuf.Timestamp get commitTimestamp => $_get(0, 1, null);
  void set commitTimestamp(google$protobuf.Timestamp v) { setField(1, v); }
  bool hasCommitTimestamp() => $_has(0, 1);
  void clearCommitTimestamp() => clearField(1);
}

class _ReadonlyCommitResponse extends CommitResponse with ReadonlyMessageMixin {}

class RollbackRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackRequest')
    ..a/*<String>*/(1, 'session', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'transactionId', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  RollbackRequest() : super();
  RollbackRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RollbackRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RollbackRequest clone() => new RollbackRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RollbackRequest create() => new RollbackRequest();
  static PbList<RollbackRequest> createRepeated() => new PbList<RollbackRequest>();
  static RollbackRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollbackRequest();
    return _defaultInstance;
  }
  static RollbackRequest _defaultInstance;
  static void $checkItem(RollbackRequest v) {
    if (v is !RollbackRequest) checkItemFailed(v, 'RollbackRequest');
  }

  String get session => $_get(0, 1, '');
  void set session(String v) { $_setString(0, 1, v); }
  bool hasSession() => $_has(0, 1);
  void clearSession() => clearField(1);

  List<int> get transactionId => $_get(1, 2, null);
  void set transactionId(List<int> v) { $_setBytes(1, 2, v); }
  bool hasTransactionId() => $_has(1, 2);
  void clearTransactionId() => clearField(2);
}

class _ReadonlyRollbackRequest extends RollbackRequest with ReadonlyMessageMixin {}

class SpannerApi {
  RpcClient _client;
  SpannerApi(this._client);

  Future<Session> createSession(ClientContext ctx, CreateSessionRequest request) {
    var emptyResponse = new Session();
    return _client.invoke(ctx, 'Spanner', 'CreateSession', request, emptyResponse);
  }
  Future<Session> getSession(ClientContext ctx, GetSessionRequest request) {
    var emptyResponse = new Session();
    return _client.invoke(ctx, 'Spanner', 'GetSession', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteSession(ClientContext ctx, DeleteSessionRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Spanner', 'DeleteSession', request, emptyResponse);
  }
  Future<ResultSet> executeSql(ClientContext ctx, ExecuteSqlRequest request) {
    var emptyResponse = new ResultSet();
    return _client.invoke(ctx, 'Spanner', 'ExecuteSql', request, emptyResponse);
  }
  Future<PartialResultSet> executeStreamingSql(ClientContext ctx, ExecuteSqlRequest request) {
    var emptyResponse = new PartialResultSet();
    return _client.invoke(ctx, 'Spanner', 'ExecuteStreamingSql', request, emptyResponse);
  }
  Future<ResultSet> read(ClientContext ctx, ReadRequest request) {
    var emptyResponse = new ResultSet();
    return _client.invoke(ctx, 'Spanner', 'Read', request, emptyResponse);
  }
  Future<PartialResultSet> streamingRead(ClientContext ctx, ReadRequest request) {
    var emptyResponse = new PartialResultSet();
    return _client.invoke(ctx, 'Spanner', 'StreamingRead', request, emptyResponse);
  }
  Future<Transaction> beginTransaction(ClientContext ctx, BeginTransactionRequest request) {
    var emptyResponse = new Transaction();
    return _client.invoke(ctx, 'Spanner', 'BeginTransaction', request, emptyResponse);
  }
  Future<CommitResponse> commit(ClientContext ctx, CommitRequest request) {
    var emptyResponse = new CommitResponse();
    return _client.invoke(ctx, 'Spanner', 'Commit', request, emptyResponse);
  }
  Future<google$protobuf.Empty> rollback(ClientContext ctx, RollbackRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'Spanner', 'Rollback', request, emptyResponse);
  }
}

