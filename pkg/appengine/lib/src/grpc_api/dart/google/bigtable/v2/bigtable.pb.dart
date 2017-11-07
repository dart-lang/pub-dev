///
//  Generated code. Do not modify.
///
library google.bigtable.v2_bigtable;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

import 'data.pb.dart';
import '../../protobuf/wrappers.pb.dart' as google$protobuf;
import '../../rpc/status.pb.dart' as google$rpc;

class ReadRowsRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsRequest')
    ..a/*<String>*/(1, 'tableName', PbFieldType.OS)
    ..a/*<RowSet>*/(2, 'rows', PbFieldType.OM, RowSet.getDefault, RowSet.create)
    ..a/*<RowFilter>*/(3, 'filter', PbFieldType.OM, RowFilter.getDefault, RowFilter.create)
    ..a/*<Int64>*/(4, 'rowsLimit', PbFieldType.O6, Int64.ZERO)
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

  RowSet get rows => $_get(1, 2, null);
  void set rows(RowSet v) { setField(2, v); }
  bool hasRows() => $_has(1, 2);
  void clearRows() => clearField(2);

  RowFilter get filter => $_get(2, 3, null);
  void set filter(RowFilter v) { setField(3, v); }
  bool hasFilter() => $_has(2, 3);
  void clearFilter() => clearField(3);

  Int64 get rowsLimit => $_get(3, 4, null);
  void set rowsLimit(Int64 v) { $_setInt64(3, 4, v); }
  bool hasRowsLimit() => $_has(3, 4);
  void clearRowsLimit() => clearField(4);
}

class _ReadonlyReadRowsRequest extends ReadRowsRequest with ReadonlyMessageMixin {}

class ReadRowsResponse_CellChunk extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsResponse_CellChunk')
    ..a/*<List<int>>*/(1, 'rowKey', PbFieldType.OY)
    ..a/*<google$protobuf.StringValue>*/(2, 'familyName', PbFieldType.OM, google$protobuf.StringValue.getDefault, google$protobuf.StringValue.create)
    ..a/*<google$protobuf.BytesValue>*/(3, 'qualifier', PbFieldType.OM, google$protobuf.BytesValue.getDefault, google$protobuf.BytesValue.create)
    ..a/*<Int64>*/(4, 'timestampMicros', PbFieldType.O6, Int64.ZERO)
    ..p/*<String>*/(5, 'labels', PbFieldType.PS)
    ..a/*<List<int>>*/(6, 'value', PbFieldType.OY)
    ..a/*<int>*/(7, 'valueSize', PbFieldType.O3)
    ..a/*<bool>*/(8, 'resetRow', PbFieldType.OB)
    ..a/*<bool>*/(9, 'commitRow', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  ReadRowsResponse_CellChunk() : super();
  ReadRowsResponse_CellChunk.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadRowsResponse_CellChunk.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadRowsResponse_CellChunk clone() => new ReadRowsResponse_CellChunk()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadRowsResponse_CellChunk create() => new ReadRowsResponse_CellChunk();
  static PbList<ReadRowsResponse_CellChunk> createRepeated() => new PbList<ReadRowsResponse_CellChunk>();
  static ReadRowsResponse_CellChunk getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadRowsResponse_CellChunk();
    return _defaultInstance;
  }
  static ReadRowsResponse_CellChunk _defaultInstance;
  static void $checkItem(ReadRowsResponse_CellChunk v) {
    if (v is !ReadRowsResponse_CellChunk) checkItemFailed(v, 'ReadRowsResponse_CellChunk');
  }

  List<int> get rowKey => $_get(0, 1, null);
  void set rowKey(List<int> v) { $_setBytes(0, 1, v); }
  bool hasRowKey() => $_has(0, 1);
  void clearRowKey() => clearField(1);

  google$protobuf.StringValue get familyName => $_get(1, 2, null);
  void set familyName(google$protobuf.StringValue v) { setField(2, v); }
  bool hasFamilyName() => $_has(1, 2);
  void clearFamilyName() => clearField(2);

  google$protobuf.BytesValue get qualifier => $_get(2, 3, null);
  void set qualifier(google$protobuf.BytesValue v) { setField(3, v); }
  bool hasQualifier() => $_has(2, 3);
  void clearQualifier() => clearField(3);

  Int64 get timestampMicros => $_get(3, 4, null);
  void set timestampMicros(Int64 v) { $_setInt64(3, 4, v); }
  bool hasTimestampMicros() => $_has(3, 4);
  void clearTimestampMicros() => clearField(4);

  List<String> get labels => $_get(4, 5, null);

  List<int> get value => $_get(5, 6, null);
  void set value(List<int> v) { $_setBytes(5, 6, v); }
  bool hasValue() => $_has(5, 6);
  void clearValue() => clearField(6);

  int get valueSize => $_get(6, 7, 0);
  void set valueSize(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasValueSize() => $_has(6, 7);
  void clearValueSize() => clearField(7);

  bool get resetRow => $_get(7, 8, false);
  void set resetRow(bool v) { $_setBool(7, 8, v); }
  bool hasResetRow() => $_has(7, 8);
  void clearResetRow() => clearField(8);

  bool get commitRow => $_get(8, 9, false);
  void set commitRow(bool v) { $_setBool(8, 9, v); }
  bool hasCommitRow() => $_has(8, 9);
  void clearCommitRow() => clearField(9);
}

