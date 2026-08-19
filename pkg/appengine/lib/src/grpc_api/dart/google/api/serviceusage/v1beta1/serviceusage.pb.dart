//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/serviceusage.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/field_mask.pb.dart' as $58;
import 'resources.pb.dart' as $40;
import 'resources.pbenum.dart' as $40;
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
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
  ///  `projects/123/services/serviceusage.googleapis.com`
  ///  where `123` is the project number (not project ID).
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

/// Request message for the `DisableService` method.
class DisableServiceRequest extends $pb.GeneratedMessage {
  factory DisableServiceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
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
  ///  `projects/123/services/serviceusage.googleapis.com`
  ///  where `123` is the project number (not project ID).
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
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
  ///  `projects/123/services/serviceusage.googleapis.com`
  ///  where `123` is the project number (not project ID).
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
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
  ///  `projects/123`
  ///  where `123` is the project number (not project ID).
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
  ///  If not set, the default page size is 50.
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
    $core.Iterable<$40.Service>? services,
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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.Service>(1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: $40.Service.create)
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
  $core.List<$40.Service> get services => $_getList(0);

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
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
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
  ///  `projects/123`
  ///  where `123` is the project number (not project ID).
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
  ///  Two or more services must be specified. To enable a single service,
  ///  use the `EnableService` method instead.
  ///
  ///  A single request can enable a maximum of 20 services at a time. If more
  ///  than 20 services are specified, the request will fail, and no state changes
  ///  will occur.
  @$pb.TagNumber(2)
  $core.List<$core.String> get serviceIds => $_getList(1);
}

