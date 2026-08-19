//
//  Generated code. Do not modify.
//  source: google/api/policy.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  Google API Policy Annotation
///
///  This message defines a simple API policy annotation that can be used to
///  annotate API request and response message fields with applicable policies.
///  One field may have multiple applicable policies that must all be satisfied
///  before a request can be processed. This policy annotation is used to
///  generate the overall policy that will be used for automatic runtime
///  policy enforcement and documentation generation.
class FieldPolicy extends $pb.GeneratedMessage {
  factory FieldPolicy({
    $core.String? selector,
    $core.String? resourcePermission,
    $core.String? resourceType,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (resourcePermission != null) {
      $result.resourcePermission = resourcePermission;
    }
    if (resourceType != null) {
      $result.resourceType = resourceType;
    }
    return $result;
  }
  FieldPolicy._() : super();
  factory FieldPolicy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory FieldPolicy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FieldPolicy',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..aOS(2, _omitFieldNames ? '' : 'resourcePermission')
    ..aOS(3, _omitFieldNames ? '' : 'resourceType')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  FieldPolicy clone() => FieldPolicy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  FieldPolicy copyWith(void Function(FieldPolicy) updates) =>
      super.copyWith((message) => updates(message as FieldPolicy))
          as FieldPolicy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FieldPolicy create() => FieldPolicy._();
  FieldPolicy createEmptyInstance() => create();
  static $pb.PbList<FieldPolicy> createRepeated() => $pb.PbList<FieldPolicy>();
  @$core.pragma('dart2js:noInline')
  static FieldPolicy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FieldPolicy>(create);
  static FieldPolicy? _defaultInstance;

  ///  Selects one or more request or response message fields to apply this
  ///  `FieldPolicy`.
  ///
  ///  When a `FieldPolicy` is used in proto annotation, the selector must
  ///  be left as empty. The service config generator will automatically fill
  ///  the correct value.
  ///
  ///  When a `FieldPolicy` is used in service config, the selector must be a
  ///  comma-separated string with valid request or response field paths,
  ///  such as "foo.bar" or "foo.bar,foo.baz".
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  /// Specifies the required permission(s) for the resource referred to by the
  /// field. It requires the field contains a valid resource reference, and
  /// the request must pass the permission checks to proceed. For example,
  /// "resourcemanager.projects.get".
  @$pb.TagNumber(2)
  $core.String get resourcePermission => $_getSZ(1);
  @$pb.TagNumber(2)
  set resourcePermission($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasResourcePermission() => $_has(1);
  @$pb.TagNumber(2)
  void clearResourcePermission() => clearField(2);

  /// Specifies the resource type for the resource referred to by the field.
  @$pb.TagNumber(3)
  $core.String get resourceType => $_getSZ(2);
  @$pb.TagNumber(3)
  set resourceType($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasResourceType() => $_has(2);
  @$pb.TagNumber(3)
  void clearResourceType() => clearField(3);
}

/// Defines policies applying to an RPC method.
class MethodPolicy extends $pb.GeneratedMessage {
  factory MethodPolicy({
    $core.Iterable<FieldPolicy>? requestPolicies,
    $core.String? selector,
  }) {
    final $result = create();
    if (requestPolicies != null) {
      $result.requestPolicies.addAll(requestPolicies);
    }
    if (selector != null) {
      $result.selector = selector;
    }
    return $result;
  }
  MethodPolicy._() : super();
  factory MethodPolicy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory MethodPolicy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MethodPolicy',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<FieldPolicy>(
        2, _omitFieldNames ? '' : 'requestPolicies', $pb.PbFieldType.PM,
        subBuilder: FieldPolicy.create)
    ..aOS(9, _omitFieldNames ? '' : 'selector')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  MethodPolicy clone() => MethodPolicy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  MethodPolicy copyWith(void Function(MethodPolicy) updates) =>
      super.copyWith((message) => updates(message as MethodPolicy))
          as MethodPolicy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MethodPolicy create() => MethodPolicy._();
  MethodPolicy createEmptyInstance() => create();
  static $pb.PbList<MethodPolicy> createRepeated() =>
      $pb.PbList<MethodPolicy>();
  @$core.pragma('dart2js:noInline')
  static MethodPolicy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MethodPolicy>(create);
  static MethodPolicy? _defaultInstance;

  /// Policies that are applicable to the request message.
  @$pb.TagNumber(2)
  $core.List<FieldPolicy> get requestPolicies => $_getList(0);

  ///  Selects a method to which these policies should be enforced, for example,
  ///  "google.pubsub.v1.Subscriber.CreateSubscription".
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
  ///
  ///  NOTE: This field must not be set in the proto annotation. It will be
  ///  automatically filled by the service config compiler .
  @$pb.TagNumber(9)
  $core.String get selector => $_getSZ(1);
  @$pb.TagNumber(9)
  set selector($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasSelector() => $_has(1);
  @$pb.TagNumber(9)
  void clearSelector() => clearField(9);
}

class Policy {
  static final fieldPolicy = $pb.Extension<FieldPolicy>(
      _omitMessageNames ? '' : 'google.protobuf.FieldOptions',
      _omitFieldNames ? '' : 'fieldPolicy',
      158361448,
      $pb.PbFieldType.OM,
      defaultOrMaker: FieldPolicy.getDefault,
      subBuilder: FieldPolicy.create);
  static final methodPolicy = $pb.Extension<MethodPolicy>(
      _omitMessageNames ? '' : 'google.protobuf.MethodOptions',
      _omitFieldNames ? '' : 'methodPolicy',
      161893301,
      $pb.PbFieldType.OM,
      defaultOrMaker: MethodPolicy.getDefault,
      subBuilder: MethodPolicy.create);
  static void registerAllExtensions($pb.ExtensionRegistry registry) {
    registry.add(fieldPolicy);
    registry.add(methodPolicy);
  }
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
