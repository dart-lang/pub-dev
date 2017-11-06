///
//  Generated code. Do not modify.
///
library google.protobuf_type;

import 'package:protobuf/protobuf.dart';

import 'source_context.pb.dart';
import 'any.pb.dart';

import 'type.pbenum.dart';

export 'type.pbenum.dart';

class Type extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Type')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<Field>*/(2, 'fields', PbFieldType.PM, Field.$checkItem, Field.create)
    ..p/*<String>*/(3, 'oneofs', PbFieldType.PS)
    ..pp/*<Option>*/(4, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..a/*<SourceContext>*/(5, 'sourceContext', PbFieldType.OM, SourceContext.getDefault, SourceContext.create)
    ..e/*<Syntax>*/(6, 'syntax', PbFieldType.OE, Syntax.SYNTAX_PROTO2, Syntax.valueOf)
    ..hasRequiredFields = false
  ;

  Type() : super();
  Type.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Type.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Type clone() => new Type()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Type create() => new Type();
  static PbList<Type> createRepeated() => new PbList<Type>();
  static Type getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyType();
    return _defaultInstance;
  }
  static Type _defaultInstance;
  static void $checkItem(Type v) {
    if (v is !Type) checkItemFailed(v, 'Type');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<Field> get fields => $_get(1, 2, null);

  List<String> get oneofs => $_get(2, 3, null);

  List<Option> get options => $_get(3, 4, null);

  SourceContext get sourceContext => $_get(4, 5, null);
  void set sourceContext(SourceContext v) { setField(5, v); }
  bool hasSourceContext() => $_has(4, 5);
  void clearSourceContext() => clearField(5);

  Syntax get syntax => $_get(5, 6, null);
  void set syntax(Syntax v) { setField(6, v); }
  bool hasSyntax() => $_has(5, 6);
  void clearSyntax() => clearField(6);
}

class _ReadonlyType extends Type with ReadonlyMessageMixin {}

class Field extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Field')
    ..e/*<Field_Kind>*/(1, 'kind', PbFieldType.OE, Field_Kind.TYPE_UNKNOWN, Field_Kind.valueOf)
    ..e/*<Field_Cardinality>*/(2, 'cardinality', PbFieldType.OE, Field_Cardinality.CARDINALITY_UNKNOWN, Field_Cardinality.valueOf)
    ..a/*<int>*/(3, 'number', PbFieldType.O3)
    ..a/*<String>*/(4, 'name', PbFieldType.OS)
    ..a/*<String>*/(6, 'typeUrl', PbFieldType.OS)
    ..a/*<int>*/(7, 'oneofIndex', PbFieldType.O3)
    ..a/*<bool>*/(8, 'packed', PbFieldType.OB)
    ..pp/*<Option>*/(9, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..a/*<String>*/(10, 'jsonName', PbFieldType.OS)
    ..a/*<String>*/(11, 'defaultValue', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Field() : super();
  Field.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Field.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Field clone() => new Field()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Field create() => new Field();
  static PbList<Field> createRepeated() => new PbList<Field>();
  static Field getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyField();
    return _defaultInstance;
  }
  static Field _defaultInstance;
  static void $checkItem(Field v) {
    if (v is !Field) checkItemFailed(v, 'Field');
  }

  Field_Kind get kind => $_get(0, 1, null);
  void set kind(Field_Kind v) { setField(1, v); }
  bool hasKind() => $_has(0, 1);
  void clearKind() => clearField(1);

  Field_Cardinality get cardinality => $_get(1, 2, null);
  void set cardinality(Field_Cardinality v) { setField(2, v); }
  bool hasCardinality() => $_has(1, 2);
  void clearCardinality() => clearField(2);

  int get number => $_get(2, 3, 0);
  void set number(int v) { $_setUnsignedInt32(2, 3, v); }
  bool hasNumber() => $_has(2, 3);
  void clearNumber() => clearField(3);

  String get name => $_get(3, 4, '');
  void set name(String v) { $_setString(3, 4, v); }
  bool hasName() => $_has(3, 4);
  void clearName() => clearField(4);

  String get typeUrl => $_get(4, 6, '');
  void set typeUrl(String v) { $_setString(4, 6, v); }
  bool hasTypeUrl() => $_has(4, 6);
  void clearTypeUrl() => clearField(6);

  int get oneofIndex => $_get(5, 7, 0);
  void set oneofIndex(int v) { $_setUnsignedInt32(5, 7, v); }
  bool hasOneofIndex() => $_has(5, 7);
  void clearOneofIndex() => clearField(7);

  bool get packed => $_get(6, 8, false);
  void set packed(bool v) { $_setBool(6, 8, v); }
  bool hasPacked() => $_has(6, 8);
  void clearPacked() => clearField(8);

  List<Option> get options => $_get(7, 9, null);

  String get jsonName => $_get(8, 10, '');
  void set jsonName(String v) { $_setString(8, 10, v); }
  bool hasJsonName() => $_has(8, 10);
  void clearJsonName() => clearField(10);

  String get defaultValue => $_get(9, 11, '');
  void set defaultValue(String v) { $_setString(9, 11, v); }
  bool hasDefaultValue() => $_has(9, 11);
  void clearDefaultValue() => clearField(11);
}

