///
//  Generated code. Do not modify.
///
library google.cloud.vision.v1_geometry;

import 'package:protobuf/protobuf.dart';

class Vertex extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Vertex')
    ..a/*<int>*/(1, 'x', PbFieldType.O3)
    ..a/*<int>*/(2, 'y', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Vertex() : super();
  Vertex.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Vertex.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Vertex clone() => new Vertex()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Vertex create() => new Vertex();
  static PbList<Vertex> createRepeated() => new PbList<Vertex>();
  static Vertex getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyVertex();
    return _defaultInstance;
  }
  static Vertex _defaultInstance;
  static void $checkItem(Vertex v) {
    if (v is !Vertex) checkItemFailed(v, 'Vertex');
  }

  int get x => $_get(0, 1, 0);
  void set x(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasX() => $_has(0, 1);
  void clearX() => clearField(1);

  int get y => $_get(1, 2, 0);
  void set y(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasY() => $_has(1, 2);
  void clearY() => clearField(2);
}

class _ReadonlyVertex extends Vertex with ReadonlyMessageMixin {}

class BoundingPoly extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BoundingPoly')
    ..pp/*<Vertex>*/(1, 'vertices', PbFieldType.PM, Vertex.$checkItem, Vertex.create)
    ..hasRequiredFields = false
  ;

  BoundingPoly() : super();
  BoundingPoly.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BoundingPoly.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BoundingPoly clone() => new BoundingPoly()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BoundingPoly create() => new BoundingPoly();
  static PbList<BoundingPoly> createRepeated() => new PbList<BoundingPoly>();
  static BoundingPoly getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBoundingPoly();
    return _defaultInstance;
  }
  static BoundingPoly _defaultInstance;
  static void $checkItem(BoundingPoly v) {
    if (v is !BoundingPoly) checkItemFailed(v, 'BoundingPoly');
  }

  List<Vertex> get vertices => $_get(0, 1, null);
}

class _ReadonlyBoundingPoly extends BoundingPoly with ReadonlyMessageMixin {}

class Position extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Position')
    ..a/*<double>*/(1, 'x', PbFieldType.OF)
    ..a/*<double>*/(2, 'y', PbFieldType.OF)
    ..a/*<double>*/(3, 'z', PbFieldType.OF)
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

  double get x => $_get(0, 1, null);
  void set x(double v) { $_setFloat(0, 1, v); }
  bool hasX() => $_has(0, 1);
  void clearX() => clearField(1);

  double get y => $_get(1, 2, null);
  void set y(double v) { $_setFloat(1, 2, v); }
  bool hasY() => $_has(1, 2);
  void clearY() => clearField(2);

  double get z => $_get(2, 3, null);
  void set z(double v) { $_setFloat(2, 3, v); }
  bool hasZ() => $_has(2, 3);
  void clearZ() => clearField(3);
}

class _ReadonlyPosition extends Position with ReadonlyMessageMixin {}

