//
//  Generated code. Do not modify.
//  source: google/iam/v1/options.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Encapsulates settings provided to GetIamPolicy.
class GetPolicyOptions extends $pb.GeneratedMessage {
  factory GetPolicyOptions({
    $core.int? requestedPolicyVersion,
  }) {
    final $result = create();
    if (requestedPolicyVersion != null) {
      $result.requestedPolicyVersion = requestedPolicyVersion;
    }
    return $result;
  }
  GetPolicyOptions._() : super();
  factory GetPolicyOptions.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPolicyOptions.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPolicyOptions',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'requestedPolicyVersion', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPolicyOptions clone() => GetPolicyOptions()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPolicyOptions copyWith(void Function(GetPolicyOptions) updates) =>
      super.copyWith((message) => updates(message as GetPolicyOptions))
          as GetPolicyOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPolicyOptions create() => GetPolicyOptions._();
  GetPolicyOptions createEmptyInstance() => create();
  static $pb.PbList<GetPolicyOptions> createRepeated() =>
      $pb.PbList<GetPolicyOptions>();
  @$core.pragma('dart2js:noInline')
  static GetPolicyOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPolicyOptions>(create);
  static GetPolicyOptions? _defaultInstance;

  ///  Optional. The maximum policy version that will be used to format the
  ///  policy.
  ///
  ///  Valid values are 0, 1, and 3. Requests specifying an invalid value will be
  ///  rejected.
  ///
  ///  Requests for policies with any conditional role bindings must specify
  ///  version 3. Policies with no conditional role bindings may specify any valid
  ///  value or leave the field unset.
  ///
  ///  The policy in the response might use the policy version that you specified,
  ///  or it might use a lower policy version. For example, if you specify version
  ///  3, but the policy has no conditional role bindings, the response uses
  ///  version 1.
  ///
  ///  To learn which resources support conditions in their IAM policies, see the
  ///  [IAM
  ///  documentation](https://cloud.google.com/iam/help/conditions/resource-policies).
  @$pb.TagNumber(1)
  $core.int get requestedPolicyVersion => $_getIZ(0);
  @$pb.TagNumber(1)
  set requestedPolicyVersion($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequestedPolicyVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestedPolicyVersion() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
