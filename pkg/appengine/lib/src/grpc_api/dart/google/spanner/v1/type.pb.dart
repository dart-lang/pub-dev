///
//  Generated code. Do not modify.
///
library google.spanner.v1_type;

import 'package:protobuf/protobuf.dart';

import 'type.pbenum.dart';

export 'type.pbenum.dart';

class Type extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Type')
    ..e/*<TypeCode>*/(1, 'code', PbFieldType.OE, TypeCode.TYPE_CODE_UNSPECIFIED, TypeCode.valueOf)
    ..a/*<Type>*/(2, 'arrayElementType', PbFieldType.OM, Type.getDefault, Type.create)
    ..a/*<StructType>*/(3, 'structType', PbFieldType.OM, StructType.getDefault, StructType.create)
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

  TypeCode get code => $_get(0, 1, null);
  void set code(TypeCode v) { setField(1, v); }
  bool hasCode() => $_has(0, 1);
  void clearCode() => clearField(1);

  Type get arrayElementType => $_get(1, 2, null);
  void set arrayElementType(Type v) { setField(2, v); }
  bool hasArrayElementType() => $_has(1, 2);
  void clearArrayElementType() => clearField(2);

  StructType get structType => $_get(2, 3, null);
  void set structType(StructType v) { setField(3, v); }
  bool hasStructType() => $_has(2, 3);
  void clearStructType() => clearField(3);
}

class _ReadonlyType extends Type with ReadonlyMessageMixin {}

class StructType_Field extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StructType_Field')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<Type>*/(2, 'type', PbFieldType.OM, Type.getDefault, Type.create)
    ..hasRequiredFields = false
  ;

  StructType_Field() : super();
  StructType_Field.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StructType_Field.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StructType_Field clone() => new StructType_Field()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StructType_Field create() => new StructType_Field();
  static PbList<StructType_Field> createRepeated() => new PbList<StructType_Field>();
  static StructType_Field getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStructType_Field();
    return _defaultInstance;
  }
  static StructType_Field _defaultInstance;
  static void $checkItem(StructType_Field v) {
    if (v is !StructType_Field) checkItemFailed(v, 'StructType_Field');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  Type get type => $_get(1, 2, null);
  void set type(Type v) { setField(2, v); }
  bool hasType() => $_has(1, 2);
  void clearType() => clearField(2);
}

class _ReadonlyStructType_Field extends StructType_Field with ReadonlyMessageMixin {}

class StructType extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('StructType')
    ..pp/*<StructType_Field>*/(1, 'fields', PbFieldType.PM, StructType_Field.$checkItem, StructType_Field.create)
    ..hasRequiredFields = false
  ;

  StructType() : super();
  StructType.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  StructType.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  StructType clone() => new StructType()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static StructType create() => new StructType();
  static PbList<StructType> createRepeated() => new PbList<StructType>();
  static StructType getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyStructType();
    return _defaultInstance;
  }
  static StructType _defaultInstance;
  static void $checkItem(StructType v) {
    if (v is !StructType) checkItemFailed(v, 'StructType');
  }

  List<StructType_Field> get fields => $_get(0, 1, null);
}

class _ReadonlyStructType extends StructType with ReadonlyMessageMixin {}

