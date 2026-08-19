//
//  Generated code. Do not modify.
//  source: google/datastore/v1/aggregation_result.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;
import 'entity.pb.dart' as $72;
import 'query.pbenum.dart' as $74;

///  The result of a single bucket from a Datastore aggregation query.
///
///  The keys of `aggregate_properties` are the same for all results in an
///  aggregation query, unlike entity queries which can have different fields
///  present for each result.
class AggregationResult extends $pb.GeneratedMessage {
  factory AggregationResult({
    $core.Map<$core.String, $72.Value>? aggregateProperties,
  }) {
    final $result = create();
    if (aggregateProperties != null) {
      $result.aggregateProperties.addAll(aggregateProperties);
    }
    return $result;
  }
  AggregationResult._() : super();
  factory AggregationResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AggregationResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AggregationResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..m<$core.String, $72.Value>(
        2, _omitFieldNames ? '' : 'aggregateProperties',
        entryClassName: 'AggregationResult.AggregatePropertiesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OM,
        valueCreator: $72.Value.create,
        valueDefaultOrMaker: $72.Value.getDefault,
        packageName: const $pb.PackageName('google.datastore.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AggregationResult clone() => AggregationResult()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AggregationResult copyWith(void Function(AggregationResult) updates) =>
      super.copyWith((message) => updates(message as AggregationResult))
          as AggregationResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AggregationResult create() => AggregationResult._();
  AggregationResult createEmptyInstance() => create();
  static $pb.PbList<AggregationResult> createRepeated() =>
      $pb.PbList<AggregationResult>();
  @$core.pragma('dart2js:noInline')
  static AggregationResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AggregationResult>(create);
  static AggregationResult? _defaultInstance;

  ///  The result of the aggregation functions, ex: `COUNT(*) AS total_entities`.
  ///
  ///  The key is the
  ///  [alias][google.datastore.v1.AggregationQuery.Aggregation.alias] assigned to
  ///  the aggregation function on input and the size of this map equals the
  ///  number of aggregation functions in the query.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $72.Value> get aggregateProperties => $_getMap(0);
}

/// A batch of aggregation results produced by an aggregation query.
class AggregationResultBatch extends $pb.GeneratedMessage {
  factory AggregationResultBatch({
    $core.Iterable<AggregationResult>? aggregationResults,
    $74.QueryResultBatch_MoreResultsType? moreResults,
    $50.Timestamp? readTime,
  }) {
    final $result = create();
    if (aggregationResults != null) {
      $result.aggregationResults.addAll(aggregationResults);
    }
    if (moreResults != null) {
      $result.moreResults = moreResults;
    }
    if (readTime != null) {
      $result.readTime = readTime;
    }
    return $result;
  }
  AggregationResultBatch._() : super();
  factory AggregationResultBatch.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AggregationResultBatch.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AggregationResultBatch',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<AggregationResult>(
        1, _omitFieldNames ? '' : 'aggregationResults', $pb.PbFieldType.PM,
        subBuilder: AggregationResult.create)
    ..e<$74.QueryResultBatch_MoreResultsType>(
        2, _omitFieldNames ? '' : 'moreResults', $pb.PbFieldType.OE,
        defaultOrMaker:
            $74.QueryResultBatch_MoreResultsType.MORE_RESULTS_TYPE_UNSPECIFIED,
        valueOf: $74.QueryResultBatch_MoreResultsType.valueOf,
        enumValues: $74.QueryResultBatch_MoreResultsType.values)
    ..aOM<$50.Timestamp>(3, _omitFieldNames ? '' : 'readTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AggregationResultBatch clone() =>
      AggregationResultBatch()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AggregationResultBatch copyWith(
          void Function(AggregationResultBatch) updates) =>
      super.copyWith((message) => updates(message as AggregationResultBatch))
          as AggregationResultBatch;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AggregationResultBatch create() => AggregationResultBatch._();
  AggregationResultBatch createEmptyInstance() => create();
  static $pb.PbList<AggregationResultBatch> createRepeated() =>
      $pb.PbList<AggregationResultBatch>();
  @$core.pragma('dart2js:noInline')
  static AggregationResultBatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AggregationResultBatch>(create);
  static AggregationResultBatch? _defaultInstance;

  /// The aggregation results for this batch.
  @$pb.TagNumber(1)
  $core.List<AggregationResult> get aggregationResults => $_getList(0);

  /// The state of the query after the current batch.
  /// Only COUNT(*) aggregations are supported in the initial launch. Therefore,
  /// expected result type is limited to `NO_MORE_RESULTS`.
  @$pb.TagNumber(2)
  $74.QueryResultBatch_MoreResultsType get moreResults => $_getN(1);
  @$pb.TagNumber(2)
  set moreResults($74.QueryResultBatch_MoreResultsType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMoreResults() => $_has(1);
  @$pb.TagNumber(2)
  void clearMoreResults() => clearField(2);

  ///  Read timestamp this batch was returned from.
  ///
  ///  In a single transaction, subsequent query result batches for the same query
  ///  can have a greater timestamp. Each batch's read timestamp
  ///  is valid for all preceding batches.
  @$pb.TagNumber(3)
  $50.Timestamp get readTime => $_getN(2);
  @$pb.TagNumber(3)
  set readTime($50.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasReadTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearReadTime() => clearField(3);
  @$pb.TagNumber(3)
  $50.Timestamp ensureReadTime() => $_ensure(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
