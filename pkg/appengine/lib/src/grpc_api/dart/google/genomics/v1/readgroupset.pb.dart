///
//  Generated code. Do not modify.
///
library google.genomics.v1_readgroupset;

import 'package:protobuf/protobuf.dart';

import 'readgroup.pb.dart';
import '../../protobuf/struct.pb.dart' as google$protobuf;

class ReadGroupSet_InfoEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroupSet_InfoEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<google$protobuf.ListValue>*/(2, 'value', PbFieldType.OM, google$protobuf.ListValue.getDefault, google$protobuf.ListValue.create)
    ..hasRequiredFields = false
  ;

  ReadGroupSet_InfoEntry() : super();
  ReadGroupSet_InfoEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroupSet_InfoEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroupSet_InfoEntry clone() => new ReadGroupSet_InfoEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroupSet_InfoEntry create() => new ReadGroupSet_InfoEntry();
  static PbList<ReadGroupSet_InfoEntry> createRepeated() => new PbList<ReadGroupSet_InfoEntry>();
  static ReadGroupSet_InfoEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroupSet_InfoEntry();
    return _defaultInstance;
  }
  static ReadGroupSet_InfoEntry _defaultInstance;
  static void $checkItem(ReadGroupSet_InfoEntry v) {
    if (v is !ReadGroupSet_InfoEntry) checkItemFailed(v, 'ReadGroupSet_InfoEntry');
  }

  String get key => $_get(0, 1, '');
  void set key(String v) { $_setString(0, 1, v); }
  bool hasKey() => $_has(0, 1);
  void clearKey() => clearField(1);

  google$protobuf.ListValue get value => $_get(1, 2, null);
  void set value(google$protobuf.ListValue v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyReadGroupSet_InfoEntry extends ReadGroupSet_InfoEntry with ReadonlyMessageMixin {}

class ReadGroupSet extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ReadGroupSet')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'datasetId', PbFieldType.OS)
    ..a/*<String>*/(3, 'referenceSetId', PbFieldType.OS)
    ..a/*<String>*/(4, 'name', PbFieldType.OS)
    ..a/*<String>*/(5, 'filename', PbFieldType.OS)
    ..pp/*<ReadGroup>*/(6, 'readGroups', PbFieldType.PM, ReadGroup.$checkItem, ReadGroup.create)
    ..pp/*<ReadGroupSet_InfoEntry>*/(7, 'info', PbFieldType.PM, ReadGroupSet_InfoEntry.$checkItem, ReadGroupSet_InfoEntry.create)
    ..hasRequiredFields = false
  ;

  ReadGroupSet() : super();
  ReadGroupSet.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ReadGroupSet.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ReadGroupSet clone() => new ReadGroupSet()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ReadGroupSet create() => new ReadGroupSet();
  static PbList<ReadGroupSet> createRepeated() => new PbList<ReadGroupSet>();
  static ReadGroupSet getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyReadGroupSet();
    return _defaultInstance;
  }
  static ReadGroupSet _defaultInstance;
  static void $checkItem(ReadGroupSet v) {
    if (v is !ReadGroupSet) checkItemFailed(v, 'ReadGroupSet');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get datasetId => $_get(1, 2, '');
  void set datasetId(String v) { $_setString(1, 2, v); }
  bool hasDatasetId() => $_has(1, 2);
  void clearDatasetId() => clearField(2);

  String get referenceSetId => $_get(2, 3, '');
  void set referenceSetId(String v) { $_setString(2, 3, v); }
  bool hasReferenceSetId() => $_has(2, 3);
  void clearReferenceSetId() => clearField(3);

  String get name => $_get(3, 4, '');
  void set name(String v) { $_setString(3, 4, v); }
  bool hasName() => $_has(3, 4);
  void clearName() => clearField(4);

  String get filename => $_get(4, 5, '');
  void set filename(String v) { $_setString(4, 5, v); }
  bool hasFilename() => $_has(4, 5);
  void clearFilename() => clearField(5);

  List<ReadGroup> get readGroups => $_get(5, 6, null);

  List<ReadGroupSet_InfoEntry> get info => $_get(6, 7, null);
}

class _ReadonlyReadGroupSet extends ReadGroupSet with ReadonlyMessageMixin {}

