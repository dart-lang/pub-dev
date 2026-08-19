//
//  Generated code. Do not modify.
//  source: google/iam/v2beta/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;
import 'deny.pb.dart' as $116;

/// Data for an IAM policy.
class Policy extends $pb.GeneratedMessage {
  factory Policy({
    $core.String? name,
    $core.String? uid,
    $core.String? kind,
    $core.String? displayName,
    $core.Map<$core.String, $core.String>? annotations,
    $core.String? etag,
    $50.Timestamp? createTime,
    $50.Timestamp? updateTime,
    $50.Timestamp? deleteTime,
    $core.Iterable<PolicyRule>? rules,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (uid != null) {
      $result.uid = uid;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (annotations != null) {
      $result.annotations.addAll(annotations);
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (createTime != null) {
      $result.createTime = createTime;
    }
    if (updateTime != null) {
      $result.updateTime = updateTime;
    }
    if (deleteTime != null) {
      $result.deleteTime = deleteTime;
    }
    if (rules != null) {
      $result.rules.addAll(rules);
    }
    return $result;
  }
  Policy._() : super();
  factory Policy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Policy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Policy',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'uid')
    ..aOS(3, _omitFieldNames ? '' : 'kind')
    ..aOS(4, _omitFieldNames ? '' : 'displayName')
    ..m<$core.String, $core.String>(5, _omitFieldNames ? '' : 'annotations',
        entryClassName: 'Policy.AnnotationsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.iam.v2beta'))
    ..aOS(6, _omitFieldNames ? '' : 'etag')
    ..aOM<$50.Timestamp>(7, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(8, _omitFieldNames ? '' : 'updateTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(9, _omitFieldNames ? '' : 'deleteTime',
        subBuilder: $50.Timestamp.create)
    ..pc<PolicyRule>(10, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: PolicyRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Policy clone() => Policy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Policy copyWith(void Function(Policy) updates) =>
      super.copyWith((message) => updates(message as Policy)) as Policy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Policy create() => Policy._();
  Policy createEmptyInstance() => create();
  static $pb.PbList<Policy> createRepeated() => $pb.PbList<Policy>();
  @$core.pragma('dart2js:noInline')
  static Policy getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Policy>(create);
  static Policy? _defaultInstance;

  ///  Immutable. The resource name of the `Policy`, which must be unique. Format:
  ///  `policies/{attachment_point}/denypolicies/{policy_id}`
  ///
  ///
  ///  The attachment point is identified by its URL-encoded full resource name,
  ///  which means that the forward-slash character, `/`, must be written as
  ///  `%2F`. For example,
  ///  `policies/cloudresourcemanager.googleapis.com%2Fprojects%2Fmy-project/denypolicies/my-deny-policy`.
  ///
  ///  For organizations and folders, use the numeric ID in the full resource
  ///  name. For projects, requests can use the alphanumeric or the numeric ID.
  ///  Responses always contain the numeric ID.
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

  /// Immutable. The globally unique ID of the `Policy`. Assigned automatically when the
  /// `Policy` is created.
  @$pb.TagNumber(2)
  $core.String get uid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uid($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUid() => clearField(2);

  /// Output only. The kind of the `Policy`. Always contains the value `DenyPolicy`.
  @$pb.TagNumber(3)
  $core.String get kind => $_getSZ(2);
  @$pb.TagNumber(3)
  set kind($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => clearField(3);

  /// A user-specified description of the `Policy`. This value can be up to 63
  /// characters.
  @$pb.TagNumber(4)
  $core.String get displayName => $_getSZ(3);
  @$pb.TagNumber(4)
  set displayName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasDisplayName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayName() => clearField(4);

  /// A key-value map to store arbitrary metadata for the `Policy`. Keys
  /// can be up to 63 characters. Values can be up to 255 characters.
  @$pb.TagNumber(5)
  $core.Map<$core.String, $core.String> get annotations => $_getMap(4);

  ///  An opaque tag that identifies the current version of the `Policy`. IAM uses
  ///  this value to help manage concurrent updates, so they do not cause one
  ///  update to be overwritten by another.
  ///
  ///  If this field is present in a [CreatePolicy][] request, the value is
  ///  ignored.
  @$pb.TagNumber(6)
  $core.String get etag => $_getSZ(5);
  @$pb.TagNumber(6)
  set etag($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasEtag() => $_has(5);
  @$pb.TagNumber(6)
  void clearEtag() => clearField(6);

  /// Output only. The time when the `Policy` was created.
  @$pb.TagNumber(7)
  $50.Timestamp get createTime => $_getN(6);
  @$pb.TagNumber(7)
  set createTime($50.Timestamp v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasCreateTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreateTime() => clearField(7);
  @$pb.TagNumber(7)
  $50.Timestamp ensureCreateTime() => $_ensure(6);

  /// Output only. The time when the `Policy` was last updated.
  @$pb.TagNumber(8)
  $50.Timestamp get updateTime => $_getN(7);
  @$pb.TagNumber(8)
  set updateTime($50.Timestamp v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasUpdateTime() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdateTime() => clearField(8);
  @$pb.TagNumber(8)
  $50.Timestamp ensureUpdateTime() => $_ensure(7);

  /// Output only. The time when the `Policy` was deleted. Empty if the policy is not deleted.
  @$pb.TagNumber(9)
  $50.Timestamp get deleteTime => $_getN(8);
  @$pb.TagNumber(9)
  set deleteTime($50.Timestamp v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDeleteTime() => $_has(8);
  @$pb.TagNumber(9)
  void clearDeleteTime() => clearField(9);
  @$pb.TagNumber(9)
  $50.Timestamp ensureDeleteTime() => $_ensure(8);

  /// A list of rules that specify the behavior of the `Policy`. All of the rules
  /// should be of the `kind` specified in the `Policy`.
  @$pb.TagNumber(10)
  $core.List<PolicyRule> get rules => $_getList(9);
}

enum PolicyRule_Kind { denyRule, notSet }

/// A single rule in a `Policy`.
class PolicyRule extends $pb.GeneratedMessage {
  factory PolicyRule({
    $core.String? description,
    $116.DenyRule? denyRule,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (denyRule != null) {
      $result.denyRule = denyRule;
    }
    return $result;
  }
  PolicyRule._() : super();
  factory PolicyRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PolicyRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, PolicyRule_Kind> _PolicyRule_KindByTag = {
    2: PolicyRule_Kind.denyRule,
    0: PolicyRule_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicyRule',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..aOM<$116.DenyRule>(2, _omitFieldNames ? '' : 'denyRule',
        subBuilder: $116.DenyRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PolicyRule clone() => PolicyRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PolicyRule copyWith(void Function(PolicyRule) updates) =>
      super.copyWith((message) => updates(message as PolicyRule)) as PolicyRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicyRule create() => PolicyRule._();
  PolicyRule createEmptyInstance() => create();
  static $pb.PbList<PolicyRule> createRepeated() => $pb.PbList<PolicyRule>();
  @$core.pragma('dart2js:noInline')
  static PolicyRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicyRule>(create);
  static PolicyRule? _defaultInstance;

  PolicyRule_Kind whichKind() => _PolicyRule_KindByTag[$_whichOneof(0)]!;
  void clearKind() => clearField($_whichOneof(0));

  /// A user-specified description of the rule. This value can be up to 256
  /// characters.
  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => clearField(1);

  /// A rule for a deny policy.
  @$pb.TagNumber(2)
  $116.DenyRule get denyRule => $_getN(1);
  @$pb.TagNumber(2)
  set denyRule($116.DenyRule v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDenyRule() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenyRule() => clearField(2);
  @$pb.TagNumber(2)
  $116.DenyRule ensureDenyRule() => $_ensure(1);
}

/// Request message for `ListPolicies`.
class ListPoliciesRequest extends $pb.GeneratedMessage {
  factory ListPoliciesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListPoliciesRequest._() : super();
  factory ListPoliciesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListPoliciesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPoliciesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListPoliciesRequest clone() => ListPoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListPoliciesRequest copyWith(void Function(ListPoliciesRequest) updates) =>
      super.copyWith((message) => updates(message as ListPoliciesRequest))
          as ListPoliciesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPoliciesRequest create() => ListPoliciesRequest._();
  ListPoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<ListPoliciesRequest> createRepeated() =>
      $pb.PbList<ListPoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPoliciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPoliciesRequest>(create);
  static ListPoliciesRequest? _defaultInstance;

  ///  Required. The resource that the policy is attached to, along with the kind of policy
  ///  to list. Format:
  ///  `policies/{attachment_point}/denypolicies`
  ///
  ///
  ///  The attachment point is identified by its URL-encoded full resource name,
  ///  which means that the forward-slash character, `/`, must be written as
  ///  `%2F`. For example,
  ///  `policies/cloudresourcemanager.googleapis.com%2Fprojects%2Fmy-project/denypolicies`.
  ///
  ///  For organizations and folders, use the numeric ID in the full resource
  ///  name. For projects, you can use the alphanumeric or the numeric ID.
  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);

  /// The maximum number of policies to return. IAM ignores this value and uses
  /// the value 1000.
  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  /// A page token received in a [ListPoliciesResponse][google.iam.v2beta.ListPoliciesResponse]. Provide this token to
  /// retrieve the next page.
  @$pb.TagNumber(3)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set pageToken($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageToken() => clearField(3);
}

/// Response message for `ListPolicies`.
class ListPoliciesResponse extends $pb.GeneratedMessage {
  factory ListPoliciesResponse({
    $core.Iterable<Policy>? policies,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (policies != null) {
      $result.policies.addAll(policies);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListPoliciesResponse._() : super();
  factory ListPoliciesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListPoliciesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListPoliciesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..pc<Policy>(1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM,
        subBuilder: Policy.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListPoliciesResponse clone() =>
      ListPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListPoliciesResponse copyWith(void Function(ListPoliciesResponse) updates) =>
      super.copyWith((message) => updates(message as ListPoliciesResponse))
          as ListPoliciesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPoliciesResponse create() => ListPoliciesResponse._();
  ListPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<ListPoliciesResponse> createRepeated() =>
      $pb.PbList<ListPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPoliciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListPoliciesResponse>(create);
  static ListPoliciesResponse? _defaultInstance;

  /// Metadata for the policies that are attached to the resource.
  @$pb.TagNumber(1)
  $core.List<Policy> get policies => $_getList(0);

  /// A page token that you can use in a [ListPoliciesRequest][google.iam.v2beta.ListPoliciesRequest] to retrieve the
  /// next page. If this field is omitted, there are no additional pages.
  @$pb.TagNumber(2)
  $core.String get nextPageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextPageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => clearField(2);
}

/// Request message for `GetPolicy`.
class GetPolicyRequest extends $pb.GeneratedMessage {
  factory GetPolicyRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetPolicyRequest._() : super();
  factory GetPolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetPolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetPolicyRequest clone() => GetPolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetPolicyRequest copyWith(void Function(GetPolicyRequest) updates) =>
      super.copyWith((message) => updates(message as GetPolicyRequest))
          as GetPolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPolicyRequest create() => GetPolicyRequest._();
  GetPolicyRequest createEmptyInstance() => create();
  static $pb.PbList<GetPolicyRequest> createRepeated() =>
      $pb.PbList<GetPolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPolicyRequest>(create);
  static GetPolicyRequest? _defaultInstance;

  ///  Required. The resource name of the policy to retrieve. Format:
  ///  `policies/{attachment_point}/denypolicies/{policy_id}`
  ///
  ///
  ///  Use the URL-encoded full resource name, which means that the forward-slash
  ///  character, `/`, must be written as `%2F`. For example,
  ///  `policies/cloudresourcemanager.googleapis.com%2Fprojects%2Fmy-project/denypolicies/my-policy`.
  ///
  ///  For organizations and folders, use the numeric ID in the full resource
  ///  name. For projects, you can use the alphanumeric or the numeric ID.
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
}

/// Request message for `CreatePolicy`.
class CreatePolicyRequest extends $pb.GeneratedMessage {
  factory CreatePolicyRequest({
    $core.String? parent,
    Policy? policy,
    $core.String? policyId,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (policy != null) {
      $result.policy = policy;
    }
    if (policyId != null) {
      $result.policyId = policyId;
    }
    return $result;
  }
  CreatePolicyRequest._() : super();
  factory CreatePolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreatePolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<Policy>(2, _omitFieldNames ? '' : 'policy', subBuilder: Policy.create)
    ..aOS(3, _omitFieldNames ? '' : 'policyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreatePolicyRequest clone() => CreatePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreatePolicyRequest copyWith(void Function(CreatePolicyRequest) updates) =>
      super.copyWith((message) => updates(message as CreatePolicyRequest))
          as CreatePolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePolicyRequest create() => CreatePolicyRequest._();
  CreatePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePolicyRequest> createRepeated() =>
      $pb.PbList<CreatePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePolicyRequest>(create);
  static CreatePolicyRequest? _defaultInstance;

  ///  Required. The resource that the policy is attached to, along with the kind of policy
  ///  to create. Format: `policies/{attachment_point}/denypolicies`
  ///
  ///
  ///  The attachment point is identified by its URL-encoded full resource name,
  ///  which means that the forward-slash character, `/`, must be written as
  ///  `%2F`. For example,
  ///  `policies/cloudresourcemanager.googleapis.com%2Fprojects%2Fmy-project/denypolicies`.
  ///
  ///  For organizations and folders, use the numeric ID in the full resource
  ///  name. For projects, you can use the alphanumeric or the numeric ID.
  @$pb.TagNumber(1)
  $core.String get parent => $_getSZ(0);
  @$pb.TagNumber(1)
  set parent($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasParent() => $_has(0);
  @$pb.TagNumber(1)
  void clearParent() => clearField(1);

  /// Required. The policy to create.
  @$pb.TagNumber(2)
  Policy get policy => $_getN(1);
  @$pb.TagNumber(2)
  set policy(Policy v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPolicy() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicy() => clearField(2);
  @$pb.TagNumber(2)
  Policy ensurePolicy() => $_ensure(1);

  /// The ID to use for this policy, which will become the final component of
  /// the policy's resource name. The ID must contain 3 to 63 characters. It can
  /// contain lowercase letters and numbers, as well as dashes (`-`) and periods
  /// (`.`). The first character must be a lowercase letter.
  @$pb.TagNumber(3)
  $core.String get policyId => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPolicyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyId() => clearField(3);
}

/// Request message for `UpdatePolicy`.
class UpdatePolicyRequest extends $pb.GeneratedMessage {
  factory UpdatePolicyRequest({
    Policy? policy,
  }) {
    final $result = create();
    if (policy != null) {
      $result.policy = policy;
    }
    return $result;
  }
  UpdatePolicyRequest._() : super();
  factory UpdatePolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdatePolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOM<Policy>(1, _omitFieldNames ? '' : 'policy', subBuilder: Policy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdatePolicyRequest clone() => UpdatePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdatePolicyRequest copyWith(void Function(UpdatePolicyRequest) updates) =>
      super.copyWith((message) => updates(message as UpdatePolicyRequest))
          as UpdatePolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePolicyRequest create() => UpdatePolicyRequest._();
  UpdatePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePolicyRequest> createRepeated() =>
      $pb.PbList<UpdatePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePolicyRequest>(create);
  static UpdatePolicyRequest? _defaultInstance;

  ///  Required. The policy to update.
  ///
  ///  To prevent conflicting updates, the `etag` value must match the value that
  ///  is stored in IAM. If the `etag` values do not match, the request fails with
  ///  a `409` error code and `ABORTED` status.
  @$pb.TagNumber(1)
  Policy get policy => $_getN(0);
  @$pb.TagNumber(1)
  set policy(Policy v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPolicy() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicy() => clearField(1);
  @$pb.TagNumber(1)
  Policy ensurePolicy() => $_ensure(0);
}

/// Request message for `DeletePolicy`.
class DeletePolicyRequest extends $pb.GeneratedMessage {
  factory DeletePolicyRequest({
    $core.String? name,
    $core.String? etag,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    return $result;
  }
  DeletePolicyRequest._() : super();
  factory DeletePolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeletePolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletePolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeletePolicyRequest clone() => DeletePolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeletePolicyRequest copyWith(void Function(DeletePolicyRequest) updates) =>
      super.copyWith((message) => updates(message as DeletePolicyRequest))
          as DeletePolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePolicyRequest create() => DeletePolicyRequest._();
  DeletePolicyRequest createEmptyInstance() => create();
  static $pb.PbList<DeletePolicyRequest> createRepeated() =>
      $pb.PbList<DeletePolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static DeletePolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeletePolicyRequest>(create);
  static DeletePolicyRequest? _defaultInstance;

  ///  Required. The resource name of the policy to delete. Format:
  ///  `policies/{attachment_point}/denypolicies/{policy_id}`
  ///
  ///
  ///  Use the URL-encoded full resource name, which means that the forward-slash
  ///  character, `/`, must be written as `%2F`. For example,
  ///  `policies/cloudresourcemanager.googleapis.com%2Fprojects%2Fmy-project/denypolicies/my-policy`.
  ///
  ///  For organizations and folders, use the numeric ID in the full resource
  ///  name. For projects, you can use the alphanumeric or the numeric ID.
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

  ///  Optional. The expected `etag` of the policy to delete. If the value does not match
  ///  the value that is stored in IAM, the request fails with a `409` error code
  ///  and `ABORTED` status.
  ///
  ///  If you omit this field, the policy is deleted regardless of its current
  ///  `etag`.
  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => clearField(2);
}

/// Metadata for long-running `Policy` operations.
class PolicyOperationMetadata extends $pb.GeneratedMessage {
  factory PolicyOperationMetadata({
    $50.Timestamp? createTime,
  }) {
    final $result = create();
    if (createTime != null) {
      $result.createTime = createTime;
    }
    return $result;
  }
  PolicyOperationMetadata._() : super();
  factory PolicyOperationMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PolicyOperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicyOperationMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2beta'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'createTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PolicyOperationMetadata clone() =>
      PolicyOperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PolicyOperationMetadata copyWith(
          void Function(PolicyOperationMetadata) updates) =>
      super.copyWith((message) => updates(message as PolicyOperationMetadata))
          as PolicyOperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicyOperationMetadata create() => PolicyOperationMetadata._();
  PolicyOperationMetadata createEmptyInstance() => create();
  static $pb.PbList<PolicyOperationMetadata> createRepeated() =>
      $pb.PbList<PolicyOperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static PolicyOperationMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicyOperationMetadata>(create);
  static PolicyOperationMetadata? _defaultInstance;

  /// Timestamp when the `google.longrunning.Operation` was created.
  @$pb.TagNumber(1)
  $50.Timestamp get createTime => $_getN(0);
  @$pb.TagNumber(1)
  set createTime($50.Timestamp v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCreateTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearCreateTime() => clearField(1);
  @$pb.TagNumber(1)
  $50.Timestamp ensureCreateTime() => $_ensure(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
