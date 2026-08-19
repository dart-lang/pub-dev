//
//  Generated code. Do not modify.
//  source: google/api/monitoring.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Configuration of a specific monitoring destination (the producer project
/// or the consumer project).
class Monitoring_MonitoringDestination extends $pb.GeneratedMessage {
  factory Monitoring_MonitoringDestination({
    $core.String? monitoredResource,
    $core.Iterable<$core.String>? metrics,
  }) {
    final $result = create();
    if (monitoredResource != null) {
      $result.monitoredResource = monitoredResource;
    }
    if (metrics != null) {
      $result.metrics.addAll(metrics);
    }
    return $result;
  }
  Monitoring_MonitoringDestination._() : super();
  factory Monitoring_MonitoringDestination.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Monitoring_MonitoringDestination.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Monitoring.MonitoringDestination',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'monitoredResource')
    ..pPS(2, _omitFieldNames ? '' : 'metrics')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Monitoring_MonitoringDestination clone() =>
      Monitoring_MonitoringDestination()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Monitoring_MonitoringDestination copyWith(
          void Function(Monitoring_MonitoringDestination) updates) =>
      super.copyWith(
              (message) => updates(message as Monitoring_MonitoringDestination))
          as Monitoring_MonitoringDestination;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Monitoring_MonitoringDestination create() =>
      Monitoring_MonitoringDestination._();
  Monitoring_MonitoringDestination createEmptyInstance() => create();
  static $pb.PbList<Monitoring_MonitoringDestination> createRepeated() =>
      $pb.PbList<Monitoring_MonitoringDestination>();
  @$core.pragma('dart2js:noInline')
  static Monitoring_MonitoringDestination getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Monitoring_MonitoringDestination>(
          create);
  static Monitoring_MonitoringDestination? _defaultInstance;

  /// The monitored resource type. The type must be defined in
  /// [Service.monitored_resources][google.api.Service.monitored_resources]
  /// section.
  @$pb.TagNumber(1)
  $core.String get monitoredResource => $_getSZ(0);
  @$pb.TagNumber(1)
  set monitoredResource($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMonitoredResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonitoredResource() => clearField(1);

  /// Types of the metrics to report to this monitoring destination.
  /// Each type must be defined in
  /// [Service.metrics][google.api.Service.metrics] section.
  @$pb.TagNumber(2)
  $core.List<$core.String> get metrics => $_getList(1);
}

///  Monitoring configuration of the service.
///
///  The example below shows how to configure monitored resources and metrics
///  for monitoring. In the example, a monitored resource and two metrics are
///  defined. The `library.googleapis.com/book/returned_count` metric is sent
///  to both producer and consumer projects, whereas the
///  `library.googleapis.com/book/num_overdue` metric is only sent to the
///  consumer project.
///
///      monitored_resources:
///      - type: library.googleapis.com/Branch
///        display_name: "Library Branch"
///        description: "A branch of a library."
///        launch_stage: GA
///        labels:
///        - key: resource_container
///          description: "The Cloud container (ie. project id) for the Branch."
///        - key: location
///          description: "The location of the library branch."
///        - key: branch_id
///          description: "The id of the branch."
///      metrics:
///      - name: library.googleapis.com/book/returned_count
///        display_name: "Books Returned"
///        description: "The count of books that have been returned."
///        launch_stage: GA
///        metric_kind: DELTA
///        value_type: INT64
///        unit: "1"
///        labels:
///        - key: customer_id
///          description: "The id of the customer."
///      - name: library.googleapis.com/book/num_overdue
///        display_name: "Books Overdue"
///        description: "The current number of overdue books."
///        launch_stage: GA
///        metric_kind: GAUGE
///        value_type: INT64
///        unit: "1"
///        labels:
///        - key: customer_id
///          description: "The id of the customer."
///      monitoring:
///        producer_destinations:
///        - monitored_resource: library.googleapis.com/Branch
///          metrics:
///          - library.googleapis.com/book/returned_count
///        consumer_destinations:
///        - monitored_resource: library.googleapis.com/Branch
///          metrics:
///          - library.googleapis.com/book/returned_count
///          - library.googleapis.com/book/num_overdue
class Monitoring extends $pb.GeneratedMessage {
  factory Monitoring({
    $core.Iterable<Monitoring_MonitoringDestination>? producerDestinations,
    $core.Iterable<Monitoring_MonitoringDestination>? consumerDestinations,
  }) {
    final $result = create();
    if (producerDestinations != null) {
      $result.producerDestinations.addAll(producerDestinations);
    }
    if (consumerDestinations != null) {
      $result.consumerDestinations.addAll(consumerDestinations);
    }
    return $result;
  }
  Monitoring._() : super();
  factory Monitoring.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Monitoring.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Monitoring',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<Monitoring_MonitoringDestination>(
        1, _omitFieldNames ? '' : 'producerDestinations', $pb.PbFieldType.PM,
        subBuilder: Monitoring_MonitoringDestination.create)
    ..pc<Monitoring_MonitoringDestination>(
        2, _omitFieldNames ? '' : 'consumerDestinations', $pb.PbFieldType.PM,
        subBuilder: Monitoring_MonitoringDestination.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Monitoring clone() => Monitoring()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Monitoring copyWith(void Function(Monitoring) updates) =>
      super.copyWith((message) => updates(message as Monitoring)) as Monitoring;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Monitoring create() => Monitoring._();
  Monitoring createEmptyInstance() => create();
  static $pb.PbList<Monitoring> createRepeated() => $pb.PbList<Monitoring>();
  @$core.pragma('dart2js:noInline')
  static Monitoring getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Monitoring>(create);
  static Monitoring? _defaultInstance;

  /// Monitoring configurations for sending metrics to the producer project.
  /// There can be multiple producer destinations. A monitored resource type may
  /// appear in multiple monitoring destinations if different aggregations are
  /// needed for different sets of metrics associated with that monitored
  /// resource type. A monitored resource and metric pair may only be used once
  /// in the Monitoring configuration.
  @$pb.TagNumber(1)
  $core.List<Monitoring_MonitoringDestination> get producerDestinations =>
      $_getList(0);

  /// Monitoring configurations for sending metrics to the consumer project.
  /// There can be multiple consumer destinations. A monitored resource type may
  /// appear in multiple monitoring destinations if different aggregations are
  /// needed for different sets of metrics associated with that monitored
  /// resource type. A monitored resource and metric pair may only be used once
  /// in the Monitoring configuration.
  @$pb.TagNumber(2)
  $core.List<Monitoring_MonitoringDestination> get consumerDestinations =>
      $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
