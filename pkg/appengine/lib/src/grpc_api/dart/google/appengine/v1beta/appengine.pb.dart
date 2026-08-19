//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/appengine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/field_mask.pb.dart' as $58;
import 'appengine.pbenum.dart';
import 'application.pb.dart' as $3;
import 'certificate.pb.dart' as $8;
import 'domain.pb.dart' as $59;
import 'domain_mapping.pb.dart' as $9;
import 'firewall.pb.dart' as $7;
import 'instance.pb.dart' as $6;
import 'service.pb.dart' as $4;
import 'version.pb.dart' as $5;

export 'appengine.pbenum.dart';

/// Request message for `Applications.GetApplication`.
class GetApplicationRequest extends $pb.GeneratedMessage {
  factory GetApplicationRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetApplicationRequest._() : super();
  factory GetApplicationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetApplicationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetApplicationRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetApplicationRequest clone() =>
      GetApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetApplicationRequest copyWith(
          void Function(GetApplicationRequest) updates) =>
      super.copyWith((message) => updates(message as GetApplicationRequest))
          as GetApplicationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetApplicationRequest create() => GetApplicationRequest._();
  GetApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<GetApplicationRequest> createRepeated() =>
      $pb.PbList<GetApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static GetApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetApplicationRequest>(create);
  static GetApplicationRequest? _defaultInstance;

