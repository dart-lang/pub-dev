//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/serviceusage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'resources.pb.dart' as $38;
import 'serviceusage.pbenum.dart';

export 'serviceusage.pbenum.dart';

/// Request message for the `EnableService` method.
class EnableServiceRequest extends $pb.GeneratedMessage {
  factory EnableServiceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  EnableServiceRequest._() : super();
  factory EnableServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnableServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnableServiceRequest clone() =>
      EnableServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnableServiceRequest copyWith(void Function(EnableServiceRequest) updates) =>
      super.copyWith((message) => updates(message as EnableServiceRequest))
          as EnableServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableServiceRequest create() => EnableServiceRequest._();
  EnableServiceRequest createEmptyInstance() => create();
  static $pb.PbList<EnableServiceRequest> createRepeated() =>
      $pb.PbList<EnableServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableServiceRequest>(create);
  static EnableServiceRequest? _defaultInstance;

  ///  Name of the consumer and service to enable the service on.
  ///
  ///  The `EnableService` and `DisableService` methods currently only support
  ///  projects.
  ///
  ///  Enabling a service requires that the service is public or is shared with
  ///  the user enabling the service.
  ///
  ///  An example name would be:
  ///  `projects/123/services/serviceusage.googleapis.com` where `123` is the
  ///  project number.
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

/// Response message for the `EnableService` method.
/// This response message is assigned to the `response` field of the returned
/// Operation when that operation is done.
class EnableServiceResponse extends $pb.GeneratedMessage {
  factory EnableServiceResponse({
    $38.Service? service,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    return $result;
  }
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOM<$38.Service>(1, _omitFieldNames ? '' : 'service',
        subBuilder: $38.Service.create)
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

  /// The new state of the service after enabling.
  @$pb.TagNumber(1)
  $38.Service get service => $_getN(0);
  @$pb.TagNumber(1)
  set service($38.Service v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);
  @$pb.TagNumber(1)
  $38.Service ensureService() => $_ensure(0);
}

/// Request message for the `DisableService` method.
class DisableServiceRequest extends $pb.GeneratedMessage {
  factory DisableServiceRequest({
    $core.String? name,
    $core.bool? disableDependentServices,
    DisableServiceRequest_CheckIfServiceHasUsage? checkIfServiceHasUsage,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (disableDependentServices != null) {
      $result.disableDependentServices = disableDependentServices;
    }
    if (checkIfServiceHasUsage != null) {
      $result.checkIfServiceHasUsage = checkIfServiceHasUsage;
    }
    return $result;
  }
  DisableServiceRequest._() : super();
  factory DisableServiceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisableServiceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableServiceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'disableDependentServices')
    ..e<DisableServiceRequest_CheckIfServiceHasUsage>(
        3, _omitFieldNames ? '' : 'checkIfServiceHasUsage', $pb.PbFieldType.OE,
        defaultOrMaker: DisableServiceRequest_CheckIfServiceHasUsage
            .CHECK_IF_SERVICE_HAS_USAGE_UNSPECIFIED,
        valueOf: DisableServiceRequest_CheckIfServiceHasUsage.valueOf,
        enumValues: DisableServiceRequest_CheckIfServiceHasUsage.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisableServiceRequest clone() =>
      DisableServiceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisableServiceRequest copyWith(
          void Function(DisableServiceRequest) updates) =>
      super.copyWith((message) => updates(message as DisableServiceRequest))
          as DisableServiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableServiceRequest create() => DisableServiceRequest._();
  DisableServiceRequest createEmptyInstance() => create();
  static $pb.PbList<DisableServiceRequest> createRepeated() =>
      $pb.PbList<DisableServiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableServiceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableServiceRequest>(create);
  static DisableServiceRequest? _defaultInstance;

  ///  Name of the consumer and service to disable the service on.
  ///
  ///  The enable and disable methods currently only support projects.
  ///
  ///  An example name would be:
  ///  `projects/123/services/serviceusage.googleapis.com` where `123` is the
  ///  project number.
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

  /// Indicates if services that are enabled and which depend on this service
  /// should also be disabled. If not set, an error will be generated if any
  /// enabled services depend on the service to be disabled. When set, the
  /// service, and any enabled services that depend on it, will be disabled
  /// together.
  @$pb.TagNumber(2)
  $core.bool get disableDependentServices => $_getBF(1);
  @$pb.TagNumber(2)
  set disableDependentServices($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasDisableDependentServices() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisableDependentServices() => clearField(2);

  /// Defines the behavior for checking service usage when disabling a service.
  @$pb.TagNumber(3)
  DisableServiceRequest_CheckIfServiceHasUsage get checkIfServiceHasUsage =>
      $_getN(2);
  @$pb.TagNumber(3)
  set checkIfServiceHasUsage(DisableServiceRequest_CheckIfServiceHasUsage v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCheckIfServiceHasUsage() => $_has(2);
  @$pb.TagNumber(3)
  void clearCheckIfServiceHasUsage() => clearField(3);
}

/// Response message for the `DisableService` method.
/// This response message is assigned to the `response` field of the returned
/// Operation when that operation is done.
class DisableServiceResponse extends $pb.GeneratedMessage {
  factory DisableServiceResponse({
    $38.Service? service,
  }) {
    final $result = create();
    if (service != null) {
      $result.service = service;
    }
    return $result;
  }
  DisableServiceResponse._() : super();
  factory DisableServiceResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisableServiceResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableServiceResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOM<$38.Service>(1, _omitFieldNames ? '' : 'service',
        subBuilder: $38.Service.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisableServiceResponse clone() =>
      DisableServiceResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisableServiceResponse copyWith(
          void Function(DisableServiceResponse) updates) =>
      super.copyWith((message) => updates(message as DisableServiceResponse))
          as DisableServiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableServiceResponse create() => DisableServiceResponse._();
  DisableServiceResponse createEmptyInstance() => create();
  static $pb.PbList<DisableServiceResponse> createRepeated() =>
      $pb.PbList<DisableServiceResponse>();
  @$core.pragma('dart2js:noInline')
  static DisableServiceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableServiceResponse>(create);
  static DisableServiceResponse? _defaultInstance;

  /// The new state of the service after disabling.
  @$pb.TagNumber(1)
  $38.Service get service => $_getN(0);
  @$pb.TagNumber(1)
  set service($38.Service v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasService() => $_has(0);
  @$pb.TagNumber(1)
  void clearService() => clearField(1);
  @$pb.TagNumber(1)
  $38.Service ensureService() => $_ensure(0);
}

/// Request message for the `GetService` method.
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
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

  ///  Name of the consumer and service to get the `ConsumerState` for.
  ///
  ///  An example name would be:
  ///  `projects/123/services/serviceusage.googleapis.com` where `123` is the
  ///  project number.
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

/// Request message for the `ListServices` method.
class ListServicesRequest extends $pb.GeneratedMessage {
  factory ListServicesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.String? filter,
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
    if (filter != null) {
      $result.filter = filter;
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOS(4, _omitFieldNames ? '' : 'filter')
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

  ///  Parent to search for services on.
  ///
  ///  An example name would be:
  ///  `projects/123` where `123` is the project number.
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

  /// Requested size of the next page of data.
  /// Requested page size cannot exceed 200.
  /// If not set, the default page size is 50.
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

  /// Token identifying which result to start with, which is returned by a
  /// previous list call.
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

  /// Only list services that conform to the given filter.
  /// The allowed filter strings are `state:ENABLED` and `state:DISABLED`.
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

/// Response message for the `ListServices` method.
class ListServicesResponse extends $pb.GeneratedMessage {
  factory ListServicesResponse({
    $core.Iterable<$38.Service>? services,
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..pc<$38.Service>(1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $38.Service.create)
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

  /// The available services for the requested project.
  @$pb.TagNumber(1)
  $core.List<$38.Service> get services => $_getList(0);

  /// Token that can be passed to `ListServices` to resume a paginated
  /// query.
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

/// Request message for the `BatchEnableServices` method.
class BatchEnableServicesRequest extends $pb.GeneratedMessage {
  factory BatchEnableServicesRequest({
    $core.String? parent,
    $core.Iterable<$core.String>? serviceIds,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (serviceIds != null) {
      $result.serviceIds.addAll(serviceIds);
    }
    return $result;
  }
  BatchEnableServicesRequest._() : super();
  factory BatchEnableServicesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchEnableServicesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchEnableServicesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..pPS(2, _omitFieldNames ? '' : 'serviceIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchEnableServicesRequest clone() =>
      BatchEnableServicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchEnableServicesRequest copyWith(
          void Function(BatchEnableServicesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as BatchEnableServicesRequest))
          as BatchEnableServicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesRequest create() => BatchEnableServicesRequest._();
  BatchEnableServicesRequest createEmptyInstance() => create();
  static $pb.PbList<BatchEnableServicesRequest> createRepeated() =>
      $pb.PbList<BatchEnableServicesRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchEnableServicesRequest>(create);
  static BatchEnableServicesRequest? _defaultInstance;

  ///  Parent to enable services on.
  ///
  ///  An example name would be:
  ///  `projects/123` where `123` is the project number.
  ///
  ///  The `BatchEnableServices` method currently only supports projects.
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

  ///  The identifiers of the services to enable on the project.
  ///
  ///  A valid identifier would be:
  ///  serviceusage.googleapis.com
  ///
  ///  Enabling services requires that each service is public or is shared with
  ///  the user enabling the service.
  ///
  ///  A single request can enable a maximum of 20 services at a time. If more
  ///  than 20 services are specified, the request will fail, and no state changes
  ///  will occur.
  @$pb.TagNumber(2)
  $core.List<$core.String> get serviceIds => $_getList(1);
}

/// Provides error messages for the failing services.
class BatchEnableServicesResponse_EnableFailure extends $pb.GeneratedMessage {
  factory BatchEnableServicesResponse_EnableFailure({
    $core.String? serviceId,
    $core.String? errorMessage,
  }) {
    final $result = create();
    if (serviceId != null) {
      $result.serviceId = serviceId;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    return $result;
  }
  BatchEnableServicesResponse_EnableFailure._() : super();
  factory BatchEnableServicesResponse_EnableFailure.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchEnableServicesResponse_EnableFailure.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchEnableServicesResponse.EnableFailure',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'serviceId')
    ..aOS(2, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchEnableServicesResponse_EnableFailure clone() =>
      BatchEnableServicesResponse_EnableFailure()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchEnableServicesResponse_EnableFailure copyWith(
          void Function(BatchEnableServicesResponse_EnableFailure) updates) =>
      super.copyWith((message) =>
              updates(message as BatchEnableServicesResponse_EnableFailure))
          as BatchEnableServicesResponse_EnableFailure;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesResponse_EnableFailure create() =>
      BatchEnableServicesResponse_EnableFailure._();
  BatchEnableServicesResponse_EnableFailure createEmptyInstance() => create();
  static $pb.PbList<BatchEnableServicesResponse_EnableFailure>
      createRepeated() =>
          $pb.PbList<BatchEnableServicesResponse_EnableFailure>();
  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesResponse_EnableFailure getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          BatchEnableServicesResponse_EnableFailure>(create);
  static BatchEnableServicesResponse_EnableFailure? _defaultInstance;

  /// The service id of a service that could not be enabled.
  @$pb.TagNumber(1)
  $core.String get serviceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set serviceId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceId() => clearField(1);

  /// An error message describing why the service could not be enabled.
  @$pb.TagNumber(2)
  $core.String get errorMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set errorMessage($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasErrorMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorMessage() => clearField(2);
}

/// Response message for the `BatchEnableServices` method.
/// This response message is assigned to the `response` field of the returned
/// Operation when that operation is done.
class BatchEnableServicesResponse extends $pb.GeneratedMessage {
  factory BatchEnableServicesResponse({
    $core.Iterable<$38.Service>? services,
    $core.Iterable<BatchEnableServicesResponse_EnableFailure>? failures,
  }) {
    final $result = create();
    if (services != null) {
      $result.services.addAll(services);
    }
    if (failures != null) {
      $result.failures.addAll(failures);
    }
    return $result;
  }
  BatchEnableServicesResponse._() : super();
  factory BatchEnableServicesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchEnableServicesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchEnableServicesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..pc<$38.Service>(1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $38.Service.create)
    ..pc<BatchEnableServicesResponse_EnableFailure>(
        2, _omitFieldNames ? '' : 'failures', $pb.PbFieldType.PM,
        subBuilder: BatchEnableServicesResponse_EnableFailure.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchEnableServicesResponse clone() =>
      BatchEnableServicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchEnableServicesResponse copyWith(
          void Function(BatchEnableServicesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as BatchEnableServicesResponse))
          as BatchEnableServicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesResponse create() =>
      BatchEnableServicesResponse._();
  BatchEnableServicesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchEnableServicesResponse> createRepeated() =>
      $pb.PbList<BatchEnableServicesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchEnableServicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchEnableServicesResponse>(create);
  static BatchEnableServicesResponse? _defaultInstance;

  /// The new state of the services after enabling.
  @$pb.TagNumber(1)
  $core.List<$38.Service> get services => $_getList(0);

  /// If allow_partial_success is true, and one or more services could not be
  /// enabled, this field contains the details about each failure.
  @$pb.TagNumber(2)
  $core.List<BatchEnableServicesResponse_EnableFailure> get failures =>
      $_getList(1);
}

/// Request message for the `BatchGetServices` method.
class BatchGetServicesRequest extends $pb.GeneratedMessage {
  factory BatchGetServicesRequest({
    $core.String? parent,
    $core.Iterable<$core.String>? names,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (names != null) {
      $result.names.addAll(names);
    }
    return $result;
  }
  BatchGetServicesRequest._() : super();
  factory BatchGetServicesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchGetServicesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchGetServicesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..pPS(2, _omitFieldNames ? '' : 'names')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchGetServicesRequest clone() =>
      BatchGetServicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchGetServicesRequest copyWith(
          void Function(BatchGetServicesRequest) updates) =>
      super.copyWith((message) => updates(message as BatchGetServicesRequest))
          as BatchGetServicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetServicesRequest create() => BatchGetServicesRequest._();
  BatchGetServicesRequest createEmptyInstance() => create();
  static $pb.PbList<BatchGetServicesRequest> createRepeated() =>
      $pb.PbList<BatchGetServicesRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchGetServicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchGetServicesRequest>(create);
  static BatchGetServicesRequest? _defaultInstance;

  /// Parent to retrieve services from.
  /// If this is set, the parent of all of the services specified in `names` must
  /// match this field. An example name would be: `projects/123` where `123` is
  /// the project number. The `BatchGetServices` method currently only supports
  /// projects.
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

  ///  Names of the services to retrieve.
  ///
  ///  An example name would be:
  ///  `projects/123/services/serviceusage.googleapis.com` where `123` is the
  ///  project number.
  ///  A single request can get a maximum of 30 services at a time.
  @$pb.TagNumber(2)
  $core.List<$core.String> get names => $_getList(1);
}

/// Response message for the `BatchGetServices` method.
class BatchGetServicesResponse extends $pb.GeneratedMessage {
  factory BatchGetServicesResponse({
    $core.Iterable<$38.Service>? services,
  }) {
    final $result = create();
    if (services != null) {
      $result.services.addAll(services);
    }
    return $result;
  }
  BatchGetServicesResponse._() : super();
  factory BatchGetServicesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchGetServicesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchGetServicesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1'),
      createEmptyInstance: create)
    ..pc<$38.Service>(1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $38.Service.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchGetServicesResponse clone() =>
      BatchGetServicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchGetServicesResponse copyWith(
          void Function(BatchGetServicesResponse) updates) =>
      super.copyWith((message) => updates(message as BatchGetServicesResponse))
          as BatchGetServicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchGetServicesResponse create() => BatchGetServicesResponse._();
  BatchGetServicesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchGetServicesResponse> createRepeated() =>
      $pb.PbList<BatchGetServicesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchGetServicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchGetServicesResponse>(create);
  static BatchGetServicesResponse? _defaultInstance;

  /// The requested Service states.
  @$pb.TagNumber(1)
  $core.List<$38.Service> get services => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
