//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/syntax.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/duration.pb.dart' as $51;
import '../../../protobuf/struct.pbenum.dart' as $48;
import '../../../protobuf/timestamp.pb.dart' as $50;
import 'syntax.pbenum.dart';

export 'syntax.pbenum.dart';

/// An expression together with source information as returned by the parser.
class ParsedExpr extends $pb.GeneratedMessage {
  factory ParsedExpr({
    Expr? expr,
    SourceInfo? sourceInfo,
  }) {
    final $result = create();
    if (expr != null) {
      $result.expr = expr;
    }
    if (sourceInfo != null) {
      $result.sourceInfo = sourceInfo;
    }
    return $result;
  }
  ParsedExpr._() : super();
  factory ParsedExpr.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ParsedExpr.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ParsedExpr',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Expr>(2, _omitFieldNames ? '' : 'expr', subBuilder: Expr.create)
    ..aOM<SourceInfo>(3, _omitFieldNames ? '' : 'sourceInfo',
        subBuilder: SourceInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ParsedExpr clone() => ParsedExpr()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ParsedExpr copyWith(void Function(ParsedExpr) updates) =>
      super.copyWith((message) => updates(message as ParsedExpr)) as ParsedExpr;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ParsedExpr create() => ParsedExpr._();
  ParsedExpr createEmptyInstance() => create();
  static $pb.PbList<ParsedExpr> createRepeated() => $pb.PbList<ParsedExpr>();
  @$core.pragma('dart2js:noInline')
  static ParsedExpr getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ParsedExpr>(create);
  static ParsedExpr? _defaultInstance;

  /// The parsed expression.
  @$pb.TagNumber(2)
  Expr get expr => $_getN(0);
  @$pb.TagNumber(2)
  set expr(Expr v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExpr() => $_has(0);
  @$pb.TagNumber(2)
  void clearExpr() => clearField(2);
  @$pb.TagNumber(2)
  Expr ensureExpr() => $_ensure(0);

  /// The source info derived from input that generated the parsed `expr`.
  @$pb.TagNumber(3)
  SourceInfo get sourceInfo => $_getN(1);
  @$pb.TagNumber(3)
  set sourceInfo(SourceInfo v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSourceInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearSourceInfo() => clearField(3);
  @$pb.TagNumber(3)
  SourceInfo ensureSourceInfo() => $_ensure(1);
}

/// An identifier expression. e.g. `request`.
class Expr_Ident extends $pb.GeneratedMessage {
  factory Expr_Ident({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  Expr_Ident._() : super();
  factory Expr_Ident.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_Ident.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.Ident',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_Ident clone() => Expr_Ident()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_Ident copyWith(void Function(Expr_Ident) updates) =>
      super.copyWith((message) => updates(message as Expr_Ident)) as Expr_Ident;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_Ident create() => Expr_Ident._();
  Expr_Ident createEmptyInstance() => create();
  static $pb.PbList<Expr_Ident> createRepeated() => $pb.PbList<Expr_Ident>();
  @$core.pragma('dart2js:noInline')
  static Expr_Ident getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_Ident>(create);
  static Expr_Ident? _defaultInstance;

  ///  Required. Holds a single, unqualified identifier, possibly preceded by a
  ///  '.'.
  ///
  ///  Qualified names are represented by the
  ///  [Expr.Select][google.api.expr.v1alpha1.Expr.Select] expression.
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
}

/// A field selection expression. e.g. `request.auth`.
class Expr_Select extends $pb.GeneratedMessage {
  factory Expr_Select({
    Expr? operand,
    $core.String? field_2,
    $core.bool? testOnly,
  }) {
    final $result = create();
    if (operand != null) {
      $result.operand = operand;
    }
    if (field_2 != null) {
      $result.field_2 = field_2;
    }
    if (testOnly != null) {
      $result.testOnly = testOnly;
    }
    return $result;
  }
  Expr_Select._() : super();
  factory Expr_Select.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_Select.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.Select',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Expr>(1, _omitFieldNames ? '' : 'operand', subBuilder: Expr.create)
    ..aOS(2, _omitFieldNames ? '' : 'field')
    ..aOB(3, _omitFieldNames ? '' : 'testOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_Select clone() => Expr_Select()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_Select copyWith(void Function(Expr_Select) updates) =>
      super.copyWith((message) => updates(message as Expr_Select))
          as Expr_Select;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_Select create() => Expr_Select._();
  Expr_Select createEmptyInstance() => create();
  static $pb.PbList<Expr_Select> createRepeated() => $pb.PbList<Expr_Select>();
  @$core.pragma('dart2js:noInline')
  static Expr_Select getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_Select>(create);
  static Expr_Select? _defaultInstance;

  ///  Required. The target of the selection expression.
  ///
  ///  For example, in the select expression `request.auth`, the `request`
  ///  portion of the expression is the `operand`.
  @$pb.TagNumber(1)
  Expr get operand => $_getN(0);
  @$pb.TagNumber(1)
  set operand(Expr v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasOperand() => $_has(0);
  @$pb.TagNumber(1)
  void clearOperand() => clearField(1);
  @$pb.TagNumber(1)
  Expr ensureOperand() => $_ensure(0);

  ///  Required. The name of the field to select.
  ///
  ///  For example, in the select expression `request.auth`, the `auth` portion
  ///  of the expression would be the `field`.
  @$pb.TagNumber(2)
  $core.String get field_2 => $_getSZ(1);
  @$pb.TagNumber(2)
  set field_2($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasField_2() => $_has(1);
  @$pb.TagNumber(2)
  void clearField_2() => clearField(2);

  ///  Whether the select is to be interpreted as a field presence test.
  ///
  ///  This results from the macro `has(request.auth)`.
  @$pb.TagNumber(3)
  $core.bool get testOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set testOnly($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasTestOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearTestOnly() => clearField(3);
}

///  A call expression, including calls to predefined functions and operators.
///
///  For example, `value == 10`, `size(map_value)`.
class Expr_Call extends $pb.GeneratedMessage {
  factory Expr_Call({
    Expr? target,
    $core.String? function,
    $core.Iterable<Expr>? args,
  }) {
    final $result = create();
    if (target != null) {
      $result.target = target;
    }
    if (function != null) {
      $result.function = function;
    }
    if (args != null) {
      $result.args.addAll(args);
    }
    return $result;
  }
  Expr_Call._() : super();
  factory Expr_Call.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_Call.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.Call',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOM<Expr>(1, _omitFieldNames ? '' : 'target', subBuilder: Expr.create)
    ..aOS(2, _omitFieldNames ? '' : 'function')
    ..pc<Expr>(3, _omitFieldNames ? '' : 'args', $pb.PbFieldType.PM,
        subBuilder: Expr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_Call clone() => Expr_Call()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_Call copyWith(void Function(Expr_Call) updates) =>
      super.copyWith((message) => updates(message as Expr_Call)) as Expr_Call;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_Call create() => Expr_Call._();
  Expr_Call createEmptyInstance() => create();
  static $pb.PbList<Expr_Call> createRepeated() => $pb.PbList<Expr_Call>();
  @$core.pragma('dart2js:noInline')
  static Expr_Call getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Expr_Call>(create);
  static Expr_Call? _defaultInstance;

  /// The target of an method call-style expression. For example, `x` in
  /// `x.f()`.
  @$pb.TagNumber(1)
  Expr get target => $_getN(0);
  @$pb.TagNumber(1)
  set target(Expr v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTarget() => $_has(0);
  @$pb.TagNumber(1)
  void clearTarget() => clearField(1);
  @$pb.TagNumber(1)
  Expr ensureTarget() => $_ensure(0);

  /// Required. The name of the function or method being called.
  @$pb.TagNumber(2)
  $core.String get function => $_getSZ(1);
  @$pb.TagNumber(2)
  set function($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFunction() => $_has(1);
  @$pb.TagNumber(2)
  void clearFunction() => clearField(2);

  /// The arguments.
  @$pb.TagNumber(3)
  $core.List<Expr> get args => $_getList(2);
}

///  A list creation expression.
///
///  Lists may either be homogenous, e.g. `[1, 2, 3]`, or heterogeneous, e.g.
///  `dyn([1, 'hello', 2.0])`
class Expr_CreateList extends $pb.GeneratedMessage {
  factory Expr_CreateList({
    $core.Iterable<Expr>? elements,
    $core.Iterable<$core.int>? optionalIndices,
  }) {
    final $result = create();
    if (elements != null) {
      $result.elements.addAll(elements);
    }
    if (optionalIndices != null) {
      $result.optionalIndices.addAll(optionalIndices);
    }
    return $result;
  }
  Expr_CreateList._() : super();
  factory Expr_CreateList.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_CreateList.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.CreateList',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..pc<Expr>(1, _omitFieldNames ? '' : 'elements', $pb.PbFieldType.PM,
        subBuilder: Expr.create)
    ..p<$core.int>(
        2, _omitFieldNames ? '' : 'optionalIndices', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_CreateList clone() => Expr_CreateList()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_CreateList copyWith(void Function(Expr_CreateList) updates) =>
      super.copyWith((message) => updates(message as Expr_CreateList))
          as Expr_CreateList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_CreateList create() => Expr_CreateList._();
  Expr_CreateList createEmptyInstance() => create();
  static $pb.PbList<Expr_CreateList> createRepeated() =>
      $pb.PbList<Expr_CreateList>();
  @$core.pragma('dart2js:noInline')
  static Expr_CreateList getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_CreateList>(create);
  static Expr_CreateList? _defaultInstance;

  /// The elements part of the list.
  @$pb.TagNumber(1)
  $core.List<Expr> get elements => $_getList(0);

  ///  The indices within the elements list which are marked as optional
  ///  elements.
  ///
  ///  When an optional-typed value is present, the value it contains
  ///  is included in the list. If the optional-typed value is absent, the list
  ///  element is omitted from the CreateList result.
  @$pb.TagNumber(2)
  $core.List<$core.int> get optionalIndices => $_getList(1);
}

enum Expr_CreateStruct_Entry_KeyKind { fieldKey, mapKey, notSet }

/// Represents an entry.
class Expr_CreateStruct_Entry extends $pb.GeneratedMessage {
  factory Expr_CreateStruct_Entry({
    $fixnum.Int64? id,
    $core.String? fieldKey,
    Expr? mapKey,
    Expr? value,
    $core.bool? optionalEntry,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (fieldKey != null) {
      $result.fieldKey = fieldKey;
    }
    if (mapKey != null) {
      $result.mapKey = mapKey;
    }
    if (value != null) {
      $result.value = value;
    }
    if (optionalEntry != null) {
      $result.optionalEntry = optionalEntry;
    }
    return $result;
  }
  Expr_CreateStruct_Entry._() : super();
  factory Expr_CreateStruct_Entry.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_CreateStruct_Entry.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Expr_CreateStruct_Entry_KeyKind>
      _Expr_CreateStruct_Entry_KeyKindByTag = {
    2: Expr_CreateStruct_Entry_KeyKind.fieldKey,
    3: Expr_CreateStruct_Entry_KeyKind.mapKey,
    0: Expr_CreateStruct_Entry_KeyKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.CreateStruct.Entry',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fieldKey')
    ..aOM<Expr>(3, _omitFieldNames ? '' : 'mapKey', subBuilder: Expr.create)
    ..aOM<Expr>(4, _omitFieldNames ? '' : 'value', subBuilder: Expr.create)
    ..aOB(5, _omitFieldNames ? '' : 'optionalEntry')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_CreateStruct_Entry clone() =>
      Expr_CreateStruct_Entry()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_CreateStruct_Entry copyWith(
          void Function(Expr_CreateStruct_Entry) updates) =>
      super.copyWith((message) => updates(message as Expr_CreateStruct_Entry))
          as Expr_CreateStruct_Entry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_CreateStruct_Entry create() => Expr_CreateStruct_Entry._();
  Expr_CreateStruct_Entry createEmptyInstance() => create();
  static $pb.PbList<Expr_CreateStruct_Entry> createRepeated() =>
      $pb.PbList<Expr_CreateStruct_Entry>();
  @$core.pragma('dart2js:noInline')
  static Expr_CreateStruct_Entry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_CreateStruct_Entry>(create);
  static Expr_CreateStruct_Entry? _defaultInstance;

  Expr_CreateStruct_Entry_KeyKind whichKeyKind() =>
      _Expr_CreateStruct_Entry_KeyKindByTag[$_whichOneof(0)]!;
  void clearKeyKind() => clearField($_whichOneof(0));

  /// Required. An id assigned to this node by the parser which is unique
  /// in a given expression tree. This is used to associate type
  /// information and other attributes to the node.
  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// The field key for a message creator statement.
  @$pb.TagNumber(2)
  $core.String get fieldKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set fieldKey($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFieldKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearFieldKey() => clearField(2);

  /// The key expression for a map creation statement.
  @$pb.TagNumber(3)
  Expr get mapKey => $_getN(2);
  @$pb.TagNumber(3)
  set mapKey(Expr v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMapKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearMapKey() => clearField(3);
  @$pb.TagNumber(3)
  Expr ensureMapKey() => $_ensure(2);

  ///  Required. The value assigned to the key.
  ///
  ///  If the optional_entry field is true, the expression must resolve to an
  ///  optional-typed value. If the optional value is present, the key will be
  ///  set; however, if the optional value is absent, the key will be unset.
  @$pb.TagNumber(4)
  Expr get value => $_getN(3);
  @$pb.TagNumber(4)
  set value(Expr v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearValue() => clearField(4);
  @$pb.TagNumber(4)
  Expr ensureValue() => $_ensure(3);

  /// Whether the key-value pair is optional.
  @$pb.TagNumber(5)
  $core.bool get optionalEntry => $_getBF(4);
  @$pb.TagNumber(5)
  set optionalEntry($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOptionalEntry() => $_has(4);
  @$pb.TagNumber(5)
  void clearOptionalEntry() => clearField(5);
}

///  A map or message creation expression.
///
///  Maps are constructed as `{'key_name': 'value'}`. Message construction is
///  similar, but prefixed with a type name and composed of field ids:
///  `types.MyType{field_id: 'value'}`.
class Expr_CreateStruct extends $pb.GeneratedMessage {
  factory Expr_CreateStruct({
    $core.String? messageName,
    $core.Iterable<Expr_CreateStruct_Entry>? entries,
  }) {
    final $result = create();
    if (messageName != null) {
      $result.messageName = messageName;
    }
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    return $result;
  }
  Expr_CreateStruct._() : super();
  factory Expr_CreateStruct.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_CreateStruct.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.CreateStruct',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageName')
    ..pc<Expr_CreateStruct_Entry>(
        2, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: Expr_CreateStruct_Entry.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_CreateStruct clone() => Expr_CreateStruct()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_CreateStruct copyWith(void Function(Expr_CreateStruct) updates) =>
      super.copyWith((message) => updates(message as Expr_CreateStruct))
          as Expr_CreateStruct;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_CreateStruct create() => Expr_CreateStruct._();
  Expr_CreateStruct createEmptyInstance() => create();
  static $pb.PbList<Expr_CreateStruct> createRepeated() =>
      $pb.PbList<Expr_CreateStruct>();
  @$core.pragma('dart2js:noInline')
  static Expr_CreateStruct getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_CreateStruct>(create);
  static Expr_CreateStruct? _defaultInstance;

  /// The type name of the message to be created, empty when creating map
  /// literals.
  @$pb.TagNumber(1)
  $core.String get messageName => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMessageName() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageName() => clearField(1);

  /// The entries in the creation expression.
  @$pb.TagNumber(2)
  $core.List<Expr_CreateStruct_Entry> get entries => $_getList(1);
}

///  A comprehension expression applied to a list or map.
///
///  Comprehensions are not part of the core syntax, but enabled with macros.
///  A macro matches a specific call signature within a parsed AST and replaces
///  the call with an alternate AST block. Macro expansion happens at parse
///  time.
///
///  The following macros are supported within CEL:
///
///  Aggregate type macros may be applied to all elements in a list or all keys
///  in a map:
///
///  *  `all`, `exists`, `exists_one` -  test a predicate expression against
///     the inputs and return `true` if the predicate is satisfied for all,
///     any, or only one value `list.all(x, x < 10)`.
///  *  `filter` - test a predicate expression against the inputs and return
///     the subset of elements which satisfy the predicate:
///     `payments.filter(p, p > 1000)`.
///  *  `map` - apply an expression to all elements in the input and return the
///     output aggregate type: `[1, 2, 3].map(i, i * i)`.
///
///  The `has(m.x)` macro tests whether the property `x` is present in struct
///  `m`. The semantics of this macro depend on the type of `m`. For proto2
///  messages `has(m.x)` is defined as 'defined, but not set`. For proto3, the
///  macro tests whether the property is set to its default. For map and struct
///  types, the macro tests whether the property `x` is defined on `m`.
///
///  Comprehensions for the standard environment macros evaluation can be best
///  visualized as the following pseudocode:
///
///  ```
///  let `accu_var` = `accu_init`
///  for (let `iter_var` in `iter_range`) {
///    if (!`loop_condition`) {
///      break
///    }
///    `accu_var` = `loop_step`
///  }
///  return `result`
///  ```
///
///  Comprehensions for the optional V2 macros which support map-to-map
///  translation differ slightly from the standard environment macros in that
///  they expose both the key or index in addition to the value for each list
///  or map entry:
///
///  ```
///  let `accu_var` = `accu_init`
///  for (let `iter_var`, `iter_var2` in `iter_range`) {
///    if (!`loop_condition`) {
///      break
///    }
///    `accu_var` = `loop_step`
///  }
///  return `result`
///  ```
class Expr_Comprehension extends $pb.GeneratedMessage {
  factory Expr_Comprehension({
    $core.String? iterVar,
    Expr? iterRange,
    $core.String? accuVar,
    Expr? accuInit,
    Expr? loopCondition,
    Expr? loopStep,
    Expr? result,
    $core.String? iterVar2,
  }) {
    final $result = create();
    if (iterVar != null) {
      $result.iterVar = iterVar;
    }
    if (iterRange != null) {
      $result.iterRange = iterRange;
    }
    if (accuVar != null) {
      $result.accuVar = accuVar;
    }
    if (accuInit != null) {
      $result.accuInit = accuInit;
    }
    if (loopCondition != null) {
      $result.loopCondition = loopCondition;
    }
    if (loopStep != null) {
      $result.loopStep = loopStep;
    }
    if (result != null) {
      $result.result = result;
    }
    if (iterVar2 != null) {
      $result.iterVar2 = iterVar2;
    }
    return $result;
  }
  Expr_Comprehension._() : super();
  factory Expr_Comprehension.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr_Comprehension.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr.Comprehension',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iterVar')
    ..aOM<Expr>(2, _omitFieldNames ? '' : 'iterRange', subBuilder: Expr.create)
    ..aOS(3, _omitFieldNames ? '' : 'accuVar')
    ..aOM<Expr>(4, _omitFieldNames ? '' : 'accuInit', subBuilder: Expr.create)
    ..aOM<Expr>(5, _omitFieldNames ? '' : 'loopCondition',
        subBuilder: Expr.create)
    ..aOM<Expr>(6, _omitFieldNames ? '' : 'loopStep', subBuilder: Expr.create)
    ..aOM<Expr>(7, _omitFieldNames ? '' : 'result', subBuilder: Expr.create)
    ..aOS(8, _omitFieldNames ? '' : 'iterVar2')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr_Comprehension clone() => Expr_Comprehension()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr_Comprehension copyWith(void Function(Expr_Comprehension) updates) =>
      super.copyWith((message) => updates(message as Expr_Comprehension))
          as Expr_Comprehension;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr_Comprehension create() => Expr_Comprehension._();
  Expr_Comprehension createEmptyInstance() => create();
  static $pb.PbList<Expr_Comprehension> createRepeated() =>
      $pb.PbList<Expr_Comprehension>();
  @$core.pragma('dart2js:noInline')
  static Expr_Comprehension getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Expr_Comprehension>(create);
  static Expr_Comprehension? _defaultInstance;

  /// The name of the first iteration variable.
  /// When the iter_range is a list, this variable is the list element.
  /// When the iter_range is a map, this variable is the map entry key.
  @$pb.TagNumber(1)
  $core.String get iterVar => $_getSZ(0);
  @$pb.TagNumber(1)
  set iterVar($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIterVar() => $_has(0);
  @$pb.TagNumber(1)
  void clearIterVar() => clearField(1);

  /// The range over which the comprehension iterates.
  @$pb.TagNumber(2)
  Expr get iterRange => $_getN(1);
  @$pb.TagNumber(2)
  set iterRange(Expr v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIterRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearIterRange() => clearField(2);
  @$pb.TagNumber(2)
  Expr ensureIterRange() => $_ensure(1);

  /// The name of the variable used for accumulation of the result.
  @$pb.TagNumber(3)
  $core.String get accuVar => $_getSZ(2);
  @$pb.TagNumber(3)
  set accuVar($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAccuVar() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccuVar() => clearField(3);

  /// The initial value of the accumulator.
  @$pb.TagNumber(4)
  Expr get accuInit => $_getN(3);
  @$pb.TagNumber(4)
  set accuInit(Expr v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAccuInit() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccuInit() => clearField(4);
  @$pb.TagNumber(4)
  Expr ensureAccuInit() => $_ensure(3);

  ///  An expression which can contain iter_var, iter_var2, and accu_var.
  ///
  ///  Returns false when the result has been computed and may be used as
  ///  a hint to short-circuit the remainder of the comprehension.
  @$pb.TagNumber(5)
  Expr get loopCondition => $_getN(4);
  @$pb.TagNumber(5)
  set loopCondition(Expr v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasLoopCondition() => $_has(4);
  @$pb.TagNumber(5)
  void clearLoopCondition() => clearField(5);
  @$pb.TagNumber(5)
  Expr ensureLoopCondition() => $_ensure(4);

  ///  An expression which can contain iter_var, iter_var2, and accu_var.
  ///
  ///  Computes the next value of accu_var.
  @$pb.TagNumber(6)
  Expr get loopStep => $_getN(5);
  @$pb.TagNumber(6)
  set loopStep(Expr v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasLoopStep() => $_has(5);
  @$pb.TagNumber(6)
  void clearLoopStep() => clearField(6);
  @$pb.TagNumber(6)
  Expr ensureLoopStep() => $_ensure(5);

  ///  An expression which can contain accu_var.
  ///
  ///  Computes the result.
  @$pb.TagNumber(7)
  Expr get result => $_getN(6);
  @$pb.TagNumber(7)
  set result(Expr v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasResult() => $_has(6);
  @$pb.TagNumber(7)
  void clearResult() => clearField(7);
  @$pb.TagNumber(7)
  Expr ensureResult() => $_ensure(6);

  /// The name of the second iteration variable, empty if not set.
  /// When the iter_range is a list, this variable is the integer index.
  /// When the iter_range is a map, this variable is the map entry value.
  /// This field is only set for comprehension v2 macros.
  @$pb.TagNumber(8)
  $core.String get iterVar2 => $_getSZ(7);
  @$pb.TagNumber(8)
  set iterVar2($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasIterVar2() => $_has(7);
  @$pb.TagNumber(8)
  void clearIterVar2() => clearField(8);
}

enum Expr_ExprKind {
  constExpr,
  identExpr,
  selectExpr,
  callExpr,
  listExpr,
  structExpr,
  comprehensionExpr,
  notSet
}

///  An abstract representation of a common expression.
///
///  Expressions are abstractly represented as a collection of identifiers,
///  select statements, function calls, literals, and comprehensions. All
///  operators with the exception of the '.' operator are modelled as function
///  calls. This makes it easy to represent new operators into the existing AST.
///
///  All references within expressions must resolve to a
///  [Decl][google.api.expr.v1alpha1.Decl] provided at type-check for an
///  expression to be valid. A reference may either be a bare identifier `name` or
///  a qualified identifier `google.api.name`. References may either refer to a
///  value or a function declaration.
///
///  For example, the expression `google.api.name.startsWith('expr')` references
///  the declaration `google.api.name` within a
///  [Expr.Select][google.api.expr.v1alpha1.Expr.Select] expression, and the
///  function declaration `startsWith`.
class Expr extends $pb.GeneratedMessage {
  factory Expr({
    $fixnum.Int64? id,
    Constant? constExpr,
    Expr_Ident? identExpr,
    Expr_Select? selectExpr,
    Expr_Call? callExpr,
    Expr_CreateList? listExpr,
    Expr_CreateStruct? structExpr,
    Expr_Comprehension? comprehensionExpr,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (constExpr != null) {
      $result.constExpr = constExpr;
    }
    if (identExpr != null) {
      $result.identExpr = identExpr;
    }
    if (selectExpr != null) {
      $result.selectExpr = selectExpr;
    }
    if (callExpr != null) {
      $result.callExpr = callExpr;
    }
    if (listExpr != null) {
      $result.listExpr = listExpr;
    }
    if (structExpr != null) {
      $result.structExpr = structExpr;
    }
    if (comprehensionExpr != null) {
      $result.comprehensionExpr = comprehensionExpr;
    }
    return $result;
  }
  Expr._() : super();
  factory Expr.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Expr.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Expr_ExprKind> _Expr_ExprKindByTag = {
    3: Expr_ExprKind.constExpr,
    4: Expr_ExprKind.identExpr,
    5: Expr_ExprKind.selectExpr,
    6: Expr_ExprKind.callExpr,
    7: Expr_ExprKind.listExpr,
    8: Expr_ExprKind.structExpr,
    9: Expr_ExprKind.comprehensionExpr,
    0: Expr_ExprKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Expr',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7, 8, 9])
    ..aInt64(2, _omitFieldNames ? '' : 'id')
    ..aOM<Constant>(3, _omitFieldNames ? '' : 'constExpr',
        subBuilder: Constant.create)
    ..aOM<Expr_Ident>(4, _omitFieldNames ? '' : 'identExpr',
        subBuilder: Expr_Ident.create)
    ..aOM<Expr_Select>(5, _omitFieldNames ? '' : 'selectExpr',
        subBuilder: Expr_Select.create)
    ..aOM<Expr_Call>(6, _omitFieldNames ? '' : 'callExpr',
        subBuilder: Expr_Call.create)
    ..aOM<Expr_CreateList>(7, _omitFieldNames ? '' : 'listExpr',
        subBuilder: Expr_CreateList.create)
    ..aOM<Expr_CreateStruct>(8, _omitFieldNames ? '' : 'structExpr',
        subBuilder: Expr_CreateStruct.create)
    ..aOM<Expr_Comprehension>(9, _omitFieldNames ? '' : 'comprehensionExpr',
        subBuilder: Expr_Comprehension.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Expr clone() => Expr()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Expr copyWith(void Function(Expr) updates) =>
      super.copyWith((message) => updates(message as Expr)) as Expr;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Expr create() => Expr._();
  Expr createEmptyInstance() => create();
  static $pb.PbList<Expr> createRepeated() => $pb.PbList<Expr>();
  @$core.pragma('dart2js:noInline')
  static Expr getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Expr>(create);
  static Expr? _defaultInstance;

  Expr_ExprKind whichExprKind() => _Expr_ExprKindByTag[$_whichOneof(0)]!;
  void clearExprKind() => clearField($_whichOneof(0));

  /// Required. An id assigned to this node by the parser which is unique in a
  /// given expression tree. This is used to associate type information and other
  /// attributes to a node in the parse tree.
  @$pb.TagNumber(2)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(2)
  set id($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// A literal expression.
  @$pb.TagNumber(3)
  Constant get constExpr => $_getN(1);
  @$pb.TagNumber(3)
  set constExpr(Constant v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasConstExpr() => $_has(1);
  @$pb.TagNumber(3)
  void clearConstExpr() => clearField(3);
  @$pb.TagNumber(3)
  Constant ensureConstExpr() => $_ensure(1);

  /// An identifier expression.
  @$pb.TagNumber(4)
  Expr_Ident get identExpr => $_getN(2);
  @$pb.TagNumber(4)
  set identExpr(Expr_Ident v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIdentExpr() => $_has(2);
  @$pb.TagNumber(4)
  void clearIdentExpr() => clearField(4);
  @$pb.TagNumber(4)
  Expr_Ident ensureIdentExpr() => $_ensure(2);

  /// A field selection expression, e.g. `request.auth`.
  @$pb.TagNumber(5)
  Expr_Select get selectExpr => $_getN(3);
  @$pb.TagNumber(5)
  set selectExpr(Expr_Select v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasSelectExpr() => $_has(3);
  @$pb.TagNumber(5)
  void clearSelectExpr() => clearField(5);
  @$pb.TagNumber(5)
  Expr_Select ensureSelectExpr() => $_ensure(3);

  /// A call expression, including calls to predefined functions and operators.
  @$pb.TagNumber(6)
  Expr_Call get callExpr => $_getN(4);
  @$pb.TagNumber(6)
  set callExpr(Expr_Call v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCallExpr() => $_has(4);
  @$pb.TagNumber(6)
  void clearCallExpr() => clearField(6);
  @$pb.TagNumber(6)
  Expr_Call ensureCallExpr() => $_ensure(4);

  /// A list creation expression.
  @$pb.TagNumber(7)
  Expr_CreateList get listExpr => $_getN(5);
  @$pb.TagNumber(7)
  set listExpr(Expr_CreateList v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasListExpr() => $_has(5);
  @$pb.TagNumber(7)
  void clearListExpr() => clearField(7);
  @$pb.TagNumber(7)
  Expr_CreateList ensureListExpr() => $_ensure(5);

  /// A map or message creation expression.
  @$pb.TagNumber(8)
  Expr_CreateStruct get structExpr => $_getN(6);
  @$pb.TagNumber(8)
  set structExpr(Expr_CreateStruct v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasStructExpr() => $_has(6);
  @$pb.TagNumber(8)
  void clearStructExpr() => clearField(8);
  @$pb.TagNumber(8)
  Expr_CreateStruct ensureStructExpr() => $_ensure(6);

  /// A comprehension expression.
  @$pb.TagNumber(9)
  Expr_Comprehension get comprehensionExpr => $_getN(7);
  @$pb.TagNumber(9)
  set comprehensionExpr(Expr_Comprehension v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasComprehensionExpr() => $_has(7);
  @$pb.TagNumber(9)
  void clearComprehensionExpr() => clearField(9);
  @$pb.TagNumber(9)
  Expr_Comprehension ensureComprehensionExpr() => $_ensure(7);
}

enum Constant_ConstantKind {
  nullValue,
  boolValue,
  int64Value,
  uint64Value,
  doubleValue,
  stringValue,
  bytesValue,
  durationValue,
  timestampValue,
  notSet
}

///  Represents a primitive literal.
///
///  Named 'Constant' here for backwards compatibility.
///
///  This is similar as the primitives supported in the well-known type
///  `google.protobuf.Value`, but richer so it can represent CEL's full range of
///  primitives.
///
///  Lists and structs are not included as constants as these aggregate types may
///  contain [Expr][google.api.expr.v1alpha1.Expr] elements which require
///  evaluation and are thus not constant.
///
///  Examples of literals include: `"hello"`, `b'bytes'`, `1u`, `4.2`, `-2`,
///  `true`, `null`.
class Constant extends $pb.GeneratedMessage {
  factory Constant({
    $48.NullValue? nullValue,
    $core.bool? boolValue,
    $fixnum.Int64? int64Value,
    $fixnum.Int64? uint64Value,
    $core.double? doubleValue,
    $core.String? stringValue,
    $core.List<$core.int>? bytesValue,
    @$core.Deprecated('This field is deprecated.') $51.Duration? durationValue,
    @$core.Deprecated('This field is deprecated.')
    $50.Timestamp? timestampValue,
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
    if (durationValue != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.durationValue = durationValue;
    }
    if (timestampValue != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.timestampValue = timestampValue;
    }
    return $result;
  }
  Constant._() : super();
  factory Constant.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Constant.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Constant_ConstantKind>
      _Constant_ConstantKindByTag = {
    1: Constant_ConstantKind.nullValue,
    2: Constant_ConstantKind.boolValue,
    3: Constant_ConstantKind.int64Value,
    4: Constant_ConstantKind.uint64Value,
    5: Constant_ConstantKind.doubleValue,
    6: Constant_ConstantKind.stringValue,
    7: Constant_ConstantKind.bytesValue,
    8: Constant_ConstantKind.durationValue,
    9: Constant_ConstantKind.timestampValue,
    0: Constant_ConstantKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Constant',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9])
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
    ..aOM<$51.Duration>(8, _omitFieldNames ? '' : 'durationValue',
        subBuilder: $51.Duration.create)
    ..aOM<$50.Timestamp>(9, _omitFieldNames ? '' : 'timestampValue',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Constant clone() => Constant()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Constant copyWith(void Function(Constant) updates) =>
      super.copyWith((message) => updates(message as Constant)) as Constant;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Constant create() => Constant._();
  Constant createEmptyInstance() => create();
  static $pb.PbList<Constant> createRepeated() => $pb.PbList<Constant>();
  @$core.pragma('dart2js:noInline')
  static Constant getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Constant>(create);
  static Constant? _defaultInstance;

  Constant_ConstantKind whichConstantKind() =>
      _Constant_ConstantKindByTag[$_whichOneof(0)]!;
  void clearConstantKind() => clearField($_whichOneof(0));

  /// null value.
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

  /// boolean value.
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

  /// int64 value.
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

  /// uint64 value.
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

  /// double value.
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

  /// string value.
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

  /// bytes value.
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

  ///  protobuf.Duration value.
  ///
  ///  Deprecated: duration is no longer considered a builtin cel type.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $51.Duration get durationValue => $_getN(7);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  set durationValue($51.Duration v) {
    setField(8, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $core.bool hasDurationValue() => $_has(7);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  void clearDurationValue() => clearField(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $51.Duration ensureDurationValue() => $_ensure(7);

  ///  protobuf.Timestamp value.
  ///
  ///  Deprecated: timestamp is no longer considered a builtin cel type.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  $50.Timestamp get timestampValue => $_getN(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  set timestampValue($50.Timestamp v) {
    setField(9, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  $core.bool hasTimestampValue() => $_has(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  void clearTimestampValue() => clearField(9);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  $50.Timestamp ensureTimestampValue() => $_ensure(8);
}

/// Version
class SourceInfo_Extension_Version extends $pb.GeneratedMessage {
  factory SourceInfo_Extension_Version({
    $fixnum.Int64? major,
    $fixnum.Int64? minor,
  }) {
    final $result = create();
    if (major != null) {
      $result.major = major;
    }
    if (minor != null) {
      $result.minor = minor;
    }
    return $result;
  }
  SourceInfo_Extension_Version._() : super();
  factory SourceInfo_Extension_Version.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceInfo_Extension_Version.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceInfo.Extension.Version',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'major')
    ..aInt64(2, _omitFieldNames ? '' : 'minor')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceInfo_Extension_Version clone() =>
      SourceInfo_Extension_Version()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceInfo_Extension_Version copyWith(
          void Function(SourceInfo_Extension_Version) updates) =>
      super.copyWith(
              (message) => updates(message as SourceInfo_Extension_Version))
          as SourceInfo_Extension_Version;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceInfo_Extension_Version create() =>
      SourceInfo_Extension_Version._();
  SourceInfo_Extension_Version createEmptyInstance() => create();
  static $pb.PbList<SourceInfo_Extension_Version> createRepeated() =>
      $pb.PbList<SourceInfo_Extension_Version>();
  @$core.pragma('dart2js:noInline')
  static SourceInfo_Extension_Version getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceInfo_Extension_Version>(create);
  static SourceInfo_Extension_Version? _defaultInstance;

  /// Major version changes indicate different required support level from
  /// the required components.
  @$pb.TagNumber(1)
  $fixnum.Int64 get major => $_getI64(0);
  @$pb.TagNumber(1)
  set major($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMajor() => $_has(0);
  @$pb.TagNumber(1)
  void clearMajor() => clearField(1);

  /// Minor version changes must not change the observed behavior from
  /// existing implementations, but may be provided informationally.
  @$pb.TagNumber(2)
  $fixnum.Int64 get minor => $_getI64(1);
  @$pb.TagNumber(2)
  set minor($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinor() => clearField(2);
}

/// An extension that was requested for the source expression.
class SourceInfo_Extension extends $pb.GeneratedMessage {
  factory SourceInfo_Extension({
    $core.String? id,
    $core.Iterable<SourceInfo_Extension_Component>? affectedComponents,
    SourceInfo_Extension_Version? version,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (affectedComponents != null) {
      $result.affectedComponents.addAll(affectedComponents);
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  SourceInfo_Extension._() : super();
  factory SourceInfo_Extension.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceInfo_Extension.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceInfo.Extension',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..pc<SourceInfo_Extension_Component>(
        2, _omitFieldNames ? '' : 'affectedComponents', $pb.PbFieldType.KE,
        valueOf: SourceInfo_Extension_Component.valueOf,
        enumValues: SourceInfo_Extension_Component.values,
        defaultEnumValue: SourceInfo_Extension_Component.COMPONENT_UNSPECIFIED)
    ..aOM<SourceInfo_Extension_Version>(3, _omitFieldNames ? '' : 'version',
        subBuilder: SourceInfo_Extension_Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceInfo_Extension clone() =>
      SourceInfo_Extension()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceInfo_Extension copyWith(void Function(SourceInfo_Extension) updates) =>
      super.copyWith((message) => updates(message as SourceInfo_Extension))
          as SourceInfo_Extension;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceInfo_Extension create() => SourceInfo_Extension._();
  SourceInfo_Extension createEmptyInstance() => create();
  static $pb.PbList<SourceInfo_Extension> createRepeated() =>
      $pb.PbList<SourceInfo_Extension>();
  @$core.pragma('dart2js:noInline')
  static SourceInfo_Extension getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceInfo_Extension>(create);
  static SourceInfo_Extension? _defaultInstance;

  /// Identifier for the extension. Example: constant_folding
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  ///  If set, the listed components must understand the extension for the
  ///  expression to evaluate correctly.
  ///
  ///  This field has set semantics, repeated values should be deduplicated.
  @$pb.TagNumber(2)
  $core.List<SourceInfo_Extension_Component> get affectedComponents =>
      $_getList(1);

  /// Version info. May be skipped if it isn't meaningful for the extension.
  /// (for example constant_folding might always be v0.0).
  @$pb.TagNumber(3)
  SourceInfo_Extension_Version get version => $_getN(2);
  @$pb.TagNumber(3)
  set version(SourceInfo_Extension_Version v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => clearField(3);
  @$pb.TagNumber(3)
  SourceInfo_Extension_Version ensureVersion() => $_ensure(2);
}

/// Source information collected at parse time.
class SourceInfo extends $pb.GeneratedMessage {
  factory SourceInfo({
    $core.String? syntaxVersion,
    $core.String? location,
    $core.Iterable<$core.int>? lineOffsets,
    $core.Map<$fixnum.Int64, $core.int>? positions,
    $core.Map<$fixnum.Int64, Expr>? macroCalls,
    $core.Iterable<SourceInfo_Extension>? extensions,
  }) {
    final $result = create();
    if (syntaxVersion != null) {
      $result.syntaxVersion = syntaxVersion;
    }
    if (location != null) {
      $result.location = location;
    }
    if (lineOffsets != null) {
      $result.lineOffsets.addAll(lineOffsets);
    }
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    if (macroCalls != null) {
      $result.macroCalls.addAll(macroCalls);
    }
    if (extensions != null) {
      $result.extensions.addAll(extensions);
    }
    return $result;
  }
  SourceInfo._() : super();
  factory SourceInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourceInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourceInfo',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'syntaxVersion')
    ..aOS(2, _omitFieldNames ? '' : 'location')
    ..p<$core.int>(3, _omitFieldNames ? '' : 'lineOffsets', $pb.PbFieldType.K3)
    ..m<$fixnum.Int64, $core.int>(4, _omitFieldNames ? '' : 'positions',
        entryClassName: 'SourceInfo.PositionsEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('google.api.expr.v1alpha1'))
    ..m<$fixnum.Int64, Expr>(5, _omitFieldNames ? '' : 'macroCalls',
        entryClassName: 'SourceInfo.MacroCallsEntry',
        keyFieldType: $pb.PbFieldType.O6,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: Expr.create,
        valueDefaultOrMaker: Expr.getDefault,
        packageName: const $pb.PackageName('google.api.expr.v1alpha1'))
    ..pc<SourceInfo_Extension>(
        6, _omitFieldNames ? '' : 'extensions', $pb.PbFieldType.PM,
        subBuilder: SourceInfo_Extension.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourceInfo clone() => SourceInfo()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourceInfo copyWith(void Function(SourceInfo) updates) =>
      super.copyWith((message) => updates(message as SourceInfo)) as SourceInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourceInfo create() => SourceInfo._();
  SourceInfo createEmptyInstance() => create();
  static $pb.PbList<SourceInfo> createRepeated() => $pb.PbList<SourceInfo>();
  @$core.pragma('dart2js:noInline')
  static SourceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourceInfo>(create);
  static SourceInfo? _defaultInstance;

  /// The syntax version of the source, e.g. `cel1`.
  @$pb.TagNumber(1)
  $core.String get syntaxVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set syntaxVersion($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSyntaxVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearSyntaxVersion() => clearField(1);

  ///  The location name. All position information attached to an expression is
  ///  relative to this location.
  ///
  ///  The location could be a file, UI element, or similar. For example,
  ///  `acme/app/AnvilPolicy.cel`.
  @$pb.TagNumber(2)
  $core.String get location => $_getSZ(1);
  @$pb.TagNumber(2)
  set location($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => clearField(2);

  ///  Monotonically increasing list of code point offsets where newlines
  ///  `\n` appear.
  ///
  ///  The line number of a given position is the index `i` where for a given
  ///  `id` the `line_offsets[i] < id_positions[id] < line_offsets[i+1]`. The
  ///  column may be derivd from `id_positions[id] - line_offsets[i]`.
  @$pb.TagNumber(3)
  $core.List<$core.int> get lineOffsets => $_getList(2);

  /// A map from the parse node id (e.g. `Expr.id`) to the code point offset
  /// within the source.
  @$pb.TagNumber(4)
  $core.Map<$fixnum.Int64, $core.int> get positions => $_getMap(3);

  ///  A map from the parse node id where a macro replacement was made to the
  ///  call `Expr` that resulted in a macro expansion.
  ///
  ///  For example, `has(value.field)` is a function call that is replaced by a
  ///  `test_only` field selection in the AST. Likewise, the call
  ///  `list.exists(e, e > 10)` translates to a comprehension expression. The key
  ///  in the map corresponds to the expression id of the expanded macro, and the
  ///  value is the call `Expr` that was replaced.
  @$pb.TagNumber(5)
  $core.Map<$fixnum.Int64, Expr> get macroCalls => $_getMap(4);

  ///  A list of tags for extensions that were used while parsing or type checking
  ///  the source expression. For example, optimizations that require special
  ///  runtime support may be specified.
  ///
  ///  These are used to check feature support between components in separate
  ///  implementations. This can be used to either skip redundant work or
  ///  report an error if the extension is unsupported.
  @$pb.TagNumber(6)
  $core.List<SourceInfo_Extension> get extensions => $_getList(5);
}

/// A specific position in source.
class SourcePosition extends $pb.GeneratedMessage {
  factory SourcePosition({
    $core.String? location,
    $core.int? offset,
    $core.int? line,
    $core.int? column,
  }) {
    final $result = create();
    if (location != null) {
      $result.location = location;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    if (line != null) {
      $result.line = line;
    }
    if (column != null) {
      $result.column = column;
    }
    return $result;
  }
  SourcePosition._() : super();
  factory SourcePosition.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SourcePosition.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SourcePosition',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'location')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'line', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'column', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SourcePosition clone() => SourcePosition()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SourcePosition copyWith(void Function(SourcePosition) updates) =>
      super.copyWith((message) => updates(message as SourcePosition))
          as SourcePosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SourcePosition create() => SourcePosition._();
  SourcePosition createEmptyInstance() => create();
  static $pb.PbList<SourcePosition> createRepeated() =>
      $pb.PbList<SourcePosition>();
  @$core.pragma('dart2js:noInline')
  static SourcePosition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SourcePosition>(create);
  static SourcePosition? _defaultInstance;

  /// The soucre location name (e.g. file name).
  @$pb.TagNumber(1)
  $core.String get location => $_getSZ(0);
  @$pb.TagNumber(1)
  set location($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => clearField(1);

  /// The UTF-8 code unit offset.
  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);

  /// The 1-based index of the starting line in the source text
  /// where the issue occurs, or 0 if unknown.
  @$pb.TagNumber(3)
  $core.int get line => $_getIZ(2);
  @$pb.TagNumber(3)
  set line($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLine() => $_has(2);
  @$pb.TagNumber(3)
  void clearLine() => clearField(3);

  /// The 0-based index of the starting position within the line of source text
  /// where the issue occurs.  Only meaningful if line is nonzero.
  @$pb.TagNumber(4)
  $core.int get column => $_getIZ(3);
  @$pb.TagNumber(4)
  set column($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasColumn() => $_has(3);
  @$pb.TagNumber(4)
  void clearColumn() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
