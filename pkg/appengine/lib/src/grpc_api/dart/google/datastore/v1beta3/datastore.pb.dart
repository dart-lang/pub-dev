///
//  Generated code. Do not modify.
///
library google.datastore.v1beta3_datastore;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'entity.pb.dart';
import 'query.pb.dart';

import 'datastore.pbenum.dart';

export 'datastore.pbenum.dart';

class LookupRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LookupRequest')
    ..a/*<ReadOptions>*/(1, 'readOptions', PbFieldType.OM, ReadOptions.getDefault, ReadOptions.create)
    ..pp/*<Key>*/(3, 'keys', PbFieldType.PM, Key.$checkItem, Key.create)
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LookupRequest() : super();
  LookupRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LookupRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LookupRequest clone() => new LookupRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LookupRequest create() => new LookupRequest();
  static PbList<LookupRequest> createRepeated() => new PbList<LookupRequest>();
  static LookupRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLookupRequest();
    return _defaultInstance;
  }
  static LookupRequest _defaultInstance;
  static void $checkItem(LookupRequest v) {
    if (v is !LookupRequest) checkItemFailed(v, 'LookupRequest');
  }

  ReadOptions get readOptions => $_get(0, 1, null);
  void set readOptions(ReadOptions v) { setField(1, v); }
  bool hasReadOptions() => $_has(0, 1);
  void clearReadOptions() => clearField(1);

  List<Key> get keys => $_get(1, 3, null);

  String get projectId => $_get(2, 8, '');
  void set projectId(String v) { $_setString(2, 8, v); }
  bool hasProjectId() => $_has(2, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyLookupRequest extends LookupRequest with ReadonlyMessageMixin {}

class LookupResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LookupResponse')
    ..pp/*<EntityResult>*/(1, 'found', PbFieldType.PM, EntityResult.$checkItem, EntityResult.create)
    ..pp/*<EntityResult>*/(2, 'missing', PbFieldType.PM, EntityResult.$checkItem, EntityResult.create)
    ..pp/*<Key>*/(3, 'deferred', PbFieldType.PM, Key.$checkItem, Key.create)
    ..hasRequiredFields = false
  ;

  LookupResponse() : super();
  LookupResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LookupResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LookupResponse clone() => new LookupResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LookupResponse create() => new LookupResponse();
  static PbList<LookupResponse> createRepeated() => new PbList<LookupResponse>();
  static LookupResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLookupResponse();
    return _defaultInstance;
  }
  static LookupResponse _defaultInstance;
  static void $checkItem(LookupResponse v) {
    if (v is !LookupResponse) checkItemFailed(v, 'LookupResponse');
  }

  List<EntityResult> get found => $_get(0, 1, null);

  List<EntityResult> get missing => $_get(1, 2, null);

  List<Key> get deferred => $_get(2, 3, null);
}

class _ReadonlyLookupResponse extends LookupResponse with ReadonlyMessageMixin {}

class RunQueryRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RunQueryRequest')
    ..a/*<ReadOptions>*/(1, 'readOptions', PbFieldType.OM, ReadOptions.getDefault, ReadOptions.create)
    ..a/*<PartitionId>*/(2, 'partitionId', PbFieldType.OM, PartitionId.getDefault, PartitionId.create)
    ..a/*<Query>*/(3, 'query', PbFieldType.OM, Query.getDefault, Query.create)
    ..a/*<GqlQuery>*/(7, 'gqlQuery', PbFieldType.OM, GqlQuery.getDefault, GqlQuery.create)
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  RunQueryRequest() : super();
  RunQueryRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RunQueryRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RunQueryRequest clone() => new RunQueryRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RunQueryRequest create() => new RunQueryRequest();
  static PbList<RunQueryRequest> createRepeated() => new PbList<RunQueryRequest>();
  static RunQueryRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRunQueryRequest();
    return _defaultInstance;
  }
  static RunQueryRequest _defaultInstance;
  static void $checkItem(RunQueryRequest v) {
    if (v is !RunQueryRequest) checkItemFailed(v, 'RunQueryRequest');
  }

  ReadOptions get readOptions => $_get(0, 1, null);
  void set readOptions(ReadOptions v) { setField(1, v); }
  bool hasReadOptions() => $_has(0, 1);
  void clearReadOptions() => clearField(1);

  PartitionId get partitionId => $_get(1, 2, null);
  void set partitionId(PartitionId v) { setField(2, v); }
  bool hasPartitionId() => $_has(1, 2);
  void clearPartitionId() => clearField(2);

  Query get query => $_get(2, 3, null);
  void set query(Query v) { setField(3, v); }
  bool hasQuery() => $_has(2, 3);
  void clearQuery() => clearField(3);

  GqlQuery get gqlQuery => $_get(3, 7, null);
  void set gqlQuery(GqlQuery v) { setField(7, v); }
  bool hasGqlQuery() => $_has(3, 7);
  void clearGqlQuery() => clearField(7);

  String get projectId => $_get(4, 8, '');
  void set projectId(String v) { $_setString(4, 8, v); }
  bool hasProjectId() => $_has(4, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyRunQueryRequest extends RunQueryRequest with ReadonlyMessageMixin {}

class RunQueryResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RunQueryResponse')
    ..a/*<QueryResultBatch>*/(1, 'batch', PbFieldType.OM, QueryResultBatch.getDefault, QueryResultBatch.create)
    ..a/*<Query>*/(2, 'query', PbFieldType.OM, Query.getDefault, Query.create)
    ..hasRequiredFields = false
  ;

  RunQueryResponse() : super();
  RunQueryResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RunQueryResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RunQueryResponse clone() => new RunQueryResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RunQueryResponse create() => new RunQueryResponse();
  static PbList<RunQueryResponse> createRepeated() => new PbList<RunQueryResponse>();
  static RunQueryResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRunQueryResponse();
    return _defaultInstance;
  }
  static RunQueryResponse _defaultInstance;
  static void $checkItem(RunQueryResponse v) {
    if (v is !RunQueryResponse) checkItemFailed(v, 'RunQueryResponse');
  }

  QueryResultBatch get batch => $_get(0, 1, null);
  void set batch(QueryResultBatch v) { setField(1, v); }
  bool hasBatch() => $_has(0, 1);
  void clearBatch() => clearField(1);

  Query get query => $_get(1, 2, null);
  void set query(Query v) { setField(2, v); }
  bool hasQuery() => $_has(1, 2);
  void clearQuery() => clearField(2);
}

class _ReadonlyRunQueryResponse extends RunQueryResponse with ReadonlyMessageMixin {}

class BeginTransactionRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionRequest')
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
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

  String get projectId => $_get(0, 8, '');
  void set projectId(String v) { $_setString(0, 8, v); }
  bool hasProjectId() => $_has(0, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyBeginTransactionRequest extends BeginTransactionRequest with ReadonlyMessageMixin {}

class BeginTransactionResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BeginTransactionResponse')
    ..a/*<List<int>>*/(1, 'transaction', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  BeginTransactionResponse() : super();
  BeginTransactionResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BeginTransactionResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BeginTransactionResponse clone() => new BeginTransactionResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BeginTransactionResponse create() => new BeginTransactionResponse();
  static PbList<BeginTransactionResponse> createRepeated() => new PbList<BeginTransactionResponse>();
  static BeginTransactionResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBeginTransactionResponse();
    return _defaultInstance;
  }
  static BeginTransactionResponse _defaultInstance;
  static void $checkItem(BeginTransactionResponse v) {
    if (v is !BeginTransactionResponse) checkItemFailed(v, 'BeginTransactionResponse');
  }

  List<int> get transaction => $_get(0, 1, null);
  void set transaction(List<int> v) { $_setBytes(0, 1, v); }
  bool hasTransaction() => $_has(0, 1);
  void clearTransaction() => clearField(1);
}