class _ReadonlyReadRowsResponse_CellChunk extends ReadRowsResponse_CellChunk with ReadonlyMessageMixin {}

class ReadRowsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadRowsResponse')
    ..pp/*<ReadRowsResponse_CellChunk>*/(1, 'chunks', PbFieldType.PM, ReadRowsResponse_CellChunk.$checkItem, ReadRowsResponse_CellChunk.create)
    ..a/*<List<int>>*/(2, 'lastScannedRowKey', PbFieldType.OY)
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

  List<ReadRowsResponse_CellChunk> get chunks => $_get(0, 1, null);

  List<int> get lastScannedRowKey => $_get(1, 2, null);
  void set lastScannedRowKey(List<int> v) { $_setBytes(1, 2, v); }
  bool hasLastScannedRowKey() => $_has(1, 2);
  void clearLastScannedRowKey() => clearField(2);
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

class MutateRowResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowResponse')
    ..hasRequiredFields = false
  ;

  MutateRowResponse() : super();
  MutateRowResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowResponse clone() => new MutateRowResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowResponse create() => new MutateRowResponse();
  static PbList<MutateRowResponse> createRepeated() => new PbList<MutateRowResponse>();
  static MutateRowResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowResponse();
    return _defaultInstance;
  }
  static MutateRowResponse _defaultInstance;
  static void $checkItem(MutateRowResponse v) {
    if (v is !MutateRowResponse) checkItemFailed(v, 'MutateRowResponse');
  }
}

class _ReadonlyMutateRowResponse extends MutateRowResponse with ReadonlyMessageMixin {}

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

class MutateRowsResponse_Entry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowsResponse_Entry')
    ..a/*<Int64>*/(1, 'index', PbFieldType.O6, Int64.ZERO)
    ..a/*<google$rpc.Status>*/(2, 'status', PbFieldType.OM, google$rpc.Status.getDefault, google$rpc.Status.create)
    ..hasRequiredFields = false
  ;

  MutateRowsResponse_Entry() : super();
  MutateRowsResponse_Entry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MutateRowsResponse_Entry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MutateRowsResponse_Entry clone() => new MutateRowsResponse_Entry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static MutateRowsResponse_Entry create() => new MutateRowsResponse_Entry();
  static PbList<MutateRowsResponse_Entry> createRepeated() => new PbList<MutateRowsResponse_Entry>();
  static MutateRowsResponse_Entry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyMutateRowsResponse_Entry();
    return _defaultInstance;
  }
  static MutateRowsResponse_Entry _defaultInstance;
  static void $checkItem(MutateRowsResponse_Entry v) {
    if (v is !MutateRowsResponse_Entry) checkItemFailed(v, 'MutateRowsResponse_Entry');
  }

  Int64 get index => $_get(0, 1, null);
  void set index(Int64 v) { $_setInt64(0, 1, v); }
  bool hasIndex() => $_has(0, 1);
  void clearIndex() => clearField(1);

  google$rpc.Status get status => $_get(1, 2, null);
  void set status(google$rpc.Status v) { setField(2, v); }
  bool hasStatus() => $_has(1, 2);
  void clearStatus() => clearField(2);
}

