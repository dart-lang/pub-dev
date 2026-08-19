//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/value.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/any.pb.dart' as $49;
import '../../../protobuf/struct.pbenum.dart' as $48;

enum Value_Kind {
  nullValue,
  boolValue,
  int64Value,
  uint64Value,
  doubleValue,
  stringValue,
  bytesValue,
  enumValue,
  objectValue,
  mapValue,
  listValue,
  typeValue,
  notSet
}

///  Represents a CEL value.
///
///  This is similar to `google.protobuf.Value`, but can represent CEL's full
///  range of values.
class Value extends $pb.GeneratedMessage {
  factory Value({
    $48.NullValue? nullValue,
    $core.bool? boolValue,
    $fixnum.Int64? int64Value,
    $fixnum.Int64? uint64Value,
    $core.double? doubleValue,
    $core.String? stringValue,
    $core.List<$core.int>? bytesValue,
    EnumValue? enumValue,
    $49.Any? objectValue,
    MapValue? mapValue,
    ListValue? listValue,
    $core.String? typeValue,
  }) {
    final $result = create();
    if (nullValue != null) {
      $result.nullValue = nullValue;
    }
    if (boolValue != null) {
      $result.boolValue = boolValue;
    }
    if (int64Value != null) {
      $result.int64Value = int64Value;
    }
    if (uint64Value != null) {
      $result.uint64Value = uint64Value;
    }
    if (doubleValue != null) {
      $result.doubleValue = doubleValue;
    }
    if (stringValue != null) {
      $result.stringValue = stringValue;
    }
    if (bytesValue != null) {
      $result.bytesValue = bytesValue;
    }
    if (enumValue != null) {
      $result.enumValue = enumValue;
    }
    if (objectValue != null) {
      $result.objectValue = objectValue;
    }
    if (mapValue != null) {
      $result.mapValue = mapValue;
    }
    if (listValue != null) {
      $result.listValue = listValue;
    }
    if (typeValue != null) {
      $result.typeValue = typeValue;
    }
    return $result;
  }
  Value._() : super();
  factory Value.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Value.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Value_Kind> _Value_KindByTag = {
    1: Value_Kind.nullValue,
    2: Value_Kind.boolValue,
    3: Value_Kind.int64Value,
    4: Value_Kind.uint64Value,
    5: Value_Kind.doubleValue,
    6: Value_Kind.stringValue,
    7: Value_Kind.bytesValue,
    9: Value_Kind.enumValue,
    10: Value_Kind.objectValue,
    11: Value_Kind.mapValue,
    12: Value_Kind.listValue,
    15: Value_Kind.typeValue,
    0: Value_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Value',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 15])
    ..e<$48.NullValue>(
        1, _omitFieldNames ? '' : 'nullValue', $pb.PbFieldType.OE,
        defaultOrMaker: $48.NullValue.NULL_VALUE,
        valueOf: $48.NullValue.valueOf,
        enumValues: $48.NullValue.values)
    ..aOB(2, _omitFieldNames ? '' : 'boolValue')
    ..aInt64(3, _omitFieldNames ? '' : 'int64Value')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'uint64Value', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'doubleValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'stringValue')
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'bytesValue', $pb.PbFieldType.OY)
    ..aOM<EnumValue>(9, _omitFieldNames ? '' : 'enumValue',
        subBuilder: EnumValue.create)
    ..aOM<$49.Any>(10, _omitFieldNames ? '' : 'objectValue',
        subBuilder: $49.Any.create)
    ..aOM<MapValue>(11, _omitFieldNames ? '' : 'mapValue',
        subBuilder: MapValue.create)
    ..aOM<ListValue>(12, _omitFieldNames ? '' : 'listValue',
        subBuilder: ListValue.create)
    ..aOS(15, _omitFieldNames ? '' : 'typeValue')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Value clone() => Value()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Value copyWith(void Function(Value) updates) =>
      super.copyWith((message) => updates(message as Value)) as Value;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Value create() => Value._();
  Value createEmptyInstance() => create();
  static $pb.PbList<Value> createRepeated() => $pb.PbList<Value>();
  @$core.pragma('dart2js:noInline')
  static Value getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Value>(create);
  static Value? _defaultInstance;

