//
//  Generated code. Do not modify.
//  source: google/api/expr/v1beta1/eval.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../rpc/status.pb.dart' as $57;
import 'value.pb.dart' as $106;

/// A single evaluation result.
class EvalState_Result extends $pb.GeneratedMessage {
  factory EvalState_Result({
    IdRef? expr,
    $core.int? value,
  }) {
    final $result = create();
    if (expr != null) {
      $result.expr = expr;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  EvalState_Result._() : super();
  factory EvalState_Result.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EvalState_Result.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EvalState.Result',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..aOM<IdRef>(1, _omitFieldNames ? '' : 'expr', subBuilder: IdRef.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EvalState_Result clone() => EvalState_Result()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EvalState_Result copyWith(void Function(EvalState_Result) updates) =>
      super.copyWith((message) => updates(message as EvalState_Result))
          as EvalState_Result;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EvalState_Result create() => EvalState_Result._();
  EvalState_Result createEmptyInstance() => create();
  static $pb.PbList<EvalState_Result> createRepeated() =>
      $pb.PbList<EvalState_Result>();
  @$core.pragma('dart2js:noInline')
  static EvalState_Result getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EvalState_Result>(create);
  static EvalState_Result? _defaultInstance;

  /// The expression this result is for.
  @$pb.TagNumber(1)
  IdRef get expr => $_getN(0);
  @$pb.TagNumber(1)
  set expr(IdRef v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasExpr() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpr() => clearField(1);
  @$pb.TagNumber(1)
  IdRef ensureExpr() => $_ensure(0);

  /// The index in `values` of the resulting value.
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

///  The state of an evaluation.
///
///  Can represent an initial, partial, or completed state of evaluation.
class EvalState extends $pb.GeneratedMessage {
  factory EvalState({
    $core.Iterable<ExprValue>? values,
    $core.Iterable<EvalState_Result>? results,
  }) {
    final $result = create();
    if (values != null) {
      $result.values.addAll(values);
    }
    if (results != null) {
      $result.results.addAll(results);
    }
    return $result;
  }
  EvalState._() : super();
  factory EvalState.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EvalState.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EvalState',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<ExprValue>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.PM,
        subBuilder: ExprValue.create)
    ..pc<EvalState_Result>(
        3, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: EvalState_Result.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EvalState clone() => EvalState()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EvalState copyWith(void Function(EvalState) updates) =>
      super.copyWith((message) => updates(message as EvalState)) as EvalState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EvalState create() => EvalState._();
  EvalState createEmptyInstance() => create();
  static $pb.PbList<EvalState> createRepeated() => $pb.PbList<EvalState>();
  @$core.pragma('dart2js:noInline')
  static EvalState getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EvalState>(create);
  static EvalState? _defaultInstance;

  /// The unique values referenced in this message.
  @$pb.TagNumber(1)
  $core.List<ExprValue> get values => $_getList(0);

  ///  An ordered list of results.
  ///
  ///  Tracks the flow of evaluation through the expression.
  ///  May be sparse.
  @$pb.TagNumber(3)
  $core.List<EvalState_Result> get results => $_getList(1);
}

enum ExprValue_Kind { value, error, unknown, notSet }

/// The value of an evaluated expression.
class ExprValue extends $pb.GeneratedMessage {
  factory ExprValue({
    $106.Value? value,
    ErrorSet? error,
    UnknownSet? unknown,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (error != null) {
      $result.error = error;
    }
    if (unknown != null) {
      $result.unknown = unknown;
    }
    return $result;
  }
  ExprValue._() : super();
  factory ExprValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExprValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ExprValue_Kind> _ExprValue_KindByTag = {
    1: ExprValue_Kind.value,
    2: ExprValue_Kind.error,
    3: ExprValue_Kind.unknown,
    0: ExprValue_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExprValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<$106.Value>(1, _omitFieldNames ? '' : 'value',
        subBuilder: $106.Value.create)
    ..aOM<ErrorSet>(2, _omitFieldNames ? '' : 'error',
        subBuilder: ErrorSet.create)
    ..aOM<UnknownSet>(3, _omitFieldNames ? '' : 'unknown',
        subBuilder: UnknownSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExprValue clone() => ExprValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExprValue copyWith(void Function(ExprValue) updates) =>
      super.copyWith((message) => updates(message as ExprValue)) as ExprValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExprValue create() => ExprValue._();
  ExprValue createEmptyInstance() => create();
  static $pb.PbList<ExprValue> createRepeated() => $pb.PbList<ExprValue>();
  @$core.pragma('dart2js:noInline')
  static ExprValue getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExprValue>(create);
  static ExprValue? _defaultInstance;

  ExprValue_Kind whichKind() => _ExprValue_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  /// A concrete value.
  @$pb.TagNumber(1)
  $106.Value get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($106.Value v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
  @$pb.TagNumber(1)
  $106.Value ensureValue() => $_ensure(0);

  ///  The set of errors in the critical path of evalution.
  ///
  ///  Only errors in the critical path are included. For example,
  ///  `(<error1> || true) && <error2>` will only result in `<error2>`,
  ///  while `<error1> || <error2>` will result in both `<error1>` and
  ///  `<error2>`.
  ///
  ///  Errors cause by the presence of other errors are not included in the
  ///  set. For example `<error1>.foo`, `foo(<error1>)`, and `<error1> + 1` will
  ///  only result in `<error1>`.
  ///
  ///  Multiple errors *might* be included when evaluation could result
  ///  in different errors. For example `<error1> + <error2>` and
  ///  `foo(<error1>, <error2>)` may result in `<error1>`, `<error2>` or both.
  ///  The exact subset of errors included for this case is unspecified and
  ///  depends on the implementation details of the evaluator.
  @$pb.TagNumber(2)
  ErrorSet get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ErrorSet v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => clearField(2);
  @$pb.TagNumber(2)
  ErrorSet ensureError() => $_ensure(1);

  ///  The set of unknowns in the critical path of evaluation.
  ///
  ///  Unknown behaves identically to Error with regards to propagation.
  ///  Specifically, only unknowns in the critical path are included, unknowns
  ///  caused by the presence of other unknowns are not included, and multiple
  ///  unknowns *might* be included included when evaluation could result in
  ///  different unknowns. For example:
  ///
  ///      (<unknown[1]> || true) && <unknown[2]> -> <unknown[2]>
  ///      <unknown[1]> || <unknown[2]> -> <unknown[1,2]>
  ///      <unknown[1]>.foo -> <unknown[1]>
  ///      foo(<unknown[1]>) -> <unknown[1]>
  ///      <unknown[1]> + <unknown[2]> -> <unknown[1]> or <unknown[2[>
  ///
  ///  Unknown takes precidence over Error in cases where a `Value` can short
  ///  circuit the result:
  ///
  ///      <error> || <unknown> -> <unknown>
  ///      <error> && <unknown> -> <unknown>
  ///
  ///  Errors take precidence in all other cases:
  ///
  ///      <unknown> + <error> -> <error>
  ///      foo(<unknown>, <error>) -> <error>
  @$pb.TagNumber(3)
  UnknownSet get unknown => $_getN(2);
  @$pb.TagNumber(3)
  set unknown(UnknownSet v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUnknown() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnknown() => clearField(3);
  @$pb.TagNumber(3)
  UnknownSet ensureUnknown() => $_ensure(2);
}

///  A set of errors.
///
///  The errors included depend on the context. See `ExprValue.error`.
class ErrorSet extends $pb.GeneratedMessage {
  factory ErrorSet({
    $core.Iterable<$57.Status>? errors,
  }) {
    final $result = create();
    if (errors != null) {
      $result.errors.addAll(errors);
    }
    return $result;
  }
  ErrorSet._() : super();
  factory ErrorSet.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ErrorSet.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ErrorSet',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<$57.Status>(1, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.PM,
        subBuilder: $57.Status.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ErrorSet clone() => ErrorSet()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ErrorSet copyWith(void Function(ErrorSet) updates) =>
      super.copyWith((message) => updates(message as ErrorSet)) as ErrorSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorSet create() => ErrorSet._();
  ErrorSet createEmptyInstance() => create();
  static $pb.PbList<ErrorSet> createRepeated() => $pb.PbList<ErrorSet>();
  @$core.pragma('dart2js:noInline')
  static ErrorSet getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorSet>(create);
  static ErrorSet? _defaultInstance;

  /// The errors in the set.
  @$pb.TagNumber(1)
  $core.List<$57.Status> get errors => $_getList(0);
}

///  A set of expressions for which the value is unknown.
///
///  The unknowns included depend on the context. See `ExprValue.unknown`.
class UnknownSet extends $pb.GeneratedMessage {
  factory UnknownSet({
    $core.Iterable<IdRef>? exprs,
  }) {
    final $result = create();
    if (exprs != null) {
      $result.exprs.addAll(exprs);
    }
    return $result;
  }
  UnknownSet._() : super();
  factory UnknownSet.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UnknownSet.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnknownSet',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..pc<IdRef>(1, _omitFieldNames ? '' : 'exprs', $pb.PbFieldType.PM,
        subBuilder: IdRef.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UnknownSet clone() => UnknownSet()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UnknownSet copyWith(void Function(UnknownSet) updates) =>
      super.copyWith((message) => updates(message as UnknownSet)) as UnknownSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnknownSet create() => UnknownSet._();
  UnknownSet createEmptyInstance() => create();
  static $pb.PbList<UnknownSet> createRepeated() => $pb.PbList<UnknownSet>();
  @$core.pragma('dart2js:noInline')
  static UnknownSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnknownSet>(create);
  static UnknownSet? _defaultInstance;

  /// The ids of the expressions with unknown values.
  @$pb.TagNumber(1)
  $core.List<IdRef> get exprs => $_getList(0);
}

/// A reference to an expression id.
class IdRef extends $pb.GeneratedMessage {
  factory IdRef({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  IdRef._() : super();
  factory IdRef.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory IdRef.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IdRef',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1beta1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  IdRef clone() => IdRef()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  IdRef copyWith(void Function(IdRef) updates) =>
      super.copyWith((message) => updates(message as IdRef)) as IdRef;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdRef create() => IdRef._();
  IdRef createEmptyInstance() => create();
  static $pb.PbList<IdRef> createRepeated() => $pb.PbList<IdRef>();
  @$core.pragma('dart2js:noInline')
  static IdRef getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdRef>(create);
  static IdRef? _defaultInstance;

  /// The expression id.
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
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
