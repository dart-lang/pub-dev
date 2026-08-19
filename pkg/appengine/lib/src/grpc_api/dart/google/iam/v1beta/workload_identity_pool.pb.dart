//
//  Generated code. Do not modify.
//  source: google/iam/v1beta/workload_identity_pool.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/field_mask.pb.dart' as $58;
import 'workload_identity_pool.pbenum.dart';

export 'workload_identity_pool.pbenum.dart';

/// Represents a collection of external workload identities. You can define IAM
/// policies to grant these identities access to Google Cloud resources.
class WorkloadIdentityPool extends $pb.GeneratedMessage {
  factory WorkloadIdentityPool({
    $core.String? name,
    $core.String? displayName,
    $core.String? description,
    WorkloadIdentityPool_State? state,
    $core.bool? disabled,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (state != null) {
      $result.state = state;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    return $result;
  }
  WorkloadIdentityPool._() : super();
  factory WorkloadIdentityPool.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPool.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPool',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<WorkloadIdentityPool_State>(
        4, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: WorkloadIdentityPool_State.STATE_UNSPECIFIED,
        valueOf: WorkloadIdentityPool_State.valueOf,
        enumValues: WorkloadIdentityPool_State.values)
    ..aOB(5, _omitFieldNames ? '' : 'disabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPool clone() =>
      WorkloadIdentityPool()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPool copyWith(void Function(WorkloadIdentityPool) updates) =>
      super.copyWith((message) => updates(message as WorkloadIdentityPool))
          as WorkloadIdentityPool;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPool create() => WorkloadIdentityPool._();
  WorkloadIdentityPool createEmptyInstance() => create();
  static $pb.PbList<WorkloadIdentityPool> createRepeated() =>
      $pb.PbList<WorkloadIdentityPool>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPool getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkloadIdentityPool>(create);
  static WorkloadIdentityPool? _defaultInstance;

  /// Output only. The resource name of the pool.
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

  /// A display name for the pool. Cannot exceed 32 characters.
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  /// A description of the pool. Cannot exceed 256 characters.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  /// Output only. The state of the pool.
  @$pb.TagNumber(4)
  WorkloadIdentityPool_State get state => $_getN(3);
  @$pb.TagNumber(4)
  set state(WorkloadIdentityPool_State v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  /// Whether the pool is disabled. You cannot use a disabled pool to exchange
  /// tokens, or use existing tokens to access resources. If
  /// the pool is re-enabled, existing tokens grant access again.
  @$pb.TagNumber(5)
  $core.bool get disabled => $_getBF(4);
  @$pb.TagNumber(5)
  set disabled($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDisabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisabled() => clearField(5);
}

/// Represents an Amazon Web Services identity provider.
class WorkloadIdentityPoolProvider_Aws extends $pb.GeneratedMessage {
  factory WorkloadIdentityPoolProvider_Aws({
    $core.String? accountId,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    return $result;
  }
  WorkloadIdentityPoolProvider_Aws._() : super();
  factory WorkloadIdentityPoolProvider_Aws.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPoolProvider_Aws.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPoolProvider.Aws',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider_Aws clone() =>
      WorkloadIdentityPoolProvider_Aws()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider_Aws copyWith(
          void Function(WorkloadIdentityPoolProvider_Aws) updates) =>
      super.copyWith(
              (message) => updates(message as WorkloadIdentityPoolProvider_Aws))
          as WorkloadIdentityPoolProvider_Aws;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider_Aws create() =>
      WorkloadIdentityPoolProvider_Aws._();
  WorkloadIdentityPoolProvider_Aws createEmptyInstance() => create();
  static $pb.PbList<WorkloadIdentityPoolProvider_Aws> createRepeated() =>
      $pb.PbList<WorkloadIdentityPoolProvider_Aws>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider_Aws getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkloadIdentityPoolProvider_Aws>(
          create);
  static WorkloadIdentityPoolProvider_Aws? _defaultInstance;

  /// Required. The AWS account ID.
  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

/// Represents an OpenId Connect 1.0 identity provider.
class WorkloadIdentityPoolProvider_Oidc extends $pb.GeneratedMessage {
  factory WorkloadIdentityPoolProvider_Oidc({
    $core.String? issuerUri,
    $core.Iterable<$core.String>? allowedAudiences,
  }) {
    final $result = create();
    if (issuerUri != null) {
      $result.issuerUri = issuerUri;
    }
    if (allowedAudiences != null) {
      $result.allowedAudiences.addAll(allowedAudiences);
    }
    return $result;
  }
  WorkloadIdentityPoolProvider_Oidc._() : super();
  factory WorkloadIdentityPoolProvider_Oidc.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPoolProvider_Oidc.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPoolProvider.Oidc',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'issuerUri')
    ..pPS(2, _omitFieldNames ? '' : 'allowedAudiences')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider_Oidc clone() =>
      WorkloadIdentityPoolProvider_Oidc()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider_Oidc copyWith(
          void Function(WorkloadIdentityPoolProvider_Oidc) updates) =>
      super.copyWith((message) =>
              updates(message as WorkloadIdentityPoolProvider_Oidc))
          as WorkloadIdentityPoolProvider_Oidc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider_Oidc create() =>
      WorkloadIdentityPoolProvider_Oidc._();
  WorkloadIdentityPoolProvider_Oidc createEmptyInstance() => create();
  static $pb.PbList<WorkloadIdentityPoolProvider_Oidc> createRepeated() =>
      $pb.PbList<WorkloadIdentityPoolProvider_Oidc>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider_Oidc getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkloadIdentityPoolProvider_Oidc>(
          create);
  static WorkloadIdentityPoolProvider_Oidc? _defaultInstance;

  /// Required. The OIDC issuer URL.
  @$pb.TagNumber(1)
  $core.String get issuerUri => $_getSZ(0);
  @$pb.TagNumber(1)
  set issuerUri($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIssuerUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearIssuerUri() => clearField(1);

  ///  Acceptable values for the `aud` field (audience) in the OIDC token. Token
  ///  exchange requests are rejected if the token audience does not match one
  ///  of the configured values. Each audience may be at most 256 characters. A
  ///  maximum of 10 audiences may be configured.
  ///
  ///  If this list is empty, the OIDC token audience must be equal to
  ///  the full canonical resource name of the WorkloadIdentityPoolProvider,
  ///  with or without the HTTPS prefix. For example:
  ///
  ///  ```
  ///  //iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
  ///  https://iam.googleapis.com/projects/<project-number>/locations/<location>/workloadIdentityPools/<pool-id>/providers/<provider-id>
  ///  ```
  @$pb.TagNumber(2)
  $core.List<$core.String> get allowedAudiences => $_getList(1);
}

enum WorkloadIdentityPoolProvider_ProviderConfig { aws, oidc, notSet }

/// A configuration for an external identity provider.
class WorkloadIdentityPoolProvider extends $pb.GeneratedMessage {
  factory WorkloadIdentityPoolProvider({
    $core.String? name,
    $core.String? displayName,
    $core.String? description,
    WorkloadIdentityPoolProvider_State? state,
    $core.bool? disabled,
    $core.Map<$core.String, $core.String>? attributeMapping,
    $core.String? attributeCondition,
    WorkloadIdentityPoolProvider_Aws? aws,
    WorkloadIdentityPoolProvider_Oidc? oidc,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (description != null) {
      $result.description = description;
    }
    if (state != null) {
      $result.state = state;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    if (attributeMapping != null) {
      $result.attributeMapping.addAll(attributeMapping);
    }
    if (attributeCondition != null) {
      $result.attributeCondition = attributeCondition;
    }
    if (aws != null) {
      $result.aws = aws;
    }
    if (oidc != null) {
      $result.oidc = oidc;
    }
    return $result;
  }
  WorkloadIdentityPoolProvider._() : super();
  factory WorkloadIdentityPoolProvider.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPoolProvider.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, WorkloadIdentityPoolProvider_ProviderConfig>
      _WorkloadIdentityPoolProvider_ProviderConfigByTag = {
    8: WorkloadIdentityPoolProvider_ProviderConfig.aws,
    9: WorkloadIdentityPoolProvider_ProviderConfig.oidc,
    0: WorkloadIdentityPoolProvider_ProviderConfig.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPoolProvider',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..oo(0, [8, 9])
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..e<WorkloadIdentityPoolProvider_State>(
        4, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker: WorkloadIdentityPoolProvider_State.STATE_UNSPECIFIED,
        valueOf: WorkloadIdentityPoolProvider_State.valueOf,
        enumValues: WorkloadIdentityPoolProvider_State.values)
    ..aOB(5, _omitFieldNames ? '' : 'disabled')
    ..m<$core.String, $core.String>(
        6, _omitFieldNames ? '' : 'attributeMapping',
        entryClassName: 'WorkloadIdentityPoolProvider.AttributeMappingEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('google.iam.v1beta'))
    ..aOS(7, _omitFieldNames ? '' : 'attributeCondition')
    ..aOM<WorkloadIdentityPoolProvider_Aws>(8, _omitFieldNames ? '' : 'aws',
        subBuilder: WorkloadIdentityPoolProvider_Aws.create)
    ..aOM<WorkloadIdentityPoolProvider_Oidc>(9, _omitFieldNames ? '' : 'oidc',
        subBuilder: WorkloadIdentityPoolProvider_Oidc.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider clone() =>
      WorkloadIdentityPoolProvider()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProvider copyWith(
          void Function(WorkloadIdentityPoolProvider) updates) =>
      super.copyWith(
              (message) => updates(message as WorkloadIdentityPoolProvider))
          as WorkloadIdentityPoolProvider;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider create() =>
      WorkloadIdentityPoolProvider._();
  WorkloadIdentityPoolProvider createEmptyInstance() => create();
  static $pb.PbList<WorkloadIdentityPoolProvider> createRepeated() =>
      $pb.PbList<WorkloadIdentityPoolProvider>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProvider getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WorkloadIdentityPoolProvider>(create);
  static WorkloadIdentityPoolProvider? _defaultInstance;

  WorkloadIdentityPoolProvider_ProviderConfig whichProviderConfig() =>
      _WorkloadIdentityPoolProvider_ProviderConfigByTag[$_whichOneof(0)]!;
  void clearProviderConfig() => clearField($_whichOneof(0));

  /// Output only. The resource name of the provider.
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

  /// A display name for the provider. Cannot exceed 32 characters.
  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  /// A description for the provider. Cannot exceed 256 characters.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  /// Output only. The state of the provider.
  @$pb.TagNumber(4)
  WorkloadIdentityPoolProvider_State get state => $_getN(3);
  @$pb.TagNumber(4)
  set state(WorkloadIdentityPoolProvider_State v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  /// Whether the provider is disabled. You cannot use a disabled provider to
  /// exchange tokens. However, existing tokens still grant access.
  @$pb.TagNumber(5)
  $core.bool get disabled => $_getBF(4);
  @$pb.TagNumber(5)
  set disabled($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDisabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisabled() => clearField(5);

  ///  Maps attributes from authentication credentials issued by an external
  ///  identity provider to Google Cloud attributes, such as `subject` and
  ///  `segment`.
  ///
  ///  Each key must be a string specifying the Google Cloud IAM attribute to
  ///  map to.
  ///
  ///  The following keys are supported:
  ///
  ///  * `google.subject`: The principal IAM is authenticating. You can reference
  ///                      this value in IAM bindings. This is also the
  ///                      subject that appears in Cloud Logging logs.
  ///                      Cannot exceed 127 characters.
  ///
  ///  * `google.groups`: Groups the external identity belongs to. You can grant
  ///                     groups access to resources using an IAM `principalSet`
  ///                     binding; access applies to all members of the group.
  ///
  ///  You can also provide custom attributes by specifying
  ///  `attribute.{custom_attribute}`, where `{custom_attribute}` is the name of
  ///  the custom attribute to be mapped. You can define a maximum of 50 custom
  ///  attributes. The maximum length of a mapped attribute key is
  ///  100 characters, and the key may only contain the characters [a-z0-9_].
  ///
  ///  You can reference these attributes in IAM policies to define fine-grained
  ///  access for a workload to Google Cloud resources. For example:
  ///
  ///  * `google.subject`:
  ///  `principal://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/subject/{value}`
  ///
  ///  * `google.groups`:
  ///  `principalSet://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/group/{value}`
  ///
  ///  * `attribute.{custom_attribute}`:
  ///  `principalSet://iam.googleapis.com/projects/{project}/locations/{location}/workloadIdentityPools/{pool}/attribute.{custom_attribute}/{value}`
  ///
  ///  Each value must be a [Common Expression Language]
  ///  (https://opensource.google/projects/cel) function that maps an
  ///  identity provider credential to the normalized attribute specified by the
  ///  corresponding map key.
  ///
  ///  You can use the `assertion` keyword in the expression to access a JSON
  ///  representation of the authentication credential issued by the provider.
  ///
  ///  The maximum length of an attribute mapping expression is 2048 characters.
  ///  When evaluated, the total size of all mapped attributes must not exceed
  ///  8KB.
  ///
  ///  For AWS providers, the following rules apply:
  ///
  ///  - If no attribute mapping is defined, the following default mapping
  ///    applies:
  ///
  ///    ```
  ///    {
  ///      "google.subject":"assertion.arn",
  ///      "attribute.aws_role":
  ///          "assertion.arn.contains('assumed-role')"
  ///          " ? assertion.arn.extract('{account_arn}assumed-role/')"
  ///          "   + 'assumed-role/'"
  ///          "   + assertion.arn.extract('assumed-role/{role_name}/')"
  ///          " : assertion.arn",
  ///    }
  ///    ```
  ///
  ///  - If any custom attribute mappings are defined, they must include a mapping
  ///    to the `google.subject` attribute.
  ///
  ///
  ///  For OIDC providers, the following rules apply:
  ///
  ///  - Custom attribute mappings must be defined, and must include a mapping to
  ///    the `google.subject` attribute. For example, the following maps the
  ///    `sub` claim of the incoming credential to the `subject` attribute on
  ///    a Google token.
  ///
  ///    ```
  ///    {"google.subject": "assertion.sub"}
  ///    ```
  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get attributeMapping => $_getMap(5);

  ///  [A Common Expression Language](https://opensource.google/projects/cel)
  ///  expression, in plain text, to restrict what otherwise valid authentication
  ///  credentials issued by the provider should not be accepted.
  ///
  ///  The expression must output a boolean representing whether to allow the
  ///  federation.
  ///
  ///  The following keywords may be referenced in the expressions:
  ///
  ///  * `assertion`: JSON representing the authentication credential issued by
  ///                 the provider.
  ///  * `google`: The Google attributes mapped from the assertion in the
  ///              `attribute_mappings`.
  ///  * `attribute`: The custom attributes mapped from the assertion in the
  ///                 `attribute_mappings`.
  ///
  ///  The maximum length of the attribute condition expression is 4096
  ///  characters. If unspecified, all valid authentication credential are
  ///  accepted.
  ///
  ///  The following example shows how to only allow credentials with a mapped
  ///  `google.groups` value of `admins`:
  ///
  ///  ```
  ///  "'admins' in google.groups"
  ///  ```
  @$pb.TagNumber(7)
  $core.String get attributeCondition => $_getSZ(6);
  @$pb.TagNumber(7)
  set attributeCondition($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasAttributeCondition() => $_has(6);
  @$pb.TagNumber(7)
  void clearAttributeCondition() => clearField(7);

  /// An Amazon Web Services identity provider.
  @$pb.TagNumber(8)
  WorkloadIdentityPoolProvider_Aws get aws => $_getN(7);
  @$pb.TagNumber(8)
  set aws(WorkloadIdentityPoolProvider_Aws v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasAws() => $_has(7);
  @$pb.TagNumber(8)
  void clearAws() => clearField(8);
  @$pb.TagNumber(8)
  WorkloadIdentityPoolProvider_Aws ensureAws() => $_ensure(7);

  /// An OpenId Connect 1.0 identity provider.
  @$pb.TagNumber(9)
  WorkloadIdentityPoolProvider_Oidc get oidc => $_getN(8);
  @$pb.TagNumber(9)
  set oidc(WorkloadIdentityPoolProvider_Oidc v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasOidc() => $_has(8);
  @$pb.TagNumber(9)
  void clearOidc() => clearField(9);
  @$pb.TagNumber(9)
  WorkloadIdentityPoolProvider_Oidc ensureOidc() => $_ensure(8);
}

/// Request message for ListWorkloadIdentityPools.
class ListWorkloadIdentityPoolsRequest extends $pb.GeneratedMessage {
  factory ListWorkloadIdentityPoolsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.bool? showDeleted,
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
    if (showDeleted != null) {
      $result.showDeleted = showDeleted;
    }
    return $result;
  }
  ListWorkloadIdentityPoolsRequest._() : super();
  factory ListWorkloadIdentityPoolsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListWorkloadIdentityPoolsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWorkloadIdentityPoolsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOB(4, _omitFieldNames ? '' : 'showDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolsRequest clone() =>
      ListWorkloadIdentityPoolsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolsRequest copyWith(
          void Function(ListWorkloadIdentityPoolsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListWorkloadIdentityPoolsRequest))
          as ListWorkloadIdentityPoolsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolsRequest create() =>
      ListWorkloadIdentityPoolsRequest._();
  ListWorkloadIdentityPoolsRequest createEmptyInstance() => create();
  static $pb.PbList<ListWorkloadIdentityPoolsRequest> createRepeated() =>
      $pb.PbList<ListWorkloadIdentityPoolsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListWorkloadIdentityPoolsRequest>(
          create);
  static ListWorkloadIdentityPoolsRequest? _defaultInstance;

  /// Required. The parent resource to list pools for.
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

  /// The maximum number of pools to return.
  /// If unspecified, at most 50 pools are returned.
  /// The maximum value is 1000; values above are 1000 truncated to 1000.
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

  /// A page token, received from a previous `ListWorkloadIdentityPools`
  /// call. Provide this to retrieve the subsequent page.
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

  /// Whether to return soft-deleted pools.
  @$pb.TagNumber(4)
  $core.bool get showDeleted => $_getBF(3);
  @$pb.TagNumber(4)
  set showDeleted($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasShowDeleted() => $_has(3);
  @$pb.TagNumber(4)
  void clearShowDeleted() => clearField(4);
}

/// Response message for ListWorkloadIdentityPools.
class ListWorkloadIdentityPoolsResponse extends $pb.GeneratedMessage {
  factory ListWorkloadIdentityPoolsResponse({
    $core.Iterable<WorkloadIdentityPool>? workloadIdentityPools,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (workloadIdentityPools != null) {
      $result.workloadIdentityPools.addAll(workloadIdentityPools);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListWorkloadIdentityPoolsResponse._() : super();
  factory ListWorkloadIdentityPoolsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListWorkloadIdentityPoolsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWorkloadIdentityPoolsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..pc<WorkloadIdentityPool>(
        1, _omitFieldNames ? '' : 'workloadIdentityPools', $pb.PbFieldType.PM,
        subBuilder: WorkloadIdentityPool.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolsResponse clone() =>
      ListWorkloadIdentityPoolsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolsResponse copyWith(
          void Function(ListWorkloadIdentityPoolsResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListWorkloadIdentityPoolsResponse))
          as ListWorkloadIdentityPoolsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolsResponse create() =>
      ListWorkloadIdentityPoolsResponse._();
  ListWorkloadIdentityPoolsResponse createEmptyInstance() => create();
  static $pb.PbList<ListWorkloadIdentityPoolsResponse> createRepeated() =>
      $pb.PbList<ListWorkloadIdentityPoolsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListWorkloadIdentityPoolsResponse>(
          create);
  static ListWorkloadIdentityPoolsResponse? _defaultInstance;

  /// A list of pools.
  @$pb.TagNumber(1)
  $core.List<WorkloadIdentityPool> get workloadIdentityPools => $_getList(0);

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
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

/// Request message for GetWorkloadIdentityPool.
class GetWorkloadIdentityPoolRequest extends $pb.GeneratedMessage {
  factory GetWorkloadIdentityPoolRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetWorkloadIdentityPoolRequest._() : super();
  factory GetWorkloadIdentityPoolRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetWorkloadIdentityPoolRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWorkloadIdentityPoolRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetWorkloadIdentityPoolRequest clone() =>
      GetWorkloadIdentityPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetWorkloadIdentityPoolRequest copyWith(
          void Function(GetWorkloadIdentityPoolRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetWorkloadIdentityPoolRequest))
          as GetWorkloadIdentityPoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWorkloadIdentityPoolRequest create() =>
      GetWorkloadIdentityPoolRequest._();
  GetWorkloadIdentityPoolRequest createEmptyInstance() => create();
  static $pb.PbList<GetWorkloadIdentityPoolRequest> createRepeated() =>
      $pb.PbList<GetWorkloadIdentityPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWorkloadIdentityPoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWorkloadIdentityPoolRequest>(create);
  static GetWorkloadIdentityPoolRequest? _defaultInstance;

  /// Required. The name of the pool to retrieve.
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

/// Request message for CreateWorkloadIdentityPool.
class CreateWorkloadIdentityPoolRequest extends $pb.GeneratedMessage {
  factory CreateWorkloadIdentityPoolRequest({
    $core.String? parent,
    WorkloadIdentityPool? workloadIdentityPool,
    $core.String? workloadIdentityPoolId,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (workloadIdentityPool != null) {
      $result.workloadIdentityPool = workloadIdentityPool;
    }
    if (workloadIdentityPoolId != null) {
      $result.workloadIdentityPoolId = workloadIdentityPoolId;
    }
    return $result;
  }
  CreateWorkloadIdentityPoolRequest._() : super();
  factory CreateWorkloadIdentityPoolRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateWorkloadIdentityPoolRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWorkloadIdentityPoolRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<WorkloadIdentityPool>(
        2, _omitFieldNames ? '' : 'workloadIdentityPool',
        subBuilder: WorkloadIdentityPool.create)
    ..aOS(3, _omitFieldNames ? '' : 'workloadIdentityPoolId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateWorkloadIdentityPoolRequest clone() =>
      CreateWorkloadIdentityPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateWorkloadIdentityPoolRequest copyWith(
          void Function(CreateWorkloadIdentityPoolRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateWorkloadIdentityPoolRequest))
          as CreateWorkloadIdentityPoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWorkloadIdentityPoolRequest create() =>
      CreateWorkloadIdentityPoolRequest._();
  CreateWorkloadIdentityPoolRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWorkloadIdentityPoolRequest> createRepeated() =>
      $pb.PbList<CreateWorkloadIdentityPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWorkloadIdentityPoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateWorkloadIdentityPoolRequest>(
          create);
  static CreateWorkloadIdentityPoolRequest? _defaultInstance;

  /// Required. The parent resource to create the pool in. The only supported
  /// location is `global`.
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

  /// Required. The pool to create.
  @$pb.TagNumber(2)
  WorkloadIdentityPool get workloadIdentityPool => $_getN(1);
  @$pb.TagNumber(2)
  set workloadIdentityPool(WorkloadIdentityPool v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWorkloadIdentityPool() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkloadIdentityPool() => clearField(2);
  @$pb.TagNumber(2)
  WorkloadIdentityPool ensureWorkloadIdentityPool() => $_ensure(1);

  /// Required. The ID to use for the pool, which becomes the
  /// final component of the resource name. This value should be 4-32 characters,
  /// and may contain the characters [a-z0-9-]. The prefix `gcp-` is
  /// reserved for use by Google, and may not be specified.
  @$pb.TagNumber(3)
  $core.String get workloadIdentityPoolId => $_getSZ(2);
  @$pb.TagNumber(3)
  set workloadIdentityPoolId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWorkloadIdentityPoolId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorkloadIdentityPoolId() => clearField(3);
}

/// Request message for UpdateWorkloadIdentityPool.
class UpdateWorkloadIdentityPoolRequest extends $pb.GeneratedMessage {
  factory UpdateWorkloadIdentityPoolRequest({
    WorkloadIdentityPool? workloadIdentityPool,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (workloadIdentityPool != null) {
      $result.workloadIdentityPool = workloadIdentityPool;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateWorkloadIdentityPoolRequest._() : super();
  factory UpdateWorkloadIdentityPoolRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateWorkloadIdentityPoolRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateWorkloadIdentityPoolRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOM<WorkloadIdentityPool>(
        1, _omitFieldNames ? '' : 'workloadIdentityPool',
        subBuilder: WorkloadIdentityPool.create)
    ..aOM<$58.FieldMask>(2, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateWorkloadIdentityPoolRequest clone() =>
      UpdateWorkloadIdentityPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateWorkloadIdentityPoolRequest copyWith(
          void Function(UpdateWorkloadIdentityPoolRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateWorkloadIdentityPoolRequest))
          as UpdateWorkloadIdentityPoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateWorkloadIdentityPoolRequest create() =>
      UpdateWorkloadIdentityPoolRequest._();
  UpdateWorkloadIdentityPoolRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateWorkloadIdentityPoolRequest> createRepeated() =>
      $pb.PbList<UpdateWorkloadIdentityPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateWorkloadIdentityPoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateWorkloadIdentityPoolRequest>(
          create);
  static UpdateWorkloadIdentityPoolRequest? _defaultInstance;

  /// Required. The pool to update. The `name` field is used to identify the pool.
  @$pb.TagNumber(1)
  WorkloadIdentityPool get workloadIdentityPool => $_getN(0);
  @$pb.TagNumber(1)
  set workloadIdentityPool(WorkloadIdentityPool v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWorkloadIdentityPool() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkloadIdentityPool() => clearField(1);
  @$pb.TagNumber(1)
  WorkloadIdentityPool ensureWorkloadIdentityPool() => $_ensure(0);

  /// Required. The list of fields update.
  @$pb.TagNumber(2)
  $58.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($58.FieldMask v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $58.FieldMask ensureUpdateMask() => $_ensure(1);
}

/// Request message for DeleteWorkloadIdentityPool.
class DeleteWorkloadIdentityPoolRequest extends $pb.GeneratedMessage {
  factory DeleteWorkloadIdentityPoolRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteWorkloadIdentityPoolRequest._() : super();
  factory DeleteWorkloadIdentityPoolRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteWorkloadIdentityPoolRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteWorkloadIdentityPoolRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteWorkloadIdentityPoolRequest clone() =>
      DeleteWorkloadIdentityPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteWorkloadIdentityPoolRequest copyWith(
          void Function(DeleteWorkloadIdentityPoolRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeleteWorkloadIdentityPoolRequest))
          as DeleteWorkloadIdentityPoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWorkloadIdentityPoolRequest create() =>
      DeleteWorkloadIdentityPoolRequest._();
  DeleteWorkloadIdentityPoolRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteWorkloadIdentityPoolRequest> createRepeated() =>
      $pb.PbList<DeleteWorkloadIdentityPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteWorkloadIdentityPoolRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteWorkloadIdentityPoolRequest>(
          create);
  static DeleteWorkloadIdentityPoolRequest? _defaultInstance;

  /// Required. The name of the pool to delete.
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

/// Request message for UndeleteWorkloadIdentityPool.
class UndeleteWorkloadIdentityPoolRequest extends $pb.GeneratedMessage {
  factory UndeleteWorkloadIdentityPoolRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  UndeleteWorkloadIdentityPoolRequest._() : super();
  factory UndeleteWorkloadIdentityPoolRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteWorkloadIdentityPoolRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteWorkloadIdentityPoolRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteWorkloadIdentityPoolRequest clone() =>
      UndeleteWorkloadIdentityPoolRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteWorkloadIdentityPoolRequest copyWith(
          void Function(UndeleteWorkloadIdentityPoolRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UndeleteWorkloadIdentityPoolRequest))
          as UndeleteWorkloadIdentityPoolRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteWorkloadIdentityPoolRequest create() =>
      UndeleteWorkloadIdentityPoolRequest._();
  UndeleteWorkloadIdentityPoolRequest createEmptyInstance() => create();
  static $pb.PbList<UndeleteWorkloadIdentityPoolRequest> createRepeated() =>
      $pb.PbList<UndeleteWorkloadIdentityPoolRequest>();
  @$core.pragma('dart2js:noInline')
  static UndeleteWorkloadIdentityPoolRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UndeleteWorkloadIdentityPoolRequest>(create);
  static UndeleteWorkloadIdentityPoolRequest? _defaultInstance;

  /// Required. The name of the pool to undelete.
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

/// Request message for ListWorkloadIdentityPoolProviders.
class ListWorkloadIdentityPoolProvidersRequest extends $pb.GeneratedMessage {
  factory ListWorkloadIdentityPoolProvidersRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.bool? showDeleted,
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
    if (showDeleted != null) {
      $result.showDeleted = showDeleted;
    }
    return $result;
  }
  ListWorkloadIdentityPoolProvidersRequest._() : super();
  factory ListWorkloadIdentityPoolProvidersRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListWorkloadIdentityPoolProvidersRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWorkloadIdentityPoolProvidersRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOB(4, _omitFieldNames ? '' : 'showDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolProvidersRequest clone() =>
      ListWorkloadIdentityPoolProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolProvidersRequest copyWith(
          void Function(ListWorkloadIdentityPoolProvidersRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListWorkloadIdentityPoolProvidersRequest))
          as ListWorkloadIdentityPoolProvidersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolProvidersRequest create() =>
      ListWorkloadIdentityPoolProvidersRequest._();
  ListWorkloadIdentityPoolProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<ListWorkloadIdentityPoolProvidersRequest>
      createRepeated() =>
          $pb.PbList<ListWorkloadIdentityPoolProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolProvidersRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListWorkloadIdentityPoolProvidersRequest>(create);
  static ListWorkloadIdentityPoolProvidersRequest? _defaultInstance;

  /// Required. The pool to list providers for.
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

  /// The maximum number of providers to return.
  /// If unspecified, at most 50 providers are returned.
  /// The maximum value is 100; values above 100 are truncated to 100.
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

  /// A page token, received from a previous
  /// `ListWorkloadIdentityPoolProviders` call. Provide this to retrieve the
  /// subsequent page.
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

  /// Whether to return soft-deleted providers.
  @$pb.TagNumber(4)
  $core.bool get showDeleted => $_getBF(3);
  @$pb.TagNumber(4)
  set showDeleted($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasShowDeleted() => $_has(3);
  @$pb.TagNumber(4)
  void clearShowDeleted() => clearField(4);
}

/// Response message for ListWorkloadIdentityPoolProviders.
class ListWorkloadIdentityPoolProvidersResponse extends $pb.GeneratedMessage {
  factory ListWorkloadIdentityPoolProvidersResponse({
    $core.Iterable<WorkloadIdentityPoolProvider>? workloadIdentityPoolProviders,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (workloadIdentityPoolProviders != null) {
      $result.workloadIdentityPoolProviders
          .addAll(workloadIdentityPoolProviders);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListWorkloadIdentityPoolProvidersResponse._() : super();
  factory ListWorkloadIdentityPoolProvidersResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListWorkloadIdentityPoolProvidersResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListWorkloadIdentityPoolProvidersResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..pc<WorkloadIdentityPoolProvider>(
        1,
        _omitFieldNames ? '' : 'workloadIdentityPoolProviders',
        $pb.PbFieldType.PM,
        subBuilder: WorkloadIdentityPoolProvider.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolProvidersResponse clone() =>
      ListWorkloadIdentityPoolProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListWorkloadIdentityPoolProvidersResponse copyWith(
          void Function(ListWorkloadIdentityPoolProvidersResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListWorkloadIdentityPoolProvidersResponse))
          as ListWorkloadIdentityPoolProvidersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolProvidersResponse create() =>
      ListWorkloadIdentityPoolProvidersResponse._();
  ListWorkloadIdentityPoolProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<ListWorkloadIdentityPoolProvidersResponse>
      createRepeated() =>
          $pb.PbList<ListWorkloadIdentityPoolProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListWorkloadIdentityPoolProvidersResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          ListWorkloadIdentityPoolProvidersResponse>(create);
  static ListWorkloadIdentityPoolProvidersResponse? _defaultInstance;

  /// A list of providers.
  @$pb.TagNumber(1)
  $core.List<WorkloadIdentityPoolProvider> get workloadIdentityPoolProviders =>
      $_getList(0);

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
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

/// Request message for GetWorkloadIdentityPoolProvider.
class GetWorkloadIdentityPoolProviderRequest extends $pb.GeneratedMessage {
  factory GetWorkloadIdentityPoolProviderRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetWorkloadIdentityPoolProviderRequest._() : super();
  factory GetWorkloadIdentityPoolProviderRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetWorkloadIdentityPoolProviderRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWorkloadIdentityPoolProviderRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetWorkloadIdentityPoolProviderRequest clone() =>
      GetWorkloadIdentityPoolProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetWorkloadIdentityPoolProviderRequest copyWith(
          void Function(GetWorkloadIdentityPoolProviderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetWorkloadIdentityPoolProviderRequest))
          as GetWorkloadIdentityPoolProviderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWorkloadIdentityPoolProviderRequest create() =>
      GetWorkloadIdentityPoolProviderRequest._();
  GetWorkloadIdentityPoolProviderRequest createEmptyInstance() => create();
  static $pb.PbList<GetWorkloadIdentityPoolProviderRequest> createRepeated() =>
      $pb.PbList<GetWorkloadIdentityPoolProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWorkloadIdentityPoolProviderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetWorkloadIdentityPoolProviderRequest>(create);
  static GetWorkloadIdentityPoolProviderRequest? _defaultInstance;

  /// Required. The name of the provider to retrieve.
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

/// Request message for CreateWorkloadIdentityPoolProvider.
class CreateWorkloadIdentityPoolProviderRequest extends $pb.GeneratedMessage {
  factory CreateWorkloadIdentityPoolProviderRequest({
    $core.String? parent,
    WorkloadIdentityPoolProvider? workloadIdentityPoolProvider,
    $core.String? workloadIdentityPoolProviderId,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (workloadIdentityPoolProvider != null) {
      $result.workloadIdentityPoolProvider = workloadIdentityPoolProvider;
    }
    if (workloadIdentityPoolProviderId != null) {
      $result.workloadIdentityPoolProviderId = workloadIdentityPoolProviderId;
    }
    return $result;
  }
  CreateWorkloadIdentityPoolProviderRequest._() : super();
  factory CreateWorkloadIdentityPoolProviderRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateWorkloadIdentityPoolProviderRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWorkloadIdentityPoolProviderRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<WorkloadIdentityPoolProvider>(
        2, _omitFieldNames ? '' : 'workloadIdentityPoolProvider',
        subBuilder: WorkloadIdentityPoolProvider.create)
    ..aOS(3, _omitFieldNames ? '' : 'workloadIdentityPoolProviderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateWorkloadIdentityPoolProviderRequest clone() =>
      CreateWorkloadIdentityPoolProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateWorkloadIdentityPoolProviderRequest copyWith(
          void Function(CreateWorkloadIdentityPoolProviderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateWorkloadIdentityPoolProviderRequest))
          as CreateWorkloadIdentityPoolProviderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWorkloadIdentityPoolProviderRequest create() =>
      CreateWorkloadIdentityPoolProviderRequest._();
  CreateWorkloadIdentityPoolProviderRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWorkloadIdentityPoolProviderRequest>
      createRepeated() =>
          $pb.PbList<CreateWorkloadIdentityPoolProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWorkloadIdentityPoolProviderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          CreateWorkloadIdentityPoolProviderRequest>(create);
  static CreateWorkloadIdentityPoolProviderRequest? _defaultInstance;

  /// Required. The pool to create this provider in.
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

  /// Required. The provider to create.
  @$pb.TagNumber(2)
  WorkloadIdentityPoolProvider get workloadIdentityPoolProvider => $_getN(1);
  @$pb.TagNumber(2)
  set workloadIdentityPoolProvider(WorkloadIdentityPoolProvider v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWorkloadIdentityPoolProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearWorkloadIdentityPoolProvider() => clearField(2);
  @$pb.TagNumber(2)
  WorkloadIdentityPoolProvider ensureWorkloadIdentityPoolProvider() =>
      $_ensure(1);

  /// Required. The ID for the provider, which becomes the
  /// final component of the resource name. This value must be 4-32 characters,
  /// and may contain the characters [a-z0-9-]. The prefix `gcp-` is
  /// reserved for use by Google, and may not be specified.
  @$pb.TagNumber(3)
  $core.String get workloadIdentityPoolProviderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set workloadIdentityPoolProviderId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasWorkloadIdentityPoolProviderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorkloadIdentityPoolProviderId() => clearField(3);
}

/// Request message for UpdateWorkloadIdentityPoolProvider.
class UpdateWorkloadIdentityPoolProviderRequest extends $pb.GeneratedMessage {
  factory UpdateWorkloadIdentityPoolProviderRequest({
    WorkloadIdentityPoolProvider? workloadIdentityPoolProvider,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (workloadIdentityPoolProvider != null) {
      $result.workloadIdentityPoolProvider = workloadIdentityPoolProvider;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateWorkloadIdentityPoolProviderRequest._() : super();
  factory UpdateWorkloadIdentityPoolProviderRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateWorkloadIdentityPoolProviderRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateWorkloadIdentityPoolProviderRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOM<WorkloadIdentityPoolProvider>(
        1, _omitFieldNames ? '' : 'workloadIdentityPoolProvider',
        subBuilder: WorkloadIdentityPoolProvider.create)
    ..aOM<$58.FieldMask>(2, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateWorkloadIdentityPoolProviderRequest clone() =>
      UpdateWorkloadIdentityPoolProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateWorkloadIdentityPoolProviderRequest copyWith(
          void Function(UpdateWorkloadIdentityPoolProviderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateWorkloadIdentityPoolProviderRequest))
          as UpdateWorkloadIdentityPoolProviderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateWorkloadIdentityPoolProviderRequest create() =>
      UpdateWorkloadIdentityPoolProviderRequest._();
  UpdateWorkloadIdentityPoolProviderRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateWorkloadIdentityPoolProviderRequest>
      createRepeated() =>
          $pb.PbList<UpdateWorkloadIdentityPoolProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateWorkloadIdentityPoolProviderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateWorkloadIdentityPoolProviderRequest>(create);
  static UpdateWorkloadIdentityPoolProviderRequest? _defaultInstance;

  /// Required. The provider to update.
  @$pb.TagNumber(1)
  WorkloadIdentityPoolProvider get workloadIdentityPoolProvider => $_getN(0);
  @$pb.TagNumber(1)
  set workloadIdentityPoolProvider(WorkloadIdentityPoolProvider v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWorkloadIdentityPoolProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkloadIdentityPoolProvider() => clearField(1);
  @$pb.TagNumber(1)
  WorkloadIdentityPoolProvider ensureWorkloadIdentityPoolProvider() =>
      $_ensure(0);

  /// Required. The list of fields to update.
  @$pb.TagNumber(2)
  $58.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($58.FieldMask v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $58.FieldMask ensureUpdateMask() => $_ensure(1);
}

/// Request message for DeleteWorkloadIdentityPoolProvider.
class DeleteWorkloadIdentityPoolProviderRequest extends $pb.GeneratedMessage {
  factory DeleteWorkloadIdentityPoolProviderRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteWorkloadIdentityPoolProviderRequest._() : super();
  factory DeleteWorkloadIdentityPoolProviderRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteWorkloadIdentityPoolProviderRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteWorkloadIdentityPoolProviderRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteWorkloadIdentityPoolProviderRequest clone() =>
      DeleteWorkloadIdentityPoolProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteWorkloadIdentityPoolProviderRequest copyWith(
          void Function(DeleteWorkloadIdentityPoolProviderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeleteWorkloadIdentityPoolProviderRequest))
          as DeleteWorkloadIdentityPoolProviderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWorkloadIdentityPoolProviderRequest create() =>
      DeleteWorkloadIdentityPoolProviderRequest._();
  DeleteWorkloadIdentityPoolProviderRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteWorkloadIdentityPoolProviderRequest>
      createRepeated() =>
          $pb.PbList<DeleteWorkloadIdentityPoolProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteWorkloadIdentityPoolProviderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          DeleteWorkloadIdentityPoolProviderRequest>(create);
  static DeleteWorkloadIdentityPoolProviderRequest? _defaultInstance;

  /// Required. The name of the provider to delete.
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

/// Request message for UndeleteWorkloadIdentityPoolProvider.
class UndeleteWorkloadIdentityPoolProviderRequest extends $pb.GeneratedMessage {
  factory UndeleteWorkloadIdentityPoolProviderRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  UndeleteWorkloadIdentityPoolProviderRequest._() : super();
  factory UndeleteWorkloadIdentityPoolProviderRequest.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteWorkloadIdentityPoolProviderRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteWorkloadIdentityPoolProviderRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteWorkloadIdentityPoolProviderRequest clone() =>
      UndeleteWorkloadIdentityPoolProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteWorkloadIdentityPoolProviderRequest copyWith(
          void Function(UndeleteWorkloadIdentityPoolProviderRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UndeleteWorkloadIdentityPoolProviderRequest))
          as UndeleteWorkloadIdentityPoolProviderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteWorkloadIdentityPoolProviderRequest create() =>
      UndeleteWorkloadIdentityPoolProviderRequest._();
  UndeleteWorkloadIdentityPoolProviderRequest createEmptyInstance() => create();
  static $pb.PbList<UndeleteWorkloadIdentityPoolProviderRequest>
      createRepeated() =>
          $pb.PbList<UndeleteWorkloadIdentityPoolProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static UndeleteWorkloadIdentityPoolProviderRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UndeleteWorkloadIdentityPoolProviderRequest>(create);
  static UndeleteWorkloadIdentityPoolProviderRequest? _defaultInstance;

  /// Required. The name of the provider to undelete.
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

/// Metadata for long-running WorkloadIdentityPool operations.
class WorkloadIdentityPoolOperationMetadata extends $pb.GeneratedMessage {
  factory WorkloadIdentityPoolOperationMetadata() => create();
  WorkloadIdentityPoolOperationMetadata._() : super();
  factory WorkloadIdentityPoolOperationMetadata.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPoolOperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPoolOperationMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolOperationMetadata clone() =>
      WorkloadIdentityPoolOperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolOperationMetadata copyWith(
          void Function(WorkloadIdentityPoolOperationMetadata) updates) =>
      super.copyWith((message) =>
              updates(message as WorkloadIdentityPoolOperationMetadata))
          as WorkloadIdentityPoolOperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolOperationMetadata create() =>
      WorkloadIdentityPoolOperationMetadata._();
  WorkloadIdentityPoolOperationMetadata createEmptyInstance() => create();
  static $pb.PbList<WorkloadIdentityPoolOperationMetadata> createRepeated() =>
      $pb.PbList<WorkloadIdentityPoolOperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolOperationMetadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          WorkloadIdentityPoolOperationMetadata>(create);
  static WorkloadIdentityPoolOperationMetadata? _defaultInstance;
}

/// Metadata for long-running WorkloadIdentityPoolProvider operations.
class WorkloadIdentityPoolProviderOperationMetadata
    extends $pb.GeneratedMessage {
  factory WorkloadIdentityPoolProviderOperationMetadata() => create();
  WorkloadIdentityPoolProviderOperationMetadata._() : super();
  factory WorkloadIdentityPoolProviderOperationMetadata.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory WorkloadIdentityPoolProviderOperationMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WorkloadIdentityPoolProviderOperationMetadata',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1beta'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProviderOperationMetadata clone() =>
      WorkloadIdentityPoolProviderOperationMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  WorkloadIdentityPoolProviderOperationMetadata copyWith(
          void Function(WorkloadIdentityPoolProviderOperationMetadata)
              updates) =>
      super.copyWith((message) =>
              updates(message as WorkloadIdentityPoolProviderOperationMetadata))
          as WorkloadIdentityPoolProviderOperationMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProviderOperationMetadata create() =>
      WorkloadIdentityPoolProviderOperationMetadata._();
  WorkloadIdentityPoolProviderOperationMetadata createEmptyInstance() =>
      create();
  static $pb.PbList<WorkloadIdentityPoolProviderOperationMetadata>
      createRepeated() =>
          $pb.PbList<WorkloadIdentityPoolProviderOperationMetadata>();
  @$core.pragma('dart2js:noInline')
  static WorkloadIdentityPoolProviderOperationMetadata getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          WorkloadIdentityPoolProviderOperationMetadata>(create);
  static WorkloadIdentityPoolProviderOperationMetadata? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
