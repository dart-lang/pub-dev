//
//  Generated code. Do not modify.
//  source: google/iam/v1/logging/audit_data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../policy.pb.dart' as $43;

/// Audit log information specific to Cloud IAM. This message is serialized
/// as an `Any` type in the `ServiceData` message of an
/// `AuditLog` message.
class AuditData extends $pb.GeneratedMessage {
  factory AuditData({
    $43.PolicyDelta? policyDelta,
  }) {
    final $result = create();
    if (policyDelta != null) {
      $result.policyDelta = policyDelta;
    }
    return $result;
  }
  AuditData._() : super();
  factory AuditData.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditData.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.v1.logging'),
      createEmptyInstance: create)
    ..aOM<$43.PolicyDelta>(2, _omitFieldNames ? '' : 'policyDelta',
        subBuilder: $43.PolicyDelta.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditData clone() => AuditData()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditData copyWith(void Function(AuditData) updates) =>
      super.copyWith((message) => updates(message as AuditData)) as AuditData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditData create() => AuditData._();
  AuditData createEmptyInstance() => create();
  static $pb.PbList<AuditData> createRepeated() => $pb.PbList<AuditData>();
  @$core.pragma('dart2js:noInline')
  static AuditData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditData>(create);
  static AuditData? _defaultInstance;

  /// Policy delta between the original policy and the newly set policy.
  @$pb.TagNumber(2)
  $43.PolicyDelta get policyDelta => $_getN(0);
  @$pb.TagNumber(2)
  set policyDelta($43.PolicyDelta v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPolicyDelta() => $_has(0);
  @$pb.TagNumber(2)
  void clearPolicyDelta() => clearField(2);
  @$pb.TagNumber(2)
  $43.PolicyDelta ensurePolicyDelta() => $_ensure(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
