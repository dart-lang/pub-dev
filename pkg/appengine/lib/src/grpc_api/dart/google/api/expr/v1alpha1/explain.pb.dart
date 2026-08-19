//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/explain.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'value.pb.dart' as $101;

/// ID and value index of one step.
class Explain_ExprStep extends $pb.GeneratedMessage {
  factory Explain_ExprStep({
    $fixnum.Int64? id,
    $core.int? valueIndex,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (valueIndex != null) {
      $result.valueIndex = valueIndex;
    }
    return $result;
  }
  Explain_ExprStep._() : super();
  factory Explain_ExprStep.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Explain_ExprStep.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Explain.ExprStep',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'valueIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Explain_ExprStep clone() => Explain_ExprStep()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Explain_ExprStep copyWith(void Function(Explain_ExprStep) updates) =>
      super.copyWith((message) => updates(message as Explain_ExprStep))
          as Explain_ExprStep;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Explain_ExprStep create() => Explain_ExprStep._();
  Explain_ExprStep createEmptyInstance() => create();
  static $pb.PbList<Explain_ExprStep> createRepeated() =>
      $pb.PbList<Explain_ExprStep>();
  @$core.pragma('dart2js:noInline')
  static Explain_ExprStep getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Explain_ExprStep>(create);
  static Explain_ExprStep? _defaultInstance;

  /// ID of corresponding Expr node.
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

  /// Index of the value in the values list.
  @$pb.TagNumber(2)
  $core.int get valueIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set valueIndex($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValueIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearValueIndex() => clearField(2);
}

/// Values of intermediate expressions produced when evaluating expression.
/// Deprecated, use `EvalState` instead.
class Explain extends $pb.GeneratedMessage {
  factory Explain({
    $core.Iterable<$101.Value>? values,
    $core.Iterable<Explain_ExprStep>? exprSteps,
  }) {
    final $result = create();
    if (values != null) {
      $result.values.addAll(values);
    }
    if (exprSteps != null) {
      $result.exprSteps.addAll(exprSteps);
    }
    return $result;
  }
  Explain._() : super();
  factory Explain.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Explain.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Explain',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.expr.v1alpha1'),
      createEmptyInstance: create)
    ..pc<$101.Value>(1, _omitFieldNames ? '' : 'values', $pb.PbFieldType.PM,
        subBuilder: $101.Value.create)
    ..pc<Explain_ExprStep>(
        2, _omitFieldNames ? '' : 'exprSteps', $pb.PbFieldType.PM,
        subBuilder: Explain_ExprStep.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Explain clone() => Explain()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Explain copyWith(void Function(Explain) updates) =>
      super.copyWith((message) => updates(message as Explain)) as Explain;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Explain create() => Explain._();
  Explain createEmptyInstance() => create();
  static $pb.PbList<Explain> createRepeated() => $pb.PbList<Explain>();
  @$core.pragma('dart2js:noInline')
  static Explain getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Explain>(create);
  static Explain? _defaultInstance;

  ///  All of the observed values.
  ///
  ///  The field value_index is an index in the values list.
  ///  Separating values from steps is needed to remove redundant values.
  @$pb.TagNumber(1)
  $core.List<$101.Value> get values => $_getList(0);

  ///  List of steps.
  ///
  ///  Repeated evaluations of the same expression generate new ExprStep
  ///  instances. The order of such ExprStep instances matches the order of
  ///  elements returned by Comprehension.iter_range.
  @$pb.TagNumber(2)
  $core.List<Explain_ExprStep> get exprSteps => $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
