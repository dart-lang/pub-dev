///
//  Generated code. Do not modify.
///
library google.bigtable.v1_bigtable_service_messages;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'bigtable_data.pb.dart';
import '../../rpc/status.pb.dart' as google$rpc;

class ReadRowsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKey', PbFieldType.OY)
    ..a/*<RowRange>*/(3, 'rowRange', PbFieldType.OM, RowRange.getDefault, RowRange.create)
    ..a/*<RowFilter>*/(5, 'filter', PbFieldType.OM, RowFilter.getDefault, RowFilter.create)
    ..a/*<bool>*/(6, 'allowRowInterleaving', PbFieldType.OB)
    ..a/*<Int64>*/(7, 'numRowsLimit', PbFieldType.O6, Int64.ZERO)
    ..a/*<RowSet>*/(8, 'rowSet', PbFieldType.OM, RowSet.getDefault, RowSet.create)
    ..hasRequiredFields = false
  ;

  ReadRowsRequest() : super();
  ReadRowsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadRowsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadRowsRequest clone() => new ReadRowsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadRowsRequest create() => new ReadRowsRequest();
  static PbList<ReadRowsRequest> createRepeated() => new PbList<ReadRowsRequest>();
  static ReadRowsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadRowsRequest();
    return _defaultInstance;
  }
  static ReadRowsRequest _defaultInstance;
  static void $checkItem(ReadRowsRequest v) {
    if (v is !ReadRowsRequest) checkItemFailed(v, 'ReadRowsRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<int> get rowKey => $_get(1, 2, null);
  void set rowKey(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKey() => $_has(1, 2);
  void clearRowKey() => clearField(2);

  RowRange get rowRange => $_get(2, 3, null);
  void set rowRange(RowRange v) { setField(3, v); }
  bool hasRowRange() => $_has(2, 3);
  void clearRowRange() => clearField(3);

  RowFilter get filter => $_get(3, 5, null);
  void set filter(RowFilter v) { setField(5, v); }
  bool hasFilter() => $_has(3, 5);
  void clearFilter() => clearField(5);

  bool get allowRowInterleaving => $_get(4, 6, false);
  void set allowRowInterleaving(bool v) { $_setBool(4, 6, v); }
  bool hasAllowRowInterleaving() => $_has(4, 6);
  void clearAllowRowInterleaving() => clearField(6);

  Int64 get numRowsLimit => $_get(5, 7, null);
  void set numRowsLimit(Int64 v) { $_setInt64(5, 7, v); }
  bool hasNumRowsLimit() => $_has(5, 7);
  void clearNumRowsLimit() => clearField(7);

  RowSet get rowSet => $_get(6, 8, null);
  void set rowSet(RowSet v) { setField(8, v); }
  bool hasRowSet() => $_has(6, 8);
  void clearRowSet() => clearField(8);
}

class _ReadonlyReadRowsRequest extends ReadRowsRequest with ReadonlyMessageMixin {}

class ReadRowsResponse_Chunk extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsResponse_Chunk')
    ..a/*<Family>*/(1, 'rowContents', PbFieldType.OM, Family.getDefault, Family.create)
    ..a/*<bool>*/(2, 'resetRow', PbFieldType.OB)
    ..a/*<bool>*/(3, 'commitRow', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  ReadRowsResponse_Chunk() : super();
  ReadRowsResponse_Chunk.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadRowsResponse_Chunk.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadRowsResponse_Chunk clone() => new ReadRowsResponse_Chunk()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadRowsResponse_Chunk create() => new ReadRowsResponse_Chunk();
  static PbList<ReadRowsResponse_Chunk> createRepeated() => new PbList<ReadRowsResponse_Chunk>();
  static ReadRowsResponse_Chunk getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadRowsResponse_Chunk();
    return _defaultInstance;
  }
  static ReadRowsResponse_Chunk _defaultInstance;
  static void $checkItem(ReadRowsResponse_Chunk v) {
    if (v is !ReadRowsResponse_Chunk) checkItemFailed(v, 'ReadRowsResponse_Chunk');
  }

  Family get rowContents => $_get(0, 1, null);
  void set rowContents(Family v) { setField(1, v); }
  bool hasRowContents() => $_has(0, 1);
  void clearRowContents() => clearField(1);

  bool get resetRow => $_get(1, 2, false);
  void set resetRow(bool v) { $_setBool(1, 2, v); }
  bool hasResetRow() => $_has(1, 2);
  void clearResetRow() => clearField(2);

  bool get commitRow => $_get(2, 3, false);
  void set commitRow(bool v) { $_setBool(2, 3, v); }
  bool hasCommitRow() => $_has(2, 3);
  void clearCommitRow() => clearField(3);
}

class _ReadonlyReadRowsResponse_Chunk extends ReadRowsResponse_Chunk with ReadonlyMessageMixin {}

class ReadRowsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsResponse')
    ..a/*<List<int>>*/(1, 'rowKey', PbFieldType.OY)
    ..pp/*<ReadRowsResponse_Chunk>*/(2, 'chunks', PbFieldType.PM, ReadRowsResponse_Chunk.$checkItem, ReadRowsResponse_Chunk.create)
    ..hasRequiredFields = false
  ;

  ReadRowsResponse() : super();
  ReadRowsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadRowsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadRowsResponse clone() => new ReadRowsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadRowsResponse create() => new ReadRowsResponse();
  static PbList<ReadRowsResponse> createRepeated() => new PbList<ReadRowsResponse>();
  static ReadRowsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadRowsResponse();
    return _defaultInstance;
  }
  static ReadRowsResponse _defaultInstance;
  static void $checkItem(ReadRowsResponse v) {
    if (v is !ReadRowsResponse) checkItemFailed(v, 'ReadRowsResponse');
  }

  List<int> get rowKey => $_get(0, 1, null);
  void set rowKey(List<int> v) { $_setBytes(0, 1, v); }
  bool hasRowKey() => $_has(0, 1);
  void clearRowKey() => clearField(1);

  List<ReadRowsResponse_Chunk> get chunks => $_get(1, 2, null);
}

