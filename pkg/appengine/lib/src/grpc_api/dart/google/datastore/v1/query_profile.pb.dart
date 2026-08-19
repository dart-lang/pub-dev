//
//  Generated code. Do not modify.
//  source: google/datastore/v1/query_profile.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $51;
import '../../protobuf/struct.pb.dart' as $48;

/// Explain options for the query.
class ExplainOptions extends $pb.GeneratedMessage {
  factory ExplainOptions({
    $core.bool? analyze,
  }) {
    final $result = create();
    if (analyze != null) {
      $result.analyze = analyze;
    }
    return $result;
  }
  ExplainOptions._() : super();
  factory ExplainOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExplainOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExplainOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'analyze')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExplainOptions clone() => ExplainOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExplainOptions copyWith(void Function(ExplainOptions) updates) =>
      super.copyWith((message) => updates(message as ExplainOptions))
          as ExplainOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExplainOptions create() => ExplainOptions._();
  ExplainOptions createEmptyInstance() => create();
  static $pb.PbList<ExplainOptions> createRepeated() =>
      $pb.PbList<ExplainOptions>();
  @$core.pragma('dart2js:noInline')
  static ExplainOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExplainOptions>(create);
  static ExplainOptions? _defaultInstance;

  ///  Optional. Whether to execute this query.
  ///
  ///  When false (the default), the query will be planned, returning only
  ///  metrics from the planning stages.
  ///
  ///  When true, the query will be planned and executed, returning the full
  ///  query results along with both planning and execution stage metrics.
  @$pb.TagNumber(1)
  $core.bool get analyze => $_getBF(0);
  @$pb.TagNumber(1)
  set analyze($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAnalyze() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnalyze() => clearField(1);
}

