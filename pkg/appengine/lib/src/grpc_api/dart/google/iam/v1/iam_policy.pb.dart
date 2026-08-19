//
//  Generated code. Do not modify.
//  source: google/iam/v1/iam_policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/field_mask.pb.dart' as $58;
import 'options.pb.dart' as $115;
import 'policy.pb.dart' as $43;

/// Request message for `SetIamPolicy` method.
class SetIamPolicyRequest extends $pb.GeneratedMessage {
  factory SetIamPolicyRequest({
    $core.String? resource,
    $43.Policy? policy,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (resource != null) {
      $result.resource = resource;
    }
    if (policy != null) {
      $result.policy = policy;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  SetIamPolicyRequest._() : super();
  factory SetIamPolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SetIamPolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetIamPolicyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resource')
    ..aOM<$43.Policy>(2, _omitFieldNames ? '' : 'policy',
        subBuilder: $43.Policy.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SetIamPolicyRequest clone() => SetIamPolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SetIamPolicyRequest copyWith(void Function(SetIamPolicyRequest) updates) =>
      super.copyWith((message) => updates(message as SetIamPolicyRequest))
          as SetIamPolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetIamPolicyRequest create() => SetIamPolicyRequest._();
  SetIamPolicyRequest createEmptyInstance() => create();
  static $pb.PbList<SetIamPolicyRequest> createRepeated() =>
      $pb.PbList<SetIamPolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static SetIamPolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetIamPolicyRequest>(create);
  static SetIamPolicyRequest? _defaultInstance;

  /// REQUIRED: The resource for which the policy is being specified.
  /// See the operation documentation for the appropriate value for this field.
  @$pb.TagNumber(1)
  $core.String get resource => $_getSZ(0);
  @$pb.TagNumber(1)
  set resource($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearResource() => clearField(1);

  /// REQUIRED: The complete policy to be applied to the `resource`. The size of
  /// the policy is limited to a few 10s of KB. An empty policy is a
  /// valid policy but certain Cloud Platform services (such as Projects)
  /// might reject them.
  @$pb.TagNumber(2)
  $43.Policy get policy => $_getN(1);
  @$pb.TagNumber(2)
  set policy($43.Policy v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPolicy() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicy() => clearField(2);
  @$pb.TagNumber(2)
  $43.Policy ensurePolicy() => $_ensure(1);

  ///  OPTIONAL: A FieldMask specifying which fields of the policy to modify. Only
  ///  the fields in the mask will be modified. If no mask is provided, the
  ///  following default mask is used:
  ///
  ///  `paths: "bindings, etag"`
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for `GetIamPolicy` method.
class GetIamPolicyRequest extends $pb.GeneratedMessage {
  factory GetIamPolicyRequest({
    $core.String? resource,
    $115.GetPolicyOptions? options,
  }) {
    final $result = create();
    if (resource != null) {
      $result.resource = resource;
    }
    if (options != null) {
      $result.options = options;
    }
    return $result;
  }
  GetIamPolicyRequest._() : super();
  factory GetIamPolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetIamPolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIamPolicyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resource')
    ..aOM<$115.GetPolicyOptions>(2, _omitFieldNames ? '' : 'options',
        subBuilder: $115.GetPolicyOptions.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetIamPolicyRequest clone() => GetIamPolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetIamPolicyRequest copyWith(void Function(GetIamPolicyRequest) updates) =>
      super.copyWith((message) => updates(message as GetIamPolicyRequest))
          as GetIamPolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIamPolicyRequest create() => GetIamPolicyRequest._();
  GetIamPolicyRequest createEmptyInstance() => create();
  static $pb.PbList<GetIamPolicyRequest> createRepeated() =>
      $pb.PbList<GetIamPolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIamPolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIamPolicyRequest>(create);
  static GetIamPolicyRequest? _defaultInstance;

  /// REQUIRED: The resource for which the policy is being requested.
  /// See the operation documentation for the appropriate value for this field.
  @$pb.TagNumber(1)
  $core.String get resource => $_getSZ(0);
  @$pb.TagNumber(1)
  set resource($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearResource() => clearField(1);

  /// OPTIONAL: A `GetPolicyOptions` object for specifying options to
  /// `GetIamPolicy`.
  @$pb.TagNumber(2)
  $115.GetPolicyOptions get options => $_getN(1);
  @$pb.TagNumber(2)
  set options($115.GetPolicyOptions v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOptions() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptions() => clearField(2);
  @$pb.TagNumber(2)
  $115.GetPolicyOptions ensureOptions() => $_ensure(1);
}

/// Request message for `TestIamPermissions` method.
class TestIamPermissionsRequest extends $pb.GeneratedMessage {
  factory TestIamPermissionsRequest({
    $core.String? resource,
    $core.Iterable<$core.String>? permissions,
  }) {
    final $result = create();
    if (resource != null) {
      $result.resource = resource;
    }
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    return $result;
  }
  TestIamPermissionsRequest._() : super();
  factory TestIamPermissionsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestIamPermissionsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestIamPermissionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resource')
    ..pPS(2, _omitFieldNames ? '' : 'permissions')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestIamPermissionsRequest clone() =>
      TestIamPermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestIamPermissionsRequest copyWith(
          void Function(TestIamPermissionsRequest) updates) =>
      super.copyWith((message) => updates(message as TestIamPermissionsRequest))
          as TestIamPermissionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestIamPermissionsRequest create() => TestIamPermissionsRequest._();
  TestIamPermissionsRequest createEmptyInstance() => create();
  static $pb.PbList<TestIamPermissionsRequest> createRepeated() =>
      $pb.PbList<TestIamPermissionsRequest>();
  @$core.pragma('dart2js:noInline')
  static TestIamPermissionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestIamPermissionsRequest>(create);
  static TestIamPermissionsRequest? _defaultInstance;

  /// REQUIRED: The resource for which the policy detail is being requested.
  /// See the operation documentation for the appropriate value for this field.
  @$pb.TagNumber(1)
  $core.String get resource => $_getSZ(0);
  @$pb.TagNumber(1)
  set resource($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasResource() => $_has(0);
  @$pb.TagNumber(1)
  void clearResource() => clearField(1);

  /// The set of permissions to check for the `resource`. Permissions with
  /// wildcards (such as '*' or 'storage.*') are not allowed. For more
  /// information see
  /// [IAM Overview](https://cloud.google.com/iam/docs/overview#permissions).
  @$pb.TagNumber(2)
  $core.List<$core.String> get permissions => $_getList(1);
}

/// Response message for `TestIamPermissions` method.
class TestIamPermissionsResponse extends $pb.GeneratedMessage {
  factory TestIamPermissionsResponse({
    $core.Iterable<$core.String>? permissions,
  }) {
    final $result = create();
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    return $result;
  }
  TestIamPermissionsResponse._() : super();
  factory TestIamPermissionsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory TestIamPermissionsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TestIamPermissionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'permissions')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  TestIamPermissionsResponse clone() =>
      TestIamPermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  TestIamPermissionsResponse copyWith(
          void Function(TestIamPermissionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as TestIamPermissionsResponse))
          as TestIamPermissionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TestIamPermissionsResponse create() => TestIamPermissionsResponse._();
  TestIamPermissionsResponse createEmptyInstance() => create();
  static $pb.PbList<TestIamPermissionsResponse> createRepeated() =>
      $pb.PbList<TestIamPermissionsResponse>();
  @$core.pragma('dart2js:noInline')
  static TestIamPermissionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TestIamPermissionsResponse>(create);
  static TestIamPermissionsResponse? _defaultInstance;

  /// A subset of `TestPermissionsRequest.permissions` that the caller is
  /// allowed.
  @$pb.TagNumber(1)
  $core.List<$core.String> get permissions => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
