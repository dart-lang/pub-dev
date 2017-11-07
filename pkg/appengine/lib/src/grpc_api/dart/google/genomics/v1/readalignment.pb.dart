///
//  Generated code. Do not modify.
///
library google.genomics.v1_readalignment;

import 'package:protobuf/protobuf.dart';

import 'position.pb.dart';
import 'cigar.pb.dart';
import '../../protobuf/struct.pb.dart' as google$protobuf;

class LinearAlignment extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LinearAlignment')
    ..a/*<Position>*/(1, 'position', PbFieldType.OM, Position.getDefault, Position.create)
    ..a/*<int>*/(2, 'mappingQuality', PbFieldType.O3)
    ..pp/*<CigarUnit>*/(3, 'cigar', PbFieldType.PM, CigarUnit.$checkItem, CigarUnit.create)
    ..hasRequiredFields = false
  ;

  LinearAlignment() : super();
  LinearAlignment.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LinearAlignment.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LinearAlignment clone() => new LinearAlignment()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LinearAlignment create() => new LinearAlignment();
  static PbList<LinearAlignment> createRepeated() => new PbList<LinearAlignment>();
  static LinearAlignment getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLinearAlignment();
    return _defaultInstance;
  }
  static LinearAlignment _defaultInstance;
  static void $checkItem(LinearAlignment v) {
    if (v is !LinearAlignment) checkItemFailed(v, 'LinearAlignment');
  }

  Position get position => $_get(0, 1, null);
  void set position(Position v) { setField(1, v); }
  bool hasPosition() => $_has(0, 1);
  void clearPosition() => clearField(1);

  int get mappingQuality => $_get(1, 2, 0);
  void set mappingQuality(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasMappingQuality() => $_has(1, 2);
  void clearMappingQuality() => clearField(2);

  List<CigarUnit> get cigar => $_get(2, 3, null);
}

class _ReadonlyLinearAlignment extends LinearAlignment with ReadonlyMessageMixin {}

