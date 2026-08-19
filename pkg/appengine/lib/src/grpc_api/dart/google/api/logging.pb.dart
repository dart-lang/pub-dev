//
//  Generated code. Do not modify.
//  source: google/api/logging.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Configuration of a specific logging destination (the producer project
/// or the consumer project).
class Logging_LoggingDestination extends $pb.GeneratedMessage {
  factory Logging_LoggingDestination({
    $core.Iterable<$core.String>? logs,
    $core.String? monitoredResource,
  }) {
    final $result = create();
    if (logs != null) {
      $result.logs.addAll(logs);
    }
    if (monitoredResource != null) {
      $result.monitoredResource = monitoredResource;
    }
    return $result;
  }
  Logging_LoggingDestination._() : super();
  factory Logging_LoggingDestination.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Logging_LoggingDestination.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Logging.LoggingDestination',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'logs')
    ..aOS(3, _omitFieldNames ? '' : 'monitoredResource')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Logging_LoggingDestination clone() =>
      Logging_LoggingDestination()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Logging_LoggingDestination copyWith(
          void Function(Logging_LoggingDestination) updates) =>
      super.copyWith(
              (message) => updates(message as Logging_LoggingDestination))
          as Logging_LoggingDestination;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Logging_LoggingDestination create() => Logging_LoggingDestination._();
  Logging_LoggingDestination createEmptyInstance() => create();
  static $pb.PbList<Logging_LoggingDestination> createRepeated() =>
      $pb.PbList<Logging_LoggingDestination>();
  @$core.pragma('dart2js:noInline')
  static Logging_LoggingDestination getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Logging_LoggingDestination>(create);
  static Logging_LoggingDestination? _defaultInstance;

  /// Names of the logs to be sent to this destination. Each name must
  /// be defined in the [Service.logs][google.api.Service.logs] section. If the
  /// log name is not a domain scoped name, it will be automatically prefixed
  /// with the service name followed by "/".
  @$pb.TagNumber(1)
  $core.List<$core.String> get logs => $_getList(0);

  /// The monitored resource type. The type must be defined in the
  /// [Service.monitored_resources][google.api.Service.monitored_resources]
  /// section.
  @$pb.TagNumber(3)
  $core.String get monitoredResource => $_getSZ(1);
  @$pb.TagNumber(3)
  set monitoredResource($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMonitoredResource() => $_has(1);
  @$pb.TagNumber(3)
  void clearMonitoredResource() => clearField(3);
}

///  Logging configuration of the service.
///
///  The following example shows how to configure logs to be sent to the
///  producer and consumer projects. In the example, the `activity_history`
///  log is sent to both the producer and consumer projects, whereas the
///  `purchase_history` log is only sent to the producer project.
///
///      monitored_resources:
///      - type: library.googleapis.com/branch
///        labels:
///        - key: /city
///          description: The city where the library branch is located in.
///        - key: /name
///          description: The name of the branch.
///      logs:
///      - name: activity_history
///        labels:
///        - key: /customer_id
///      - name: purchase_history
///      logging:
///        producer_destinations:
///        - monitored_resource: library.googleapis.com/branch
///          logs:
///          - activity_history
///          - purchase_history
///        consumer_destinations:
///        - monitored_resource: library.googleapis.com/branch
///          logs:
///          - activity_history
class Logging extends $pb.GeneratedMessage {
  factory Logging({
    $core.Iterable<Logging_LoggingDestination>? producerDestinations,
    $core.Iterable<Logging_LoggingDestination>? consumerDestinations,
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
  Logging._() : super();
  factory Logging.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Logging.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Logging',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<Logging_LoggingDestination>(
        1, _omitFieldNames ? '' : 'producerDestinations', $pb.PbFieldType.PM,
        subBuilder: Logging_LoggingDestination.create)
    ..pc<Logging_LoggingDestination>(
        2, _omitFieldNames ? '' : 'consumerDestinations', $pb.PbFieldType.PM,
        subBuilder: Logging_LoggingDestination.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Logging clone() => Logging()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Logging copyWith(void Function(Logging) updates) =>
      super.copyWith((message) => updates(message as Logging)) as Logging;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Logging create() => Logging._();
  Logging createEmptyInstance() => create();
  static $pb.PbList<Logging> createRepeated() => $pb.PbList<Logging>();
  @$core.pragma('dart2js:noInline')
  static Logging getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Logging>(create);
  static Logging? _defaultInstance;

  /// Logging configurations for sending logs to the producer project.
  /// There can be multiple producer destinations, each one must have a
  /// different monitored resource type. A log can be used in at most
  /// one producer destination.
  @$pb.TagNumber(1)
  $core.List<Logging_LoggingDestination> get producerDestinations =>
      $_getList(0);

  /// Logging configurations for sending logs to the consumer project.
  /// There can be multiple consumer destinations, each one must have a
  /// different monitored resource type. A log can be used in at most
  /// one consumer destination.
  @$pb.TagNumber(2)
  $core.List<Logging_LoggingDestination> get consumerDestinations =>
      $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
