//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_metrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../api/distribution.pb.dart' as $70;
import '../../api/metric.pb.dart' as $69;
import '../../protobuf/timestamp.pb.dart' as $50;
import 'logging_metrics.pbenum.dart';

export 'logging_metrics.pbenum.dart';

///  Describes a logs-based metric. The value of the metric is the number of log
///  entries that match a logs filter in a given time interval.
///
///  Logs-based metrics can also be used to extract values from logs and create a
///  distribution of the values. The distribution records the statistics of the
///  extracted values along with an optional histogram of the values as specified
///  by the bucket options.
class LogMetric extends $pb.GeneratedMessage {
  factory LogMetric({
    $core.String? name,
    $core.String? description,
    $core.String? filter,
    @$core.Deprecated('This field is deprecated.')
    LogMetric_ApiVersion? version,
    $69.MetricDescriptor? metricDescriptor,
    $core.String? valueExtractor,
    $core.Map<$core.String, $core.String>? labelExtractors,
    $70.Distribution_BucketOptions? bucketOptions,
    $50.Timestamp? createTime,
    $50.Timestamp? updateTime,
    $core.bool? disabled,
    $core.String? bucketName,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (filter != null) {
      $result.filter = filter;
    }
    if (version != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.version = version;
    }
    if (metricDescriptor != null) {
      $result.metricDescriptor = metricDescriptor;
    }
    if (valueExtractor != null) {
      $result.valueExtractor = valueExtractor;
    }
    if (labelExtractors != null) {
      $result.labelExtractors.addAll(labelExtractors);
    }
    if (bucketOptions != null) {
      $result.bucketOptions = bucketOptions;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    if (bucketName != null) {
      $result.bucketName = bucketName;
    }
    return $result;
  }
  LogMetric._() : super();
  factory LogMetric.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LogMetric.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogMetric',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'filter')
    ..e<LogMetric_ApiVersion>(
        4, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OE,
        defaultOrMaker: LogMetric_ApiVersion.V2,
        valueOf: LogMetric_ApiVersion.valueOf,
        enumValues: LogMetric_ApiVersion.values)
    ..aOM<$69.MetricDescriptor>(5, _omitFieldNames ? '' : 'metricDescriptor',
        subBuilder: $69.MetricDescriptor.create)
    ..aOS(6, _omitFieldNames ? '' : 'valueExtractor')
    ..m<$core.String, $core.String>(7, _omitFieldNames ? '' : 'labelExtractors',
        entryClassName: 'LogMetric.LabelExtractorsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.logging.v2'))
    ..aOM<$70.Distribution_BucketOptions>(
        8, _omitFieldNames ? '' : 'bucketOptions',
        subBuilder: $70.Distribution_BucketOptions.create)
    ..aOM<$50.Timestamp>(9, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(10, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOB(12, _omitFieldNames ? '' : 'disabled')
    ..aOS(13, _omitFieldNames ? '' : 'bucketName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LogMetric clone() => LogMetric()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LogMetric copyWith(void Function(LogMetric) updates) =>
      super.copyWith((message) => updates(message as LogMetric)) as LogMetric;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogMetric create() => LogMetric._();
  LogMetric createEmptyInstance() => create();
  static $pb.PbList<LogMetric> createRepeated() => $pb.PbList<LogMetric>();
  @$core.pragma('dart2js:noInline')
  static LogMetric getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogMetric>(create);
  static LogMetric? _defaultInstance;

  ///  Required. The client-assigned metric identifier.
  ///  Examples: `"error_count"`, `"nginx/requests"`.
  ///
  ///  Metric identifiers are limited to 100 characters and can include only the
  ///  following characters: `A-Z`, `a-z`, `0-9`, and the special characters
  ///  `_-.,+!*',()%/`. The forward-slash character (`/`) denotes a hierarchy of
  ///  name pieces, and it cannot be the first character of the name.
  ///
  ///  This field is the `[METRIC_ID]` part of a metric resource name in the
  ///  format "projects/[PROJECT_ID]/metrics/[METRIC_ID]". Example: If the
  ///  resource name of a metric is
  ///  `"projects/my-project/metrics/nginx%2Frequests"`, this field's value is
  ///  `"nginx/requests"`.
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

  /// Optional. A description of this metric, which is used in documentation.
  /// The maximum length of the description is 8000 characters.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  ///  Required. An [advanced logs
  ///  filter](https://cloud.google.com/logging/docs/view/advanced_filters) which
  ///  is used to match log entries. Example:
  ///
  ///      "resource.type=gae_app AND severity>=ERROR"
  ///
  ///  The maximum length of the filter is 20000 characters.
  @$pb.TagNumber(3)
  $core.String get filter => $_getSZ(2);
  @$pb.TagNumber(3)
  set filter($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilter() => clearField(3);

  /// Deprecated. The API version that created or updated this metric.
  /// The v2 format is used by default and cannot be changed.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  LogMetric_ApiVersion get version => $_getN(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set version(LogMetric_ApiVersion v) {
    setField(4, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearVersion() => clearField(4);

  ///  Optional. The metric descriptor associated with the logs-based metric.
  ///  If unspecified, it uses a default metric descriptor with a DELTA metric
  ///  kind, INT64 value type, with no labels and a unit of "1". Such a metric
  ///  counts the number of log entries matching the `filter` expression.
  ///
  ///  The `name`, `type`, and `description` fields in the `metric_descriptor`
  ///  are output only, and is constructed using the `name` and `description`
  ///  field in the LogMetric.
  ///
  ///  To create a logs-based metric that records a distribution of log values, a
  ///  DELTA metric kind with a DISTRIBUTION value type must be used along with
  ///  a `value_extractor` expression in the LogMetric.
  ///
  ///  Each label in the metric descriptor must have a matching label
  ///  name as the key and an extractor expression as the value in the
  ///  `label_extractors` map.
  ///
  ///  The `metric_kind` and `value_type` fields in the `metric_descriptor` cannot
  ///  be updated once initially configured. New labels can be added in the
  ///  `metric_descriptor`, but existing labels cannot be modified except for
  ///  their description.
  @$pb.TagNumber(5)
  $69.MetricDescriptor get metricDescriptor => $_getN(4);
  @$pb.TagNumber(5)
  set metricDescriptor($69.MetricDescriptor v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasMetricDescriptor() => $_has(4);
  @$pb.TagNumber(5)
  void clearMetricDescriptor() => clearField(5);
  @$pb.TagNumber(5)
  $69.MetricDescriptor ensureMetricDescriptor() => $_ensure(4);

  ///  Optional. A `value_extractor` is required when using a distribution
  ///  logs-based metric to extract the values to record from a log entry.
  ///  Two functions are supported for value extraction: `EXTRACT(field)` or
  ///  `REGEXP_EXTRACT(field, regex)`. The arguments are:
  ///
  ///    1. field: The name of the log entry field from which the value is to be
  ///       extracted.
  ///    2. regex: A regular expression using the Google RE2 syntax
  ///       (https://github.com/google/re2/wiki/Syntax) with a single capture
  ///       group to extract data from the specified log entry field. The value
  ///       of the field is converted to a string before applying the regex.
  ///       It is an error to specify a regex that does not include exactly one
  ///       capture group.
  ///
  ///  The result of the extraction must be convertible to a double type, as the
  ///  distribution always records double values. If either the extraction or
  ///  the conversion to double fails, then those values are not recorded in the
  ///  distribution.
  ///
  ///  Example: `REGEXP_EXTRACT(jsonPayload.request, ".*quantity=(\d+).*")`
  @$pb.TagNumber(6)
  $core.String get valueExtractor => $_getSZ(5);
  @$pb.TagNumber(6)
  set valueExtractor($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasValueExtractor() => $_has(5);
  @$pb.TagNumber(6)
  void clearValueExtractor() => clearField(6);

  ///  Optional. A map from a label key string to an extractor expression which is
  ///  used to extract data from a log entry field and assign as the label value.
  ///  Each label key specified in the LabelDescriptor must have an associated
  ///  extractor expression in this map. The syntax of the extractor expression
  ///  is the same as for the `value_extractor` field.
  ///
  ///  The extracted value is converted to the type defined in the label
  ///  descriptor. If either the extraction or the type conversion fails,
  ///  the label will have a default value. The default value for a string
  ///  label is an empty string, for an integer label its 0, and for a boolean
  ///  label its `false`.
  ///
  ///  Note that there are upper bounds on the maximum number of labels and the
  ///  number of active time series that are allowed in a project.
  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.String> get labelExtractors => $_getMap(6);

  /// Optional. The `bucket_options` are required when the logs-based metric is
  /// using a DISTRIBUTION value type and it describes the bucket boundaries
  /// used to create a histogram of the extracted values.
  @$pb.TagNumber(8)
  $70.Distribution_BucketOptions get bucketOptions => $_getN(7);
  @$pb.TagNumber(8)
  set bucketOptions($70.Distribution_BucketOptions v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasBucketOptions() => $_has(7);
  @$pb.TagNumber(8)
  void clearBucketOptions() => clearField(8);
  @$pb.TagNumber(8)
  $70.Distribution_BucketOptions ensureBucketOptions() => $_ensure(7);

  ///  Output only. The creation timestamp of the metric.
  ///
  ///  This field may not be present for older metrics.
  @$pb.TagNumber(9)
  $50.Timestamp get createTime => $_getN(8);
  @$pb.TagNumber(9)
  set createTime($50.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasCreateTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreateTime() => clearField(9);
  @$pb.TagNumber(9)
  $50.Timestamp ensureCreateTime() => $_ensure(8);

  ///  Output only. The last update timestamp of the metric.
  ///
  ///  This field may not be present for older metrics.
  @$pb.TagNumber(10)
  $50.Timestamp get updateTime => $_getN(9);
  @$pb.TagNumber(10)
  set updateTime($50.Timestamp v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasUpdateTime() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdateTime() => clearField(10);
  @$pb.TagNumber(10)
  $50.Timestamp ensureUpdateTime() => $_ensure(9);

  /// Optional. If set to True, then this metric is disabled and it does not
  /// generate any points.
  @$pb.TagNumber(12)
  $core.bool get disabled => $_getBF(10);
  @$pb.TagNumber(12)
  set disabled($core.bool v) {
    $_setBool(10, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasDisabled() => $_has(10);
  @$pb.TagNumber(12)
  void clearDisabled() => clearField(12);

  ///  Optional. The resource name of the Log Bucket that owns the Log Metric.
  ///  Only Log Buckets in projects are supported. The bucket has to be in the
  ///  same project as the metric.
  ///
  ///  For example:
  ///
  ///    `projects/my-project/locations/global/buckets/my-bucket`
  ///
  ///  If empty, then the Log Metric is considered a non-Bucket Log Metric.
  @$pb.TagNumber(13)
  $core.String get bucketName => $_getSZ(11);
  @$pb.TagNumber(13)
  set bucketName($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(13)
  $core.bool hasBucketName() => $_has(11);
  @$pb.TagNumber(13)
  void clearBucketName() => clearField(13);
}

/// The parameters to ListLogMetrics.
class ListLogMetricsRequest extends $pb.GeneratedMessage {
  factory ListLogMetricsRequest({
    $core.String? parent,
    $core.String? pageToken,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  ListLogMetricsRequest._() : super();
  factory ListLogMetricsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogMetricsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogMetricsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogMetricsRequest clone() =>
      ListLogMetricsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogMetricsRequest copyWith(
          void Function(ListLogMetricsRequest) updates) =>
      super.copyWith((message) => updates(message as ListLogMetricsRequest))
          as ListLogMetricsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogMetricsRequest create() => ListLogMetricsRequest._();
  ListLogMetricsRequest createEmptyInstance() => create();
  static $pb.PbList<ListLogMetricsRequest> createRepeated() =>
      $pb.PbList<ListLogMetricsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLogMetricsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogMetricsRequest>(create);
  static ListLogMetricsRequest? _defaultInstance;

  ///  Required. The name of the project containing the metrics:
  ///
  ///      "projects/[PROJECT_ID]"
  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);

  /// Optional. If present, then retrieve the next batch of results from the
  /// preceding call to this method. `pageToken` must be the value of
  /// `nextPageToken` from the previous response. The values of other method
  /// parameters should be identical to those in the previous call.
  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  /// Optional. The maximum number of results to return from this request.
  /// Non-positive values are ignored. The presence of `nextPageToken` in the
  /// response indicates that more results might be available.
  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);
}

/// Result returned from ListLogMetrics.
class ListLogMetricsResponse extends $pb.GeneratedMessage {
  factory ListLogMetricsResponse({
    $core.Iterable<LogMetric>? metrics,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (metrics != null) {
      $result.metrics.addAll(metrics);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListLogMetricsResponse._() : super();
  factory ListLogMetricsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListLogMetricsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListLogMetricsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..pc<LogMetric>(1, _omitFieldNames ? '' : 'metrics', $pb.PbFieldType.PM,
        subBuilder: LogMetric.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListLogMetricsResponse clone() =>
      ListLogMetricsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListLogMetricsResponse copyWith(
          void Function(ListLogMetricsResponse) updates) =>
      super.copyWith((message) => updates(message as ListLogMetricsResponse))
          as ListLogMetricsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListLogMetricsResponse create() => ListLogMetricsResponse._();
  ListLogMetricsResponse createEmptyInstance() => create();
  static $pb.PbList<ListLogMetricsResponse> createRepeated() =>
      $pb.PbList<ListLogMetricsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListLogMetricsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListLogMetricsResponse>(create);
  static ListLogMetricsResponse? _defaultInstance;

  /// A list of logs-based metrics.
  @$pb.TagNumber(1)
  $core.List<LogMetric> get metrics => $_getList(0);

  /// If there might be more results than appear in this response, then
  /// `nextPageToken` is included. To get the next set of results, call this
  /// method again using the value of `nextPageToken` as `pageToken`.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

/// The parameters to GetLogMetric.
class GetLogMetricRequest extends $pb.GeneratedMessage {
  factory GetLogMetricRequest({
    $core.String? metricName,
  }) {
    final $result = create();
    if (metricName != null) {
      $result.metricName = metricName;
    }
    return $result;
  }
  GetLogMetricRequest._() : super();
  factory GetLogMetricRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetLogMetricRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLogMetricRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'metricName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetLogMetricRequest clone() => GetLogMetricRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetLogMetricRequest copyWith(void Function(GetLogMetricRequest) updates) =>
      super.copyWith((message) => updates(message as GetLogMetricRequest))
          as GetLogMetricRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLogMetricRequest create() => GetLogMetricRequest._();
  GetLogMetricRequest createEmptyInstance() => create();
  static $pb.PbList<GetLogMetricRequest> createRepeated() =>
      $pb.PbList<GetLogMetricRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLogMetricRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLogMetricRequest>(create);
  static GetLogMetricRequest? _defaultInstance;

  ///  Required. The resource name of the desired metric:
  ///
  ///      "projects/[PROJECT_ID]/metrics/[METRIC_ID]"
  @$pb.TagNumber(1)
  $core.String get metricName => $_getSZ(0);
  @$pb.TagNumber(1)
  set metricName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMetricName() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetricName() => clearField(1);
}

/// The parameters to CreateLogMetric.
class CreateLogMetricRequest extends $pb.GeneratedMessage {
  factory CreateLogMetricRequest({
    $core.String? parent,
    LogMetric? metric,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (metric != null) {
      $result.metric = metric;
    }
    return $result;
  }
  CreateLogMetricRequest._() : super();
  factory CreateLogMetricRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateLogMetricRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateLogMetricRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<LogMetric>(2, _omitFieldNames ? '' : 'metric',
        subBuilder: LogMetric.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateLogMetricRequest clone() =>
      CreateLogMetricRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateLogMetricRequest copyWith(
          void Function(CreateLogMetricRequest) updates) =>
      super.copyWith((message) => updates(message as CreateLogMetricRequest))
          as CreateLogMetricRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateLogMetricRequest create() => CreateLogMetricRequest._();
  CreateLogMetricRequest createEmptyInstance() => create();
  static $pb.PbList<CreateLogMetricRequest> createRepeated() =>
      $pb.PbList<CreateLogMetricRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateLogMetricRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateLogMetricRequest>(create);
  static CreateLogMetricRequest? _defaultInstance;

  ///  Required. The resource name of the project in which to create the metric:
  ///
  ///      "projects/[PROJECT_ID]"
  ///
  ///  The new metric must be provided in the request.
  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);

  /// Required. The new logs-based metric, which must not have an identifier that
  /// already exists.
  @$pb.TagNumber(2)
  LogMetric get metric => $_getN(1);
  @$pb.TagNumber(2)
  set metric(LogMetric v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMetric() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetric() => clearField(2);
  @$pb.TagNumber(2)
  LogMetric ensureMetric() => $_ensure(1);
}

/// The parameters to UpdateLogMetric.
class UpdateLogMetricRequest extends $pb.GeneratedMessage {
  factory UpdateLogMetricRequest({
    $core.String? metricName,
    LogMetric? metric,
  }) {
    final $result = create();
    if (metricName != null) {
      $result.metricName = metricName;
    }
    if (metric != null) {
      $result.metric = metric;
    }
    return $result;
  }
  UpdateLogMetricRequest._() : super();
  factory UpdateLogMetricRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateLogMetricRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateLogMetricRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'metricName')
    ..aOM<LogMetric>(2, _omitFieldNames ? '' : 'metric',
        subBuilder: LogMetric.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateLogMetricRequest clone() =>
      UpdateLogMetricRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateLogMetricRequest copyWith(
          void Function(UpdateLogMetricRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateLogMetricRequest))
          as UpdateLogMetricRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateLogMetricRequest create() => UpdateLogMetricRequest._();
  UpdateLogMetricRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateLogMetricRequest> createRepeated() =>
      $pb.PbList<UpdateLogMetricRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateLogMetricRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateLogMetricRequest>(create);
  static UpdateLogMetricRequest? _defaultInstance;

  ///  Required. The resource name of the metric to update:
  ///
  ///      "projects/[PROJECT_ID]/metrics/[METRIC_ID]"
  ///
  ///  The updated metric must be provided in the request and it's
  ///  `name` field must be the same as `[METRIC_ID]` If the metric
  ///  does not exist in `[PROJECT_ID]`, then a new metric is created.
  @$pb.TagNumber(1)
  $core.String get metricName => $_getSZ(0);
  @$pb.TagNumber(1)
  set metricName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMetricName() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetricName() => clearField(1);

  /// Required. The updated metric.
  @$pb.TagNumber(2)
  LogMetric get metric => $_getN(1);
  @$pb.TagNumber(2)
  set metric(LogMetric v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasMetric() => $_has(1);
  @$pb.TagNumber(2)
  void clearMetric() => clearField(2);
  @$pb.TagNumber(2)
  LogMetric ensureMetric() => $_ensure(1);
}

/// The parameters to DeleteLogMetric.
class DeleteLogMetricRequest extends $pb.GeneratedMessage {
  factory DeleteLogMetricRequest({
    $core.String? metricName,
  }) {
    final $result = create();
    if (metricName != null) {
      $result.metricName = metricName;
    }
    return $result;
  }
  DeleteLogMetricRequest._() : super();
  factory DeleteLogMetricRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteLogMetricRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteLogMetricRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.logging.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'metricName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteLogMetricRequest clone() =>
      DeleteLogMetricRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteLogMetricRequest copyWith(
          void Function(DeleteLogMetricRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteLogMetricRequest))
          as DeleteLogMetricRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteLogMetricRequest create() => DeleteLogMetricRequest._();
  DeleteLogMetricRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteLogMetricRequest> createRepeated() =>
      $pb.PbList<DeleteLogMetricRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteLogMetricRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteLogMetricRequest>(create);
  static DeleteLogMetricRequest? _defaultInstance;

  ///  Required. The resource name of the metric to delete:
  ///
  ///      "projects/[PROJECT_ID]/metrics/[METRIC_ID]"
  @$pb.TagNumber(1)
  $core.String get metricName => $_getSZ(0);
  @$pb.TagNumber(1)
  set metricName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMetricName() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetricName() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
