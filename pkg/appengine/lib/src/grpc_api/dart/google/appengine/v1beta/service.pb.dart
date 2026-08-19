//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'network_settings.pb.dart' as $54;
import 'service.pbenum.dart';

export 'service.pbenum.dart';

/// A Service resource is a logical component of an application that can share
/// state and communicate in a secure fashion with other services.
/// For example, an application that handles customer requests might
/// include separate services to handle tasks such as backend data
/// analysis or API requests from mobile devices. Each service has a
/// collection of versions that define a specific set of code used to
/// implement the functionality of that service.
class Service extends $pb.GeneratedMessage {
  factory Service({
    $core.String? name,
    $core.String? id,
    TrafficSplit? split,
    $54.NetworkSettings? networkSettings,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (id != null) {
      $result.id = id;
    }
    if (split != null) {
      $result.split = split;
    }
    if (networkSettings != null) {
      $result.networkSettings = networkSettings;
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
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOM<TrafficSplit>(3, _omitFieldNames ? '' : 'split',
        subBuilder: TrafficSplit.create)
    ..aOM<$54.NetworkSettings>(6, _omitFieldNames ? '' : 'networkSettings',
        subBuilder: $54.NetworkSettings.create)
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

  ///  Full path to the Service resource in the API.
  ///  Example: `apps/myapp/services/default`.
  ///
  ///  @OutputOnly
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

  ///  Relative name of the service within the application.
  ///  Example: `default`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// Mapping that defines fractional HTTP traffic diversion to
  /// different versions within the service.
  @$pb.TagNumber(3)
  TrafficSplit get split => $_getN(2);
  @$pb.TagNumber(3)
  set split(TrafficSplit v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSplit() => $_has(2);
  @$pb.TagNumber(3)
  void clearSplit() => clearField(3);
  @$pb.TagNumber(3)
  TrafficSplit ensureSplit() => $_ensure(2);

  /// Ingress settings for this service. Will apply to all versions.
  @$pb.TagNumber(6)
  $54.NetworkSettings get networkSettings => $_getN(3);
  @$pb.TagNumber(6)
  set networkSettings($54.NetworkSettings v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasNetworkSettings() => $_has(3);
  @$pb.TagNumber(6)
  void clearNetworkSettings() => clearField(6);
  @$pb.TagNumber(6)
  $54.NetworkSettings ensureNetworkSettings() => $_ensure(3);
}

/// Traffic routing configuration for versions within a single service. Traffic
/// splits define how traffic directed to the service is assigned to versions.
class TrafficSplit extends $pb.GeneratedMessage {
  factory TrafficSplit({
    TrafficSplit_ShardBy? shardBy,
    $core.Map<$core.String, $core.double>? allocations,
  }) {
    final $result = create();
    if (shardBy != null) {
      $result.shardBy = shardBy;
    }
    if (allocations != null) {
      $result.allocations.addAll(allocations);
    }
    return $result;
  }
  TrafficSplit._() : super();
  factory TrafficSplit.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TrafficSplit.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrafficSplit',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..e<TrafficSplit_ShardBy>(
        1, _omitFieldNames ? '' : 'shardBy', $pb.PbFieldType.OE,
        defaultOrMaker: TrafficSplit_ShardBy.UNSPECIFIED,
        valueOf: TrafficSplit_ShardBy.valueOf,
        enumValues: TrafficSplit_ShardBy.values)
    ..m<$core.String, $core.double>(2, _omitFieldNames ? '' : 'allocations',
        entryClassName: 'TrafficSplit.AllocationsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('google.appengine.v1beta'))
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TrafficSplit clone() => TrafficSplit()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TrafficSplit copyWith(void Function(TrafficSplit) updates) =>
      super.copyWith((message) => updates(message as TrafficSplit))
          as TrafficSplit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrafficSplit create() => TrafficSplit._();
  TrafficSplit createEmptyInstance() => create();
  static $pb.PbList<TrafficSplit> createRepeated() =>
      $pb.PbList<TrafficSplit>();
  @$core.pragma('dart2js:noInline')
  static TrafficSplit getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TrafficSplit>(create);
  static TrafficSplit? _defaultInstance;

  /// Mechanism used to determine which version a request is sent to.
  /// The traffic selection algorithm will
  /// be stable for either type until allocations are changed.
  @$pb.TagNumber(1)
  TrafficSplit_ShardBy get shardBy => $_getN(0);
  @$pb.TagNumber(1)
  set shardBy(TrafficSplit_ShardBy v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasShardBy() => $_has(0);
  @$pb.TagNumber(1)
  void clearShardBy() => clearField(1);

  /// Mapping from version IDs within the service to fractional
  /// (0.000, 1] allocations of traffic for that version. Each version can
  /// be specified only once, but some versions in the service may not
  /// have any traffic allocation. Services that have traffic allocated
  /// cannot be deleted until either the service is deleted or
  /// their traffic allocation is removed. Allocations must sum to 1.
  /// Up to two decimal place precision is supported for IP-based splits and
  /// up to three decimal places is supported for cookie-based splits.
  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.double> get allocations => $_getMap(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
