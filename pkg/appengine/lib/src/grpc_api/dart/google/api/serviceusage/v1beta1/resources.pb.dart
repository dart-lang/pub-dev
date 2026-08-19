//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/api.pb.dart' as $84;
import '../../auth.pb.dart' as $88;
import '../../documentation.pb.dart' as $85;
import '../../endpoint.pb.dart' as $91;
import '../../monitored_resource.pb.dart' as $67;
import '../../monitoring.pb.dart' as $96;
import '../../quota.pb.dart' as $87;
import '../../usage.pb.dart' as $90;
import 'resources.pbenum.dart';

export 'resources.pbenum.dart';

/// A service that is available for use by the consumer.
class Service extends $pb.GeneratedMessage {
  factory Service({
    $core.String? name,
    ServiceConfig? config,
    State? state,
    $core.String? parent,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (config != null) {
      $result.config = config;
    }
    if (state != null) {
      $result.state = state;
    }
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  Service._() : super();
  factory Service.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Service.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Service',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<ServiceConfig>(2, _omitFieldNames ? '' : 'config',
        subBuilder: ServiceConfig.create)
    ..e<State>(4, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: State.STATE_UNSPECIFIED,
        valueOf: State.valueOf,
        enumValues: State.values)
    ..aOS(5, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Service clone() => Service()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Service copyWith(void Function(Service) updates) =>
      super.copyWith((message) => updates(message as Service)) as Service;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Service create() => Service._();
  Service createEmptyInstance() => create();
  static $pb.PbList<Service> createRepeated() => $pb.PbList<Service>();
  @$core.pragma('dart2js:noInline')
  static Service getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Service>(create);
  static Service? _defaultInstance;

  ///  The resource name of the consumer and service.
  ///
  ///  A valid name would be:
  ///  - `projects/123/services/serviceusage.googleapis.com`
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

  /// The service configuration of the available service.
  /// Some fields may be filtered out of the configuration in responses to
  /// the `ListServices` method. These fields are present only in responses to
  /// the `GetService` method.
  @$pb.TagNumber(2)
  ServiceConfig get config => $_getN(1);
  @$pb.TagNumber(2)
  set config(ServiceConfig v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfig() => clearField(2);
  @$pb.TagNumber(2)
  ServiceConfig ensureConfig() => $_ensure(1);

  /// Whether or not the service has been enabled for use by the consumer.
  @$pb.TagNumber(4)
  State get state => $_getN(2);
  @$pb.TagNumber(4)
  set state(State v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(2);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  ///  The resource name of the consumer.
  ///
  ///  A valid name would be:
  ///  - `projects/123`
  @$pb.TagNumber(5)
  $core.String get parent => $_getSZ(3);
  @$pb.TagNumber(5)
  set parent($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasParent() => $_has(3);
  @$pb.TagNumber(5)
  void clearParent() => clearField(5);
}

/// The configuration of the service.
class ServiceConfig extends $pb.GeneratedMessage {
  factory ServiceConfig({
    $core.String? name,
    $core.String? title,
    $core.Iterable<$84.Api>? apis,
    $85.Documentation? documentation,
    $87.Quota? quota,
    $88.Authentication? authentication,
    $90.Usage? usage,
    $core.Iterable<$91.Endpoint>? endpoints,
    $core.Iterable<$67.MonitoredResourceDescriptor>? monitoredResources,
    $96.Monitoring? monitoring,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (title != null) {
      $result.title = title;
    }
    if (apis != null) {
      $result.apis.addAll(apis);
    }
    if (documentation != null) {
      $result.documentation = documentation;
    }
    if (quota != null) {
      $result.quota = quota;
    }
    if (authentication != null) {
      $result.authentication = authentication;
    }
    if (usage != null) {
      $result.usage = usage;
    }
    if (endpoints != null) {
      $result.endpoints.addAll(endpoints);
    }
    if (monitoredResources != null) {
      $result.monitoredResources.addAll(monitoredResources);
    }
    if (monitoring != null) {
      $result.monitoring = monitoring;
    }
    return $result;
  }
  ServiceConfig._() : super();
  factory ServiceConfig.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceConfig.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceConfig',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..pc<$84.Api>(3, _omitFieldNames ? '' : 'apis', $pb.PbFieldType.PM,
        subBuilder: $84.Api.create)
    ..aOM<$85.Documentation>(6, _omitFieldNames ? '' : 'documentation',
        subBuilder: $85.Documentation.create)
    ..aOM<$87.Quota>(10, _omitFieldNames ? '' : 'quota',
        subBuilder: $87.Quota.create)
    ..aOM<$88.Authentication>(11, _omitFieldNames ? '' : 'authentication',
        subBuilder: $88.Authentication.create)
    ..aOM<$90.Usage>(15, _omitFieldNames ? '' : 'usage',
        subBuilder: $90.Usage.create)
    ..pc<$91.Endpoint>(
        18, _omitFieldNames ? '' : 'endpoints', $pb.PbFieldType.PM,
        subBuilder: $91.Endpoint.create)
    ..pc<$67.MonitoredResourceDescriptor>(
        25, _omitFieldNames ? '' : 'monitoredResources', $pb.PbFieldType.PM,
        subBuilder: $67.MonitoredResourceDescriptor.create)
    ..aOM<$96.Monitoring>(28, _omitFieldNames ? '' : 'monitoring',
        subBuilder: $96.Monitoring.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceConfig clone() => ServiceConfig()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceConfig copyWith(void Function(ServiceConfig) updates) =>
      super.copyWith((message) => updates(message as ServiceConfig))
          as ServiceConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceConfig create() => ServiceConfig._();
  ServiceConfig createEmptyInstance() => create();
  static $pb.PbList<ServiceConfig> createRepeated() =>
      $pb.PbList<ServiceConfig>();
  @$core.pragma('dart2js:noInline')
  static ServiceConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceConfig>(create);
  static ServiceConfig? _defaultInstance;

  ///  The DNS address at which this service is available.
  ///
  ///  An example DNS address would be:
  ///  `calendar.googleapis.com`.
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

  /// The product title for this service.
  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  /// A list of API interfaces exported by this service. Contains only the names,
  /// versions, and method names of the interfaces.
  @$pb.TagNumber(3)
  $core.List<$84.Api> get apis => $_getList(2);

  /// Additional API documentation. Contains only the summary and the
  /// documentation URL.
  @$pb.TagNumber(6)
  $85.Documentation get documentation => $_getN(3);
  @$pb.TagNumber(6)
  set documentation($85.Documentation v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDocumentation() => $_has(3);
  @$pb.TagNumber(6)
  void clearDocumentation() => clearField(6);
  @$pb.TagNumber(6)
  $85.Documentation ensureDocumentation() => $_ensure(3);

  /// Quota configuration.
  @$pb.TagNumber(10)
  $87.Quota get quota => $_getN(4);
  @$pb.TagNumber(10)
  set quota($87.Quota v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasQuota() => $_has(4);
  @$pb.TagNumber(10)
  void clearQuota() => clearField(10);
  @$pb.TagNumber(10)
  $87.Quota ensureQuota() => $_ensure(4);

  /// Auth configuration. Contains only the OAuth rules.
  @$pb.TagNumber(11)
  $88.Authentication get authentication => $_getN(5);
  @$pb.TagNumber(11)
  set authentication($88.Authentication v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasAuthentication() => $_has(5);
  @$pb.TagNumber(11)
  void clearAuthentication() => clearField(11);
  @$pb.TagNumber(11)
  $88.Authentication ensureAuthentication() => $_ensure(5);

  /// Configuration controlling usage of this service.
  @$pb.TagNumber(15)
  $90.Usage get usage => $_getN(6);
  @$pb.TagNumber(15)
  set usage($90.Usage v) {
    setField(15, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasUsage() => $_has(6);
  @$pb.TagNumber(15)
  void clearUsage() => clearField(15);
  @$pb.TagNumber(15)
  $90.Usage ensureUsage() => $_ensure(6);

  /// Configuration for network endpoints. Contains only the names and aliases
  /// of the endpoints.
  @$pb.TagNumber(18)
  $core.List<$91.Endpoint> get endpoints => $_getList(7);

  /// Defines the monitored resources used by this service. This is required
  /// by the [Service.monitoring][google.api.Service.monitoring] and
  /// [Service.logging][google.api.Service.logging] configurations.
  @$pb.TagNumber(25)
  $core.List<$67.MonitoredResourceDescriptor> get monitoredResources =>
      $_getList(8);

  /// Monitoring configuration.
  /// This should not include the 'producer_destinations' field.
  @$pb.TagNumber(28)
  $96.Monitoring get monitoring => $_getN(9);
  @$pb.TagNumber(28)
  set monitoring($96.Monitoring v) {
    setField(28, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasMonitoring() => $_has(9);
  @$pb.TagNumber(28)
  void clearMonitoring() => clearField(28);
  @$pb.TagNumber(28)
  $96.Monitoring ensureMonitoring() => $_ensure(9);
}

/// The operation metadata returned for the batchend services operation.
class OperationMetadata extends $pb.GeneratedMessage {
  factory OperationMetadata({
    $core.Iterable<$core.String>? resourceNames,
  }) {
    final $result = create();
    if (resourceNames != null) {
      $result.resourceNames.addAll(resourceNames);
    }
    return $result;
  }
  OperationMetadata._() : super();
  factory OperationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pPS(2, _omitFieldNames ? '' : 'resourceNames')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OperationMetadata clone() => OperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OperationMetadata copyWith(void Function(OperationMetadata) updates) =>
      super.copyWith((message) => updates(message as OperationMetadata))
          as OperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationMetadata create() => OperationMetadata._();
  OperationMetadata createEmptyInstance() => create();
  static $pb.PbList<OperationMetadata> createRepeated() =>
      $pb.PbList<OperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static OperationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationMetadata>(create);
  static OperationMetadata? _defaultInstance;

  /// The full name of the resources that this operation is directly
  /// associated with.
  @$pb.TagNumber(2)
  $core.List<$core.String> get resourceNames => $_getList(0);
}

/// Consumer quota settings for a quota metric.
class ConsumerQuotaMetric extends $pb.GeneratedMessage {
  factory ConsumerQuotaMetric({
    $core.String? name,
    $core.String? displayName,
    $core.Iterable<ConsumerQuotaLimit>? consumerQuotaLimits,
    $core.String? metric,
    $core.String? unit,
    $core.Iterable<ConsumerQuotaLimit>? descendantConsumerQuotaLimits,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (consumerQuotaLimits != null) {
      $result.consumerQuotaLimits.addAll(consumerQuotaLimits);
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (descendantConsumerQuotaLimits != null) {
      $result.descendantConsumerQuotaLimits
          .addAll(descendantConsumerQuotaLimits);
    }
    return $result;
  }
  ConsumerQuotaMetric._() : super();
  factory ConsumerQuotaMetric.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConsumerQuotaMetric.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConsumerQuotaMetric',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..pc<ConsumerQuotaLimit>(
        3, _omitFieldNames ? '' : 'consumerQuotaLimits', $pb.PbFieldType.PM,
        subBuilder: ConsumerQuotaLimit.create)
    ..aOS(4, _omitFieldNames ? '' : 'metric')
    ..aOS(5, _omitFieldNames ? '' : 'unit')
    ..pc<ConsumerQuotaLimit>(
        6,
        _omitFieldNames ? '' : 'descendantConsumerQuotaLimits',
        $pb.PbFieldType.PM,
        subBuilder: ConsumerQuotaLimit.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConsumerQuotaMetric clone() => ConsumerQuotaMetric()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConsumerQuotaMetric copyWith(void Function(ConsumerQuotaMetric) updates) =>
      super.copyWith((message) => updates(message as ConsumerQuotaMetric))
          as ConsumerQuotaMetric;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsumerQuotaMetric create() => ConsumerQuotaMetric._();
  ConsumerQuotaMetric createEmptyInstance() => create();
  static $pb.PbList<ConsumerQuotaMetric> createRepeated() =>
      $pb.PbList<ConsumerQuotaMetric>();
  @$core.pragma('dart2js:noInline')
  static ConsumerQuotaMetric getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConsumerQuotaMetric>(create);
  static ConsumerQuotaMetric? _defaultInstance;

  ///  The resource name of the quota settings on this metric for this consumer.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus`
  ///
  ///  The resource name is intended to be opaque and should not be parsed for
  ///  its component strings, since its representation could change in the future.
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

  ///  The display name of the metric.
  ///
  ///  An example name would be:
  ///  `CPUs`
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  /// The consumer quota for each quota limit defined on the metric.
  @$pb.TagNumber(3)
  $core.List<ConsumerQuotaLimit> get consumerQuotaLimits => $_getList(2);

  ///  The name of the metric.
  ///
  ///  An example name would be:
  ///  `compute.googleapis.com/cpus`
  @$pb.TagNumber(4)
  $core.String get metric => $_getSZ(3);
  @$pb.TagNumber(4)
  set metric($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMetric() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetric() => clearField(4);

  /// The units in which the metric value is reported.
  @$pb.TagNumber(5)
  $core.String get unit => $_getSZ(4);
  @$pb.TagNumber(5)
  set unit($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnit() => clearField(5);

  ///  The quota limits targeting the descendant containers of the
  ///  consumer in request.
  ///
  ///  If the consumer in request is of type `organizations`
  ///  or `folders`, the field will list per-project limits in the metric; if the
  ///  consumer in request is of type `project`, the field will be empty.
  ///
  ///  The `quota_buckets` field of each descendant consumer quota limit will not
  ///  be populated.
  @$pb.TagNumber(6)
  $core.List<ConsumerQuotaLimit> get descendantConsumerQuotaLimits =>
      $_getList(5);
}

/// Consumer quota settings for a quota limit.
class ConsumerQuotaLimit extends $pb.GeneratedMessage {
  factory ConsumerQuotaLimit({
    $core.String? name,
    $core.String? unit,
    $core.bool? isPrecise,
    $core.bool? allowsAdminOverrides,
    $core.String? metric,
    $core.Iterable<QuotaBucket>? quotaBuckets,
    $core.Iterable<$core.String>? supportedLocations,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (isPrecise != null) {
      $result.isPrecise = isPrecise;
    }
    if (allowsAdminOverrides != null) {
      $result.allowsAdminOverrides = allowsAdminOverrides;
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (quotaBuckets != null) {
      $result.quotaBuckets.addAll(quotaBuckets);
    }
    if (supportedLocations != null) {
      $result.supportedLocations.addAll(supportedLocations);
    }
    return $result;
  }
  ConsumerQuotaLimit._() : super();
  factory ConsumerQuotaLimit.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ConsumerQuotaLimit.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConsumerQuotaLimit',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'unit')
    ..aOB(3, _omitFieldNames ? '' : 'isPrecise')
    ..aOB(7, _omitFieldNames ? '' : 'allowsAdminOverrides')
    ..aOS(8, _omitFieldNames ? '' : 'metric')
    ..pc<QuotaBucket>(
        9, _omitFieldNames ? '' : 'quotaBuckets', $pb.PbFieldType.PM,
        subBuilder: QuotaBucket.create)
    ..pPS(11, _omitFieldNames ? '' : 'supportedLocations')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ConsumerQuotaLimit clone() => ConsumerQuotaLimit()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ConsumerQuotaLimit copyWith(void Function(ConsumerQuotaLimit) updates) =>
      super.copyWith((message) => updates(message as ConsumerQuotaLimit))
          as ConsumerQuotaLimit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConsumerQuotaLimit create() => ConsumerQuotaLimit._();
  ConsumerQuotaLimit createEmptyInstance() => create();
  static $pb.PbList<ConsumerQuotaLimit> createRepeated() =>
      $pb.PbList<ConsumerQuotaLimit>();
  @$core.pragma('dart2js:noInline')
  static ConsumerQuotaLimit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConsumerQuotaLimit>(create);
  static ConsumerQuotaLimit? _defaultInstance;

  ///  The resource name of the quota limit.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion`
  ///
  ///  The resource name is intended to be opaque and should not be parsed for
  ///  its component strings, since its representation could change in the future.
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

  ///  The limit unit.
  ///
  ///  An example unit would be
  ///  `1/{project}/{region}`
  ///  Note that `{project}` and `{region}` are not placeholders in this example;
  ///  the literal characters `{` and `}` occur in the string.
  @$pb.TagNumber(2)
  $core.String get unit => $_getSZ(1);
  @$pb.TagNumber(2)
  set unit($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUnit() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnit() => clearField(2);

  /// Whether this limit is precise or imprecise.
  @$pb.TagNumber(3)
  $core.bool get isPrecise => $_getBF(2);
  @$pb.TagNumber(3)
  set isPrecise($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasIsPrecise() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsPrecise() => clearField(3);

  /// Whether admin overrides are allowed on this limit
  @$pb.TagNumber(7)
  $core.bool get allowsAdminOverrides => $_getBF(3);
  @$pb.TagNumber(7)
  set allowsAdminOverrides($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasAllowsAdminOverrides() => $_has(3);
  @$pb.TagNumber(7)
  void clearAllowsAdminOverrides() => clearField(7);

  ///  The name of the parent metric of this limit.
  ///
  ///  An example name would be:
  ///  `compute.googleapis.com/cpus`
  @$pb.TagNumber(8)
  $core.String get metric => $_getSZ(4);
  @$pb.TagNumber(8)
  set metric($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasMetric() => $_has(4);
  @$pb.TagNumber(8)
  void clearMetric() => clearField(8);

  /// Summary of the enforced quota buckets, organized by quota dimension,
  /// ordered from least specific to most specific (for example, the global
  /// default bucket, with no quota dimensions, will always appear first).
  @$pb.TagNumber(9)
  $core.List<QuotaBucket> get quotaBuckets => $_getList(5);

  /// List of all supported locations.
  /// This field is present only if the limit has a {region} or {zone} dimension.
  @$pb.TagNumber(11)
  $core.List<$core.String> get supportedLocations => $_getList(6);
}

/// A quota bucket is a quota provisioning unit for a specific set of dimensions.
class QuotaBucket extends $pb.GeneratedMessage {
  factory QuotaBucket({
    $fixnum.Int64? effectiveLimit,
    $fixnum.Int64? defaultLimit,
    QuotaOverride? producerOverride,
    QuotaOverride? consumerOverride,
    QuotaOverride? adminOverride,
    $core.Map<$core.String, $core.String>? dimensions,
    ProducerQuotaPolicy? producerQuotaPolicy,
  }) {
    final $result = create();
    if (effectiveLimit != null) {
      $result.effectiveLimit = effectiveLimit;
    }
    if (defaultLimit != null) {
      $result.defaultLimit = defaultLimit;
    }
    if (producerOverride != null) {
      $result.producerOverride = producerOverride;
    }
    if (consumerOverride != null) {
      $result.consumerOverride = consumerOverride;
    }
    if (adminOverride != null) {
      $result.adminOverride = adminOverride;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (producerQuotaPolicy != null) {
      $result.producerQuotaPolicy = producerQuotaPolicy;
    }
    return $result;
  }
  QuotaBucket._() : super();
  factory QuotaBucket.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaBucket.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaBucket',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'effectiveLimit')
    ..aInt64(2, _omitFieldNames ? '' : 'defaultLimit')
    ..aOM<QuotaOverride>(3, _omitFieldNames ? '' : 'producerOverride',
        subBuilder: QuotaOverride.create)
    ..aOM<QuotaOverride>(4, _omitFieldNames ? '' : 'consumerOverride',
        subBuilder: QuotaOverride.create)
    ..aOM<QuotaOverride>(5, _omitFieldNames ? '' : 'adminOverride',
        subBuilder: QuotaOverride.create)
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'QuotaBucket.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.serviceusage.v1beta1'))
    ..aOM<ProducerQuotaPolicy>(7, _omitFieldNames ? '' : 'producerQuotaPolicy',
        subBuilder: ProducerQuotaPolicy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaBucket clone() => QuotaBucket()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaBucket copyWith(void Function(QuotaBucket) updates) =>
      super.copyWith((message) => updates(message as QuotaBucket))
          as QuotaBucket;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaBucket create() => QuotaBucket._();
  QuotaBucket createEmptyInstance() => create();
  static $pb.PbList<QuotaBucket> createRepeated() => $pb.PbList<QuotaBucket>();
  @$core.pragma('dart2js:noInline')
  static QuotaBucket getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaBucket>(create);
  static QuotaBucket? _defaultInstance;

  /// The effective limit of this quota bucket. Equal to default_limit if there
  /// are no overrides.
  @$pb.TagNumber(1)
  $fixnum.Int64 get effectiveLimit => $_getI64(0);
  @$pb.TagNumber(1)
  set effectiveLimit($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEffectiveLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearEffectiveLimit() => clearField(1);

  /// The default limit of this quota bucket, as specified by the service
  /// configuration.
  @$pb.TagNumber(2)
  $fixnum.Int64 get defaultLimit => $_getI64(1);
  @$pb.TagNumber(2)
  set defaultLimit($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDefaultLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearDefaultLimit() => clearField(2);

  /// Producer override on this quota bucket.
  @$pb.TagNumber(3)
  QuotaOverride get producerOverride => $_getN(2);
  @$pb.TagNumber(3)
  set producerOverride(QuotaOverride v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasProducerOverride() => $_has(2);
  @$pb.TagNumber(3)
  void clearProducerOverride() => clearField(3);
  @$pb.TagNumber(3)
  QuotaOverride ensureProducerOverride() => $_ensure(2);

  /// Consumer override on this quota bucket.
  @$pb.TagNumber(4)
  QuotaOverride get consumerOverride => $_getN(3);
  @$pb.TagNumber(4)
  set consumerOverride(QuotaOverride v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasConsumerOverride() => $_has(3);
  @$pb.TagNumber(4)
  void clearConsumerOverride() => clearField(4);
  @$pb.TagNumber(4)
  QuotaOverride ensureConsumerOverride() => $_ensure(3);

  /// Admin override on this quota bucket.
  @$pb.TagNumber(5)
  QuotaOverride get adminOverride => $_getN(4);
  @$pb.TagNumber(5)
  set adminOverride(QuotaOverride v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAdminOverride() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdminOverride() => clearField(5);
  @$pb.TagNumber(5)
  QuotaOverride ensureAdminOverride() => $_ensure(4);

  ///  The dimensions of this quota bucket.
  ///
  ///  If this map is empty, this is the global bucket, which is the default quota
  ///  value applied to all requests that do not have a more specific override.
  ///
  ///  If this map is nonempty, the default limit, effective limit, and quota
  ///  overrides apply only to requests that have the dimensions given in the map.
  ///
  ///  For example, if the map has key `region` and value `us-east-1`, then the
  ///  specified effective limit is only effective in that region, and the
  ///  specified overrides apply only in that region.
  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(5);

  /// Producer policy inherited from the closet ancestor of the current consumer.
  @$pb.TagNumber(7)
  ProducerQuotaPolicy get producerQuotaPolicy => $_getN(6);
  @$pb.TagNumber(7)
  set producerQuotaPolicy(ProducerQuotaPolicy v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasProducerQuotaPolicy() => $_has(6);
  @$pb.TagNumber(7)
  void clearProducerQuotaPolicy() => clearField(7);
  @$pb.TagNumber(7)
  ProducerQuotaPolicy ensureProducerQuotaPolicy() => $_ensure(6);
}

/// A quota override
class QuotaOverride extends $pb.GeneratedMessage {
  factory QuotaOverride({
    $core.String? name,
    $fixnum.Int64? overrideValue,
    $core.Map<$core.String, $core.String>? dimensions,
    $core.String? metric,
    $core.String? unit,
    $core.String? adminOverrideAncestor,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (overrideValue != null) {
      $result.overrideValue = overrideValue;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (adminOverrideAncestor != null) {
      $result.adminOverrideAncestor = adminOverrideAncestor;
    }
    return $result;
  }
  QuotaOverride._() : super();
  factory QuotaOverride.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QuotaOverride.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuotaOverride',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'overrideValue')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'QuotaOverride.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.serviceusage.v1beta1'))
    ..aOS(4, _omitFieldNames ? '' : 'metric')
    ..aOS(5, _omitFieldNames ? '' : 'unit')
    ..aOS(6, _omitFieldNames ? '' : 'adminOverrideAncestor')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QuotaOverride clone() => QuotaOverride()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QuotaOverride copyWith(void Function(QuotaOverride) updates) =>
      super.copyWith((message) => updates(message as QuotaOverride))
          as QuotaOverride;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuotaOverride create() => QuotaOverride._();
  QuotaOverride createEmptyInstance() => create();
  static $pb.PbList<QuotaOverride> createRepeated() =>
      $pb.PbList<QuotaOverride>();
  @$core.pragma('dart2js:noInline')
  static QuotaOverride getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuotaOverride>(create);
  static QuotaOverride? _defaultInstance;

  ///  The resource name of the override.
  ///  This name is generated by the server when the override is created.
  ///
  ///  Example names would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/adminOverrides/4a3f2c1d`
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/consumerOverrides/4a3f2c1d`
  ///
  ///  The resource name is intended to be opaque and should not be parsed for
  ///  its component strings, since its representation could change in the future.
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

  /// The overriding quota limit value.
  /// Can be any nonnegative integer, or -1 (unlimited quota).
  @$pb.TagNumber(2)
  $fixnum.Int64 get overrideValue => $_getI64(1);
  @$pb.TagNumber(2)
  set overrideValue($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOverrideValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverrideValue() => clearField(2);

  ///  If this map is nonempty, then this override applies only to specific values
  ///  for dimensions defined in the limit unit.
  ///
  ///  For example, an override on a limit with the unit `1/{project}/{region}`
  ///  could contain an entry with the key `region` and the value `us-east-1`;
  ///  the override is only applied to quota consumed in that region.
  ///
  ///  This map has the following restrictions:
  ///
  ///  *   Keys that are not defined in the limit's unit are not valid keys.
  ///      Any string appearing in `{brackets}` in the unit (besides `{project}`
  ///      or
  ///      `{user}`) is a defined key.
  ///  *   `project` is not a valid key; the project is already specified in
  ///      the parent resource name.
  ///  *   `user` is not a valid key; the API does not support quota overrides
  ///      that apply only to a specific user.
  ///  *   If `region` appears as a key, its value must be a valid Cloud region.
  ///  *   If `zone` appears as a key, its value must be a valid Cloud zone.
  ///  *   If any valid key other than `region` or `zone` appears in the map, then
  ///      all valid keys other than `region` or `zone` must also appear in the
  ///      map.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(2);

  ///  The name of the metric to which this override applies.
  ///
  ///  An example name would be:
  ///  `compute.googleapis.com/cpus`
  @$pb.TagNumber(4)
  $core.String get metric => $_getSZ(3);
  @$pb.TagNumber(4)
  set metric($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMetric() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetric() => clearField(4);

  ///  The limit unit of the limit to which this override applies.
  ///
  ///  An example unit would be:
  ///  `1/{project}/{region}`
  ///  Note that `{project}` and `{region}` are not placeholders in this example;
  ///  the literal characters `{` and `}` occur in the string.
  @$pb.TagNumber(5)
  $core.String get unit => $_getSZ(4);
  @$pb.TagNumber(5)
  set unit($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnit() => clearField(5);

  /// The resource name of the ancestor that requested the override. For example:
  /// `organizations/12345` or `folders/67890`.
  /// Used by admin overrides only.
  @$pb.TagNumber(6)
  $core.String get adminOverrideAncestor => $_getSZ(5);
  @$pb.TagNumber(6)
  set adminOverrideAncestor($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasAdminOverrideAncestor() => $_has(5);
  @$pb.TagNumber(6)
  void clearAdminOverrideAncestor() => clearField(6);
}

/// Import data embedded in the request message
class OverrideInlineSource extends $pb.GeneratedMessage {
  factory OverrideInlineSource({
    $core.Iterable<QuotaOverride>? overrides,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    return $result;
  }
  OverrideInlineSource._() : super();
  factory OverrideInlineSource.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OverrideInlineSource.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OverrideInlineSource',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: QuotaOverride.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OverrideInlineSource clone() =>
      OverrideInlineSource()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OverrideInlineSource copyWith(void Function(OverrideInlineSource) updates) =>
      super.copyWith((message) => updates(message as OverrideInlineSource))
          as OverrideInlineSource;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OverrideInlineSource create() => OverrideInlineSource._();
  OverrideInlineSource createEmptyInstance() => create();
  static $pb.PbList<OverrideInlineSource> createRepeated() =>
      $pb.PbList<OverrideInlineSource>();
  @$core.pragma('dart2js:noInline')
  static OverrideInlineSource getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OverrideInlineSource>(create);
  static OverrideInlineSource? _defaultInstance;

  /// The overrides to create.
  /// Each override must have a value for 'metric' and 'unit', to specify
  /// which metric and which limit the override should be applied to.
  /// The 'name' field of the override does not need to be set; it is ignored.
  @$pb.TagNumber(1)
  $core.List<QuotaOverride> get overrides => $_getList(0);
}

/// Quota policy created by service producer.
class ProducerQuotaPolicy extends $pb.GeneratedMessage {
  factory ProducerQuotaPolicy({
    $core.String? name,
    $fixnum.Int64? policyValue,
    $core.Map<$core.String, $core.String>? dimensions,
    $core.String? metric,
    $core.String? unit,
    $core.String? container,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (policyValue != null) {
      $result.policyValue = policyValue;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (container != null) {
      $result.container = container;
    }
    return $result;
  }
  ProducerQuotaPolicy._() : super();
  factory ProducerQuotaPolicy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ProducerQuotaPolicy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProducerQuotaPolicy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'policyValue')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'ProducerQuotaPolicy.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.serviceusage.v1beta1'))
    ..aOS(4, _omitFieldNames ? '' : 'metric')
    ..aOS(5, _omitFieldNames ? '' : 'unit')
    ..aOS(6, _omitFieldNames ? '' : 'container')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ProducerQuotaPolicy clone() => ProducerQuotaPolicy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ProducerQuotaPolicy copyWith(void Function(ProducerQuotaPolicy) updates) =>
      super.copyWith((message) => updates(message as ProducerQuotaPolicy))
          as ProducerQuotaPolicy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProducerQuotaPolicy create() => ProducerQuotaPolicy._();
  ProducerQuotaPolicy createEmptyInstance() => create();
  static $pb.PbList<ProducerQuotaPolicy> createRepeated() =>
      $pb.PbList<ProducerQuotaPolicy>();
  @$core.pragma('dart2js:noInline')
  static ProducerQuotaPolicy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProducerQuotaPolicy>(create);
  static ProducerQuotaPolicy? _defaultInstance;

  ///  The resource name of the policy.
  ///  This name is generated by the server when the policy is created.
  ///
  ///  Example names would be:
  ///  `organizations/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/producerQuotaPolicies/4a3f2c1d`
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

  /// The quota policy value.
  /// Can be any nonnegative integer, or -1 (unlimited quota).
  @$pb.TagNumber(2)
  $fixnum.Int64 get policyValue => $_getI64(1);
  @$pb.TagNumber(2)
  set policyValue($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPolicyValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyValue() => clearField(2);

  ///
  ///  If this map is nonempty, then this policy applies only to specific values
  ///  for dimensions defined in the limit unit.
  ///
  ///  For example, a policy on a limit with the unit `1/{project}/{region}`
  ///  could contain an entry with the key `region` and the value `us-east-1`;
  ///  the policy is only applied to quota consumed in that region.
  ///
  ///  This map has the following restrictions:
  ///
  ///  *   Keys that are not defined in the limit's unit are not valid keys.
  ///      Any string appearing in {brackets} in the unit (besides {project} or
  ///      {user}) is a defined key.
  ///  *   `project` is not a valid key; the project is already specified in
  ///      the parent resource name.
  ///  *   `user` is not a valid key; the API does not support quota policies
  ///      that apply only to a specific user.
  ///  *   If `region` appears as a key, its value must be a valid Cloud region.
  ///  *   If `zone` appears as a key, its value must be a valid Cloud zone.
  ///  *   If any valid key other than `region` or `zone` appears in the map, then
  ///      all valid keys other than `region` or `zone` must also appear in the
  ///      map.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(2);

  ///  The name of the metric to which this policy applies.
  ///
  ///  An example name would be:
  ///  `compute.googleapis.com/cpus`
  @$pb.TagNumber(4)
  $core.String get metric => $_getSZ(3);
  @$pb.TagNumber(4)
  set metric($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMetric() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetric() => clearField(4);

  ///  The limit unit of the limit to which this policy applies.
  ///
  ///  An example unit would be:
  ///  `1/{project}/{region}`
  ///  Note that `{project}` and `{region}` are not placeholders in this example;
  ///  the literal characters `{` and `}` occur in the string.
  @$pb.TagNumber(5)
  $core.String get unit => $_getSZ(4);
  @$pb.TagNumber(5)
  set unit($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnit() => clearField(5);

  /// The cloud resource container at which the quota policy is created. The
  /// format is `{container_type}/{container_number}`
  @$pb.TagNumber(6)
  $core.String get container => $_getSZ(5);
  @$pb.TagNumber(6)
  set container($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasContainer() => $_has(5);
  @$pb.TagNumber(6)
  void clearContainer() => clearField(6);
}

/// Quota policy created by quota administrator.
class AdminQuotaPolicy extends $pb.GeneratedMessage {
  factory AdminQuotaPolicy({
    $core.String? name,
    $fixnum.Int64? policyValue,
    $core.Map<$core.String, $core.String>? dimensions,
    $core.String? metric,
    $core.String? unit,
    $core.String? container,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (policyValue != null) {
      $result.policyValue = policyValue;
    }
    if (dimensions != null) {
      $result.dimensions.addAll(dimensions);
    }
    if (metric != null) {
      $result.metric = metric;
    }
    if (unit != null) {
      $result.unit = unit;
    }
    if (container != null) {
      $result.container = container;
    }
    return $result;
  }
  AdminQuotaPolicy._() : super();
  factory AdminQuotaPolicy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AdminQuotaPolicy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminQuotaPolicy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aInt64(2, _omitFieldNames ? '' : 'policyValue')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'dimensions',
        entryClassName: 'AdminQuotaPolicy.DimensionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.api.serviceusage.v1beta1'))
    ..aOS(4, _omitFieldNames ? '' : 'metric')
    ..aOS(5, _omitFieldNames ? '' : 'unit')
    ..aOS(6, _omitFieldNames ? '' : 'container')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AdminQuotaPolicy clone() => AdminQuotaPolicy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AdminQuotaPolicy copyWith(void Function(AdminQuotaPolicy) updates) =>
      super.copyWith((message) => updates(message as AdminQuotaPolicy))
          as AdminQuotaPolicy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminQuotaPolicy create() => AdminQuotaPolicy._();
  AdminQuotaPolicy createEmptyInstance() => create();
  static $pb.PbList<AdminQuotaPolicy> createRepeated() =>
      $pb.PbList<AdminQuotaPolicy>();
  @$core.pragma('dart2js:noInline')
  static AdminQuotaPolicy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminQuotaPolicy>(create);
  static AdminQuotaPolicy? _defaultInstance;

  ///  The resource name of the policy.
  ///  This name is generated by the server when the policy is created.
  ///
  ///  Example names would be:
  ///  `organizations/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/adminQuotaPolicies/4a3f2c1d`
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

  /// The quota policy value.
  /// Can be any nonnegative integer, or -1 (unlimited quota).
  @$pb.TagNumber(2)
  $fixnum.Int64 get policyValue => $_getI64(1);
  @$pb.TagNumber(2)
  set policyValue($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPolicyValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyValue() => clearField(2);

  ///
  ///  If this map is nonempty, then this policy applies only to specific values
  ///  for dimensions defined in the limit unit.
  ///
  ///  For example, a policy on a limit with the unit `1/{project}/{region}`
  ///  could contain an entry with the key `region` and the value `us-east-1`;
  ///  the policy is only applied to quota consumed in that region.
  ///
  ///  This map has the following restrictions:
  ///
  ///  *   If `region` appears as a key, its value must be a valid Cloud region.
  ///  *   If `zone` appears as a key, its value must be a valid Cloud zone.
  ///  *   Keys other than `region` or `zone` are not valid.
  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get dimensions => $_getMap(2);

  ///  The name of the metric to which this policy applies.
  ///
  ///  An example name would be:
  ///  `compute.googleapis.com/cpus`
  @$pb.TagNumber(4)
  $core.String get metric => $_getSZ(3);
  @$pb.TagNumber(4)
  set metric($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMetric() => $_has(3);
  @$pb.TagNumber(4)
  void clearMetric() => clearField(4);

  ///  The limit unit of the limit to which this policy applies.
  ///
  ///  An example unit would be:
  ///  `1/{project}/{region}`
  ///  Note that `{project}` and `{region}` are not placeholders in this example;
  ///  the literal characters `{` and `}` occur in the string.
  @$pb.TagNumber(5)
  $core.String get unit => $_getSZ(4);
  @$pb.TagNumber(5)
  set unit($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnit() => clearField(5);

  /// The cloud resource container at which the quota policy is created. The
  /// format is `{container_type}/{container_number}`
  @$pb.TagNumber(6)
  $core.String get container => $_getSZ(5);
  @$pb.TagNumber(6)
  set container($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasContainer() => $_has(5);
  @$pb.TagNumber(6)
  void clearContainer() => clearField(6);
}

/// Service identity for a service. This is the identity that service producer
/// should use to access consumer resources.
class ServiceIdentity extends $pb.GeneratedMessage {
  factory ServiceIdentity({
    $core.String? email,
    $core.String? uniqueId,
  }) {
    final $result = create();
    if (email != null) {
      $result.email = email;
    }
    if (uniqueId != null) {
      $result.uniqueId = uniqueId;
    }
    return $result;
  }
  ServiceIdentity._() : super();
  factory ServiceIdentity.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceIdentity.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceIdentity',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'uniqueId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceIdentity clone() => ServiceIdentity()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceIdentity copyWith(void Function(ServiceIdentity) updates) =>
      super.copyWith((message) => updates(message as ServiceIdentity))
          as ServiceIdentity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceIdentity create() => ServiceIdentity._();
  ServiceIdentity createEmptyInstance() => create();
  static $pb.PbList<ServiceIdentity> createRepeated() =>
      $pb.PbList<ServiceIdentity>();
  @$core.pragma('dart2js:noInline')
  static ServiceIdentity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceIdentity>(create);
  static ServiceIdentity? _defaultInstance;

  /// The email address of the service account that a service producer would use
  /// to access consumer resources.
  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  /// The unique and stable id of the service account.
  /// https://cloud.google.com/iam/reference/rest/v1/projects.serviceAccounts#ServiceAccount
  @$pb.TagNumber(2)
  $core.String get uniqueId => $_getSZ(1);
  @$pb.TagNumber(2)
  set uniqueId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUniqueId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUniqueId() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
