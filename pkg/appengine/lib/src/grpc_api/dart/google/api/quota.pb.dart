//
//  Generated code. Do not modify.
//  source: google/api/quota.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

///  Quota configuration helps to achieve fairness and budgeting in service
///  usage.
///
///  The metric based quota configuration works this way:
///  - The service configuration defines a set of metrics.
///  - For API calls, the quota.metric_rules maps methods to metrics with
///    corresponding costs.
///  - The quota.limits defines limits on the metrics, which will be used for
///    quota checks at runtime.
///
///  An example quota configuration in yaml format:
///
///     quota:
///       limits:
///
///       - name: apiWriteQpsPerProject
///         metric: library.googleapis.com/write_calls
///         unit: "1/min/{project}"  # rate limit for consumer projects
///         values:
///           STANDARD: 10000
///
///
///       (The metric rules bind all methods to the read_calls metric,
///        except for the UpdateBook and DeleteBook methods. These two methods
///        are mapped to the write_calls metric, with the UpdateBook method
///        consuming at twice rate as the DeleteBook method.)
///       metric_rules:
///       - selector: "*"
///         metric_costs:
///           library.googleapis.com/read_calls: 1
///       - selector: google.example.library.v1.LibraryService.UpdateBook
///         metric_costs:
///           library.googleapis.com/write_calls: 2
///       - selector: google.example.library.v1.LibraryService.DeleteBook
///         metric_costs:
///           library.googleapis.com/write_calls: 1
///
///   Corresponding Metric definition:
///
///       metrics:
///       - name: library.googleapis.com/read_calls
///         display_name: Read requests
///         metric_kind: DELTA
///         value_type: INT64
///
///       - name: library.googleapis.com/write_calls
///         display_name: Write requests
///         metric_kind: DELTA
///         value_type: INT64
class Quota extends $pb.GeneratedMessage {
  factory Quota({
    $core.Iterable<QuotaLimit>? limits,
    $core.Iterable<MetricRule>? metricRules,
  }) {
    final $result = create();
    if (limits != null) {
      $result.limits.addAll(limits);
    }
    if (metricRules != null) {
      $result.metricRules.addAll(metricRules);
    }
    return $result;
  }
  Quota._() : super();
  factory Quota.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Quota.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Quota',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<QuotaLimit>(3, _omitFieldNames ? '' : 'limits', $pb.PbFieldType.PM,
        subBuilder: QuotaLimit.create)
    ..pc<MetricRule>(
        4, _omitFieldNames ? '' : 'metricRules', $pb.PbFieldType.PM,
        subBuilder: MetricRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Quota clone() => Quota()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Quota copyWith(void Function(Quota) updates) =>
      super.copyWith((message) => updates(message as Quota)) as Quota;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Quota create() => Quota._();
  Quota createEmptyInstance() => create();
  static $pb.PbList<Quota> createRepeated() => $pb.PbList<Quota>();
  @$core.pragma('dart2js:noInline')
  static Quota getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Quota>(create);
  static Quota? _defaultInstance;

  /// List of QuotaLimit definitions for the service.
  @$pb.TagNumber(3)
  $core.List<QuotaLimit> get limits => $_getList(0);

  /// List of MetricRule definitions, each one mapping a selected method to one
  /// or more metrics.
  @$pb.TagNumber(4)
  $core.List<MetricRule> get metricRules => $_getList(1);
}