class _ReadonlyBeginTransactionResponse extends BeginTransactionResponse with ReadonlyMessageMixin {}

class RollbackRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackRequest')
    ..a/*<List<int>>*/(1, 'transaction', PbFieldType.OY)
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
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

  List<int> get transaction => $_get(0, 1, null);
  void set transaction(List<int> v) { $_setBytes(0, 1, v); }
  bool hasTransaction() => $_has(0, 1);
  void clearTransaction() => clearField(1);

  String get projectId => $_get(1, 8, '');
  void set projectId(String v) { $_setString(1, 8, v); }
  bool hasProjectId() => $_has(1, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyRollbackRequest extends RollbackRequest with ReadonlyMessageMixin {}

class RollbackResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('RollbackResponse')
    ..hasRequiredFields = false
  ;

  RollbackResponse() : super();
  RollbackResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RollbackResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RollbackResponse clone() => new RollbackResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static RollbackResponse create() => new RollbackResponse();
  static PbList<RollbackResponse> createRepeated() => new PbList<RollbackResponse>();
  static RollbackResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRollbackResponse();
    return _defaultInstance;
  }
  static RollbackResponse _defaultInstance;
  static void $checkItem(RollbackResponse v) {
    if (v is !RollbackResponse) checkItemFailed(v, 'RollbackResponse');
  }
}

class _ReadonlyRollbackResponse extends RollbackResponse with ReadonlyMessageMixin {}

class CommitRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitRequest')
    ..a/*<List<int>>*/(1, 'transaction', PbFieldType.OY)
    ..e/*<CommitRequest_Mode>*/(5, 'mode', PbFieldType.OE, CommitRequest_Mode.MODE_UNSPECIFIED, CommitRequest_Mode.valueOf)
    ..pp/*<Mutation>*/(6, 'mutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
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

  List<int> get transaction => $_get(0, 1, null);
  void set transaction(List<int> v) { $_setBytes(0, 1, v); }
  bool hasTransaction() => $_has(0, 1);
  void clearTransaction() => clearField(1);

  CommitRequest_Mode get mode => $_get(1, 5, null);
  void set mode(CommitRequest_Mode v) { setField(5, v); }
  bool hasMode() => $_has(1, 5);
  void clearMode() => clearField(5);

  List<Mutation> get mutations => $_get(2, 6, null);

  String get projectId => $_get(3, 8, '');
  void set projectId(String v) { $_setString(3, 8, v); }
  bool hasProjectId() => $_has(3, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyCommitRequest extends CommitRequest with ReadonlyMessageMixin {}

class CommitResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CommitResponse')
    ..pp/*<MutationResult>*/(3, 'mutationResults', PbFieldType.PM, MutationResult.$checkItem, MutationResult.create)
    ..a/*<int>*/(4, 'indexUpdates', PbFieldType.O3)
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

  List<MutationResult> get mutationResults => $_get(0, 3, null);

  int get indexUpdates => $_get(1, 4, 0);
  void set indexUpdates(int v) { $_setUnsignedInt32(1, 4, v); }
  bool hasIndexUpdates() => $_has(1, 4);
  void clearIndexUpdates() => clearField(4);
}

class _ReadonlyCommitResponse extends CommitResponse with ReadonlyMessageMixin {}

class AllocateIdsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsRequest')
    ..pp/*<Key>*/(1, 'keys', PbFieldType.PM, Key.$checkItem, Key.create)
    ..a/*<String>*/(8, 'projectId', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AllocateIdsRequest() : super();
  AllocateIdsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsRequest clone() => new AllocateIdsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AllocateIdsRequest create() => new AllocateIdsRequest();
  static PbList<AllocateIdsRequest> createRepeated() => new PbList<AllocateIdsRequest>();
  static AllocateIdsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAllocateIdsRequest();
    return _defaultInstance;
  }
  static AllocateIdsRequest _defaultInstance;
  static void $checkItem(AllocateIdsRequest v) {
    if (v is !AllocateIdsRequest) checkItemFailed(v, 'AllocateIdsRequest');
  }

  List<Key> get keys => $_get(0, 1, null);

  String get projectId => $_get(1, 8, '');
  void set projectId(String v) { $_setString(1, 8, v); }
  bool hasProjectId() => $_has(1, 8);
  void clearProjectId() => clearField(8);
}

