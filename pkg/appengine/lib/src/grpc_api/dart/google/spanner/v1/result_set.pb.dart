///
//  Generated code. Do not modify.
///
library google.spanner.v1_result_set;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/struct.pb.dart' as google$protobuf;
import 'type.pb.dart';
import 'transaction.pb.dart';
import 'query_plan.pb.dart';

class ResultSet extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResultSet')
    ..a/*<ResultSetMetadata>*/(1, 'metadata', PbFieldType.OM, ResultSetMetadata.getDefault, ResultSetMetadata.create)
    ..pp/*<google$protobuf.ListValue>*/(2, 'rows', PbFieldType.PM, google$protobuf.ListValue.$checkItem, google$protobuf.ListValue.create)
    ..a/*<ResultSetStats>*/(3, 'stats', PbFieldType.OM, ResultSetStats.getDefault, ResultSetStats.create)
    ..hasRequiredFields = false
  ;

  ResultSet() : super();
  ResultSet.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResultSet.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResultSet clone() => new ResultSet()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResultSet create() => new ResultSet();
  static PbList<ResultSet> createRepeated() => new PbList<ResultSet>();
  static ResultSet getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResultSet();
    return _defaultInstance;
  }
  static ResultSet _defaultInstance;
  static void $checkItem(ResultSet v) {
    if (v is !ResultSet) checkItemFailed(v, 'ResultSet');
  }

  ResultSetMetadata get metadata => $_get(0, 1, null);
  void set metadata(ResultSetMetadata v) { setField(1, v); }
  bool hasMetadata() => $_has(0, 1);
  void clearMetadata() => clearField(1);

  List<google$protobuf.ListValue> get rows => $_get(1, 2, null);

  ResultSetStats get stats => $_get(2, 3, null);
  void set stats(ResultSetStats v) { setField(3, v); }
  bool hasStats() => $_has(2, 3);
  void clearStats() => clearField(3);
}

class _ReadonlyResultSet extends ResultSet with ReadonlyMessageMixin {}

class PartialResultSet extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('PartialResultSet')
    ..a/*<ResultSetMetadata>*/(1, 'metadata', PbFieldType.OM, ResultSetMetadata.getDefault, ResultSetMetadata.create)
    ..pp/*<google$protobuf.Value>*/(2, 'values', PbFieldType.PM, google$protobuf.Value.$checkItem, google$protobuf.Value.create)
    ..a/*<bool>*/(3, 'chunkedValue', PbFieldType.OB)
    ..a/*<List<int>>*/(4, 'resumeToken', PbFieldType.OY)
    ..a/*<ResultSetStats>*/(5, 'stats', PbFieldType.OM, ResultSetStats.getDefault, ResultSetStats.create)
    ..hasRequiredFields = false
  ;

  PartialResultSet() : super();
  PartialResultSet.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PartialResultSet.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PartialResultSet clone() => new PartialResultSet()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static PartialResultSet create() => new PartialResultSet();
  static PbList<PartialResultSet> createRepeated() => new PbList<PartialResultSet>();
  static PartialResultSet getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPartialResultSet();
    return _defaultInstance;
  }
  static PartialResultSet _defaultInstance;
  static void $checkItem(PartialResultSet v) {
    if (v is !PartialResultSet) checkItemFailed(v, 'PartialResultSet');
  }

  ResultSetMetadata get metadata => $_get(0, 1, null);
  void set metadata(ResultSetMetadata v) { setField(1, v); }
  bool hasMetadata() => $_has(0, 1);
  void clearMetadata() => clearField(1);

  List<google$protobuf.Value> get values => $_get(1, 2, null);

  bool get chunkedValue => $_get(2, 3, false);
  void set chunkedValue(bool v) { $_setBool(2, 3, v); }
  bool hasChunkedValue() => $_has(2, 3);
  void clearChunkedValue() => clearField(3);

  List<int> get resumeToken => $_get(3, 4, null);
  void set resumeToken(List<int> v) { $_setBytes(3, 4, v); }
  bool hasResumeToken() => $_has(3, 4);
  void clearResumeToken() => clearField(4);

  ResultSetStats get stats => $_get(4, 5, null);
  void set stats(ResultSetStats v) { setField(5, v); }
  bool hasStats() => $_has(4, 5);
  void clearStats() => clearField(5);
}

class _ReadonlyPartialResultSet extends PartialResultSet with ReadonlyMessageMixin {}

class ResultSetMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResultSetMetadata')
    ..a/*<StructType>*/(1, 'rowType', PbFieldType.OM, StructType.getDefault, StructType.create)
    ..a/*<Transaction>*/(2, 'transaction', PbFieldType.OM, Transaction.getDefault, Transaction.create)
    ..hasRequiredFields = false
  ;

  ResultSetMetadata() : super();
  ResultSetMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResultSetMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResultSetMetadata clone() => new ResultSetMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResultSetMetadata create() => new ResultSetMetadata();
  static PbList<ResultSetMetadata> createRepeated() => new PbList<ResultSetMetadata>();
  static ResultSetMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResultSetMetadata();
    return _defaultInstance;
  }
  static ResultSetMetadata _defaultInstance;
  static void $checkItem(ResultSetMetadata v) {
    if (v is !ResultSetMetadata) checkItemFailed(v, 'ResultSetMetadata');
  }

  StructType get rowType => $_get(0, 1, null);
  void set rowType(StructType v) { setField(1, v); }
  bool hasRowType() => $_has(0, 1);
  void clearRowType() => clearField(1);

  Transaction get transaction => $_get(1, 2, null);
  void set transaction(Transaction v) { setField(2, v); }
  bool hasTransaction() => $_has(1, 2);
  void clearTransaction() => clearField(2);
}

class _ReadonlyResultSetMetadata extends ResultSetMetadata with ReadonlyMessageMixin {}

class ResultSetStats extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ResultSetStats')
    ..a/*<QueryPlan>*/(1, 'queryPlan', PbFieldType.OM, QueryPlan.getDefault, QueryPlan.create)
    ..a/*<google$protobuf.Struct>*/(2, 'queryStats', PbFieldType.OM, google$protobuf.Struct.getDefault, google$protobuf.Struct.create)
    ..hasRequiredFields = false
  ;

  ResultSetStats() : super();
  ResultSetStats.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ResultSetStats.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ResultSetStats clone() => new ResultSetStats()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ResultSetStats create() => new ResultSetStats();
  static PbList<ResultSetStats> createRepeated() => new PbList<ResultSetStats>();
  static ResultSetStats getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyResultSetStats();
    return _defaultInstance;
  }
  static ResultSetStats _defaultInstance;
  static void $checkItem(ResultSetStats v) {
    if (v is !ResultSetStats) checkItemFailed(v, 'ResultSetStats');
  }

  QueryPlan get queryPlan => $_get(0, 1, null);
  void set queryPlan(QueryPlan v) { setField(1, v); }
  bool hasQueryPlan() => $_has(0, 1);
  void clearQueryPlan() => clearField(1);

  google$protobuf.Struct get queryStats => $_get(1, 2, null);
  void set queryStats(google$protobuf.Struct v) { setField(2, v); }
  bool hasQueryStats() => $_has(1, 2);
  void clearQueryStats() => clearField(2);
}

class _ReadonlyResultSetStats extends ResultSetStats with ReadonlyMessageMixin {}

