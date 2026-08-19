//
//  Generated code. Do not modify.
//  source: google/api/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/api.pb.dart' as $84;
import '../protobuf/type.pb.dart' as $83;
import '../protobuf/wrappers.pb.dart' as $73;
import 'auth.pb.dart' as $88;
import 'backend.pb.dart' as $86;
import 'billing.pb.dart' as $94;
import 'client.pb.dart' as $99;
import 'context.pb.dart' as $89;
import 'control.pb.dart' as $92;
import 'documentation.pb.dart' as $85;
import 'endpoint.pb.dart' as $91;
import 'http.pb.dart' as $55;
import 'log.pb.dart' as $93;
import 'logging.pb.dart' as $95;
import 'metric.pb.dart' as $69;
import 'monitored_resource.pb.dart' as $67;
import 'monitoring.pb.dart' as $96;
import 'quota.pb.dart' as $87;
import 'source_info.pb.dart' as $98;
import 'system_parameter.pb.dart' as $97;
import 'usage.pb.dart' as $90;

///  `Service` is the root object of Google API service configuration (service
///  config). It describes the basic information about a logical service,
///  such as the service name and the user-facing title, and delegates other
///  aspects to sub-sections. Each sub-section is either a proto message or a
///  repeated proto message that configures a specific aspect, such as auth.
///  For more information, see each proto message definition.
///
///  Example:
///
///      type: google.api.Service
///      name: calendar.googleapis.com
///      title: Google Calendar API
///      apis:
///      - name: google.calendar.v3.Calendar
///
///      visibility:
///        rules:
///        - selector: "google.calendar.v3.*"
///          restriction: PREVIEW
///      backend:
///        rules:
///        - selector: "google.calendar.v3.*"
///          address: calendar.example.com
///
///      authentication:
///        providers:
///        - id: google_calendar_auth
///          jwks_uri: https://www.googleapis.com/oauth2/v1/certs
///          issuer: https://securetoken.google.com
///        rules:
///        - selector: "*"
///          requirements:
///            provider_id: google_calendar_auth
class Service extends $pb.GeneratedMessage {
  factory Service({
    $core.String? name,
    $core.String? title,
    $core.Iterable<$84.Api>? apis,
    $core.Iterable<$83.Type>? types,
    $core.Iterable<$83.Enum>? enums,
    $85.Documentation? documentation,
    $86.Backend? backend,
    $55.Http? http,
    $87.Quota? quota,
    $88.Authentication? authentication,
    $89.Context? context,
    $90.Usage? usage,
    $core.Iterable<$91.Endpoint>? endpoints,
    $73.UInt32Value? configVersion,
    $92.Control? control,
    $core.String? producerProjectId,
    $core.Iterable<$93.LogDescriptor>? logs,
    $core.Iterable<$69.MetricDescriptor>? metrics,
    $core.Iterable<$67.MonitoredResourceDescriptor>? monitoredResources,
    $94.Billing? billing,
    $95.Logging? logging,
    $96.Monitoring? monitoring,
    $97.SystemParameters? systemParameters,
    $core.String? id,
    $98.SourceInfo? sourceInfo,
    $99.Publishing? publishing,
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
    if (types != null) {
      $result.types.addAll(types);
    }
    if (enums != null) {
      $result.enums.addAll(enums);
    }
    if (documentation != null) {
      $result.documentation = documentation;
    }
    if (backend != null) {
      $result.backend = backend;
    }
    if (http != null) {
      $result.http = http;
    }
    if (quota != null) {
      $result.quota = quota;
    }
    if (authentication != null) {
      $result.authentication = authentication;
    }
    if (context != null) {
      $result.context = context;
    }
    if (usage != null) {
      $result.usage = usage;
    }
    if (endpoints != null) {
      $result.endpoints.addAll(endpoints);
    }
    if (configVersion != null) {
      $result.configVersion = configVersion;
    }
    if (control != null) {
      $result.control = control;
    }
    if (producerProjectId != null) {
      $result.producerProjectId = producerProjectId;
    }
    if (logs != null) {
      $result.logs.addAll(logs);
    }
    if (metrics != null) {
      $result.metrics.addAll(metrics);
    }
    if (monitoredResources != null) {
      $result.monitoredResources.addAll(monitoredResources);
    }
    if (billing != null) {
      $result.billing = billing;
    }
    if (logging != null) {
      $result.logging = logging;
    }
    if (monitoring != null) {
      $result.monitoring = monitoring;
    }
    if (systemParameters != null) {
      $result.systemParameters = systemParameters;
    }
    if (id != null) {
      $result.id = id;
    }
    if (sourceInfo != null) {
      $result.sourceInfo = sourceInfo;
    }
    if (publishing != null) {
      $result.publishing = publishing;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..pc<$84.Api>(3, _omitFieldNames ? '' : 'apis', $pb.PbFieldType.PM,
        subBuilder: $84.Api.create)
    ..pc<$83.Type>(4, _omitFieldNames ? '' : 'types', $pb.PbFieldType.PM,
        subBuilder: $83.Type.create)
    ..pc<$83.Enum>(5, _omitFieldNames ? '' : 'enums', $pb.PbFieldType.PM,
        subBuilder: $83.Enum.create)
    ..aOM<$85.Documentation>(6, _omitFieldNames ? '' : 'documentation',
        subBuilder: $85.Documentation.create)
    ..aOM<$86.Backend>(8, _omitFieldNames ? '' : 'backend',
        subBuilder: $86.Backend.create)
    ..aOM<$55.Http>(9, _omitFieldNames ? '' : 'http',
        subBuilder: $55.Http.create)
    ..aOM<$87.Quota>(10, _omitFieldNames ? '' : 'quota',
        subBuilder: $87.Quota.create)
    ..aOM<$88.Authentication>(11, _omitFieldNames ? '' : 'authentication',
        subBuilder: $88.Authentication.create)
    ..aOM<$89.Context>(12, _omitFieldNames ? '' : 'context',
        subBuilder: $89.Context.create)
    ..aOM<$90.Usage>(15, _omitFieldNames ? '' : 'usage',
        subBuilder: $90.Usage.create)
    ..pc<$91.Endpoint>(
        18, _omitFieldNames ? '' : 'endpoints', $pb.PbFieldType.PM,
        subBuilder: $91.Endpoint.create)
    ..aOM<$73.UInt32Value>(20, _omitFieldNames ? '' : 'configVersion',
        subBuilder: $73.UInt32Value.create)
    ..aOM<$92.Control>(21, _omitFieldNames ? '' : 'control',
        subBuilder: $92.Control.create)
    ..aOS(22, _omitFieldNames ? '' : 'producerProjectId')
    ..pc<$93.LogDescriptor>(
        23, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM,
        subBuilder: $93.LogDescriptor.create)
    ..pc<$69.MetricDescriptor>(
        24, _omitFieldNames ? '' : 'metrics', $pb.PbFieldType.PM,
        subBuilder: $69.MetricDescriptor.create)
    ..pc<$67.MonitoredResourceDescriptor>(
        25, _omitFieldNames ? '' : 'monitoredResources', $pb.PbFieldType.PM,
        subBuilder: $67.MonitoredResourceDescriptor.create)
    ..aOM<$94.Billing>(26, _omitFieldNames ? '' : 'billing',
        subBuilder: $94.Billing.create)
    ..aOM<$95.Logging>(27, _omitFieldNames ? '' : 'logging',
        subBuilder: $95.Logging.create)
    ..aOM<$96.Monitoring>(28, _omitFieldNames ? '' : 'monitoring',
        subBuilder: $96.Monitoring.create)
    ..aOM<$97.SystemParameters>(29, _omitFieldNames ? '' : 'systemParameters',
        subBuilder: $97.SystemParameters.create)
    ..aOS(33, _omitFieldNames ? '' : 'id')
    ..aOM<$98.SourceInfo>(37, _omitFieldNames ? '' : 'sourceInfo',
        subBuilder: $98.SourceInfo.create)
    ..aOM<$99.Publishing>(45, _omitFieldNames ? '' : 'publishing',
        subBuilder: $99.Publishing.create)
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

  /// The service name, which is a DNS-like logical identifier for the
  /// service, such as `calendar.googleapis.com`. The service name
  /// typically goes through DNS verification to make sure the owner
  /// of the service also owns the DNS name.
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

  /// The product title for this service, it is the name displayed in Google
  /// Cloud Console.
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

  /// A list of API interfaces exported by this service. Only the `name` field
  /// of the [google.protobuf.Api][google.protobuf.Api] needs to be provided by
  /// the configuration author, as the remaining fields will be derived from the
  /// IDL during the normalization process. It is an error to specify an API
  /// interface here which cannot be resolved against the associated IDL files.
  @$pb.TagNumber(3)
  $core.List<$84.Api> get apis => $_getList(2);

  ///  A list of all proto message types included in this API service.
  ///  Types referenced directly or indirectly by the `apis` are automatically
  ///  included.  Messages which are not referenced but shall be included, such as
  ///  types used by the `google.protobuf.Any` type, should be listed here by
  ///  name by the configuration author. Example:
  ///
  ///      types:
  ///      - name: google.protobuf.Int32
  @$pb.TagNumber(4)
  $core.List<$83.Type> get types => $_getList(3);

  ///  A list of all enum types included in this API service.  Enums referenced
  ///  directly or indirectly by the `apis` are automatically included.  Enums
  ///  which are not referenced but shall be included should be listed here by
  ///  name by the configuration author. Example:
  ///
  ///      enums:
  ///      - name: google.someapi.v1.SomeEnum
  @$pb.TagNumber(5)
  $core.List<$83.Enum> get enums => $_getList(4);

  /// Additional API documentation.
  @$pb.TagNumber(6)
  $85.Documentation get documentation => $_getN(5);
  @$pb.TagNumber(6)
  set documentation($85.Documentation v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDocumentation() => $_has(5);
  @$pb.TagNumber(6)
  void clearDocumentation() => clearField(6);
  @$pb.TagNumber(6)
  $85.Documentation ensureDocumentation() => $_ensure(5);

  /// API backend configuration.
  @$pb.TagNumber(8)
  $86.Backend get backend => $_getN(6);
  @$pb.TagNumber(8)
  set backend($86.Backend v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasBackend() => $_has(6);
  @$pb.TagNumber(8)
  void clearBackend() => clearField(8);
  @$pb.TagNumber(8)
  $86.Backend ensureBackend() => $_ensure(6);

  /// HTTP configuration.
  @$pb.TagNumber(9)
  $55.Http get http => $_getN(7);
  @$pb.TagNumber(9)
  set http($55.Http v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasHttp() => $_has(7);
  @$pb.TagNumber(9)
  void clearHttp() => clearField(9);
  @$pb.TagNumber(9)
  $55.Http ensureHttp() => $_ensure(7);

  /// Quota configuration.
  @$pb.TagNumber(10)
  $87.Quota get quota => $_getN(8);
  @$pb.TagNumber(10)
  set quota($87.Quota v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasQuota() => $_has(8);
  @$pb.TagNumber(10)
  void clearQuota() => clearField(10);
  @$pb.TagNumber(10)
  $87.Quota ensureQuota() => $_ensure(8);

  /// Auth configuration.
  @$pb.TagNumber(11)
  $88.Authentication get authentication => $_getN(9);
  @$pb.TagNumber(11)
  set authentication($88.Authentication v) {
    setField(11, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasAuthentication() => $_has(9);
  @$pb.TagNumber(11)
  void clearAuthentication() => clearField(11);
  @$pb.TagNumber(11)
  $88.Authentication ensureAuthentication() => $_ensure(9);

  /// Context configuration.
  @$pb.TagNumber(12)
  $89.Context get context => $_getN(10);
  @$pb.TagNumber(12)
  set context($89.Context v) {
    setField(12, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasContext() => $_has(10);
  @$pb.TagNumber(12)
  void clearContext() => clearField(12);
  @$pb.TagNumber(12)
  $89.Context ensureContext() => $_ensure(10);

  /// Configuration controlling usage of this service.
  @$pb.TagNumber(15)
  $90.Usage get usage => $_getN(11);
  @$pb.TagNumber(15)
  set usage($90.Usage v) {
    setField(15, v);
  }

  @$pb.TagNumber(15)
  $core.bool hasUsage() => $_has(11);
  @$pb.TagNumber(15)
  void clearUsage() => clearField(15);
  @$pb.TagNumber(15)
  $90.Usage ensureUsage() => $_ensure(11);

  /// Configuration for network endpoints.  If this is empty, then an endpoint
  /// with the same name as the service is automatically generated to service all
  /// defined APIs.
  @$pb.TagNumber(18)
  $core.List<$91.Endpoint> get endpoints => $_getList(12);

  ///  Obsolete. Do not use.
  ///
  ///  This field has no semantic meaning. The service config compiler always
  ///  sets this field to `3`.
  @$pb.TagNumber(20)
  $73.UInt32Value get configVersion => $_getN(13);
  @$pb.TagNumber(20)
  set configVersion($73.UInt32Value v) {
    setField(20, v);
  }

  @$pb.TagNumber(20)
  $core.bool hasConfigVersion() => $_has(13);
  @$pb.TagNumber(20)
  void clearConfigVersion() => clearField(20);
  @$pb.TagNumber(20)
  $73.UInt32Value ensureConfigVersion() => $_ensure(13);

  /// Configuration for the service control plane.
  @$pb.TagNumber(21)
  $92.Control get control => $_getN(14);
  @$pb.TagNumber(21)
  set control($92.Control v) {
    setField(21, v);
  }

  @$pb.TagNumber(21)
  $core.bool hasControl() => $_has(14);
  @$pb.TagNumber(21)
  void clearControl() => clearField(21);
  @$pb.TagNumber(21)
  $92.Control ensureControl() => $_ensure(14);

  /// The Google project that owns this service.
  @$pb.TagNumber(22)
  $core.String get producerProjectId => $_getSZ(15);
  @$pb.TagNumber(22)
  set producerProjectId($core.String v) {
    $_setString(15, v);
  }

  @$pb.TagNumber(22)
  $core.bool hasProducerProjectId() => $_has(15);
  @$pb.TagNumber(22)
  void clearProducerProjectId() => clearField(22);

  /// Defines the logs used by this service.
  @$pb.TagNumber(23)
  $core.List<$93.LogDescriptor> get logs => $_getList(16);

  /// Defines the metrics used by this service.
  @$pb.TagNumber(24)
  $core.List<$69.MetricDescriptor> get metrics => $_getList(17);

  /// Defines the monitored resources used by this service. This is required
  /// by the [Service.monitoring][google.api.Service.monitoring] and
  /// [Service.logging][google.api.Service.logging] configurations.
  @$pb.TagNumber(25)
  $core.List<$67.MonitoredResourceDescriptor> get monitoredResources =>
      $_getList(18);

  /// Billing configuration.
  @$pb.TagNumber(26)
  $94.Billing get billing => $_getN(19);
  @$pb.TagNumber(26)
  set billing($94.Billing v) {
    setField(26, v);
  }

  @$pb.TagNumber(26)
  $core.bool hasBilling() => $_has(19);
  @$pb.TagNumber(26)
  void clearBilling() => clearField(26);
  @$pb.TagNumber(26)
  $94.Billing ensureBilling() => $_ensure(19);

  /// Logging configuration.
  @$pb.TagNumber(27)
  $95.Logging get logging => $_getN(20);
  @$pb.TagNumber(27)
  set logging($95.Logging v) {
    setField(27, v);
  }

  @$pb.TagNumber(27)
  $core.bool hasLogging() => $_has(20);
  @$pb.TagNumber(27)
  void clearLogging() => clearField(27);
  @$pb.TagNumber(27)
  $95.Logging ensureLogging() => $_ensure(20);

  /// Monitoring configuration.
  @$pb.TagNumber(28)
  $96.Monitoring get monitoring => $_getN(21);
  @$pb.TagNumber(28)
  set monitoring($96.Monitoring v) {
    setField(28, v);
  }

  @$pb.TagNumber(28)
  $core.bool hasMonitoring() => $_has(21);
  @$pb.TagNumber(28)
  void clearMonitoring() => clearField(28);
  @$pb.TagNumber(28)
  $96.Monitoring ensureMonitoring() => $_ensure(21);

  /// System parameter configuration.
  @$pb.TagNumber(29)
  $97.SystemParameters get systemParameters => $_getN(22);
  @$pb.TagNumber(29)
  set systemParameters($97.SystemParameters v) {
    setField(29, v);
  }

  @$pb.TagNumber(29)
  $core.bool hasSystemParameters() => $_has(22);
  @$pb.TagNumber(29)
  void clearSystemParameters() => clearField(29);
  @$pb.TagNumber(29)
  $97.SystemParameters ensureSystemParameters() => $_ensure(22);

  /// A unique ID for a specific instance of this message, typically assigned
  /// by the client for tracking purpose. Must be no longer than 63 characters
  /// and only lower case letters, digits, '.', '_' and '-' are allowed. If
  /// empty, the server may choose to generate one instead.
  @$pb.TagNumber(33)
  $core.String get id => $_getSZ(23);
  @$pb.TagNumber(33)
  set id($core.String v) {
    $_setString(23, v);
  }

  @$pb.TagNumber(33)
  $core.bool hasId() => $_has(23);
  @$pb.TagNumber(33)
  void clearId() => clearField(33);

  /// Output only. The source information for this configuration if available.
  @$pb.TagNumber(37)
  $98.SourceInfo get sourceInfo => $_getN(24);
  @$pb.TagNumber(37)
  set sourceInfo($98.SourceInfo v) {
    setField(37, v);
  }

  @$pb.TagNumber(37)
  $core.bool hasSourceInfo() => $_has(24);
  @$pb.TagNumber(37)
  void clearSourceInfo() => clearField(37);
  @$pb.TagNumber(37)
  $98.SourceInfo ensureSourceInfo() => $_ensure(24);

  /// Settings for [Google Cloud Client
  /// libraries](https://cloud.google.com/apis/docs/cloud-client-libraries)
  /// generated from APIs defined as protocol buffers.
  @$pb.TagNumber(45)
  $99.Publishing get publishing => $_getN(25);
  @$pb.TagNumber(45)
  set publishing($99.Publishing v) {
    setField(45, v);
  }

  @$pb.TagNumber(45)
  $core.bool hasPublishing() => $_has(25);
  @$pb.TagNumber(45)
  void clearPublishing() => clearField(45);
  @$pb.TagNumber(45)
  $99.Publishing ensurePublishing() => $_ensure(25);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
