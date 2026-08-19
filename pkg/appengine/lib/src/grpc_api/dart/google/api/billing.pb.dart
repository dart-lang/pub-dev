//
//  Generated code. Do not modify.
//  source: google/api/billing.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Configuration of a specific billing destination (Currently only support
/// bill against consumer project).
class Billing_BillingDestination extends $pb.GeneratedMessage {
  factory Billing_BillingDestination({
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
  Billing_BillingDestination._() : super();
  factory Billing_BillingDestination.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Billing_BillingDestination.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Billing.BillingDestination',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'monitoredResource')
    ..pPS(2, _omitFieldNames ? '' : 'metrics')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Billing_BillingDestination clone() =>
      Billing_BillingDestination()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Billing_BillingDestination copyWith(
          void Function(Billing_BillingDestination) updates) =>
      super.copyWith(
              (message) => updates(message as Billing_BillingDestination))
          as Billing_BillingDestination;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Billing_BillingDestination create() => Billing_BillingDestination._();
  Billing_BillingDestination createEmptyInstance() => create();
  static $pb.PbList<Billing_BillingDestination> createRepeated() =>
      $pb.PbList<Billing_BillingDestination>();
  @$core.pragma('dart2js:noInline')
  static Billing_BillingDestination getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Billing_BillingDestination>(create);
  static Billing_BillingDestination? _defaultInstance;

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

  /// Names of the metrics to report to this billing destination.
  /// Each name must be defined in
  /// [Service.metrics][google.api.Service.metrics] section.
  @$pb.TagNumber(2)
  $core.List<$core.String> get metrics => $_getList(1);
}

///  Billing related configuration of the service.
///
///  The following example shows how to configure monitored resources and metrics
///  for billing, `consumer_destinations` is the only supported destination and
///  the monitored resources need at least one label key
///  `cloud.googleapis.com/location` to indicate the location of the billing
///  usage, using different monitored resources between monitoring and billing is
///  recommended so they can be evolved independently:
///
///
///      monitored_resources:
///      - type: library.googleapis.com/billing_branch
///        labels:
///        - key: cloud.googleapis.com/location
///          description: |
///            Predefined label to support billing location restriction.
///        - key: city
///          description: |
///            Custom label to define the city where the library branch is located
///            in.
///        - key: name
///          description: Custom label to define the name of the library branch.
///      metrics:
///      - name: library.googleapis.com/book/borrowed_count
///        metric_kind: DELTA
///        value_type: INT64
///        unit: "1"
///      billing:
///        consumer_destinations:
///        - monitored_resource: library.googleapis.com/billing_branch
///          metrics:
///          - library.googleapis.com/book/borrowed_count
class Billing extends $pb.GeneratedMessage {
  factory Billing({
    $core.Iterable<Billing_BillingDestination>? consumerDestinations,
  }) {
    final $result = create();
    if (consumerDestinations != null) {
      $result.consumerDestinations.addAll(consumerDestinations);
    }
    return $result;
  }
  Billing._() : super();
  factory Billing.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Billing.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Billing',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<Billing_BillingDestination>(
        8, _omitFieldNames ? '' : 'consumerDestinations', $pb.PbFieldType.PM,
        subBuilder: Billing_BillingDestination.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Billing clone() => Billing()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Billing copyWith(void Function(Billing) updates) =>
      super.copyWith((message) => updates(message as Billing)) as Billing;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Billing create() => Billing._();
  Billing createEmptyInstance() => create();
  static $pb.PbList<Billing> createRepeated() => $pb.PbList<Billing>();
  @$core.pragma('dart2js:noInline')
  static Billing getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Billing>(create);
  static Billing? _defaultInstance;

  /// Billing configurations for sending metrics to the consumer project.
  /// There can be multiple consumer destinations per service, each one must have
  /// a different monitored resource type. A metric can be used in at most
  /// one consumer destination.
  @$pb.TagNumber(8)
  $core.List<Billing_BillingDestination> get consumerDestinations =>
      $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
