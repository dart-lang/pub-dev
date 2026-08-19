//
//  Generated code. Do not modify.
//  source: google/api/servicemanagement/v1/servicemanager.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/any.pb.dart' as $49;
import '../../service.pb.dart' as $28;
import 'resources.pb.dart' as $27;
import 'servicemanager.pbenum.dart';

export 'servicemanager.pbenum.dart';

/// Request message for `ListServices` method.
class ListServicesRequest extends $pb.GeneratedMessage {
  factory ListServicesRequest({
    $core.String? producerProjectId,
    $core.int? pageSize,
    $core.String? pageToken,
    @$core.Deprecated('This field is deprecated.') $core.String? consumerId,
  }) {
    final $result = create();
    if (producerProjectId != null) {
      $result.producerProjectId = producerProjectId;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (consumerId != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.consumerId = consumerId;
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
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'producerProjectId')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'pageToken')
    ..aOS(7, _omitFieldNames ? '' : 'consumerId')
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

  /// Include services produced by the specified project.
  @$pb.TagNumber(1)
  $core.String get producerProjectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set producerProjectId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProducerProjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProducerProjectId() => clearField(1);

  /// The max number of items to include in the response list. Page size is 50
  /// if not specified. Maximum value is 500.
  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(5)
  set pageSize($core.int v) {
    $_setSignedInt32(1, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(5)
  void clearPageSize() => clearField(5);

  /// Token identifying which result to start with; returned by a previous list
  /// call.
  @$pb.TagNumber(6)
  $core.String get pageToken => $_getSZ(2);
  @$pb.TagNumber(6)
  set pageToken($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasPageToken() => $_has(2);
  @$pb.TagNumber(6)
  void clearPageToken() => clearField(6);

  ///  Include services consumed by the specified consumer.
  ///
  ///  The Google Service Management implementation accepts the following
  ///  forms:
  ///  - project:<project_id>
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.String get consumerId => $_getSZ(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  set consumerId($core.String v) {
    $_setString(3, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.bool hasConsumerId() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  void clearConsumerId() => clearField(7);
}

/// Response message for `ListServices` method.
class ListServicesResponse extends $pb.GeneratedMessage {
  factory ListServicesResponse({
    $core.Iterable<$27.ManagedService>? services,
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
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pc<$27.ManagedService>(
        1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $27.ManagedService.create)
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

  /// The returned services will only have the name field set.
  @$pb.TagNumber(1)
  $core.List<$27.ManagedService> get services => $_getList(0);

  /// Token that can be passed to `ListServices` to resume a paginated query.
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

/// Request message for `GetService` method.
class GetServiceRequest extends $pb.GeneratedMessage {
  factory GetServiceRequest({
    $core.String? serviceName,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
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
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
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

  /// Required. The name of the service.  See the `ServiceManager` overview for
  /// naming requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);
}

/// Request message for CreateService method.
class CreateServiceRequest extends $pb.GeneratedMessage {
  factory CreateServiceRequest({
    $27.ManagedService? service,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    return $result;
  }
  CreateServiceRequest._() : super();
  factory CreateServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOM<$27.ManagedService>(1, _omitFieldNames ? '' : 'service',
        subBuilder: $27.ManagedService.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateServiceRequest clone() =>
      CreateServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateServiceRequest copyWith(void Function(CreateServiceRequest) updates) =>
      super.copyWith((message) => updates(message as CreateServiceRequest))
          as CreateServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateServiceRequest create() => CreateServiceRequest._();
  CreateServiceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateServiceRequest> createRepeated() =>
      $pb.PbList<CreateServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateServiceRequest>(create);
  static CreateServiceRequest? _defaultInstance;

  /// Required. Initial values for the service resource.
  @$pb.TagNumber(1)
  $27.ManagedService get service => $_getN(0);
  @$pb.TagNumber(1)
  set service($27.ManagedService v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);
  @$pb.TagNumber(1)
  $27.ManagedService ensureService() => $_ensure(0);
}

/// Request message for DeleteService method.
class DeleteServiceRequest extends $pb.GeneratedMessage {
  factory DeleteServiceRequest({
    $core.String? serviceName,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
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
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
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

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);
}

/// Request message for UndeleteService method.
class UndeleteServiceRequest extends $pb.GeneratedMessage {
  factory UndeleteServiceRequest({
    $core.String? serviceName,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    return $result;
  }
  UndeleteServiceRequest._() : super();
  factory UndeleteServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteServiceRequest clone() =>
      UndeleteServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteServiceRequest copyWith(
          void Function(UndeleteServiceRequest) updates) =>
      super.copyWith((message) => updates(message as UndeleteServiceRequest))
          as UndeleteServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteServiceRequest create() => UndeleteServiceRequest._();
  UndeleteServiceRequest createEmptyInstance() => create();
  static $pb.PbList<UndeleteServiceRequest> createRepeated() =>
      $pb.PbList<UndeleteServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static UndeleteServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndeleteServiceRequest>(create);
  static UndeleteServiceRequest? _defaultInstance;

  /// Required. The name of the service. See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements. For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);
}

/// Response message for UndeleteService method.
class UndeleteServiceResponse extends $pb.GeneratedMessage {
  factory UndeleteServiceResponse({
    $27.ManagedService? service,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    return $result;
  }
  UndeleteServiceResponse._() : super();
  factory UndeleteServiceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteServiceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteServiceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOM<$27.ManagedService>(1, _omitFieldNames ? '' : 'service',
        subBuilder: $27.ManagedService.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteServiceResponse clone() =>
      UndeleteServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteServiceResponse copyWith(
          void Function(UndeleteServiceResponse) updates) =>
      super.copyWith((message) => updates(message as UndeleteServiceResponse))
          as UndeleteServiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteServiceResponse create() => UndeleteServiceResponse._();
  UndeleteServiceResponse createEmptyInstance() => create();
  static $pb.PbList<UndeleteServiceResponse> createRepeated() =>
      $pb.PbList<UndeleteServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static UndeleteServiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndeleteServiceResponse>(create);
  static UndeleteServiceResponse? _defaultInstance;

  /// Revived service resource.
  @$pb.TagNumber(1)
  $27.ManagedService get service => $_getN(0);
  @$pb.TagNumber(1)
  set service($27.ManagedService v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);
  @$pb.TagNumber(1)
  $27.ManagedService ensureService() => $_ensure(0);
}

/// Request message for GetServiceConfig method.
class GetServiceConfigRequest extends $pb.GeneratedMessage {
  factory GetServiceConfigRequest({
    $core.String? serviceName,
    $core.String? configId,
    GetServiceConfigRequest_ConfigView? view,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (configId != null) {
      $result.configId = configId;
    }
    if (view != null) {
      $result.view = view;
    }
    return $result;
  }
  GetServiceConfigRequest._() : super();
  factory GetServiceConfigRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceConfigRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceConfigRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'configId')
    ..e<GetServiceConfigRequest_ConfigView>(
        3, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: GetServiceConfigRequest_ConfigView.BASIC,
        valueOf: GetServiceConfigRequest_ConfigView.valueOf,
        enumValues: GetServiceConfigRequest_ConfigView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceConfigRequest clone() =>
      GetServiceConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceConfigRequest copyWith(
          void Function(GetServiceConfigRequest) updates) =>
      super.copyWith((message) => updates(message as GetServiceConfigRequest))
          as GetServiceConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceConfigRequest create() => GetServiceConfigRequest._();
  GetServiceConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceConfigRequest> createRepeated() =>
      $pb.PbList<GetServiceConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceConfigRequest>(create);
  static GetServiceConfigRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  ///  Required. The id of the service configuration resource.
  ///
  ///  This field must be specified for the server to return all fields, including
  ///  `SourceInfo`.
  @$pb.TagNumber(2)
  $core.String get configId => $_getSZ(1);
  @$pb.TagNumber(2)
  set configId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConfigId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfigId() => clearField(2);

  /// Specifies which parts of the Service Config should be returned in the
  /// response.
  @$pb.TagNumber(3)
  GetServiceConfigRequest_ConfigView get view => $_getN(2);
  @$pb.TagNumber(3)
  set view(GetServiceConfigRequest_ConfigView v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasView() => $_has(2);
  @$pb.TagNumber(3)
  void clearView() => clearField(3);
}

/// Request message for ListServiceConfigs method.
class ListServiceConfigsRequest extends $pb.GeneratedMessage {
  factory ListServiceConfigsRequest({
    $core.String? serviceName,
    $core.String? pageToken,
    $core.int? pageSize,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    return $result;
  }
  ListServiceConfigsRequest._() : super();
  factory ListServiceConfigsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceConfigsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceConfigsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceConfigsRequest clone() =>
      ListServiceConfigsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceConfigsRequest copyWith(
          void Function(ListServiceConfigsRequest) updates) =>
      super.copyWith((message) => updates(message as ListServiceConfigsRequest))
          as ListServiceConfigsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceConfigsRequest create() => ListServiceConfigsRequest._();
  ListServiceConfigsRequest createEmptyInstance() => create();
  static $pb.PbList<ListServiceConfigsRequest> createRepeated() =>
      $pb.PbList<ListServiceConfigsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListServiceConfigsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceConfigsRequest>(create);
  static ListServiceConfigsRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// The token of the page to retrieve.
  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  /// The max number of items to include in the response list. Page size is 50
  /// if not specified. Maximum value is 100.
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
}

/// Response message for ListServiceConfigs method.
class ListServiceConfigsResponse extends $pb.GeneratedMessage {
  factory ListServiceConfigsResponse({
    $core.Iterable<$28.Service>? serviceConfigs,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (serviceConfigs != null) {
      $result.serviceConfigs.addAll(serviceConfigs);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListServiceConfigsResponse._() : super();
  factory ListServiceConfigsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceConfigsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceConfigsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pc<$28.Service>(
        1, _omitFieldNames ? '' : 'serviceConfigs', $pb.PbFieldType.PM,
        subBuilder: $28.Service.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceConfigsResponse clone() =>
      ListServiceConfigsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceConfigsResponse copyWith(
          void Function(ListServiceConfigsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceConfigsResponse))
          as ListServiceConfigsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceConfigsResponse create() => ListServiceConfigsResponse._();
  ListServiceConfigsResponse createEmptyInstance() => create();
  static $pb.PbList<ListServiceConfigsResponse> createRepeated() =>
      $pb.PbList<ListServiceConfigsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListServiceConfigsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceConfigsResponse>(create);
  static ListServiceConfigsResponse? _defaultInstance;

  /// The list of service configuration resources.
  @$pb.TagNumber(1)
  $core.List<$28.Service> get serviceConfigs => $_getList(0);

  /// The token of the next page of results.
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

/// Request message for CreateServiceConfig method.
class CreateServiceConfigRequest extends $pb.GeneratedMessage {
  factory CreateServiceConfigRequest({
    $core.String? serviceName,
    $28.Service? serviceConfig,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (serviceConfig != null) {
      $result.serviceConfig = serviceConfig;
    }
    return $result;
  }
  CreateServiceConfigRequest._() : super();
  factory CreateServiceConfigRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateServiceConfigRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateServiceConfigRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOM<$28.Service>(2, _omitFieldNames ? '' : 'serviceConfig',
        subBuilder: $28.Service.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateServiceConfigRequest clone() =>
      CreateServiceConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateServiceConfigRequest copyWith(
          void Function(CreateServiceConfigRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateServiceConfigRequest))
          as CreateServiceConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateServiceConfigRequest create() => CreateServiceConfigRequest._();
  CreateServiceConfigRequest createEmptyInstance() => create();
  static $pb.PbList<CreateServiceConfigRequest> createRepeated() =>
      $pb.PbList<CreateServiceConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateServiceConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateServiceConfigRequest>(create);
  static CreateServiceConfigRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Required. The service configuration resource.
  @$pb.TagNumber(2)
  $28.Service get serviceConfig => $_getN(1);
  @$pb.TagNumber(2)
  set serviceConfig($28.Service v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasServiceConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearServiceConfig() => clearField(2);
  @$pb.TagNumber(2)
  $28.Service ensureServiceConfig() => $_ensure(1);
}

/// Request message for SubmitConfigSource method.
class SubmitConfigSourceRequest extends $pb.GeneratedMessage {
  factory SubmitConfigSourceRequest({
    $core.String? serviceName,
    $27.ConfigSource? configSource,
    $core.bool? validateOnly,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (configSource != null) {
      $result.configSource = configSource;
    }
    if (validateOnly != null) {
      $result.validateOnly = validateOnly;
    }
    return $result;
  }
  SubmitConfigSourceRequest._() : super();
  factory SubmitConfigSourceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubmitConfigSourceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitConfigSourceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOM<$27.ConfigSource>(2, _omitFieldNames ? '' : 'configSource',
        subBuilder: $27.ConfigSource.create)
    ..aOB(3, _omitFieldNames ? '' : 'validateOnly')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubmitConfigSourceRequest clone() =>
      SubmitConfigSourceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubmitConfigSourceRequest copyWith(
          void Function(SubmitConfigSourceRequest) updates) =>
      super.copyWith((message) => updates(message as SubmitConfigSourceRequest))
          as SubmitConfigSourceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitConfigSourceRequest create() => SubmitConfigSourceRequest._();
  SubmitConfigSourceRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitConfigSourceRequest> createRepeated() =>
      $pb.PbList<SubmitConfigSourceRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitConfigSourceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitConfigSourceRequest>(create);
  static SubmitConfigSourceRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Required. The source configuration for the service.
  @$pb.TagNumber(2)
  $27.ConfigSource get configSource => $_getN(1);
  @$pb.TagNumber(2)
  set configSource($27.ConfigSource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasConfigSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfigSource() => clearField(2);
  @$pb.TagNumber(2)
  $27.ConfigSource ensureConfigSource() => $_ensure(1);

  /// Optional. If set, this will result in the generation of a
  /// `google.api.Service` configuration based on the `ConfigSource` provided,
  /// but the generated config and the sources will NOT be persisted.
  @$pb.TagNumber(3)
  $core.bool get validateOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set validateOnly($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasValidateOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearValidateOnly() => clearField(3);
}

/// Response message for SubmitConfigSource method.
class SubmitConfigSourceResponse extends $pb.GeneratedMessage {
  factory SubmitConfigSourceResponse({
    $28.Service? serviceConfig,
  }) {
    final $result = create();
    if (serviceConfig != null) {
      $result.serviceConfig = serviceConfig;
    }
    return $result;
  }
  SubmitConfigSourceResponse._() : super();
  factory SubmitConfigSourceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SubmitConfigSourceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitConfigSourceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOM<$28.Service>(1, _omitFieldNames ? '' : 'serviceConfig',
        subBuilder: $28.Service.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SubmitConfigSourceResponse clone() =>
      SubmitConfigSourceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SubmitConfigSourceResponse copyWith(
          void Function(SubmitConfigSourceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitConfigSourceResponse))
          as SubmitConfigSourceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitConfigSourceResponse create() => SubmitConfigSourceResponse._();
  SubmitConfigSourceResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitConfigSourceResponse> createRepeated() =>
      $pb.PbList<SubmitConfigSourceResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitConfigSourceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitConfigSourceResponse>(create);
  static SubmitConfigSourceResponse? _defaultInstance;

  /// The generated service configuration.
  @$pb.TagNumber(1)
  $28.Service get serviceConfig => $_getN(0);
  @$pb.TagNumber(1)
  set serviceConfig($28.Service v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceConfig() => clearField(1);
  @$pb.TagNumber(1)
  $28.Service ensureServiceConfig() => $_ensure(0);
}

///
///  Request message for 'CreateServiceRollout'
class CreateServiceRolloutRequest extends $pb.GeneratedMessage {
  factory CreateServiceRolloutRequest({
    $core.String? serviceName,
    $27.Rollout? rollout,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (rollout != null) {
      $result.rollout = rollout;
    }
    return $result;
  }
  CreateServiceRolloutRequest._() : super();
  factory CreateServiceRolloutRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateServiceRolloutRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateServiceRolloutRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOM<$27.Rollout>(2, _omitFieldNames ? '' : 'rollout',
        subBuilder: $27.Rollout.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateServiceRolloutRequest clone() =>
      CreateServiceRolloutRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateServiceRolloutRequest copyWith(
          void Function(CreateServiceRolloutRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateServiceRolloutRequest))
          as CreateServiceRolloutRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateServiceRolloutRequest create() =>
      CreateServiceRolloutRequest._();
  CreateServiceRolloutRequest createEmptyInstance() => create();
  static $pb.PbList<CreateServiceRolloutRequest> createRepeated() =>
      $pb.PbList<CreateServiceRolloutRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateServiceRolloutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateServiceRolloutRequest>(create);
  static CreateServiceRolloutRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Required. The rollout resource. The `service_name` field is output only.
  @$pb.TagNumber(2)
  $27.Rollout get rollout => $_getN(1);
  @$pb.TagNumber(2)
  set rollout($27.Rollout v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRollout() => $_has(1);
  @$pb.TagNumber(2)
  void clearRollout() => clearField(2);
  @$pb.TagNumber(2)
  $27.Rollout ensureRollout() => $_ensure(1);
}

/// Request message for 'ListServiceRollouts'
class ListServiceRolloutsRequest extends $pb.GeneratedMessage {
  factory ListServiceRolloutsRequest({
    $core.String? serviceName,
    $core.String? pageToken,
    $core.int? pageSize,
    $core.String? filter,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (filter != null) {
      $result.filter = filter;
    }
    return $result;
  }
  ListServiceRolloutsRequest._() : super();
  factory ListServiceRolloutsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceRolloutsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceRolloutsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'pageToken')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'filter')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceRolloutsRequest clone() =>
      ListServiceRolloutsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceRolloutsRequest copyWith(
          void Function(ListServiceRolloutsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceRolloutsRequest))
          as ListServiceRolloutsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceRolloutsRequest create() => ListServiceRolloutsRequest._();
  ListServiceRolloutsRequest createEmptyInstance() => create();
  static $pb.PbList<ListServiceRolloutsRequest> createRepeated() =>
      $pb.PbList<ListServiceRolloutsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListServiceRolloutsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceRolloutsRequest>(create);
  static ListServiceRolloutsRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// The token of the page to retrieve.
  @$pb.TagNumber(2)
  $core.String get pageToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set pageToken($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageToken() => clearField(2);

  /// The max number of items to include in the response list. Page size is 50
  /// if not specified. Maximum value is 100.
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

  ///  Required. Use `filter` to return subset of rollouts.
  ///  The following filters are supported:
  ///
  ///   -- By [status]
  ///   [google.api.servicemanagement.v1.Rollout.RolloutStatus]. For example,
  ///   `filter='status=SUCCESS'`
  ///
  ///   -- By [strategy]
  ///   [google.api.servicemanagement.v1.Rollout.strategy]. For example,
  ///   `filter='strategy=TrafficPercentStrategy'`
  @$pb.TagNumber(4)
  $core.String get filter => $_getSZ(3);
  @$pb.TagNumber(4)
  set filter($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearFilter() => clearField(4);
}

/// Response message for ListServiceRollouts method.
class ListServiceRolloutsResponse extends $pb.GeneratedMessage {
  factory ListServiceRolloutsResponse({
    $core.Iterable<$27.Rollout>? rollouts,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (rollouts != null) {
      $result.rollouts.addAll(rollouts);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListServiceRolloutsResponse._() : super();
  factory ListServiceRolloutsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceRolloutsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceRolloutsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..pc<$27.Rollout>(1, _omitFieldNames ? '' : 'rollouts', $pb.PbFieldType.PM,
        subBuilder: $27.Rollout.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceRolloutsResponse clone() =>
      ListServiceRolloutsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceRolloutsResponse copyWith(
          void Function(ListServiceRolloutsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceRolloutsResponse))
          as ListServiceRolloutsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceRolloutsResponse create() =>
      ListServiceRolloutsResponse._();
  ListServiceRolloutsResponse createEmptyInstance() => create();
  static $pb.PbList<ListServiceRolloutsResponse> createRepeated() =>
      $pb.PbList<ListServiceRolloutsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListServiceRolloutsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceRolloutsResponse>(create);
  static ListServiceRolloutsResponse? _defaultInstance;

  /// The list of rollout resources.
  @$pb.TagNumber(1)
  $core.List<$27.Rollout> get rollouts => $_getList(0);

  /// The token of the next page of results.
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

/// Request message for GetServiceRollout method.
class GetServiceRolloutRequest extends $pb.GeneratedMessage {
  factory GetServiceRolloutRequest({
    $core.String? serviceName,
    $core.String? rolloutId,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (rolloutId != null) {
      $result.rolloutId = rolloutId;
    }
    return $result;
  }
  GetServiceRolloutRequest._() : super();
  factory GetServiceRolloutRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceRolloutRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceRolloutRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'rolloutId')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceRolloutRequest clone() =>
      GetServiceRolloutRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceRolloutRequest copyWith(
          void Function(GetServiceRolloutRequest) updates) =>
      super.copyWith((message) => updates(message as GetServiceRolloutRequest))
          as GetServiceRolloutRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceRolloutRequest create() => GetServiceRolloutRequest._();
  GetServiceRolloutRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceRolloutRequest> createRepeated() =>
      $pb.PbList<GetServiceRolloutRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceRolloutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceRolloutRequest>(create);
  static GetServiceRolloutRequest? _defaultInstance;

  /// Required. The name of the service.  See the
  /// [overview](https://cloud.google.com/service-management/overview) for naming
  /// requirements.  For example: `example.googleapis.com`.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// Required. The id of the rollout resource.
  @$pb.TagNumber(2)
  $core.String get rolloutId => $_getSZ(1);
  @$pb.TagNumber(2)
  set rolloutId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRolloutId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRolloutId() => clearField(2);
}

/// Operation payload for EnableService method.
class EnableServiceResponse extends $pb.GeneratedMessage {
  factory EnableServiceResponse() => create();
  EnableServiceResponse._() : super();
  factory EnableServiceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnableServiceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableServiceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnableServiceResponse clone() =>
      EnableServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnableServiceResponse copyWith(
          void Function(EnableServiceResponse) updates) =>
      super.copyWith((message) => updates(message as EnableServiceResponse))
          as EnableServiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableServiceResponse create() => EnableServiceResponse._();
  EnableServiceResponse createEmptyInstance() => create();
  static $pb.PbList<EnableServiceResponse> createRepeated() =>
      $pb.PbList<EnableServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static EnableServiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableServiceResponse>(create);
  static EnableServiceResponse? _defaultInstance;
}

/// Request message for GenerateConfigReport method.
class GenerateConfigReportRequest extends $pb.GeneratedMessage {
  factory GenerateConfigReportRequest({
    $49.Any? newConfig,
    $49.Any? oldConfig,
  }) {
    final $result = create();
    if (newConfig != null) {
      $result.newConfig = newConfig;
    }
    if (oldConfig != null) {
      $result.oldConfig = oldConfig;
    }
    return $result;
  }
  GenerateConfigReportRequest._() : super();
  factory GenerateConfigReportRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateConfigReportRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateConfigReportRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOM<$49.Any>(1, _omitFieldNames ? '' : 'newConfig',
        subBuilder: $49.Any.create)
    ..aOM<$49.Any>(2, _omitFieldNames ? '' : 'oldConfig',
        subBuilder: $49.Any.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateConfigReportRequest clone() =>
      GenerateConfigReportRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateConfigReportRequest copyWith(
          void Function(GenerateConfigReportRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateConfigReportRequest))
          as GenerateConfigReportRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateConfigReportRequest create() =>
      GenerateConfigReportRequest._();
  GenerateConfigReportRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateConfigReportRequest> createRepeated() =>
      $pb.PbList<GenerateConfigReportRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateConfigReportRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateConfigReportRequest>(create);
  static GenerateConfigReportRequest? _defaultInstance;

  /// Required. Service configuration for which we want to generate the report.
  /// For this version of API, the supported types are
  /// [google.api.servicemanagement.v1.ConfigRef][google.api.servicemanagement.v1.ConfigRef],
  /// [google.api.servicemanagement.v1.ConfigSource][google.api.servicemanagement.v1.ConfigSource],
  /// and [google.api.Service][google.api.Service]
  @$pb.TagNumber(1)
  $49.Any get newConfig => $_getN(0);
  @$pb.TagNumber(1)
  set newConfig($49.Any v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasNewConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewConfig() => clearField(1);
  @$pb.TagNumber(1)
  $49.Any ensureNewConfig() => $_ensure(0);

  /// Optional. Service configuration against which the comparison will be done.
  /// For this version of API, the supported types are
  /// [google.api.servicemanagement.v1.ConfigRef][google.api.servicemanagement.v1.ConfigRef],
  /// [google.api.servicemanagement.v1.ConfigSource][google.api.servicemanagement.v1.ConfigSource],
  /// and [google.api.Service][google.api.Service]
  @$pb.TagNumber(2)
  $49.Any get oldConfig => $_getN(1);
  @$pb.TagNumber(2)
  set oldConfig($49.Any v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOldConfig() => $_has(1);
  @$pb.TagNumber(2)
  void clearOldConfig() => clearField(2);
  @$pb.TagNumber(2)
  $49.Any ensureOldConfig() => $_ensure(1);
}

/// Response message for GenerateConfigReport method.
class GenerateConfigReportResponse extends $pb.GeneratedMessage {
  factory GenerateConfigReportResponse({
    $core.String? serviceName,
    $core.String? id,
    $core.Iterable<$27.ChangeReport>? changeReports,
    $core.Iterable<$27.Diagnostic>? diagnostics,
  }) {
    final $result = create();
    if (serviceName != null) {
      $result.serviceName = serviceName;
    }
    if (id != null) {
      $result.id = id;
    }
    if (changeReports != null) {
      $result.changeReports.addAll(changeReports);
    }
    if (diagnostics != null) {
      $result.diagnostics.addAll(diagnostics);
    }
    return $result;
  }
  GenerateConfigReportResponse._() : super();
  factory GenerateConfigReportResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateConfigReportResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateConfigReportResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.servicemanagement.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceName')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..pc<$27.ChangeReport>(
        3, _omitFieldNames ? '' : 'changeReports', $pb.PbFieldType.PM,
        subBuilder: $27.ChangeReport.create)
    ..pc<$27.Diagnostic>(
        4, _omitFieldNames ? '' : 'diagnostics', $pb.PbFieldType.PM,
        subBuilder: $27.Diagnostic.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateConfigReportResponse clone() =>
      GenerateConfigReportResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateConfigReportResponse copyWith(
          void Function(GenerateConfigReportResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateConfigReportResponse))
          as GenerateConfigReportResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateConfigReportResponse create() =>
      GenerateConfigReportResponse._();
  GenerateConfigReportResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateConfigReportResponse> createRepeated() =>
      $pb.PbList<GenerateConfigReportResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateConfigReportResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateConfigReportResponse>(create);
  static GenerateConfigReportResponse? _defaultInstance;

  /// Name of the service this report belongs to.
  @$pb.TagNumber(1)
  $core.String get serviceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceName() => clearField(1);

  /// ID of the service configuration this report belongs to.
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// list of ChangeReport, each corresponding to comparison between two
  /// service configurations.
  @$pb.TagNumber(3)
  $core.List<$27.ChangeReport> get changeReports => $_getList(2);

  /// Errors / Linter warnings associated with the service definition this
  /// report
  /// belongs to.
  @$pb.TagNumber(4)
  $core.List<$27.Diagnostic> get diagnostics => $_getList(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
