//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/expr.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/struct.pbenum.dart' as $48;
import 'source.pb.dart' as $104;

/// An expression together with source information as returned by the parser.
class ParsedExpr extends $pb.GeneratedMessage {
  factory ParsedExpr({
    Expr? expr,
    $104.SourceInfo? sourceInfo,
    $core.String? syntaxVersion,
  }) {
    final $result = create();
    if (expr != null) {
      $result.expr = expr;
    }
    if (sourceInfo != null) {
      $result.sourceInfo = sourceInfo;
    }
    if (syntaxVersion != null) {
      $result.syntaxVersion = syntaxVersion;
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOM<Expr>(2, _omitFieldNames ? '' : 'expr', subBuilder: Expr.create)
    ..aOM<$104.SourceInfo>(3, _omitFieldNames ? '' : 'sourceInfo',
        subBuilder: $104.SourceInfo.create)
    ..aOS(4, _omitFieldNames ? '' : 'syntaxVersion')
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
  $104.SourceInfo get sourceInfo => $_getN(1);
  @$pb.TagNumber(3)
  set sourceInfo($104.SourceInfo v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSourceInfo() => $_has(1);
  @$pb.TagNumber(3)
  void clearSourceInfo() => clearField(3);
  @$pb.TagNumber(3)
  $104.SourceInfo ensureSourceInfo() => $_ensure(1);

  /// The syntax version of the source, e.g. `cel1`.
  @$pb.TagNumber(4)
  $core.String get syntaxVersion => $_getSZ(2);
  @$pb.TagNumber(4)
  set syntaxVersion($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSyntaxVersion() => $_has(2);
  @$pb.TagNumber(4)
  void clearSyntaxVersion() => clearField(4);
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
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
  ///  Qualified names are represented by the [Expr.Select][google.api.expr.v1beta1.Expr.Select] expression.
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
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
///  Lists may either be homogenous, e.g. `[1, 2, 3]`, or heterogenous, e.g.
///  `dyn([1, 'hello', 2.0])`
class Expr_CreateList extends $pb.GeneratedMessage {
  factory Expr_CreateList({
    $core.Iterable<Expr>? elements,
  }) {
    final $result = create();
    if (elements != null) {
      $result.elements.addAll(elements);
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<Expr>(1, _omitFieldNames ? '' : 'elements', $pb.PbFieldType.PM,
        subBuilder: Expr.create)
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
}

enum Expr_CreateStruct_Entry_KeyKind { fieldKey, mapKey, notSet }

/// Represents an entry.
class Expr_CreateStruct_Entry extends $pb.GeneratedMessage {
  factory Expr_CreateStruct_Entry({
    $core.int? id,
    $core.String? fieldKey,
    Expr? mapKey,
    Expr? value,
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'fieldKey')
    ..aOM<Expr>(3, _omitFieldNames ? '' : 'mapKey', subBuilder: Expr.create)
    ..aOM<Expr>(4, _omitFieldNames ? '' : 'value', subBuilder: Expr.create)
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
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setSignedInt32(0, v);
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

  /// Required. The value assigned to the key.
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
}

///  A map or message creation expression.
///
///  Maps are constructed as `{'key_name': 'value'}`. Message construction is
///  similar, but prefixed with a type name and composed of field ids:
///  `types.MyType{field_id: 'value'}`.
class Expr_CreateStruct extends $pb.GeneratedMessage {
  factory Expr_CreateStruct({
    $core.String? type,
    $core.Iterable<Expr_CreateStruct_Entry>? entries,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'type')
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
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

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
class Expr_Comprehension extends $pb.GeneratedMessage {
  factory Expr_Comprehension({
    $core.String? iterVar,
    Expr? iterRange,
    $core.String? accuVar,
    Expr? accuInit,
    Expr? loopCondition,
    Expr? loopStep,
    Expr? result,
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iterVar')
    ..aOM<Expr>(2, _omitFieldNames ? '' : 'iterRange', subBuilder: Expr.create)
    ..aOS(3, _omitFieldNames ? '' : 'accuVar')
    ..aOM<Expr>(4, _omitFieldNames ? '' : 'accuInit', subBuilder: Expr.create)
    ..aOM<Expr>(5, _omitFieldNames ? '' : 'loopCondition',
        subBuilder: Expr.create)
    ..aOM<Expr>(6, _omitFieldNames ? '' : 'loopStep', subBuilder: Expr.create)
    ..aOM<Expr>(7, _omitFieldNames ? '' : 'result', subBuilder: Expr.create)
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

  /// The name of the iteration variable.
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

  /// The range over which var iterates.
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

  ///  An expression which can contain iter_var and accu_var.
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

  ///  An expression which can contain iter_var and accu_var.
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
}

enum Expr_ExprKind {
  literalExpr,
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
///  All references within expressions must resolve to a [Decl][google.api.expr.v1beta1.Decl] provided at
///  type-check for an expression to be valid. A reference may either be a bare
///  identifier `name` or a qualified identifier `google.api.name`. References
///  may either refer to a value or a function declaration.
///
///  For example, the expression `google.api.name.startsWith('expr')` references
///  the declaration `google.api.name` within a [Expr.Select][google.api.expr.v1beta1.Expr.Select] expression, and
///  the function declaration `startsWith`.
class Expr extends $pb.GeneratedMessage {
  factory Expr({
    $core.int? id,
    Literal? literalExpr,
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
    if (literalExpr != null) {
      $result.literalExpr = literalExpr;
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
    3: Expr_ExprKind.literalExpr,
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
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7, 8, 9])
    ..a<$core.int>(2, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOM<Literal>(3, _omitFieldNames ? '' : 'literalExpr',
        subBuilder: Literal.create)
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
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(2)
  set id($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// A literal expression.
  @$pb.TagNumber(3)
  Literal get literalExpr => $_getN(1);
  @$pb.TagNumber(3)
  set literalExpr(Literal v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasLiteralExpr() => $_has(1);
  @$pb.TagNumber(3)
  void clearLiteralExpr() => clearField(3);
  @$pb.TagNumber(3)
  Literal ensureLiteralExpr() => $_ensure(1);

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

  /// A map or object creation expression.
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

enum Literal_ConstantKind {
  nullValue,
  boolValue,
  int64Value,
  uint64Value,
  doubleValue,
  stringValue,
  bytesValue,
  notSet
}

///  Represents a primitive literal.
///
///  This is similar to the primitives supported in the well-known type
///  `google.protobuf.Value`, but richer so it can represent CEL's full range of
///  primitives.
///
///  Lists and structs are not included as constants as these aggregate types may
///  contain [Expr][google.api.expr.v1beta1.Expr] elements which require evaluation and are thus not constant.
///
///  Examples of literals include: `"hello"`, `b'bytes'`, `1u`, `4.2`, `-2`,
///  `true`, `null`.
class Literal extends $pb.GeneratedMessage {
  factory Literal({
    $48.NullValue? nullValue,
    $core.bool? boolValue,
    $fixnum.Int64? int64Value,
    $fixnum.Int64? uint64Value,
    $core.double? doubleValue,
    $core.String? stringValue,
    $core.List<$core.int>? bytesValue,
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
    return $result;
  }
  Literal._() : super();
  factory Literal.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Literal.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Literal_ConstantKind>
      _Literal_ConstantKindByTag = {
    1: Literal_ConstantKind.nullValue,
    2: Literal_ConstantKind.boolValue,
    3: Literal_ConstantKind.int64Value,
    4: Literal_ConstantKind.uint64Value,
    5: Literal_ConstantKind.doubleValue,
    6: Literal_ConstantKind.stringValue,
    7: Literal_ConstantKind.bytesValue,
    0: Literal_ConstantKind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Literal',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
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
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Literal clone() => Literal()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Literal copyWith(void Function(Literal) updates) =>
      super.copyWith((message) => updates(message as Literal)) as Literal;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Literal create() => Literal._();
  Literal createEmptyInstance() => create();
  static $pb.PbList<Literal> createRepeated() => $pb.PbList<Literal>();
  @$core.pragma('dart2js:noInline')
  static Literal getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Literal>(create);
  static Literal? _defaultInstance;

  Literal_ConstantKind whichConstantKind() =>
      _Literal_ConstantKindByTag[$_whichOneof(0)]!;
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
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
