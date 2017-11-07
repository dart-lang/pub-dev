///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_data;

import 'package:protobuf/protobuf.dart';

import '../../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../../../protobuf/duration.pb.dart' as google$protobuf;

import 'bigtable_table_data.pbenum.dart';

export 'bigtable_table_data.pbenum.dart';

class Table_ColumnFamiliesEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Table_ColumnFamiliesEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<ColumnFamily>*/(2, 'value', PbFieldType.OM, ColumnFamily.getDefault, ColumnFamily.create)
    ..hasRequiredFields = false
  ;

  Table_ColumnFamiliesEntry() : super();
  Table_ColumnFamiliesEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Table_ColumnFamiliesEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Table_ColumnFamiliesEntry clone() => new Table_ColumnFamiliesEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Table_ColumnFamiliesEntry create() => new Table_ColumnFamiliesEntry();
  static PbList<Table_ColumnFamiliesEntry> createRepeated() => new PbList<Table_ColumnFamiliesEntry>();
  static Table_ColumnFamiliesEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTable_ColumnFamiliesEntry();
    return _defaultInstance;
  }
  static Table_ColumnFamiliesEntry _defaultInstance;
  static void $checkItem(Table_ColumnFamiliesEntry v) {
    if (v is !Table_ColumnFamiliesEntry) checkItemFailed(v, 'Table_ColumnFamiliesEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  ColumnFamily get value => $_get(1, 2, null);
  void set value(ColumnFamily v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyTable_ColumnFamiliesEntry extends Table_ColumnFamiliesEntry with ReadonlyMessageMixin {}

class Table extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Table')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<google$longrunning.Operation>*/(2, 'currentOperation', PbFieldType.OM, google$longrunning.Operation.getDefault, google$longrunning.Operation.create)
    ..pp/*<Table_ColumnFamiliesEntry>*/(3, 'columnFamilies', PbFieldType.PM, Table_ColumnFamiliesEntry.$checkItem, Table_ColumnFamiliesEntry.create)
    ..e/*<Table_TimestampGranularity>*/(4, 'granularity', PbFieldType.OE, Table_TimestampGranularity.MILLIS, Table_TimestampGranularity.valueOf)
    ..hasRequiredFields = false
  ;

  Table() : super();
  Table.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Table.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Table clone() => new Table()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Table create() => new Table();
  static PbList<Table> createRepeated() => new PbList<Table>();
  static Table getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyTable();
    return _defaultInstance;
  }
  static Table _defaultInstance;
  static void $checkItem(Table v) {
    if (v is !Table) checkItemFailed(v, 'Table');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  google$longrunning.Operation get currentOperation => $_get(1, 2, null);
  void set currentOperation(google$longrunning.Operation v) { setField(2, v); }
  bool hasCurrentOperation() => $_has(1, 2);
  void clearCurrentOperation() => clearField(2);

  List<Table_ColumnFamiliesEntry> get columnFamilies => $_get(2, 3, null);

  Table_TimestampGranularity get granularity => $_get(3, 4, null);
  void set granularity(Table_TimestampGranularity v) { setField(4, v); }
  bool hasGranularity() => $_has(3, 4);
  void clearGranularity() => clearField(4);
}

class _ReadonlyTable extends Table with ReadonlyMessageMixin {}

class ColumnFamily extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ColumnFamily')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'gcExpression', PbFieldType.OS)
    ..a/*<GcRule>*/(3, 'gcRule', PbFieldType.OM, GcRule.getDefault, GcRule.create)
    ..hasRequiredFields = false
  ;

  ColumnFamily() : super();
  ColumnFamily.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ColumnFamily.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ColumnFamily clone() => new ColumnFamily()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ColumnFamily create() => new ColumnFamily();
  static PbList<ColumnFamily> createRepeated() => new PbList<ColumnFamily>();
  static ColumnFamily getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyColumnFamily();
    return _defaultInstance;
  }
  static ColumnFamily _defaultInstance;
  static void $checkItem(ColumnFamily v) {
    if (v is !ColumnFamily) checkItemFailed(v, 'ColumnFamily');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get gcExpression => $_get(1, 2, '');
  void set gcExpression(String v) { $_setString(1, 2, v); }
  bool hasGcExpression() => $_has(1, 2);
  void clearGcExpression() => clearField(2);

  GcRule get gcRule => $_get(2, 3, null);
  void set gcRule(GcRule v) { setField(3, v); }
  bool hasGcRule() => $_has(2, 3);
  void clearGcRule() => clearField(3);
}

class _ReadonlyColumnFamily extends ColumnFamily with ReadonlyMessageMixin {}

class GcRule_Intersection extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GcRule_Intersection')
    ..pp/*<GcRule>*/(1, 'rules', PbFieldType.PM, GcRule.$checkItem, GcRule.create)
    ..hasRequiredFields = false
  ;

  GcRule_Intersection() : super();
  GcRule_Intersection.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GcRule_Intersection.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GcRule_Intersection clone() => new GcRule_Intersection()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GcRule_Intersection create() => new GcRule_Intersection();
  static PbList<GcRule_Intersection> createRepeated() => new PbList<GcRule_Intersection>();
  static GcRule_Intersection getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGcRule_Intersection();
    return _defaultInstance;
  }
  static GcRule_Intersection _defaultInstance;
  static void $checkItem(GcRule_Intersection v) {
    if (v is !GcRule_Intersection) checkItemFailed(v, 'GcRule_Intersection');
  }

  List<GcRule> get rules => $_get(0, 1, null);
}

