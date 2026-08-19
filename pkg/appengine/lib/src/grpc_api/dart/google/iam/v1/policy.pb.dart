//
//  Generated code. Do not modify.
//  source: google/iam/v1/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../type/expr.pb.dart' as $114;
import 'policy.pbenum.dart';

export 'policy.pbenum.dart';

///  An Identity and Access Management (IAM) policy, which specifies access
///  controls for Google Cloud resources.
///
///
///  A `Policy` is a collection of `bindings`. A `binding` binds one or more
///  `members`, or principals, to a single `role`. Principals can be user
///  accounts, service accounts, Google groups, and domains (such as G Suite). A
///  `role` is a named list of permissions; each `role` can be an IAM predefined
///  role or a user-created custom role.
///
///  For some types of Google Cloud resources, a `binding` can also specify a
///  `condition`, which is a logical expression that allows access to a resource
///  only if the expression evaluates to `true`. A condition can add constraints
///  based on attributes of the request, the resource, or both. To learn which
///  resources support conditions in their IAM policies, see the
///  [IAM
///  documentation](https://cloud.google.com/iam/help/conditions/resource-policies).
///
///  **JSON example:**
///
///  ```
///      {
///        "bindings": [
///          {
///            "role": "roles/resourcemanager.organizationAdmin",
///            "members": [
///              "user:mike@example.com",
///              "group:admins@example.com",
///              "domain:google.com",
///              "serviceAccount:my-project-id@appspot.gserviceaccount.com"
///            ]
///          },
///          {
///            "role": "roles/resourcemanager.organizationViewer",
///            "members": [
///              "user:eve@example.com"
///            ],
///            "condition": {
///              "title": "expirable access",
///              "description": "Does not grant access after Sep 2020",
///              "expression": "request.time <
///              timestamp('2020-10-01T00:00:00.000Z')",
///            }
///          }
///        ],
///        "etag": "BwWWja0YfJA=",
///        "version": 3
///      }
///  ```
///
///  **YAML example:**
///
///  ```
///      bindings:
///      - members:
///        - user:mike@example.com
///        - group:admins@example.com
///        - domain:google.com
///        - serviceAccount:my-project-id@appspot.gserviceaccount.com
///        role: roles/resourcemanager.organizationAdmin
///      - members:
///        - user:eve@example.com
///        role: roles/resourcemanager.organizationViewer
///        condition:
///          title: expirable access
///          description: Does not grant access after Sep 2020
///          expression: request.time < timestamp('2020-10-01T00:00:00.000Z')
///      etag: BwWWja0YfJA=
///      version: 3
///  ```
///
///  For a description of IAM and its features, see the
///  [IAM documentation](https://cloud.google.com/iam/docs/).
class Policy extends $pb.GeneratedMessage {
  factory Policy({
    $core.int? version,
    $core.List<$core.int>? etag,
    $core.Iterable<Binding>? bindings,
    $core.Iterable<AuditConfig>? auditConfigs,
  }) {
    final $result = create();
    if (version != null) {
      $result.version = version;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (bindings != null) {
      $result.bindings.addAll(bindings);
    }
    if (auditConfigs != null) {
      $result.auditConfigs.addAll(auditConfigs);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'etag', $pb.PbFieldType.OY)
    ..pc<Binding>(4, _omitFieldNames ? '' : 'bindings', $pb.PbFieldType.PM,
        subBuilder: Binding.create)
    ..pc<AuditConfig>(
        6, _omitFieldNames ? '' : 'auditConfigs', $pb.PbFieldType.PM,
        subBuilder: AuditConfig.create)
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

  ///  Specifies the format of the policy.
  ///
  ///  Valid values are `0`, `1`, and `3`. Requests that specify an invalid value
  ///  are rejected.
  ///
  ///  Any operation that affects conditional role bindings must specify version
  ///  `3`. This requirement applies to the following operations:
  ///
  ///  * Getting a policy that includes a conditional role binding
  ///  * Adding a conditional role binding to a policy
  ///  * Changing a conditional role binding in a policy
  ///  * Removing any role binding, with or without a condition, from a policy
  ///    that includes conditions
  ///
  ///  **Important:** If you use IAM Conditions, you must include the `etag` field
  ///  whenever you call `setIamPolicy`. If you omit this field, then IAM allows
  ///  you to overwrite a version `3` policy with a version `1` policy, and all of
  ///  the conditions in the version `3` policy are lost.
  ///
  ///  If a policy does not include any conditions, operations on that policy may
  ///  specify any valid version or leave the field unset.
  ///
  ///  To learn which resources support conditions in their IAM policies, see the
  ///  [IAM
  ///  documentation](https://cloud.google.com/iam/help/conditions/resource-policies).
  @$pb.TagNumber(1)
  $core.int get version => $_getIZ(0);
  @$pb.TagNumber(1)
  set version($core.int v) {
    $_setSignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => clearField(1);

  ///  `etag` is used for optimistic concurrency control as a way to help
  ///  prevent simultaneous updates of a policy from overwriting each other.
  ///  It is strongly suggested that systems make use of the `etag` in the
  ///  read-modify-write cycle to perform policy updates in order to avoid race
  ///  conditions: An `etag` is returned in the response to `getIamPolicy`, and
  ///  systems are expected to put that etag in the request to `setIamPolicy` to
  ///  ensure that their change will be applied to the same version of the policy.
  ///
  ///  **Important:** If you use IAM Conditions, you must include the `etag` field
  ///  whenever you call `setIamPolicy`. If you omit this field, then IAM allows
  ///  you to overwrite a version `3` policy with a version `1` policy, and all of
  ///  the conditions in the version `3` policy are lost.
  @$pb.TagNumber(3)
  $core.List<$core.int> get etag => $_getN(1);
  @$pb.TagNumber(3)
  set etag($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(3)
  void clearEtag() => clearField(3);

  ///  Associates a list of `members`, or principals, with a `role`. Optionally,
  ///  may specify a `condition` that determines how and when the `bindings` are
  ///  applied. Each of the `bindings` must contain at least one principal.
  ///
  ///  The `bindings` in a `Policy` can refer to up to 1,500 principals; up to 250
  ///  of these principals can be Google groups. Each occurrence of a principal
  ///  counts towards these limits. For example, if the `bindings` grant 50
  ///  different roles to `user:alice@example.com`, and not to any other
  ///  principal, then you can add another 1,450 principals to the `bindings` in
  ///  the `Policy`.
  @$pb.TagNumber(4)
  $core.List<Binding> get bindings => $_getList(2);

  /// Specifies cloud audit logging configuration for this policy.
  @$pb.TagNumber(6)
  $core.List<AuditConfig> get auditConfigs => $_getList(3);
}

/// Associates `members`, or principals, with a `role`.
class Binding extends $pb.GeneratedMessage {
  factory Binding({
    $core.String? role,
    $core.Iterable<$core.String>? members,
    $114.Expr? condition,
  }) {
    final $result = create();
    if (role != null) {
      $result.role = role;
    }
    if (members != null) {
      $result.members.addAll(members);
    }
    if (condition != null) {
      $result.condition = condition;
    }
    return $result;
  }
  Binding._() : super();
  factory Binding.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Binding.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Binding',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'role')
    ..pPS(2, _omitFieldNames ? '' : 'members')
    ..aOM<$114.Expr>(3, _omitFieldNames ? '' : 'condition',
        subBuilder: $114.Expr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Binding clone() => Binding()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Binding copyWith(void Function(Binding) updates) =>
      super.copyWith((message) => updates(message as Binding)) as Binding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Binding create() => Binding._();
  Binding createEmptyInstance() => create();
  static $pb.PbList<Binding> createRepeated() => $pb.PbList<Binding>();
  @$core.pragma('dart2js:noInline')
  static Binding getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Binding>(create);
  static Binding? _defaultInstance;

  /// Role that is assigned to the list of `members`, or principals.
  /// For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
  @$pb.TagNumber(1)
  $core.String get role => $_getSZ(0);
  @$pb.TagNumber(1)
  set role($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRole() => $_has(0);
  @$pb.TagNumber(1)
  void clearRole() => clearField(1);

  ///  Specifies the principals requesting access for a Google Cloud resource.
  ///  `members` can have the following values:
  ///
  ///  * `allUsers`: A special identifier that represents anyone who is
  ///     on the internet; with or without a Google account.
  ///
  ///  * `allAuthenticatedUsers`: A special identifier that represents anyone
  ///     who is authenticated with a Google account or a service account.
  ///
  ///  * `user:{emailid}`: An email address that represents a specific Google
  ///     account. For example, `alice@example.com` .
  ///
  ///
  ///  * `serviceAccount:{emailid}`: An email address that represents a service
  ///     account. For example, `my-other-app@appspot.gserviceaccount.com`.
  ///
  ///  * `group:{emailid}`: An email address that represents a Google group.
  ///     For example, `admins@example.com`.
  ///
  ///  * `deleted:user:{emailid}?uid={uniqueid}`: An email address (plus unique
  ///     identifier) representing a user that has been recently deleted. For
  ///     example, `alice@example.com?uid=123456789012345678901`. If the user is
  ///     recovered, this value reverts to `user:{emailid}` and the recovered user
  ///     retains the role in the binding.
  ///
  ///  * `deleted:serviceAccount:{emailid}?uid={uniqueid}`: An email address (plus
  ///     unique identifier) representing a service account that has been recently
  ///     deleted. For example,
  ///     `my-other-app@appspot.gserviceaccount.com?uid=123456789012345678901`.
  ///     If the service account is undeleted, this value reverts to
  ///     `serviceAccount:{emailid}` and the undeleted service account retains the
  ///     role in the binding.
  ///
  ///  * `deleted:group:{emailid}?uid={uniqueid}`: An email address (plus unique
  ///     identifier) representing a Google group that has been recently
  ///     deleted. For example, `admins@example.com?uid=123456789012345678901`. If
  ///     the group is recovered, this value reverts to `group:{emailid}` and the
  ///     recovered group retains the role in the binding.
  ///
  ///
  ///  * `domain:{domain}`: The G Suite domain (primary) that represents all the
  ///     users of that domain. For example, `google.com` or `example.com`.
  @$pb.TagNumber(2)
  $core.List<$core.String> get members => $_getList(1);

  ///  The condition that is associated with this binding.
  ///
  ///  If the condition evaluates to `true`, then this binding applies to the
  ///  current request.
  ///
  ///  If the condition evaluates to `false`, then this binding does not apply to
  ///  the current request. However, a different role binding might grant the same
  ///  role to one or more of the principals in this binding.
  ///
  ///  To learn which resources support conditions in their IAM policies, see the
  ///  [IAM
  ///  documentation](https://cloud.google.com/iam/help/conditions/resource-policies).
  @$pb.TagNumber(3)
  $114.Expr get condition => $_getN(2);
  @$pb.TagNumber(3)
  set condition($114.Expr v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCondition() => $_has(2);
  @$pb.TagNumber(3)
  void clearCondition() => clearField(3);
  @$pb.TagNumber(3)
  $114.Expr ensureCondition() => $_ensure(2);
}

///  Specifies the audit configuration for a service.
///  The configuration determines which permission types are logged, and what
///  identities, if any, are exempted from logging.
///  An AuditConfig must have one or more AuditLogConfigs.
///
///  If there are AuditConfigs for both `allServices` and a specific service,
///  the union of the two AuditConfigs is used for that service: the log_types
///  specified in each AuditConfig are enabled, and the exempted_members in each
///  AuditLogConfig are exempted.
///
///  Example Policy with multiple AuditConfigs:
///
///      {
///        "audit_configs": [
///          {
///            "service": "allServices",
///            "audit_log_configs": [
///              {
///                "log_type": "DATA_READ",
///                "exempted_members": [
///                  "user:jose@example.com"
///                ]
///              },
///              {
///                "log_type": "DATA_WRITE"
///              },
///              {
///                "log_type": "ADMIN_READ"
///              }
///            ]
///          },
///          {
///            "service": "sampleservice.googleapis.com",
///            "audit_log_configs": [
///              {
///                "log_type": "DATA_READ"
///              },
///              {
///                "log_type": "DATA_WRITE",
///                "exempted_members": [
///                  "user:aliya@example.com"
///                ]
///              }
///            ]
///          }
///        ]
///      }
///
///  For sampleservice, this policy enables DATA_READ, DATA_WRITE and ADMIN_READ
///  logging. It also exempts `jose@example.com` from DATA_READ logging, and
///  `aliya@example.com` from DATA_WRITE logging.
class AuditConfig extends $pb.GeneratedMessage {
  factory AuditConfig({
    $core.String? service,
    $core.Iterable<AuditLogConfig>? auditLogConfigs,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    if (auditLogConfigs != null) {
      $result.auditLogConfigs.addAll(auditLogConfigs);
    }
    return $result;
  }
  AuditConfig._() : super();
  factory AuditConfig.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditConfig.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'service')
    ..pc<AuditLogConfig>(
        3, _omitFieldNames ? '' : 'auditLogConfigs', $pb.PbFieldType.PM,
        subBuilder: AuditLogConfig.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditConfig clone() => AuditConfig()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditConfig copyWith(void Function(AuditConfig) updates) =>
      super.copyWith((message) => updates(message as AuditConfig))
          as AuditConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditConfig create() => AuditConfig._();
  AuditConfig createEmptyInstance() => create();
  static $pb.PbList<AuditConfig> createRepeated() => $pb.PbList<AuditConfig>();
  @$core.pragma('dart2js:noInline')
  static AuditConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuditConfig>(create);
  static AuditConfig? _defaultInstance;

  /// Specifies a service that will be enabled for audit logging.
  /// For example, `storage.googleapis.com`, `cloudsql.googleapis.com`.
  /// `allServices` is a special value that covers all services.
  @$pb.TagNumber(1)
  $core.String get service => $_getSZ(0);
  @$pb.TagNumber(1)
  set service($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);

  /// The configuration for logging of each type of permission.
  @$pb.TagNumber(3)
  $core.List<AuditLogConfig> get auditLogConfigs => $_getList(1);
}

///  Provides the configuration for logging a type of permissions.
///  Example:
///
///      {
///        "audit_log_configs": [
///          {
///            "log_type": "DATA_READ",
///            "exempted_members": [
///              "user:jose@example.com"
///            ]
///          },
///          {
///            "log_type": "DATA_WRITE"
///          }
///        ]
///      }
///
///  This enables 'DATA_READ' and 'DATA_WRITE' logging, while exempting
///  jose@example.com from DATA_READ logging.
class AuditLogConfig extends $pb.GeneratedMessage {
  factory AuditLogConfig({
    AuditLogConfig_LogType? logType,
    $core.Iterable<$core.String>? exemptedMembers,
  }) {
    final $result = create();
    if (logType != null) {
      $result.logType = logType;
    }
    if (exemptedMembers != null) {
      $result.exemptedMembers.addAll(exemptedMembers);
    }
    return $result;
  }
  AuditLogConfig._() : super();
  factory AuditLogConfig.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditLogConfig.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditLogConfig',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..e<AuditLogConfig_LogType>(
        1, _omitFieldNames ? '' : 'logType', $pb.PbFieldType.OE,
        defaultOrMaker: AuditLogConfig_LogType.LOG_TYPE_UNSPECIFIED,
        valueOf: AuditLogConfig_LogType.valueOf,
        enumValues: AuditLogConfig_LogType.values)
    ..pPS(2, _omitFieldNames ? '' : 'exemptedMembers')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditLogConfig clone() => AuditLogConfig()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditLogConfig copyWith(void Function(AuditLogConfig) updates) =>
      super.copyWith((message) => updates(message as AuditLogConfig))
          as AuditLogConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditLogConfig create() => AuditLogConfig._();
  AuditLogConfig createEmptyInstance() => create();
  static $pb.PbList<AuditLogConfig> createRepeated() =>
      $pb.PbList<AuditLogConfig>();
  @$core.pragma('dart2js:noInline')
  static AuditLogConfig getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuditLogConfig>(create);
  static AuditLogConfig? _defaultInstance;

  /// The log type that this config enables.
  @$pb.TagNumber(1)
  AuditLogConfig_LogType get logType => $_getN(0);
  @$pb.TagNumber(1)
  set logType(AuditLogConfig_LogType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLogType() => $_has(0);
  @$pb.TagNumber(1)
  void clearLogType() => clearField(1);

  /// Specifies the identities that do not cause logging for this type of
  /// permission.
  /// Follows the same format of
  /// [Binding.members][google.iam.v1.Binding.members].
  @$pb.TagNumber(2)
  $core.List<$core.String> get exemptedMembers => $_getList(1);
}

/// The difference delta between two policies.
class PolicyDelta extends $pb.GeneratedMessage {
  factory PolicyDelta({
    $core.Iterable<BindingDelta>? bindingDeltas,
    $core.Iterable<AuditConfigDelta>? auditConfigDeltas,
  }) {
    final $result = create();
    if (bindingDeltas != null) {
      $result.bindingDeltas.addAll(bindingDeltas);
    }
    if (auditConfigDeltas != null) {
      $result.auditConfigDeltas.addAll(auditConfigDeltas);
    }
    return $result;
  }
  PolicyDelta._() : super();
  factory PolicyDelta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PolicyDelta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PolicyDelta',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..pc<BindingDelta>(
        1, _omitFieldNames ? '' : 'bindingDeltas', $pb.PbFieldType.PM,
        subBuilder: BindingDelta.create)
    ..pc<AuditConfigDelta>(
        2, _omitFieldNames ? '' : 'auditConfigDeltas', $pb.PbFieldType.PM,
        subBuilder: AuditConfigDelta.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PolicyDelta clone() => PolicyDelta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PolicyDelta copyWith(void Function(PolicyDelta) updates) =>
      super.copyWith((message) => updates(message as PolicyDelta))
          as PolicyDelta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicyDelta create() => PolicyDelta._();
  PolicyDelta createEmptyInstance() => create();
  static $pb.PbList<PolicyDelta> createRepeated() => $pb.PbList<PolicyDelta>();
  @$core.pragma('dart2js:noInline')
  static PolicyDelta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PolicyDelta>(create);
  static PolicyDelta? _defaultInstance;

  /// The delta for Bindings between two policies.
  @$pb.TagNumber(1)
  $core.List<BindingDelta> get bindingDeltas => $_getList(0);

  /// The delta for AuditConfigs between two policies.
  @$pb.TagNumber(2)
  $core.List<AuditConfigDelta> get auditConfigDeltas => $_getList(1);
}

/// One delta entry for Binding. Each individual change (only one member in each
/// entry) to a binding will be a separate entry.
class BindingDelta extends $pb.GeneratedMessage {
  factory BindingDelta({
    BindingDelta_Action? action,
    $core.String? role,
    $core.String? member,
    $114.Expr? condition,
  }) {
    final $result = create();
    if (action != null) {
      $result.action = action;
    }
    if (role != null) {
      $result.role = role;
    }
    if (member != null) {
      $result.member = member;
    }
    if (condition != null) {
      $result.condition = condition;
    }
    return $result;
  }
  BindingDelta._() : super();
  factory BindingDelta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BindingDelta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BindingDelta',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..e<BindingDelta_Action>(
        1, _omitFieldNames ? '' : 'action', $pb.PbFieldType.OE,
        defaultOrMaker: BindingDelta_Action.ACTION_UNSPECIFIED,
        valueOf: BindingDelta_Action.valueOf,
        enumValues: BindingDelta_Action.values)
    ..aOS(2, _omitFieldNames ? '' : 'role')
    ..aOS(3, _omitFieldNames ? '' : 'member')
    ..aOM<$114.Expr>(4, _omitFieldNames ? '' : 'condition',
        subBuilder: $114.Expr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BindingDelta clone() => BindingDelta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BindingDelta copyWith(void Function(BindingDelta) updates) =>
      super.copyWith((message) => updates(message as BindingDelta))
          as BindingDelta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BindingDelta create() => BindingDelta._();
  BindingDelta createEmptyInstance() => create();
  static $pb.PbList<BindingDelta> createRepeated() =>
      $pb.PbList<BindingDelta>();
  @$core.pragma('dart2js:noInline')
  static BindingDelta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BindingDelta>(create);
  static BindingDelta? _defaultInstance;

  /// The action that was performed on a Binding.
  /// Required
  @$pb.TagNumber(1)
  BindingDelta_Action get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(BindingDelta_Action v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);

  /// Role that is assigned to `members`.
  /// For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
  /// Required
  @$pb.TagNumber(2)
  $core.String get role => $_getSZ(1);
  @$pb.TagNumber(2)
  set role($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => clearField(2);

  /// A single identity requesting access for a Google Cloud resource.
  /// Follows the same format of Binding.members.
  /// Required
  @$pb.TagNumber(3)
  $core.String get member => $_getSZ(2);
  @$pb.TagNumber(3)
  set member($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasMember() => $_has(2);
  @$pb.TagNumber(3)
  void clearMember() => clearField(3);

  /// The condition that is associated with this binding.
  @$pb.TagNumber(4)
  $114.Expr get condition => $_getN(3);
  @$pb.TagNumber(4)
  set condition($114.Expr v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCondition() => $_has(3);
  @$pb.TagNumber(4)
  void clearCondition() => clearField(4);
  @$pb.TagNumber(4)
  $114.Expr ensureCondition() => $_ensure(3);
}

/// One delta entry for AuditConfig. Each individual change (only one
/// exempted_member in each entry) to a AuditConfig will be a separate entry.
class AuditConfigDelta extends $pb.GeneratedMessage {
  factory AuditConfigDelta({
    AuditConfigDelta_Action? action,
    $core.String? service,
    $core.String? exemptedMember,
    $core.String? logType,
  }) {
    final $result = create();
    if (action != null) {
      $result.action = action;
    }
    if (service != null) {
      $result.service = service;
    }
    if (exemptedMember != null) {
      $result.exemptedMember = exemptedMember;
    }
    if (logType != null) {
      $result.logType = logType;
    }
    return $result;
  }
  AuditConfigDelta._() : super();
  factory AuditConfigDelta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditConfigDelta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditConfigDelta',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v1'),
      createEmptyInstance: create)
    ..e<AuditConfigDelta_Action>(
        1, _omitFieldNames ? '' : 'action', $pb.PbFieldType.OE,
        defaultOrMaker: AuditConfigDelta_Action.ACTION_UNSPECIFIED,
        valueOf: AuditConfigDelta_Action.valueOf,
        enumValues: AuditConfigDelta_Action.values)
    ..aOS(2, _omitFieldNames ? '' : 'service')
    ..aOS(3, _omitFieldNames ? '' : 'exemptedMember')
    ..aOS(4, _omitFieldNames ? '' : 'logType')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditConfigDelta clone() => AuditConfigDelta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditConfigDelta copyWith(void Function(AuditConfigDelta) updates) =>
      super.copyWith((message) => updates(message as AuditConfigDelta))
          as AuditConfigDelta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditConfigDelta create() => AuditConfigDelta._();
  AuditConfigDelta createEmptyInstance() => create();
  static $pb.PbList<AuditConfigDelta> createRepeated() =>
      $pb.PbList<AuditConfigDelta>();
  @$core.pragma('dart2js:noInline')
  static AuditConfigDelta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuditConfigDelta>(create);
  static AuditConfigDelta? _defaultInstance;

  /// The action that was performed on an audit configuration in a policy.
  /// Required
  @$pb.TagNumber(1)
  AuditConfigDelta_Action get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(AuditConfigDelta_Action v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);

  /// Specifies a service that was configured for Cloud Audit Logging.
  /// For example, `storage.googleapis.com`, `cloudsql.googleapis.com`.
  /// `allServices` is a special value that covers all services.
  /// Required
  @$pb.TagNumber(2)
  $core.String get service => $_getSZ(1);
  @$pb.TagNumber(2)
  set service($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasService() => $_has(1);
  @$pb.TagNumber(2)
  void clearService() => clearField(2);

  /// A single identity that is exempted from "data access" audit
  /// logging for the `service` specified above.
  /// Follows the same format of Binding.members.
  @$pb.TagNumber(3)
  $core.String get exemptedMember => $_getSZ(2);
  @$pb.TagNumber(3)
  set exemptedMember($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExemptedMember() => $_has(2);
  @$pb.TagNumber(3)
  void clearExemptedMember() => clearField(3);

  /// Specifies the log_type that was be enabled. ADMIN_ACTIVITY is always
  /// enabled, and cannot be configured.
  /// Required
  @$pb.TagNumber(4)
  $core.String get logType => $_getSZ(3);
  @$pb.TagNumber(4)
  set logType($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasLogType() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogType() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
