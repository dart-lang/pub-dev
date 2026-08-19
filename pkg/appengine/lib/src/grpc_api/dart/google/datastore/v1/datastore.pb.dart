//
//  Generated code. Do not modify.
//  source: google/datastore/v1/datastore.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;
import 'aggregation_result.pb.dart' as $76;
import 'datastore.pbenum.dart';
import 'entity.pb.dart' as $72;
import 'query.pb.dart' as $74;
import 'query_profile.pb.dart' as $75;

export 'datastore.pbenum.dart';

/// The request for [Datastore.Lookup][google.datastore.v1.Datastore.Lookup].
class LookupRequest extends $pb.GeneratedMessage {
  factory LookupRequest({
    ReadOptions? readOptions,
    $core.Iterable<$72.Key>? keys,
    PropertyMask? propertyMask,
    $core.String? projectId,
    $core.String? databaseId,
  }) {
    final $result = create();
    if (readOptions != null) {
      $result.readOptions = readOptions;
    }
    if (keys != null) {
      $result.keys.addAll(keys);
    }
    if (propertyMask != null) {
      $result.propertyMask = propertyMask;
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    return $result;
  }
  LookupRequest._() : super();
  factory LookupRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LookupRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<ReadOptions>(1, _omitFieldNames ? '' : 'readOptions',
        subBuilder: ReadOptions.create)
    ..pc<$72.Key>(3, _omitFieldNames ? '' : 'keys', $pb.PbFieldType.PM,
        subBuilder: $72.Key.create)
    ..aOM<PropertyMask>(5, _omitFieldNames ? '' : 'propertyMask',
        subBuilder: PropertyMask.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LookupRequest clone() => LookupRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LookupRequest copyWith(void Function(LookupRequest) updates) =>
      super.copyWith((message) => updates(message as LookupRequest))
          as LookupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupRequest create() => LookupRequest._();
  LookupRequest createEmptyInstance() => create();
  static $pb.PbList<LookupRequest> createRepeated() =>
      $pb.PbList<LookupRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupRequest>(create);
  static LookupRequest? _defaultInstance;

  /// The options for this lookup request.
  @$pb.TagNumber(1)
  ReadOptions get readOptions => $_getN(0);
  @$pb.TagNumber(1)
  set readOptions(ReadOptions v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadOptions() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadOptions() => clearField(1);
  @$pb.TagNumber(1)
  ReadOptions ensureReadOptions() => $_ensure(0);

  /// Required. Keys of entities to look up.
  @$pb.TagNumber(3)
  $core.List<$72.Key> get keys => $_getList(1);

  ///  The properties to return. Defaults to returning all properties.
  ///
  ///  If this field is set and an entity has a property not referenced in the
  ///  mask, it will be absent from [LookupResponse.found.entity.properties][].
  ///
  ///  The entity's key is always returned.
  @$pb.TagNumber(5)
  PropertyMask get propertyMask => $_getN(2);
  @$pb.TagNumber(5)
  set propertyMask(PropertyMask v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPropertyMask() => $_has(2);
  @$pb.TagNumber(5)
  void clearPropertyMask() => clearField(5);
  @$pb.TagNumber(5)
  PropertyMask ensurePropertyMask() => $_ensure(2);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(3);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(3);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(4);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(4);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);
}

/// The response for [Datastore.Lookup][google.datastore.v1.Datastore.Lookup].
class LookupResponse extends $pb.GeneratedMessage {
  factory LookupResponse({
    $core.Iterable<$74.EntityResult>? found,
    $core.Iterable<$74.EntityResult>? missing,
    $core.Iterable<$72.Key>? deferred,
    $core.List<$core.int>? transaction,
    $50.Timestamp? readTime,
  }) {
    final $result = create();
    if (found != null) {
      $result.found.addAll(found);
    }
    if (missing != null) {
      $result.missing.addAll(missing);
    }
    if (deferred != null) {
      $result.deferred.addAll(deferred);
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (readTime != null) {
      $result.readTime = readTime;
    }
    return $result;
  }
  LookupResponse._() : super();
  factory LookupResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LookupResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<$74.EntityResult>(
        1, _omitFieldNames ? '' : 'found', $pb.PbFieldType.PM,
        subBuilder: $74.EntityResult.create)
    ..pc<$74.EntityResult>(
        2, _omitFieldNames ? '' : 'missing', $pb.PbFieldType.PM,
        subBuilder: $74.EntityResult.create)
    ..pc<$72.Key>(3, _omitFieldNames ? '' : 'deferred', $pb.PbFieldType.PM,
        subBuilder: $72.Key.create)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..aOM<$50.Timestamp>(7, _omitFieldNames ? '' : 'readTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LookupResponse clone() => LookupResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LookupResponse copyWith(void Function(LookupResponse) updates) =>
      super.copyWith((message) => updates(message as LookupResponse))
          as LookupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupResponse create() => LookupResponse._();
  LookupResponse createEmptyInstance() => create();
  static $pb.PbList<LookupResponse> createRepeated() =>
      $pb.PbList<LookupResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupResponse>(create);
  static LookupResponse? _defaultInstance;

  /// Entities found as `ResultType.FULL` entities. The order of results in this
  /// field is undefined and has no relation to the order of the keys in the
  /// input.
  @$pb.TagNumber(1)
  $core.List<$74.EntityResult> get found => $_getList(0);

  /// Entities not found as `ResultType.KEY_ONLY` entities. The order of results
  /// in this field is undefined and has no relation to the order of the keys
  /// in the input.
  @$pb.TagNumber(2)
  $core.List<$74.EntityResult> get missing => $_getList(1);

  /// A list of keys that were not looked up due to resource constraints. The
  /// order of results in this field is undefined and has no relation to the
  /// order of the keys in the input.
  @$pb.TagNumber(3)
  $core.List<$72.Key> get deferred => $_getList(2);

  ///  The identifier of the transaction that was started as part of this Lookup
  ///  request.
  ///
  ///  Set only when
  ///  [ReadOptions.new_transaction][google.datastore.v1.ReadOptions.new_transaction]
  ///  was set in
  ///  [LookupRequest.read_options][google.datastore.v1.LookupRequest.read_options].
  @$pb.TagNumber(5)
  $core.List<$core.int> get transaction => $_getN(3);
  @$pb.TagNumber(5)
  set transaction($core.List<$core.int> v) {
    $_setBytes(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTransaction() => $_has(3);
  @$pb.TagNumber(5)
  void clearTransaction() => clearField(5);

  /// The time at which these entities were read or found missing.
  @$pb.TagNumber(7)
  $50.Timestamp get readTime => $_getN(4);
  @$pb.TagNumber(7)
  set readTime($50.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasReadTime() => $_has(4);
  @$pb.TagNumber(7)
  void clearReadTime() => clearField(7);
  @$pb.TagNumber(7)
  $50.Timestamp ensureReadTime() => $_ensure(4);
}

enum RunQueryRequest_QueryType { query, gqlQuery, notSet }

/// The request for [Datastore.RunQuery][google.datastore.v1.Datastore.RunQuery].
class RunQueryRequest extends $pb.GeneratedMessage {
  factory RunQueryRequest({
    ReadOptions? readOptions,
    $72.PartitionId? partitionId,
    $74.Query? query,
    $74.GqlQuery? gqlQuery,
    $core.String? projectId,
    $core.String? databaseId,
    PropertyMask? propertyMask,
    $75.ExplainOptions? explainOptions,
  }) {
    final $result = create();
    if (readOptions != null) {
      $result.readOptions = readOptions;
    }
    if (partitionId != null) {
      $result.partitionId = partitionId;
    }
    if (query != null) {
      $result.query = query;
    }
    if (gqlQuery != null) {
      $result.gqlQuery = gqlQuery;
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    if (propertyMask != null) {
      $result.propertyMask = propertyMask;
    }
    if (explainOptions != null) {
      $result.explainOptions = explainOptions;
    }
    return $result;
  }
  RunQueryRequest._() : super();
  factory RunQueryRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RunQueryRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RunQueryRequest_QueryType>
      _RunQueryRequest_QueryTypeByTag = {
    3: RunQueryRequest_QueryType.query,
    7: RunQueryRequest_QueryType.gqlQuery,
    0: RunQueryRequest_QueryType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunQueryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 7])
    ..aOM<ReadOptions>(1, _omitFieldNames ? '' : 'readOptions',
        subBuilder: ReadOptions.create)
    ..aOM<$72.PartitionId>(2, _omitFieldNames ? '' : 'partitionId',
        subBuilder: $72.PartitionId.create)
    ..aOM<$74.Query>(3, _omitFieldNames ? '' : 'query',
        subBuilder: $74.Query.create)
    ..aOM<$74.GqlQuery>(7, _omitFieldNames ? '' : 'gqlQuery',
        subBuilder: $74.GqlQuery.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..aOM<PropertyMask>(10, _omitFieldNames ? '' : 'propertyMask',
        subBuilder: PropertyMask.create)
    ..aOM<$75.ExplainOptions>(12, _omitFieldNames ? '' : 'explainOptions',
        subBuilder: $75.ExplainOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RunQueryRequest clone() => RunQueryRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RunQueryRequest copyWith(void Function(RunQueryRequest) updates) =>
      super.copyWith((message) => updates(message as RunQueryRequest))
          as RunQueryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunQueryRequest create() => RunQueryRequest._();
  RunQueryRequest createEmptyInstance() => create();
  static $pb.PbList<RunQueryRequest> createRepeated() =>
      $pb.PbList<RunQueryRequest>();
  @$core.pragma('dart2js:noInline')
  static RunQueryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunQueryRequest>(create);
  static RunQueryRequest? _defaultInstance;

  RunQueryRequest_QueryType whichQueryType() =>
      _RunQueryRequest_QueryTypeByTag[$_whichOneof(0)]!;
  void clearQueryType() => clearField($_whichOneof(0));

  /// The options for this query.
  @$pb.TagNumber(1)
  ReadOptions get readOptions => $_getN(0);
  @$pb.TagNumber(1)
  set readOptions(ReadOptions v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadOptions() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadOptions() => clearField(1);
  @$pb.TagNumber(1)
  ReadOptions ensureReadOptions() => $_ensure(0);

  /// Entities are partitioned into subsets, identified by a partition ID.
  /// Queries are scoped to a single partition.
  /// This partition ID is normalized with the standard default context
  /// partition ID.
  @$pb.TagNumber(2)
  $72.PartitionId get partitionId => $_getN(1);
  @$pb.TagNumber(2)
  set partitionId($72.PartitionId v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPartitionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPartitionId() => clearField(2);
  @$pb.TagNumber(2)
  $72.PartitionId ensurePartitionId() => $_ensure(1);

  /// The query to run.
  @$pb.TagNumber(3)
  $74.Query get query => $_getN(2);
  @$pb.TagNumber(3)
  set query($74.Query v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => clearField(3);
  @$pb.TagNumber(3)
  $74.Query ensureQuery() => $_ensure(2);

  /// The GQL query to run. This query must be a non-aggregation query.
  @$pb.TagNumber(7)
  $74.GqlQuery get gqlQuery => $_getN(3);
  @$pb.TagNumber(7)
  set gqlQuery($74.GqlQuery v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasGqlQuery() => $_has(3);
  @$pb.TagNumber(7)
  void clearGqlQuery() => clearField(7);
  @$pb.TagNumber(7)
  $74.GqlQuery ensureGqlQuery() => $_ensure(3);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(4);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(4);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(5);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(5);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);

  ///  The properties to return.
  ///  This field must not be set for a projection query.
  ///
  ///  See
  ///  [LookupRequest.property_mask][google.datastore.v1.LookupRequest.property_mask].
  @$pb.TagNumber(10)
  PropertyMask get propertyMask => $_getN(6);
  @$pb.TagNumber(10)
  set propertyMask(PropertyMask v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasPropertyMask() => $_has(6);
  @$pb.TagNumber(10)
  void clearPropertyMask() => clearField(10);
  @$pb.TagNumber(10)
  PropertyMask ensurePropertyMask() => $_ensure(6);

  /// Optional. Explain options for the query. If set, additional query
  /// statistics will be returned. If not, only query results will be returned.
  @$pb.TagNumber(12)
  $75.ExplainOptions get explainOptions => $_getN(7);
  @$pb.TagNumber(12)
  set explainOptions($75.ExplainOptions v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasExplainOptions() => $_has(7);
  @$pb.TagNumber(12)
  void clearExplainOptions() => clearField(12);
  @$pb.TagNumber(12)
  $75.ExplainOptions ensureExplainOptions() => $_ensure(7);
}

/// The response for
/// [Datastore.RunQuery][google.datastore.v1.Datastore.RunQuery].
class RunQueryResponse extends $pb.GeneratedMessage {
  factory RunQueryResponse({
    $74.QueryResultBatch? batch,
    $74.Query? query,
    $core.List<$core.int>? transaction,
    $75.ExplainMetrics? explainMetrics,
  }) {
    final $result = create();
    if (batch != null) {
      $result.batch = batch;
    }
    if (query != null) {
      $result.query = query;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (explainMetrics != null) {
      $result.explainMetrics = explainMetrics;
    }
    return $result;
  }
  RunQueryResponse._() : super();
  factory RunQueryResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RunQueryResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunQueryResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<$74.QueryResultBatch>(1, _omitFieldNames ? '' : 'batch',
        subBuilder: $74.QueryResultBatch.create)
    ..aOM<$74.Query>(2, _omitFieldNames ? '' : 'query',
        subBuilder: $74.Query.create)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..aOM<$75.ExplainMetrics>(9, _omitFieldNames ? '' : 'explainMetrics',
        subBuilder: $75.ExplainMetrics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RunQueryResponse clone() => RunQueryResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RunQueryResponse copyWith(void Function(RunQueryResponse) updates) =>
      super.copyWith((message) => updates(message as RunQueryResponse))
          as RunQueryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunQueryResponse create() => RunQueryResponse._();
  RunQueryResponse createEmptyInstance() => create();
  static $pb.PbList<RunQueryResponse> createRepeated() =>
      $pb.PbList<RunQueryResponse>();
  @$core.pragma('dart2js:noInline')
  static RunQueryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunQueryResponse>(create);
  static RunQueryResponse? _defaultInstance;

  /// A batch of query results (always present).
  @$pb.TagNumber(1)
  $74.QueryResultBatch get batch => $_getN(0);
  @$pb.TagNumber(1)
  set batch($74.QueryResultBatch v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBatch() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatch() => clearField(1);
  @$pb.TagNumber(1)
  $74.QueryResultBatch ensureBatch() => $_ensure(0);

  /// The parsed form of the `GqlQuery` from the request, if it was set.
  @$pb.TagNumber(2)
  $74.Query get query => $_getN(1);
  @$pb.TagNumber(2)
  set query($74.Query v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);
  @$pb.TagNumber(2)
  $74.Query ensureQuery() => $_ensure(1);

  ///  The identifier of the transaction that was started as part of this
  ///  RunQuery request.
  ///
  ///  Set only when
  ///  [ReadOptions.new_transaction][google.datastore.v1.ReadOptions.new_transaction]
  ///  was set in
  ///  [RunQueryRequest.read_options][google.datastore.v1.RunQueryRequest.read_options].
  @$pb.TagNumber(5)
  $core.List<$core.int> get transaction => $_getN(2);
  @$pb.TagNumber(5)
  set transaction($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(5)
  void clearTransaction() => clearField(5);

  /// Query explain metrics. This is only present when the
  /// [RunQueryRequest.explain_options][google.datastore.v1.RunQueryRequest.explain_options]
  /// is provided, and it is sent only once with the last response in the stream.
  @$pb.TagNumber(9)
  $75.ExplainMetrics get explainMetrics => $_getN(3);
  @$pb.TagNumber(9)
  set explainMetrics($75.ExplainMetrics v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasExplainMetrics() => $_has(3);
  @$pb.TagNumber(9)
  void clearExplainMetrics() => clearField(9);
  @$pb.TagNumber(9)
  $75.ExplainMetrics ensureExplainMetrics() => $_ensure(3);
}

enum RunAggregationQueryRequest_QueryType { aggregationQuery, gqlQuery, notSet }

/// The request for
/// [Datastore.RunAggregationQuery][google.datastore.v1.Datastore.RunAggregationQuery].
class RunAggregationQueryRequest extends $pb.GeneratedMessage {
  factory RunAggregationQueryRequest({
    ReadOptions? readOptions,
    $72.PartitionId? partitionId,
    $74.AggregationQuery? aggregationQuery,
    $74.GqlQuery? gqlQuery,
    $core.String? projectId,
    $core.String? databaseId,
    $75.ExplainOptions? explainOptions,
  }) {
    final $result = create();
    if (readOptions != null) {
      $result.readOptions = readOptions;
    }
    if (partitionId != null) {
      $result.partitionId = partitionId;
    }
    if (aggregationQuery != null) {
      $result.aggregationQuery = aggregationQuery;
    }
    if (gqlQuery != null) {
      $result.gqlQuery = gqlQuery;
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    if (explainOptions != null) {
      $result.explainOptions = explainOptions;
    }
    return $result;
  }
  RunAggregationQueryRequest._() : super();
  factory RunAggregationQueryRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RunAggregationQueryRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RunAggregationQueryRequest_QueryType>
      _RunAggregationQueryRequest_QueryTypeByTag = {
    3: RunAggregationQueryRequest_QueryType.aggregationQuery,
    7: RunAggregationQueryRequest_QueryType.gqlQuery,
    0: RunAggregationQueryRequest_QueryType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunAggregationQueryRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [3, 7])
    ..aOM<ReadOptions>(1, _omitFieldNames ? '' : 'readOptions',
        subBuilder: ReadOptions.create)
    ..aOM<$72.PartitionId>(2, _omitFieldNames ? '' : 'partitionId',
        subBuilder: $72.PartitionId.create)
    ..aOM<$74.AggregationQuery>(3, _omitFieldNames ? '' : 'aggregationQuery',
        subBuilder: $74.AggregationQuery.create)
    ..aOM<$74.GqlQuery>(7, _omitFieldNames ? '' : 'gqlQuery',
        subBuilder: $74.GqlQuery.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..aOM<$75.ExplainOptions>(11, _omitFieldNames ? '' : 'explainOptions',
        subBuilder: $75.ExplainOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RunAggregationQueryRequest clone() =>
      RunAggregationQueryRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RunAggregationQueryRequest copyWith(
          void Function(RunAggregationQueryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RunAggregationQueryRequest))
          as RunAggregationQueryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunAggregationQueryRequest create() => RunAggregationQueryRequest._();
  RunAggregationQueryRequest createEmptyInstance() => create();
  static $pb.PbList<RunAggregationQueryRequest> createRepeated() =>
      $pb.PbList<RunAggregationQueryRequest>();
  @$core.pragma('dart2js:noInline')
  static RunAggregationQueryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunAggregationQueryRequest>(create);
  static RunAggregationQueryRequest? _defaultInstance;

  RunAggregationQueryRequest_QueryType whichQueryType() =>
      _RunAggregationQueryRequest_QueryTypeByTag[$_whichOneof(0)]!;
  void clearQueryType() => clearField($_whichOneof(0));

  /// The options for this query.
  @$pb.TagNumber(1)
  ReadOptions get readOptions => $_getN(0);
  @$pb.TagNumber(1)
  set readOptions(ReadOptions v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadOptions() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadOptions() => clearField(1);
  @$pb.TagNumber(1)
  ReadOptions ensureReadOptions() => $_ensure(0);

  /// Entities are partitioned into subsets, identified by a partition ID.
  /// Queries are scoped to a single partition.
  /// This partition ID is normalized with the standard default context
  /// partition ID.
  @$pb.TagNumber(2)
  $72.PartitionId get partitionId => $_getN(1);
  @$pb.TagNumber(2)
  set partitionId($72.PartitionId v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPartitionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPartitionId() => clearField(2);
  @$pb.TagNumber(2)
  $72.PartitionId ensurePartitionId() => $_ensure(1);

  /// The query to run.
  @$pb.TagNumber(3)
  $74.AggregationQuery get aggregationQuery => $_getN(2);
  @$pb.TagNumber(3)
  set aggregationQuery($74.AggregationQuery v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAggregationQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearAggregationQuery() => clearField(3);
  @$pb.TagNumber(3)
  $74.AggregationQuery ensureAggregationQuery() => $_ensure(2);

  /// The GQL query to run. This query must be an aggregation query.
  @$pb.TagNumber(7)
  $74.GqlQuery get gqlQuery => $_getN(3);
  @$pb.TagNumber(7)
  set gqlQuery($74.GqlQuery v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasGqlQuery() => $_has(3);
  @$pb.TagNumber(7)
  void clearGqlQuery() => clearField(7);
  @$pb.TagNumber(7)
  $74.GqlQuery ensureGqlQuery() => $_ensure(3);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(4);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(4);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(5);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(5);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);

  /// Optional. Explain options for the query. If set, additional query
  /// statistics will be returned. If not, only query results will be returned.
  @$pb.TagNumber(11)
  $75.ExplainOptions get explainOptions => $_getN(6);
  @$pb.TagNumber(11)
  set explainOptions($75.ExplainOptions v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasExplainOptions() => $_has(6);
  @$pb.TagNumber(11)
  void clearExplainOptions() => clearField(11);
  @$pb.TagNumber(11)
  $75.ExplainOptions ensureExplainOptions() => $_ensure(6);
}

/// The response for
/// [Datastore.RunAggregationQuery][google.datastore.v1.Datastore.RunAggregationQuery].
class RunAggregationQueryResponse extends $pb.GeneratedMessage {
  factory RunAggregationQueryResponse({
    $76.AggregationResultBatch? batch,
    $74.AggregationQuery? query,
    $core.List<$core.int>? transaction,
    $75.ExplainMetrics? explainMetrics,
  }) {
    final $result = create();
    if (batch != null) {
      $result.batch = batch;
    }
    if (query != null) {
      $result.query = query;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (explainMetrics != null) {
      $result.explainMetrics = explainMetrics;
    }
    return $result;
  }
  RunAggregationQueryResponse._() : super();
  factory RunAggregationQueryResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RunAggregationQueryResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RunAggregationQueryResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<$76.AggregationResultBatch>(1, _omitFieldNames ? '' : 'batch',
        subBuilder: $76.AggregationResultBatch.create)
    ..aOM<$74.AggregationQuery>(2, _omitFieldNames ? '' : 'query',
        subBuilder: $74.AggregationQuery.create)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..aOM<$75.ExplainMetrics>(9, _omitFieldNames ? '' : 'explainMetrics',
        subBuilder: $75.ExplainMetrics.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RunAggregationQueryResponse clone() =>
      RunAggregationQueryResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RunAggregationQueryResponse copyWith(
          void Function(RunAggregationQueryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RunAggregationQueryResponse))
          as RunAggregationQueryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunAggregationQueryResponse create() =>
      RunAggregationQueryResponse._();
  RunAggregationQueryResponse createEmptyInstance() => create();
  static $pb.PbList<RunAggregationQueryResponse> createRepeated() =>
      $pb.PbList<RunAggregationQueryResponse>();
  @$core.pragma('dart2js:noInline')
  static RunAggregationQueryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RunAggregationQueryResponse>(create);
  static RunAggregationQueryResponse? _defaultInstance;

  /// A batch of aggregation results. Always present.
  @$pb.TagNumber(1)
  $76.AggregationResultBatch get batch => $_getN(0);
  @$pb.TagNumber(1)
  set batch($76.AggregationResultBatch v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasBatch() => $_has(0);
  @$pb.TagNumber(1)
  void clearBatch() => clearField(1);
  @$pb.TagNumber(1)
  $76.AggregationResultBatch ensureBatch() => $_ensure(0);

  /// The parsed form of the `GqlQuery` from the request, if it was set.
  @$pb.TagNumber(2)
  $74.AggregationQuery get query => $_getN(1);
  @$pb.TagNumber(2)
  set query($74.AggregationQuery v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);
  @$pb.TagNumber(2)
  $74.AggregationQuery ensureQuery() => $_ensure(1);

  ///  The identifier of the transaction that was started as part of this
  ///  RunAggregationQuery request.
  ///
  ///  Set only when
  ///  [ReadOptions.new_transaction][google.datastore.v1.ReadOptions.new_transaction]
  ///  was set in
  ///  [RunAggregationQueryRequest.read_options][google.datastore.v1.RunAggregationQueryRequest.read_options].
  @$pb.TagNumber(5)
  $core.List<$core.int> get transaction => $_getN(2);
  @$pb.TagNumber(5)
  set transaction($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTransaction() => $_has(2);
  @$pb.TagNumber(5)
  void clearTransaction() => clearField(5);

  /// Query explain metrics. This is only present when the
  /// [RunAggregationQueryRequest.explain_options][google.datastore.v1.RunAggregationQueryRequest.explain_options]
  /// is provided, and it is sent only once with the last response in the stream.
  @$pb.TagNumber(9)
  $75.ExplainMetrics get explainMetrics => $_getN(3);
  @$pb.TagNumber(9)
  set explainMetrics($75.ExplainMetrics v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasExplainMetrics() => $_has(3);
  @$pb.TagNumber(9)
  void clearExplainMetrics() => clearField(9);
  @$pb.TagNumber(9)
  $75.ExplainMetrics ensureExplainMetrics() => $_ensure(3);
}

/// The request for
/// [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction].
class BeginTransactionRequest extends $pb.GeneratedMessage {
  factory BeginTransactionRequest({
    $core.String? projectId,
    $core.String? databaseId,
    TransactionOptions? transactionOptions,
  }) {
    final $result = create();
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    if (transactionOptions != null) {
      $result.transactionOptions = transactionOptions;
    }
    return $result;
  }
  BeginTransactionRequest._() : super();
  factory BeginTransactionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BeginTransactionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BeginTransactionRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..aOM<TransactionOptions>(10, _omitFieldNames ? '' : 'transactionOptions',
        subBuilder: TransactionOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BeginTransactionRequest clone() =>
      BeginTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BeginTransactionRequest copyWith(
          void Function(BeginTransactionRequest) updates) =>
      super.copyWith((message) => updates(message as BeginTransactionRequest))
          as BeginTransactionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BeginTransactionRequest create() => BeginTransactionRequest._();
  BeginTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<BeginTransactionRequest> createRepeated() =>
      $pb.PbList<BeginTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static BeginTransactionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BeginTransactionRequest>(create);
  static BeginTransactionRequest? _defaultInstance;

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(1);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(1);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);

  /// Options for a new transaction.
  @$pb.TagNumber(10)
  TransactionOptions get transactionOptions => $_getN(2);
  @$pb.TagNumber(10)
  set transactionOptions(TransactionOptions v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasTransactionOptions() => $_has(2);
  @$pb.TagNumber(10)
  void clearTransactionOptions() => clearField(10);
  @$pb.TagNumber(10)
  TransactionOptions ensureTransactionOptions() => $_ensure(2);
}

/// The response for
/// [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction].
class BeginTransactionResponse extends $pb.GeneratedMessage {
  factory BeginTransactionResponse({
    $core.List<$core.int>? transaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    return $result;
  }
  BeginTransactionResponse._() : super();
  factory BeginTransactionResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BeginTransactionResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BeginTransactionResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BeginTransactionResponse clone() =>
      BeginTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BeginTransactionResponse copyWith(
          void Function(BeginTransactionResponse) updates) =>
      super.copyWith((message) => updates(message as BeginTransactionResponse))
          as BeginTransactionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BeginTransactionResponse create() => BeginTransactionResponse._();
  BeginTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<BeginTransactionResponse> createRepeated() =>
      $pb.PbList<BeginTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static BeginTransactionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BeginTransactionResponse>(create);
  static BeginTransactionResponse? _defaultInstance;

  /// The transaction identifier (always present).
  @$pb.TagNumber(1)
  $core.List<$core.int> get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
}

/// The request for [Datastore.Rollback][google.datastore.v1.Datastore.Rollback].
class RollbackRequest extends $pb.GeneratedMessage {
  factory RollbackRequest({
    $core.List<$core.int>? transaction,
    $core.String? projectId,
    $core.String? databaseId,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    return $result;
  }
  RollbackRequest._() : super();
  factory RollbackRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RollbackRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RollbackRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RollbackRequest clone() => RollbackRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RollbackRequest copyWith(void Function(RollbackRequest) updates) =>
      super.copyWith((message) => updates(message as RollbackRequest))
          as RollbackRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RollbackRequest create() => RollbackRequest._();
  RollbackRequest createEmptyInstance() => create();
  static $pb.PbList<RollbackRequest> createRepeated() =>
      $pb.PbList<RollbackRequest>();
  @$core.pragma('dart2js:noInline')
  static RollbackRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RollbackRequest>(create);
  static RollbackRequest? _defaultInstance;

  /// Required. The transaction identifier, returned by a call to
  /// [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction].
  @$pb.TagNumber(1)
  $core.List<$core.int> get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(2);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(2);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);
}

/// The response for
/// [Datastore.Rollback][google.datastore.v1.Datastore.Rollback]. (an empty
/// message).
class RollbackResponse extends $pb.GeneratedMessage {
  factory RollbackResponse() => create();
  RollbackResponse._() : super();
  factory RollbackResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RollbackResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RollbackResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RollbackResponse clone() => RollbackResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RollbackResponse copyWith(void Function(RollbackResponse) updates) =>
      super.copyWith((message) => updates(message as RollbackResponse))
          as RollbackResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RollbackResponse create() => RollbackResponse._();
  RollbackResponse createEmptyInstance() => create();
  static $pb.PbList<RollbackResponse> createRepeated() =>
      $pb.PbList<RollbackResponse>();
  @$core.pragma('dart2js:noInline')
  static RollbackResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RollbackResponse>(create);
  static RollbackResponse? _defaultInstance;
}

enum CommitRequest_TransactionSelector {
  transaction,
  singleUseTransaction,
  notSet
}

/// The request for [Datastore.Commit][google.datastore.v1.Datastore.Commit].
class CommitRequest extends $pb.GeneratedMessage {
  factory CommitRequest({
    $core.List<$core.int>? transaction,
    CommitRequest_Mode? mode,
    $core.Iterable<Mutation>? mutations,
    $core.String? projectId,
    $core.String? databaseId,
    TransactionOptions? singleUseTransaction,
  }) {
    final $result = create();
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (mode != null) {
      $result.mode = mode;
    }
    if (mutations != null) {
      $result.mutations.addAll(mutations);
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    if (singleUseTransaction != null) {
      $result.singleUseTransaction = singleUseTransaction;
    }
    return $result;
  }
  CommitRequest._() : super();
  factory CommitRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommitRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CommitRequest_TransactionSelector>
      _CommitRequest_TransactionSelectorByTag = {
    1: CommitRequest_TransactionSelector.transaction,
    10: CommitRequest_TransactionSelector.singleUseTransaction,
    0: CommitRequest_TransactionSelector.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 10])
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..e<CommitRequest_Mode>(
        5, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE,
        defaultOrMaker: CommitRequest_Mode.MODE_UNSPECIFIED,
        valueOf: CommitRequest_Mode.valueOf,
        enumValues: CommitRequest_Mode.values)
    ..pc<Mutation>(6, _omitFieldNames ? '' : 'mutations', $pb.PbFieldType.PM,
        subBuilder: Mutation.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..aOM<TransactionOptions>(10, _omitFieldNames ? '' : 'singleUseTransaction',
        subBuilder: TransactionOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommitRequest clone() => CommitRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommitRequest copyWith(void Function(CommitRequest) updates) =>
      super.copyWith((message) => updates(message as CommitRequest))
          as CommitRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommitRequest create() => CommitRequest._();
  CommitRequest createEmptyInstance() => create();
  static $pb.PbList<CommitRequest> createRepeated() =>
      $pb.PbList<CommitRequest>();
  @$core.pragma('dart2js:noInline')
  static CommitRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitRequest>(create);
  static CommitRequest? _defaultInstance;

  CommitRequest_TransactionSelector whichTransactionSelector() =>
      _CommitRequest_TransactionSelectorByTag[$_whichOneof(0)]!;
  void clearTransactionSelector() => clearField($_whichOneof(0));

  /// The identifier of the transaction associated with the commit. A
  /// transaction identifier is returned by a call to
  /// [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction].
  @$pb.TagNumber(1)
  $core.List<$core.int> get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);

  /// The type of commit to perform. Defaults to `TRANSACTIONAL`.
  @$pb.TagNumber(5)
  CommitRequest_Mode get mode => $_getN(1);
  @$pb.TagNumber(5)
  set mode(CommitRequest_Mode v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMode() => $_has(1);
  @$pb.TagNumber(5)
  void clearMode() => clearField(5);

  ///  The mutations to perform.
  ///
  ///  When mode is `TRANSACTIONAL`, mutations affecting a single entity are
  ///  applied in order. The following sequences of mutations affecting a single
  ///  entity are not permitted in a single `Commit` request:
  ///
  ///  - `insert` followed by `insert`
  ///  - `update` followed by `insert`
  ///  - `upsert` followed by `insert`
  ///  - `delete` followed by `update`
  ///
  ///  When mode is `NON_TRANSACTIONAL`, no two mutations may affect a single
  ///  entity.
  @$pb.TagNumber(6)
  $core.List<Mutation> get mutations => $_getList(2);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(3);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(3);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(4);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(4);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);

  /// Options for beginning a new transaction for this request.
  /// The transaction is committed when the request completes. If specified,
  /// [TransactionOptions.mode][google.datastore.v1.TransactionOptions] must be
  /// [TransactionOptions.ReadWrite][google.datastore.v1.TransactionOptions.ReadWrite].
  @$pb.TagNumber(10)
  TransactionOptions get singleUseTransaction => $_getN(5);
  @$pb.TagNumber(10)
  set singleUseTransaction(TransactionOptions v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasSingleUseTransaction() => $_has(5);
  @$pb.TagNumber(10)
  void clearSingleUseTransaction() => clearField(10);
  @$pb.TagNumber(10)
  TransactionOptions ensureSingleUseTransaction() => $_ensure(5);
}

/// The response for [Datastore.Commit][google.datastore.v1.Datastore.Commit].
class CommitResponse extends $pb.GeneratedMessage {
  factory CommitResponse({
    $core.Iterable<MutationResult>? mutationResults,
    $core.int? indexUpdates,
    $50.Timestamp? commitTime,
  }) {
    final $result = create();
    if (mutationResults != null) {
      $result.mutationResults.addAll(mutationResults);
    }
    if (indexUpdates != null) {
      $result.indexUpdates = indexUpdates;
    }
    if (commitTime != null) {
      $result.commitTime = commitTime;
    }
    return $result;
  }
  CommitResponse._() : super();
  factory CommitResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CommitResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommitResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<MutationResult>(
        3, _omitFieldNames ? '' : 'mutationResults', $pb.PbFieldType.PM,
        subBuilder: MutationResult.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'indexUpdates', $pb.PbFieldType.O3)
    ..aOM<$50.Timestamp>(8, _omitFieldNames ? '' : 'commitTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CommitResponse clone() => CommitResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CommitResponse copyWith(void Function(CommitResponse) updates) =>
      super.copyWith((message) => updates(message as CommitResponse))
          as CommitResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommitResponse create() => CommitResponse._();
  CommitResponse createEmptyInstance() => create();
  static $pb.PbList<CommitResponse> createRepeated() =>
      $pb.PbList<CommitResponse>();
  @$core.pragma('dart2js:noInline')
  static CommitResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommitResponse>(create);
  static CommitResponse? _defaultInstance;

  /// The result of performing the mutations.
  /// The i-th mutation result corresponds to the i-th mutation in the request.
  @$pb.TagNumber(3)
  $core.List<MutationResult> get mutationResults => $_getList(0);

  /// The number of index entries updated during the commit, or zero if none were
  /// updated.
  @$pb.TagNumber(4)
  $core.int get indexUpdates => $_getIZ(1);
  @$pb.TagNumber(4)
  set indexUpdates($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIndexUpdates() => $_has(1);
  @$pb.TagNumber(4)
  void clearIndexUpdates() => clearField(4);

  /// The transaction commit timestamp. Not set for non-transactional commits.
  @$pb.TagNumber(8)
  $50.Timestamp get commitTime => $_getN(2);
  @$pb.TagNumber(8)
  set commitTime($50.Timestamp v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCommitTime() => $_has(2);
  @$pb.TagNumber(8)
  void clearCommitTime() => clearField(8);
  @$pb.TagNumber(8)
  $50.Timestamp ensureCommitTime() => $_ensure(2);
}

/// The request for
/// [Datastore.AllocateIds][google.datastore.v1.Datastore.AllocateIds].
class AllocateIdsRequest extends $pb.GeneratedMessage {
  factory AllocateIdsRequest({
    $core.Iterable<$72.Key>? keys,
    $core.String? projectId,
    $core.String? databaseId,
  }) {
    final $result = create();
    if (keys != null) {
      $result.keys.addAll(keys);
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    return $result;
  }
  AllocateIdsRequest._() : super();
  factory AllocateIdsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AllocateIdsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateIdsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<$72.Key>(1, _omitFieldNames ? '' : 'keys', $pb.PbFieldType.PM,
        subBuilder: $72.Key.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AllocateIdsRequest clone() => AllocateIdsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AllocateIdsRequest copyWith(void Function(AllocateIdsRequest) updates) =>
      super.copyWith((message) => updates(message as AllocateIdsRequest))
          as AllocateIdsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateIdsRequest create() => AllocateIdsRequest._();
  AllocateIdsRequest createEmptyInstance() => create();
  static $pb.PbList<AllocateIdsRequest> createRepeated() =>
      $pb.PbList<AllocateIdsRequest>();
  @$core.pragma('dart2js:noInline')
  static AllocateIdsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateIdsRequest>(create);
  static AllocateIdsRequest? _defaultInstance;

  /// Required. A list of keys with incomplete key paths for which to allocate
  /// IDs. No key may be reserved/read-only.
  @$pb.TagNumber(1)
  $core.List<$72.Key> get keys => $_getList(0);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(2);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(2);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);
}

/// The response for
/// [Datastore.AllocateIds][google.datastore.v1.Datastore.AllocateIds].
class AllocateIdsResponse extends $pb.GeneratedMessage {
  factory AllocateIdsResponse({
    $core.Iterable<$72.Key>? keys,
  }) {
    final $result = create();
    if (keys != null) {
      $result.keys.addAll(keys);
    }
    return $result;
  }
  AllocateIdsResponse._() : super();
  factory AllocateIdsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AllocateIdsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateIdsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<$72.Key>(1, _omitFieldNames ? '' : 'keys', $pb.PbFieldType.PM,
        subBuilder: $72.Key.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AllocateIdsResponse clone() => AllocateIdsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AllocateIdsResponse copyWith(void Function(AllocateIdsResponse) updates) =>
      super.copyWith((message) => updates(message as AllocateIdsResponse))
          as AllocateIdsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateIdsResponse create() => AllocateIdsResponse._();
  AllocateIdsResponse createEmptyInstance() => create();
  static $pb.PbList<AllocateIdsResponse> createRepeated() =>
      $pb.PbList<AllocateIdsResponse>();
  @$core.pragma('dart2js:noInline')
  static AllocateIdsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateIdsResponse>(create);
  static AllocateIdsResponse? _defaultInstance;

  /// The keys specified in the request (in the same order), each with
  /// its key path completed with a newly allocated ID.
  @$pb.TagNumber(1)
  $core.List<$72.Key> get keys => $_getList(0);
}

/// The request for
/// [Datastore.ReserveIds][google.datastore.v1.Datastore.ReserveIds].
class ReserveIdsRequest extends $pb.GeneratedMessage {
  factory ReserveIdsRequest({
    $core.Iterable<$72.Key>? keys,
    $core.String? projectId,
    $core.String? databaseId,
  }) {
    final $result = create();
    if (keys != null) {
      $result.keys.addAll(keys);
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (databaseId != null) {
      $result.databaseId = databaseId;
    }
    return $result;
  }
  ReserveIdsRequest._() : super();
  factory ReserveIdsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReserveIdsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReserveIdsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pc<$72.Key>(1, _omitFieldNames ? '' : 'keys', $pb.PbFieldType.PM,
        subBuilder: $72.Key.create)
    ..aOS(8, _omitFieldNames ? '' : 'projectId')
    ..aOS(9, _omitFieldNames ? '' : 'databaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReserveIdsRequest clone() => ReserveIdsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReserveIdsRequest copyWith(void Function(ReserveIdsRequest) updates) =>
      super.copyWith((message) => updates(message as ReserveIdsRequest))
          as ReserveIdsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReserveIdsRequest create() => ReserveIdsRequest._();
  ReserveIdsRequest createEmptyInstance() => create();
  static $pb.PbList<ReserveIdsRequest> createRepeated() =>
      $pb.PbList<ReserveIdsRequest>();
  @$core.pragma('dart2js:noInline')
  static ReserveIdsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReserveIdsRequest>(create);
  static ReserveIdsRequest? _defaultInstance;

  /// Required. A list of keys with complete key paths whose numeric IDs should
  /// not be auto-allocated.
  @$pb.TagNumber(1)
  $core.List<$72.Key> get keys => $_getList(0);

  /// Required. The ID of the project against which to make the request.
  @$pb.TagNumber(8)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(8)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(8)
  void clearProjectId() => clearField(8);

  ///  The ID of the database against which to make the request.
  ///
  ///  '(default)' is not allowed; please use empty string '' to refer the default
  ///  database.
  @$pb.TagNumber(9)
  $core.String get databaseId => $_getSZ(2);
  @$pb.TagNumber(9)
  set databaseId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDatabaseId() => $_has(2);
  @$pb.TagNumber(9)
  void clearDatabaseId() => clearField(9);
}

/// The response for
/// [Datastore.ReserveIds][google.datastore.v1.Datastore.ReserveIds].
class ReserveIdsResponse extends $pb.GeneratedMessage {
  factory ReserveIdsResponse() => create();
  ReserveIdsResponse._() : super();
  factory ReserveIdsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReserveIdsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReserveIdsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReserveIdsResponse clone() => ReserveIdsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReserveIdsResponse copyWith(void Function(ReserveIdsResponse) updates) =>
      super.copyWith((message) => updates(message as ReserveIdsResponse))
          as ReserveIdsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReserveIdsResponse create() => ReserveIdsResponse._();
  ReserveIdsResponse createEmptyInstance() => create();
  static $pb.PbList<ReserveIdsResponse> createRepeated() =>
      $pb.PbList<ReserveIdsResponse>();
  @$core.pragma('dart2js:noInline')
  static ReserveIdsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReserveIdsResponse>(create);
  static ReserveIdsResponse? _defaultInstance;
}

enum Mutation_Operation { insert, update, upsert, delete, notSet }

enum Mutation_ConflictDetectionStrategy { baseVersion, updateTime, notSet }

/// A mutation to apply to an entity.
class Mutation extends $pb.GeneratedMessage {
  factory Mutation({
    $72.Entity? insert,
    $72.Entity? update,
    $72.Entity? upsert,
    $72.Key? delete,
    $fixnum.Int64? baseVersion,
    PropertyMask? propertyMask,
    $50.Timestamp? updateTime,
  }) {
    final $result = create();
    if (insert != null) {
      $result.insert = insert;
    }
    if (update != null) {
      $result.update = update;
    }
    if (upsert != null) {
      $result.upsert = upsert;
    }
    if (delete != null) {
      $result.delete = delete;
    }
    if (baseVersion != null) {
      $result.baseVersion = baseVersion;
    }
    if (propertyMask != null) {
      $result.propertyMask = propertyMask;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    return $result;
  }
  Mutation._() : super();
  factory Mutation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Mutation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Mutation_Operation>
      _Mutation_OperationByTag = {
    4: Mutation_Operation.insert,
    5: Mutation_Operation.update,
    6: Mutation_Operation.upsert,
    7: Mutation_Operation.delete,
    0: Mutation_Operation.notSet
  };
  static const $core.Map<$core.int, Mutation_ConflictDetectionStrategy>
      _Mutation_ConflictDetectionStrategyByTag = {
    8: Mutation_ConflictDetectionStrategy.baseVersion,
    11: Mutation_ConflictDetectionStrategy.updateTime,
    0: Mutation_ConflictDetectionStrategy.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Mutation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7])
    ..oo(1, [8, 11])
    ..aOM<$72.Entity>(4, _omitFieldNames ? '' : 'insert',
        subBuilder: $72.Entity.create)
    ..aOM<$72.Entity>(5, _omitFieldNames ? '' : 'update',
        subBuilder: $72.Entity.create)
    ..aOM<$72.Entity>(6, _omitFieldNames ? '' : 'upsert',
        subBuilder: $72.Entity.create)
    ..aOM<$72.Key>(7, _omitFieldNames ? '' : 'delete',
        subBuilder: $72.Key.create)
    ..aInt64(8, _omitFieldNames ? '' : 'baseVersion')
    ..aOM<PropertyMask>(9, _omitFieldNames ? '' : 'propertyMask',
        subBuilder: PropertyMask.create)
    ..aOM<$50.Timestamp>(11, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Mutation clone() => Mutation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Mutation copyWith(void Function(Mutation) updates) =>
      super.copyWith((message) => updates(message as Mutation)) as Mutation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mutation create() => Mutation._();
  Mutation createEmptyInstance() => create();
  static $pb.PbList<Mutation> createRepeated() => $pb.PbList<Mutation>();
  @$core.pragma('dart2js:noInline')
  static Mutation getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mutation>(create);
  static Mutation? _defaultInstance;

  Mutation_Operation whichOperation() =>
      _Mutation_OperationByTag[$_whichOneof(0)]!;
  void clearOperation() => clearField($_whichOneof(0));

  Mutation_ConflictDetectionStrategy whichConflictDetectionStrategy() =>
      _Mutation_ConflictDetectionStrategyByTag[$_whichOneof(1)]!;
  void clearConflictDetectionStrategy() => clearField($_whichOneof(1));

  /// The entity to insert. The entity must not already exist.
  /// The entity key's final path element may be incomplete.
  @$pb.TagNumber(4)
  $72.Entity get insert => $_getN(0);
  @$pb.TagNumber(4)
  set insert($72.Entity v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasInsert() => $_has(0);
  @$pb.TagNumber(4)
  void clearInsert() => clearField(4);
  @$pb.TagNumber(4)
  $72.Entity ensureInsert() => $_ensure(0);

  /// The entity to update. The entity must already exist.
  /// Must have a complete key path.
  @$pb.TagNumber(5)
  $72.Entity get update => $_getN(1);
  @$pb.TagNumber(5)
  set update($72.Entity v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUpdate() => $_has(1);
  @$pb.TagNumber(5)
  void clearUpdate() => clearField(5);
  @$pb.TagNumber(5)
  $72.Entity ensureUpdate() => $_ensure(1);

  /// The entity to upsert. The entity may or may not already exist.
  /// The entity key's final path element may be incomplete.
  @$pb.TagNumber(6)
  $72.Entity get upsert => $_getN(2);
  @$pb.TagNumber(6)
  set upsert($72.Entity v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUpsert() => $_has(2);
  @$pb.TagNumber(6)
  void clearUpsert() => clearField(6);
  @$pb.TagNumber(6)
  $72.Entity ensureUpsert() => $_ensure(2);

  /// The key of the entity to delete. The entity may or may not already exist.
  /// Must have a complete key path and must not be reserved/read-only.
  @$pb.TagNumber(7)
  $72.Key get delete => $_getN(3);
  @$pb.TagNumber(7)
  set delete($72.Key v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDelete() => $_has(3);
  @$pb.TagNumber(7)
  void clearDelete() => clearField(7);
  @$pb.TagNumber(7)
  $72.Key ensureDelete() => $_ensure(3);

  /// The version of the entity that this mutation is being applied
  /// to. If this does not match the current version on the server, the
  /// mutation conflicts.
  @$pb.TagNumber(8)
  $fixnum.Int64 get baseVersion => $_getI64(4);
  @$pb.TagNumber(8)
  set baseVersion($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasBaseVersion() => $_has(4);
  @$pb.TagNumber(8)
  void clearBaseVersion() => clearField(8);

  ///  The properties to write in this mutation.
  ///  None of the properties in the mask may have a reserved name, except for
  ///  `__key__`.
  ///  This field is ignored for `delete`.
  ///
  ///  If the entity already exists, only properties referenced in the mask are
  ///  updated, others are left untouched.
  ///  Properties referenced in the mask but not in the entity are deleted.
  @$pb.TagNumber(9)
  PropertyMask get propertyMask => $_getN(5);
  @$pb.TagNumber(9)
  set propertyMask(PropertyMask v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasPropertyMask() => $_has(5);
  @$pb.TagNumber(9)
  void clearPropertyMask() => clearField(9);
  @$pb.TagNumber(9)
  PropertyMask ensurePropertyMask() => $_ensure(5);

  /// The update time of the entity that this mutation is being applied
  /// to. If this does not match the current update time on the server, the
  /// mutation conflicts.
  @$pb.TagNumber(11)
  $50.Timestamp get updateTime => $_getN(6);
  @$pb.TagNumber(11)
  set updateTime($50.Timestamp v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasUpdateTime() => $_has(6);
  @$pb.TagNumber(11)
  void clearUpdateTime() => clearField(11);
  @$pb.TagNumber(11)
  $50.Timestamp ensureUpdateTime() => $_ensure(6);
}

/// The result of applying a mutation.
class MutationResult extends $pb.GeneratedMessage {
  factory MutationResult({
    $72.Key? key,
    $fixnum.Int64? version,
    $core.bool? conflictDetected,
    $50.Timestamp? updateTime,
    $50.Timestamp? createTime,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    if (version != null) {
      $result.version = version;
    }
    if (conflictDetected != null) {
      $result.conflictDetected = conflictDetected;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    return $result;
  }
  MutationResult._() : super();
  factory MutationResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MutationResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MutationResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<$72.Key>(3, _omitFieldNames ? '' : 'key', subBuilder: $72.Key.create)
    ..aInt64(4, _omitFieldNames ? '' : 'version')
    ..aOB(5, _omitFieldNames ? '' : 'conflictDetected')
    ..aOM<$50.Timestamp>(6, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(7, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MutationResult clone() => MutationResult()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MutationResult copyWith(void Function(MutationResult) updates) =>
      super.copyWith((message) => updates(message as MutationResult))
          as MutationResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MutationResult create() => MutationResult._();
  MutationResult createEmptyInstance() => create();
  static $pb.PbList<MutationResult> createRepeated() =>
      $pb.PbList<MutationResult>();
  @$core.pragma('dart2js:noInline')
  static MutationResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MutationResult>(create);
  static MutationResult? _defaultInstance;

  /// The automatically allocated key.
  /// Set only when the mutation allocated a key.
  @$pb.TagNumber(3)
  $72.Key get key => $_getN(0);
  @$pb.TagNumber(3)
  set key($72.Key v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(3)
  void clearKey() => clearField(3);
  @$pb.TagNumber(3)
  $72.Key ensureKey() => $_ensure(0);

  /// The version of the entity on the server after processing the mutation. If
  /// the mutation doesn't change anything on the server, then the version will
  /// be the version of the current entity or, if no entity is present, a version
  /// that is strictly greater than the version of any previous entity and less
  /// than the version of any possible future entity.
  @$pb.TagNumber(4)
  $fixnum.Int64 get version => $_getI64(1);
  @$pb.TagNumber(4)
  set version($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);

  /// Whether a conflict was detected for this mutation. Always false when a
  /// conflict detection strategy field is not set in the mutation.
  @$pb.TagNumber(5)
  $core.bool get conflictDetected => $_getBF(2);
  @$pb.TagNumber(5)
  set conflictDetected($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasConflictDetected() => $_has(2);
  @$pb.TagNumber(5)
  void clearConflictDetected() => clearField(5);

  /// The update time of the entity on the server after processing the mutation.
  /// If the mutation doesn't change anything on the server, then the timestamp
  /// will be the update timestamp of the current entity. This field will not be
  /// set after a 'delete'.
  @$pb.TagNumber(6)
  $50.Timestamp get updateTime => $_getN(3);
  @$pb.TagNumber(6)
  set updateTime($50.Timestamp v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasUpdateTime() => $_has(3);
  @$pb.TagNumber(6)
  void clearUpdateTime() => clearField(6);
  @$pb.TagNumber(6)
  $50.Timestamp ensureUpdateTime() => $_ensure(3);

  /// The create time of the entity. This field will not be set after a 'delete'.
  @$pb.TagNumber(7)
  $50.Timestamp get createTime => $_getN(4);
  @$pb.TagNumber(7)
  set createTime($50.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCreateTime() => $_has(4);
  @$pb.TagNumber(7)
  void clearCreateTime() => clearField(7);
  @$pb.TagNumber(7)
  $50.Timestamp ensureCreateTime() => $_ensure(4);
}

/// The set of arbitrarily nested property paths used to restrict an operation to
/// only a subset of properties in an entity.
class PropertyMask extends $pb.GeneratedMessage {
  factory PropertyMask({
    $core.Iterable<$core.String>? paths,
  }) {
    final $result = create();
    if (paths != null) {
      $result.paths.addAll(paths);
    }
    return $result;
  }
  PropertyMask._() : super();
  factory PropertyMask.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PropertyMask.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PropertyMask',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'paths')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PropertyMask clone() => PropertyMask()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PropertyMask copyWith(void Function(PropertyMask) updates) =>
      super.copyWith((message) => updates(message as PropertyMask))
          as PropertyMask;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PropertyMask create() => PropertyMask._();
  PropertyMask createEmptyInstance() => create();
  static $pb.PbList<PropertyMask> createRepeated() =>
      $pb.PbList<PropertyMask>();
  @$core.pragma('dart2js:noInline')
  static PropertyMask getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PropertyMask>(create);
  static PropertyMask? _defaultInstance;

  ///  The paths to the properties covered by this mask.
  ///
  ///  A path is a list of property names separated by dots (`.`), for example
  ///  `foo.bar` means the property `bar` inside the entity property `foo` inside
  ///  the entity associated with this path.
  ///
  ///  If a property name contains a dot `.` or a backslash `\`, then that
  ///  name must be escaped.
  ///
  ///  A path must not be empty, and may not reference a value inside an
  ///  [array value][google.datastore.v1.Value.array_value].
  @$pb.TagNumber(1)
  $core.List<$core.String> get paths => $_getList(0);
}

enum ReadOptions_ConsistencyType {
  readConsistency,
  transaction,
  newTransaction,
  readTime,
  notSet
}

/// The options shared by read requests.
class ReadOptions extends $pb.GeneratedMessage {
  factory ReadOptions({
    ReadOptions_ReadConsistency? readConsistency,
    $core.List<$core.int>? transaction,
    TransactionOptions? newTransaction,
    $50.Timestamp? readTime,
  }) {
    final $result = create();
    if (readConsistency != null) {
      $result.readConsistency = readConsistency;
    }
    if (transaction != null) {
      $result.transaction = transaction;
    }
    if (newTransaction != null) {
      $result.newTransaction = newTransaction;
    }
    if (readTime != null) {
      $result.readTime = readTime;
    }
    return $result;
  }
  ReadOptions._() : super();
  factory ReadOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ReadOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ReadOptions_ConsistencyType>
      _ReadOptions_ConsistencyTypeByTag = {
    1: ReadOptions_ConsistencyType.readConsistency,
    2: ReadOptions_ConsistencyType.transaction,
    3: ReadOptions_ConsistencyType.newTransaction,
    4: ReadOptions_ConsistencyType.readTime,
    0: ReadOptions_ConsistencyType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..e<ReadOptions_ReadConsistency>(
        1, _omitFieldNames ? '' : 'readConsistency', $pb.PbFieldType.OE,
        defaultOrMaker:
            ReadOptions_ReadConsistency.READ_CONSISTENCY_UNSPECIFIED,
        valueOf: ReadOptions_ReadConsistency.valueOf,
        enumValues: ReadOptions_ReadConsistency.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'transaction', $pb.PbFieldType.OY)
    ..aOM<TransactionOptions>(3, _omitFieldNames ? '' : 'newTransaction',
        subBuilder: TransactionOptions.create)
    ..aOM<$50.Timestamp>(4, _omitFieldNames ? '' : 'readTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ReadOptions clone() => ReadOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ReadOptions copyWith(void Function(ReadOptions) updates) =>
      super.copyWith((message) => updates(message as ReadOptions))
          as ReadOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadOptions create() => ReadOptions._();
  ReadOptions createEmptyInstance() => create();
  static $pb.PbList<ReadOptions> createRepeated() => $pb.PbList<ReadOptions>();
  @$core.pragma('dart2js:noInline')
  static ReadOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadOptions>(create);
  static ReadOptions? _defaultInstance;

  ReadOptions_ConsistencyType whichConsistencyType() =>
      _ReadOptions_ConsistencyTypeByTag[$_whichOneof(0)]!;
  void clearConsistencyType() => clearField($_whichOneof(0));

  /// The non-transactional read consistency to use.
  @$pb.TagNumber(1)
  ReadOptions_ReadConsistency get readConsistency => $_getN(0);
  @$pb.TagNumber(1)
  set readConsistency(ReadOptions_ReadConsistency v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadConsistency() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadConsistency() => clearField(1);

  /// The identifier of the transaction in which to read. A
  /// transaction identifier is returned by a call to
  /// [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction].
  @$pb.TagNumber(2)
  $core.List<$core.int> get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => clearField(2);

  ///  Options for beginning a new transaction for this request.
  ///
  ///  The new transaction identifier will be returned in the corresponding
  ///  response as either
  ///  [LookupResponse.transaction][google.datastore.v1.LookupResponse.transaction]
  ///  or
  ///  [RunQueryResponse.transaction][google.datastore.v1.RunQueryResponse.transaction].
  @$pb.TagNumber(3)
  TransactionOptions get newTransaction => $_getN(2);
  @$pb.TagNumber(3)
  set newTransaction(TransactionOptions v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasNewTransaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewTransaction() => clearField(3);
  @$pb.TagNumber(3)
  TransactionOptions ensureNewTransaction() => $_ensure(2);

  ///  Reads entities as they were at the given time. This value is only
  ///  supported for Cloud Firestore in Datastore mode.
  ///
  ///  This must be a microsecond precision timestamp within the past one hour,
  ///  or if Point-in-Time Recovery is enabled, can additionally be a whole
  ///  minute timestamp within the past 7 days.
  @$pb.TagNumber(4)
  $50.Timestamp get readTime => $_getN(3);
  @$pb.TagNumber(4)
  set readTime($50.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasReadTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearReadTime() => clearField(4);
  @$pb.TagNumber(4)
  $50.Timestamp ensureReadTime() => $_ensure(3);
}

/// Options specific to read / write transactions.
class TransactionOptions_ReadWrite extends $pb.GeneratedMessage {
  factory TransactionOptions_ReadWrite({
    $core.List<$core.int>? previousTransaction,
  }) {
    final $result = create();
    if (previousTransaction != null) {
      $result.previousTransaction = previousTransaction;
    }
    return $result;
  }
  TransactionOptions_ReadWrite._() : super();
  factory TransactionOptions_ReadWrite.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionOptions_ReadWrite.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionOptions.ReadWrite',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'previousTransaction', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TransactionOptions_ReadWrite clone() =>
      TransactionOptions_ReadWrite()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TransactionOptions_ReadWrite copyWith(
          void Function(TransactionOptions_ReadWrite) updates) =>
      super.copyWith(
              (message) => updates(message as TransactionOptions_ReadWrite))
          as TransactionOptions_ReadWrite;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionOptions_ReadWrite create() =>
      TransactionOptions_ReadWrite._();
  TransactionOptions_ReadWrite createEmptyInstance() => create();
  static $pb.PbList<TransactionOptions_ReadWrite> createRepeated() =>
      $pb.PbList<TransactionOptions_ReadWrite>();
  @$core.pragma('dart2js:noInline')
  static TransactionOptions_ReadWrite getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionOptions_ReadWrite>(create);
  static TransactionOptions_ReadWrite? _defaultInstance;

  /// The transaction identifier of the transaction being retried.
  @$pb.TagNumber(1)
  $core.List<$core.int> get previousTransaction => $_getN(0);
  @$pb.TagNumber(1)
  set previousTransaction($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPreviousTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreviousTransaction() => clearField(1);
}

/// Options specific to read-only transactions.
class TransactionOptions_ReadOnly extends $pb.GeneratedMessage {
  factory TransactionOptions_ReadOnly({
    $50.Timestamp? readTime,
  }) {
    final $result = create();
    if (readTime != null) {
      $result.readTime = readTime;
    }
    return $result;
  }
  TransactionOptions_ReadOnly._() : super();
  factory TransactionOptions_ReadOnly.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionOptions_ReadOnly.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionOptions.ReadOnly',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'readTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TransactionOptions_ReadOnly clone() =>
      TransactionOptions_ReadOnly()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TransactionOptions_ReadOnly copyWith(
          void Function(TransactionOptions_ReadOnly) updates) =>
      super.copyWith(
              (message) => updates(message as TransactionOptions_ReadOnly))
          as TransactionOptions_ReadOnly;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionOptions_ReadOnly create() =>
      TransactionOptions_ReadOnly._();
  TransactionOptions_ReadOnly createEmptyInstance() => create();
  static $pb.PbList<TransactionOptions_ReadOnly> createRepeated() =>
      $pb.PbList<TransactionOptions_ReadOnly>();
  @$core.pragma('dart2js:noInline')
  static TransactionOptions_ReadOnly getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionOptions_ReadOnly>(create);
  static TransactionOptions_ReadOnly? _defaultInstance;

  ///  Reads entities at the given time.
  ///
  ///  This must be a microsecond precision timestamp within the past one hour,
  ///  or if Point-in-Time Recovery is enabled, can additionally be a whole
  ///  minute timestamp within the past 7 days.
  @$pb.TagNumber(1)
  $50.Timestamp get readTime => $_getN(0);
  @$pb.TagNumber(1)
  set readTime($50.Timestamp v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadTime() => clearField(1);
  @$pb.TagNumber(1)
  $50.Timestamp ensureReadTime() => $_ensure(0);
}

enum TransactionOptions_Mode { readWrite, readOnly, notSet }

///  Options for beginning a new transaction.
///
///  Transactions can be created explicitly with calls to
///  [Datastore.BeginTransaction][google.datastore.v1.Datastore.BeginTransaction]
///  or implicitly by setting
///  [ReadOptions.new_transaction][google.datastore.v1.ReadOptions.new_transaction]
///  in read requests.
class TransactionOptions extends $pb.GeneratedMessage {
  factory TransactionOptions({
    TransactionOptions_ReadWrite? readWrite,
    TransactionOptions_ReadOnly? readOnly,
  }) {
    final $result = create();
    if (readWrite != null) {
      $result.readWrite = readWrite;
    }
    if (readOnly != null) {
      $result.readOnly = readOnly;
    }
    return $result;
  }
  TransactionOptions._() : super();
  factory TransactionOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TransactionOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, TransactionOptions_Mode>
      _TransactionOptions_ModeByTag = {
    1: TransactionOptions_Mode.readWrite,
    2: TransactionOptions_Mode.readOnly,
    0: TransactionOptions_Mode.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionOptions',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.datastore.v1'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<TransactionOptions_ReadWrite>(1, _omitFieldNames ? '' : 'readWrite',
        subBuilder: TransactionOptions_ReadWrite.create)
    ..aOM<TransactionOptions_ReadOnly>(2, _omitFieldNames ? '' : 'readOnly',
        subBuilder: TransactionOptions_ReadOnly.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TransactionOptions clone() => TransactionOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TransactionOptions copyWith(void Function(TransactionOptions) updates) =>
      super.copyWith((message) => updates(message as TransactionOptions))
          as TransactionOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionOptions create() => TransactionOptions._();
  TransactionOptions createEmptyInstance() => create();
  static $pb.PbList<TransactionOptions> createRepeated() =>
      $pb.PbList<TransactionOptions>();
  @$core.pragma('dart2js:noInline')
  static TransactionOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionOptions>(create);
  static TransactionOptions? _defaultInstance;

  TransactionOptions_Mode whichMode() =>
      _TransactionOptions_ModeByTag[$_whichOneof(0)]!;
  void clearMode() => clearField($_whichOneof(0));

  /// The transaction should allow both reads and writes.
  @$pb.TagNumber(1)
  TransactionOptions_ReadWrite get readWrite => $_getN(0);
  @$pb.TagNumber(1)
  set readWrite(TransactionOptions_ReadWrite v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasReadWrite() => $_has(0);
  @$pb.TagNumber(1)
  void clearReadWrite() => clearField(1);
  @$pb.TagNumber(1)
  TransactionOptions_ReadWrite ensureReadWrite() => $_ensure(0);

  /// The transaction should only allow reads.
  @$pb.TagNumber(2)
  TransactionOptions_ReadOnly get readOnly => $_getN(1);
  @$pb.TagNumber(2)
  set readOnly(TransactionOptions_ReadOnly v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasReadOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearReadOnly() => clearField(2);
  @$pb.TagNumber(2)
  TransactionOptions_ReadOnly ensureReadOnly() => $_ensure(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