/// Request message for ListConsumerQuotaMetrics
class ListConsumerQuotaMetricsRequest extends $pb.GeneratedMessage {
  factory ListConsumerQuotaMetricsRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $40.QuotaView? view,
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
  ListConsumerQuotaMetricsRequest._() : super();
  factory ListConsumerQuotaMetricsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListConsumerQuotaMetricsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListConsumerQuotaMetricsRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..e<$40.QuotaView>(4, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: $40.QuotaView.QUOTA_VIEW_UNSPECIFIED,
        valueOf: $40.QuotaView.valueOf,
        enumValues: $40.QuotaView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListConsumerQuotaMetricsRequest clone() =>
      ListConsumerQuotaMetricsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListConsumerQuotaMetricsRequest copyWith(
          void Function(ListConsumerQuotaMetricsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListConsumerQuotaMetricsRequest))
          as ListConsumerQuotaMetricsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListConsumerQuotaMetricsRequest create() =>
      ListConsumerQuotaMetricsRequest._();
  ListConsumerQuotaMetricsRequest createEmptyInstance() => create();
  static $pb.PbList<ListConsumerQuotaMetricsRequest> createRepeated() =>
      $pb.PbList<ListConsumerQuotaMetricsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListConsumerQuotaMetricsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListConsumerQuotaMetricsRequest>(
          create);
  static ListConsumerQuotaMetricsRequest? _defaultInstance;

  ///  Parent of the quotas resource.
  ///
  ///  Some example names would be:
  ///  `projects/123/services/serviceconsumermanagement.googleapis.com`
  ///  `folders/345/services/serviceconsumermanagement.googleapis.com`
  ///  `organizations/456/services/serviceconsumermanagement.googleapis.com`
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

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

  /// Specifies the level of detail for quota information in the response.
  @$pb.TagNumber(4)
  $40.QuotaView get view => $_getN(3);
  @$pb.TagNumber(4)
  set view($40.QuotaView v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasView() => $_has(3);
  @$pb.TagNumber(4)
  void clearView() => clearField(4);
}

/// Response message for ListConsumerQuotaMetrics
class ListConsumerQuotaMetricsResponse extends $pb.GeneratedMessage {
  factory ListConsumerQuotaMetricsResponse({
    $core.Iterable<$40.ConsumerQuotaMetric>? metrics,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (metrics != null) {
      $result.metrics.addAll(metrics);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListConsumerQuotaMetricsResponse._() : super();
  factory ListConsumerQuotaMetricsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListConsumerQuotaMetricsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListConsumerQuotaMetricsResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.ConsumerQuotaMetric>(
        1, _omitFieldNames ? '' : 'metrics', $pb.PbFieldType.PM,
        subBuilder: $40.ConsumerQuotaMetric.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListConsumerQuotaMetricsResponse clone() =>
      ListConsumerQuotaMetricsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListConsumerQuotaMetricsResponse copyWith(
          void Function(ListConsumerQuotaMetricsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListConsumerQuotaMetricsResponse))
          as ListConsumerQuotaMetricsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListConsumerQuotaMetricsResponse create() =>
      ListConsumerQuotaMetricsResponse._();
  ListConsumerQuotaMetricsResponse createEmptyInstance() => create();
  static $pb.PbList<ListConsumerQuotaMetricsResponse> createRepeated() =>
      $pb.PbList<ListConsumerQuotaMetricsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListConsumerQuotaMetricsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListConsumerQuotaMetricsResponse>(
          create);
  static ListConsumerQuotaMetricsResponse? _defaultInstance;

  /// Quota settings for the consumer, organized by quota metric.
  @$pb.TagNumber(1)
  $core.List<$40.ConsumerQuotaMetric> get metrics => $_getList(0);

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

/// Request message for GetConsumerQuotaMetric
class GetConsumerQuotaMetricRequest extends $pb.GeneratedMessage {
  factory GetConsumerQuotaMetricRequest({
    $core.String? name,
    $40.QuotaView? view,
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
  GetConsumerQuotaMetricRequest._() : super();
  factory GetConsumerQuotaMetricRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetConsumerQuotaMetricRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetConsumerQuotaMetricRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<$40.QuotaView>(2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: $40.QuotaView.QUOTA_VIEW_UNSPECIFIED,
        valueOf: $40.QuotaView.valueOf,
        enumValues: $40.QuotaView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetConsumerQuotaMetricRequest clone() =>
      GetConsumerQuotaMetricRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetConsumerQuotaMetricRequest copyWith(
          void Function(GetConsumerQuotaMetricRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetConsumerQuotaMetricRequest))
          as GetConsumerQuotaMetricRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConsumerQuotaMetricRequest create() =>
      GetConsumerQuotaMetricRequest._();
  GetConsumerQuotaMetricRequest createEmptyInstance() => create();
  static $pb.PbList<GetConsumerQuotaMetricRequest> createRepeated() =>
      $pb.PbList<GetConsumerQuotaMetricRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConsumerQuotaMetricRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetConsumerQuotaMetricRequest>(create);
  static GetConsumerQuotaMetricRequest? _defaultInstance;

  ///  The resource name of the quota limit.
  ///
  ///  An example name would be:
  ///  `projects/123/services/serviceusage.googleapis.com/quotas/metrics/serviceusage.googleapis.com%2Fmutate_requests`
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

  /// Specifies the level of detail for quota information in the response.
  @$pb.TagNumber(2)
  $40.QuotaView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view($40.QuotaView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);
}

/// Request message for GetConsumerQuotaLimit
class GetConsumerQuotaLimitRequest extends $pb.GeneratedMessage {
  factory GetConsumerQuotaLimitRequest({
    $core.String? name,
    $40.QuotaView? view,
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
  GetConsumerQuotaLimitRequest._() : super();
  factory GetConsumerQuotaLimitRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetConsumerQuotaLimitRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetConsumerQuotaLimitRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<$40.QuotaView>(2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: $40.QuotaView.QUOTA_VIEW_UNSPECIFIED,
        valueOf: $40.QuotaView.valueOf,
        enumValues: $40.QuotaView.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetConsumerQuotaLimitRequest clone() =>
      GetConsumerQuotaLimitRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetConsumerQuotaLimitRequest copyWith(
          void Function(GetConsumerQuotaLimitRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetConsumerQuotaLimitRequest))
          as GetConsumerQuotaLimitRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetConsumerQuotaLimitRequest create() =>
      GetConsumerQuotaLimitRequest._();
  GetConsumerQuotaLimitRequest createEmptyInstance() => create();
  static $pb.PbList<GetConsumerQuotaLimitRequest> createRepeated() =>
      $pb.PbList<GetConsumerQuotaLimitRequest>();
  @$core.pragma('dart2js:noInline')
  static GetConsumerQuotaLimitRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetConsumerQuotaLimitRequest>(create);
  static GetConsumerQuotaLimitRequest? _defaultInstance;

  ///  The resource name of the quota limit.
  ///
  ///  Use the quota limit resource name returned by previous
  ///  ListConsumerQuotaMetrics and GetConsumerQuotaMetric API calls.
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

  /// Specifies the level of detail for quota information in the response.
  @$pb.TagNumber(2)
  $40.QuotaView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view($40.QuotaView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);
}

/// Request message for CreateAdminOverride.
class CreateAdminOverrideRequest extends $pb.GeneratedMessage {
  factory CreateAdminOverrideRequest({
    $core.String? parent,
    $40.QuotaOverride? override,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (override != null) {
      $result.override = override;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  CreateAdminOverrideRequest._() : super();
  factory CreateAdminOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAdminOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAdminOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$40.QuotaOverride>(2, _omitFieldNames ? '' : 'override',
        subBuilder: $40.QuotaOverride.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        4, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAdminOverrideRequest clone() =>
      CreateAdminOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAdminOverrideRequest copyWith(
          void Function(CreateAdminOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateAdminOverrideRequest))
          as CreateAdminOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAdminOverrideRequest create() => CreateAdminOverrideRequest._();
  CreateAdminOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<CreateAdminOverrideRequest> createRepeated() =>
      $pb.PbList<CreateAdminOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateAdminOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAdminOverrideRequest>(create);
  static CreateAdminOverrideRequest? _defaultInstance;

  ///  The resource name of the parent quota limit, returned by a
  ///  ListConsumerQuotaMetrics or GetConsumerQuotaMetric call.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion`
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

  /// The admin override to create.
  @$pb.TagNumber(2)
  $40.QuotaOverride get override => $_getN(1);
  @$pb.TagNumber(2)
  set override($40.QuotaOverride v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOverride() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverride() => clearField(2);
  @$pb.TagNumber(2)
  $40.QuotaOverride ensureOverride() => $_ensure(1);

  /// Whether to force the creation of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(4)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(3);
}

/// Request message for UpdateAdminOverride.
class UpdateAdminOverrideRequest extends $pb.GeneratedMessage {
  factory UpdateAdminOverrideRequest({
    $core.String? name,
    $40.QuotaOverride? override,
    $core.bool? force,
    $58.FieldMask? updateMask,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (override != null) {
      $result.override = override;
    }
    if (force != null) {
      $result.force = force;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  UpdateAdminOverrideRequest._() : super();
  factory UpdateAdminOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateAdminOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAdminOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$40.QuotaOverride>(2, _omitFieldNames ? '' : 'override',
        subBuilder: $40.QuotaOverride.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..aOM<$58.FieldMask>(4, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..pc<$40.QuotaSafetyCheck>(
        5, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateAdminOverrideRequest clone() =>
      UpdateAdminOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateAdminOverrideRequest copyWith(
          void Function(UpdateAdminOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateAdminOverrideRequest))
          as UpdateAdminOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAdminOverrideRequest create() => UpdateAdminOverrideRequest._();
  UpdateAdminOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateAdminOverrideRequest> createRepeated() =>
      $pb.PbList<UpdateAdminOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateAdminOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAdminOverrideRequest>(create);
  static UpdateAdminOverrideRequest? _defaultInstance;

  ///  The resource name of the override to update.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/adminOverrides/4a3f2c1d`
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

  /// The new override.
  /// Only the override_value is updated; all other fields are ignored.
  @$pb.TagNumber(2)
  $40.QuotaOverride get override => $_getN(1);
  @$pb.TagNumber(2)
  set override($40.QuotaOverride v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOverride() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverride() => clearField(2);
  @$pb.TagNumber(2)
  $40.QuotaOverride ensureOverride() => $_ensure(1);

  /// Whether to force the update of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// Update only the specified fields of the override.
  /// If unset, all fields will be updated.
  @$pb.TagNumber(4)
  $58.FieldMask get updateMask => $_getN(3);
  @$pb.TagNumber(4)
  set updateMask($58.FieldMask v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUpdateMask() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateMask() => clearField(4);
  @$pb.TagNumber(4)
  $58.FieldMask ensureUpdateMask() => $_ensure(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(5)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(4);
}

/// Request message for DeleteAdminOverride.
class DeleteAdminOverrideRequest extends $pb.GeneratedMessage {
  factory DeleteAdminOverrideRequest({
    $core.String? name,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  DeleteAdminOverrideRequest._() : super();
  factory DeleteAdminOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteAdminOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAdminOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        3, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteAdminOverrideRequest clone() =>
      DeleteAdminOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteAdminOverrideRequest copyWith(
          void Function(DeleteAdminOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteAdminOverrideRequest))
          as DeleteAdminOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAdminOverrideRequest create() => DeleteAdminOverrideRequest._();
  DeleteAdminOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAdminOverrideRequest> createRepeated() =>
      $pb.PbList<DeleteAdminOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAdminOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAdminOverrideRequest>(create);
  static DeleteAdminOverrideRequest? _defaultInstance;

  ///  The resource name of the override to delete.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/adminOverrides/4a3f2c1d`
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

  /// Whether to force the deletion of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(2)
  $core.bool get force => $_getBF(1);
  @$pb.TagNumber(2)
  set force($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearForce() => clearField(2);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(3)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(2);
}

/// Request message for ListAdminOverrides
class ListAdminOverridesRequest extends $pb.GeneratedMessage {
  factory ListAdminOverridesRequest({
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
  ListAdminOverridesRequest._() : super();
  factory ListAdminOverridesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAdminOverridesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAdminOverridesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAdminOverridesRequest clone() =>
      ListAdminOverridesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAdminOverridesRequest copyWith(
          void Function(ListAdminOverridesRequest) updates) =>
      super.copyWith((message) => updates(message as ListAdminOverridesRequest))
          as ListAdminOverridesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAdminOverridesRequest create() => ListAdminOverridesRequest._();
  ListAdminOverridesRequest createEmptyInstance() => create();
  static $pb.PbList<ListAdminOverridesRequest> createRepeated() =>
      $pb.PbList<ListAdminOverridesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAdminOverridesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAdminOverridesRequest>(create);
  static ListAdminOverridesRequest? _defaultInstance;

  ///  The resource name of the parent quota limit, returned by a
  ///  ListConsumerQuotaMetrics or GetConsumerQuotaMetric call.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion`
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

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

/// Response message for ListAdminOverrides.
class ListAdminOverridesResponse extends $pb.GeneratedMessage {
  factory ListAdminOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListAdminOverridesResponse._() : super();
  factory ListAdminOverridesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListAdminOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAdminOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListAdminOverridesResponse clone() =>
      ListAdminOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListAdminOverridesResponse copyWith(
          void Function(ListAdminOverridesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListAdminOverridesResponse))
          as ListAdminOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAdminOverridesResponse create() => ListAdminOverridesResponse._();
  ListAdminOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<ListAdminOverridesResponse> createRepeated() =>
      $pb.PbList<ListAdminOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAdminOverridesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAdminOverridesResponse>(create);
  static ListAdminOverridesResponse? _defaultInstance;

  /// Admin overrides on this limit.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

/// Response message for BatchCreateAdminOverrides
class BatchCreateAdminOverridesResponse extends $pb.GeneratedMessage {
  factory BatchCreateAdminOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    return $result;
  }
  BatchCreateAdminOverridesResponse._() : super();
  factory BatchCreateAdminOverridesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchCreateAdminOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateAdminOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchCreateAdminOverridesResponse clone() =>
      BatchCreateAdminOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchCreateAdminOverridesResponse copyWith(
          void Function(BatchCreateAdminOverridesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as BatchCreateAdminOverridesResponse))
          as BatchCreateAdminOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateAdminOverridesResponse create() =>
      BatchCreateAdminOverridesResponse._();
  BatchCreateAdminOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchCreateAdminOverridesResponse> createRepeated() =>
      $pb.PbList<BatchCreateAdminOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateAdminOverridesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BatchCreateAdminOverridesResponse>(
          create);
  static BatchCreateAdminOverridesResponse? _defaultInstance;

  /// The overrides that were created.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);
}

enum ImportAdminOverridesRequest_Source { inlineSource, notSet }

/// Request message for ImportAdminOverrides
class ImportAdminOverridesRequest extends $pb.GeneratedMessage {
  factory ImportAdminOverridesRequest({
    $core.String? parent,
    $40.OverrideInlineSource? inlineSource,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (inlineSource != null) {
      $result.inlineSource = inlineSource;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  ImportAdminOverridesRequest._() : super();
  factory ImportAdminOverridesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportAdminOverridesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ImportAdminOverridesRequest_Source>
      _ImportAdminOverridesRequest_SourceByTag = {
    2: ImportAdminOverridesRequest_Source.inlineSource,
    0: ImportAdminOverridesRequest_Source.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAdminOverridesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$40.OverrideInlineSource>(2, _omitFieldNames ? '' : 'inlineSource',
        subBuilder: $40.OverrideInlineSource.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        4, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesRequest clone() =>
      ImportAdminOverridesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesRequest copyWith(
          void Function(ImportAdminOverridesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ImportAdminOverridesRequest))
          as ImportAdminOverridesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesRequest create() =>
      ImportAdminOverridesRequest._();
  ImportAdminOverridesRequest createEmptyInstance() => create();
  static $pb.PbList<ImportAdminOverridesRequest> createRepeated() =>
      $pb.PbList<ImportAdminOverridesRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAdminOverridesRequest>(create);
  static ImportAdminOverridesRequest? _defaultInstance;

  ImportAdminOverridesRequest_Source whichSource() =>
      _ImportAdminOverridesRequest_SourceByTag[$_whichOneof(0)]!;
  void clearSource() => clearField($_whichOneof(0));

  ///  The resource name of the consumer.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com`
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

  /// The import data is specified in the request message itself
  @$pb.TagNumber(2)
  $40.OverrideInlineSource get inlineSource => $_getN(1);
  @$pb.TagNumber(2)
  set inlineSource($40.OverrideInlineSource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInlineSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearInlineSource() => clearField(2);
  @$pb.TagNumber(2)
  $40.OverrideInlineSource ensureInlineSource() => $_ensure(1);

  /// Whether to force the creation of the quota overrides.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(4)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(3);
}

/// Response message for ImportAdminOverrides
class ImportAdminOverridesResponse extends $pb.GeneratedMessage {
  factory ImportAdminOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    return $result;
  }
  ImportAdminOverridesResponse._() : super();
  factory ImportAdminOverridesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportAdminOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAdminOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesResponse clone() =>
      ImportAdminOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesResponse copyWith(
          void Function(ImportAdminOverridesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ImportAdminOverridesResponse))
          as ImportAdminOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesResponse create() =>
      ImportAdminOverridesResponse._();
  ImportAdminOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<ImportAdminOverridesResponse> createRepeated() =>
      $pb.PbList<ImportAdminOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAdminOverridesResponse>(create);
  static ImportAdminOverridesResponse? _defaultInstance;

  /// The overrides that were created from the imported data.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by ImportAdminOverrides.
class ImportAdminOverridesMetadata extends $pb.GeneratedMessage {
  factory ImportAdminOverridesMetadata() => create();
  ImportAdminOverridesMetadata._() : super();
  factory ImportAdminOverridesMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportAdminOverridesMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAdminOverridesMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesMetadata clone() =>
      ImportAdminOverridesMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportAdminOverridesMetadata copyWith(
          void Function(ImportAdminOverridesMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as ImportAdminOverridesMetadata))
          as ImportAdminOverridesMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesMetadata create() =>
      ImportAdminOverridesMetadata._();
  ImportAdminOverridesMetadata createEmptyInstance() => create();
  static $pb.PbList<ImportAdminOverridesMetadata> createRepeated() =>
      $pb.PbList<ImportAdminOverridesMetadata>();
  @$core.pragma('dart2js:noInline')
  static ImportAdminOverridesMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAdminOverridesMetadata>(create);
  static ImportAdminOverridesMetadata? _defaultInstance;
}

/// Request message for CreateConsumerOverride.
class CreateConsumerOverrideRequest extends $pb.GeneratedMessage {
  factory CreateConsumerOverrideRequest({
    $core.String? parent,
    $40.QuotaOverride? override,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (override != null) {
      $result.override = override;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  CreateConsumerOverrideRequest._() : super();
  factory CreateConsumerOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateConsumerOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateConsumerOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$40.QuotaOverride>(2, _omitFieldNames ? '' : 'override',
        subBuilder: $40.QuotaOverride.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        4, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateConsumerOverrideRequest clone() =>
      CreateConsumerOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateConsumerOverrideRequest copyWith(
          void Function(CreateConsumerOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateConsumerOverrideRequest))
          as CreateConsumerOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateConsumerOverrideRequest create() =>
      CreateConsumerOverrideRequest._();
  CreateConsumerOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<CreateConsumerOverrideRequest> createRepeated() =>
      $pb.PbList<CreateConsumerOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateConsumerOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateConsumerOverrideRequest>(create);
  static CreateConsumerOverrideRequest? _defaultInstance;

  ///  The resource name of the parent quota limit, returned by a
  ///  ListConsumerQuotaMetrics or GetConsumerQuotaMetric call.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion`
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

  /// The override to create.
  @$pb.TagNumber(2)
  $40.QuotaOverride get override => $_getN(1);
  @$pb.TagNumber(2)
  set override($40.QuotaOverride v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOverride() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverride() => clearField(2);
  @$pb.TagNumber(2)
  $40.QuotaOverride ensureOverride() => $_ensure(1);

  /// Whether to force the creation of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(4)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(3);
}

/// Request message for UpdateConsumerOverride.
class UpdateConsumerOverrideRequest extends $pb.GeneratedMessage {
  factory UpdateConsumerOverrideRequest({
    $core.String? name,
    $40.QuotaOverride? override,
    $core.bool? force,
    $58.FieldMask? updateMask,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (override != null) {
      $result.override = override;
    }
    if (force != null) {
      $result.force = force;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  UpdateConsumerOverrideRequest._() : super();
  factory UpdateConsumerOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateConsumerOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateConsumerOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<$40.QuotaOverride>(2, _omitFieldNames ? '' : 'override',
        subBuilder: $40.QuotaOverride.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..aOM<$58.FieldMask>(4, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..pc<$40.QuotaSafetyCheck>(
        5, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateConsumerOverrideRequest clone() =>
      UpdateConsumerOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateConsumerOverrideRequest copyWith(
          void Function(UpdateConsumerOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateConsumerOverrideRequest))
          as UpdateConsumerOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateConsumerOverrideRequest create() =>
      UpdateConsumerOverrideRequest._();
  UpdateConsumerOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateConsumerOverrideRequest> createRepeated() =>
      $pb.PbList<UpdateConsumerOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateConsumerOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateConsumerOverrideRequest>(create);
  static UpdateConsumerOverrideRequest? _defaultInstance;

  ///  The resource name of the override to update.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/consumerOverrides/4a3f2c1d`
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

  /// The new override.
  /// Only the override_value is updated; all other fields are ignored.
  @$pb.TagNumber(2)
  $40.QuotaOverride get override => $_getN(1);
  @$pb.TagNumber(2)
  set override($40.QuotaOverride v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOverride() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverride() => clearField(2);
  @$pb.TagNumber(2)
  $40.QuotaOverride ensureOverride() => $_ensure(1);

  /// Whether to force the update of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// Update only the specified fields of the override.
  /// If unset, all fields will be updated.
  @$pb.TagNumber(4)
  $58.FieldMask get updateMask => $_getN(3);
  @$pb.TagNumber(4)
  set updateMask($58.FieldMask v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUpdateMask() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpdateMask() => clearField(4);
  @$pb.TagNumber(4)
  $58.FieldMask ensureUpdateMask() => $_ensure(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(5)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(4);
}

/// Request message for DeleteConsumerOverride.
class DeleteConsumerOverrideRequest extends $pb.GeneratedMessage {
  factory DeleteConsumerOverrideRequest({
    $core.String? name,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  DeleteConsumerOverrideRequest._() : super();
  factory DeleteConsumerOverrideRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteConsumerOverrideRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteConsumerOverrideRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        3, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteConsumerOverrideRequest clone() =>
      DeleteConsumerOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteConsumerOverrideRequest copyWith(
          void Function(DeleteConsumerOverrideRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteConsumerOverrideRequest))
          as DeleteConsumerOverrideRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteConsumerOverrideRequest create() =>
      DeleteConsumerOverrideRequest._();
  DeleteConsumerOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteConsumerOverrideRequest> createRepeated() =>
      $pb.PbList<DeleteConsumerOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteConsumerOverrideRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteConsumerOverrideRequest>(create);
  static DeleteConsumerOverrideRequest? _defaultInstance;

  ///  The resource name of the override to delete.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion/consumerOverrides/4a3f2c1d`
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

  /// Whether to force the deletion of the quota override.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(2)
  $core.bool get force => $_getBF(1);
  @$pb.TagNumber(2)
  set force($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearForce() => clearField(2);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(3)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(2);
}

/// Request message for ListConsumerOverrides
class ListConsumerOverridesRequest extends $pb.GeneratedMessage {
  factory ListConsumerOverridesRequest({
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
  ListConsumerOverridesRequest._() : super();
  factory ListConsumerOverridesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListConsumerOverridesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListConsumerOverridesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListConsumerOverridesRequest clone() =>
      ListConsumerOverridesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListConsumerOverridesRequest copyWith(
          void Function(ListConsumerOverridesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListConsumerOverridesRequest))
          as ListConsumerOverridesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListConsumerOverridesRequest create() =>
      ListConsumerOverridesRequest._();
  ListConsumerOverridesRequest createEmptyInstance() => create();
  static $pb.PbList<ListConsumerOverridesRequest> createRepeated() =>
      $pb.PbList<ListConsumerOverridesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListConsumerOverridesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListConsumerOverridesRequest>(create);
  static ListConsumerOverridesRequest? _defaultInstance;

  ///  The resource name of the parent quota limit, returned by a
  ///  ListConsumerQuotaMetrics or GetConsumerQuotaMetric call.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com/consumerQuotaMetrics/compute.googleapis.com%2Fcpus/limits/%2Fproject%2Fregion`
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

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

/// Response message for ListConsumerOverrides.
class ListConsumerOverridesResponse extends $pb.GeneratedMessage {
  factory ListConsumerOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListConsumerOverridesResponse._() : super();
  factory ListConsumerOverridesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListConsumerOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListConsumerOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListConsumerOverridesResponse clone() =>
      ListConsumerOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListConsumerOverridesResponse copyWith(
          void Function(ListConsumerOverridesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListConsumerOverridesResponse))
          as ListConsumerOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListConsumerOverridesResponse create() =>
      ListConsumerOverridesResponse._();
  ListConsumerOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<ListConsumerOverridesResponse> createRepeated() =>
      $pb.PbList<ListConsumerOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListConsumerOverridesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListConsumerOverridesResponse>(create);
  static ListConsumerOverridesResponse? _defaultInstance;

  /// Consumer overrides on this limit.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);

  /// Token identifying which result to start with; returned by a previous list
  /// call.
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

/// Response message for BatchCreateConsumerOverrides
class BatchCreateConsumerOverridesResponse extends $pb.GeneratedMessage {
  factory BatchCreateConsumerOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    return $result;
  }
  BatchCreateConsumerOverridesResponse._() : super();
  factory BatchCreateConsumerOverridesResponse.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory BatchCreateConsumerOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BatchCreateConsumerOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  BatchCreateConsumerOverridesResponse clone() =>
      BatchCreateConsumerOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  BatchCreateConsumerOverridesResponse copyWith(
          void Function(BatchCreateConsumerOverridesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as BatchCreateConsumerOverridesResponse))
          as BatchCreateConsumerOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateConsumerOverridesResponse create() =>
      BatchCreateConsumerOverridesResponse._();
  BatchCreateConsumerOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<BatchCreateConsumerOverridesResponse> createRepeated() =>
      $pb.PbList<BatchCreateConsumerOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateConsumerOverridesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          BatchCreateConsumerOverridesResponse>(create);
  static BatchCreateConsumerOverridesResponse? _defaultInstance;

  /// The overrides that were created.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);
}

enum ImportConsumerOverridesRequest_Source { inlineSource, notSet }

/// Request message for ImportConsumerOverrides
class ImportConsumerOverridesRequest extends $pb.GeneratedMessage {
  factory ImportConsumerOverridesRequest({
    $core.String? parent,
    $40.OverrideInlineSource? inlineSource,
    $core.bool? force,
    $core.Iterable<$40.QuotaSafetyCheck>? forceOnly,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (inlineSource != null) {
      $result.inlineSource = inlineSource;
    }
    if (force != null) {
      $result.force = force;
    }
    if (forceOnly != null) {
      $result.forceOnly.addAll(forceOnly);
    }
    return $result;
  }
  ImportConsumerOverridesRequest._() : super();
  factory ImportConsumerOverridesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportConsumerOverridesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ImportConsumerOverridesRequest_Source>
      _ImportConsumerOverridesRequest_SourceByTag = {
    2: ImportConsumerOverridesRequest_Source.inlineSource,
    0: ImportConsumerOverridesRequest_Source.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportConsumerOverridesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..oo(0, [2])
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOM<$40.OverrideInlineSource>(2, _omitFieldNames ? '' : 'inlineSource',
        subBuilder: $40.OverrideInlineSource.create)
    ..aOB(3, _omitFieldNames ? '' : 'force')
    ..pc<$40.QuotaSafetyCheck>(
        4, _omitFieldNames ? '' : 'forceOnly', $pb.PbFieldType.KE,
        valueOf: $40.QuotaSafetyCheck.valueOf,
        enumValues: $40.QuotaSafetyCheck.values,
        defaultEnumValue: $40.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesRequest clone() =>
      ImportConsumerOverridesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesRequest copyWith(
          void Function(ImportConsumerOverridesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ImportConsumerOverridesRequest))
          as ImportConsumerOverridesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesRequest create() =>
      ImportConsumerOverridesRequest._();
  ImportConsumerOverridesRequest createEmptyInstance() => create();
  static $pb.PbList<ImportConsumerOverridesRequest> createRepeated() =>
      $pb.PbList<ImportConsumerOverridesRequest>();
  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportConsumerOverridesRequest>(create);
  static ImportConsumerOverridesRequest? _defaultInstance;

  ImportConsumerOverridesRequest_Source whichSource() =>
      _ImportConsumerOverridesRequest_SourceByTag[$_whichOneof(0)]!;
  void clearSource() => clearField($_whichOneof(0));

  ///  The resource name of the consumer.
  ///
  ///  An example name would be:
  ///  `projects/123/services/compute.googleapis.com`
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

  /// The import data is specified in the request message itself
  @$pb.TagNumber(2)
  $40.OverrideInlineSource get inlineSource => $_getN(1);
  @$pb.TagNumber(2)
  set inlineSource($40.OverrideInlineSource v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInlineSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearInlineSource() => clearField(2);
  @$pb.TagNumber(2)
  $40.OverrideInlineSource ensureInlineSource() => $_ensure(1);

  /// Whether to force the creation of the quota overrides.
  /// Setting the force parameter to 'true' ignores all quota safety checks that
  /// would fail the request. QuotaSafetyCheck lists all such validations.
  @$pb.TagNumber(3)
  $core.bool get force => $_getBF(2);
  @$pb.TagNumber(3)
  set force($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearForce() => clearField(3);

  /// The list of quota safety checks to ignore before the override mutation.
  /// Unlike 'force' field that ignores all the quota safety checks, the
  /// 'force_only' field ignores only the specified checks; other checks are
  /// still enforced. The 'force' and 'force_only' fields cannot both be set.
  @$pb.TagNumber(4)
  $core.List<$40.QuotaSafetyCheck> get forceOnly => $_getList(3);
}

/// Response message for ImportConsumerOverrides
class ImportConsumerOverridesResponse extends $pb.GeneratedMessage {
  factory ImportConsumerOverridesResponse({
    $core.Iterable<$40.QuotaOverride>? overrides,
  }) {
    final $result = create();
    if (overrides != null) {
      $result.overrides.addAll(overrides);
    }
    return $result;
  }
  ImportConsumerOverridesResponse._() : super();
  factory ImportConsumerOverridesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportConsumerOverridesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportConsumerOverridesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.QuotaOverride>(
        1, _omitFieldNames ? '' : 'overrides', $pb.PbFieldType.PM,
        subBuilder: $40.QuotaOverride.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesResponse clone() =>
      ImportConsumerOverridesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesResponse copyWith(
          void Function(ImportConsumerOverridesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ImportConsumerOverridesResponse))
          as ImportConsumerOverridesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesResponse create() =>
      ImportConsumerOverridesResponse._();
  ImportConsumerOverridesResponse createEmptyInstance() => create();
  static $pb.PbList<ImportConsumerOverridesResponse> createRepeated() =>
      $pb.PbList<ImportConsumerOverridesResponse>();
  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportConsumerOverridesResponse>(
          create);
  static ImportConsumerOverridesResponse? _defaultInstance;

  /// The overrides that were created from the imported data.
  @$pb.TagNumber(1)
  $core.List<$40.QuotaOverride> get overrides => $_getList(0);
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by ImportConsumerOverrides.
class ImportConsumerOverridesMetadata extends $pb.GeneratedMessage {
  factory ImportConsumerOverridesMetadata() => create();
  ImportConsumerOverridesMetadata._() : super();
  factory ImportConsumerOverridesMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportConsumerOverridesMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportConsumerOverridesMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesMetadata clone() =>
      ImportConsumerOverridesMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportConsumerOverridesMetadata copyWith(
          void Function(ImportConsumerOverridesMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as ImportConsumerOverridesMetadata))
          as ImportConsumerOverridesMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesMetadata create() =>
      ImportConsumerOverridesMetadata._();
  ImportConsumerOverridesMetadata createEmptyInstance() => create();
  static $pb.PbList<ImportConsumerOverridesMetadata> createRepeated() =>
      $pb.PbList<ImportConsumerOverridesMetadata>();
  @$core.pragma('dart2js:noInline')
  static ImportConsumerOverridesMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportConsumerOverridesMetadata>(
          create);
  static ImportConsumerOverridesMetadata? _defaultInstance;
}

/// Response message for ImportAdminQuotaPolicies
class ImportAdminQuotaPoliciesResponse extends $pb.GeneratedMessage {
  factory ImportAdminQuotaPoliciesResponse({
    $core.Iterable<$40.AdminQuotaPolicy>? policies,
  }) {
    final $result = create();
    if (policies != null) {
      $result.policies.addAll(policies);
    }
    return $result;
  }
  ImportAdminQuotaPoliciesResponse._() : super();
  factory ImportAdminQuotaPoliciesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportAdminQuotaPoliciesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAdminQuotaPoliciesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..pc<$40.AdminQuotaPolicy>(
        1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM,
        subBuilder: $40.AdminQuotaPolicy.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportAdminQuotaPoliciesResponse clone() =>
      ImportAdminQuotaPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportAdminQuotaPoliciesResponse copyWith(
          void Function(ImportAdminQuotaPoliciesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ImportAdminQuotaPoliciesResponse))
          as ImportAdminQuotaPoliciesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportAdminQuotaPoliciesResponse create() =>
      ImportAdminQuotaPoliciesResponse._();
  ImportAdminQuotaPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<ImportAdminQuotaPoliciesResponse> createRepeated() =>
      $pb.PbList<ImportAdminQuotaPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static ImportAdminQuotaPoliciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAdminQuotaPoliciesResponse>(
          create);
  static ImportAdminQuotaPoliciesResponse? _defaultInstance;

  /// The policies that were created from the imported data.
  @$pb.TagNumber(1)
  $core.List<$40.AdminQuotaPolicy> get policies => $_getList(0);
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by ImportAdminQuotaPolicies.
class ImportAdminQuotaPoliciesMetadata extends $pb.GeneratedMessage {
  factory ImportAdminQuotaPoliciesMetadata() => create();
  ImportAdminQuotaPoliciesMetadata._() : super();
  factory ImportAdminQuotaPoliciesMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ImportAdminQuotaPoliciesMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportAdminQuotaPoliciesMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ImportAdminQuotaPoliciesMetadata clone() =>
      ImportAdminQuotaPoliciesMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ImportAdminQuotaPoliciesMetadata copyWith(
          void Function(ImportAdminQuotaPoliciesMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as ImportAdminQuotaPoliciesMetadata))
          as ImportAdminQuotaPoliciesMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImportAdminQuotaPoliciesMetadata create() =>
      ImportAdminQuotaPoliciesMetadata._();
  ImportAdminQuotaPoliciesMetadata createEmptyInstance() => create();
  static $pb.PbList<ImportAdminQuotaPoliciesMetadata> createRepeated() =>
      $pb.PbList<ImportAdminQuotaPoliciesMetadata>();
  @$core.pragma('dart2js:noInline')
  static ImportAdminQuotaPoliciesMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportAdminQuotaPoliciesMetadata>(
          create);
  static ImportAdminQuotaPoliciesMetadata? _defaultInstance;
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by CreateAdminQuotaPolicy.
class CreateAdminQuotaPolicyMetadata extends $pb.GeneratedMessage {
  factory CreateAdminQuotaPolicyMetadata() => create();
  CreateAdminQuotaPolicyMetadata._() : super();
  factory CreateAdminQuotaPolicyMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateAdminQuotaPolicyMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateAdminQuotaPolicyMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateAdminQuotaPolicyMetadata clone() =>
      CreateAdminQuotaPolicyMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateAdminQuotaPolicyMetadata copyWith(
          void Function(CreateAdminQuotaPolicyMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as CreateAdminQuotaPolicyMetadata))
          as CreateAdminQuotaPolicyMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateAdminQuotaPolicyMetadata create() =>
      CreateAdminQuotaPolicyMetadata._();
  CreateAdminQuotaPolicyMetadata createEmptyInstance() => create();
  static $pb.PbList<CreateAdminQuotaPolicyMetadata> createRepeated() =>
      $pb.PbList<CreateAdminQuotaPolicyMetadata>();
  @$core.pragma('dart2js:noInline')
  static CreateAdminQuotaPolicyMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateAdminQuotaPolicyMetadata>(create);
  static CreateAdminQuotaPolicyMetadata? _defaultInstance;
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by UpdateAdminQuotaPolicy.
class UpdateAdminQuotaPolicyMetadata extends $pb.GeneratedMessage {
  factory UpdateAdminQuotaPolicyMetadata() => create();
  UpdateAdminQuotaPolicyMetadata._() : super();
  factory UpdateAdminQuotaPolicyMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateAdminQuotaPolicyMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAdminQuotaPolicyMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateAdminQuotaPolicyMetadata clone() =>
      UpdateAdminQuotaPolicyMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateAdminQuotaPolicyMetadata copyWith(
          void Function(UpdateAdminQuotaPolicyMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateAdminQuotaPolicyMetadata))
          as UpdateAdminQuotaPolicyMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAdminQuotaPolicyMetadata create() =>
      UpdateAdminQuotaPolicyMetadata._();
  UpdateAdminQuotaPolicyMetadata createEmptyInstance() => create();
  static $pb.PbList<UpdateAdminQuotaPolicyMetadata> createRepeated() =>
      $pb.PbList<UpdateAdminQuotaPolicyMetadata>();
  @$core.pragma('dart2js:noInline')
  static UpdateAdminQuotaPolicyMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAdminQuotaPolicyMetadata>(create);
  static UpdateAdminQuotaPolicyMetadata? _defaultInstance;
}

/// Metadata message that provides information such as progress,
/// partial failures, and similar information on each GetOperation call
/// of LRO returned by DeleteAdminQuotaPolicy.
class DeleteAdminQuotaPolicyMetadata extends $pb.GeneratedMessage {
  factory DeleteAdminQuotaPolicyMetadata() => create();
  DeleteAdminQuotaPolicyMetadata._() : super();
  factory DeleteAdminQuotaPolicyMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteAdminQuotaPolicyMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAdminQuotaPolicyMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteAdminQuotaPolicyMetadata clone() =>
      DeleteAdminQuotaPolicyMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteAdminQuotaPolicyMetadata copyWith(
          void Function(DeleteAdminQuotaPolicyMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteAdminQuotaPolicyMetadata))
          as DeleteAdminQuotaPolicyMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAdminQuotaPolicyMetadata create() =>
      DeleteAdminQuotaPolicyMetadata._();
  DeleteAdminQuotaPolicyMetadata createEmptyInstance() => create();
  static $pb.PbList<DeleteAdminQuotaPolicyMetadata> createRepeated() =>
      $pb.PbList<DeleteAdminQuotaPolicyMetadata>();
  @$core.pragma('dart2js:noInline')
  static DeleteAdminQuotaPolicyMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAdminQuotaPolicyMetadata>(create);
  static DeleteAdminQuotaPolicyMetadata? _defaultInstance;
}

/// Request message for generating service identity.
class GenerateServiceIdentityRequest extends $pb.GeneratedMessage {
  factory GenerateServiceIdentityRequest({
    $core.String? parent,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    return $result;
  }
  GenerateServiceIdentityRequest._() : super();
  factory GenerateServiceIdentityRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateServiceIdentityRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateServiceIdentityRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateServiceIdentityRequest clone() =>
      GenerateServiceIdentityRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateServiceIdentityRequest copyWith(
          void Function(GenerateServiceIdentityRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateServiceIdentityRequest))
          as GenerateServiceIdentityRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateServiceIdentityRequest create() =>
      GenerateServiceIdentityRequest._();
  GenerateServiceIdentityRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateServiceIdentityRequest> createRepeated() =>
      $pb.PbList<GenerateServiceIdentityRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateServiceIdentityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateServiceIdentityRequest>(create);
  static GenerateServiceIdentityRequest? _defaultInstance;

  ///  Name of the consumer and service to generate an identity for.
  ///
  ///  The `GenerateServiceIdentity` methods currently support projects, folders,
  ///  organizations.
  ///
  ///  Example parents would be:
  ///  `projects/123/services/example.googleapis.com`
  ///  `folders/123/services/example.googleapis.com`
  ///  `organizations/123/services/example.googleapis.com`
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
}

/// Response message for getting service identity.
class GetServiceIdentityResponse extends $pb.GeneratedMessage {
  factory GetServiceIdentityResponse({
    $40.ServiceIdentity? identity,
    GetServiceIdentityResponse_IdentityState? state,
  }) {
    final $result = create();
    if (identity != null) {
      $result.identity = identity;
    }
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  GetServiceIdentityResponse._() : super();
  factory GetServiceIdentityResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceIdentityResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceIdentityResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..aOM<$40.ServiceIdentity>(1, _omitFieldNames ? '' : 'identity',
        subBuilder: $40.ServiceIdentity.create)
    ..e<GetServiceIdentityResponse_IdentityState>(
        2, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE,
        defaultOrMaker:
            GetServiceIdentityResponse_IdentityState.IDENTITY_STATE_UNSPECIFIED,
        valueOf: GetServiceIdentityResponse_IdentityState.valueOf,
        enumValues: GetServiceIdentityResponse_IdentityState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceIdentityResponse clone() =>
      GetServiceIdentityResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceIdentityResponse copyWith(
          void Function(GetServiceIdentityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetServiceIdentityResponse))
          as GetServiceIdentityResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceIdentityResponse create() => GetServiceIdentityResponse._();
  GetServiceIdentityResponse createEmptyInstance() => create();
  static $pb.PbList<GetServiceIdentityResponse> createRepeated() =>
      $pb.PbList<GetServiceIdentityResponse>();
  @$core.pragma('dart2js:noInline')
  static GetServiceIdentityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceIdentityResponse>(create);
  static GetServiceIdentityResponse? _defaultInstance;

  /// Service identity that service producer can use to access consumer
  /// resources. If exists is true, it contains email and unique_id. If exists is
  /// false, it contains pre-constructed email and empty unique_id.
  @$pb.TagNumber(1)
  $40.ServiceIdentity get identity => $_getN(0);
  @$pb.TagNumber(1)
  set identity($40.ServiceIdentity v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasIdentity() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentity() => clearField(1);
  @$pb.TagNumber(1)
  $40.ServiceIdentity ensureIdentity() => $_ensure(0);

  /// Service identity state.
  @$pb.TagNumber(2)
  GetServiceIdentityResponse_IdentityState get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(GetServiceIdentityResponse_IdentityState v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => clearField(2);
}

/// Metadata for the `GetServiceIdentity` method.
class GetServiceIdentityMetadata extends $pb.GeneratedMessage {
  factory GetServiceIdentityMetadata() => create();
  GetServiceIdentityMetadata._() : super();
  factory GetServiceIdentityMetadata.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceIdentityMetadata.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceIdentityMetadata',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.serviceusage.v1beta1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceIdentityMetadata clone() =>
      GetServiceIdentityMetadata()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceIdentityMetadata copyWith(
          void Function(GetServiceIdentityMetadata) updates) =>
      super.copyWith(
              (message) => updates(message as GetServiceIdentityMetadata))
          as GetServiceIdentityMetadata;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceIdentityMetadata create() => GetServiceIdentityMetadata._();
  GetServiceIdentityMetadata createEmptyInstance() => create();
  static $pb.PbList<GetServiceIdentityMetadata> createRepeated() =>
      $pb.PbList<GetServiceIdentityMetadata>();
  @$core.pragma('dart2js:noInline')
  static GetServiceIdentityMetadata getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceIdentityMetadata>(create);
  static GetServiceIdentityMetadata? _defaultInstance;
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
