//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/metric_value.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/timestamp.pb.dart' as $50;
import 'distribution.pb.dart' as $108;

enum MetricValue_Value {
  boolValue,
  int64Value,
  doubleValue,
  stringValue,
  distributionValue,
  notSet
}

/// Represents a single metric value.
class MetricValue extends $pb.GeneratedMessage {
  factory MetricValue({
    $core.Map<$core.String, $core.String>? labels,
    $50.Timestamp? startTime,
    $50.Timestamp? endTime,
    $core.bool? boolValue,
    $fixnum.Int64? int64Value,
    $core.double? doubleValue,
    $core.String? stringValue,
    $108.Distribution? distributionValue,
  }) {
    final $result = create();
    if (labels != null) {
      $result.labels.addAll(labels);
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (boolValue != null) {
      $result.boolValue = boolValue;
    }
    if (int64Value != null) {
      $result.int64Value = int64Value;
    }
    if (doubleValue != null) {
      $result.doubleValue = doubleValue;
    }
    if (stringValue != null) {
      $result.stringValue = stringValue;
    }
    if (distributionValue != null) {
      $result.distributionValue = distributionValue;
    }
    return $result;
  }
  MetricValue._() : super();
  factory MetricValue.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MetricValue.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MetricValue_Value> _MetricValue_ValueByTag =
      {
    4: MetricValue_Value.boolValue,
    5: MetricValue_Value.int64Value,
    6: MetricValue_Value.doubleValue,
    7: MetricValue_Value.stringValue,
    8: MetricValue_Value.distributionValue,
    0: MetricValue_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetricValue',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7, 8])
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'labels',
        entryClassName: 'MetricValue.LabelsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.servicecontrol.v1'))
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'startTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(3, _omitFieldNames ? '' : 'endTime',
        subBuilder: $50.Timestamp.create)
    ..aOB(4, _omitFieldNames ? '' : 'boolValue')
    ..aInt64(5, _omitFieldNames ? '' : 'int64Value')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'doubleValue', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'stringValue')
    ..aOM<$108.Distribution>(8, _omitFieldNames ? '' : 'distributionValue',
        subBuilder: $108.Distribution.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MetricValue clone() => MetricValue()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MetricValue copyWith(void Function(MetricValue) updates) =>
      super.copyWith((message) => updates(message as MetricValue))
          as MetricValue;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetricValue create() => MetricValue._();
  MetricValue createEmptyInstance() => create();
  static $pb.PbList<MetricValue> createRepeated() => $pb.PbList<MetricValue>();
  @$core.pragma('dart2js:noInline')
  static MetricValue getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetricValue>(create);
  static MetricValue? _defaultInstance;

  MetricValue_Value whichValue() => _MetricValue_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  /// The labels describing the metric value.
  /// See comments on [google.api.servicecontrol.v1.Operation.labels][google.api.servicecontrol.v1.Operation.labels] for
  /// the overriding relationship.
  /// Note that this map must not contain monitored resource labels.
  @$pb.TagNumber(1)
  $core.Map<$core.String, $core.String> get labels => $_getMap(0);

  /// The start of the time period over which this metric value's measurement
  /// applies. The time period has different semantics for different metric
  /// types (cumulative, delta, and gauge). See the metric definition
  /// documentation in the service configuration for details. If not specified,
  /// [google.api.servicecontrol.v1.Operation.start_time][google.api.servicecontrol.v1.Operation.start_time] will be used.
  @$pb.TagNumber(2)
  $50.Timestamp get startTime => $_getN(1);
  @$pb.TagNumber(2)
  set startTime($50.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => clearField(2);
  @$pb.TagNumber(2)
  $50.Timestamp ensureStartTime() => $_ensure(1);

  /// The end of the time period over which this metric value's measurement
  /// applies.  If not specified,
  /// [google.api.servicecontrol.v1.Operation.end_time][google.api.servicecontrol.v1.Operation.end_time] will be used.
  @$pb.TagNumber(3)
  $50.Timestamp get endTime => $_getN(2);
  @$pb.TagNumber(3)
  set endTime($50.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEndTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTime() => clearField(3);
  @$pb.TagNumber(3)
  $50.Timestamp ensureEndTime() => $_ensure(2);

  /// A boolean value.
  @$pb.TagNumber(4)
  $core.bool get boolValue => $_getBF(3);
  @$pb.TagNumber(4)
  set boolValue($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasBoolValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoolValue() => clearField(4);

  /// A signed 64-bit integer value.
  @$pb.TagNumber(5)
  $fixnum.Int64 get int64Value => $_getI64(4);
  @$pb.TagNumber(5)
  set int64Value($fixnum.Int64 v) {
    $_setInt64(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasInt64Value() => $_has(4);
  @$pb.TagNumber(5)
  void clearInt64Value() => clearField(5);

  /// A double precision floating point value.
  @$pb.TagNumber(6)
  $core.double get doubleValue => $_getN(5);
  @$pb.TagNumber(6)
  set doubleValue($core.double v) {
    $_setDouble(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDoubleValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDoubleValue() => clearField(6);

  /// A text string value.
  @$pb.TagNumber(7)
  $core.String get stringValue => $_getSZ(6);
  @$pb.TagNumber(7)
  set stringValue($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasStringValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearStringValue() => clearField(7);

  /// A distribution value.
  @$pb.TagNumber(8)
  $108.Distribution get distributionValue => $_getN(7);
  @$pb.TagNumber(8)
  set distributionValue($108.Distribution v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasDistributionValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearDistributionValue() => clearField(8);
  @$pb.TagNumber(8)
  $108.Distribution ensureDistributionValue() => $_ensure(7);
}

/// Represents a set of metric values in the same metric.
/// Each metric value in the set should have a unique combination of start time,
/// end time, and label values.
class MetricValueSet extends $pb.GeneratedMessage {
  factory MetricValueSet({
    $core.String? metricName,
    $core.Iterable<MetricValue>? metricValues,
  }) {
    final $result = create();
    if (metricName != null) {
      $result.metricName = metricName;
    }
    if (metricValues != null) {
      $result.metricValues.addAll(metricValues);
    }
    return $result;
  }
  MetricValueSet._() : super();
  factory MetricValueSet.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MetricValueSet.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MetricValueSet',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'metricName')
    ..pc<MetricValue>(
        2, _omitFieldNames ? '' : 'metricValues', $pb.PbFieldType.PM,
        subBuilder: MetricValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MetricValueSet clone() => MetricValueSet()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MetricValueSet copyWith(void Function(MetricValueSet) updates) =>
      super.copyWith((message) => updates(message as MetricValueSet))
          as MetricValueSet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MetricValueSet create() => MetricValueSet._();
  MetricValueSet createEmptyInstance() => create();
  static $pb.PbList<MetricValueSet> createRepeated() =>
      $pb.PbList<MetricValueSet>();
  @$core.pragma('dart2js:noInline')
  static MetricValueSet getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MetricValueSet>(create);
  static MetricValueSet? _defaultInstance;

  /// The metric name defined in the service configuration.
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

  /// The values in this metric.
  @$pb.TagNumber(2)
  $core.List<MetricValue> get metricValues => $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
