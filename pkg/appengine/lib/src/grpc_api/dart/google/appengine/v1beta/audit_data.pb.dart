//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/audit_data.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'appengine.pb.dart' as $2;

enum AuditData_Method { updateService, createVersion, notSet }

/// App Engine admin service audit log.
class AuditData extends $pb.GeneratedMessage {
  factory AuditData({
    UpdateServiceMethod? updateService,
    CreateVersionMethod? createVersion,
  }) {
    final $result = create();
    if (updateService != null) {
      $result.updateService = updateService;
    }
    if (createVersion != null) {
      $result.createVersion = createVersion;
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

  static const $core.Map<$core.int, AuditData_Method> _AuditData_MethodByTag = {
    1: AuditData_Method.updateService,
    2: AuditData_Method.createVersion,
    0: AuditData_Method.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuditData',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<UpdateServiceMethod>(1, _omitFieldNames ? '' : 'updateService',
        subBuilder: UpdateServiceMethod.create)
    ..aOM<CreateVersionMethod>(2, _omitFieldNames ? '' : 'createVersion',
        subBuilder: CreateVersionMethod.create)
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

  AuditData_Method whichMethod() => _AuditData_MethodByTag[$_whichOneof(0)]!;
  void clearMethod() => clearField($_whichOneof(0));

  /// Detailed information about UpdateService call.
  @$pb.TagNumber(1)
  UpdateServiceMethod get updateService => $_getN(0);
  @$pb.TagNumber(1)
  set updateService(UpdateServiceMethod v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUpdateService() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateService() => clearField(1);
  @$pb.TagNumber(1)
  UpdateServiceMethod ensureUpdateService() => $_ensure(0);

  /// Detailed information about CreateVersion call.
  @$pb.TagNumber(2)
  CreateVersionMethod get createVersion => $_getN(1);
  @$pb.TagNumber(2)
  set createVersion(CreateVersionMethod v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCreateVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreateVersion() => clearField(2);
  @$pb.TagNumber(2)
  CreateVersionMethod ensureCreateVersion() => $_ensure(1);
}

/// Detailed information about UpdateService call.
class UpdateServiceMethod extends $pb.GeneratedMessage {
  factory UpdateServiceMethod({
    $2.UpdateServiceRequest? request,
  }) {
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    return $result;
  }
  UpdateServiceMethod._() : super();
  factory UpdateServiceMethod.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateServiceMethod.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateServiceMethod',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOM<$2.UpdateServiceRequest>(1, _omitFieldNames ? '' : 'request',
        subBuilder: $2.UpdateServiceRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateServiceMethod clone() => UpdateServiceMethod()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateServiceMethod copyWith(void Function(UpdateServiceMethod) updates) =>
      super.copyWith((message) => updates(message as UpdateServiceMethod))
          as UpdateServiceMethod;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateServiceMethod create() => UpdateServiceMethod._();
  UpdateServiceMethod createEmptyInstance() => create();
  static $pb.PbList<UpdateServiceMethod> createRepeated() =>
      $pb.PbList<UpdateServiceMethod>();
  @$core.pragma('dart2js:noInline')
  static UpdateServiceMethod getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateServiceMethod>(create);
  static UpdateServiceMethod? _defaultInstance;

  /// Update service request.
  @$pb.TagNumber(1)
  $2.UpdateServiceRequest get request => $_getN(0);
  @$pb.TagNumber(1)
  set request($2.UpdateServiceRequest v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
  @$pb.TagNumber(1)
  $2.UpdateServiceRequest ensureRequest() => $_ensure(0);
}

/// Detailed information about CreateVersion call.
class CreateVersionMethod extends $pb.GeneratedMessage {
  factory CreateVersionMethod({
    $2.CreateVersionRequest? request,
  }) {
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    return $result;
  }
  CreateVersionMethod._() : super();
  factory CreateVersionMethod.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateVersionMethod.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVersionMethod',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOM<$2.CreateVersionRequest>(1, _omitFieldNames ? '' : 'request',
        subBuilder: $2.CreateVersionRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateVersionMethod clone() => CreateVersionMethod()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateVersionMethod copyWith(void Function(CreateVersionMethod) updates) =>
      super.copyWith((message) => updates(message as CreateVersionMethod))
          as CreateVersionMethod;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVersionMethod create() => CreateVersionMethod._();
  CreateVersionMethod createEmptyInstance() => create();
  static $pb.PbList<CreateVersionMethod> createRepeated() =>
      $pb.PbList<CreateVersionMethod>();
  @$core.pragma('dart2js:noInline')
  static CreateVersionMethod getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVersionMethod>(create);
  static CreateVersionMethod? _defaultInstance;

  /// Create version request.
  @$pb.TagNumber(1)
  $2.CreateVersionRequest get request => $_getN(0);
  @$pb.TagNumber(1)
  set request($2.CreateVersionRequest v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
  @$pb.TagNumber(1)
  $2.CreateVersionRequest ensureRequest() => $_ensure(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
