///
//  Generated code. Do not modify.
///
library google.protobuf_wrappers;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class DoubleValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('DoubleValue')
    ..a/*<double>*/(1, 'value', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  DoubleValue() : super();
  DoubleValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  DoubleValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  DoubleValue clone() => new DoubleValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static DoubleValue create() => new DoubleValue();
  static PbList<DoubleValue> createRepeated() => new PbList<DoubleValue>();
  static DoubleValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyDoubleValue();
    return _defaultInstance;
  }
  static DoubleValue _defaultInstance;
  static void $checkItem(DoubleValue v) {
    if (v is !DoubleValue) checkItemFailed(v, 'DoubleValue');
  }

  double get value => $_get(0, 1, null);
  void set value(double v) { $_setDouble(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyDoubleValue extends DoubleValue with ReadonlyMessageMixin {}

class FloatValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('FloatValue')
    ..a/*<double>*/(1, 'value', PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  FloatValue() : super();
  FloatValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  FloatValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  FloatValue clone() => new FloatValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static FloatValue create() => new FloatValue();
  static PbList<FloatValue> createRepeated() => new PbList<FloatValue>();
  static FloatValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyFloatValue();
    return _defaultInstance;
  }
  static FloatValue _defaultInstance;
  static void $checkItem(FloatValue v) {
    if (v is !FloatValue) checkItemFailed(v, 'FloatValue');
  }

  double get value => $_get(0, 1, null);
  void set value(double v) { $_setFloat(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyFloatValue extends FloatValue with ReadonlyMessageMixin {}

class Int64Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Int64Value')
    ..a/*<Int64>*/(1, 'value', PbFieldType.O6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  Int64Value() : super();
  Int64Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Int64Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Int64Value clone() => new Int64Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Int64Value create() => new Int64Value();
  static PbList<Int64Value> createRepeated() => new PbList<Int64Value>();
  static Int64Value getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyInt64Value();
    return _defaultInstance;
  }
  static Int64Value _defaultInstance;
  static void $checkItem(Int64Value v) {
    if (v is !Int64Value) checkItemFailed(v, 'Int64Value');
  }

  Int64 get value => $_get(0, 1, null);
  void set value(Int64 v) { $_setInt64(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyInt64Value extends Int64Value with ReadonlyMessageMixin {}

class UInt64Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UInt64Value')
    ..a/*<Int64>*/(1, 'value', PbFieldType.OU6, Int64.ZERO)
    ..hasRequiredFields = false
  ;

  UInt64Value() : super();
  UInt64Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UInt64Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UInt64Value clone() => new UInt64Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UInt64Value create() => new UInt64Value();
  static PbList<UInt64Value> createRepeated() => new PbList<UInt64Value>();
  static UInt64Value getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUInt64Value();
    return _defaultInstance;
  }
  static UInt64Value _defaultInstance;
  static void $checkItem(UInt64Value v) {
    if (v is !UInt64Value) checkItemFailed(v, 'UInt64Value');
  }

  Int64 get value => $_get(0, 1, null);
  void set value(Int64 v) { $_setInt64(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyUInt64Value extends UInt64Value with ReadonlyMessageMixin {}

class Int32Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Int32Value')
    ..a/*<int>*/(1, 'value', PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Int32Value() : super();
  Int32Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Int32Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Int32Value clone() => new Int32Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Int32Value create() => new Int32Value();
  static PbList<Int32Value> createRepeated() => new PbList<Int32Value>();
  static Int32Value getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyInt32Value();
    return _defaultInstance;
  }
  static Int32Value _defaultInstance;
  static void $checkItem(Int32Value v) {
    if (v is !Int32Value) checkItemFailed(v, 'Int32Value');
  }

  int get value => $_get(0, 1, 0);
  void set value(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyInt32Value extends Int32Value with ReadonlyMessageMixin {}

class UInt32Value extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UInt32Value')
    ..a/*<int>*/(1, 'value', PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  UInt32Value() : super();
  UInt32Value.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UInt32Value.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UInt32Value clone() => new UInt32Value()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UInt32Value create() => new UInt32Value();
  static PbList<UInt32Value> createRepeated() => new PbList<UInt32Value>();
  static UInt32Value getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUInt32Value();
    return _defaultInstance;
  }
  static UInt32Value _defaultInstance;
  static void $checkItem(UInt32Value v) {
    if (v is !UInt32Value) checkItemFailed(v, 'UInt32Value');
  }

  int get value => $_get(0, 1, 0);
  void set value(int v) { $_setUnsignedInt32(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyUInt32Value extends UInt32Value with ReadonlyMessageMixin {}

class BoolValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BoolValue')
    ..a/*<bool>*/(1, 'value', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  BoolValue() : super();
  BoolValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BoolValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BoolValue clone() => new BoolValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BoolValue create() => new BoolValue();
  static PbList<BoolValue> createRepeated() => new PbList<BoolValue>();
  static BoolValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBoolValue();
    return _defaultInstance;
  }
  static BoolValue _defaultInstance;
  static void $checkItem(BoolValue v) {
    if (v is !BoolValue) checkItemFailed(v, 'BoolValue');
  }

  bool get value => $_get(0, 1, false);
  void set value(bool v) { $_setBool(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyBoolValue extends BoolValue with ReadonlyMessageMixin {}

class StringValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StringValue')
    ..a/*<String>*/(1, 'value', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  StringValue() : super();
  StringValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StringValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StringValue clone() => new StringValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StringValue create() => new StringValue();
  static PbList<StringValue> createRepeated() => new PbList<StringValue>();
  static StringValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStringValue();
    return _defaultInstance;
  }
  static StringValue _defaultInstance;
  static void $checkItem(StringValue v) {
    if (v is !StringValue) checkItemFailed(v, 'StringValue');
  }

  String get value => $_get(0, 1, '');
  void set value(String v) { $_setString(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyStringValue extends StringValue with ReadonlyMessageMixin {}

class BytesValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('BytesValue')
    ..a/*<List<int>>*/(1, 'value', PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  BytesValue() : super();
  BytesValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BytesValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BytesValue clone() => new BytesValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static BytesValue create() => new BytesValue();
  static PbList<BytesValue> createRepeated() => new PbList<BytesValue>();
  static BytesValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyBytesValue();
    return _defaultInstance;
  }
  static BytesValue _defaultInstance;
  static void $checkItem(BytesValue v) {
    if (v is !BytesValue) checkItemFailed(v, 'BytesValue');
  }

  List<int> get value => $_get(0, 1, null);
  void set value(List<int> v) { $_setBytes(0, 1, v); }
  bool hasValue() => $_has(0, 1);
  void clearValue() => clearField(1);
}

class _ReadonlyBytesValue extends BytesValue with ReadonlyMessageMixin {}

