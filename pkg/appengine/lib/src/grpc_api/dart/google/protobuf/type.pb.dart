//
//  Generated code. Do not modify.
//  source: google/protobuf/type.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'any.pb.dart' as $49;
import 'source_context.pb.dart' as $82;
import 'type.pbenum.dart';

export 'type.pbenum.dart';

/// A protocol buffer message type.
class Type extends $pb.GeneratedMessage {
  factory Type({
    $core.String? name,
    $core.Iterable<Field>? fields,
    $core.Iterable<$core.String>? oneofs,
    $core.Iterable<Option>? options,
    $82.SourceContext? sourceContext,
    Syntax? syntax,
    $core.String? edition,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (fields != null) {
      $result.fields.addAll(fields);
    }
    if (oneofs != null) {
      $result.oneofs.addAll(oneofs);
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (syntax != null) {
      $result.syntax = syntax;
    }
    if (edition != null) {
      $result.edition = edition;
    }
    return $result;
  }
  Type._() : super();
  factory Type.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Type.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<Field>(2, _omitFieldNames ? '' : 'fields', $pb.PbFieldType.PM,
        subBuilder: Field.create)
    ..pPS(3, _omitFieldNames ? '' : 'oneofs')
    ..pc<Option>(4, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: Option.create)
    ..aOM<$82.SourceContext>(5, _omitFieldNames ? '' : 'sourceContext',
        subBuilder: $82.SourceContext.create)
    ..e<Syntax>(6, _omitFieldNames ? '' : 'syntax', $pb.PbFieldType.OE,
        defaultOrMaker: Syntax.SYNTAX_PROTO2,
        valueOf: Syntax.valueOf,
        enumValues: Syntax.values)
    ..aOS(7, _omitFieldNames ? '' : 'edition')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Type clone() => Type()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Type copyWith(void Function(Type) updates) =>
      super.copyWith((message) => updates(message as Type)) as Type;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Type create() => Type._();
  Type createEmptyInstance() => create();
  static $pb.PbList<Type> createRepeated() => $pb.PbList<Type>();
  @$core.pragma('dart2js:noInline')
  static Type getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Type>(create);
  static Type? _defaultInstance;

  /// The fully qualified message name.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// The list of fields.
  @$pb.TagNumber(2)
  $core.List<Field> get fields => $_getList(1);

  /// The list of types appearing in `oneof` definitions in this type.
  @$pb.TagNumber(3)
  $core.List<$core.String> get oneofs => $_getList(2);

  /// The protocol buffer options.
  @$pb.TagNumber(4)
  $core.List<Option> get options => $_getList(3);

  /// The source context.
  @$pb.TagNumber(5)
  $82.SourceContext get sourceContext => $_getN(4);
  @$pb.TagNumber(5)
  set sourceContext($82.SourceContext v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSourceContext() => $_has(4);
  @$pb.TagNumber(5)
  void clearSourceContext() => clearField(5);
  @$pb.TagNumber(5)
  $82.SourceContext ensureSourceContext() => $_ensure(4);

  /// The source syntax.
  @$pb.TagNumber(6)
  Syntax get syntax => $_getN(5);
  @$pb.TagNumber(6)
  set syntax(Syntax v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasSyntax() => $_has(5);
  @$pb.TagNumber(6)
  void clearSyntax() => clearField(6);

  /// The source edition string, only valid when syntax is SYNTAX_EDITIONS.
  @$pb.TagNumber(7)
  $core.String get edition => $_getSZ(6);
  @$pb.TagNumber(7)
  set edition($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasEdition() => $_has(6);
  @$pb.TagNumber(7)
  void clearEdition() => clearField(7);
}

/// A single field of a message type.
class Field extends $pb.GeneratedMessage {
  factory Field({
    Field_Kind? kind,
    Field_Cardinality? cardinality,
    $core.int? number,
    $core.String? name,
    $core.String? typeUrl,
    $core.int? oneofIndex,
    $core.bool? packed,
    $core.Iterable<Option>? options,
    $core.String? jsonName,
    $core.String? defaultValue,
  }) {
    final $result = create();
    if (kind != null) {
      $result.kind = kind;
    }
    if (cardinality != null) {
      $result.cardinality = cardinality;
    }
    if (number != null) {
      $result.number = number;
    }
    if (name != null) {
      $result.name = name;
    }
    if (typeUrl != null) {
      $result.typeUrl = typeUrl;
    }
    if (oneofIndex != null) {
      $result.oneofIndex = oneofIndex;
    }
    if (packed != null) {
      $result.packed = packed;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (jsonName != null) {
      $result.jsonName = jsonName;
    }
    if (defaultValue != null) {
      $result.defaultValue = defaultValue;
    }
    return $result;
  }
  Field._() : super();
  factory Field.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Field.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Field',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..e<Field_Kind>(1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: Field_Kind.TYPE_UNKNOWN,
        valueOf: Field_Kind.valueOf,
        enumValues: Field_Kind.values)
    ..e<Field_Cardinality>(
        2, _omitFieldNames ? '' : 'cardinality', $pb.PbFieldType.OE,
        defaultOrMaker: Field_Cardinality.CARDINALITY_UNKNOWN,
        valueOf: Field_Cardinality.valueOf,
        enumValues: Field_Cardinality.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(6, _omitFieldNames ? '' : 'typeUrl')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'oneofIndex', $pb.PbFieldType.O3)
    ..aOB(8, _omitFieldNames ? '' : 'packed')
    ..pc<Option>(9, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: Option.create)
    ..aOS(10, _omitFieldNames ? '' : 'jsonName')
    ..aOS(11, _omitFieldNames ? '' : 'defaultValue')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Field clone() => Field()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Field copyWith(void Function(Field) updates) =>
      super.copyWith((message) => updates(message as Field)) as Field;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Field create() => Field._();
  Field createEmptyInstance() => create();
  static $pb.PbList<Field> createRepeated() => $pb.PbList<Field>();
  @$core.pragma('dart2js:noInline')
  static Field getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Field>(create);
  static Field? _defaultInstance;

  /// The field type.
  @$pb.TagNumber(1)
  Field_Kind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(Field_Kind v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => clearField(1);

  /// The field cardinality.
  @$pb.TagNumber(2)
  Field_Cardinality get cardinality => $_getN(1);
  @$pb.TagNumber(2)
  set cardinality(Field_Cardinality v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCardinality() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardinality() => clearField(2);

  /// The field number.
  @$pb.TagNumber(3)
  $core.int get number => $_getIZ(2);
  @$pb.TagNumber(3)
  set number($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumber() => clearField(3);

  /// The field name.
  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => clearField(4);

  /// The field type URL, without the scheme, for message or enumeration
  /// types. Example: `"type.googleapis.com/google.protobuf.Timestamp"`.
  @$pb.TagNumber(6)
  $core.String get typeUrl => $_getSZ(4);
  @$pb.TagNumber(6)
  set typeUrl($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasTypeUrl() => $_has(4);
  @$pb.TagNumber(6)
  void clearTypeUrl() => clearField(6);

  /// The index of the field type in `Type.oneofs`, for message or enumeration
  /// types. The first type has index 1; zero means the type is not in the list.
  @$pb.TagNumber(7)
  $core.int get oneofIndex => $_getIZ(5);
  @$pb.TagNumber(7)
  set oneofIndex($core.int v) {
    $_setSignedInt32(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasOneofIndex() => $_has(5);
  @$pb.TagNumber(7)
  void clearOneofIndex() => clearField(7);

  /// Whether to use alternative packed wire representation.
  @$pb.TagNumber(8)
  $core.bool get packed => $_getBF(6);
  @$pb.TagNumber(8)
  set packed($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasPacked() => $_has(6);
  @$pb.TagNumber(8)
  void clearPacked() => clearField(8);

  /// The protocol buffer options.
  @$pb.TagNumber(9)
  $core.List<Option> get options => $_getList(7);

  /// The field JSON name.
  @$pb.TagNumber(10)
  $core.String get jsonName => $_getSZ(8);
  @$pb.TagNumber(10)
  set jsonName($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasJsonName() => $_has(8);
  @$pb.TagNumber(10)
  void clearJsonName() => clearField(10);

  /// The string value of the default value of this field. Proto2 syntax only.
  @$pb.TagNumber(11)
  $core.String get defaultValue => $_getSZ(9);
  @$pb.TagNumber(11)
  set defaultValue($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasDefaultValue() => $_has(9);
  @$pb.TagNumber(11)
  void clearDefaultValue() => clearField(11);
}

/// Enum type definition.
class Enum extends $pb.GeneratedMessage {
  factory Enum({
    $core.String? name,
    $core.Iterable<EnumValue>? enumvalue,
    $core.Iterable<Option>? options,
    $82.SourceContext? sourceContext,
    Syntax? syntax,
    $core.String? edition,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (enumvalue != null) {
      $result.enumvalue.addAll(enumvalue);
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (sourceContext != null) {
      $result.sourceContext = sourceContext;
    }
    if (syntax != null) {
      $result.syntax = syntax;
    }
    if (edition != null) {
      $result.edition = edition;
    }
    return $result;
  }
  Enum._() : super();
  factory Enum.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Enum.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Enum',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<EnumValue>(2, _omitFieldNames ? '' : 'enumvalue', $pb.PbFieldType.PM,
        subBuilder: EnumValue.create)
    ..pc<Option>(3, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: Option.create)
    ..aOM<$82.SourceContext>(4, _omitFieldNames ? '' : 'sourceContext',
        subBuilder: $82.SourceContext.create)
    ..e<Syntax>(5, _omitFieldNames ? '' : 'syntax', $pb.PbFieldType.OE,
        defaultOrMaker: Syntax.SYNTAX_PROTO2,
        valueOf: Syntax.valueOf,
        enumValues: Syntax.values)
    ..aOS(6, _omitFieldNames ? '' : 'edition')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Enum clone() => Enum()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Enum copyWith(void Function(Enum) updates) =>
      super.copyWith((message) => updates(message as Enum)) as Enum;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Enum create() => Enum._();
  Enum createEmptyInstance() => create();
  static $pb.PbList<Enum> createRepeated() => $pb.PbList<Enum>();
  @$core.pragma('dart2js:noInline')
  static Enum getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Enum>(create);
  static Enum? _defaultInstance;

  /// Enum type name.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// Enum value definitions.
  @$pb.TagNumber(2)
  $core.List<EnumValue> get enumvalue => $_getList(1);

  /// Protocol buffer options.
  @$pb.TagNumber(3)
  $core.List<Option> get options => $_getList(2);

  /// The source context.
  @$pb.TagNumber(4)
  $82.SourceContext get sourceContext => $_getN(3);
  @$pb.TagNumber(4)
  set sourceContext($82.SourceContext v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSourceContext() => $_has(3);
  @$pb.TagNumber(4)
  void clearSourceContext() => clearField(4);
  @$pb.TagNumber(4)
  $82.SourceContext ensureSourceContext() => $_ensure(3);

  /// The source syntax.
  @$pb.TagNumber(5)
  Syntax get syntax => $_getN(4);
  @$pb.TagNumber(5)
  set syntax(Syntax v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSyntax() => $_has(4);
  @$pb.TagNumber(5)
  void clearSyntax() => clearField(5);

  /// The source edition string, only valid when syntax is SYNTAX_EDITIONS.
  @$pb.TagNumber(6)
  $core.String get edition => $_getSZ(5);
  @$pb.TagNumber(6)
  set edition($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasEdition() => $_has(5);
  @$pb.TagNumber(6)
  void clearEdition() => clearField(6);
}

/// Enum value definition.
class EnumValue extends $pb.GeneratedMessage {
  factory EnumValue({
    $core.String? name,
    $core.int? number,
    $core.Iterable<Option>? options,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (number != null) {
      $result.number = number;
    }
    if (options != null) {
      $result.options.addAll(options);
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'number', $pb.PbFieldType.O3)
    ..pc<Option>(3, _omitFieldNames ? '' : 'options', $pb.PbFieldType.PM,
        subBuilder: Option.create)
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

  /// Enum value name.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// Enum value number.
  @$pb.TagNumber(2)
  $core.int get number => $_getIZ(1);
  @$pb.TagNumber(2)
  set number($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumber() => clearField(2);

  /// Protocol buffer options.
  @$pb.TagNumber(3)
  $core.List<Option> get options => $_getList(2);
}

/// A protocol buffer option, which can be attached to a message, field,
/// enumeration, etc.
class Option extends $pb.GeneratedMessage {
  factory Option({
    $core.String? name,
    $49.Any? value,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Option._() : super();
  factory Option.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Option.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Option',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.protobuf'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$49.Any>(2, _omitFieldNames ? '' : 'value',
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Option clone() => Option()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Option copyWith(void Function(Option) updates) =>
      super.copyWith((message) => updates(message as Option)) as Option;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Option create() => Option._();
  Option createEmptyInstance() => create();
  static $pb.PbList<Option> createRepeated() => $pb.PbList<Option>();
  @$core.pragma('dart2js:noInline')
  static Option getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Option>(create);
  static Option? _defaultInstance;

  /// The option's name. For protobuf built-in options (options defined in
  /// descriptor.proto), this is the short name. For example, `"map_entry"`.
  /// For custom options, it should be the fully-qualified name. For example,
  /// `"google.api.http"`.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  /// The option's value packed in an Any message. If the value is a primitive,
  /// the corresponding wrapper type defined in google/protobuf/wrappers.proto
  /// should be used. If the value is an enum, it should be stored as an int32
  /// value using the google.protobuf.Int32Value type.
  @$pb.TagNumber(2)
  $49.Any get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($49.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  $49.Any ensureValue() => $_ensure(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