class _ReadonlyGcRule_Intersection extends GcRule_Intersection with ReadonlyMessageMixin {}

class GcRule_Union extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GcRule_Union')
    ..pp/*<GcRule>*/(1, 'rules', PbFieldType.PM, GcRule.$checkItem, GcRule.create)
    ..hasRequiredFields = false
  ;

  GcRule_Union() : super();
  GcRule_Union.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GcRule_Union.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GcRule_Union clone() => new GcRule_Union()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GcRule_Union create() => new GcRule_Union();
  static PbList<GcRule_Union> createRepeated() => new PbList<GcRule_Union>();
  static GcRule_Union getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGcRule_Union();
    return _defaultInstance;
  }
  static GcRule_Union _defaultInstance;
  static void $checkItem(GcRule_Union v) {
    if (v is !GcRule_Union) checkItemFailed(v, 'GcRule_Union');
  }

  List<GcRule> get rules => $_get(0, 1, null);
}

class _ReadonlyGcRule_Union extends GcRule_Union with ReadonlyMessageMixin {}

class GcRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('GcRule')
    ..a/*<int>*/(1, 'maxNumVersions', PbFieldType.O3)
    ..a/*<google$protobuf.Duration>*/(2, 'maxAge', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<GcRule_Intersection>*/(3, 'intersection', PbFieldType.OM, GcRule_Intersection.getDefault, GcRule_Intersection.create)
    ..a/*<GcRule_Union>*/(4, 'union', PbFieldType.OM, GcRule_Union.getDefault, GcRule_Union.create)
    ..hasRequiredFields = false
  ;

  GcRule() : super();
  GcRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GcRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GcRule clone() => new GcRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static GcRule create() => new GcRule();
  static PbList<GcRule> createRepeated() => new PbList<GcRule>();
  static GcRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyGcRule();
    return _defaultInstance;
  }
  static GcRule _defaultInstance;
  static void $checkItem(GcRule v) {
    if (v is !GcRule) checkItemFailed(v, 'GcRule');
  }

  int get maxNumVersions => $_get(0, 1, 0);
  void set maxNumVersions(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasMaxNumVersions() => $_has(0, 1);
  void clearMaxNumVersions() => clearField(1);

  google$protobuf.Duration get maxAge => $_get(1, 2, null);
  void set maxAge(google$protobuf.Duration v) { setField(2, v); }
  bool hasMaxAge() => $_has(1, 2);
  void clearMaxAge() => clearField(2);

  GcRule_Intersection get intersection => $_get(2, 3, null);
  void set intersection(GcRule_Intersection v) { setField(3, v); }
  bool hasIntersection() => $_has(2, 3);
  void clearIntersection() => clearField(3);

  GcRule_Union get union => $_get(3, 4, null);
  void set union(GcRule_Union v) { setField(4, v); }
  bool hasUnion() => $_has(3, 4);
  void clearUnion() => clearField(4);
}

class _ReadonlyGcRule extends GcRule with ReadonlyMessageMixin {}