class Read_InfoEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Read_InfoEntry')
    ..a/*<String>*/(1, 'key', PbFieldType.OS)
    ..a/*<google$protobuf.ListValue>*/(2, 'value', PbFieldType.OM, google$protobuf.ListValue.getDefault, google$protobuf.ListValue.create)
    ..hasRequiredFields = false
  ;

  Read_InfoEntry() : super();
  Read_InfoEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Read_InfoEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Read_InfoEntry clone() => new Read_InfoEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Read_InfoEntry create() => new Read_InfoEntry();
  static PbList<Read_InfoEntry> createRepeated() => new PbList<Read_InfoEntry>();
  static Read_InfoEntry getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRead_InfoEntry();
    return _defaultInstance;
  }
  static Read_InfoEntry _defaultInstance;
  static void $checkItem(Read_InfoEntry v) {
    if (v is !Read_InfoEntry) checkItemFailed(v, 'Read_InfoEntry');
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

class _ReadonlyRead_InfoEntry extends Read_InfoEntry with ReadonlyMessageMixin {}

class Read extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Read')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'readGroupId', PbFieldType.OS)
    ..a/*<String>*/(3, 'readGroupSetId', PbFieldType.OS)
    ..a/*<String>*/(4, 'fragmentName', PbFieldType.OS)
    ..a/*<bool>*/(5, 'properPlacement', PbFieldType.OB)
    ..a/*<bool>*/(6, 'duplicateFragment', PbFieldType.OB)
    ..a/*<int>*/(7, 'fragmentLength', PbFieldType.O3)
    ..a/*<int>*/(8, 'readNumber', PbFieldType.O3)
    ..a/*<int>*/(9, 'numberReads', PbFieldType.O3)
    ..a/*<bool>*/(10, 'failedVendorQualityChecks', PbFieldType.OB)
    ..a/*<LinearAlignment>*/(11, 'alignment', PbFieldType.OM, LinearAlignment.getDefault, LinearAlignment.create)
    ..a/*<bool>*/(12, 'secondaryAlignment', PbFieldType.OB)
    ..a/*<bool>*/(13, 'supplementaryAlignment', PbFieldType.OB)
    ..a/*<String>*/(14, 'alignedSequence', PbFieldType.OS)
    ..p/*<int>*/(15, 'alignedQuality', PbFieldType.P3)
    ..a/*<Position>*/(16, 'nextMatePosition', PbFieldType.OM, Position.getDefault, Position.create)
    ..pp/*<Read_InfoEntry>*/(17, 'info', PbFieldType.PM, Read_InfoEntry.$checkItem, Read_InfoEntry.create)
    ..hasRequiredFields = false
  ;

  Read() : super();
  Read.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Read.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Read clone() => new Read()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Read create() => new Read();
  static PbList<Read> createRepeated() => new PbList<Read>();
  static Read getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyRead();
    return _defaultInstance;
  }
  static Read _defaultInstance;
  static void $checkItem(Read v) {
    if (v is !Read) checkItemFailed(v, 'Read');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get readGroupId => $_get(1, 2, '');
  void set readGroupId(String v) { $_setString(1, 2, v); }
  bool hasReadGroupId() => $_has(1, 2);
  void clearReadGroupId() => clearField(2);

  String get readGroupSetId => $_get(2, 3, '');
  void set readGroupSetId(String v) { $_setString(2, 3, v); }
  bool hasReadGroupSetId() => $_has(2, 3);
  void clearReadGroupSetId() => clearField(3);

  String get fragmentName => $_get(3, 4, '');
  void set fragmentName(String v) { $_setString(3, 4, v); }
  bool hasFragmentName() => $_has(3, 4);
  void clearFragmentName() => clearField(4);

  bool get properPlacement => $_get(4, 5, false);
  void set properPlacement(bool v) { $_setBool(4, 5, v); }
  bool hasProperPlacement() => $_has(4, 5);
  void clearProperPlacement() => clearField(5);

  bool get duplicateFragment => $_get(5, 6, false);
  void set duplicateFragment(bool v) { $_setBool(5, 6, v); }
  bool hasDuplicateFragment() => $_has(5, 6);
  void clearDuplicateFragment() => clearField(6);

  int get fragmentLength => $_get(6, 7, 0);
  void set fragmentLength(int v) { $_setUnsignedInt32(6, 7, v); }
  bool hasFragmentLength() => $_has(6, 7);
  void clearFragmentLength() => clearField(7);

  int get readNumber => $_get(7, 8, 0);
  void set readNumber(int v) { $_setUnsignedInt32(7, 8, v); }
  bool hasReadNumber() => $_has(7, 8);
  void clearReadNumber() => clearField(8);

  int get numberReads => $_get(8, 9, 0);
  void set numberReads(int v) { $_setUnsignedInt32(8, 9, v); }
  bool hasNumberReads() => $_has(8, 9);
  void clearNumberReads() => clearField(9);

  bool get failedVendorQualityChecks => $_get(9, 10, false);
  void set failedVendorQualityChecks(bool v) { $_setBool(9, 10, v); }
  bool hasFailedVendorQualityChecks() => $_has(9, 10);
  void clearFailedVendorQualityChecks() => clearField(10);

  LinearAlignment get alignment => $_get(10, 11, null);
  void set alignment(LinearAlignment v) { setField(11, v); }
  bool hasAlignment() => $_has(10, 11);
  void clearAlignment() => clearField(11);

  bool get secondaryAlignment => $_get(11, 12, false);
  void set secondaryAlignment(bool v) { $_setBool(11, 12, v); }
  bool hasSecondaryAlignment() => $_has(11, 12);
  void clearSecondaryAlignment() => clearField(12);

  bool get supplementaryAlignment => $_get(12, 13, false);
  void set supplementaryAlignment(bool v) { $_setBool(12, 13, v); }
  bool hasSupplementaryAlignment() => $_has(12, 13);
  void clearSupplementaryAlignment() => clearField(13);

  String get alignedSequence => $_get(13, 14, '');
  void set alignedSequence(String v) { $_setString(13, 14, v); }
  bool hasAlignedSequence() => $_has(13, 14);
  void clearAlignedSequence() => clearField(14);

  List<int> get alignedQuality => $_get(14, 15, null);

  Position get nextMatePosition => $_get(15, 16, null);
  void set nextMatePosition(Position v) { setField(16, v); }
  bool hasNextMatePosition() => $_has(15, 16);
  void clearNextMatePosition() => clearField(16);

  List<Read_InfoEntry> get info => $_get(16, 17, null);
}

class _ReadonlyRead extends Read with ReadonlyMessageMixin {}

