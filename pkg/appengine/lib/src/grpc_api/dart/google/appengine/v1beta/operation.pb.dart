//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/operation.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;

enum OperationMetadataV1Beta_MethodMetadata { createVersionMetadata, notSet }

/// Metadata for the given [google.longrunning.Operation][google.longrunning.Operation].
class OperationMetadataV1Beta extends $pb.GeneratedMessage {
  factory OperationMetadataV1Beta({
    $core.String? method,
    $50.Timestamp? insertTime,
    $50.Timestamp? endTime,
    $core.String? user,
    $core.String? target,
    $core.String? ephemeralMessage,
    $core.Iterable<$core.String>? warning,
    CreateVersionMetadataV1Beta? createVersionMetadata,
  }) {
    final $result = create();
    if (method != null) {
      $result.method = method;
    }
    if (insertTime != null) {
      $result.insertTime = insertTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (user != null) {
      $result.user = user;
    }
    if (target != null) {
      $result.target = target;
    }
    if (ephemeralMessage != null) {
      $result.ephemeralMessage = ephemeralMessage;
    }
    if (warning != null) {
      $result.warning.addAll(warning);
    }
    if (createVersionMetadata != null) {
      $result.createVersionMetadata = createVersionMetadata;
    }
    return $result;
  }
  OperationMetadataV1Beta._() : super();
  factory OperationMetadataV1Beta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OperationMetadataV1Beta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OperationMetadataV1Beta_MethodMetadata>
      _OperationMetadataV1Beta_MethodMetadataByTag = {
    8: OperationMetadataV1Beta_MethodMetadata.createVersionMetadata,
    0: OperationMetadataV1Beta_MethodMetadata.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OperationMetadataV1Beta',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..oo(0, [8])
    ..aOS(1, _omitFieldNames ? '' : 'method')
    ..aOM<$50.Timestamp>(2, _omitFieldNames ? '' : 'insertTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(3, _omitFieldNames ? '' : 'endTime',
        subBuilder: $50.Timestamp.create)
    ..aOS(4, _omitFieldNames ? '' : 'user')
    ..aOS(5, _omitFieldNames ? '' : 'target')
    ..aOS(6, _omitFieldNames ? '' : 'ephemeralMessage')
    ..pPS(7, _omitFieldNames ? '' : 'warning')
    ..aOM<CreateVersionMetadataV1Beta>(
        8, _omitFieldNames ? '' : 'createVersionMetadata',
        subBuilder: CreateVersionMetadataV1Beta.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OperationMetadataV1Beta clone() =>
      OperationMetadataV1Beta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OperationMetadataV1Beta copyWith(
          void Function(OperationMetadataV1Beta) updates) =>
      super.copyWith((message) => updates(message as OperationMetadataV1Beta))
          as OperationMetadataV1Beta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OperationMetadataV1Beta create() => OperationMetadataV1Beta._();
  OperationMetadataV1Beta createEmptyInstance() => create();
  static $pb.PbList<OperationMetadataV1Beta> createRepeated() =>
      $pb.PbList<OperationMetadataV1Beta>();
  @$core.pragma('dart2js:noInline')
  static OperationMetadataV1Beta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OperationMetadataV1Beta>(create);
  static OperationMetadataV1Beta? _defaultInstance;

  OperationMetadataV1Beta_MethodMetadata whichMethodMetadata() =>
      _OperationMetadataV1Beta_MethodMetadataByTag[$_whichOneof(0)]!;
  void clearMethodMetadata() => clearField($_whichOneof(0));

  ///  API method that initiated this operation. Example:
  ///  `google.appengine.v1beta.Versions.CreateVersion`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  ///  Time that this operation was created.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(2)
  $50.Timestamp get insertTime => $_getN(1);
  @$pb.TagNumber(2)
  set insertTime($50.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInsertTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearInsertTime() => clearField(2);
  @$pb.TagNumber(2)
  $50.Timestamp ensureInsertTime() => $_ensure(1);

  ///  Time that this operation completed.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(3)
  $50.Timestamp get endTime => $_getN(2);
  @$pb.TagNumber(3)
  set endTime($50.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasEndTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndTime() => clearField(3);
  @$pb.TagNumber(3)
  $50.Timestamp ensureEndTime() => $_ensure(2);

  ///  User who requested this operation.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(4)
  $core.String get user => $_getSZ(3);
  @$pb.TagNumber(4)
  set user($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);

  ///  Name of the resource that this operation is acting on. Example:
  ///  `apps/myapp/services/default`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(5)
  $core.String get target => $_getSZ(4);
  @$pb.TagNumber(5)
  set target($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasTarget() => $_has(4);
  @$pb.TagNumber(5)
  void clearTarget() => clearField(5);

  /// Ephemeral message that may change every time the operation is polled.
  /// @OutputOnly
  @$pb.TagNumber(6)
  $core.String get ephemeralMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set ephemeralMessage($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasEphemeralMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearEphemeralMessage() => clearField(6);

  /// Durable messages that persist on every operation poll.
  /// @OutputOnly
  @$pb.TagNumber(7)
  $core.List<$core.String> get warning => $_getList(6);

  @$pb.TagNumber(8)
  CreateVersionMetadataV1Beta get createVersionMetadata => $_getN(7);
  @$pb.TagNumber(8)
  set createVersionMetadata(CreateVersionMetadataV1Beta v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCreateVersionMetadata() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreateVersionMetadata() => clearField(8);
  @$pb.TagNumber(8)
  CreateVersionMetadataV1Beta ensureCreateVersionMetadata() => $_ensure(7);
}

/// Metadata for the given [google.longrunning.Operation][google.longrunning.Operation] during a
/// [google.appengine.v1beta.CreateVersionRequest][google.appengine.v1beta.CreateVersionRequest].
class CreateVersionMetadataV1Beta extends $pb.GeneratedMessage {
  factory CreateVersionMetadataV1Beta({
    $core.String? cloudBuildId,
  }) {
    final $result = create();
    if (cloudBuildId != null) {
      $result.cloudBuildId = cloudBuildId;
    }
    return $result;
  }
  CreateVersionMetadataV1Beta._() : super();
  factory CreateVersionMetadataV1Beta.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateVersionMetadataV1Beta.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVersionMetadataV1Beta',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cloudBuildId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateVersionMetadataV1Beta clone() =>
      CreateVersionMetadataV1Beta()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateVersionMetadataV1Beta copyWith(
          void Function(CreateVersionMetadataV1Beta) updates) =>
      super.copyWith(
              (message) => updates(message as CreateVersionMetadataV1Beta))
          as CreateVersionMetadataV1Beta;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVersionMetadataV1Beta create() =>
      CreateVersionMetadataV1Beta._();
  CreateVersionMetadataV1Beta createEmptyInstance() => create();
  static $pb.PbList<CreateVersionMetadataV1Beta> createRepeated() =>
      $pb.PbList<CreateVersionMetadataV1Beta>();
  @$core.pragma('dart2js:noInline')
  static CreateVersionMetadataV1Beta getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVersionMetadataV1Beta>(create);
  static CreateVersionMetadataV1Beta? _defaultInstance;

  /// The Cloud Build ID if one was created as part of the version create.
  /// @OutputOnly
  @$pb.TagNumber(1)
  $core.String get cloudBuildId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cloudBuildId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCloudBuildId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCloudBuildId() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
