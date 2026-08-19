//
//  Generated code. Do not modify.
//  source: google/api/context.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  `Context` defines which contexts an API requests.
///
///  Example:
///
///      context:
///        rules:
///        - selector: "*"
///          requested:
///          - google.rpc.context.ProjectContext
///          - google.rpc.context.OriginContext
///
///  The above specifies that all methods in the API request
///  `google.rpc.context.ProjectContext` and
///  `google.rpc.context.OriginContext`.
///
///  Available context types are defined in package
///  `google.rpc.context`.
///
///  This also provides mechanism to allowlist any protobuf message extension that
///  can be sent in grpc metadata using “x-goog-ext-<extension_id>-bin” and
///  “x-goog-ext-<extension_id>-jspb” format. For example, list any service
///  specific protobuf types that can appear in grpc metadata as follows in your
///  yaml file:
///
///  Example:
///
///      context:
///        rules:
///         - selector: "google.example.library.v1.LibraryService.CreateBook"
///           allowed_request_extensions:
///           - google.foo.v1.NewExtension
///           allowed_response_extensions:
///           - google.foo.v1.NewExtension
///
///  You can also specify extension ID instead of fully qualified extension name
///  here.
class Context extends $pb.GeneratedMessage {
  factory Context({
    $core.Iterable<ContextRule>? rules,
  }) {
    final $result = create();
    if (rules != null) {
      $result.rules.addAll(rules);
    }
    return $result;
  }
  Context._() : super();
  factory Context.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Context.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Context',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<ContextRule>(1, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: ContextRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Context clone() => Context()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Context copyWith(void Function(Context) updates) =>
      super.copyWith((message) => updates(message as Context)) as Context;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Context create() => Context._();
  Context createEmptyInstance() => create();
  static $pb.PbList<Context> createRepeated() => $pb.PbList<Context>();
  @$core.pragma('dart2js:noInline')
  static Context getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Context>(create);
  static Context? _defaultInstance;

  ///  A list of RPC context rules that apply to individual API methods.
  ///
  ///  **NOTE:** All service configuration rules follow "last one wins" order.
  @$pb.TagNumber(1)
  $core.List<ContextRule> get rules => $_getList(0);
}

/// A context rule provides information about the context for an individual API
/// element.
class ContextRule extends $pb.GeneratedMessage {
  factory ContextRule({
    $core.String? selector,
    $core.Iterable<$core.String>? requested,
    $core.Iterable<$core.String>? provided,
    $core.Iterable<$core.String>? allowedRequestExtensions,
    $core.Iterable<$core.String>? allowedResponseExtensions,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (requested != null) {
      $result.requested.addAll(requested);
    }
    if (provided != null) {
      $result.provided.addAll(provided);
    }
    if (allowedRequestExtensions != null) {
      $result.allowedRequestExtensions.addAll(allowedRequestExtensions);
    }
    if (allowedResponseExtensions != null) {
      $result.allowedResponseExtensions.addAll(allowedResponseExtensions);
    }
    return $result;
  }
  ContextRule._() : super();
  factory ContextRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ContextRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContextRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..pPS(2, _omitFieldNames ? '' : 'requested')
    ..pPS(3, _omitFieldNames ? '' : 'provided')
    ..pPS(4, _omitFieldNames ? '' : 'allowedRequestExtensions')
    ..pPS(5, _omitFieldNames ? '' : 'allowedResponseExtensions')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ContextRule clone() => ContextRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ContextRule copyWith(void Function(ContextRule) updates) =>
      super.copyWith((message) => updates(message as ContextRule))
          as ContextRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContextRule create() => ContextRule._();
  ContextRule createEmptyInstance() => create();
  static $pb.PbList<ContextRule> createRepeated() => $pb.PbList<ContextRule>();
  @$core.pragma('dart2js:noInline')
  static ContextRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContextRule>(create);
  static ContextRule? _defaultInstance;

  ///  Selects the methods to which this rule applies.
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
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

  /// A list of full type names of requested contexts, only the requested context
  /// will be made available to the backend.
  @$pb.TagNumber(2)
  $core.List<$core.String> get requested => $_getList(1);

  /// A list of full type names of provided contexts. It is used to support
  /// propagating HTTP headers and ETags from the response extension.
  @$pb.TagNumber(3)
  $core.List<$core.String> get provided => $_getList(2);

  /// A list of full type names or extension IDs of extensions allowed in grpc
  /// side channel from client to backend.
  @$pb.TagNumber(4)
  $core.List<$core.String> get allowedRequestExtensions => $_getList(3);

  /// A list of full type names or extension IDs of extensions allowed in grpc
  /// side channel from backend to client.
  @$pb.TagNumber(5)
  $core.List<$core.String> get allowedResponseExtensions => $_getList(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
