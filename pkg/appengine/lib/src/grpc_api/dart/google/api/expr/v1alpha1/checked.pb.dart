//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/checked.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/empty.pb.dart' as $1;
import '../../../protobuf/struct.pbenum.dart' as $48;
import 'checked.pbenum.dart';
import 'syntax.pb.dart' as $100;

export 'checked.pbenum.dart';

/// A CEL expression which has been successfully type checked.
class CheckedExpr extends $pb.GeneratedMessage {
  factory CheckedExpr({
    $core.Map<$fixnum.Int64, Reference>? referenceMap,
    $core.Map<$fixnum.Int64, Type>? typeMap,
    $100.Expr? expr,
    $100.SourceInfo? sourceInfo,
    $core.String? exprVersion,
  }) {
    final $result = create();
    if (referenceMap != null) {
      $result.referenceMap.addAll(referenceMap);
    }
    if (typeMap != null) {
      $result.typeMap.addAll(typeMap);
    }
    if (expr != null) {
      $result.expr = expr;
    }
    if (sourceInfo != null) {
      $result.sourceInfo = sourceInfo;
    }
    if (exprVersion != null) {
      $result.exprVersion = exprVersion;
    }
    return $result;
  }
  CheckedExpr._() : super();
  factory CheckedExpr.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CheckedExpr.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckedExpr',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..m<$fixnum.Int64, Reference>(2, _omitFieldNames ? '' : 'referenceMap',
        entryClassName: 'CheckedExpr.ReferenceMapEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: Reference.create,
        valueDefaultOrMaker: Reference.getDefault,
        packageName: const $pb.PackageName('google.api.expr.v1alpha1'))
    ..m<$fixnum.Int64, Type>(3, _omitFieldNames ? '' : 'typeMap',
        entryClassName: 'CheckedExpr.TypeMapEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: Type.create,
        valueDefaultOrMaker: Type.getDefault,
        packageName: const $pb.PackageName('google.api.expr.v1alpha1'))
    ..aOM<$100.Expr>(4, _omitFieldNames ? '' : 'expr',
        subBuilder: $100.Expr.create)
    ..aOM<$100.SourceInfo>(5, _omitFieldNames ? '' : 'sourceInfo',
        subBuilder: $100.SourceInfo.create)
    ..aOS(6, _omitFieldNames ? '' : 'exprVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CheckedExpr clone() => CheckedExpr()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CheckedExpr copyWith(void Function(CheckedExpr) updates) =>
      super.copyWith((message) => updates(message as CheckedExpr))
          as CheckedExpr;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckedExpr create() => CheckedExpr._();
  CheckedExpr createEmptyInstance() => create();
  static $pb.PbList<CheckedExpr> createRepeated() => $pb.PbList<CheckedExpr>();
  @$core.pragma('dart2js:noInline')
  static CheckedExpr getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckedExpr>(create);
  static CheckedExpr? _defaultInstance;

  ///  A map from expression ids to resolved references.
  ///
  ///  The following entries are in this table:
  ///
  ///  - An Ident or Select expression is represented here if it resolves to a
  ///    declaration. For instance, if `a.b.c` is represented by
  ///    `select(select(id(a), b), c)`, and `a.b` resolves to a declaration,
  ///    while `c` is a field selection, then the reference is attached to the
  ///    nested select expression (but not to the id or or the outer select).
  ///    In turn, if `a` resolves to a declaration and `b.c` are field selections,
  ///    the reference is attached to the ident expression.
  ///  - Every Call expression has an entry here, identifying the function being
  ///    called.
  ///  - Every CreateStruct expression for a message has an entry, identifying
  ///    the message.
  @$pb.TagNumber(2)
  $core.Map<$fixnum.Int64, Reference> get referenceMap => $_getMap(0);

  ///  A map from expression ids to types.
  ///
  ///  Every expression node which has a type different than DYN has a mapping
  ///  here. If an expression has type DYN, it is omitted from this map to save
  ///  space.
  @$pb.TagNumber(3)
  $core.Map<$fixnum.Int64, Type> get typeMap => $_getMap(1);

  /// The checked expression. Semantically equivalent to the parsed `expr`, but
  /// may have structural differences.
  @$pb.TagNumber(4)
  $100.Expr get expr => $_getN(2);
  @$pb.TagNumber(4)
  set expr($100.Expr v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasExpr() => $_has(2);
  @$pb.TagNumber(4)
  void clearExpr() => clearField(4);
  @$pb.TagNumber(4)
  $100.Expr ensureExpr() => $_ensure(2);

  /// The source info derived from input that generated the parsed `expr` and
  /// any optimizations made during the type-checking pass.
  @$pb.TagNumber(5)
  $100.SourceInfo get sourceInfo => $_getN(3);
  @$pb.TagNumber(5)
  set sourceInfo($100.SourceInfo v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSourceInfo() => $_has(3);
  @$pb.TagNumber(5)
  void clearSourceInfo() => clearField(5);
  @$pb.TagNumber(5)
  $100.SourceInfo ensureSourceInfo() => $_ensure(3);

  ///  The expr version indicates the major / minor version number of the `expr`
  ///  representation.
  ///
  ///  The most common reason for a version change will be to indicate to the CEL
  ///  runtimes that transformations have been performed on the expr during static
  ///  analysis. In some cases, this will save the runtime the work of applying
  ///  the same or similar transformations prior to evaluation.
  @$pb.TagNumber(6)
  $core.String get exprVersion => $_getSZ(4);
  @$pb.TagNumber(6)
  set exprVersion($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasExprVersion() => $_has(4);
  @$pb.TagNumber(6)
  void clearExprVersion() => clearField(6);
}

/// List type with typed elements, e.g. `list<example.proto.MyMessage>`.
class Type_ListType extends $pb.GeneratedMessage {
  factory Type_ListType({
    Type? elemType,
  }) {
    final $result = create();
    if (elemType != null) {
      $result.elemType = elemType;
    }
    return $result;
  }
  Type_ListType._() : super();
  factory Type_ListType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Type_ListType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type.ListType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Type>(1, _omitFieldNames ? '' : 'elemType', subBuilder: Type.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Type_ListType clone() => Type_ListType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Type_ListType copyWith(void Function(Type_ListType) updates) =>
      super.copyWith((message) => updates(message as Type_ListType))
          as Type_ListType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Type_ListType create() => Type_ListType._();
  Type_ListType createEmptyInstance() => create();
  static $pb.PbList<Type_ListType> createRepeated() =>
      $pb.PbList<Type_ListType>();
  @$core.pragma('dart2js:noInline')
  static Type_ListType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Type_ListType>(create);
  static Type_ListType? _defaultInstance;

  /// The element type.
  @$pb.TagNumber(1)
  Type get elemType => $_getN(0);
  @$pb.TagNumber(1)
  set elemType(Type v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasElemType() => $_has(0);
  @$pb.TagNumber(1)
  void clearElemType() => clearField(1);
  @$pb.TagNumber(1)
  Type ensureElemType() => $_ensure(0);
}

/// Map type with parameterized key and value types, e.g. `map<string, int>`.
class Type_MapType extends $pb.GeneratedMessage {
  factory Type_MapType({
    Type? keyType,
    Type? valueType,
  }) {
    final $result = create();
    if (keyType != null) {
      $result.keyType = keyType;
    }
    if (valueType != null) {
      $result.valueType = valueType;
    }
    return $result;
  }
  Type_MapType._() : super();
  factory Type_MapType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Type_MapType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type.MapType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Type>(1, _omitFieldNames ? '' : 'keyType', subBuilder: Type.create)
    ..aOM<Type>(2, _omitFieldNames ? '' : 'valueType', subBuilder: Type.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Type_MapType clone() => Type_MapType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Type_MapType copyWith(void Function(Type_MapType) updates) =>
      super.copyWith((message) => updates(message as Type_MapType))
          as Type_MapType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Type_MapType create() => Type_MapType._();
  Type_MapType createEmptyInstance() => create();
  static $pb.PbList<Type_MapType> createRepeated() =>
      $pb.PbList<Type_MapType>();
  @$core.pragma('dart2js:noInline')
  static Type_MapType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Type_MapType>(create);
  static Type_MapType? _defaultInstance;

  /// The type of the key.
  @$pb.TagNumber(1)
  Type get keyType => $_getN(0);
  @$pb.TagNumber(1)
  set keyType(Type v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKeyType() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyType() => clearField(1);
  @$pb.TagNumber(1)
  Type ensureKeyType() => $_ensure(0);

  /// The type of the value.
  @$pb.TagNumber(2)
  Type get valueType => $_getN(1);
  @$pb.TagNumber(2)
  set valueType(Type v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValueType() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueType() => clearField(2);
  @$pb.TagNumber(2)
  Type ensureValueType() => $_ensure(1);
}

/// Function type with result and arg types.
class Type_FunctionType extends $pb.GeneratedMessage {
  factory Type_FunctionType({
    Type? resultType,
    $core.Iterable<Type>? argTypes,
  }) {
    final $result = create();
    if (resultType != null) {
      $result.resultType = resultType;
    }
    if (argTypes != null) {
      $result.argTypes.addAll(argTypes);
    }
    return $result;
  }
  Type_FunctionType._() : super();
  factory Type_FunctionType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Type_FunctionType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type.FunctionType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Type>(1, _omitFieldNames ? '' : 'resultType', subBuilder: Type.create)
    ..pc<Type>(2, _omitFieldNames ? '' : 'argTypes', $pb.PbFieldType.PM,
        subBuilder: Type.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Type_FunctionType clone() => Type_FunctionType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Type_FunctionType copyWith(void Function(Type_FunctionType) updates) =>
      super.copyWith((message) => updates(message as Type_FunctionType))
          as Type_FunctionType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Type_FunctionType create() => Type_FunctionType._();
  Type_FunctionType createEmptyInstance() => create();
  static $pb.PbList<Type_FunctionType> createRepeated() =>
      $pb.PbList<Type_FunctionType>();
  @$core.pragma('dart2js:noInline')
  static Type_FunctionType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Type_FunctionType>(create);
  static Type_FunctionType? _defaultInstance;

  /// Result type of the function.
  @$pb.TagNumber(1)
  Type get resultType => $_getN(0);
  @$pb.TagNumber(1)
  set resultType(Type v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResultType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResultType() => clearField(1);
  @$pb.TagNumber(1)
  Type ensureResultType() => $_ensure(0);

  /// Argument types of the function.
  @$pb.TagNumber(2)
  $core.List<Type> get argTypes => $_getList(1);
}

/// Application defined abstract type.
class Type_AbstractType extends $pb.GeneratedMessage {
  factory Type_AbstractType({
    $core.String? name,
    $core.Iterable<Type>? parameterTypes,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (parameterTypes != null) {
      $result.parameterTypes.addAll(parameterTypes);
    }
    return $result;
  }
  Type_AbstractType._() : super();
  factory Type_AbstractType.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Type_AbstractType.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type.AbstractType',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<Type>(2, _omitFieldNames ? '' : 'parameterTypes', $pb.PbFieldType.PM,
        subBuilder: Type.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Type_AbstractType clone() => Type_AbstractType()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Type_AbstractType copyWith(void Function(Type_AbstractType) updates) =>
      super.copyWith((message) => updates(message as Type_AbstractType))
          as Type_AbstractType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Type_AbstractType create() => Type_AbstractType._();
  Type_AbstractType createEmptyInstance() => create();
  static $pb.PbList<Type_AbstractType> createRepeated() =>
      $pb.PbList<Type_AbstractType>();
  @$core.pragma('dart2js:noInline')
  static Type_AbstractType getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Type_AbstractType>(create);
  static Type_AbstractType? _defaultInstance;

  /// The fully qualified name of this abstract type.
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

  /// Parameter types for this abstract type.
  @$pb.TagNumber(2)
  $core.List<Type> get parameterTypes => $_getList(1);
}

enum Type_TypeKind {
  dyn,
  null_2,
  primitive,
  wrapper,
  wellKnown,
  listType,
  mapType,
  function,
  messageType,
  typeParam,
  type,
  error,
  abstractType,
  notSet
}

/// Represents a CEL type.
class Type extends $pb.GeneratedMessage {
  factory Type({
    $1.Empty? dyn,
    $48.NullValue? null_2,
    Type_PrimitiveType? primitive,
    Type_PrimitiveType? wrapper,
    Type_WellKnownType? wellKnown,
    Type_ListType? listType,
    Type_MapType? mapType,
    Type_FunctionType? function,
    $core.String? messageType,
    $core.String? typeParam,
    Type? type,
    $1.Empty? error,
    Type_AbstractType? abstractType,
  }) {
    final $result = create();
    if (dyn != null) {
      $result.dyn = dyn;
    }
    if (null_2 != null) {
      $result.null_2 = null_2;
    }
    if (primitive != null) {
      $result.primitive = primitive;
    }
    if (wrapper != null) {
      $result.wrapper = wrapper;
    }
    if (wellKnown != null) {
      $result.wellKnown = wellKnown;
    }
    if (listType != null) {
      $result.listType = listType;
    }
    if (mapType != null) {
      $result.mapType = mapType;
    }
    if (function != null) {
      $result.function = function;
    }
    if (messageType != null) {
      $result.messageType = messageType;
    }
    if (typeParam != null) {
      $result.typeParam = typeParam;
    }
    if (type != null) {
      $result.type = type;
    }
    if (error != null) {
      $result.error = error;
    }
    if (abstractType != null) {
      $result.abstractType = abstractType;
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

  static const $core.Map<$core.int, Type_TypeKind> _Type_TypeKindByTag = {
    1: Type_TypeKind.dyn,
    2: Type_TypeKind.null_2,
    3: Type_TypeKind.primitive,
    4: Type_TypeKind.wrapper,
    5: Type_TypeKind.wellKnown,
    6: Type_TypeKind.listType,
    7: Type_TypeKind.mapType,
    8: Type_TypeKind.function,
    9: Type_TypeKind.messageType,
    10: Type_TypeKind.typeParam,
    11: Type_TypeKind.type,
    12: Type_TypeKind.error,
    14: Type_TypeKind.abstractType,
    0: Type_TypeKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Type',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14])
    ..aOM<$1.Empty>(1, _omitFieldNames ? '' : 'dyn',
        subBuilder: $1.Empty.create)
    ..e<$48.NullValue>(2, _omitFieldNames ? '' : 'null', $pb.PbFieldType.OE,
        defaultOrMaker: $48.NullValue.NULL_VALUE,
        valueOf: $48.NullValue.valueOf,
        enumValues: $48.NullValue.values)
    ..e<Type_PrimitiveType>(
        3, _omitFieldNames ? '' : 'primitive', $pb.PbFieldType.OE,
        defaultOrMaker: Type_PrimitiveType.PRIMITIVE_TYPE_UNSPECIFIED,
        valueOf: Type_PrimitiveType.valueOf,
        enumValues: Type_PrimitiveType.values)
    ..e<Type_PrimitiveType>(
        4, _omitFieldNames ? '' : 'wrapper', $pb.PbFieldType.OE,
        defaultOrMaker: Type_PrimitiveType.PRIMITIVE_TYPE_UNSPECIFIED,
        valueOf: Type_PrimitiveType.valueOf,
        enumValues: Type_PrimitiveType.values)
    ..e<Type_WellKnownType>(
        5, _omitFieldNames ? '' : 'wellKnown', $pb.PbFieldType.OE,
        defaultOrMaker: Type_WellKnownType.WELL_KNOWN_TYPE_UNSPECIFIED,
        valueOf: Type_WellKnownType.valueOf,
        enumValues: Type_WellKnownType.values)
    ..aOM<Type_ListType>(6, _omitFieldNames ? '' : 'listType',
        subBuilder: Type_ListType.create)
    ..aOM<Type_MapType>(7, _omitFieldNames ? '' : 'mapType',
        subBuilder: Type_MapType.create)
    ..aOM<Type_FunctionType>(8, _omitFieldNames ? '' : 'function',
        subBuilder: Type_FunctionType.create)
    ..aOS(9, _omitFieldNames ? '' : 'messageType')
    ..aOS(10, _omitFieldNames ? '' : 'typeParam')
    ..aOM<Type>(11, _omitFieldNames ? '' : 'type', subBuilder: Type.create)
    ..aOM<$1.Empty>(12, _omitFieldNames ? '' : 'error',
        subBuilder: $1.Empty.create)
    ..aOM<Type_AbstractType>(14, _omitFieldNames ? '' : 'abstractType',
        subBuilder: Type_AbstractType.create)
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

  Type_TypeKind whichTypeKind() => _Type_TypeKindByTag[$_whichOneof(0)]!;
  void clearTypeKind() => clearField($_whichOneof(0));

  /// Dynamic type.
  @$pb.TagNumber(1)
  $1.Empty get dyn => $_getN(0);
  @$pb.TagNumber(1)
  set dyn($1.Empty v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDyn() => $_has(0);
  @$pb.TagNumber(1)
  void clearDyn() => clearField(1);
  @$pb.TagNumber(1)
  $1.Empty ensureDyn() => $_ensure(0);

  /// Null value.
  @$pb.TagNumber(2)
  $48.NullValue get null_2 => $_getN(1);
  @$pb.TagNumber(2)
  set null_2($48.NullValue v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNull_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearNull_2() => clearField(2);

  /// Primitive types: `true`, `1u`, `-2.0`, `'string'`, `b'bytes'`.
  @$pb.TagNumber(3)
  Type_PrimitiveType get primitive => $_getN(2);
  @$pb.TagNumber(3)
  set primitive(Type_PrimitiveType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPrimitive() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrimitive() => clearField(3);

  /// Wrapper of a primitive type, e.g. `google.protobuf.Int64Value`.
  @$pb.TagNumber(4)
  Type_PrimitiveType get wrapper => $_getN(3);
  @$pb.TagNumber(4)
  set wrapper(Type_PrimitiveType v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasWrapper() => $_has(3);
  @$pb.TagNumber(4)
  void clearWrapper() => clearField(4);

  /// Well-known protobuf type such as `google.protobuf.Timestamp`.
  @$pb.TagNumber(5)
  Type_WellKnownType get wellKnown => $_getN(4);
  @$pb.TagNumber(5)
  set wellKnown(Type_WellKnownType v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasWellKnown() => $_has(4);
  @$pb.TagNumber(5)
  void clearWellKnown() => clearField(5);

  /// Parameterized list with elements of `list_type`, e.g. `list<timestamp>`.
  @$pb.TagNumber(6)
  Type_ListType get listType => $_getN(5);
  @$pb.TagNumber(6)
  set listType(Type_ListType v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasListType() => $_has(5);
  @$pb.TagNumber(6)
  void clearListType() => clearField(6);
  @$pb.TagNumber(6)
  Type_ListType ensureListType() => $_ensure(5);

  /// Parameterized map with typed keys and values.
  @$pb.TagNumber(7)
  Type_MapType get mapType => $_getN(6);
  @$pb.TagNumber(7)
  set mapType(Type_MapType v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasMapType() => $_has(6);
  @$pb.TagNumber(7)
  void clearMapType() => clearField(7);
  @$pb.TagNumber(7)
  Type_MapType ensureMapType() => $_ensure(6);

  /// Function type.
  @$pb.TagNumber(8)
  Type_FunctionType get function => $_getN(7);
  @$pb.TagNumber(8)
  set function(Type_FunctionType v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasFunction() => $_has(7);
  @$pb.TagNumber(8)
  void clearFunction() => clearField(8);
  @$pb.TagNumber(8)
  Type_FunctionType ensureFunction() => $_ensure(7);

  ///  Protocol buffer message type.
  ///
  ///  The `message_type` string specifies the qualified message type name. For
  ///  example, `google.plus.Profile`.
  @$pb.TagNumber(9)
  $core.String get messageType => $_getSZ(8);
  @$pb.TagNumber(9)
  set messageType($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasMessageType() => $_has(8);
  @$pb.TagNumber(9)
  void clearMessageType() => clearField(9);

  ///  Type param type.
  ///
  ///  The `type_param` string specifies the type parameter name, e.g. `list<E>`
  ///  would be a `list_type` whose element type was a `type_param` type
  ///  named `E`.
  @$pb.TagNumber(10)
  $core.String get typeParam => $_getSZ(9);
  @$pb.TagNumber(10)
  set typeParam($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTypeParam() => $_has(9);
  @$pb.TagNumber(10)
  void clearTypeParam() => clearField(10);

  ///  Type type.
  ///
  ///  The `type` value specifies the target type. e.g. int is type with a
  ///  target type of `Primitive.INT`.
  @$pb.TagNumber(11)
  Type get type => $_getN(10);
  @$pb.TagNumber(11)
  set type(Type v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasType() => $_has(10);
  @$pb.TagNumber(11)
  void clearType() => clearField(11);
  @$pb.TagNumber(11)
  Type ensureType() => $_ensure(10);

  ///  Error type.
  ///
  ///  During type-checking if an expression is an error, its type is propagated
  ///  as the `ERROR` type. This permits the type-checker to discover other
  ///  errors present in the expression.
  @$pb.TagNumber(12)
  $1.Empty get error => $_getN(11);
  @$pb.TagNumber(12)
  set error($1.Empty v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasError() => $_has(11);
  @$pb.TagNumber(12)
  void clearError() => clearField(12);
  @$pb.TagNumber(12)
  $1.Empty ensureError() => $_ensure(11);

  /// Abstract, application defined type.
  @$pb.TagNumber(14)
  Type_AbstractType get abstractType => $_getN(12);
  @$pb.TagNumber(14)
  set abstractType(Type_AbstractType v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasAbstractType() => $_has(12);
  @$pb.TagNumber(14)
  void clearAbstractType() => clearField(14);
  @$pb.TagNumber(14)
  Type_AbstractType ensureAbstractType() => $_ensure(12);
}

///  Identifier declaration which specifies its type and optional `Expr` value.
///
///  An identifier without a value is a declaration that must be provided at
///  evaluation time. An identifier with a value should resolve to a constant,
///  but may be used in conjunction with other identifiers bound at evaluation
///  time.
class Decl_IdentDecl extends $pb.GeneratedMessage {
  factory Decl_IdentDecl({
    Type? type,
    $100.Constant? value,
    $core.String? doc,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (value != null) {
      $result.value = value;
    }
    if (doc != null) {
      $result.doc = doc;
    }
    return $result;
  }
  Decl_IdentDecl._() : super();
  factory Decl_IdentDecl.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Decl_IdentDecl.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Decl.IdentDecl',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Type>(1, _omitFieldNames ? '' : 'type', subBuilder: Type.create)
    ..aOM<$100.Constant>(2, _omitFieldNames ? '' : 'value',
        subBuilder: $100.Constant.create)
    ..aOS(3, _omitFieldNames ? '' : 'doc')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Decl_IdentDecl clone() => Decl_IdentDecl()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Decl_IdentDecl copyWith(void Function(Decl_IdentDecl) updates) =>
      super.copyWith((message) => updates(message as Decl_IdentDecl))
          as Decl_IdentDecl;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Decl_IdentDecl create() => Decl_IdentDecl._();
  Decl_IdentDecl createEmptyInstance() => create();
  static $pb.PbList<Decl_IdentDecl> createRepeated() =>
      $pb.PbList<Decl_IdentDecl>();
  @$core.pragma('dart2js:noInline')
  static Decl_IdentDecl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Decl_IdentDecl>(create);
  static Decl_IdentDecl? _defaultInstance;

  /// Required. The type of the identifier.
  @$pb.TagNumber(1)
  Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Type v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);
  @$pb.TagNumber(1)
  Type ensureType() => $_ensure(0);

  /// The constant value of the identifier. If not specified, the identifier
  /// must be supplied at evaluation time.
  @$pb.TagNumber(2)
  $100.Constant get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($100.Constant v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
  @$pb.TagNumber(2)
  $100.Constant ensureValue() => $_ensure(1);

  /// Documentation string for the identifier.
  @$pb.TagNumber(3)
  $core.String get doc => $_getSZ(2);
  @$pb.TagNumber(3)
  set doc($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDoc() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoc() => clearField(3);
}

///  An overload indicates a function's parameter types and return type, and
///  may optionally include a function body described in terms of
///  [Expr][google.api.expr.v1alpha1.Expr] values.
///
///  Functions overloads are declared in either a function or method
///  call-style. For methods, the `params[0]` is the expected type of the
///  target receiver.
///
///  Overloads must have non-overlapping argument types after erasure of all
///  parameterized type variables (similar as type erasure in Java).
class Decl_FunctionDecl_Overload extends $pb.GeneratedMessage {
  factory Decl_FunctionDecl_Overload({
    $core.String? overloadId,
    $core.Iterable<Type>? params,
    $core.Iterable<$core.String>? typeParams,
    Type? resultType,
    $core.bool? isInstanceFunction,
    $core.String? doc,
  }) {
    final $result = create();
    if (overloadId != null) {
      $result.overloadId = overloadId;
    }
    if (params != null) {
      $result.params.addAll(params);
    }
    if (typeParams != null) {
      $result.typeParams.addAll(typeParams);
    }
    if (resultType != null) {
      $result.resultType = resultType;
    }
    if (isInstanceFunction != null) {
      $result.isInstanceFunction = isInstanceFunction;
    }
    if (doc != null) {
      $result.doc = doc;
    }
    return $result;
  }
  Decl_FunctionDecl_Overload._() : super();
  factory Decl_FunctionDecl_Overload.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Decl_FunctionDecl_Overload.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Decl.FunctionDecl.Overload',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'overloadId')
    ..pc<Type>(2, _omitFieldNames ? '' : 'params', $pb.PbFieldType.PM,
        subBuilder: Type.create)
    ..pPS(3, _omitFieldNames ? '' : 'typeParams')
    ..aOM<Type>(4, _omitFieldNames ? '' : 'resultType', subBuilder: Type.create)
    ..aOB(5, _omitFieldNames ? '' : 'isInstanceFunction')
    ..aOS(6, _omitFieldNames ? '' : 'doc')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Decl_FunctionDecl_Overload clone() =>
      Decl_FunctionDecl_Overload()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Decl_FunctionDecl_Overload copyWith(
          void Function(Decl_FunctionDecl_Overload) updates) =>
      super.copyWith(
              (message) => updates(message as Decl_FunctionDecl_Overload))
          as Decl_FunctionDecl_Overload;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Decl_FunctionDecl_Overload create() => Decl_FunctionDecl_Overload._();
  Decl_FunctionDecl_Overload createEmptyInstance() => create();
  static $pb.PbList<Decl_FunctionDecl_Overload> createRepeated() =>
      $pb.PbList<Decl_FunctionDecl_Overload>();
  @$core.pragma('dart2js:noInline')
  static Decl_FunctionDecl_Overload getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Decl_FunctionDecl_Overload>(create);
  static Decl_FunctionDecl_Overload? _defaultInstance;

  ///  Required. Globally unique overload name of the function which reflects
  ///  the function name and argument types.
  ///
  ///  This will be used by a [Reference][google.api.expr.v1alpha1.Reference]
  ///  to indicate the `overload_id` that was resolved for the function
  ///  `name`.
  @$pb.TagNumber(1)
  $core.String get overloadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set overloadId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOverloadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOverloadId() => clearField(1);

  ///  List of function parameter [Type][google.api.expr.v1alpha1.Type]
  ///  values.
  ///
  ///  Param types are disjoint after generic type parameters have been
  ///  replaced with the type `DYN`. Since the `DYN` type is compatible with
  ///  any other type, this means that if `A` is a type parameter, the
  ///  function types `int<A>` and `int<int>` are not disjoint. Likewise,
  ///  `map<string, string>` is not disjoint from `map<K, V>`.
  ///
  ///  When the `result_type` of a function is a generic type param, the
  ///  type param name also appears as the `type` of on at least one params.
  @$pb.TagNumber(2)
  $core.List<Type> get params => $_getList(1);

  ///  The type param names associated with the function declaration.
  ///
  ///  For example, `function ex<K,V>(K key, map<K, V> map) : V` would yield
  ///  the type params of `K, V`.
  @$pb.TagNumber(3)
  $core.List<$core.String> get typeParams => $_getList(2);

  /// Required. The result type of the function. For example, the operator
  /// `string.isEmpty()` would have `result_type` of `kind: BOOL`.
  @$pb.TagNumber(4)
  Type get resultType => $_getN(3);
  @$pb.TagNumber(4)
  set resultType(Type v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasResultType() => $_has(3);
  @$pb.TagNumber(4)
  void clearResultType() => clearField(4);
  @$pb.TagNumber(4)
  Type ensureResultType() => $_ensure(3);

  ///  Whether the function is to be used in a method call-style `x.f(...)`
  ///  or a function call-style `f(x, ...)`.
  ///
  ///  For methods, the first parameter declaration, `params[0]` is the
  ///  expected type of the target receiver.
  @$pb.TagNumber(5)
  $core.bool get isInstanceFunction => $_getBF(4);
  @$pb.TagNumber(5)
  set isInstanceFunction($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasIsInstanceFunction() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsInstanceFunction() => clearField(5);

  /// Documentation string for the overload.
  @$pb.TagNumber(6)
  $core.String get doc => $_getSZ(5);
  @$pb.TagNumber(6)
  set doc($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDoc() => $_has(5);
  @$pb.TagNumber(6)
  void clearDoc() => clearField(6);
}

///  Function declaration specifies one or more overloads which indicate the
///  function's parameter types and return type.
///
///  Functions have no observable side-effects (there may be side-effects like
///  logging which are not observable from CEL).
class Decl_FunctionDecl extends $pb.GeneratedMessage {
  factory Decl_FunctionDecl({
    $core.Iterable<Decl_FunctionDecl_Overload>? overloads,
  }) {
    final $result = create();
    if (overloads != null) {
      $result.overloads.addAll(overloads);
    }
    return $result;
  }
  Decl_FunctionDecl._() : super();
  factory Decl_FunctionDecl.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Decl_FunctionDecl.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Decl.FunctionDecl',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..pc<Decl_FunctionDecl_Overload>(
        1, _omitFieldNames ? '' : 'overloads', $pb.PbFieldType.PM,
        subBuilder: Decl_FunctionDecl_Overload.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Decl_FunctionDecl clone() => Decl_FunctionDecl()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Decl_FunctionDecl copyWith(void Function(Decl_FunctionDecl) updates) =>
      super.copyWith((message) => updates(message as Decl_FunctionDecl))
          as Decl_FunctionDecl;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Decl_FunctionDecl create() => Decl_FunctionDecl._();
  Decl_FunctionDecl createEmptyInstance() => create();
  static $pb.PbList<Decl_FunctionDecl> createRepeated() =>
      $pb.PbList<Decl_FunctionDecl>();
  @$core.pragma('dart2js:noInline')
  static Decl_FunctionDecl getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Decl_FunctionDecl>(create);
  static Decl_FunctionDecl? _defaultInstance;

  /// Required. List of function overloads, must contain at least one overload.
  @$pb.TagNumber(1)
  $core.List<Decl_FunctionDecl_Overload> get overloads => $_getList(0);
}

enum Decl_DeclKind { ident, function, notSet }

///  Represents a declaration of a named value or function.
///
///  A declaration is part of the contract between the expression, the agent
///  evaluating that expression, and the caller requesting evaluation.
class Decl extends $pb.GeneratedMessage {
  factory Decl({
    $core.String? name,
    Decl_IdentDecl? ident,
    Decl_FunctionDecl? function,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (ident != null) {
      $result.ident = ident;
    }
    if (function != null) {
      $result.function = function;
    }
    return $result;
  }
  Decl._() : super();
  factory Decl.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Decl.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Decl_DeclKind> _Decl_DeclKindByTag = {
    2: Decl_DeclKind.ident,
    3: Decl_DeclKind.function,
    0: Decl_DeclKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Decl',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Decl_IdentDecl>(2, _omitFieldNames ? '' : 'ident',
        subBuilder: Decl_IdentDecl.create)
    ..aOM<Decl_FunctionDecl>(3, _omitFieldNames ? '' : 'function',
        subBuilder: Decl_FunctionDecl.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Decl clone() => Decl()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Decl copyWith(void Function(Decl) updates) =>
      super.copyWith((message) => updates(message as Decl)) as Decl;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Decl create() => Decl._();
  Decl createEmptyInstance() => create();
  static $pb.PbList<Decl> createRepeated() => $pb.PbList<Decl>();
  @$core.pragma('dart2js:noInline')
  static Decl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Decl>(create);
  static Decl? _defaultInstance;

  Decl_DeclKind whichDeclKind() => _Decl_DeclKindByTag[$_whichOneof(0)]!;
  void clearDeclKind() => clearField($_whichOneof(0));

  ///  The fully qualified name of the declaration.
  ///
  ///  Declarations are organized in containers and this represents the full path
  ///  to the declaration in its container, as in `google.api.expr.Decl`.
  ///
  ///  Declarations used as
  ///  [FunctionDecl.Overload][google.api.expr.v1alpha1.Decl.FunctionDecl.Overload]
  ///  parameters may or may not have a name depending on whether the overload is
  ///  function declaration or a function definition containing a result
  ///  [Expr][google.api.expr.v1alpha1.Expr].
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

  /// Identifier declaration.
  @$pb.TagNumber(2)
  Decl_IdentDecl get ident => $_getN(1);
  @$pb.TagNumber(2)
  set ident(Decl_IdentDecl v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIdent() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdent() => clearField(2);
  @$pb.TagNumber(2)
  Decl_IdentDecl ensureIdent() => $_ensure(1);

  /// Function declaration.
  @$pb.TagNumber(3)
  Decl_FunctionDecl get function => $_getN(2);
  @$pb.TagNumber(3)
  set function(Decl_FunctionDecl v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => clearField(3);
  @$pb.TagNumber(3)
  Decl_FunctionDecl ensureFunction() => $_ensure(2);
}

/// Describes a resolved reference to a declaration.
class Reference extends $pb.GeneratedMessage {
  factory Reference({
    $core.String? name,
    $core.Iterable<$core.String>? overloadId,
    $100.Constant? value,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (overloadId != null) {
      $result.overloadId.addAll(overloadId);
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  Reference._() : super();
  factory Reference.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Reference.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Reference',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(3, _omitFieldNames ? '' : 'overloadId')
    ..aOM<$100.Constant>(4, _omitFieldNames ? '' : 'value',
        subBuilder: $100.Constant.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Reference clone() => Reference()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Reference copyWith(void Function(Reference) updates) =>
      super.copyWith((message) => updates(message as Reference)) as Reference;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Reference create() => Reference._();
  Reference createEmptyInstance() => create();
  static $pb.PbList<Reference> createRepeated() => $pb.PbList<Reference>();
  @$core.pragma('dart2js:noInline')
  static Reference getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reference>(create);
  static Reference? _defaultInstance;

  /// The fully qualified name of the declaration.
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

  ///  For references to functions, this is a list of `Overload.overload_id`
  ///  values which match according to typing rules.
  ///
  ///  If the list has more than one element, overload resolution among the
  ///  presented candidates must happen at runtime because of dynamic types. The
  ///  type checker attempts to narrow down this list as much as possible.
  ///
  ///  Empty if this is not a reference to a
  ///  [Decl.FunctionDecl][google.api.expr.v1alpha1.Decl.FunctionDecl].
  @$pb.TagNumber(3)
  $core.List<$core.String> get overloadId => $_getList(1);

  /// For references to constants, this may contain the value of the
  /// constant if known at compile time.
  @$pb.TagNumber(4)
  $100.Constant get value => $_getN(2);
  @$pb.TagNumber(4)
  set value($100.Constant v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(4)
  void clearValue() => clearField(4);
  @$pb.TagNumber(4)
  $100.Constant ensureValue() => $_ensure(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
