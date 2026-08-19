//
//  Generated code. Do not modify.
//  source: google/api/control.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'policy.pb.dart' as $81;

///  Selects and configures the service controller used by the service.
///
///  Example:
///
///      control:
///        environment: servicecontrol.googleapis.com
class Control extends $pb.GeneratedMessage {
  factory Control({
    $core.String? environment,
    $core.Iterable<$81.MethodPolicy>? methodPolicies,
  }) {
    final $result = create();
    if (environment != null) {
      $result.environment = environment;
    }
    if (methodPolicies != null) {
      $result.methodPolicies.addAll(methodPolicies);
    }
    return $result;
  }
  Control._() : super();
  factory Control.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Control.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Control',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'environment')
    ..pc<$81.MethodPolicy>(
        4, _omitFieldNames ? '' : 'methodPolicies', $pb.PbFieldType.PM,
        subBuilder: $81.MethodPolicy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Control clone() => Control()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Control copyWith(void Function(Control) updates) =>
      super.copyWith((message) => updates(message as Control)) as Control;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Control create() => Control._();
  Control createEmptyInstance() => create();
  static $pb.PbList<Control> createRepeated() => $pb.PbList<Control>();
  @$core.pragma('dart2js:noInline')
  static Control getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Control>(create);
  static Control? _defaultInstance;

  /// The service controller environment to use. If empty, no control plane
  /// feature (like quota and billing) will be enabled. The recommended value for
  /// most services is servicecontrol.googleapis.com
  @$pb.TagNumber(1)
  $core.String get environment => $_getSZ(0);
  @$pb.TagNumber(1)
  set environment($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEnvironment() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvironment() => clearField(1);

  /// Defines policies applying to the API methods of the service.
  @$pb.TagNumber(4)
  $core.List<$81.MethodPolicy> get methodPolicies => $_getList(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
