//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/audit_data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// A PermissionDelta message to record the added_permissions and
/// removed_permissions inside a role.
class AuditData_PermissionDelta extends $pb.GeneratedMessage {
  factory AuditData_PermissionDelta({
    $core.Iterable<$core.String>? addedPermissions,
    $core.Iterable<$core.String>? removedPermissions,
  }) {
    final $result = create();
    if (addedPermissions != null) {
      $result.addedPermissions.addAll(addedPermissions);
    }
    if (removedPermissions != null) {
      $result.removedPermissions.addAll(removedPermissions);
    }
    return $result;
  }
  AuditData_PermissionDelta._() : super();
  factory AuditData_PermissionDelta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuditData_PermissionDelta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditData.PermissionDelta',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'addedPermissions')
    ..pPS(2, _omitFieldNames ? '' : 'removedPermissions')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuditData_PermissionDelta clone() =>
      AuditData_PermissionDelta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuditData_PermissionDelta copyWith(
          void Function(AuditData_PermissionDelta) updates) =>
      super.copyWith((message) => updates(message as AuditData_PermissionDelta))
          as AuditData_PermissionDelta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditData_PermissionDelta create() => AuditData_PermissionDelta._();
  AuditData_PermissionDelta createEmptyInstance() => create();
  static $pb.PbList<AuditData_PermissionDelta> createRepeated() =>
      $pb.PbList<AuditData_PermissionDelta>();
  @$core.pragma('dart2js:noInline')
  static AuditData_PermissionDelta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuditData_PermissionDelta>(create);
  static AuditData_PermissionDelta? _defaultInstance;

  /// Added permissions.
  @$pb.TagNumber(1)
  $core.List<$core.String> get addedPermissions => $_getList(0);

  /// Removed permissions.
  @$pb.TagNumber(2)
  $core.List<$core.String> get removedPermissions => $_getList(1);
}

/// Audit log information specific to Cloud IAM admin APIs. This message is
/// serialized as an `Any` type in the `ServiceData` message of an
/// `AuditLog` message.
class AuditData extends $pb.GeneratedMessage {
  factory AuditData({
    AuditData_PermissionDelta? permissionDelta,
  }) {
    final $result = create();
    if (permissionDelta != null) {
      $result.permissionDelta = permissionDelta;
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
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOM<AuditData_PermissionDelta>(
        1, _omitFieldNames ? '' : 'permissionDelta',
        subBuilder: AuditData_PermissionDelta.create)
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

  /// The permission_delta when when creating or updating a Role.
  @$pb.TagNumber(1)
  AuditData_PermissionDelta get permissionDelta => $_getN(0);
  @$pb.TagNumber(1)
  set permissionDelta(AuditData_PermissionDelta v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPermissionDelta() => $_has(0);
  @$pb.TagNumber(1)
  void clearPermissionDelta() => clearField(1);
  @$pb.TagNumber(1)
  AuditData_PermissionDelta ensurePermissionDelta() => $_ensure(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
