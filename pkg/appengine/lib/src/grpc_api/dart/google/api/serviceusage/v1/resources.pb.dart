//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/resources.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
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
  ///  - projects/123/services/serviceusage.googleapis.com
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
  ///  - projects/123
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
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

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