  /// Name of the Application resource to get. Example: `apps/myapp`.
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

/// Request message for `Applications.CreateApplication`.
class CreateApplicationRequest extends $pb.GeneratedMessage {
  factory CreateApplicationRequest({
    $3.Application? application,
  }) {
    final $result = create();
    if (application != null) {
      $result.application = application;
    }
    return $result;
  }
  CreateApplicationRequest._() : super();
  factory CreateApplicationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateApplicationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateApplicationRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOM<$3.Application>(2, _omitFieldNames ? '' : 'application',
        subBuilder: $3.Application.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateApplicationRequest clone() =>
      CreateApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateApplicationRequest copyWith(
          void Function(CreateApplicationRequest) updates) =>
      super.copyWith((message) => updates(message as CreateApplicationRequest))
          as CreateApplicationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateApplicationRequest create() => CreateApplicationRequest._();
  CreateApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateApplicationRequest> createRepeated() =>
      $pb.PbList<CreateApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateApplicationRequest>(create);
  static CreateApplicationRequest? _defaultInstance;

  /// Application configuration.
  @$pb.TagNumber(2)
  $3.Application get application => $_getN(0);
  @$pb.TagNumber(2)
  set application($3.Application v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasApplication() => $_has(0);
  @$pb.TagNumber(2)
  void clearApplication() => clearField(2);
  @$pb.TagNumber(2)
  $3.Application ensureApplication() => $_ensure(0);
}

/// Request message for `Applications.UpdateApplication`.
class UpdateApplicationRequest extends $pb.GeneratedMessage {
  factory UpdateApplicationRequest({
    $core.String? name,
    $3.Application? application,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (application != null) {
      $result.application = application;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateApplicationRequest._() : super();
  factory UpdateApplicationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateApplicationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateApplicationRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$3.Application>(2, _omitFieldNames ? '' : 'application',
        subBuilder: $3.Application.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateApplicationRequest clone() =>
      UpdateApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateApplicationRequest copyWith(
          void Function(UpdateApplicationRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateApplicationRequest))
          as UpdateApplicationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateApplicationRequest create() => UpdateApplicationRequest._();
  UpdateApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateApplicationRequest> createRepeated() =>
      $pb.PbList<UpdateApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateApplicationRequest>(create);
  static UpdateApplicationRequest? _defaultInstance;

  /// Name of the Application resource to update. Example: `apps/myapp`.
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

  /// An Application containing the updated resource.
  @$pb.TagNumber(2)
  $3.Application get application => $_getN(1);
  @$pb.TagNumber(2)
  set application($3.Application v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasApplication() => $_has(1);
  @$pb.TagNumber(2)
  void clearApplication() => clearField(2);
  @$pb.TagNumber(2)
  $3.Application ensureApplication() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for 'Applications.RepairApplication'.
class RepairApplicationRequest extends $pb.GeneratedMessage {
  factory RepairApplicationRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  RepairApplicationRequest._() : super();
  factory RepairApplicationRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory RepairApplicationRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RepairApplicationRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  RepairApplicationRequest clone() =>
      RepairApplicationRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  RepairApplicationRequest copyWith(
          void Function(RepairApplicationRequest) updates) =>
      super.copyWith((message) => updates(message as RepairApplicationRequest))
          as RepairApplicationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepairApplicationRequest create() => RepairApplicationRequest._();
  RepairApplicationRequest createEmptyInstance() => create();
  static $pb.PbList<RepairApplicationRequest> createRepeated() =>
      $pb.PbList<RepairApplicationRequest>();
  @$core.pragma('dart2js:noInline')
  static RepairApplicationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RepairApplicationRequest>(create);
  static RepairApplicationRequest? _defaultInstance;

  /// Name of the application to repair. Example: `apps/myapp`
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

/// Request message for `Services.ListServices`.
class ListServicesRequest extends $pb.GeneratedMessage {
  factory ListServicesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
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
    return $result;
  }
  ListServicesRequest._() : super();
  factory ListServicesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServicesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServicesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServicesRequest clone() => ListServicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServicesRequest copyWith(void Function(ListServicesRequest) updates) =>
      super.copyWith((message) => updates(message as ListServicesRequest))
          as ListServicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServicesRequest create() => ListServicesRequest._();
  ListServicesRequest createEmptyInstance() => create();
  static $pb.PbList<ListServicesRequest> createRepeated() =>
      $pb.PbList<ListServicesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListServicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServicesRequest>(create);
  static ListServicesRequest? _defaultInstance;

  /// Name of the parent Application resource. Example: `apps/myapp`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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
}

/// Response message for `Services.ListServices`.
class ListServicesResponse extends $pb.GeneratedMessage {
  factory ListServicesResponse({
    $core.Iterable<$4.Service>? services,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (services != null) {
      $result.services.addAll(services);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListServicesResponse._() : super();
  factory ListServicesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServicesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServicesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$4.Service>(1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $4.Service.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServicesResponse clone() =>
      ListServicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServicesResponse copyWith(void Function(ListServicesResponse) updates) =>
      super.copyWith((message) => updates(message as ListServicesResponse))
          as ListServicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServicesResponse create() => ListServicesResponse._();
  ListServicesResponse createEmptyInstance() => create();
  static $pb.PbList<ListServicesResponse> createRepeated() =>
      $pb.PbList<ListServicesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListServicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServicesResponse>(create);
  static ListServicesResponse? _defaultInstance;

  /// The services belonging to the requested application.
  @$pb.TagNumber(1)
  $core.List<$4.Service> get services => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `Services.GetService`.
class GetServiceRequest extends $pb.GeneratedMessage {
  factory GetServiceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetServiceRequest._() : super();
  factory GetServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceRequest clone() => GetServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceRequest copyWith(void Function(GetServiceRequest) updates) =>
      super.copyWith((message) => updates(message as GetServiceRequest))
          as GetServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceRequest create() => GetServiceRequest._();
  GetServiceRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceRequest> createRepeated() =>
      $pb.PbList<GetServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceRequest>(create);
  static GetServiceRequest? _defaultInstance;

  /// Name of the resource requested. Example: `apps/myapp/services/default`.
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

/// Request message for `Services.UpdateService`.
class UpdateServiceRequest extends $pb.GeneratedMessage {
  factory UpdateServiceRequest({
    $core.String? name,
    $4.Service? service,
    $58.FieldMask? updateMask,
    $core.bool? migrateTraffic,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (service != null) {
      $result.service = service;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    if (migrateTraffic != null) {
      $result.migrateTraffic = migrateTraffic;
    }
    return $result;
  }
  UpdateServiceRequest._() : super();
  factory UpdateServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$4.Service>(2, _omitFieldNames ? '' : 'service',
        subBuilder: $4.Service.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..aOB(4, _omitFieldNames ? '' : 'migrateTraffic')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateServiceRequest clone() =>
      UpdateServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateServiceRequest copyWith(void Function(UpdateServiceRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateServiceRequest))
          as UpdateServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateServiceRequest create() => UpdateServiceRequest._();
  UpdateServiceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateServiceRequest> createRepeated() =>
      $pb.PbList<UpdateServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateServiceRequest>(create);
  static UpdateServiceRequest? _defaultInstance;

  /// Name of the resource to update. Example: `apps/myapp/services/default`.
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

  /// A Service resource containing the updated service. Only fields set in the
  /// field mask will be updated.
  @$pb.TagNumber(2)
  $4.Service get service => $_getN(1);
  @$pb.TagNumber(2)
  set service($4.Service v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasService() => $_has(1);
  @$pb.TagNumber(2)
  void clearService() => clearField(2);
  @$pb.TagNumber(2)
  $4.Service ensureService() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);

  /// Set to `true` to gradually shift traffic to one or more versions that you
  /// specify. By default, traffic is shifted immediately.
  /// For gradual traffic migration, the target versions
  /// must be located within instances that are configured for both
  /// [warmup requests](https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta/apps.services.versions#InboundServiceType)
  /// and
  /// [automatic scaling](https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta/apps.services.versions#AutomaticScaling).
  /// You must specify the
  /// [`shardBy`](https://cloud.google.com/appengine/docs/admin-api/reference/rest/v1beta/apps.services#ShardBy)
  /// field in the Service resource. Gradual traffic migration is not
  /// supported in the App Engine flexible environment. For examples, see
  /// [Migrating and Splitting Traffic](https://cloud.google.com/appengine/docs/admin-api/migrating-splitting-traffic).
  @$pb.TagNumber(4)
  $core.bool get migrateTraffic => $_getBF(3);
  @$pb.TagNumber(4)
  set migrateTraffic($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMigrateTraffic() => $_has(3);
  @$pb.TagNumber(4)
  void clearMigrateTraffic() => clearField(4);
}

/// Request message for `Services.DeleteService`.
class DeleteServiceRequest extends $pb.GeneratedMessage {
  factory DeleteServiceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteServiceRequest._() : super();
  factory DeleteServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteServiceRequest clone() =>
      DeleteServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteServiceRequest copyWith(void Function(DeleteServiceRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteServiceRequest))
          as DeleteServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteServiceRequest create() => DeleteServiceRequest._();
  DeleteServiceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteServiceRequest> createRepeated() =>
      $pb.PbList<DeleteServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteServiceRequest>(create);
  static DeleteServiceRequest? _defaultInstance;

  /// Name of the resource requested. Example: `apps/myapp/services/default`.
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

/// Request message for `Versions.ListVersions`.
class ListVersionsRequest extends $pb.GeneratedMessage {
  factory ListVersionsRequest({
    $core.String? parent,
    VersionView? view,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (view != null) {
      $result.view = view;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListVersionsRequest._() : super();
  factory ListVersionsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListVersionsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListVersionsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..e<VersionView>(2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: VersionView.BASIC,
        valueOf: VersionView.valueOf,
        enumValues: VersionView.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListVersionsRequest clone() => ListVersionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListVersionsRequest copyWith(void Function(ListVersionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListVersionsRequest))
          as ListVersionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListVersionsRequest create() => ListVersionsRequest._();
  ListVersionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListVersionsRequest> createRepeated() =>
      $pb.PbList<ListVersionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListVersionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListVersionsRequest>(create);
  static ListVersionsRequest? _defaultInstance;

  /// Name of the parent Service resource. Example:
  /// `apps/myapp/services/default`.
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

  /// Controls the set of fields returned in the `List` response.
  @$pb.TagNumber(2)
  VersionView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view(VersionView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);

  /// Maximum results to return per page.
  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int v) {
    $_setSignedInt32(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => clearField(3);

  /// Continuation token for fetching the next page of results.
  @$pb.TagNumber(4)
  $core.String get pageToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set pageToken($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasPageToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageToken() => clearField(4);
}

/// Response message for `Versions.ListVersions`.
class ListVersionsResponse extends $pb.GeneratedMessage {
  factory ListVersionsResponse({
    $core.Iterable<$5.Version>? versions,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (versions != null) {
      $result.versions.addAll(versions);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListVersionsResponse._() : super();
  factory ListVersionsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListVersionsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListVersionsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$5.Version>(1, _omitFieldNames ? '' : 'versions', $pb.PbFieldType.PM,
        subBuilder: $5.Version.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListVersionsResponse clone() =>
      ListVersionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListVersionsResponse copyWith(void Function(ListVersionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListVersionsResponse))
          as ListVersionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListVersionsResponse create() => ListVersionsResponse._();
  ListVersionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListVersionsResponse> createRepeated() =>
      $pb.PbList<ListVersionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListVersionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListVersionsResponse>(create);
  static ListVersionsResponse? _defaultInstance;

  /// The versions belonging to the requested service.
  @$pb.TagNumber(1)
  $core.List<$5.Version> get versions => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `Versions.GetVersion`.
class GetVersionRequest extends $pb.GeneratedMessage {
  factory GetVersionRequest({
    $core.String? name,
    VersionView? view,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (view != null) {
      $result.view = view;
    }
    return $result;
  }
  GetVersionRequest._() : super();
  factory GetVersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetVersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetVersionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<VersionView>(2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: VersionView.BASIC,
        valueOf: VersionView.valueOf,
        enumValues: VersionView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetVersionRequest clone() => GetVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetVersionRequest copyWith(void Function(GetVersionRequest) updates) =>
      super.copyWith((message) => updates(message as GetVersionRequest))
          as GetVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVersionRequest create() => GetVersionRequest._();
  GetVersionRequest createEmptyInstance() => create();
  static $pb.PbList<GetVersionRequest> createRepeated() =>
      $pb.PbList<GetVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetVersionRequest>(create);
  static GetVersionRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/services/default/versions/v1`.
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

  /// Controls the set of fields returned in the `Get` response.
  @$pb.TagNumber(2)
  VersionView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view(VersionView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);
}

/// Request message for `Versions.CreateVersion`.
class CreateVersionRequest extends $pb.GeneratedMessage {
  factory CreateVersionRequest({
    $core.String? parent,
    $5.Version? version,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  CreateVersionRequest._() : super();
  factory CreateVersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateVersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVersionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$5.Version>(2, _omitFieldNames ? '' : 'version',
        subBuilder: $5.Version.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateVersionRequest clone() =>
      CreateVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateVersionRequest copyWith(void Function(CreateVersionRequest) updates) =>
      super.copyWith((message) => updates(message as CreateVersionRequest))
          as CreateVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVersionRequest create() => CreateVersionRequest._();
  CreateVersionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVersionRequest> createRepeated() =>
      $pb.PbList<CreateVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVersionRequest>(create);
  static CreateVersionRequest? _defaultInstance;

  /// Name of the parent resource to create this version under. Example:
  /// `apps/myapp/services/default`.
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

  /// Application deployment configuration.
  @$pb.TagNumber(2)
  $5.Version get version => $_getN(1);
  @$pb.TagNumber(2)
  set version($5.Version v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
  @$pb.TagNumber(2)
  $5.Version ensureVersion() => $_ensure(1);
}

/// Request message for `Versions.UpdateVersion`.
class UpdateVersionRequest extends $pb.GeneratedMessage {
  factory UpdateVersionRequest({
    $core.String? name,
    $5.Version? version,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (version != null) {
      $result.version = version;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateVersionRequest._() : super();
  factory UpdateVersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateVersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateVersionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$5.Version>(2, _omitFieldNames ? '' : 'version',
        subBuilder: $5.Version.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateVersionRequest clone() =>
      UpdateVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateVersionRequest copyWith(void Function(UpdateVersionRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateVersionRequest))
          as UpdateVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateVersionRequest create() => UpdateVersionRequest._();
  UpdateVersionRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateVersionRequest> createRepeated() =>
      $pb.PbList<UpdateVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateVersionRequest>(create);
  static UpdateVersionRequest? _defaultInstance;

  /// Name of the resource to update. Example:
  /// `apps/myapp/services/default/versions/1`.
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

  /// A Version containing the updated resource. Only fields set in the field
  /// mask will be updated.
  @$pb.TagNumber(2)
  $5.Version get version => $_getN(1);
  @$pb.TagNumber(2)
  set version($5.Version v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersion() => clearField(2);
  @$pb.TagNumber(2)
  $5.Version ensureVersion() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for `Versions.DeleteVersion`.
class DeleteVersionRequest extends $pb.GeneratedMessage {
  factory DeleteVersionRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteVersionRequest._() : super();
  factory DeleteVersionRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteVersionRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteVersionRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteVersionRequest clone() =>
      DeleteVersionRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteVersionRequest copyWith(void Function(DeleteVersionRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteVersionRequest))
          as DeleteVersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteVersionRequest create() => DeleteVersionRequest._();
  DeleteVersionRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteVersionRequest> createRepeated() =>
      $pb.PbList<DeleteVersionRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteVersionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteVersionRequest>(create);
  static DeleteVersionRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/services/default/versions/v1`.
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

/// Request message for `Instances.ListInstances`.
class ListInstancesRequest extends $pb.GeneratedMessage {
  factory ListInstancesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
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
    return $result;
  }
  ListInstancesRequest._() : super();
  factory ListInstancesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListInstancesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListInstancesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListInstancesRequest clone() =>
      ListInstancesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListInstancesRequest copyWith(void Function(ListInstancesRequest) updates) =>
      super.copyWith((message) => updates(message as ListInstancesRequest))
          as ListInstancesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInstancesRequest create() => ListInstancesRequest._();
  ListInstancesRequest createEmptyInstance() => create();
  static $pb.PbList<ListInstancesRequest> createRepeated() =>
      $pb.PbList<ListInstancesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListInstancesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListInstancesRequest>(create);
  static ListInstancesRequest? _defaultInstance;

  /// Name of the parent Version resource. Example:
  /// `apps/myapp/services/default/versions/v1`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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
}

/// Response message for `Instances.ListInstances`.
class ListInstancesResponse extends $pb.GeneratedMessage {
  factory ListInstancesResponse({
    $core.Iterable<$6.Instance>? instances,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (instances != null) {
      $result.instances.addAll(instances);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListInstancesResponse._() : super();
  factory ListInstancesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListInstancesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListInstancesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$6.Instance>(1, _omitFieldNames ? '' : 'instances', $pb.PbFieldType.PM,
        subBuilder: $6.Instance.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListInstancesResponse clone() =>
      ListInstancesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListInstancesResponse copyWith(
          void Function(ListInstancesResponse) updates) =>
      super.copyWith((message) => updates(message as ListInstancesResponse))
          as ListInstancesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInstancesResponse create() => ListInstancesResponse._();
  ListInstancesResponse createEmptyInstance() => create();
  static $pb.PbList<ListInstancesResponse> createRepeated() =>
      $pb.PbList<ListInstancesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListInstancesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListInstancesResponse>(create);
  static ListInstancesResponse? _defaultInstance;

  /// The instances belonging to the requested version.
  @$pb.TagNumber(1)
  $core.List<$6.Instance> get instances => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `Instances.GetInstance`.
class GetInstanceRequest extends $pb.GeneratedMessage {
  factory GetInstanceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetInstanceRequest._() : super();
  factory GetInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetInstanceRequest clone() => GetInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetInstanceRequest copyWith(void Function(GetInstanceRequest) updates) =>
      super.copyWith((message) => updates(message as GetInstanceRequest))
          as GetInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInstanceRequest create() => GetInstanceRequest._();
  GetInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetInstanceRequest> createRepeated() =>
      $pb.PbList<GetInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInstanceRequest>(create);
  static GetInstanceRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/services/default/versions/v1/instances/instance-1`.
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

/// Request message for `Instances.DeleteInstance`.
class DeleteInstanceRequest extends $pb.GeneratedMessage {
  factory DeleteInstanceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteInstanceRequest._() : super();
  factory DeleteInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteInstanceRequest clone() =>
      DeleteInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteInstanceRequest copyWith(
          void Function(DeleteInstanceRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteInstanceRequest))
          as DeleteInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInstanceRequest create() => DeleteInstanceRequest._();
  DeleteInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInstanceRequest> createRepeated() =>
      $pb.PbList<DeleteInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteInstanceRequest>(create);
  static DeleteInstanceRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/services/default/versions/v1/instances/instance-1`.
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

/// Request message for `Instances.DebugInstance`.
class DebugInstanceRequest extends $pb.GeneratedMessage {
  factory DebugInstanceRequest({
    $core.String? name,
    $core.String? sshKey,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (sshKey != null) {
      $result.sshKey = sshKey;
    }
    return $result;
  }
  DebugInstanceRequest._() : super();
  factory DebugInstanceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DebugInstanceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DebugInstanceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'sshKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DebugInstanceRequest clone() =>
      DebugInstanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DebugInstanceRequest copyWith(void Function(DebugInstanceRequest) updates) =>
      super.copyWith((message) => updates(message as DebugInstanceRequest))
          as DebugInstanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugInstanceRequest create() => DebugInstanceRequest._();
  DebugInstanceRequest createEmptyInstance() => create();
  static $pb.PbList<DebugInstanceRequest> createRepeated() =>
      $pb.PbList<DebugInstanceRequest>();
  @$core.pragma('dart2js:noInline')
  static DebugInstanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DebugInstanceRequest>(create);
  static DebugInstanceRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/services/default/versions/v1/instances/instance-1`.
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

  ///  Public SSH key to add to the instance. Examples:
  ///
  ///  * `[USERNAME]:ssh-rsa [KEY_VALUE] [USERNAME]`
  ///  * `[USERNAME]:ssh-rsa [KEY_VALUE] google-ssh {"userName":"[USERNAME]","expireOn":"[EXPIRE_TIME]"}`
  ///
  ///  For more information, see
  ///  [Adding and Removing SSH Keys](https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys).
  @$pb.TagNumber(2)
  $core.String get sshKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set sshKey($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSshKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearSshKey() => clearField(2);
}

/// Request message for `Firewall.ListIngressRules`.
class ListIngressRulesRequest extends $pb.GeneratedMessage {
  factory ListIngressRulesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.String? matchingAddress,
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
    if (matchingAddress != null) {
      $result.matchingAddress = matchingAddress;
    }
    return $result;
  }
  ListIngressRulesRequest._() : super();
  factory ListIngressRulesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListIngressRulesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListIngressRulesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOS(4, _omitFieldNames ? '' : 'matchingAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListIngressRulesRequest clone() =>
      ListIngressRulesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListIngressRulesRequest copyWith(
          void Function(ListIngressRulesRequest) updates) =>
      super.copyWith((message) => updates(message as ListIngressRulesRequest))
          as ListIngressRulesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListIngressRulesRequest create() => ListIngressRulesRequest._();
  ListIngressRulesRequest createEmptyInstance() => create();
  static $pb.PbList<ListIngressRulesRequest> createRepeated() =>
      $pb.PbList<ListIngressRulesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListIngressRulesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListIngressRulesRequest>(create);
  static ListIngressRulesRequest? _defaultInstance;

  /// Name of the Firewall collection to retrieve.
  /// Example: `apps/myapp/firewall/ingressRules`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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

  /// A valid IP Address. If set, only rules matching this address will be
  /// returned. The first returned rule will be the rule that fires on requests
  /// from this IP.
  @$pb.TagNumber(4)
  $core.String get matchingAddress => $_getSZ(3);
  @$pb.TagNumber(4)
  set matchingAddress($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasMatchingAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatchingAddress() => clearField(4);
}

/// Response message for `Firewall.ListIngressRules`.
class ListIngressRulesResponse extends $pb.GeneratedMessage {
  factory ListIngressRulesResponse({
    $core.Iterable<$7.FirewallRule>? ingressRules,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (ingressRules != null) {
      $result.ingressRules.addAll(ingressRules);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListIngressRulesResponse._() : super();
  factory ListIngressRulesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListIngressRulesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListIngressRulesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$7.FirewallRule>(
        1, _omitFieldNames ? '' : 'ingressRules', $pb.PbFieldType.PM,
        subBuilder: $7.FirewallRule.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListIngressRulesResponse clone() =>
      ListIngressRulesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListIngressRulesResponse copyWith(
          void Function(ListIngressRulesResponse) updates) =>
      super.copyWith((message) => updates(message as ListIngressRulesResponse))
          as ListIngressRulesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListIngressRulesResponse create() => ListIngressRulesResponse._();
  ListIngressRulesResponse createEmptyInstance() => create();
  static $pb.PbList<ListIngressRulesResponse> createRepeated() =>
      $pb.PbList<ListIngressRulesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListIngressRulesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListIngressRulesResponse>(create);
  static ListIngressRulesResponse? _defaultInstance;

  /// The ingress FirewallRules for this application.
  @$pb.TagNumber(1)
  $core.List<$7.FirewallRule> get ingressRules => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `Firewall.BatchUpdateIngressRules`.
class BatchUpdateIngressRulesRequest extends $pb.GeneratedMessage {
  factory BatchUpdateIngressRulesRequest({
    $core.String? name,
    $core.Iterable<$7.FirewallRule>? ingressRules,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (ingressRules != null) {
      $result.ingressRules.addAll(ingressRules);
    }
    return $result;
  }
  BatchUpdateIngressRulesRequest._() : super();
  factory BatchUpdateIngressRulesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchUpdateIngressRulesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchUpdateIngressRulesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<$7.FirewallRule>(
        2, _omitFieldNames ? '' : 'ingressRules', $pb.PbFieldType.PM,
        subBuilder: $7.FirewallRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchUpdateIngressRulesRequest clone() =>
      BatchUpdateIngressRulesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchUpdateIngressRulesRequest copyWith(
          void Function(BatchUpdateIngressRulesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as BatchUpdateIngressRulesRequest))
          as BatchUpdateIngressRulesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchUpdateIngressRulesRequest create() =>
      BatchUpdateIngressRulesRequest._();
  BatchUpdateIngressRulesRequest createEmptyInstance() => create();
  static $pb.PbList<BatchUpdateIngressRulesRequest> createRepeated() =>
      $pb.PbList<BatchUpdateIngressRulesRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchUpdateIngressRulesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchUpdateIngressRulesRequest>(create);
  static BatchUpdateIngressRulesRequest? _defaultInstance;

  /// Name of the Firewall collection to set.
  /// Example: `apps/myapp/firewall/ingressRules`.
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

  /// A list of FirewallRules to replace the existing set.
  @$pb.TagNumber(2)
  $core.List<$7.FirewallRule> get ingressRules => $_getList(1);
}

/// Response message for `Firewall.UpdateAllIngressRules`.
class BatchUpdateIngressRulesResponse extends $pb.GeneratedMessage {
  factory BatchUpdateIngressRulesResponse({
    $core.Iterable<$7.FirewallRule>? ingressRules,
  }) {
    final $result = create();
    if (ingressRules != null) {
      $result.ingressRules.addAll(ingressRules);
    }
    return $result;
  }
  BatchUpdateIngressRulesResponse._() : super();
  factory BatchUpdateIngressRulesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchUpdateIngressRulesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchUpdateIngressRulesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$7.FirewallRule>(
        1, _omitFieldNames ? '' : 'ingressRules', $pb.PbFieldType.PM,
        subBuilder: $7.FirewallRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchUpdateIngressRulesResponse clone() =>
      BatchUpdateIngressRulesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchUpdateIngressRulesResponse copyWith(
          void Function(BatchUpdateIngressRulesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BatchUpdateIngressRulesResponse))
          as BatchUpdateIngressRulesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchUpdateIngressRulesResponse create() =>
      BatchUpdateIngressRulesResponse._();
  BatchUpdateIngressRulesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchUpdateIngressRulesResponse> createRepeated() =>
      $pb.PbList<BatchUpdateIngressRulesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchUpdateIngressRulesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchUpdateIngressRulesResponse>(
          create);
  static BatchUpdateIngressRulesResponse? _defaultInstance;

  /// The full list of ingress FirewallRules for this application.
  @$pb.TagNumber(1)
  $core.List<$7.FirewallRule> get ingressRules => $_getList(0);
}

/// Request message for `Firewall.CreateIngressRule`.
class CreateIngressRuleRequest extends $pb.GeneratedMessage {
  factory CreateIngressRuleRequest({
    $core.String? parent,
    $7.FirewallRule? rule,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (rule != null) {
      $result.rule = rule;
    }
    return $result;
  }
  CreateIngressRuleRequest._() : super();
  factory CreateIngressRuleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateIngressRuleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateIngressRuleRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$7.FirewallRule>(2, _omitFieldNames ? '' : 'rule',
        subBuilder: $7.FirewallRule.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateIngressRuleRequest clone() =>
      CreateIngressRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateIngressRuleRequest copyWith(
          void Function(CreateIngressRuleRequest) updates) =>
      super.copyWith((message) => updates(message as CreateIngressRuleRequest))
          as CreateIngressRuleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateIngressRuleRequest create() => CreateIngressRuleRequest._();
  CreateIngressRuleRequest createEmptyInstance() => create();
  static $pb.PbList<CreateIngressRuleRequest> createRepeated() =>
      $pb.PbList<CreateIngressRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateIngressRuleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateIngressRuleRequest>(create);
  static CreateIngressRuleRequest? _defaultInstance;

  /// Name of the parent Firewall collection in which to create a new rule.
  /// Example: `apps/myapp/firewall/ingressRules`.
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

  ///  A FirewallRule containing the new resource.
  ///
  ///  The user may optionally provide a position at which the new rule will be
  ///  placed. The positions define a sequential list starting at 1. If a rule
  ///  already exists at the given position, rules greater than the provided
  ///  position will be moved forward by one.
  ///
  ///  If no position is provided, the server will place the rule as the second to
  ///  last rule in the sequence before the required default allow-all or deny-all
  ///  rule.
  @$pb.TagNumber(2)
  $7.FirewallRule get rule => $_getN(1);
  @$pb.TagNumber(2)
  set rule($7.FirewallRule v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRule() => $_has(1);
  @$pb.TagNumber(2)
  void clearRule() => clearField(2);
  @$pb.TagNumber(2)
  $7.FirewallRule ensureRule() => $_ensure(1);
}

/// Request message for `Firewall.GetIngressRule`.
class GetIngressRuleRequest extends $pb.GeneratedMessage {
  factory GetIngressRuleRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetIngressRuleRequest._() : super();
  factory GetIngressRuleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetIngressRuleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIngressRuleRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetIngressRuleRequest clone() =>
      GetIngressRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetIngressRuleRequest copyWith(
          void Function(GetIngressRuleRequest) updates) =>
      super.copyWith((message) => updates(message as GetIngressRuleRequest))
          as GetIngressRuleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIngressRuleRequest create() => GetIngressRuleRequest._();
  GetIngressRuleRequest createEmptyInstance() => create();
  static $pb.PbList<GetIngressRuleRequest> createRepeated() =>
      $pb.PbList<GetIngressRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIngressRuleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIngressRuleRequest>(create);
  static GetIngressRuleRequest? _defaultInstance;

  /// Name of the Firewall resource to retrieve.
  /// Example: `apps/myapp/firewall/ingressRules/100`.
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

/// Request message for `Firewall.UpdateIngressRule`.
class UpdateIngressRuleRequest extends $pb.GeneratedMessage {
  factory UpdateIngressRuleRequest({
    $core.String? name,
    $7.FirewallRule? rule,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (rule != null) {
      $result.rule = rule;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateIngressRuleRequest._() : super();
  factory UpdateIngressRuleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateIngressRuleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateIngressRuleRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$7.FirewallRule>(2, _omitFieldNames ? '' : 'rule',
        subBuilder: $7.FirewallRule.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateIngressRuleRequest clone() =>
      UpdateIngressRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateIngressRuleRequest copyWith(
          void Function(UpdateIngressRuleRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateIngressRuleRequest))
          as UpdateIngressRuleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateIngressRuleRequest create() => UpdateIngressRuleRequest._();
  UpdateIngressRuleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateIngressRuleRequest> createRepeated() =>
      $pb.PbList<UpdateIngressRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateIngressRuleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateIngressRuleRequest>(create);
  static UpdateIngressRuleRequest? _defaultInstance;

  /// Name of the Firewall resource to update.
  /// Example: `apps/myapp/firewall/ingressRules/100`.
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

  /// A FirewallRule containing the updated resource
  @$pb.TagNumber(2)
  $7.FirewallRule get rule => $_getN(1);
  @$pb.TagNumber(2)
  set rule($7.FirewallRule v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRule() => $_has(1);
  @$pb.TagNumber(2)
  void clearRule() => clearField(2);
  @$pb.TagNumber(2)
  $7.FirewallRule ensureRule() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for `Firewall.DeleteIngressRule`.
class DeleteIngressRuleRequest extends $pb.GeneratedMessage {
  factory DeleteIngressRuleRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteIngressRuleRequest._() : super();
  factory DeleteIngressRuleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteIngressRuleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteIngressRuleRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteIngressRuleRequest clone() =>
      DeleteIngressRuleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteIngressRuleRequest copyWith(
          void Function(DeleteIngressRuleRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteIngressRuleRequest))
          as DeleteIngressRuleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteIngressRuleRequest create() => DeleteIngressRuleRequest._();
  DeleteIngressRuleRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteIngressRuleRequest> createRepeated() =>
      $pb.PbList<DeleteIngressRuleRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteIngressRuleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteIngressRuleRequest>(create);
  static DeleteIngressRuleRequest? _defaultInstance;

  /// Name of the Firewall resource to delete.
  /// Example: `apps/myapp/firewall/ingressRules/100`.
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

/// Request message for `AuthorizedDomains.ListAuthorizedDomains`.
class ListAuthorizedDomainsRequest extends $pb.GeneratedMessage {
  factory ListAuthorizedDomainsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
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
    return $result;
  }
  ListAuthorizedDomainsRequest._() : super();
  factory ListAuthorizedDomainsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAuthorizedDomainsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAuthorizedDomainsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAuthorizedDomainsRequest clone() =>
      ListAuthorizedDomainsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAuthorizedDomainsRequest copyWith(
          void Function(ListAuthorizedDomainsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListAuthorizedDomainsRequest))
          as ListAuthorizedDomainsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAuthorizedDomainsRequest create() =>
      ListAuthorizedDomainsRequest._();
  ListAuthorizedDomainsRequest createEmptyInstance() => create();
  static $pb.PbList<ListAuthorizedDomainsRequest> createRepeated() =>
      $pb.PbList<ListAuthorizedDomainsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAuthorizedDomainsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAuthorizedDomainsRequest>(create);
  static ListAuthorizedDomainsRequest? _defaultInstance;

  /// Name of the parent Application resource. Example: `apps/myapp`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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
}

/// Response message for `AuthorizedDomains.ListAuthorizedDomains`.
class ListAuthorizedDomainsResponse extends $pb.GeneratedMessage {
  factory ListAuthorizedDomainsResponse({
    $core.Iterable<$59.AuthorizedDomain>? domains,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (domains != null) {
      $result.domains.addAll(domains);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListAuthorizedDomainsResponse._() : super();
  factory ListAuthorizedDomainsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAuthorizedDomainsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAuthorizedDomainsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$59.AuthorizedDomain>(
        1, _omitFieldNames ? '' : 'domains', $pb.PbFieldType.PM,
        subBuilder: $59.AuthorizedDomain.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAuthorizedDomainsResponse clone() =>
      ListAuthorizedDomainsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAuthorizedDomainsResponse copyWith(
          void Function(ListAuthorizedDomainsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListAuthorizedDomainsResponse))
          as ListAuthorizedDomainsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAuthorizedDomainsResponse create() =>
      ListAuthorizedDomainsResponse._();
  ListAuthorizedDomainsResponse createEmptyInstance() => create();
  static $pb.PbList<ListAuthorizedDomainsResponse> createRepeated() =>
      $pb.PbList<ListAuthorizedDomainsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAuthorizedDomainsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAuthorizedDomainsResponse>(create);
  static ListAuthorizedDomainsResponse? _defaultInstance;

  /// The authorized domains belonging to the user.
  @$pb.TagNumber(1)
  $core.List<$59.AuthorizedDomain> get domains => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `AuthorizedCertificates.ListAuthorizedCertificates`.
class ListAuthorizedCertificatesRequest extends $pb.GeneratedMessage {
  factory ListAuthorizedCertificatesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    AuthorizedCertificateView? view,
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
    if (view != null) {
      $result.view = view;
    }
    return $result;
  }
  ListAuthorizedCertificatesRequest._() : super();
  factory ListAuthorizedCertificatesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAuthorizedCertificatesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAuthorizedCertificatesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..e<AuthorizedCertificateView>(
        4, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: AuthorizedCertificateView.BASIC_CERTIFICATE,
        valueOf: AuthorizedCertificateView.valueOf,
        enumValues: AuthorizedCertificateView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAuthorizedCertificatesRequest clone() =>
      ListAuthorizedCertificatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAuthorizedCertificatesRequest copyWith(
          void Function(ListAuthorizedCertificatesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as ListAuthorizedCertificatesRequest))
          as ListAuthorizedCertificatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAuthorizedCertificatesRequest create() =>
      ListAuthorizedCertificatesRequest._();
  ListAuthorizedCertificatesRequest createEmptyInstance() => create();
  static $pb.PbList<ListAuthorizedCertificatesRequest> createRepeated() =>
      $pb.PbList<ListAuthorizedCertificatesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAuthorizedCertificatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAuthorizedCertificatesRequest>(
          create);
  static ListAuthorizedCertificatesRequest? _defaultInstance;

  /// Name of the parent `Application` resource. Example: `apps/myapp`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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

  /// Controls the set of fields returned in the `LIST` response.
  @$pb.TagNumber(4)
  AuthorizedCertificateView get view => $_getN(3);
  @$pb.TagNumber(4)
  set view(AuthorizedCertificateView v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasView() => $_has(3);
  @$pb.TagNumber(4)
  void clearView() => clearField(4);
}

/// Response message for `AuthorizedCertificates.ListAuthorizedCertificates`.
class ListAuthorizedCertificatesResponse extends $pb.GeneratedMessage {
  factory ListAuthorizedCertificatesResponse({
    $core.Iterable<$8.AuthorizedCertificate>? certificates,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (certificates != null) {
      $result.certificates.addAll(certificates);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListAuthorizedCertificatesResponse._() : super();
  factory ListAuthorizedCertificatesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAuthorizedCertificatesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAuthorizedCertificatesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$8.AuthorizedCertificate>(
        1, _omitFieldNames ? '' : 'certificates', $pb.PbFieldType.PM,
        subBuilder: $8.AuthorizedCertificate.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAuthorizedCertificatesResponse clone() =>
      ListAuthorizedCertificatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAuthorizedCertificatesResponse copyWith(
          void Function(ListAuthorizedCertificatesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ListAuthorizedCertificatesResponse))
          as ListAuthorizedCertificatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAuthorizedCertificatesResponse create() =>
      ListAuthorizedCertificatesResponse._();
  ListAuthorizedCertificatesResponse createEmptyInstance() => create();
  static $pb.PbList<ListAuthorizedCertificatesResponse> createRepeated() =>
      $pb.PbList<ListAuthorizedCertificatesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAuthorizedCertificatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAuthorizedCertificatesResponse>(
          create);
  static ListAuthorizedCertificatesResponse? _defaultInstance;

  /// The SSL certificates the user is authorized to administer.
  @$pb.TagNumber(1)
  $core.List<$8.AuthorizedCertificate> get certificates => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `AuthorizedCertificates.GetAuthorizedCertificate`.
class GetAuthorizedCertificateRequest extends $pb.GeneratedMessage {
  factory GetAuthorizedCertificateRequest({
    $core.String? name,
    AuthorizedCertificateView? view,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (view != null) {
      $result.view = view;
    }
    return $result;
  }
  GetAuthorizedCertificateRequest._() : super();
  factory GetAuthorizedCertificateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetAuthorizedCertificateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAuthorizedCertificateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<AuthorizedCertificateView>(
        2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: AuthorizedCertificateView.BASIC_CERTIFICATE,
        valueOf: AuthorizedCertificateView.valueOf,
        enumValues: AuthorizedCertificateView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetAuthorizedCertificateRequest clone() =>
      GetAuthorizedCertificateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetAuthorizedCertificateRequest copyWith(
          void Function(GetAuthorizedCertificateRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAuthorizedCertificateRequest))
          as GetAuthorizedCertificateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAuthorizedCertificateRequest create() =>
      GetAuthorizedCertificateRequest._();
  GetAuthorizedCertificateRequest createEmptyInstance() => create();
  static $pb.PbList<GetAuthorizedCertificateRequest> createRepeated() =>
      $pb.PbList<GetAuthorizedCertificateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAuthorizedCertificateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAuthorizedCertificateRequest>(
          create);
  static GetAuthorizedCertificateRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/authorizedCertificates/12345`.
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

  /// Controls the set of fields returned in the `GET` response.
  @$pb.TagNumber(2)
  AuthorizedCertificateView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view(AuthorizedCertificateView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);
}

/// Request message for `AuthorizedCertificates.CreateAuthorizedCertificate`.
class CreateAuthorizedCertificateRequest extends $pb.GeneratedMessage {
  factory CreateAuthorizedCertificateRequest({
    $core.String? parent,
    $8.AuthorizedCertificate? certificate,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (certificate != null) {
      $result.certificate = certificate;
    }
    return $result;
  }
  CreateAuthorizedCertificateRequest._() : super();
  factory CreateAuthorizedCertificateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAuthorizedCertificateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAuthorizedCertificateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$8.AuthorizedCertificate>(2, _omitFieldNames ? '' : 'certificate',
        subBuilder: $8.AuthorizedCertificate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAuthorizedCertificateRequest clone() =>
      CreateAuthorizedCertificateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAuthorizedCertificateRequest copyWith(
          void Function(CreateAuthorizedCertificateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as CreateAuthorizedCertificateRequest))
          as CreateAuthorizedCertificateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAuthorizedCertificateRequest create() =>
      CreateAuthorizedCertificateRequest._();
  CreateAuthorizedCertificateRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAuthorizedCertificateRequest> createRepeated() =>
      $pb.PbList<CreateAuthorizedCertificateRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAuthorizedCertificateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAuthorizedCertificateRequest>(
          create);
  static CreateAuthorizedCertificateRequest? _defaultInstance;

  /// Name of the parent `Application` resource. Example: `apps/myapp`.
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

  /// SSL certificate data.
  @$pb.TagNumber(2)
  $8.AuthorizedCertificate get certificate => $_getN(1);
  @$pb.TagNumber(2)
  set certificate($8.AuthorizedCertificate v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCertificate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCertificate() => clearField(2);
  @$pb.TagNumber(2)
  $8.AuthorizedCertificate ensureCertificate() => $_ensure(1);
}

/// Request message for `AuthorizedCertificates.UpdateAuthorizedCertificate`.
class UpdateAuthorizedCertificateRequest extends $pb.GeneratedMessage {
  factory UpdateAuthorizedCertificateRequest({
    $core.String? name,
    $8.AuthorizedCertificate? certificate,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (certificate != null) {
      $result.certificate = certificate;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateAuthorizedCertificateRequest._() : super();
  factory UpdateAuthorizedCertificateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateAuthorizedCertificateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAuthorizedCertificateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$8.AuthorizedCertificate>(2, _omitFieldNames ? '' : 'certificate',
        subBuilder: $8.AuthorizedCertificate.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateAuthorizedCertificateRequest clone() =>
      UpdateAuthorizedCertificateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateAuthorizedCertificateRequest copyWith(
          void Function(UpdateAuthorizedCertificateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateAuthorizedCertificateRequest))
          as UpdateAuthorizedCertificateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAuthorizedCertificateRequest create() =>
      UpdateAuthorizedCertificateRequest._();
  UpdateAuthorizedCertificateRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAuthorizedCertificateRequest> createRepeated() =>
      $pb.PbList<UpdateAuthorizedCertificateRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAuthorizedCertificateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAuthorizedCertificateRequest>(
          create);
  static UpdateAuthorizedCertificateRequest? _defaultInstance;

  /// Name of the resource to update. Example:
  /// `apps/myapp/authorizedCertificates/12345`.
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

  /// An `AuthorizedCertificate` containing the updated resource. Only fields set
  /// in the field mask will be updated.
  @$pb.TagNumber(2)
  $8.AuthorizedCertificate get certificate => $_getN(1);
  @$pb.TagNumber(2)
  set certificate($8.AuthorizedCertificate v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCertificate() => $_has(1);
  @$pb.TagNumber(2)
  void clearCertificate() => clearField(2);
  @$pb.TagNumber(2)
  $8.AuthorizedCertificate ensureCertificate() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated. Updates are only
  /// supported on the `certificate_raw_data` and `display_name` fields.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for `AuthorizedCertificates.DeleteAuthorizedCertificate`.
class DeleteAuthorizedCertificateRequest extends $pb.GeneratedMessage {
  factory DeleteAuthorizedCertificateRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteAuthorizedCertificateRequest._() : super();
  factory DeleteAuthorizedCertificateRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteAuthorizedCertificateRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAuthorizedCertificateRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteAuthorizedCertificateRequest clone() =>
      DeleteAuthorizedCertificateRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteAuthorizedCertificateRequest copyWith(
          void Function(DeleteAuthorizedCertificateRequest) updates) =>
      super.copyWith((message) =>
              updates(message as DeleteAuthorizedCertificateRequest))
          as DeleteAuthorizedCertificateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAuthorizedCertificateRequest create() =>
      DeleteAuthorizedCertificateRequest._();
  DeleteAuthorizedCertificateRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAuthorizedCertificateRequest> createRepeated() =>
      $pb.PbList<DeleteAuthorizedCertificateRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAuthorizedCertificateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAuthorizedCertificateRequest>(
          create);
  static DeleteAuthorizedCertificateRequest? _defaultInstance;

  /// Name of the resource to delete. Example:
  /// `apps/myapp/authorizedCertificates/12345`.
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

/// Request message for `DomainMappings.ListDomainMappings`.
class ListDomainMappingsRequest extends $pb.GeneratedMessage {
  factory ListDomainMappingsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
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
    return $result;
  }
  ListDomainMappingsRequest._() : super();
  factory ListDomainMappingsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListDomainMappingsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDomainMappingsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListDomainMappingsRequest clone() =>
      ListDomainMappingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListDomainMappingsRequest copyWith(
          void Function(ListDomainMappingsRequest) updates) =>
      super.copyWith((message) => updates(message as ListDomainMappingsRequest))
          as ListDomainMappingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDomainMappingsRequest create() => ListDomainMappingsRequest._();
  ListDomainMappingsRequest createEmptyInstance() => create();
  static $pb.PbList<ListDomainMappingsRequest> createRepeated() =>
      $pb.PbList<ListDomainMappingsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListDomainMappingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDomainMappingsRequest>(create);
  static ListDomainMappingsRequest? _defaultInstance;

  /// Name of the parent Application resource. Example: `apps/myapp`.
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

  /// Maximum results to return per page.
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

  /// Continuation token for fetching the next page of results.
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
}

/// Response message for `DomainMappings.ListDomainMappings`.
class ListDomainMappingsResponse extends $pb.GeneratedMessage {
  factory ListDomainMappingsResponse({
    $core.Iterable<$9.DomainMapping>? domainMappings,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (domainMappings != null) {
      $result.domainMappings.addAll(domainMappings);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListDomainMappingsResponse._() : super();
  factory ListDomainMappingsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListDomainMappingsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDomainMappingsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..pc<$9.DomainMapping>(
        1, _omitFieldNames ? '' : 'domainMappings', $pb.PbFieldType.PM,
        subBuilder: $9.DomainMapping.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListDomainMappingsResponse clone() =>
      ListDomainMappingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListDomainMappingsResponse copyWith(
          void Function(ListDomainMappingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListDomainMappingsResponse))
          as ListDomainMappingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListDomainMappingsResponse create() => ListDomainMappingsResponse._();
  ListDomainMappingsResponse createEmptyInstance() => create();
  static $pb.PbList<ListDomainMappingsResponse> createRepeated() =>
      $pb.PbList<ListDomainMappingsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListDomainMappingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDomainMappingsResponse>(create);
  static ListDomainMappingsResponse? _defaultInstance;

  /// The domain mappings for the application.
  @$pb.TagNumber(1)
  $core.List<$9.DomainMapping> get domainMappings => $_getList(0);

  /// Continuation token for fetching the next page of results.
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

/// Request message for `DomainMappings.GetDomainMapping`.
class GetDomainMappingRequest extends $pb.GeneratedMessage {
  factory GetDomainMappingRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetDomainMappingRequest._() : super();
  factory GetDomainMappingRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetDomainMappingRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDomainMappingRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetDomainMappingRequest clone() =>
      GetDomainMappingRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetDomainMappingRequest copyWith(
          void Function(GetDomainMappingRequest) updates) =>
      super.copyWith((message) => updates(message as GetDomainMappingRequest))
          as GetDomainMappingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDomainMappingRequest create() => GetDomainMappingRequest._();
  GetDomainMappingRequest createEmptyInstance() => create();
  static $pb.PbList<GetDomainMappingRequest> createRepeated() =>
      $pb.PbList<GetDomainMappingRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDomainMappingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDomainMappingRequest>(create);
  static GetDomainMappingRequest? _defaultInstance;

  /// Name of the resource requested. Example:
  /// `apps/myapp/domainMappings/example.com`.
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

/// Request message for `DomainMappings.CreateDomainMapping`.
class CreateDomainMappingRequest extends $pb.GeneratedMessage {
  factory CreateDomainMappingRequest({
    $core.String? parent,
    $9.DomainMapping? domainMapping,
    DomainOverrideStrategy? overrideStrategy,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (domainMapping != null) {
      $result.domainMapping = domainMapping;
    }
    if (overrideStrategy != null) {
      $result.overrideStrategy = overrideStrategy;
    }
    return $result;
  }
  CreateDomainMappingRequest._() : super();
  factory CreateDomainMappingRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateDomainMappingRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateDomainMappingRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$9.DomainMapping>(2, _omitFieldNames ? '' : 'domainMapping',
        subBuilder: $9.DomainMapping.create)
    ..e<DomainOverrideStrategy>(
        4, _omitFieldNames ? '' : 'overrideStrategy', $pb.PbFieldType.OE,
        defaultOrMaker:
            DomainOverrideStrategy.UNSPECIFIED_DOMAIN_OVERRIDE_STRATEGY,
        valueOf: DomainOverrideStrategy.valueOf,
        enumValues: DomainOverrideStrategy.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateDomainMappingRequest clone() =>
      CreateDomainMappingRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateDomainMappingRequest copyWith(
          void Function(CreateDomainMappingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateDomainMappingRequest))
          as CreateDomainMappingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateDomainMappingRequest create() => CreateDomainMappingRequest._();
  CreateDomainMappingRequest createEmptyInstance() => create();
  static $pb.PbList<CreateDomainMappingRequest> createRepeated() =>
      $pb.PbList<CreateDomainMappingRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateDomainMappingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateDomainMappingRequest>(create);
  static CreateDomainMappingRequest? _defaultInstance;

  /// Name of the parent Application resource. Example: `apps/myapp`.
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

  /// Domain mapping configuration.
  @$pb.TagNumber(2)
  $9.DomainMapping get domainMapping => $_getN(1);
  @$pb.TagNumber(2)
  set domainMapping($9.DomainMapping v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDomainMapping() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomainMapping() => clearField(2);
  @$pb.TagNumber(2)
  $9.DomainMapping ensureDomainMapping() => $_ensure(1);

  /// Whether the domain creation should override any existing mappings for this
  /// domain. By default, overrides are rejected.
  @$pb.TagNumber(4)
  DomainOverrideStrategy get overrideStrategy => $_getN(2);
  @$pb.TagNumber(4)
  set overrideStrategy(DomainOverrideStrategy v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOverrideStrategy() => $_has(2);
  @$pb.TagNumber(4)
  void clearOverrideStrategy() => clearField(4);
}

/// Request message for `DomainMappings.UpdateDomainMapping`.
class UpdateDomainMappingRequest extends $pb.GeneratedMessage {
  factory UpdateDomainMappingRequest({
    $core.String? name,
    $9.DomainMapping? domainMapping,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (domainMapping != null) {
      $result.domainMapping = domainMapping;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateDomainMappingRequest._() : super();
  factory UpdateDomainMappingRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateDomainMappingRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDomainMappingRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$9.DomainMapping>(2, _omitFieldNames ? '' : 'domainMapping',
        subBuilder: $9.DomainMapping.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateDomainMappingRequest clone() =>
      UpdateDomainMappingRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateDomainMappingRequest copyWith(
          void Function(UpdateDomainMappingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateDomainMappingRequest))
          as UpdateDomainMappingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDomainMappingRequest create() => UpdateDomainMappingRequest._();
  UpdateDomainMappingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateDomainMappingRequest> createRepeated() =>
      $pb.PbList<UpdateDomainMappingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateDomainMappingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDomainMappingRequest>(create);
  static UpdateDomainMappingRequest? _defaultInstance;

  /// Name of the resource to update. Example:
  /// `apps/myapp/domainMappings/example.com`.
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

  /// A domain mapping containing the updated resource. Only fields set
  /// in the field mask will be updated.
  @$pb.TagNumber(2)
  $9.DomainMapping get domainMapping => $_getN(1);
  @$pb.TagNumber(2)
  set domainMapping($9.DomainMapping v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDomainMapping() => $_has(1);
  @$pb.TagNumber(2)
  void clearDomainMapping() => clearField(2);
  @$pb.TagNumber(2)
  $9.DomainMapping ensureDomainMapping() => $_ensure(1);

  /// Standard field mask for the set of fields to be updated.
  @$pb.TagNumber(3)
  $58.FieldMask get updateMask => $_getN(2);
  @$pb.TagNumber(3)
  set updateMask($58.FieldMask v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasUpdateMask() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateMask() => clearField(3);
  @$pb.TagNumber(3)
  $58.FieldMask ensureUpdateMask() => $_ensure(2);
}

/// Request message for `DomainMappings.DeleteDomainMapping`.
class DeleteDomainMappingRequest extends $pb.GeneratedMessage {
  factory DeleteDomainMappingRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteDomainMappingRequest._() : super();
  factory DeleteDomainMappingRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteDomainMappingRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteDomainMappingRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteDomainMappingRequest clone() =>
      DeleteDomainMappingRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteDomainMappingRequest copyWith(
          void Function(DeleteDomainMappingRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteDomainMappingRequest))
          as DeleteDomainMappingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteDomainMappingRequest create() => DeleteDomainMappingRequest._();
  DeleteDomainMappingRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteDomainMappingRequest> createRepeated() =>
      $pb.PbList<DeleteDomainMappingRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteDomainMappingRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteDomainMappingRequest>(create);
  static DeleteDomainMappingRequest? _defaultInstance;

  /// Name of the resource to delete. Example:
  /// `apps/myapp/domainMappings/example.com`.
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

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
