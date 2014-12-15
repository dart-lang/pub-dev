///
//  Generated code. Do not modify.
///
library appengine.base;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class StringProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StringProto')
    ..a(1, 'value', GeneratedMessage.QS)
  ;

  StringProto() : super();
  StringProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StringProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StringProto clone() => new StringProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  String get value => getField(1);
  void set value(String v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class Integer32Proto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Integer32Proto')
    ..a(1, 'value', GeneratedMessage.Q3)
  ;

  Integer32Proto() : super();
  Integer32Proto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Integer32Proto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Integer32Proto clone() => new Integer32Proto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  int get value => getField(1);
  void set value(int v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class Integer64Proto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Integer64Proto')
    ..a(1, 'value', GeneratedMessage.Q6, () => makeLongInt(0))
  ;

  Integer64Proto() : super();
  Integer64Proto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Integer64Proto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Integer64Proto clone() => new Integer64Proto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  Int64 get value => getField(1);
  void set value(Int64 v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class BoolProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BoolProto')
    ..a(1, 'value', GeneratedMessage.QB)
  ;

  BoolProto() : super();
  BoolProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BoolProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BoolProto clone() => new BoolProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  bool get value => getField(1);
  void set value(bool v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class DoubleProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DoubleProto')
    ..a(1, 'value', GeneratedMessage.QD)
  ;

  DoubleProto() : super();
  DoubleProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DoubleProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DoubleProto clone() => new DoubleProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  double get value => getField(1);
  void set value(double v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class BytesProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BytesProto')
    ..a(1, 'value', GeneratedMessage.QY)
  ;

  BytesProto() : super();
  BytesProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BytesProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BytesProto clone() => new BytesProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;

  List<int> get value => getField(1);
  void set value(List<int> v) { setField(1, v); }
  bool hasValue() => hasField(1);
  void clearValue() => clearField(1);
}

class VoidProto extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('VoidProto')
    ..hasRequiredFields = false
  ;

  VoidProto() : super();
  VoidProto.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  VoidProto.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  VoidProto clone() => new VoidProto()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
}

