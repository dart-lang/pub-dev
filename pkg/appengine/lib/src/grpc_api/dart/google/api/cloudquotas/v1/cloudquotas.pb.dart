//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/cloudquotas.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/field_mask.pb.dart' as $58;
import 'resources.pb.dart' as $32;
import 'resources.pbenum.dart' as $32;

/// Message for requesting list of QuotaInfos
class ListQuotaInfosRequest extends $pb.GeneratedMessage {
  factory ListQuotaInfosRequest({
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
  ListQuotaInfosRequest._() : super();
  factory ListQuotaInfosRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListQuotaInfosRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotaInfosRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListQuotaInfosRequest clone() =>
      ListQuotaInfosRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListQuotaInfosRequest copyWith(
          void Function(ListQuotaInfosRequest) updates) =>
      super.copyWith((message) => updates(message as ListQuotaInfosRequest))
          as ListQuotaInfosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotaInfosRequest create() => ListQuotaInfosRequest._();
  ListQuotaInfosRequest createEmptyInstance() => create();
  static $pb.PbList<ListQuotaInfosRequest> createRepeated() =>
      $pb.PbList<ListQuotaInfosRequest>();
  @$core.pragma('dart2js:noInline')
  static ListQuotaInfosRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotaInfosRequest>(create);
  static ListQuotaInfosRequest? _defaultInstance;

  ///  Required. Parent value of QuotaInfo resources.
  ///  Listing across different resource containers (such as 'projects/-') is not
  ///  allowed.
  ///
  ///  Example names:
  ///  `projects/123/locations/global/services/compute.googleapis.com`
  ///  `folders/234/locations/global/services/compute.googleapis.com`
  ///  `organizations/345/locations/global/services/compute.googleapis.com`
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

  /// Optional. Requested page size. Server may return fewer items than
  /// requested. If unspecified, server will pick an appropriate default.
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

  /// Optional. A token identifying a page of results the server should return.
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

/// Message for response to listing QuotaInfos
class ListQuotaInfosResponse extends $pb.GeneratedMessage {
  factory ListQuotaInfosResponse({
    $core.Iterable<$32.QuotaInfo>? quotaInfos,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (quotaInfos != null) {
      $result.quotaInfos.addAll(quotaInfos);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListQuotaInfosResponse._() : super();
  factory ListQuotaInfosResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListQuotaInfosResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotaInfosResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..pc<$32.QuotaInfo>(
        1, _omitFieldNames ? '' : 'quotaInfos', $pb.PbFieldType.PM,
        subBuilder: $32.QuotaInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListQuotaInfosResponse clone() =>
      ListQuotaInfosResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListQuotaInfosResponse copyWith(
          void Function(ListQuotaInfosResponse) updates) =>
      super.copyWith((message) => updates(message as ListQuotaInfosResponse))
          as ListQuotaInfosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotaInfosResponse create() => ListQuotaInfosResponse._();
  ListQuotaInfosResponse createEmptyInstance() => create();
  static $pb.PbList<ListQuotaInfosResponse> createRepeated() =>
      $pb.PbList<ListQuotaInfosResponse>();
  @$core.pragma('dart2js:noInline')
  static ListQuotaInfosResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotaInfosResponse>(create);
  static ListQuotaInfosResponse? _defaultInstance;

  /// The list of QuotaInfo
  @$pb.TagNumber(1)
  $core.List<$32.QuotaInfo> get quotaInfos => $_getList(0);

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
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

/// Message for getting a QuotaInfo
class GetQuotaInfoRequest extends $pb.GeneratedMessage {
  factory GetQuotaInfoRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetQuotaInfoRequest._() : super();
  factory GetQuotaInfoRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetQuotaInfoRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetQuotaInfoRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetQuotaInfoRequest clone() => GetQuotaInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetQuotaInfoRequest copyWith(void Function(GetQuotaInfoRequest) updates) =>
      super.copyWith((message) => updates(message as GetQuotaInfoRequest))
          as GetQuotaInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuotaInfoRequest create() => GetQuotaInfoRequest._();
  GetQuotaInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuotaInfoRequest> createRepeated() =>
      $pb.PbList<GetQuotaInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuotaInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetQuotaInfoRequest>(create);
  static GetQuotaInfoRequest? _defaultInstance;

  ///  Required. The resource name of the quota info.
  ///
  ///  An example name:
  ///  `projects/123/locations/global/services/compute.googleapis.com/quotaInfos/CpusPerProjectPerRegion`
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

/// Message for requesting list of QuotaPreferences
class ListQuotaPreferencesRequest extends $pb.GeneratedMessage {
  factory ListQuotaPreferencesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    $core.String? filter,
    $core.String? orderBy,
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
    if (orderBy != null) {
      $result.orderBy = orderBy;
    }
    return $result;
  }
  ListQuotaPreferencesRequest._() : super();
  factory ListQuotaPreferencesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListQuotaPreferencesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotaPreferencesRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..aOS(4, _omitFieldNames ? '' : 'filter')
    ..aOS(5, _omitFieldNames ? '' : 'orderBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListQuotaPreferencesRequest clone() =>
      ListQuotaPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListQuotaPreferencesRequest copyWith(
          void Function(ListQuotaPreferencesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListQuotaPreferencesRequest))
          as ListQuotaPreferencesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotaPreferencesRequest create() =>
      ListQuotaPreferencesRequest._();
  ListQuotaPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<ListQuotaPreferencesRequest> createRepeated() =>
      $pb.PbList<ListQuotaPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListQuotaPreferencesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotaPreferencesRequest>(create);
  static ListQuotaPreferencesRequest? _defaultInstance;

  ///  Required. Parent value of QuotaPreference resources.
  ///  Listing across different resource containers (such as 'projects/-') is not
  ///  allowed.
  ///
  ///  When the value starts with 'folders' or 'organizations', it lists the
  ///  QuotaPreferences for org quotas in the container. It does not list the
  ///  QuotaPreferences in the descendant projects of the container.
  ///
  ///  Example parents:
  ///  `projects/123/locations/global`
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

  /// Optional. Requested page size. Server may return fewer items than
  /// requested. If unspecified, server will pick an appropriate default.
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

  /// Optional. A token identifying a page of results the server should return.
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

  ///  Optional. Filter result QuotaPreferences by their state, type,
  ///  create/update time range.
  ///
  ///  Example filters:
  ///  `reconciling=true AND request_type=CLOUD_CONSOLE`,
  ///  `reconciling=true OR creation_time>2022-12-03T10:30:00`
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

  ///  Optional. How to order of the results. By default, the results are ordered
  ///  by create time.
  ///
  ///  Example orders:
  ///  `quota_id`,
  ///  `service, create_time`
  @$pb.TagNumber(5)
  $core.String get orderBy => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderBy($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasOrderBy() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderBy() => clearField(5);
}

/// Message for response to listing QuotaPreferences
class ListQuotaPreferencesResponse extends $pb.GeneratedMessage {
  factory ListQuotaPreferencesResponse({
    $core.Iterable<$32.QuotaPreference>? quotaPreferences,
    $core.String? nextPageToken,
    $core.Iterable<$core.String>? unreachable,
  }) {
    final $result = create();
    if (quotaPreferences != null) {
      $result.quotaPreferences.addAll(quotaPreferences);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    if (unreachable != null) {
      $result.unreachable.addAll(unreachable);
    }
    return $result;
  }
  ListQuotaPreferencesResponse._() : super();
  factory ListQuotaPreferencesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListQuotaPreferencesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListQuotaPreferencesResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..pc<$32.QuotaPreference>(
        1, _omitFieldNames ? '' : 'quotaPreferences', $pb.PbFieldType.PM,
        subBuilder: $32.QuotaPreference.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..pPS(3, _omitFieldNames ? '' : 'unreachable')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListQuotaPreferencesResponse clone() =>
      ListQuotaPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListQuotaPreferencesResponse copyWith(
          void Function(ListQuotaPreferencesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListQuotaPreferencesResponse))
          as ListQuotaPreferencesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListQuotaPreferencesResponse create() =>
      ListQuotaPreferencesResponse._();
  ListQuotaPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<ListQuotaPreferencesResponse> createRepeated() =>
      $pb.PbList<ListQuotaPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListQuotaPreferencesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListQuotaPreferencesResponse>(create);
  static ListQuotaPreferencesResponse? _defaultInstance;

  /// The list of QuotaPreference
  @$pb.TagNumber(1)
  $core.List<$32.QuotaPreference> get quotaPreferences => $_getList(0);

  /// A token, which can be sent as `page_token` to retrieve the next page.
  /// If this field is omitted, there are no subsequent pages.
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

  /// Locations that could not be reached.
  @$pb.TagNumber(3)
  $core.List<$core.String> get unreachable => $_getList(2);
}

/// Message for getting a QuotaPreference
class GetQuotaPreferenceRequest extends $pb.GeneratedMessage {
  factory GetQuotaPreferenceRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetQuotaPreferenceRequest._() : super();
  factory GetQuotaPreferenceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetQuotaPreferenceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetQuotaPreferenceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetQuotaPreferenceRequest clone() =>
      GetQuotaPreferenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetQuotaPreferenceRequest copyWith(
          void Function(GetQuotaPreferenceRequest) updates) =>
      super.copyWith((message) => updates(message as GetQuotaPreferenceRequest))
          as GetQuotaPreferenceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuotaPreferenceRequest create() => GetQuotaPreferenceRequest._();
  GetQuotaPreferenceRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuotaPreferenceRequest> createRepeated() =>
      $pb.PbList<GetQuotaPreferenceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuotaPreferenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetQuotaPreferenceRequest>(create);
  static GetQuotaPreferenceRequest? _defaultInstance;

  ///  Required. Name of the resource
  ///
  ///  Example name:
  ///  `projects/123/locations/global/quota_preferences/my-config-for-us-east1`
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

/// Message for creating a QuotaPreference
class CreateQuotaPreferenceRequest extends $pb.GeneratedMessage {
  factory CreateQuotaPreferenceRequest({
    $core.String? parent,
    $core.String? quotaPreferenceId,
    $32.QuotaPreference? quotaPreference,
    $core.Iterable<$32.QuotaSafetyCheck>? ignoreSafetyChecks,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (quotaPreferenceId != null) {
      $result.quotaPreferenceId = quotaPreferenceId;
    }
    if (quotaPreference != null) {
      $result.quotaPreference = quotaPreference;
    }
    if (ignoreSafetyChecks != null) {
      $result.ignoreSafetyChecks.addAll(ignoreSafetyChecks);
    }
    return $result;
  }
  CreateQuotaPreferenceRequest._() : super();
  factory CreateQuotaPreferenceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateQuotaPreferenceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateQuotaPreferenceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOS(2, _omitFieldNames ? '' : 'quotaPreferenceId')
    ..aOM<$32.QuotaPreference>(3, _omitFieldNames ? '' : 'quotaPreference',
        subBuilder: $32.QuotaPreference.create)
    ..pc<$32.QuotaSafetyCheck>(
        4, _omitFieldNames ? '' : 'ignoreSafetyChecks', $pb.PbFieldType.KE,
        valueOf: $32.QuotaSafetyCheck.valueOf,
        enumValues: $32.QuotaSafetyCheck.values,
        defaultEnumValue: $32.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateQuotaPreferenceRequest clone() =>
      CreateQuotaPreferenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateQuotaPreferenceRequest copyWith(
          void Function(CreateQuotaPreferenceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateQuotaPreferenceRequest))
          as CreateQuotaPreferenceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateQuotaPreferenceRequest create() =>
      CreateQuotaPreferenceRequest._();
  CreateQuotaPreferenceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateQuotaPreferenceRequest> createRepeated() =>
      $pb.PbList<CreateQuotaPreferenceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateQuotaPreferenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateQuotaPreferenceRequest>(create);
  static CreateQuotaPreferenceRequest? _defaultInstance;

  ///  Required. Value for parent.
  ///
  ///  Example:
  ///  `projects/123/locations/global`
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

  /// Optional. Id of the requesting object, must be unique under its parent.
  /// If client does not set this field, the service will generate one.
  @$pb.TagNumber(2)
  $core.String get quotaPreferenceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set quotaPreferenceId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuotaPreferenceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuotaPreferenceId() => clearField(2);

  /// Required. The resource being created
  @$pb.TagNumber(3)
  $32.QuotaPreference get quotaPreference => $_getN(2);
  @$pb.TagNumber(3)
  set quotaPreference($32.QuotaPreference v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasQuotaPreference() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuotaPreference() => clearField(3);
  @$pb.TagNumber(3)
  $32.QuotaPreference ensureQuotaPreference() => $_ensure(2);

  /// The list of quota safety checks to be ignored.
  @$pb.TagNumber(4)
  $core.List<$32.QuotaSafetyCheck> get ignoreSafetyChecks => $_getList(3);
}

/// Message for updating a QuotaPreference
class UpdateQuotaPreferenceRequest extends $pb.GeneratedMessage {
  factory UpdateQuotaPreferenceRequest({
    $58.FieldMask? updateMask,
    $32.QuotaPreference? quotaPreference,
    $core.bool? allowMissing,
    $core.bool? validateOnly,
    $core.Iterable<$32.QuotaSafetyCheck>? ignoreSafetyChecks,
  }) {
    final $result = create();
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    if (quotaPreference != null) {
      $result.quotaPreference = quotaPreference;
    }
    if (allowMissing != null) {
      $result.allowMissing = allowMissing;
    }
    if (validateOnly != null) {
      $result.validateOnly = validateOnly;
    }
    if (ignoreSafetyChecks != null) {
      $result.ignoreSafetyChecks.addAll(ignoreSafetyChecks);
    }
    return $result;
  }
  UpdateQuotaPreferenceRequest._() : super();
  factory UpdateQuotaPreferenceRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateQuotaPreferenceRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateQuotaPreferenceRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.api.cloudquotas.v1'),
      createEmptyInstance: create)
    ..aOM<$58.FieldMask>(1, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..aOM<$32.QuotaPreference>(2, _omitFieldNames ? '' : 'quotaPreference',
        subBuilder: $32.QuotaPreference.create)
    ..aOB(3, _omitFieldNames ? '' : 'allowMissing')
    ..aOB(4, _omitFieldNames ? '' : 'validateOnly')
    ..pc<$32.QuotaSafetyCheck>(
        5, _omitFieldNames ? '' : 'ignoreSafetyChecks', $pb.PbFieldType.KE,
        valueOf: $32.QuotaSafetyCheck.valueOf,
        enumValues: $32.QuotaSafetyCheck.values,
        defaultEnumValue: $32.QuotaSafetyCheck.QUOTA_SAFETY_CHECK_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateQuotaPreferenceRequest clone() =>
      UpdateQuotaPreferenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateQuotaPreferenceRequest copyWith(
          void Function(UpdateQuotaPreferenceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateQuotaPreferenceRequest))
          as UpdateQuotaPreferenceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateQuotaPreferenceRequest create() =>
      UpdateQuotaPreferenceRequest._();
  UpdateQuotaPreferenceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateQuotaPreferenceRequest> createRepeated() =>
      $pb.PbList<UpdateQuotaPreferenceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateQuotaPreferenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateQuotaPreferenceRequest>(create);
  static UpdateQuotaPreferenceRequest? _defaultInstance;

  /// Optional. Field mask is used to specify the fields to be overwritten in the
  /// QuotaPreference resource by the update.
  /// The fields specified in the update_mask are relative to the resource, not
  /// the full request. A field will be overwritten if it is in the mask. If the
  /// user does not provide a mask then all fields will be overwritten.
  @$pb.TagNumber(1)
  $58.FieldMask get updateMask => $_getN(0);
  @$pb.TagNumber(1)
  set updateMask($58.FieldMask v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasUpdateMask() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdateMask() => clearField(1);
  @$pb.TagNumber(1)
  $58.FieldMask ensureUpdateMask() => $_ensure(0);

  /// Required. The resource being updated
  @$pb.TagNumber(2)
  $32.QuotaPreference get quotaPreference => $_getN(1);
  @$pb.TagNumber(2)
  set quotaPreference($32.QuotaPreference v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuotaPreference() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuotaPreference() => clearField(2);
  @$pb.TagNumber(2)
  $32.QuotaPreference ensureQuotaPreference() => $_ensure(1);

  /// Optional. If set to true, and the quota preference is not found, a new one
  /// will be created. In this situation, `update_mask` is ignored.
  @$pb.TagNumber(3)
  $core.bool get allowMissing => $_getBF(2);
  @$pb.TagNumber(3)
  set allowMissing($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAllowMissing() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowMissing() => clearField(3);

  /// Optional. If set to true, validate the request, but do not actually update.
  /// Note that a request being valid does not mean that the request is
  /// guaranteed to be fulfilled.
  @$pb.TagNumber(4)
  $core.bool get validateOnly => $_getBF(3);
  @$pb.TagNumber(4)
  set validateOnly($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasValidateOnly() => $_has(3);
  @$pb.TagNumber(4)
  void clearValidateOnly() => clearField(4);

  /// The list of quota safety checks to be ignored.
  @$pb.TagNumber(5)
  $core.List<$32.QuotaSafetyCheck> get ignoreSafetyChecks => $_getList(4);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
