///
//  Generated code. Do not modify.
///
library google.genomics.v1_position;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Position extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Position')
    ..a/*<String>*/(1, 'referenceName', PbFieldType.OS)
    ..a/*<Int64>*/(2, 'position', PbFieldType.O6, Int64.ZERO)
    ..a/*<bool>*/(3, 'reverseStrand', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Position() : super();
  Position.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Position.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Position clone() => new Position()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Position create() => new Position();
  static PbList<Position> createRepeated() => new PbList<Position>();
  static Position getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyPosition();
    return _defaultInstance;
  }
  static Position _defaultInstance;
  static void $checkItem(Position v) {
    if (v is !Position) checkItemFailed(v, 'Position');
  }

  String get referenceName => $_get(0, 1, '');
  void set referenceName(String v) { $_setString(0, 1, v); }
  bool hasReferenceName() => $_has(0, 1);
  void clearReferenceName() => clearField(1);

  Int64 get position => $_get(1, 2, null);
  void set position(Int64 v) { $_setInt64(1, 2, v); }
  bool hasPosition() => $_has(1, 2);
  void clearPosition() => clearField(2);

  bool get reverseStrand => $_get(2, 3, false);
  void set reverseStrand(bool v) { $_setBool(2, 3, v); }
  bool hasReverseStrand() => $_has(2, 3);
  void clearReverseStrand() => clearField(3);
}

class _ReadonlyPosition extends Position with ReadonlyMessageMixin {}

