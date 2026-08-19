//
//  Generated code. Do not modify.
//  source: google/appengine/v1/network_settings.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'network_settings.pbenum.dart';

export 'network_settings.pbenum.dart';

/// A NetworkSettings resource is a container for ingress settings for a version
/// or service.
class NetworkSettings extends $pb.GeneratedMessage {
  factory NetworkSettings({
    NetworkSettings_IngressTrafficAllowed? ingressTrafficAllowed,
  }) {
    final $result = create();
    if (ingressTrafficAllowed != null) {
      $result.ingressTrafficAllowed = ingressTrafficAllowed;
    }
    return $result;
  }
  NetworkSettings._() : super();
  factory NetworkSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory NetworkSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NetworkSettings',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..e<NetworkSettings_IngressTrafficAllowed>(
        1, _omitFieldNames ? '' : 'ingressTrafficAllowed', $pb.PbFieldType.OE,
        defaultOrMaker: NetworkSettings_IngressTrafficAllowed
            .INGRESS_TRAFFIC_ALLOWED_UNSPECIFIED,
        valueOf: NetworkSettings_IngressTrafficAllowed.valueOf,
        enumValues: NetworkSettings_IngressTrafficAllowed.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  NetworkSettings clone() => NetworkSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  NetworkSettings copyWith(void Function(NetworkSettings) updates) =>
      super.copyWith((message) => updates(message as NetworkSettings))
          as NetworkSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NetworkSettings create() => NetworkSettings._();
  NetworkSettings createEmptyInstance() => create();
  static $pb.PbList<NetworkSettings> createRepeated() =>
      $pb.PbList<NetworkSettings>();
  @$core.pragma('dart2js:noInline')
  static NetworkSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NetworkSettings>(create);
  static NetworkSettings? _defaultInstance;

  /// The ingress settings for version or service.
  @$pb.TagNumber(1)
  NetworkSettings_IngressTrafficAllowed get ingressTrafficAllowed => $_getN(0);
  @$pb.TagNumber(1)
  set ingressTrafficAllowed(NetworkSettings_IngressTrafficAllowed v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIngressTrafficAllowed() => $_has(0);
  @$pb.TagNumber(1)
  void clearIngressTrafficAllowed() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