class _ReadonlyMutateRowsResponse_Entry extends MutateRowsResponse_Entry with ReadonlyMessageMixin {}

class MutateRowsResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('MutateRowsResponse')
    ..pp/*<MutateRowsResponse_Entry>*/(1, 'entries', PbFieldType.PM, MutateRowsResponse_Entry.$checkItem, MutateRowsResponse_Entry.create)
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

  List<MutateRowsResponse_Entry> get entries => $_get(0, 1, null);
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

class ReadModifyWriteRowResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadModifyWriteRowResponse')
    ..a/*<Row>*/(1, 'row', PbFieldType.OM, Row.getDefault, Row.create)
    ..hasRequiredFields = false
  ;

  ReadModifyWriteRowResponse() : super();
  ReadModifyWriteRowResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadModifyWriteRowResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadModifyWriteRowResponse clone() => new ReadModifyWriteRowResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadModifyWriteRowResponse create() => new ReadModifyWriteRowResponse();
  static PbList<ReadModifyWriteRowResponse> createRepeated() => new PbList<ReadModifyWriteRowResponse>();
  static ReadModifyWriteRowResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadModifyWriteRowResponse();
    return _defaultInstance;
  }
  static ReadModifyWriteRowResponse _defaultInstance;
  static void $checkItem(ReadModifyWriteRowResponse v) {
    if (v is !ReadModifyWriteRowResponse) checkItemFailed(v, 'ReadModifyWriteRowResponse');
  }

  Row get row => $_get(0, 1, null);
  void set row(Row v) { setField(1, v); }
  bool hasRow() => $_has(0, 1);
  void clearRow() => clearField(1);
}

class _ReadonlyReadModifyWriteRowResponse extends ReadModifyWriteRowResponse with ReadonlyMessageMixin {}

class BigtableApi {
  RpcClient _client;
  BigtableApi(this._client);

  Future<ReadRowsResponse> readRows(ClientContext ctx, ReadRowsRequest request) {
    var emptyResponse = new ReadRowsResponse();
    return _client.invoke(ctx, 'Bigtable', 'ReadRows', request, emptyResponse);
  }
  Future<SampleRowKeysResponse> sampleRowKeys(ClientContext ctx, SampleRowKeysRequest request) {
    var emptyResponse = new SampleRowKeysResponse();
    return _client.invoke(ctx, 'Bigtable', 'SampleRowKeys', request, emptyResponse);
  }
  Future<MutateRowResponse> mutateRow(ClientContext ctx, MutateRowRequest request) {
    var emptyResponse = new MutateRowResponse();
    return _client.invoke(ctx, 'Bigtable', 'MutateRow', request, emptyResponse);
  }
  Future<MutateRowsResponse> mutateRows(ClientContext ctx, MutateRowsRequest request) {
    var emptyResponse = new MutateRowsResponse();
    return _client.invoke(ctx, 'Bigtable', 'MutateRows', request, emptyResponse);
  }
  Future<CheckAndMutateRowResponse> checkAndMutateRow(ClientContext ctx, CheckAndMutateRowRequest request) {
    var emptyResponse = new CheckAndMutateRowResponse();
    return _client.invoke(ctx, 'Bigtable', 'CheckAndMutateRow', request, emptyResponse);
  }
  Future<ReadModifyWriteRowResponse> readModifyWriteRow(ClientContext ctx, ReadModifyWriteRowRequest request) {
    var emptyResponse = new ReadModifyWriteRowResponse();
    return _client.invoke(ctx, 'Bigtable', 'ReadModifyWriteRow', request, emptyResponse);
  }
}

