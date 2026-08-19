//
//  Generated code. Do not modify.
//  source: google/api/servicecontrol/v1/check_error.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../rpc/status.pb.dart' as $57;
import 'check_error.pbenum.dart';

export 'check_error.pbenum.dart';

/// Defines the errors to be returned in
/// [google.api.servicecontrol.v1.CheckResponse.check_errors][google.api.servicecontrol.v1.CheckResponse.check_errors].
class CheckError extends $pb.GeneratedMessage {
  factory CheckError({
    CheckError_Code? code,
    $core.String? detail,
    $57.Status? status,
    $core.String? subject,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (detail != null) {
      $result.detail = detail;
    }
    if (status != null) {
      $result.status = status;
    }
    if (subject != null) {
      $result.subject = subject;
    }
    return $result;
  }
  CheckError._() : super();
  factory CheckError.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CheckError.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckError',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicecontrol.v1'),
      createEmptyInstance: create)
    ..e<CheckError_Code>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OE,
        defaultOrMaker: CheckError_Code.ERROR_CODE_UNSPECIFIED,
        valueOf: CheckError_Code.valueOf,
        enumValues: CheckError_Code.values)
    ..aOS(2, _omitFieldNames ? '' : 'detail')
    ..aOM<$57.Status>(3, _omitFieldNames ? '' : 'status',
        subBuilder: $57.Status.create)
    ..aOS(4, _omitFieldNames ? '' : 'subject')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CheckError clone() => CheckError()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CheckError copyWith(void Function(CheckError) updates) =>
      super.copyWith((message) => updates(message as CheckError)) as CheckError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckError create() => CheckError._();
  CheckError createEmptyInstance() => create();
  static $pb.PbList<CheckError> createRepeated() => $pb.PbList<CheckError>();
  @$core.pragma('dart2js:noInline')
  static CheckError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckError>(create);
  static CheckError? _defaultInstance;

  /// The error code.
  @$pb.TagNumber(1)
  CheckError_Code get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(CheckError_Code v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  /// Free-form text providing details on the error cause of the error.
  @$pb.TagNumber(2)
  $core.String get detail => $_getSZ(1);
  @$pb.TagNumber(2)
  set detail($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDetail() => $_has(1);
  @$pb.TagNumber(2)
  void clearDetail() => clearField(2);

  /// Contains public information about the check error. If available,
  /// `status.code` will be non zero and client can propagate it out as public
  /// error.
  @$pb.TagNumber(3)
  $57.Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status($57.Status v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
  @$pb.TagNumber(3)
  $57.Status ensureStatus() => $_ensure(2);

  ///  Subject to whom this error applies. See the specific code enum for more
  ///  details on this field. For example:
  ///
  ///  - "project:<project-id or project-number>"
  ///  - "folder:<folder-id>"
  ///  - "organization:<organization-id>"
  @$pb.TagNumber(4)
  $core.String get subject => $_getSZ(3);
  @$pb.TagNumber(4)
  set subject($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSubject() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubject() => clearField(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
