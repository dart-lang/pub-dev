//
//  Generated code. Do not modify.
//  source: google/iam/v2/deny.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../type/expr.pb.dart' as $114;

/// A deny rule in an IAM deny policy.
class DenyRule extends $pb.GeneratedMessage {
  factory DenyRule({
    $core.Iterable<$core.String>? deniedPrincipals,
    $core.Iterable<$core.String>? exceptionPrincipals,
    $core.Iterable<$core.String>? deniedPermissions,
    $core.Iterable<$core.String>? exceptionPermissions,
    $114.Expr? denialCondition,
  }) {
    final $result = create();
    if (deniedPrincipals != null) {
      $result.deniedPrincipals.addAll(deniedPrincipals);
    }
    if (exceptionPrincipals != null) {
      $result.exceptionPrincipals.addAll(exceptionPrincipals);
    }
    if (deniedPermissions != null) {
      $result.deniedPermissions.addAll(deniedPermissions);
    }
    if (exceptionPermissions != null) {
      $result.exceptionPermissions.addAll(exceptionPermissions);
    }
    if (denialCondition != null) {
      $result.denialCondition = denialCondition;
    }
    return $result;
  }
  DenyRule._() : super();
  factory DenyRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DenyRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DenyRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'deniedPrincipals')
    ..pPS(2, _omitFieldNames ? '' : 'exceptionPrincipals')
    ..pPS(3, _omitFieldNames ? '' : 'deniedPermissions')
    ..pPS(4, _omitFieldNames ? '' : 'exceptionPermissions')
    ..aOM<$114.Expr>(5, _omitFieldNames ? '' : 'denialCondition',
        subBuilder: $114.Expr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DenyRule clone() => DenyRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DenyRule copyWith(void Function(DenyRule) updates) =>
      super.copyWith((message) => updates(message as DenyRule)) as DenyRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DenyRule create() => DenyRule._();
  DenyRule createEmptyInstance() => create();
  static $pb.PbList<DenyRule> createRepeated() => $pb.PbList<DenyRule>();
  @$core.pragma('dart2js:noInline')
  static DenyRule getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DenyRule>(create);
  static DenyRule? _defaultInstance;

  ///  The identities that are prevented from using one or more permissions on
  ///  Google Cloud resources. This field can contain the following values:
  ///
  ///  * `principalSet://goog/public:all`: A special identifier that represents
  ///    any principal that is on the internet, even if they do not have a Google
  ///    Account or are not logged in.
  ///
  ///  * `principal://goog/subject/{email_id}`: A specific Google Account.
  ///    Includes Gmail, Cloud Identity, and Google Workspace user accounts. For
  ///    example, `principal://goog/subject/alice@example.com`.
  ///
  ///  * `deleted:principal://goog/subject/{email_id}?uid={uid}`: A specific
  ///    Google Account that was deleted recently. For example,
  ///    `deleted:principal://goog/subject/alice@example.com?uid=1234567890`. If
  ///    the Google Account is recovered, this identifier reverts to the standard
  ///    identifier for a Google Account.
  ///
  ///  * `principalSet://goog/group/{group_id}`: A Google group. For example,
  ///    `principalSet://goog/group/admins@example.com`.
  ///
  ///  * `deleted:principalSet://goog/group/{group_id}?uid={uid}`: A Google group
  ///    that was deleted recently. For example,
  ///    `deleted:principalSet://goog/group/admins@example.com?uid=1234567890`. If
  ///    the Google group is restored, this identifier reverts to the standard
  ///    identifier for a Google group.
  ///
  ///  * `principal://iam.googleapis.com/projects/-/serviceAccounts/{service_account_id}`:
  ///    A Google Cloud service account. For example,
  ///    `principal://iam.googleapis.com/projects/-/serviceAccounts/my-service-account@iam.gserviceaccount.com`.
  ///
  ///  * `deleted:principal://iam.googleapis.com/projects/-/serviceAccounts/{service_account_id}?uid={uid}`:
  ///    A Google Cloud service account that was deleted recently. For example,
  ///    `deleted:principal://iam.googleapis.com/projects/-/serviceAccounts/my-service-account@iam.gserviceaccount.com?uid=1234567890`.
  ///    If the service account is undeleted, this identifier reverts to the
  ///    standard identifier for a service account.
  ///
  ///  * `principalSet://goog/cloudIdentityCustomerId/{customer_id}`: All of the
  ///    principals associated with the specified Google Workspace or Cloud
  ///    Identity customer ID. For example,
  ///    `principalSet://goog/cloudIdentityCustomerId/C01Abc35`.
  @$pb.TagNumber(1)
  $core.List<$core.String> get deniedPrincipals => $_getList(0);

  ///  The identities that are excluded from the deny rule, even if they are
  ///  listed in the `denied_principals`. For example, you could add a Google
  ///  group to the `denied_principals`, then exclude specific users who belong to
  ///  that group.
  ///
  ///  This field can contain the same values as the `denied_principals` field,
  ///  excluding `principalSet://goog/public:all`, which represents all users on
  ///  the internet.
  @$pb.TagNumber(2)
  $core.List<$core.String> get exceptionPrincipals => $_getList(1);

  /// The permissions that are explicitly denied by this rule. Each permission
  /// uses the format `{service_fqdn}/{resource}.{verb}`, where `{service_fqdn}`
  /// is the fully qualified domain name for the service. For example,
  /// `iam.googleapis.com/roles.list`.
  @$pb.TagNumber(3)
  $core.List<$core.String> get deniedPermissions => $_getList(2);

  ///  Specifies the permissions that this rule excludes from the set of denied
  ///  permissions given by `denied_permissions`. If a permission appears in
  ///  `denied_permissions` _and_ in `exception_permissions` then it will _not_ be
  ///  denied.
  ///
  ///  The excluded permissions can be specified using the same syntax as
  ///  `denied_permissions`.
  @$pb.TagNumber(4)
  $core.List<$core.String> get exceptionPermissions => $_getList(3);

  ///  The condition that determines whether this deny rule applies to a request.
  ///  If the condition expression evaluates to `true`, then the deny rule is
  ///  applied; otherwise, the deny rule is not applied.
  ///
  ///  Each deny rule is evaluated independently. If this deny rule does not apply
  ///  to a request, other deny rules might still apply.
  ///
  ///  The condition can use CEL functions that evaluate
  ///  [resource
  ///  tags](https://cloud.google.com/iam/help/conditions/resource-tags). Other
  ///  functions and operators are not supported.
  @$pb.TagNumber(5)
  $114.Expr get denialCondition => $_getN(4);
  @$pb.TagNumber(5)
  set denialCondition($114.Expr v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasDenialCondition() => $_has(4);
  @$pb.TagNumber(5)
  void clearDenialCondition() => clearField(5);
  @$pb.TagNumber(5)
  $114.Expr ensureDenialCondition() => $_ensure(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