  Value_Kind whichKind() => _Value_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  /// Null value.
  @$pb.TagNumber(1)
  $48.NullValue get nullValue => $_getN(0);
  @$pb.TagNumber(1)
  set nullValue($48.NullValue v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNullValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearNullValue() => clearField(1);

  /// Boolean value.
  @$pb.TagNumber(2)
  $core.bool get boolValue => $_getBF(1);
  @$pb.TagNumber(2)
  set boolValue($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasBoolValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearBoolValue() => clearField(2);

  /// Signed integer value.
  @$pb.TagNumber(3)
  $fixnum.Int64 get int64Value => $_getI64(2);
  @$pb.TagNumber(3)
  set int64Value($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasInt64Value() => $_has(2);
  @$pb.TagNumber(3)
  void clearInt64Value() => clearField(3);

  /// Unsigned integer value.
  @$pb.TagNumber(4)
  $fixnum.Int64 get uint64Value => $_getI64(3);
  @$pb.TagNumber(4)
  set uint64Value($fixnum.Int64 v) {
    $_setInt64(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUint64Value() => $_has(3);
  @$pb.TagNumber(4)
  void clearUint64Value() => clearField(4);

  /// Floating point value.
  @$pb.TagNumber(5)
  $core.double get doubleValue => $_getN(4);
  @$pb.TagNumber(5)
  set doubleValue($core.double v) {
    $_setDouble(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDoubleValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearDoubleValue() => clearField(5);

  /// UTF-8 string value.
  @$pb.TagNumber(6)
  $core.String get stringValue => $_getSZ(5);
  @$pb.TagNumber(6)
  set stringValue($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasStringValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearStringValue() => clearField(6);

  /// Byte string value.
  @$pb.TagNumber(7)
  $core.List<$core.int> get bytesValue => $_getN(6);
  @$pb.TagNumber(7)
  set bytesValue($core.List<$core.int> v) {
    $_setBytes(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasBytesValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearBytesValue() => clearField(7);

  /// An enum value.
  @$pb.TagNumber(9)
  EnumValue get enumValue => $_getN(7);
  @$pb.TagNumber(9)
  set enumValue(EnumValue v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasEnumValue() => $_has(7);
  @$pb.TagNumber(9)
  void clearEnumValue() => clearField(9);
  @$pb.TagNumber(9)
  EnumValue ensureEnumValue() => $_ensure(7);

  /// The proto message backing an object value.
  @$pb.TagNumber(10)
  $49.Any get objectValue => $_getN(8);
  @$pb.TagNumber(10)
  set objectValue($49.Any v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasObjectValue() => $_has(8);
  @$pb.TagNumber(10)
  void clearObjectValue() => clearField(10);
  @$pb.TagNumber(10)
  $49.Any ensureObjectValue() => $_ensure(8);

  /// Map value.
  @$pb.TagNumber(11)
  MapValue get mapValue => $_getN(9);
  @$pb.TagNumber(11)
  set mapValue(MapValue v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasMapValue() => $_has(9);
  @$pb.TagNumber(11)
  void clearMapValue() => clearField(11);
  @$pb.TagNumber(11)
  MapValue ensureMapValue() => $_ensure(9);

  /// List value.
  @$pb.TagNumber(12)
  ListValue get listValue => $_getN(10);
  @$pb.TagNumber(12)
  set listValue(ListValue v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasListValue() => $_has(10);
  @$pb.TagNumber(12)
  void clearListValue() => clearField(12);
  @$pb.TagNumber(12)
  ListValue ensureListValue() => $_ensure(10);

  /// A Type value represented by the fully qualified name of the type.
  @$pb.TagNumber(15)
  $core.String get typeValue => $_getSZ(11);
  @$pb.TagNumber(15)
  set typeValue($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasTypeValue() => $_has(11);
  @$pb.TagNumber(15)
  void clearTypeValue() => clearField(15);
}

/// An enum value.
class EnumValue extends $pb.GeneratedMessage {
  factory EnumValue({
    $core.String? type,
    $core.int? value,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  EnumValue._() : super();
  factory EnumValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnumValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnumValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnumValue clone() => EnumValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnumValue copyWith(void Function(EnumValue) updates) =>
      super.copyWith((message) => updates(message as EnumValue)) as EnumValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnumValue create() => EnumValue._();
  EnumValue createEmptyInstance() => create();
  static $pb.PbList<EnumValue> createRepeated() => $pb.PbList<EnumValue>();
  @$core.pragma('dart2js:noInline')
  static EnumValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnumValue>(create);
  static EnumValue? _defaultInstance;

  /// The fully qualified name of the enum type.
  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  /// The value of the enum.
  @$pb.TagNumber(2)
  $core.int get value => $_getIZ(1);
  @$pb.TagNumber(2)
  set value($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

///  A list.
///
///  Wrapped in a message so 'not set' and empty can be differentiated, which is
///  required for use in a 'oneof'.
class ListValue extends $pb.GeneratedMessage {
  factory ListValue({
    $core.Iterable<Value>? values,
  }) {
    final $result = create();
    if (values != null) {
      $result.values.addAll(values);
    }
    return $result;
  }
  ListValue._() : super();
  factory ListValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<Value>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.PM,
        subBuilder: Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListValue clone() => ListValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListValue copyWith(void Function(ListValue) updates) =>
      super.copyWith((message) => updates(message as ListValue)) as ListValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListValue create() => ListValue._();
  ListValue createEmptyInstance() => create();
  static $pb.PbList<ListValue> createRepeated() => $pb.PbList<ListValue>();
  @$core.pragma('dart2js:noInline')
  static ListValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListValue>(create);
  static ListValue? _defaultInstance;

  /// The ordered values in the list.
  @$pb.TagNumber(1)
  $core.List<Value> get values => $_getList(0);
}

/// An entry in the map.
class MapValue_Entry extends $pb.GeneratedMessage {
  factory MapValue_Entry({
    Value? key,
    Value? value,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  MapValue_Entry._() : super();
  factory MapValue_Entry.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MapValue_Entry.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MapValue.Entry',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOM<Value>(1, _omitFieldNames ? '' : 'key', subBuilder: Value.create)
    ..aOM<Value>(2, _omitFieldNames ? '' : 'value', subBuilder: Value.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MapValue_Entry clone() => MapValue_Entry()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MapValue_Entry copyWith(void Function(MapValue_Entry) updates) =>
      super.copyWith((message) => updates(message as MapValue_Entry))
          as MapValue_Entry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MapValue_Entry create() => MapValue_Entry._();
  MapValue_Entry createEmptyInstance() => create();
  static $pb.PbList<MapValue_Entry> createRepeated() =>
      $pb.PbList<MapValue_Entry>();
  @$core.pragma('dart2js:noInline')
  static MapValue_Entry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MapValue_Entry>(create);
  static MapValue_Entry? _defaultInstance;

  ///  The key.
  ///
  ///  Must be unique with in the map.
  ///  Currently only boolean, int, uint, and string values can be keys.
  @$pb.TagNumber(1)
  Value get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(Value v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);
  @$pb.TagNumber(1)
  Value ensureKey() => $_ensure(0);

  /// The value.
  @$pb.TagNumber(2)
  Value get value => $_getN(1);
  @$pb.TagNumber(2)
  set value(Value v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  Value ensureValue() => $_ensure(1);
}

///  A map.
///
///  Wrapped in a message so 'not set' and empty can be differentiated, which is
///  required for use in a 'oneof'.
class MapValue extends $pb.GeneratedMessage {
  factory MapValue({
    $core.Iterable<MapValue_Entry>? entries,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    return $result;
  }
  MapValue._() : super();
  factory MapValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MapValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MapValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<MapValue_Entry>(
        1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: MapValue_Entry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MapValue clone() => MapValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MapValue copyWith(void Function(MapValue) updates) =>
      super.copyWith((message) => updates(message as MapValue)) as MapValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MapValue create() => MapValue._();
  MapValue createEmptyInstance() => create();
  static $pb.PbList<MapValue> createRepeated() => $pb.PbList<MapValue>();
  @$core.pragma('dart2js:noInline')
  static MapValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MapValue>(create);
  static MapValue? _defaultInstance;

  ///  The set of map entries.
  ///
  ///  CEL has fewer restrictions on keys, so a protobuf map represenation
  ///  cannot be used.
  @$pb.TagNumber(1)
  $core.List<MapValue_Entry> get entries => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