/// Explain metrics for the query.
class ExplainMetrics extends $pb.GeneratedMessage {
  factory ExplainMetrics({
    PlanSummary? planSummary,
    ExecutionStats? executionStats,
  }) {
    final $result = create();
    if (planSummary != null) {
      $result.planSummary = planSummary;
    }
    if (executionStats != null) {
      $result.executionStats = executionStats;
    }
    return $result;
  }
  ExplainMetrics._() : super();
  factory ExplainMetrics.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExplainMetrics.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExplainMetrics',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<PlanSummary>(1, _omitFieldNames ? '' : 'planSummary',
        subBuilder: PlanSummary.create)
    ..aOM<ExecutionStats>(2, _omitFieldNames ? '' : 'executionStats',
        subBuilder: ExecutionStats.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExplainMetrics clone() => ExplainMetrics()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExplainMetrics copyWith(void Function(ExplainMetrics) updates) =>
      super.copyWith((message) => updates(message as ExplainMetrics))
          as ExplainMetrics;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExplainMetrics create() => ExplainMetrics._();
  ExplainMetrics createEmptyInstance() => create();
  static $pb.PbList<ExplainMetrics> createRepeated() =>
      $pb.PbList<ExplainMetrics>();
  @$core.pragma('dart2js:noInline')
  static ExplainMetrics getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExplainMetrics>(create);
  static ExplainMetrics? _defaultInstance;

  /// Planning phase information for the query.
  @$pb.TagNumber(1)
  PlanSummary get planSummary => $_getN(0);
  @$pb.TagNumber(1)
  set planSummary(PlanSummary v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPlanSummary() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlanSummary() => clearField(1);
  @$pb.TagNumber(1)
  PlanSummary ensurePlanSummary() => $_ensure(0);

  /// Aggregated stats from the execution of the query. Only present when
  /// [ExplainOptions.analyze][google.datastore.v1.ExplainOptions.analyze] is set
  /// to true.
  @$pb.TagNumber(2)
  ExecutionStats get executionStats => $_getN(1);
  @$pb.TagNumber(2)
  set executionStats(ExecutionStats v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasExecutionStats() => $_has(1);
  @$pb.TagNumber(2)
  void clearExecutionStats() => clearField(2);
  @$pb.TagNumber(2)
  ExecutionStats ensureExecutionStats() => $_ensure(1);
}

/// Planning phase information for the query.
class PlanSummary extends $pb.GeneratedMessage {
  factory PlanSummary({
    $core.Iterable<$48.Struct>? indexesUsed,
  }) {
    final $result = create();
    if (indexesUsed != null) {
      $result.indexesUsed.addAll(indexesUsed);
    }
    return $result;
  }
  PlanSummary._() : super();
  factory PlanSummary.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PlanSummary.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlanSummary',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<$48.Struct>(
        1, _omitFieldNames ? '' : 'indexesUsed', $pb.PbFieldType.PM,
        subBuilder: $48.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PlanSummary clone() => PlanSummary()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PlanSummary copyWith(void Function(PlanSummary) updates) =>
      super.copyWith((message) => updates(message as PlanSummary))
          as PlanSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlanSummary create() => PlanSummary._();
  PlanSummary createEmptyInstance() => create();
  static $pb.PbList<PlanSummary> createRepeated() => $pb.PbList<PlanSummary>();
  @$core.pragma('dart2js:noInline')
  static PlanSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlanSummary>(create);
  static PlanSummary? _defaultInstance;

  /// The indexes selected for the query. For example:
  ///  [
  ///    {"query_scope": "Collection", "properties": "(foo ASC, __name__ ASC)"},
  ///    {"query_scope": "Collection", "properties": "(bar ASC, __name__ ASC)"}
  ///  ]
  @$pb.TagNumber(1)
  $core.List<$48.Struct> get indexesUsed => $_getList(0);
}

/// Execution statistics for the query.
class ExecutionStats extends $pb.GeneratedMessage {
  factory ExecutionStats({
    $fixnum.Int64? resultsReturned,
    $51.Duration? executionDuration,
    $fixnum.Int64? readOperations,
    $48.Struct? debugStats,
  }) {
    final $result = create();
    if (resultsReturned != null) {
      $result.resultsReturned = resultsReturned;
    }
    if (executionDuration != null) {
      $result.executionDuration = executionDuration;
    }
    if (readOperations != null) {
      $result.readOperations = readOperations;
    }
    if (debugStats != null) {
      $result.debugStats = debugStats;
    }
    return $result;
  }
  ExecutionStats._() : super();
  factory ExecutionStats.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ExecutionStats.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionStats',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'resultsReturned')
    ..aOM<$51.Duration>(3, _omitFieldNames ? '' : 'executionDuration',
        subBuilder: $51.Duration.create)
    ..aInt64(4, _omitFieldNames ? '' : 'readOperations')
    ..aOM<$48.Struct>(5, _omitFieldNames ? '' : 'debugStats',
        subBuilder: $48.Struct.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ExecutionStats clone() => ExecutionStats()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ExecutionStats copyWith(void Function(ExecutionStats) updates) =>
      super.copyWith((message) => updates(message as ExecutionStats))
          as ExecutionStats;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionStats create() => ExecutionStats._();
  ExecutionStats createEmptyInstance() => create();
  static $pb.PbList<ExecutionStats> createRepeated() =>
      $pb.PbList<ExecutionStats>();
  @$core.pragma('dart2js:noInline')
  static ExecutionStats getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionStats>(create);
  static ExecutionStats? _defaultInstance;

  /// Total number of results returned, including documents, projections,
  /// aggregation results, keys.
  @$pb.TagNumber(1)
  $fixnum.Int64 get resultsReturned => $_getI64(0);
  @$pb.TagNumber(1)
  set resultsReturned($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResultsReturned() => $_has(0);
  @$pb.TagNumber(1)
  void clearResultsReturned() => clearField(1);

  /// Total time to execute the query in the backend.
  @$pb.TagNumber(3)
  $51.Duration get executionDuration => $_getN(1);
  @$pb.TagNumber(3)
  set executionDuration($51.Duration v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExecutionDuration() => $_has(1);
  @$pb.TagNumber(3)
  void clearExecutionDuration() => clearField(3);
  @$pb.TagNumber(3)
  $51.Duration ensureExecutionDuration() => $_ensure(1);

  /// Total billable read operations.
  @$pb.TagNumber(4)
  $fixnum.Int64 get readOperations => $_getI64(2);
  @$pb.TagNumber(4)
  set readOperations($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasReadOperations() => $_has(2);
  @$pb.TagNumber(4)
  void clearReadOperations() => clearField(4);

  /// Debugging statistics from the execution of the query. Note that the
  /// debugging stats are subject to change as Firestore evolves. It could
  /// include:
  ///  {
  ///    "indexes_entries_scanned": "1000",
  ///    "documents_scanned": "20",
  ///    "billing_details" : {
  ///       "documents_billable": "20",
  ///       "index_entries_billable": "1000",
  ///       "min_query_cost": "0"
  ///    }
  ///  }
  @$pb.TagNumber(5)
  $48.Struct get debugStats => $_getN(3);
  @$pb.TagNumber(5)
  set debugStats($48.Struct v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDebugStats() => $_has(3);
  @$pb.TagNumber(5)
  void clearDebugStats() => clearField(5);
  @$pb.TagNumber(5)
  $48.Struct ensureDebugStats() => $_ensure(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