class _ReadonlyReadRowsResponse extends ReadRowsResponse with ReadonlyMessageMixin {}

class SampleRowKeysRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SampleRowKeysRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  SampleRowKeysRequest() : super();
  SampleRowKeysRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SampleRowKeysRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SampleRowKeysRequest clone() => new SampleRowKeysRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SampleRowKeysRequest create() => new SampleRowKeysRequest();
  static PbList<SampleRowKeysRequest> createRepeated() => new PbList<SampleRowKeysRequest>();
  static SampleRowKeysRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySampleRowKeysRequest();
    return _defaultInstance;
  }
  static SampleRowKeysRequest _defaultInstance;
  static void $checkItem(SampleRowKeysRequest v) {
    if (v is !SampleRowKeysRequest) checkItemFailed(v, 'SampleRowKeysRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);
}

class _ReadonlySampleRowKeysRequest extends SampleRowKeysRequest with ReadonlyMessageMixin {}

class SampleRowKeysResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('SampleRowKeysResponse')
    ..a/*<List<int>>*/(1, 'rowKey', PbFieldType.OY)
    ..a/*<Int64>*/(2, 'offsetBytes', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  SampleRowKeysResponse() : super();
  SampleRowKeysResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  SampleRowKeysResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  SampleRowKeysResponse clone() => new SampleRowKeysResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static SampleRowKeysResponse create() => new SampleRowKeysResponse();
  static PbList<SampleRowKeysResponse> createRepeated() => new PbList<SampleRowKeysResponse>();
  static SampleRowKeysResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlySampleRowKeysResponse();
    return _defaultInstance;
  }
  static SampleRowKeysResponse _defaultInstance;
  static void $checkItem(SampleRowKeysResponse v) {
    if (v is !SampleRowKeysResponse) checkItemFailed(v, 'SampleRowKeysResponse');
  }

  List<int> get rowKey => $_get(0, 1, null);
  void set rowKey(List<int> v) { $_setBytes(0, 1, v); }
  bool hasRowKey() => $_has(0, 1);
  void clearRowKey() => clearField(1);

  Int64 get offsetBytes => $_get(1, 2, null);
  void set offsetBytes(Int64 v) { $_setInt64(1, 2, v); }
  bool hasOffsetBytes() => $_has(1, 2);
  void clearOffsetBytes() => clearField(2);
}

class _ReadonlySampleRowKeysResponse extends SampleRowKeysResponse with ReadonlyMessageMixin {}

class MutateRowRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKey', PbFieldType.OY)
    ..pp/*<Mutation>*/(3, 'mutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..hasRequiredFields = false
  ;

  MutateRowRequest() : super();
  MutateRowRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowRequest clone() => new MutateRowRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowRequest create() => new MutateRowRequest();
  static PbList<MutateRowRequest> createRepeated() => new PbList<MutateRowRequest>();
  static MutateRowRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowRequest();
    return _defaultInstance;
  }
  static MutateRowRequest _defaultInstance;
  static void $checkItem(MutateRowRequest v) {
    if (v is !MutateRowRequest) checkItemFailed(v, 'MutateRowRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<int> get rowKey => $_get(1, 2, null);
  void set rowKey(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKey() => $_has(1, 2);
  void clearRowKey() => clearField(2);

  List<Mutation> get mutations => $_get(2, 3, null);
}

class _ReadonlyMutateRowRequest extends MutateRowRequest with ReadonlyMessageMixin {}

class MutateRowsRequest_Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowsRequest_Entry')
    ..a/*<List<int>>*/(1, 'rowKey', PbFieldType.OY)
    ..pp/*<Mutation>*/(2, 'mutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..hasRequiredFields = false
  ;

  MutateRowsRequest_Entry() : super();
  MutateRowsRequest_Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowsRequest_Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowsRequest_Entry clone() => new MutateRowsRequest_Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowsRequest_Entry create() => new MutateRowsRequest_Entry();
  static PbList<MutateRowsRequest_Entry> createRepeated() => new PbList<MutateRowsRequest_Entry>();
  static MutateRowsRequest_Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowsRequest_Entry();
    return _defaultInstance;
  }
  static MutateRowsRequest_Entry _defaultInstance;
  static void $checkItem(MutateRowsRequest_Entry v) {
    if (v is !MutateRowsRequest_Entry) checkItemFailed(v, 'MutateRowsRequest_Entry');
  }

  List<int> get rowKey => $_get(0, 1, null);
  void set rowKey(List<int> v) { $_setBytes(0, 1, v); }
  bool hasRowKey() => $_has(0, 1);
  void clearRowKey() => clearField(1);

  List<Mutation> get mutations => $_get(1, 2, null);
}

class _ReadonlyMutateRowsRequest_Entry extends MutateRowsRequest_Entry with ReadonlyMessageMixin {}

class MutateRowsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowsRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..pp/*<MutateRowsRequest_Entry>*/(2, 'entries', PbFieldType.PM, MutateRowsRequest_Entry.$checkItem, MutateRowsRequest_Entry.create)
    ..hasRequiredFields = false
  ;

  MutateRowsRequest() : super();
  MutateRowsRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowsRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowsRequest clone() => new MutateRowsRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowsRequest create() => new MutateRowsRequest();
  static PbList<MutateRowsRequest> createRepeated() => new PbList<MutateRowsRequest>();
  static MutateRowsRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowsRequest();
    return _defaultInstance;
  }
  static MutateRowsRequest _defaultInstance;
  static void $checkItem(MutateRowsRequest v) {
    if (v is !MutateRowsRequest) checkItemFailed(v, 'MutateRowsRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<MutateRowsRequest_Entry> get entries => $_get(1, 2, null);
}

class _ReadonlyMutateRowsRequest extends MutateRowsRequest with ReadonlyMessageMixin {}

class MutateRowsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowsResponse')
    ..pp/*<google$rpc.Status>*/(1, 'statuses', PbFieldType.PM, google$rpc.Status.$checkItem, google$rpc.Status.create)
    ..hasRequiredFields = false
  ;

  MutateRowsResponse() : super();
  MutateRowsResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowsResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowsResponse clone() => new MutateRowsResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowsResponse create() => new MutateRowsResponse();
  static PbList<MutateRowsResponse> createRepeated() => new PbList<MutateRowsResponse>();
  static MutateRowsResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowsResponse();
    return _defaultInstance;
  }
  static MutateRowsResponse _defaultInstance;
  static void $checkItem(MutateRowsResponse v) {
    if (v is !MutateRowsResponse) checkItemFailed(v, 'MutateRowsResponse');
  }

  List<google$rpc.Status> get statuses => $_get(0, 1, null);
}

class _ReadonlyMutateRowsResponse extends MutateRowsResponse with ReadonlyMessageMixin {}

class CheckAndMutateRowRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckAndMutateRowRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKey', PbFieldType.OY)
    ..pp/*<Mutation>*/(4, 'trueMutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..pp/*<Mutation>*/(5, 'falseMutations', PbFieldType.PM, Mutation.$checkItem, Mutation.create)
    ..a/*<RowFilter>*/(6, 'predicateFilter', PbFieldType.OM, RowFilter.getDefault, RowFilter.create)
    ..hasRequiredFields = false
  ;

  CheckAndMutateRowRequest() : super();
  CheckAndMutateRowRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckAndMutateRowRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckAndMutateRowRequest clone() => new CheckAndMutateRowRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CheckAndMutateRowRequest create() => new CheckAndMutateRowRequest();
  static PbList<CheckAndMutateRowRequest> createRepeated() => new PbList<CheckAndMutateRowRequest>();
  static CheckAndMutateRowRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCheckAndMutateRowRequest();
    return _defaultInstance;
  }
  static CheckAndMutateRowRequest _defaultInstance;
  static void $checkItem(CheckAndMutateRowRequest v) {
    if (v is !CheckAndMutateRowRequest) checkItemFailed(v, 'CheckAndMutateRowRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<int> get rowKey => $_get(1, 2, null);
  void set rowKey(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKey() => $_has(1, 2);
  void clearRowKey() => clearField(2);

  List<Mutation> get trueMutations => $_get(2, 4, null);

  List<Mutation> get falseMutations => $_get(3, 5, null);

  RowFilter get predicateFilter => $_get(4, 6, null);
  void set predicateFilter(RowFilter v) { setField(6, v); }
  bool hasPredicateFilter() => $_has(4, 6);
  void clearPredicateFilter() => clearField(6);
}

class _ReadonlyCheckAndMutateRowRequest extends CheckAndMutateRowRequest with ReadonlyMessageMixin {}

class CheckAndMutateRowResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('CheckAndMutateRowResponse')
    ..a/*<bool>*/(1, 'predicateMatched', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  CheckAndMutateRowResponse() : super();
  CheckAndMutateRowResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CheckAndMutateRowResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CheckAndMutateRowResponse clone() => new CheckAndMutateRowResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static CheckAndMutateRowResponse create() => new CheckAndMutateRowResponse();
  static PbList<CheckAndMutateRowResponse> createRepeated() => new PbList<CheckAndMutateRowResponse>();
  static CheckAndMutateRowResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyCheckAndMutateRowResponse();
    return _defaultInstance;
  }
  static CheckAndMutateRowResponse _defaultInstance;
  static void $checkItem(CheckAndMutateRowResponse v) {
    if (v is !CheckAndMutateRowResponse) checkItemFailed(v, 'CheckAndMutateRowResponse');
  }

  bool get predicateMatched => $_get(0, 1, false);
  void set predicateMatched(bool v) { $_setBool(0, 1, v); }
  bool hasPredicateMatched() => $_has(0, 1);
  void clearPredicateMatched() => clearField(1);
}

class _ReadonlyCheckAndMutateRowResponse extends CheckAndMutateRowResponse with ReadonlyMessageMixin {}

class ReadModifyWriteRowRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadModifyWriteRowRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<List<int>>*/(2, 'rowKey', PbFieldType.OY)
    ..pp/*<ReadModifyWriteRule>*/(3, 'rules', PbFieldType.PM, ReadModifyWriteRule.$checkItem, ReadModifyWriteRule.create)
    ..hasRequiredFields = false
  ;

  ReadModifyWriteRowRequest() : super();
  ReadModifyWriteRowRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadModifyWriteRowRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadModifyWriteRowRequest clone() => new ReadModifyWriteRowRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadModifyWriteRowRequest create() => new ReadModifyWriteRowRequest();
  static PbList<ReadModifyWriteRowRequest> createRepeated() => new PbList<ReadModifyWriteRowRequest>();
  static ReadModifyWriteRowRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadModifyWriteRowRequest();
    return _defaultInstance;
  }
  static ReadModifyWriteRowRequest _defaultInstance;
  static void $checkItem(ReadModifyWriteRowRequest v) {
    if (v is !ReadModifyWriteRowRequest) checkItemFailed(v, 'ReadModifyWriteRowRequest');
  }

  String get tableName => $_get(0, 1, '');
  void set tableName(String v) { $_setString(0, 1, v); }
  bool hasTableName() => $_has(0, 1);
  void clearTableName() => clearField(1);

  List<int> get rowKey => $_get(1, 2, null);
  void set rowKey(List<int> v) { $_setBytes(1, 2, v); }
  bool hasRowKey() => $_has(1, 2);
  void clearRowKey() => clearField(2);

  List<ReadModifyWriteRule> get rules => $_get(2, 3, null);
}

class _ReadonlyReadModifyWriteRowRequest extends ReadModifyWriteRowRequest with ReadonlyMessageMixin {}

