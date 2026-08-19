//
//  Generated code. Do not modify.
//  source: google/rpc/context/audit_context.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/struct.pb.dart' as $48;

/// `AuditContext` provides information that is needed for audit logging.
class AuditContext extends $pb.GeneratedMessage {
  factory AuditContext({
    $core.List<$core.int>? auditLog,
    $48.Struct? scrubbedRequest,
    $48.Struct? scrubbedResponse,
    $core.int? scrubbedResponseItemCount,
    $core.String? targetResource,
  }) {
    final $result = create();
    if (auditLog != null) {
      $result.auditLog = auditLog;
    }
    if (scrubbedRequest != null) {
      $result.scrubbedRequest = scrubbedRequest;
    }
    if (scrubbedResponse != null) {
      $result.scrubbedResponse = scrubbedResponse;
    }
    if (scrubbedResponseItemCount != null) {
      $result.scrubbedResponseItemCount = scrubbedResponseItemCount;
    }
    if (targetResource != null) {
      $result.targetResource = targetResource;
    }
    return $result;
  }
  AuditContext._() : super();
  factory AuditContext.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditContext.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditContext',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.rpc.context'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'auditLog', $pb.PbFieldType.OY)
    ..aOM<$48.Struct>(2, _omitFieldNames ? '' : 'scrubbedRequest',
        subBuilder: $48.Struct.create)
    ..aOM<$48.Struct>(3, _omitFieldNames ? '' : 'scrubbedResponse',
        subBuilder: $48.Struct.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'scrubbedResponseItemCount',
        $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'targetResource')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditContext clone() => AuditContext()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditContext copyWith(void Function(AuditContext) updates) =>
      super.copyWith((message) => updates(message as AuditContext))
          as AuditContext;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditContext create() => AuditContext._();
  AuditContext createEmptyInstance() => create();
  static $pb.PbList<AuditContext> createRepeated() =>
      $pb.PbList<AuditContext>();
  @$core.pragma('dart2js:noInline')
  static AuditContext getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuditContext>(create);
  static AuditContext? _defaultInstance;

  /// Serialized audit log.
  @$pb.TagNumber(1)
  $core.List<$core.int> get auditLog => $_getN(0);
  @$pb.TagNumber(1)
  set auditLog($core.List<$core.int> v) {
    $_setBytes(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAuditLog() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuditLog() => clearField(1);

  /// An API request message that is scrubbed based on the method annotation.
  /// This field should only be filled if audit_log field is present.
  /// Service Control will use this to assemble a complete log for Cloud Audit
  /// Logs and Google internal audit logs.
  @$pb.TagNumber(2)
  $48.Struct get scrubbedRequest => $_getN(1);
  @$pb.TagNumber(2)
  set scrubbedRequest($48.Struct v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasScrubbedRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearScrubbedRequest() => clearField(2);
  @$pb.TagNumber(2)
  $48.Struct ensureScrubbedRequest() => $_ensure(1);

  /// An API response message that is scrubbed based on the method annotation.
  /// This field should only be filled if audit_log field is present.
  /// Service Control will use this to assemble a complete log for Cloud Audit
  /// Logs and Google internal audit logs.
  @$pb.TagNumber(3)
  $48.Struct get scrubbedResponse => $_getN(2);
  @$pb.TagNumber(3)
  set scrubbedResponse($48.Struct v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasScrubbedResponse() => $_has(2);
  @$pb.TagNumber(3)
  void clearScrubbedResponse() => clearField(3);
  @$pb.TagNumber(3)
  $48.Struct ensureScrubbedResponse() => $_ensure(2);

  /// Number of scrubbed response items.
  @$pb.TagNumber(4)
  $core.int get scrubbedResponseItemCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set scrubbedResponseItemCount($core.int v) {
    $_setSignedInt32(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasScrubbedResponseItemCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearScrubbedResponseItemCount() => clearField(4);

  /// Audit resource name which is scrubbed.
  @$pb.TagNumber(5)
  $core.String get targetResource => $_getSZ(4);
  @$pb.TagNumber(5)
  set targetResource($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTargetResource() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetResource() => clearField(5);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