class _ReadonlyAllocateIdsRequest extends AllocateIdsRequest with ReadonlyMessageMixin {}

class AllocateIdsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AllocateIdsResponse')
    ..pp/*<Key>*/(1, 'keys', PbFieldType.PM, Key.$checkItem, Key.create)
    ..hasRequiredFields = false
  ;

  AllocateIdsResponse() : super();
  AllocateIdsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AllocateIdsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AllocateIdsResponse clone() => new AllocateIdsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AllocateIdsResponse create() => new AllocateIdsResponse();
  static PbList<AllocateIdsResponse> createRepeated() => new PbList<AllocateIdsResponse>();
  static AllocateIdsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAllocateIdsResponse();
    return _defaultInstance;
  }
  static AllocateIdsResponse _defaultInstance;
  static void $checkItem(AllocateIdsResponse v) {
    if (v is !AllocateIdsResponse) checkItemFailed(v, 'AllocateIdsResponse');
  }

  List<Key> get keys => $_get(0, 1, null);
}

class _ReadonlyAllocateIdsResponse extends AllocateIdsResponse with ReadonlyMessageMixin {}

class Mutation extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Mutation')
    ..a/*<Entity>*/(4, 'insert', PbFieldType.OM, Entity.getDefault, Entity.create)
    ..a/*<Entity>*/(5, 'update', PbFieldType.OM, Entity.getDefault, Entity.create)
    ..a/*<Entity>*/(6, 'upsert', PbFieldType.OM, Entity.getDefault, Entity.create)
    ..a/*<Key>*/(7, 'delete', PbFieldType.OM, Key.getDefault, Key.create)
    ..a/*<Int64>*/(8, 'baseVersion', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Mutation() : super();
  Mutation.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Mutation.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Mutation clone() => new Mutation()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Mutation create() => new Mutation();
  static PbList<Mutation> createRepeated() => new PbList<Mutation>();
  static Mutation getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutation();
    return _defaultInstance;
  }
  static Mutation _defaultInstance;
  static void $checkItem(Mutation v) {
    if (v is !Mutation) checkItemFailed(v, 'Mutation');
  }

  Entity get insert => $_get(0, 4, null);
  void set insert(Entity v) { setField(4, v); }
  bool hasInsert() => $_has(0, 4);
  void clearInsert() => clearField(4);

  Entity get update => $_get(1, 5, null);
  void set update(Entity v) { setField(5, v); }
  bool hasUpdate() => $_has(1, 5);
  void clearUpdate() => clearField(5);

  Entity get upsert => $_get(2, 6, null);
  void set upsert(Entity v) { setField(6, v); }
  bool hasUpsert() => $_has(2, 6);
  void clearUpsert() => clearField(6);

  Key get delete => $_get(3, 7, null);
  void set delete(Key v) { setField(7, v); }
  bool hasDelete() => $_has(3, 7);
  void clearDelete() => clearField(7);

  Int64 get baseVersion => $_get(4, 8, null);
  void set baseVersion(Int64 v) { $_setInt64(4, 8, v); }
  bool hasBaseVersion() => $_has(4, 8);
  void clearBaseVersion() => clearField(8);
}

class _ReadonlyMutation extends Mutation with ReadonlyMessageMixin {}