/// Bind API methods to metrics. Binding a method to a metric causes that
/// metric's configured quota behaviors to apply to the method call.
class MetricRule extends $pb.GeneratedMessage {
  factory MetricRule({
    $core.String? selector,
    $core.Map<$core.String, $fixnum.Int64>? metricCosts,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (metricCosts != null) {
      $result.metricCosts.addAll(metricCosts);
    }
    return $result;
  }
  MetricRule._() : super();
  factory MetricRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MetricRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetricRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..m<$core.String, $fixnum.Int64>(2, _omitFieldNames ? '' : 'metricCosts',
        entryClassName: 'MetricRule.MetricCostsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('google.api'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MetricRule clone() => MetricRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MetricRule copyWith(void Function(MetricRule) updates) =>
      super.copyWith((message) => updates(message as MetricRule)) as MetricRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetricRule create() => MetricRule._();
  MetricRule createEmptyInstance() => create();
  static $pb.PbList<MetricRule> createRepeated() => $pb.PbList<MetricRule>();
  @$core.pragma('dart2js:noInline')
  static MetricRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetricRule>(create);
  static MetricRule? _defaultInstance;

  ///  Selects the methods to which this rule applies.
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  ///  Metrics to update when the selected methods are called, and the associated
  ///  cost applied to each metric.
  ///
  ///  The key of the map is the metric name, and the values are the amount
  ///  increased for the metric against which the quota limits are defined.
  ///  The value must not be negative.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $fixnum.Int64> get metricCosts => $_getMap(1);
}

/// `QuotaLimit` defines a specific limit that applies over a specified duration
/// for a limit type. There can be at most one limit for a duration and limit
/// type combination defined within a `QuotaGroup`.
class QuotaLimit extends $pb.GeneratedMessage {
  factory QuotaLimit({
    $core.String? description,
    $fixnum.Int64? defaultLimit,
    $fixnum.Int64? maxLimit,
    $core.String? duration,
    $core.String? name,
    $fixnum.Int64? freeTier,
    $core.String? metric,
    $core.String? unit,
    $core.Map<$core.String, $fixnum.Int64>? values,
    $core.String? displayName,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (defaultLimit != null) {
      $result.defaultLimit = defaultLimit;
    }
    if (maxLimit != null) {
      $result.maxLimit = maxLimit;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (name != null) {
      $result.name = name;
    }
    if (freeTier != null) {
      $result.freeTier = freeTier;
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (values != null) {
      $result.values.addAll(values);
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    return $result;
  }
  QuotaLimit._() : super();
  factory QuotaLimit.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaLimit.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaLimit',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aInt64(3, _omitFieldNames ? '' : 'defaultLimit')
    ..aInt64(4, _omitFieldNames ? '' : 'maxLimit')
    ..aOS(5, _omitFieldNames ? '' : 'duration')
    ..aOS(6, _omitFieldNames ? '' : 'name')
    ..aInt64(7, _omitFieldNames ? '' : 'freeTier')
    ..aOS(8, _omitFieldNames ? '' : 'metric')
    ..aOS(9, _omitFieldNames ? '' : 'unit')
    ..m<$core.String, $fixnum.Int64>(10, _omitFieldNames ? '' : 'values',
        entryClassName: 'QuotaLimit.ValuesEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O6,
        packageName: const $pb.PackageName('google.api'))
    ..aOS(12, _omitFieldNames ? '' : 'displayName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaLimit clone() => QuotaLimit()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaLimit copyWith(void Function(QuotaLimit) updates) =>
      super.copyWith((message) => updates(message as QuotaLimit)) as QuotaLimit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaLimit create() => QuotaLimit._();
  QuotaLimit createEmptyInstance() => create();
  static $pb.PbList<QuotaLimit> createRepeated() => $pb.PbList<QuotaLimit>();
  @$core.pragma('dart2js:noInline')
  static QuotaLimit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaLimit>(create);
  static QuotaLimit? _defaultInstance;

  /// Optional. User-visible, extended description for this quota limit.
  /// Should be used only when more context is needed to understand this limit
  /// than provided by the limit's display name (see: `display_name`).
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(2)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  ///  Default number of tokens that can be consumed during the specified
  ///  duration. This is the number of tokens assigned when a client
  ///  application developer activates the service for his/her project.
  ///
  ///  Specifying a value of 0 will block all requests. This can be used if you
  ///  are provisioning quota to selected consumers and blocking others.
  ///  Similarly, a value of -1 will indicate an unlimited quota. No other
  ///  negative values are allowed.
  ///
  ///  Used by group-based quotas only.
  @$pb.TagNumber(3)
  $fixnum.Int64 get defaultLimit => $_getI64(1);
  @$pb.TagNumber(3)
  set defaultLimit($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDefaultLimit() => $_has(1);
  @$pb.TagNumber(3)
  void clearDefaultLimit() => clearField(3);

  ///  Maximum number of tokens that can be consumed during the specified
  ///  duration. Client application developers can override the default limit up
  ///  to this maximum. If specified, this value cannot be set to a value less
  ///  than the default limit. If not specified, it is set to the default limit.
  ///
  ///  To allow clients to apply overrides with no upper bound, set this to -1,
  ///  indicating unlimited maximum quota.
  ///
  ///  Used by group-based quotas only.
  @$pb.TagNumber(4)
  $fixnum.Int64 get maxLimit => $_getI64(2);
  @$pb.TagNumber(4)
  set maxLimit($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMaxLimit() => $_has(2);
  @$pb.TagNumber(4)
  void clearMaxLimit() => clearField(4);

  ///  Duration of this limit in textual notation. Must be "100s" or "1d".
  ///
  ///  Used by group-based quotas only.
  @$pb.TagNumber(5)
  $core.String get duration => $_getSZ(3);
  @$pb.TagNumber(5)
  set duration($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(3);
  @$pb.TagNumber(5)
  void clearDuration() => clearField(5);

  ///  Name of the quota limit.
  ///
  ///  The name must be provided, and it must be unique within the service. The
  ///  name can only include alphanumeric characters as well as '-'.
  ///
  ///  The maximum length of the limit name is 64 characters.
  @$pb.TagNumber(6)
  $core.String get name => $_getSZ(4);
  @$pb.TagNumber(6)
  set name($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasName() => $_has(4);
  @$pb.TagNumber(6)
  void clearName() => clearField(6);

  ///  Free tier value displayed in the Developers Console for this limit.
  ///  The free tier is the number of tokens that will be subtracted from the
  ///  billed amount when billing is enabled.
  ///  This field can only be set on a limit with duration "1d", in a billable
  ///  group; it is invalid on any other limit. If this field is not set, it
  ///  defaults to 0, indicating that there is no free tier for this service.
  ///
  ///  Used by group-based quotas only.
  @$pb.TagNumber(7)
  $fixnum.Int64 get freeTier => $_getI64(5);
  @$pb.TagNumber(7)
  set freeTier($fixnum.Int64 v) {
    $_setInt64(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasFreeTier() => $_has(5);
  @$pb.TagNumber(7)
  void clearFreeTier() => clearField(7);

  /// The name of the metric this quota limit applies to. The quota limits with
  /// the same metric will be checked together during runtime. The metric must be
  /// defined within the service config.
  @$pb.TagNumber(8)
  $core.String get metric => $_getSZ(6);
  @$pb.TagNumber(8)
  set metric($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasMetric() => $_has(6);
  @$pb.TagNumber(8)
  void clearMetric() => clearField(8);

  ///  Specify the unit of the quota limit. It uses the same syntax as
  ///  [Metric.unit][]. The supported unit kinds are determined by the quota
  ///  backend system.
  ///
  ///  Here are some examples:
  ///  * "1/min/{project}" for quota per minute per project.
  ///
  ///  Note: the order of unit components is insignificant.
  ///  The "1" at the beginning is required to follow the metric unit syntax.
  @$pb.TagNumber(9)
  $core.String get unit => $_getSZ(7);
  @$pb.TagNumber(9)
  set unit($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasUnit() => $_has(7);
  @$pb.TagNumber(9)
  void clearUnit() => clearField(9);

  /// Tiered limit values. You must specify this as a key:value pair, with an
  /// integer value that is the maximum number of requests allowed for the
  /// specified unit. Currently only STANDARD is supported.
  @$pb.TagNumber(10)
  $core.Map<$core.String, $fixnum.Int64> get values => $_getMap(8);

  /// User-visible display name for this limit.
  /// Optional. If not set, the UI will provide a default display name based on
  /// the quota configuration. This field can be used to override the default
  /// display name generated from the configuration.
  @$pb.TagNumber(12)
  $core.String get displayName => $_getSZ(9);
  @$pb.TagNumber(12)
  set displayName($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasDisplayName() => $_has(9);
  @$pb.TagNumber(12)
  void clearDisplayName() => clearField(12);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