class _ReadonlyField extends Field with ReadonlyMessageMixin {}

class Enum extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Enum')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..pp/*<EnumValue>*/(2, 'enumvalue', PbFieldType.PM, EnumValue.$checkItem, EnumValue.create)
    ..pp/*<Option>*/(3, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..a/*<SourceContext>*/(4, 'sourceContext', PbFieldType.OM, SourceContext.getDefault, SourceContext.create)
    ..e/*<Syntax>*/(5, 'syntax', PbFieldType.OE, Syntax.SYNTAX_PROTO2, Syntax.valueOf)
    ..hasRequiredFields = false
  ;

  Enum() : super();
  Enum.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Enum.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Enum clone() => new Enum()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Enum create() => new Enum();
  static PbList<Enum> createRepeated() => new PbList<Enum>();
  static Enum getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEnum();
    return _defaultInstance;
  }
  static Enum _defaultInstance;
  static void $checkItem(Enum v) {
    if (v is !Enum) checkItemFailed(v, 'Enum');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<EnumValue> get enumvalue => $_get(1, 2, null);

  List<Option> get options => $_get(2, 3, null);

  SourceContext get sourceContext => $_get(3, 4, null);
  void set sourceContext(SourceContext v) { setField(4, v); }
  bool hasSourceContext() => $_has(3, 4);
  void clearSourceContext() => clearField(4);

  Syntax get syntax => $_get(4, 5, null);
  void set syntax(Syntax v) { setField(5, v); }
  bool hasSyntax() => $_has(4, 5);
  void clearSyntax() => clearField(5);
}

class _ReadonlyEnum extends Enum with ReadonlyMessageMixin {}

class EnumValue extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('EnumValue')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<int>*/(2, 'number', PbFieldType.O3)
    ..pp/*<Option>*/(3, 'options', PbFieldType.PM, Option.$checkItem, Option.create)
    ..hasRequiredFields = false
  ;

  EnumValue() : super();
  EnumValue.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  EnumValue.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  EnumValue clone() => new EnumValue()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static EnumValue create() => new EnumValue();
  static PbList<EnumValue> createRepeated() => new PbList<EnumValue>();
  static EnumValue getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEnumValue();
    return _defaultInstance;
  }
  static EnumValue _defaultInstance;
  static void $checkItem(EnumValue v) {
    if (v is !EnumValue) checkItemFailed(v, 'EnumValue');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  int get number => $_get(1, 2, 0);
  void set number(int v) { $_setUnsignedInt32(1, 2, v); }
  bool hasNumber() => $_has(1, 2);
  void clearNumber() => clearField(2);

  List<Option> get options => $_get(2, 3, null);
}

class _ReadonlyEnumValue extends EnumValue with ReadonlyMessageMixin {}

class Option extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Option')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Any>*/(2, 'value', PbFieldType.OM, Any.getDefault, Any.create)
    ..hasRequiredFields = false
  ;

  Option() : super();
  Option.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Option.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Option clone() => new Option()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Option create() => new Option();
  static PbList<Option> createRepeated() => new PbList<Option>();
  static Option getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOption();
    return _defaultInstance;
  }
  static Option _defaultInstance;
  static void $checkItem(Option v) {
    if (v is !Option) checkItemFailed(v, 'Option');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Any get value => $_get(1, 2, null);
  void set value(Any v) { setField(2, v); }
  bool hasValue() => $_has(1, 2);
  void clearValue() => clearField(2);
}

class _ReadonlyOption extends Option with ReadonlyMessageMixin {}