class MutationResult extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutationResult')
    ..a/*<Key>*/(3, 'key', PbFieldType.OM, Key.getDefault, Key.create)
    ..a/*<Int64>*/(4, 'version', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(5, 'conflictDetected', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  MutationResult() : super();
  MutationResult.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutationResult.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutationResult clone() => new MutationResult()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutationResult create() => new MutationResult();
  static PbList<MutationResult> createRepeated() => new PbList<MutationResult>();
  static MutationResult getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutationResult();
    return _defaultInstance;
  }
  static MutationResult _defaultInstance;
  static void $checkItem(MutationResult v) {
    if (v is !MutationResult) checkItemFailed(v, 'MutationResult');
  }

  Key get key => $_get(0, 3, null);
  void set key(Key v) { setField(3, v); }
  bool hasKey() => $_has(0, 3);
  void clearKey() => clearField(3);

  Int64 get version => $_get(1, 4, null);
  void set version(Int64 v) { $_setInt64(1, 4, v); }
  bool hasVersion() => $_has(1, 4);
  void clearVersion() => clearField(4);

  bool get conflictDetected => $_get(2, 5, false);
  void set conflictDetected(bool v) { $_setBool(2, 5, v); }
  bool hasConflictDetected() => $_has(2, 5);
  void clearConflictDetected() => clearField(5);
}

class _ReadonlyMutationResult extends MutationResult with ReadonlyMessageMixin {}

class ReadOptions extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadOptions')
    ..e/*<ReadOptions_ReadConsistency>*/(1, 'readConsistency', PbFieldType.OE, ReadOptions_ReadConsistency.READ_CONSISTENCY_UNSPECIFIED, ReadOptions_ReadConsistency.valueOf)
    ..a/*<List<int>>*/(2, 'transaction', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  ReadOptions() : super();
  ReadOptions.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadOptions.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadOptions clone() => new ReadOptions()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadOptions create() => new ReadOptions();
  static PbList<ReadOptions> createRepeated() => new PbList<ReadOptions>();
  static ReadOptions getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadOptions();
    return _defaultInstance;
  }
  static ReadOptions _defaultInstance;
  static void $checkItem(ReadOptions v) {
    if (v is !ReadOptions) checkItemFailed(v, 'ReadOptions');
  }

  ReadOptions_ReadConsistency get readConsistency => $_get(0, 1, null);
  void set readConsistency(ReadOptions_ReadConsistency v) { setField(1, v); }
  bool hasReadConsistency() => $_has(0, 1);
  void clearReadConsistency() => clearField(1);

  List<int> get transaction => $_get(1, 2, null);
  void set transaction(List<int> v) { $_setBytes(1, 2, v); }
  bool hasTransaction() => $_has(1, 2);
  void clearTransaction() => clearField(2);
}

class _ReadonlyReadOptions extends ReadOptions with ReadonlyMessageMixin {}

class DatastoreApi {
  RpcClient _client;
  DatastoreApi(this._client);

  Future<LookupResponse> lookup(ClientContext ctx, LookupRequest request) {
    var emptyResponse = new LookupResponse();
    return _client.invoke(ctx, 'Datastore', 'Lookup', request, emptyResponse);
  }
  Future<RunQueryResponse> runQuery(ClientContext ctx, RunQueryRequest request) {
    var emptyResponse = new RunQueryResponse();
    return _client.invoke(ctx, 'Datastore', 'RunQuery', request, emptyResponse);
  }
  Future<BeginTransactionResponse> beginTransaction(ClientContext ctx, BeginTransactionRequest request) {
    var emptyResponse = new BeginTransactionResponse();
    return _client.invoke(ctx, 'Datastore', 'BeginTransaction', request, emptyResponse);
  }
  Future<CommitResponse> commit(ClientContext ctx, CommitRequest request) {
    var emptyResponse = new CommitResponse();
    return _client.invoke(ctx, 'Datastore', 'Commit', request, emptyResponse);
  }
  Future<RollbackResponse> rollback(ClientContext ctx, RollbackRequest request) {
    var emptyResponse = new RollbackResponse();
    return _client.invoke(ctx, 'Datastore', 'Rollback', request, emptyResponse);
  }
  Future<AllocateIdsResponse> allocateIds(ClientContext ctx, AllocateIdsRequest request) {
    var emptyResponse = new AllocateIdsResponse();
    return _client.invoke(ctx, 'Datastore', 'AllocateIds', request, emptyResponse);
  }
}

