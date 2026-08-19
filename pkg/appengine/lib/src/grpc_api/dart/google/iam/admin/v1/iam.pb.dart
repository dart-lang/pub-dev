//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/iam.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/field_mask.pb.dart' as $58;
import '../../../protobuf/timestamp.pb.dart' as $50;
import '../../../type/expr.pb.dart' as $114;
import 'iam.pbenum.dart';

export 'iam.pbenum.dart';

///  An IAM service account.
///
///  A service account is an account for an application or a virtual machine (VM)
///  instance, not a person. You can use a service account to call Google APIs. To
///  learn more, read the [overview of service
///  accounts](https://cloud.google.com/iam/help/service-accounts/overview).
///
///  When you create a service account, you specify the project ID that owns the
///  service account, as well as a name that must be unique within the project.
///  IAM uses these values to create an email address that identifies the service
///  account.
class ServiceAccount extends $pb.GeneratedMessage {
  factory ServiceAccount({
    $core.String? name,
    $core.String? projectId,
    $core.String? uniqueId,
    $core.String? email,
    $core.String? displayName,
    @$core.Deprecated('This field is deprecated.') $core.List<$core.int>? etag,
    $core.String? description,
    $core.String? oauth2ClientId,
    $core.bool? disabled,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (projectId != null) {
      $result.projectId = projectId;
    }
    if (uniqueId != null) {
      $result.uniqueId = uniqueId;
    }
    if (email != null) {
      $result.email = email;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (etag != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.etag = etag;
    }
    if (description != null) {
      $result.description = description;
    }
    if (oauth2ClientId != null) {
      $result.oauth2ClientId = oauth2ClientId;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    return $result;
  }
  ServiceAccount._() : super();
  factory ServiceAccount.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceAccount.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceAccount',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'projectId')
    ..aOS(4, _omitFieldNames ? '' : 'uniqueId')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'displayName')
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'etag', $pb.PbFieldType.OY)
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'oauth2ClientId')
    ..aOB(11, _omitFieldNames ? '' : 'disabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceAccount clone() => ServiceAccount()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceAccount copyWith(void Function(ServiceAccount) updates) =>
      super.copyWith((message) => updates(message as ServiceAccount))
          as ServiceAccount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceAccount create() => ServiceAccount._();
  ServiceAccount createEmptyInstance() => create();
  static $pb.PbList<ServiceAccount> createRepeated() =>
      $pb.PbList<ServiceAccount>();
  @$core.pragma('dart2js:noInline')
  static ServiceAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceAccount>(create);
  static ServiceAccount? _defaultInstance;

  ///  The resource name of the service account.
  ///
  ///  Use one of the following formats:
  ///
  ///  * `projects/{PROJECT_ID}/serviceAccounts/{EMAIL_ADDRESS}`
  ///  * `projects/{PROJECT_ID}/serviceAccounts/{UNIQUE_ID}`
  ///
  ///  As an alternative, you can use the `-` wildcard character instead of the
  ///  project ID:
  ///
  ///  * `projects/-/serviceAccounts/{EMAIL_ADDRESS}`
  ///  * `projects/-/serviceAccounts/{UNIQUE_ID}`
  ///
  ///  When possible, avoid using the `-` wildcard character, because it can cause
  ///  response messages to contain misleading error codes. For example, if you
  ///  try to get the service account
  ///  `projects/-/serviceAccounts/fake@example.com`, which does not exist, the
  ///  response contains an HTTP `403 Forbidden` error instead of a `404 Not
  ///  Found` error.
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

  /// Output only. The ID of the project that owns the service account.
  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set projectId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProjectId() => clearField(2);

  ///  Output only. The unique, stable numeric ID for the service account.
  ///
  ///  Each service account retains its unique ID even if you delete the service
  ///  account. For example, if you delete a service account, then create a new
  ///  service account with the same name, the new service account has a different
  ///  unique ID than the deleted service account.
  @$pb.TagNumber(4)
  $core.String get uniqueId => $_getSZ(2);
  @$pb.TagNumber(4)
  set uniqueId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasUniqueId() => $_has(2);
  @$pb.TagNumber(4)
  void clearUniqueId() => clearField(4);

  /// Output only. The email address of the service account.
  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(5)
  set email($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  /// Optional. A user-specified, human-readable name for the service account. The maximum
  /// length is 100 UTF-8 bytes.
  @$pb.TagNumber(6)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(6)
  set displayName($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(6)
  void clearDisplayName() => clearField(6);

  /// Deprecated. Do not use.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.List<$core.int> get etag => $_getN(5);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  set etag($core.List<$core.int> v) {
    $_setBytes(5, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.bool hasEtag() => $_has(5);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  void clearEtag() => clearField(7);

  /// Optional. A user-specified, human-readable description of the service account. The
  /// maximum length is 256 UTF-8 bytes.
  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(8)
  set description($core.String v) {
    $_setString(6, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  /// Output only. The OAuth 2.0 client ID for the service account.
  @$pb.TagNumber(9)
  $core.String get oauth2ClientId => $_getSZ(7);
  @$pb.TagNumber(9)
  set oauth2ClientId($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasOauth2ClientId() => $_has(7);
  @$pb.TagNumber(9)
  void clearOauth2ClientId() => clearField(9);

  /// Output only. Whether the service account is disabled.
  @$pb.TagNumber(11)
  $core.bool get disabled => $_getBF(8);
  @$pb.TagNumber(11)
  set disabled($core.bool v) {
    $_setBool(8, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasDisabled() => $_has(8);
  @$pb.TagNumber(11)
  void clearDisabled() => clearField(11);
}

/// The service account create request.
class CreateServiceAccountRequest extends $pb.GeneratedMessage {
  factory CreateServiceAccountRequest({
    $core.String? name,
    $core.String? accountId,
    ServiceAccount? serviceAccount,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (serviceAccount != null) {
      $result.serviceAccount = serviceAccount;
    }
    return $result;
  }
  CreateServiceAccountRequest._() : super();
  factory CreateServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'accountId')
    ..aOM<ServiceAccount>(3, _omitFieldNames ? '' : 'serviceAccount',
        subBuilder: ServiceAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateServiceAccountRequest clone() =>
      CreateServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateServiceAccountRequest copyWith(
          void Function(CreateServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateServiceAccountRequest))
          as CreateServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateServiceAccountRequest create() =>
      CreateServiceAccountRequest._();
  CreateServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateServiceAccountRequest> createRepeated() =>
      $pb.PbList<CreateServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateServiceAccountRequest>(create);
  static CreateServiceAccountRequest? _defaultInstance;

  /// Required. The resource name of the project associated with the service
  /// accounts, such as `projects/my-project-123`.
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

  /// Required. The account id that is used to generate the service account
  /// email address and a stable unique id. It is unique within a project,
  /// must be 6-30 characters long, and match the regular expression
  /// `[a-z]([-a-z0-9]*[a-z0-9])` to comply with RFC1035.
  @$pb.TagNumber(2)
  $core.String get accountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set accountId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccountId() => clearField(2);

  /// The [ServiceAccount][google.iam.admin.v1.ServiceAccount] resource to
  /// create. Currently, only the following values are user assignable:
  /// `display_name` and `description`.
  @$pb.TagNumber(3)
  ServiceAccount get serviceAccount => $_getN(2);
  @$pb.TagNumber(3)
  set serviceAccount(ServiceAccount v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasServiceAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearServiceAccount() => clearField(3);
  @$pb.TagNumber(3)
  ServiceAccount ensureServiceAccount() => $_ensure(2);
}

/// The service account list request.
class ListServiceAccountsRequest extends $pb.GeneratedMessage {
  factory ListServiceAccountsRequest({
    $core.String? name,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListServiceAccountsRequest._() : super();
  factory ListServiceAccountsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceAccountsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceAccountsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceAccountsRequest clone() =>
      ListServiceAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceAccountsRequest copyWith(
          void Function(ListServiceAccountsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceAccountsRequest))
          as ListServiceAccountsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceAccountsRequest create() => ListServiceAccountsRequest._();
  ListServiceAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<ListServiceAccountsRequest> createRepeated() =>
      $pb.PbList<ListServiceAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListServiceAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceAccountsRequest>(create);
  static ListServiceAccountsRequest? _defaultInstance;

  /// Required. The resource name of the project associated with the service
  /// accounts, such as `projects/my-project-123`.
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

  ///  Optional limit on the number of service accounts to include in the
  ///  response. Further accounts can subsequently be obtained by including the
  ///  [ListServiceAccountsResponse.next_page_token][google.iam.admin.v1.ListServiceAccountsResponse.next_page_token]
  ///  in a subsequent request.
  ///
  ///  The default is 20, and the maximum is 100.
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

  /// Optional pagination token returned in an earlier
  /// [ListServiceAccountsResponse.next_page_token][google.iam.admin.v1.ListServiceAccountsResponse.next_page_token].
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

/// The service account list response.
class ListServiceAccountsResponse extends $pb.GeneratedMessage {
  factory ListServiceAccountsResponse({
    $core.Iterable<ServiceAccount>? accounts,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (accounts != null) {
      $result.accounts.addAll(accounts);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListServiceAccountsResponse._() : super();
  factory ListServiceAccountsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceAccountsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceAccountsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<ServiceAccount>(
        1, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: ServiceAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceAccountsResponse clone() =>
      ListServiceAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceAccountsResponse copyWith(
          void Function(ListServiceAccountsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceAccountsResponse))
          as ListServiceAccountsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceAccountsResponse create() =>
      ListServiceAccountsResponse._();
  ListServiceAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<ListServiceAccountsResponse> createRepeated() =>
      $pb.PbList<ListServiceAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListServiceAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceAccountsResponse>(create);
  static ListServiceAccountsResponse? _defaultInstance;

  /// The list of matching service accounts.
  @$pb.TagNumber(1)
  $core.List<ServiceAccount> get accounts => $_getList(0);

  /// To retrieve the next page of results, set
  /// [ListServiceAccountsRequest.page_token][google.iam.admin.v1.ListServiceAccountsRequest.page_token]
  /// to this value.
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

/// The service account get request.
class GetServiceAccountRequest extends $pb.GeneratedMessage {
  factory GetServiceAccountRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetServiceAccountRequest._() : super();
  factory GetServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceAccountRequest clone() =>
      GetServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceAccountRequest copyWith(
          void Function(GetServiceAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetServiceAccountRequest))
          as GetServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceAccountRequest create() => GetServiceAccountRequest._();
  GetServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceAccountRequest> createRepeated() =>
      $pb.PbList<GetServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceAccountRequest>(create);
  static GetServiceAccountRequest? _defaultInstance;

  /// Required. The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

/// The service account delete request.
class DeleteServiceAccountRequest extends $pb.GeneratedMessage {
  factory DeleteServiceAccountRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteServiceAccountRequest._() : super();
  factory DeleteServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteServiceAccountRequest clone() =>
      DeleteServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteServiceAccountRequest copyWith(
          void Function(DeleteServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteServiceAccountRequest))
          as DeleteServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteServiceAccountRequest create() =>
      DeleteServiceAccountRequest._();
  DeleteServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteServiceAccountRequest> createRepeated() =>
      $pb.PbList<DeleteServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteServiceAccountRequest>(create);
  static DeleteServiceAccountRequest? _defaultInstance;

  /// Required. The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

///  The service account patch request.
///
///  You can patch only the `display_name` and `description` fields. You must use
///  the `update_mask` field to specify which of these fields you want to patch.
///
///  Only the fields specified in the request are guaranteed to be returned in
///  the response. Other fields may be empty in the response.
class PatchServiceAccountRequest extends $pb.GeneratedMessage {
  factory PatchServiceAccountRequest({
    ServiceAccount? serviceAccount,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (serviceAccount != null) {
      $result.serviceAccount = serviceAccount;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  PatchServiceAccountRequest._() : super();
  factory PatchServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory PatchServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PatchServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOM<ServiceAccount>(1, _omitFieldNames ? '' : 'serviceAccount',
        subBuilder: ServiceAccount.create)
    ..aOM<$58.FieldMask>(2, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  PatchServiceAccountRequest clone() =>
      PatchServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  PatchServiceAccountRequest copyWith(
          void Function(PatchServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as PatchServiceAccountRequest))
          as PatchServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PatchServiceAccountRequest create() => PatchServiceAccountRequest._();
  PatchServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<PatchServiceAccountRequest> createRepeated() =>
      $pb.PbList<PatchServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static PatchServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PatchServiceAccountRequest>(create);
  static PatchServiceAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ServiceAccount get serviceAccount => $_getN(0);
  @$pb.TagNumber(1)
  set serviceAccount(ServiceAccount v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasServiceAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearServiceAccount() => clearField(1);
  @$pb.TagNumber(1)
  ServiceAccount ensureServiceAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $58.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($58.FieldMask v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $58.FieldMask ensureUpdateMask() => $_ensure(1);
}

/// The service account undelete request.
class UndeleteServiceAccountRequest extends $pb.GeneratedMessage {
  factory UndeleteServiceAccountRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  UndeleteServiceAccountRequest._() : super();
  factory UndeleteServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteServiceAccountRequest clone() =>
      UndeleteServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteServiceAccountRequest copyWith(
          void Function(UndeleteServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UndeleteServiceAccountRequest))
          as UndeleteServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteServiceAccountRequest create() =>
      UndeleteServiceAccountRequest._();
  UndeleteServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UndeleteServiceAccountRequest> createRepeated() =>
      $pb.PbList<UndeleteServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UndeleteServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndeleteServiceAccountRequest>(create);
  static UndeleteServiceAccountRequest? _defaultInstance;

  /// The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT_UNIQUE_ID}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account.
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

class UndeleteServiceAccountResponse extends $pb.GeneratedMessage {
  factory UndeleteServiceAccountResponse({
    ServiceAccount? restoredAccount,
  }) {
    final $result = create();
    if (restoredAccount != null) {
      $result.restoredAccount = restoredAccount;
    }
    return $result;
  }
  UndeleteServiceAccountResponse._() : super();
  factory UndeleteServiceAccountResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteServiceAccountResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteServiceAccountResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOM<ServiceAccount>(1, _omitFieldNames ? '' : 'restoredAccount',
        subBuilder: ServiceAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteServiceAccountResponse clone() =>
      UndeleteServiceAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteServiceAccountResponse copyWith(
          void Function(UndeleteServiceAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UndeleteServiceAccountResponse))
          as UndeleteServiceAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteServiceAccountResponse create() =>
      UndeleteServiceAccountResponse._();
  UndeleteServiceAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UndeleteServiceAccountResponse> createRepeated() =>
      $pb.PbList<UndeleteServiceAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UndeleteServiceAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndeleteServiceAccountResponse>(create);
  static UndeleteServiceAccountResponse? _defaultInstance;

  /// Metadata for the restored service account.
  @$pb.TagNumber(1)
  ServiceAccount get restoredAccount => $_getN(0);
  @$pb.TagNumber(1)
  set restoredAccount(ServiceAccount v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRestoredAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearRestoredAccount() => clearField(1);
  @$pb.TagNumber(1)
  ServiceAccount ensureRestoredAccount() => $_ensure(0);
}

/// The service account enable request.
class EnableServiceAccountRequest extends $pb.GeneratedMessage {
  factory EnableServiceAccountRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  EnableServiceAccountRequest._() : super();
  factory EnableServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnableServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnableServiceAccountRequest clone() =>
      EnableServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnableServiceAccountRequest copyWith(
          void Function(EnableServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EnableServiceAccountRequest))
          as EnableServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableServiceAccountRequest create() =>
      EnableServiceAccountRequest._();
  EnableServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<EnableServiceAccountRequest> createRepeated() =>
      $pb.PbList<EnableServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableServiceAccountRequest>(create);
  static EnableServiceAccountRequest? _defaultInstance;

  /// The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

/// The service account disable request.
class DisableServiceAccountRequest extends $pb.GeneratedMessage {
  factory DisableServiceAccountRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DisableServiceAccountRequest._() : super();
  factory DisableServiceAccountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisableServiceAccountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableServiceAccountRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisableServiceAccountRequest clone() =>
      DisableServiceAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisableServiceAccountRequest copyWith(
          void Function(DisableServiceAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DisableServiceAccountRequest))
          as DisableServiceAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableServiceAccountRequest create() =>
      DisableServiceAccountRequest._();
  DisableServiceAccountRequest createEmptyInstance() => create();
  static $pb.PbList<DisableServiceAccountRequest> createRepeated() =>
      $pb.PbList<DisableServiceAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableServiceAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableServiceAccountRequest>(create);
  static DisableServiceAccountRequest? _defaultInstance;

  /// The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

/// The service account keys list request.
class ListServiceAccountKeysRequest extends $pb.GeneratedMessage {
  factory ListServiceAccountKeysRequest({
    $core.String? name,
    $core.Iterable<ListServiceAccountKeysRequest_KeyType>? keyTypes,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (keyTypes != null) {
      $result.keyTypes.addAll(keyTypes);
    }
    return $result;
  }
  ListServiceAccountKeysRequest._() : super();
  factory ListServiceAccountKeysRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceAccountKeysRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceAccountKeysRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pc<ListServiceAccountKeysRequest_KeyType>(
        2, _omitFieldNames ? '' : 'keyTypes', $pb.PbFieldType.KE,
        valueOf: ListServiceAccountKeysRequest_KeyType.valueOf,
        enumValues: ListServiceAccountKeysRequest_KeyType.values,
        defaultEnumValue:
            ListServiceAccountKeysRequest_KeyType.KEY_TYPE_UNSPECIFIED)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceAccountKeysRequest clone() =>
      ListServiceAccountKeysRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceAccountKeysRequest copyWith(
          void Function(ListServiceAccountKeysRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceAccountKeysRequest))
          as ListServiceAccountKeysRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceAccountKeysRequest create() =>
      ListServiceAccountKeysRequest._();
  ListServiceAccountKeysRequest createEmptyInstance() => create();
  static $pb.PbList<ListServiceAccountKeysRequest> createRepeated() =>
      $pb.PbList<ListServiceAccountKeysRequest>();
  @$core.pragma('dart2js:noInline')
  static ListServiceAccountKeysRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceAccountKeysRequest>(create);
  static ListServiceAccountKeysRequest? _defaultInstance;

  ///  Required. The resource name of the service account in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  ///
  ///  Using `-` as a wildcard for the `PROJECT_ID`, will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
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

  /// Filters the types of keys the user wants to include in the list
  /// response. Duplicate key types are not allowed. If no key type
  /// is provided, all keys are returned.
  @$pb.TagNumber(2)
  $core.List<ListServiceAccountKeysRequest_KeyType> get keyTypes =>
      $_getList(1);
}

/// The service account keys list response.
class ListServiceAccountKeysResponse extends $pb.GeneratedMessage {
  factory ListServiceAccountKeysResponse({
    $core.Iterable<ServiceAccountKey>? keys,
  }) {
    final $result = create();
    if (keys != null) {
      $result.keys.addAll(keys);
    }
    return $result;
  }
  ListServiceAccountKeysResponse._() : super();
  factory ListServiceAccountKeysResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListServiceAccountKeysResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListServiceAccountKeysResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<ServiceAccountKey>(
        1, _omitFieldNames ? '' : 'keys', $pb.PbFieldType.PM,
        subBuilder: ServiceAccountKey.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListServiceAccountKeysResponse clone() =>
      ListServiceAccountKeysResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListServiceAccountKeysResponse copyWith(
          void Function(ListServiceAccountKeysResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListServiceAccountKeysResponse))
          as ListServiceAccountKeysResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListServiceAccountKeysResponse create() =>
      ListServiceAccountKeysResponse._();
  ListServiceAccountKeysResponse createEmptyInstance() => create();
  static $pb.PbList<ListServiceAccountKeysResponse> createRepeated() =>
      $pb.PbList<ListServiceAccountKeysResponse>();
  @$core.pragma('dart2js:noInline')
  static ListServiceAccountKeysResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListServiceAccountKeysResponse>(create);
  static ListServiceAccountKeysResponse? _defaultInstance;

  /// The public keys for the service account.
  @$pb.TagNumber(1)
  $core.List<ServiceAccountKey> get keys => $_getList(0);
}

/// The service account key get by id request.
class GetServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory GetServiceAccountKeyRequest({
    $core.String? name,
    ServiceAccountPublicKeyType? publicKeyType,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (publicKeyType != null) {
      $result.publicKeyType = publicKeyType;
    }
    return $result;
  }
  GetServiceAccountKeyRequest._() : super();
  factory GetServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<ServiceAccountPublicKeyType>(
        2, _omitFieldNames ? '' : 'publicKeyType', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountPublicKeyType.TYPE_NONE,
        valueOf: ServiceAccountPublicKeyType.valueOf,
        enumValues: ServiceAccountPublicKeyType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetServiceAccountKeyRequest clone() =>
      GetServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetServiceAccountKeyRequest copyWith(
          void Function(GetServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetServiceAccountKeyRequest))
          as GetServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetServiceAccountKeyRequest create() =>
      GetServiceAccountKeyRequest._();
  GetServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<GetServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<GetServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static GetServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetServiceAccountKeyRequest>(create);
  static GetServiceAccountKeyRequest? _defaultInstance;

  ///  Required. The resource name of the service account key in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
  ///
  ///  Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
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

  /// Optional. The output format of the public key. The default is `TYPE_NONE`, which
  /// means that the public key is not returned.
  @$pb.TagNumber(2)
  ServiceAccountPublicKeyType get publicKeyType => $_getN(1);
  @$pb.TagNumber(2)
  set publicKeyType(ServiceAccountPublicKeyType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPublicKeyType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKeyType() => clearField(2);
}

///  Represents a service account key.
///
///  A service account has two sets of key-pairs: user-managed, and
///  system-managed.
///
///  User-managed key-pairs can be created and deleted by users.  Users are
///  responsible for rotating these keys periodically to ensure security of
///  their service accounts.  Users retain the private key of these key-pairs,
///  and Google retains ONLY the public key.
///
///  System-managed keys are automatically rotated by Google, and are used for
///  signing for a maximum of two weeks. The rotation process is probabilistic,
///  and usage of the new key will gradually ramp up and down over the key's
///  lifetime.
///
///  If you cache the public key set for a service account, we recommend that you
///  update the cache every 15 minutes. User-managed keys can be added and removed
///  at any time, so it is important to update the cache frequently. For
///  Google-managed keys, Google will publish a key at least 6 hours before it is
///  first used for signing and will keep publishing it for at least 6 hours after
///  it was last used for signing.
///
///  Public keys for all service accounts are also published at the OAuth2
///  Service Account API.
class ServiceAccountKey extends $pb.GeneratedMessage {
  factory ServiceAccountKey({
    $core.String? name,
    ServiceAccountPrivateKeyType? privateKeyType,
    $core.List<$core.int>? privateKeyData,
    $50.Timestamp? validAfterTime,
    $50.Timestamp? validBeforeTime,
    $core.List<$core.int>? publicKeyData,
    ServiceAccountKeyAlgorithm? keyAlgorithm,
    ServiceAccountKeyOrigin? keyOrigin,
    ListServiceAccountKeysRequest_KeyType? keyType,
    $core.bool? disabled,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (privateKeyType != null) {
      $result.privateKeyType = privateKeyType;
    }
    if (privateKeyData != null) {
      $result.privateKeyData = privateKeyData;
    }
    if (validAfterTime != null) {
      $result.validAfterTime = validAfterTime;
    }
    if (validBeforeTime != null) {
      $result.validBeforeTime = validBeforeTime;
    }
    if (publicKeyData != null) {
      $result.publicKeyData = publicKeyData;
    }
    if (keyAlgorithm != null) {
      $result.keyAlgorithm = keyAlgorithm;
    }
    if (keyOrigin != null) {
      $result.keyOrigin = keyOrigin;
    }
    if (keyType != null) {
      $result.keyType = keyType;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    return $result;
  }
  ServiceAccountKey._() : super();
  factory ServiceAccountKey.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ServiceAccountKey.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceAccountKey',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<ServiceAccountPrivateKeyType>(
        2, _omitFieldNames ? '' : 'privateKeyType', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountPrivateKeyType.TYPE_UNSPECIFIED,
        valueOf: ServiceAccountPrivateKeyType.valueOf,
        enumValues: ServiceAccountPrivateKeyType.values)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'privateKeyData', $pb.PbFieldType.OY)
    ..aOM<$50.Timestamp>(4, _omitFieldNames ? '' : 'validAfterTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<$50.Timestamp>(5, _omitFieldNames ? '' : 'validBeforeTime',
        subBuilder: $50.Timestamp.create)
    ..a<$core.List<$core.int>>(
        7, _omitFieldNames ? '' : 'publicKeyData', $pb.PbFieldType.OY)
    ..e<ServiceAccountKeyAlgorithm>(
        8, _omitFieldNames ? '' : 'keyAlgorithm', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountKeyAlgorithm.KEY_ALG_UNSPECIFIED,
        valueOf: ServiceAccountKeyAlgorithm.valueOf,
        enumValues: ServiceAccountKeyAlgorithm.values)
    ..e<ServiceAccountKeyOrigin>(
        9, _omitFieldNames ? '' : 'keyOrigin', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountKeyOrigin.ORIGIN_UNSPECIFIED,
        valueOf: ServiceAccountKeyOrigin.valueOf,
        enumValues: ServiceAccountKeyOrigin.values)
    ..e<ListServiceAccountKeysRequest_KeyType>(
        10, _omitFieldNames ? '' : 'keyType', $pb.PbFieldType.OE,
        defaultOrMaker:
            ListServiceAccountKeysRequest_KeyType.KEY_TYPE_UNSPECIFIED,
        valueOf: ListServiceAccountKeysRequest_KeyType.valueOf,
        enumValues: ListServiceAccountKeysRequest_KeyType.values)
    ..aOB(11, _omitFieldNames ? '' : 'disabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ServiceAccountKey clone() => ServiceAccountKey()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ServiceAccountKey copyWith(void Function(ServiceAccountKey) updates) =>
      super.copyWith((message) => updates(message as ServiceAccountKey))
          as ServiceAccountKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServiceAccountKey create() => ServiceAccountKey._();
  ServiceAccountKey createEmptyInstance() => create();
  static $pb.PbList<ServiceAccountKey> createRepeated() =>
      $pb.PbList<ServiceAccountKey>();
  @$core.pragma('dart2js:noInline')
  static ServiceAccountKey getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ServiceAccountKey>(create);
  static ServiceAccountKey? _defaultInstance;

  /// The resource name of the service account key in the following format
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
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

  ///  The output format for the private key.
  ///  Only provided in `CreateServiceAccountKey` responses, not
  ///  in `GetServiceAccountKey` or `ListServiceAccountKey` responses.
  ///
  ///  Google never exposes system-managed private keys, and never retains
  ///  user-managed private keys.
  @$pb.TagNumber(2)
  ServiceAccountPrivateKeyType get privateKeyType => $_getN(1);
  @$pb.TagNumber(2)
  set privateKeyType(ServiceAccountPrivateKeyType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrivateKeyType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrivateKeyType() => clearField(2);

  /// The private key data. Only provided in `CreateServiceAccountKey`
  /// responses. Make sure to keep the private key data secure because it
  /// allows for the assertion of the service account identity.
  /// When base64 decoded, the private key data can be used to authenticate with
  /// Google API client libraries and with
  /// <a href="/sdk/gcloud/reference/auth/activate-service-account">gcloud
  /// auth activate-service-account</a>.
  @$pb.TagNumber(3)
  $core.List<$core.int> get privateKeyData => $_getN(2);
  @$pb.TagNumber(3)
  set privateKeyData($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasPrivateKeyData() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrivateKeyData() => clearField(3);

  /// The key can be used after this timestamp.
  @$pb.TagNumber(4)
  $50.Timestamp get validAfterTime => $_getN(3);
  @$pb.TagNumber(4)
  set validAfterTime($50.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasValidAfterTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearValidAfterTime() => clearField(4);
  @$pb.TagNumber(4)
  $50.Timestamp ensureValidAfterTime() => $_ensure(3);

  /// The key can be used before this timestamp.
  /// For system-managed key pairs, this timestamp is the end time for the
  /// private key signing operation. The public key could still be used
  /// for verification for a few hours after this time.
  @$pb.TagNumber(5)
  $50.Timestamp get validBeforeTime => $_getN(4);
  @$pb.TagNumber(5)
  set validBeforeTime($50.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasValidBeforeTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearValidBeforeTime() => clearField(5);
  @$pb.TagNumber(5)
  $50.Timestamp ensureValidBeforeTime() => $_ensure(4);

  /// The public key data. Only provided in `GetServiceAccountKey` responses.
  @$pb.TagNumber(7)
  $core.List<$core.int> get publicKeyData => $_getN(5);
  @$pb.TagNumber(7)
  set publicKeyData($core.List<$core.int> v) {
    $_setBytes(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasPublicKeyData() => $_has(5);
  @$pb.TagNumber(7)
  void clearPublicKeyData() => clearField(7);

  /// Specifies the algorithm (and possibly key size) for the key.
  @$pb.TagNumber(8)
  ServiceAccountKeyAlgorithm get keyAlgorithm => $_getN(6);
  @$pb.TagNumber(8)
  set keyAlgorithm(ServiceAccountKeyAlgorithm v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasKeyAlgorithm() => $_has(6);
  @$pb.TagNumber(8)
  void clearKeyAlgorithm() => clearField(8);

  /// The key origin.
  @$pb.TagNumber(9)
  ServiceAccountKeyOrigin get keyOrigin => $_getN(7);
  @$pb.TagNumber(9)
  set keyOrigin(ServiceAccountKeyOrigin v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasKeyOrigin() => $_has(7);
  @$pb.TagNumber(9)
  void clearKeyOrigin() => clearField(9);

  /// The key type.
  @$pb.TagNumber(10)
  ListServiceAccountKeysRequest_KeyType get keyType => $_getN(8);
  @$pb.TagNumber(10)
  set keyType(ListServiceAccountKeysRequest_KeyType v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasKeyType() => $_has(8);
  @$pb.TagNumber(10)
  void clearKeyType() => clearField(10);

  /// The key status.
  @$pb.TagNumber(11)
  $core.bool get disabled => $_getBF(9);
  @$pb.TagNumber(11)
  set disabled($core.bool v) {
    $_setBool(9, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasDisabled() => $_has(9);
  @$pb.TagNumber(11)
  void clearDisabled() => clearField(11);
}

/// The service account key create request.
class CreateServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory CreateServiceAccountKeyRequest({
    $core.String? name,
    ServiceAccountPrivateKeyType? privateKeyType,
    ServiceAccountKeyAlgorithm? keyAlgorithm,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (privateKeyType != null) {
      $result.privateKeyType = privateKeyType;
    }
    if (keyAlgorithm != null) {
      $result.keyAlgorithm = keyAlgorithm;
    }
    return $result;
  }
  CreateServiceAccountKeyRequest._() : super();
  factory CreateServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..e<ServiceAccountPrivateKeyType>(
        2, _omitFieldNames ? '' : 'privateKeyType', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountPrivateKeyType.TYPE_UNSPECIFIED,
        valueOf: ServiceAccountPrivateKeyType.valueOf,
        enumValues: ServiceAccountPrivateKeyType.values)
    ..e<ServiceAccountKeyAlgorithm>(
        3, _omitFieldNames ? '' : 'keyAlgorithm', $pb.PbFieldType.OE,
        defaultOrMaker: ServiceAccountKeyAlgorithm.KEY_ALG_UNSPECIFIED,
        valueOf: ServiceAccountKeyAlgorithm.valueOf,
        enumValues: ServiceAccountKeyAlgorithm.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateServiceAccountKeyRequest clone() =>
      CreateServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateServiceAccountKeyRequest copyWith(
          void Function(CreateServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateServiceAccountKeyRequest))
          as CreateServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateServiceAccountKeyRequest create() =>
      CreateServiceAccountKeyRequest._();
  CreateServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<CreateServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<CreateServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateServiceAccountKeyRequest>(create);
  static CreateServiceAccountKeyRequest? _defaultInstance;

  /// Required. The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

  /// The output format of the private key. The default value is
  /// `TYPE_GOOGLE_CREDENTIALS_FILE`, which is the Google Credentials File
  /// format.
  @$pb.TagNumber(2)
  ServiceAccountPrivateKeyType get privateKeyType => $_getN(1);
  @$pb.TagNumber(2)
  set privateKeyType(ServiceAccountPrivateKeyType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrivateKeyType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrivateKeyType() => clearField(2);

  /// Which type of key and algorithm to use for the key.
  /// The default is currently a 2K RSA key.  However this may change in the
  /// future.
  @$pb.TagNumber(3)
  ServiceAccountKeyAlgorithm get keyAlgorithm => $_getN(2);
  @$pb.TagNumber(3)
  set keyAlgorithm(ServiceAccountKeyAlgorithm v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasKeyAlgorithm() => $_has(2);
  @$pb.TagNumber(3)
  void clearKeyAlgorithm() => clearField(3);
}

/// The service account key upload request.
class UploadServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory UploadServiceAccountKeyRequest({
    $core.String? name,
    $core.List<$core.int>? publicKeyData,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (publicKeyData != null) {
      $result.publicKeyData = publicKeyData;
    }
    return $result;
  }
  UploadServiceAccountKeyRequest._() : super();
  factory UploadServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UploadServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'publicKeyData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UploadServiceAccountKeyRequest clone() =>
      UploadServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UploadServiceAccountKeyRequest copyWith(
          void Function(UploadServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UploadServiceAccountKeyRequest))
          as UploadServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadServiceAccountKeyRequest create() =>
      UploadServiceAccountKeyRequest._();
  UploadServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<UploadServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<UploadServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadServiceAccountKeyRequest>(create);
  static UploadServiceAccountKeyRequest? _defaultInstance;

  /// The resource name of the service account in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

  /// The public key to associate with the service account. Must be an RSA public
  /// key that is wrapped in an X.509 v3 certificate. Include the first line,
  /// `-----BEGIN CERTIFICATE-----`, and the last line,
  /// `-----END CERTIFICATE-----`.
  @$pb.TagNumber(2)
  $core.List<$core.int> get publicKeyData => $_getN(1);
  @$pb.TagNumber(2)
  set publicKeyData($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPublicKeyData() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKeyData() => clearField(2);
}

/// The service account key delete request.
class DeleteServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory DeleteServiceAccountKeyRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DeleteServiceAccountKeyRequest._() : super();
  factory DeleteServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteServiceAccountKeyRequest clone() =>
      DeleteServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteServiceAccountKeyRequest copyWith(
          void Function(DeleteServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteServiceAccountKeyRequest))
          as DeleteServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteServiceAccountKeyRequest create() =>
      DeleteServiceAccountKeyRequest._();
  DeleteServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<DeleteServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteServiceAccountKeyRequest>(create);
  static DeleteServiceAccountKeyRequest? _defaultInstance;

  /// Required. The resource name of the service account key in the following format:
  /// `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
  /// Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  /// the account. The `ACCOUNT` value can be the `email` address or the
  /// `unique_id` of the service account.
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

/// The service account key disable request.
class DisableServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory DisableServiceAccountKeyRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  DisableServiceAccountKeyRequest._() : super();
  factory DisableServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DisableServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DisableServiceAccountKeyRequest clone() =>
      DisableServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DisableServiceAccountKeyRequest copyWith(
          void Function(DisableServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DisableServiceAccountKeyRequest))
          as DisableServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableServiceAccountKeyRequest create() =>
      DisableServiceAccountKeyRequest._();
  DisableServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<DisableServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<DisableServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableServiceAccountKeyRequest>(
          create);
  static DisableServiceAccountKeyRequest? _defaultInstance;

  ///  Required. The resource name of the service account key in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
  ///
  ///  Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
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

/// The service account key enable request.
class EnableServiceAccountKeyRequest extends $pb.GeneratedMessage {
  factory EnableServiceAccountKeyRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  EnableServiceAccountKeyRequest._() : super();
  factory EnableServiceAccountKeyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory EnableServiceAccountKeyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableServiceAccountKeyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  EnableServiceAccountKeyRequest clone() =>
      EnableServiceAccountKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  EnableServiceAccountKeyRequest copyWith(
          void Function(EnableServiceAccountKeyRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EnableServiceAccountKeyRequest))
          as EnableServiceAccountKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableServiceAccountKeyRequest create() =>
      EnableServiceAccountKeyRequest._();
  EnableServiceAccountKeyRequest createEmptyInstance() => create();
  static $pb.PbList<EnableServiceAccountKeyRequest> createRepeated() =>
      $pb.PbList<EnableServiceAccountKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableServiceAccountKeyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableServiceAccountKeyRequest>(create);
  static EnableServiceAccountKeyRequest? _defaultInstance;

  ///  Required. The resource name of the service account key in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}/keys/{key}`.
  ///
  ///  Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
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

///  Deprecated. [Migrate to Service Account Credentials
///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
///
///  The service account sign blob request.
class SignBlobRequest extends $pb.GeneratedMessage {
  factory SignBlobRequest({
    @$core.Deprecated('This field is deprecated.') $core.String? name,
    @$core.Deprecated('This field is deprecated.')
    $core.List<$core.int>? bytesToSign,
  }) {
    final $result = create();
    if (name != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.name = name;
    }
    if (bytesToSign != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.bytesToSign = bytesToSign;
    }
    return $result;
  }
  SignBlobRequest._() : super();
  factory SignBlobRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignBlobRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignBlobRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'bytesToSign', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignBlobRequest clone() => SignBlobRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignBlobRequest copyWith(void Function(SignBlobRequest) updates) =>
      super.copyWith((message) => updates(message as SignBlobRequest))
          as SignBlobRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignBlobRequest create() => SignBlobRequest._();
  SignBlobRequest createEmptyInstance() => create();
  static $pb.PbList<SignBlobRequest> createRepeated() =>
      $pb.PbList<SignBlobRequest>();
  @$core.pragma('dart2js:noInline')
  static SignBlobRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignBlobRequest>(create);
  static SignBlobRequest? _defaultInstance;

  ///  Required. Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The resource name of the service account in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  ///  Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  ///  Required. Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The bytes to sign.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.List<$core.int> get bytesToSign => $_getN(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set bytesToSign($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasBytesToSign() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearBytesToSign() => clearField(2);
}

///  Deprecated. [Migrate to Service Account Credentials
///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
///
///  The service account sign blob response.
class SignBlobResponse extends $pb.GeneratedMessage {
  factory SignBlobResponse({
    @$core.Deprecated('This field is deprecated.') $core.String? keyId,
    @$core.Deprecated('This field is deprecated.')
    $core.List<$core.int>? signature,
  }) {
    final $result = create();
    if (keyId != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.keyId = keyId;
    }
    if (signature != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.signature = signature;
    }
    return $result;
  }
  SignBlobResponse._() : super();
  factory SignBlobResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignBlobResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignBlobResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignBlobResponse clone() => SignBlobResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignBlobResponse copyWith(void Function(SignBlobResponse) updates) =>
      super.copyWith((message) => updates(message as SignBlobResponse))
          as SignBlobResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignBlobResponse create() => SignBlobResponse._();
  SignBlobResponse createEmptyInstance() => create();
  static $pb.PbList<SignBlobResponse> createRepeated() =>
      $pb.PbList<SignBlobResponse>();
  @$core.pragma('dart2js:noInline')
  static SignBlobResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignBlobResponse>(create);
  static SignBlobResponse? _defaultInstance;

  ///  Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The id of the key used to sign the blob.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get keyId => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set keyId($core.String v) {
    $_setString(0, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasKeyId() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearKeyId() => clearField(1);

  ///  Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The signed blob.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearSignature() => clearField(2);
}

///  Deprecated. [Migrate to Service Account Credentials
///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
///
///  The service account sign JWT request.
class SignJwtRequest extends $pb.GeneratedMessage {
  factory SignJwtRequest({
    @$core.Deprecated('This field is deprecated.') $core.String? name,
    @$core.Deprecated('This field is deprecated.') $core.String? payload,
  }) {
    final $result = create();
    if (name != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.name = name;
    }
    if (payload != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.payload = payload;
    }
    return $result;
  }
  SignJwtRequest._() : super();
  factory SignJwtRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignJwtRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignJwtRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'payload')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignJwtRequest clone() => SignJwtRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignJwtRequest copyWith(void Function(SignJwtRequest) updates) =>
      super.copyWith((message) => updates(message as SignJwtRequest))
          as SignJwtRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignJwtRequest create() => SignJwtRequest._();
  SignJwtRequest createEmptyInstance() => create();
  static $pb.PbList<SignJwtRequest> createRepeated() =>
      $pb.PbList<SignJwtRequest>();
  @$core.pragma('dart2js:noInline')
  static SignJwtRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignJwtRequest>(create);
  static SignJwtRequest? _defaultInstance;

  ///  Required. Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The resource name of the service account in the following format:
  ///  `projects/{PROJECT_ID}/serviceAccounts/{ACCOUNT}`.
  ///  Using `-` as a wildcard for the `PROJECT_ID` will infer the project from
  ///  the account. The `ACCOUNT` value can be the `email` address or the
  ///  `unique_id` of the service account.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  ///  Required. Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The JWT payload to sign. Must be a serialized JSON object that contains a
  ///  JWT Claims Set. For example: `{"sub": "user@example.com", "iat": 313435}`
  ///
  ///  If the JWT Claims Set contains an expiration time (`exp`) claim, it must be
  ///  an integer timestamp that is not in the past and no more than 12 hours in
  ///  the future.
  ///
  ///  If the JWT Claims Set does not contain an expiration time (`exp`) claim,
  ///  this claim is added automatically, with a timestamp that is 1 hour in the
  ///  future.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.String get payload => $_getSZ(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set payload($core.String v) {
    $_setString(1, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearPayload() => clearField(2);
}

///  Deprecated. [Migrate to Service Account Credentials
///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
///
///  The service account sign JWT response.
class SignJwtResponse extends $pb.GeneratedMessage {
  factory SignJwtResponse({
    @$core.Deprecated('This field is deprecated.') $core.String? keyId,
    @$core.Deprecated('This field is deprecated.') $core.String? signedJwt,
  }) {
    final $result = create();
    if (keyId != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.keyId = keyId;
    }
    if (signedJwt != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.signedJwt = signedJwt;
    }
    return $result;
  }
  SignJwtResponse._() : super();
  factory SignJwtResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignJwtResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignJwtResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyId')
    ..aOS(2, _omitFieldNames ? '' : 'signedJwt')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignJwtResponse clone() => SignJwtResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignJwtResponse copyWith(void Function(SignJwtResponse) updates) =>
      super.copyWith((message) => updates(message as SignJwtResponse))
          as SignJwtResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignJwtResponse create() => SignJwtResponse._();
  SignJwtResponse createEmptyInstance() => create();
  static $pb.PbList<SignJwtResponse> createRepeated() =>
      $pb.PbList<SignJwtResponse>();
  @$core.pragma('dart2js:noInline')
  static SignJwtResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignJwtResponse>(create);
  static SignJwtResponse? _defaultInstance;

  ///  Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The id of the key used to sign the JWT.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get keyId => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set keyId($core.String v) {
    $_setString(0, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasKeyId() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearKeyId() => clearField(1);

  ///  Deprecated. [Migrate to Service Account Credentials
  ///  API](https://cloud.google.com/iam/help/credentials/migrate-api).
  ///
  ///  The signed JWT.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.String get signedJwt => $_getSZ(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set signedJwt($core.String v) {
    $_setString(1, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasSignedJwt() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearSignedJwt() => clearField(2);
}

/// A role in the Identity and Access Management API.
class Role extends $pb.GeneratedMessage {
  factory Role({
    $core.String? name,
    $core.String? title,
    $core.String? description,
    $core.Iterable<$core.String>? includedPermissions,
    Role_RoleLaunchStage? stage,
    $core.List<$core.int>? etag,
    $core.bool? deleted,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (includedPermissions != null) {
      $result.includedPermissions.addAll(includedPermissions);
    }
    if (stage != null) {
      $result.stage = stage;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    if (deleted != null) {
      $result.deleted = deleted;
    }
    return $result;
  }
  Role._() : super();
  factory Role.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Role.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Role',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPS(7, _omitFieldNames ? '' : 'includedPermissions')
    ..e<Role_RoleLaunchStage>(
        8, _omitFieldNames ? '' : 'stage', $pb.PbFieldType.OE,
        defaultOrMaker: Role_RoleLaunchStage.ALPHA,
        valueOf: Role_RoleLaunchStage.valueOf,
        enumValues: Role_RoleLaunchStage.values)
    ..a<$core.List<$core.int>>(
        9, _omitFieldNames ? '' : 'etag', $pb.PbFieldType.OY)
    ..aOB(11, _omitFieldNames ? '' : 'deleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Role clone() => Role()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Role copyWith(void Function(Role) updates) =>
      super.copyWith((message) => updates(message as Role)) as Role;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Role create() => Role._();
  Role createEmptyInstance() => create();
  static $pb.PbList<Role> createRepeated() => $pb.PbList<Role>();
  @$core.pragma('dart2js:noInline')
  static Role getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Role>(create);
  static Role? _defaultInstance;

  ///  The name of the role.
  ///
  ///  When Role is used in CreateRole, the role name must not be set.
  ///
  ///  When Role is used in output and other input such as UpdateRole, the role
  ///  name is the complete path, e.g., roles/logging.viewer for predefined roles
  ///  and organizations/{ORGANIZATION_ID}/roles/logging.viewer for custom roles.
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

  /// Optional. A human-readable title for the role.  Typically this
  /// is limited to 100 UTF-8 bytes.
  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  /// Optional. A human-readable description for the role.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  /// The names of the permissions this role grants when bound in an IAM policy.
  @$pb.TagNumber(7)
  $core.List<$core.String> get includedPermissions => $_getList(3);

  /// The current launch stage of the role. If the `ALPHA` launch stage has been
  /// selected for a role, the `stage` field will not be included in the
  /// returned definition for the role.
  @$pb.TagNumber(8)
  Role_RoleLaunchStage get stage => $_getN(4);
  @$pb.TagNumber(8)
  set stage(Role_RoleLaunchStage v) {
    setField(8, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasStage() => $_has(4);
  @$pb.TagNumber(8)
  void clearStage() => clearField(8);

  /// Used to perform a consistent read-modify-write.
  @$pb.TagNumber(9)
  $core.List<$core.int> get etag => $_getN(5);
  @$pb.TagNumber(9)
  set etag($core.List<$core.int> v) {
    $_setBytes(5, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasEtag() => $_has(5);
  @$pb.TagNumber(9)
  void clearEtag() => clearField(9);

  /// The current deleted state of the role. This field is read only.
  /// It will be ignored in calls to CreateRole and UpdateRole.
  @$pb.TagNumber(11)
  $core.bool get deleted => $_getBF(6);
  @$pb.TagNumber(11)
  set deleted($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasDeleted() => $_has(6);
  @$pb.TagNumber(11)
  void clearDeleted() => clearField(11);
}

/// The grantable role query request.
class QueryGrantableRolesRequest extends $pb.GeneratedMessage {
  factory QueryGrantableRolesRequest({
    $core.String? fullResourceName,
    RoleView? view,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (fullResourceName != null) {
      $result.fullResourceName = fullResourceName;
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
  QueryGrantableRolesRequest._() : super();
  factory QueryGrantableRolesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryGrantableRolesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryGrantableRolesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullResourceName')
    ..e<RoleView>(2, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: RoleView.BASIC,
        valueOf: RoleView.valueOf,
        enumValues: RoleView.values)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryGrantableRolesRequest clone() =>
      QueryGrantableRolesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryGrantableRolesRequest copyWith(
          void Function(QueryGrantableRolesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as QueryGrantableRolesRequest))
          as QueryGrantableRolesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryGrantableRolesRequest create() => QueryGrantableRolesRequest._();
  QueryGrantableRolesRequest createEmptyInstance() => create();
  static $pb.PbList<QueryGrantableRolesRequest> createRepeated() =>
      $pb.PbList<QueryGrantableRolesRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryGrantableRolesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryGrantableRolesRequest>(create);
  static QueryGrantableRolesRequest? _defaultInstance;

  ///  Required. The full resource name to query from the list of grantable roles.
  ///
  ///  The name follows the Google Cloud Platform resource format.
  ///  For example, a Cloud Platform project with id `my-project` will be named
  ///  `//cloudresourcemanager.googleapis.com/projects/my-project`.
  @$pb.TagNumber(1)
  $core.String get fullResourceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullResourceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFullResourceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullResourceName() => clearField(1);

  @$pb.TagNumber(2)
  RoleView get view => $_getN(1);
  @$pb.TagNumber(2)
  set view(RoleView v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasView() => $_has(1);
  @$pb.TagNumber(2)
  void clearView() => clearField(2);

  ///  Optional limit on the number of roles to include in the response.
  ///
  ///  The default is 300, and the maximum is 1,000.
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

  /// Optional pagination token returned in an earlier
  /// QueryGrantableRolesResponse.
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

/// The grantable role query response.
class QueryGrantableRolesResponse extends $pb.GeneratedMessage {
  factory QueryGrantableRolesResponse({
    $core.Iterable<Role>? roles,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (roles != null) {
      $result.roles.addAll(roles);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  QueryGrantableRolesResponse._() : super();
  factory QueryGrantableRolesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryGrantableRolesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryGrantableRolesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<Role>(1, _omitFieldNames ? '' : 'roles', $pb.PbFieldType.PM,
        subBuilder: Role.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryGrantableRolesResponse clone() =>
      QueryGrantableRolesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryGrantableRolesResponse copyWith(
          void Function(QueryGrantableRolesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as QueryGrantableRolesResponse))
          as QueryGrantableRolesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryGrantableRolesResponse create() =>
      QueryGrantableRolesResponse._();
  QueryGrantableRolesResponse createEmptyInstance() => create();
  static $pb.PbList<QueryGrantableRolesResponse> createRepeated() =>
      $pb.PbList<QueryGrantableRolesResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryGrantableRolesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryGrantableRolesResponse>(create);
  static QueryGrantableRolesResponse? _defaultInstance;

  /// The list of matching roles.
  @$pb.TagNumber(1)
  $core.List<Role> get roles => $_getList(0);

  /// To retrieve the next page of results, set
  /// `QueryGrantableRolesRequest.page_token` to this value.
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

/// The request to get all roles defined under a resource.
class ListRolesRequest extends $pb.GeneratedMessage {
  factory ListRolesRequest({
    $core.String? parent,
    $core.int? pageSize,
    $core.String? pageToken,
    RoleView? view,
    $core.bool? showDeleted,
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
    if (showDeleted != null) {
      $result.showDeleted = showDeleted;
    }
    return $result;
  }
  ListRolesRequest._() : super();
  factory ListRolesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListRolesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRolesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..e<RoleView>(4, _omitFieldNames ? '' : 'view', $pb.PbFieldType.OE,
        defaultOrMaker: RoleView.BASIC,
        valueOf: RoleView.valueOf,
        enumValues: RoleView.values)
    ..aOB(6, _omitFieldNames ? '' : 'showDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListRolesRequest clone() => ListRolesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListRolesRequest copyWith(void Function(ListRolesRequest) updates) =>
      super.copyWith((message) => updates(message as ListRolesRequest))
          as ListRolesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRolesRequest create() => ListRolesRequest._();
  ListRolesRequest createEmptyInstance() => create();
  static $pb.PbList<ListRolesRequest> createRepeated() =>
      $pb.PbList<ListRolesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRolesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRolesRequest>(create);
  static ListRolesRequest? _defaultInstance;

  ///  The `parent` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`roles`](https://cloud.google.com/iam/reference/rest/v1/roles),
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles),
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `parent` value format is described below:
  ///
  ///  * [`roles.list()`](https://cloud.google.com/iam/reference/rest/v1/roles/list): An empty string.
  ///    This method doesn't require a resource; it simply returns all
  ///    [predefined
  ///    roles](https://cloud.google.com/iam/docs/understanding-roles#predefined_roles)
  ///    in Cloud IAM. Example request URL: `https://iam.googleapis.com/v1/roles`
  ///
  ///  * [`projects.roles.list()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/list):
  ///    `projects/{PROJECT_ID}`. This method lists all project-level
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles).
  ///    Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles`
  ///
  ///  * [`organizations.roles.list()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/list):
  ///    `organizations/{ORGANIZATION_ID}`. This method lists all
  ///    organization-level [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles).
  ///    Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

  ///  Optional limit on the number of roles to include in the response.
  ///
  ///  The default is 300, and the maximum is 1,000.
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

  /// Optional pagination token returned in an earlier ListRolesResponse.
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

  /// Optional view for the returned Role objects. When `FULL` is specified,
  /// the `includedPermissions` field is returned, which includes a list of all
  /// permissions in the role. The default value is `BASIC`, which does not
  /// return the `includedPermissions` field.
  @$pb.TagNumber(4)
  RoleView get view => $_getN(3);
  @$pb.TagNumber(4)
  set view(RoleView v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasView() => $_has(3);
  @$pb.TagNumber(4)
  void clearView() => clearField(4);

  /// Include Roles that have been deleted.
  @$pb.TagNumber(6)
  $core.bool get showDeleted => $_getBF(4);
  @$pb.TagNumber(6)
  set showDeleted($core.bool v) {
    $_setBool(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasShowDeleted() => $_has(4);
  @$pb.TagNumber(6)
  void clearShowDeleted() => clearField(6);
}

/// The response containing the roles defined under a resource.
class ListRolesResponse extends $pb.GeneratedMessage {
  factory ListRolesResponse({
    $core.Iterable<Role>? roles,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (roles != null) {
      $result.roles.addAll(roles);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListRolesResponse._() : super();
  factory ListRolesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ListRolesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRolesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<Role>(1, _omitFieldNames ? '' : 'roles', $pb.PbFieldType.PM,
        subBuilder: Role.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ListRolesResponse clone() => ListRolesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ListRolesResponse copyWith(void Function(ListRolesResponse) updates) =>
      super.copyWith((message) => updates(message as ListRolesResponse))
          as ListRolesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRolesResponse create() => ListRolesResponse._();
  ListRolesResponse createEmptyInstance() => create();
  static $pb.PbList<ListRolesResponse> createRepeated() =>
      $pb.PbList<ListRolesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListRolesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRolesResponse>(create);
  static ListRolesResponse? _defaultInstance;

  /// The Roles defined on this resource.
  @$pb.TagNumber(1)
  $core.List<Role> get roles => $_getList(0);

  /// To retrieve the next page of results, set
  /// `ListRolesRequest.page_token` to this value.
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

/// The request to get the definition of an existing role.
class GetRoleRequest extends $pb.GeneratedMessage {
  factory GetRoleRequest({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  GetRoleRequest._() : super();
  factory GetRoleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GetRoleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetRoleRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GetRoleRequest clone() => GetRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GetRoleRequest copyWith(void Function(GetRoleRequest) updates) =>
      super.copyWith((message) => updates(message as GetRoleRequest))
          as GetRoleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRoleRequest create() => GetRoleRequest._();
  GetRoleRequest createEmptyInstance() => create();
  static $pb.PbList<GetRoleRequest> createRepeated() =>
      $pb.PbList<GetRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetRoleRequest>(create);
  static GetRoleRequest? _defaultInstance;

  ///  The `name` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`roles`](https://cloud.google.com/iam/reference/rest/v1/roles),
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles),
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `name` value format is described below:
  ///
  ///  * [`roles.get()`](https://cloud.google.com/iam/reference/rest/v1/roles/get): `roles/{ROLE_NAME}`.
  ///    This method returns results from all
  ///    [predefined
  ///    roles](https://cloud.google.com/iam/docs/understanding-roles#predefined_roles)
  ///    in Cloud IAM. Example request URL:
  ///    `https://iam.googleapis.com/v1/roles/{ROLE_NAME}`
  ///
  ///  * [`projects.roles.get()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/get):
  ///    `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method returns only
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the project level. Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  * [`organizations.roles.get()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/get):
  ///    `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
  ///    returns only [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the organization level. Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

/// The request to create a new role.
class CreateRoleRequest extends $pb.GeneratedMessage {
  factory CreateRoleRequest({
    $core.String? parent,
    $core.String? roleId,
    Role? role,
  }) {
    final $result = create();
    if (parent != null) {
      $result.parent = parent;
    }
    if (roleId != null) {
      $result.roleId = roleId;
    }
    if (role != null) {
      $result.role = role;
    }
    return $result;
  }
  CreateRoleRequest._() : super();
  factory CreateRoleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CreateRoleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateRoleRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'parent')
    ..aOS(2, _omitFieldNames ? '' : 'roleId')
    ..aOM<Role>(3, _omitFieldNames ? '' : 'role', subBuilder: Role.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CreateRoleRequest clone() => CreateRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CreateRoleRequest copyWith(void Function(CreateRoleRequest) updates) =>
      super.copyWith((message) => updates(message as CreateRoleRequest))
          as CreateRoleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateRoleRequest create() => CreateRoleRequest._();
  CreateRoleRequest createEmptyInstance() => create();
  static $pb.PbList<CreateRoleRequest> createRepeated() =>
      $pb.PbList<CreateRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateRoleRequest>(create);
  static CreateRoleRequest? _defaultInstance;

  ///  The `parent` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles)
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `parent` value format is described below:
  ///
  ///  * [`projects.roles.create()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/create):
  ///    `projects/{PROJECT_ID}`. This method creates project-level
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles).
  ///    Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles`
  ///
  ///  * [`organizations.roles.create()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/create):
  ///    `organizations/{ORGANIZATION_ID}`. This method creates organization-level
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles).
  ///    Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

  ///  The role ID to use for this role.
  ///
  ///  A role ID may contain alphanumeric characters, underscores (`_`), and
  ///  periods (`.`). It must contain a minimum of 3 characters and a maximum of
  ///  64 characters.
  @$pb.TagNumber(2)
  $core.String get roleId => $_getSZ(1);
  @$pb.TagNumber(2)
  set roleId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRoleId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoleId() => clearField(2);

  /// The Role resource to create.
  @$pb.TagNumber(3)
  Role get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(Role v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => clearField(3);
  @$pb.TagNumber(3)
  Role ensureRole() => $_ensure(2);
}

/// The request to update a role.
class UpdateRoleRequest extends $pb.GeneratedMessage {
  factory UpdateRoleRequest({
    $core.String? name,
    Role? role,
    $58.FieldMask? updateMask,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (role != null) {
      $result.role = role;
    }
    if (updateMask != null) {
      $result.updateMask = updateMask;
    }
    return $result;
  }
  UpdateRoleRequest._() : super();
  factory UpdateRoleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UpdateRoleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateRoleRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOM<Role>(2, _omitFieldNames ? '' : 'role', subBuilder: Role.create)
    ..aOM<$58.FieldMask>(3, _omitFieldNames ? '' : 'updateMask',
        subBuilder: $58.FieldMask.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UpdateRoleRequest clone() => UpdateRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UpdateRoleRequest copyWith(void Function(UpdateRoleRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateRoleRequest))
          as UpdateRoleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateRoleRequest create() => UpdateRoleRequest._();
  UpdateRoleRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateRoleRequest> createRepeated() =>
      $pb.PbList<UpdateRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateRoleRequest>(create);
  static UpdateRoleRequest? _defaultInstance;

  ///  The `name` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles)
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `name` value format is described below:
  ///
  ///  * [`projects.roles.patch()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/patch):
  ///    `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method updates only
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the project level. Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  * [`organizations.roles.patch()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/patch):
  ///    `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
  ///    updates only [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the organization level. Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

  /// The updated role.
  @$pb.TagNumber(2)
  Role get role => $_getN(1);
  @$pb.TagNumber(2)
  set role(Role v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => clearField(2);
  @$pb.TagNumber(2)
  Role ensureRole() => $_ensure(1);

  /// A mask describing which fields in the Role have changed.
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

/// The request to delete an existing role.
class DeleteRoleRequest extends $pb.GeneratedMessage {
  factory DeleteRoleRequest({
    $core.String? name,
    $core.List<$core.int>? etag,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    return $result;
  }
  DeleteRoleRequest._() : super();
  factory DeleteRoleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory DeleteRoleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteRoleRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'etag', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DeleteRoleRequest clone() => DeleteRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DeleteRoleRequest copyWith(void Function(DeleteRoleRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteRoleRequest))
          as DeleteRoleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteRoleRequest create() => DeleteRoleRequest._();
  DeleteRoleRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteRoleRequest> createRepeated() =>
      $pb.PbList<DeleteRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteRoleRequest>(create);
  static DeleteRoleRequest? _defaultInstance;

  ///  The `name` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles)
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `name` value format is described below:
  ///
  ///  * [`projects.roles.delete()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/delete):
  ///    `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method deletes only
  ///    [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the project level. Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  * [`organizations.roles.delete()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/delete):
  ///    `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
  ///    deletes only [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the organization level. Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

  /// Used to perform a consistent read-modify-write.
  @$pb.TagNumber(2)
  $core.List<$core.int> get etag => $_getN(1);
  @$pb.TagNumber(2)
  set etag($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => clearField(2);
}

/// The request to undelete an existing role.
class UndeleteRoleRequest extends $pb.GeneratedMessage {
  factory UndeleteRoleRequest({
    $core.String? name,
    $core.List<$core.int>? etag,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (etag != null) {
      $result.etag = etag;
    }
    return $result;
  }
  UndeleteRoleRequest._() : super();
  factory UndeleteRoleRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UndeleteRoleRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UndeleteRoleRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'etag', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UndeleteRoleRequest clone() => UndeleteRoleRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UndeleteRoleRequest copyWith(void Function(UndeleteRoleRequest) updates) =>
      super.copyWith((message) => updates(message as UndeleteRoleRequest))
          as UndeleteRoleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UndeleteRoleRequest create() => UndeleteRoleRequest._();
  UndeleteRoleRequest createEmptyInstance() => create();
  static $pb.PbList<UndeleteRoleRequest> createRepeated() =>
      $pb.PbList<UndeleteRoleRequest>();
  @$core.pragma('dart2js:noInline')
  static UndeleteRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UndeleteRoleRequest>(create);
  static UndeleteRoleRequest? _defaultInstance;

  ///  The `name` parameter's value depends on the target resource for the
  ///  request, namely
  ///  [`projects`](https://cloud.google.com/iam/reference/rest/v1/projects.roles)
  ///  or
  ///  [`organizations`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles).
  ///  Each resource type's `name` value format is described below:
  ///
  ///  * [`projects.roles.undelete()`](https://cloud.google.com/iam/reference/rest/v1/projects.roles/undelete):
  ///    `projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`. This method undeletes
  ///    only [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the project level. Example request URL:
  ///    `https://iam.googleapis.com/v1/projects/{PROJECT_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  * [`organizations.roles.undelete()`](https://cloud.google.com/iam/reference/rest/v1/organizations.roles/undelete):
  ///    `organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`. This method
  ///    undeletes only [custom
  ///    roles](https://cloud.google.com/iam/docs/understanding-custom-roles) that
  ///    have been created at the organization level. Example request URL:
  ///    `https://iam.googleapis.com/v1/organizations/{ORGANIZATION_ID}/roles/{CUSTOM_ROLE_ID}`
  ///
  ///  Note: Wildcard (*) values are invalid; you must specify a complete project
  ///  ID or organization ID.
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

  /// Used to perform a consistent read-modify-write.
  @$pb.TagNumber(2)
  $core.List<$core.int> get etag => $_getN(1);
  @$pb.TagNumber(2)
  set etag($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => clearField(2);
}

/// A permission which can be included by a role.
class Permission extends $pb.GeneratedMessage {
  factory Permission({
    $core.String? name,
    $core.String? title,
    $core.String? description,
    @$core.Deprecated('This field is deprecated.')
    $core.bool? onlyInPredefinedRoles,
    Permission_PermissionLaunchStage? stage,
    Permission_CustomRolesSupportLevel? customRolesSupportLevel,
    $core.bool? apiDisabled,
    $core.String? primaryPermission,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (onlyInPredefinedRoles != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.onlyInPredefinedRoles = onlyInPredefinedRoles;
    }
    if (stage != null) {
      $result.stage = stage;
    }
    if (customRolesSupportLevel != null) {
      $result.customRolesSupportLevel = customRolesSupportLevel;
    }
    if (apiDisabled != null) {
      $result.apiDisabled = apiDisabled;
    }
    if (primaryPermission != null) {
      $result.primaryPermission = primaryPermission;
    }
    return $result;
  }
  Permission._() : super();
  factory Permission.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Permission.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Permission',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOB(4, _omitFieldNames ? '' : 'onlyInPredefinedRoles')
    ..e<Permission_PermissionLaunchStage>(
        5, _omitFieldNames ? '' : 'stage', $pb.PbFieldType.OE,
        defaultOrMaker: Permission_PermissionLaunchStage.ALPHA,
        valueOf: Permission_PermissionLaunchStage.valueOf,
        enumValues: Permission_PermissionLaunchStage.values)
    ..e<Permission_CustomRolesSupportLevel>(
        6, _omitFieldNames ? '' : 'customRolesSupportLevel', $pb.PbFieldType.OE,
        defaultOrMaker: Permission_CustomRolesSupportLevel.SUPPORTED,
        valueOf: Permission_CustomRolesSupportLevel.valueOf,
        enumValues: Permission_CustomRolesSupportLevel.values)
    ..aOB(7, _omitFieldNames ? '' : 'apiDisabled')
    ..aOS(8, _omitFieldNames ? '' : 'primaryPermission')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Permission clone() => Permission()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Permission copyWith(void Function(Permission) updates) =>
      super.copyWith((message) => updates(message as Permission)) as Permission;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Permission create() => Permission._();
  Permission createEmptyInstance() => create();
  static $pb.PbList<Permission> createRepeated() => $pb.PbList<Permission>();
  @$core.pragma('dart2js:noInline')
  static Permission getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Permission>(create);
  static Permission? _defaultInstance;

  /// The name of this Permission.
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

  /// The title of this Permission.
  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  /// A brief description of what this Permission is used for.
  /// This permission can ONLY be used in predefined roles.
  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool get onlyInPredefinedRoles => $_getBF(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set onlyInPredefinedRoles($core.bool v) {
    $_setBool(3, v);
  }

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasOnlyInPredefinedRoles() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearOnlyInPredefinedRoles() => clearField(4);

  /// The current launch stage of the permission.
  @$pb.TagNumber(5)
  Permission_PermissionLaunchStage get stage => $_getN(4);
  @$pb.TagNumber(5)
  set stage(Permission_PermissionLaunchStage v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasStage() => $_has(4);
  @$pb.TagNumber(5)
  void clearStage() => clearField(5);

  /// The current custom role support level.
  @$pb.TagNumber(6)
  Permission_CustomRolesSupportLevel get customRolesSupportLevel => $_getN(5);
  @$pb.TagNumber(6)
  set customRolesSupportLevel(Permission_CustomRolesSupportLevel v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCustomRolesSupportLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearCustomRolesSupportLevel() => clearField(6);

  /// The service API associated with the permission is not enabled.
  @$pb.TagNumber(7)
  $core.bool get apiDisabled => $_getBF(6);
  @$pb.TagNumber(7)
  set apiDisabled($core.bool v) {
    $_setBool(6, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasApiDisabled() => $_has(6);
  @$pb.TagNumber(7)
  void clearApiDisabled() => clearField(7);

  /// The preferred name for this permission. If present, then this permission is
  /// an alias of, and equivalent to, the listed primary_permission.
  @$pb.TagNumber(8)
  $core.String get primaryPermission => $_getSZ(7);
  @$pb.TagNumber(8)
  set primaryPermission($core.String v) {
    $_setString(7, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasPrimaryPermission() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrimaryPermission() => clearField(8);
}

/// A request to get permissions which can be tested on a resource.
class QueryTestablePermissionsRequest extends $pb.GeneratedMessage {
  factory QueryTestablePermissionsRequest({
    $core.String? fullResourceName,
    $core.int? pageSize,
    $core.String? pageToken,
  }) {
    final $result = create();
    if (fullResourceName != null) {
      $result.fullResourceName = fullResourceName;
    }
    if (pageSize != null) {
      $result.pageSize = pageSize;
    }
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  QueryTestablePermissionsRequest._() : super();
  factory QueryTestablePermissionsRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTestablePermissionsRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryTestablePermissionsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullResourceName')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'pageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryTestablePermissionsRequest clone() =>
      QueryTestablePermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryTestablePermissionsRequest copyWith(
          void Function(QueryTestablePermissionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as QueryTestablePermissionsRequest))
          as QueryTestablePermissionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryTestablePermissionsRequest create() =>
      QueryTestablePermissionsRequest._();
  QueryTestablePermissionsRequest createEmptyInstance() => create();
  static $pb.PbList<QueryTestablePermissionsRequest> createRepeated() =>
      $pb.PbList<QueryTestablePermissionsRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryTestablePermissionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryTestablePermissionsRequest>(
          create);
  static QueryTestablePermissionsRequest? _defaultInstance;

  ///  Required. The full resource name to query from the list of testable
  ///  permissions.
  ///
  ///  The name follows the Google Cloud Platform resource format.
  ///  For example, a Cloud Platform project with id `my-project` will be named
  ///  `//cloudresourcemanager.googleapis.com/projects/my-project`.
  @$pb.TagNumber(1)
  $core.String get fullResourceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullResourceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFullResourceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullResourceName() => clearField(1);

  ///  Optional limit on the number of permissions to include in the response.
  ///
  ///  The default is 100, and the maximum is 1,000.
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

  /// Optional pagination token returned in an earlier
  /// QueryTestablePermissionsRequest.
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

/// The response containing permissions which can be tested on a resource.
class QueryTestablePermissionsResponse extends $pb.GeneratedMessage {
  factory QueryTestablePermissionsResponse({
    $core.Iterable<Permission>? permissions,
    $core.String? nextPageToken,
  }) {
    final $result = create();
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  QueryTestablePermissionsResponse._() : super();
  factory QueryTestablePermissionsResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryTestablePermissionsResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryTestablePermissionsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<Permission>(
        1, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM,
        subBuilder: Permission.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextPageToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryTestablePermissionsResponse clone() =>
      QueryTestablePermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryTestablePermissionsResponse copyWith(
          void Function(QueryTestablePermissionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as QueryTestablePermissionsResponse))
          as QueryTestablePermissionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryTestablePermissionsResponse create() =>
      QueryTestablePermissionsResponse._();
  QueryTestablePermissionsResponse createEmptyInstance() => create();
  static $pb.PbList<QueryTestablePermissionsResponse> createRepeated() =>
      $pb.PbList<QueryTestablePermissionsResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryTestablePermissionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryTestablePermissionsResponse>(
          create);
  static QueryTestablePermissionsResponse? _defaultInstance;

  /// The Permissions testable on the requested resource.
  @$pb.TagNumber(1)
  $core.List<Permission> get permissions => $_getList(0);

  /// To retrieve the next page of results, set
  /// `QueryTestableRolesRequest.page_token` to this value.
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

/// A request to get the list of auditable services for a resource.
class QueryAuditableServicesRequest extends $pb.GeneratedMessage {
  factory QueryAuditableServicesRequest({
    $core.String? fullResourceName,
  }) {
    final $result = create();
    if (fullResourceName != null) {
      $result.fullResourceName = fullResourceName;
    }
    return $result;
  }
  QueryAuditableServicesRequest._() : super();
  factory QueryAuditableServicesRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryAuditableServicesRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryAuditableServicesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fullResourceName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesRequest clone() =>
      QueryAuditableServicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesRequest copyWith(
          void Function(QueryAuditableServicesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as QueryAuditableServicesRequest))
          as QueryAuditableServicesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesRequest create() =>
      QueryAuditableServicesRequest._();
  QueryAuditableServicesRequest createEmptyInstance() => create();
  static $pb.PbList<QueryAuditableServicesRequest> createRepeated() =>
      $pb.PbList<QueryAuditableServicesRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryAuditableServicesRequest>(create);
  static QueryAuditableServicesRequest? _defaultInstance;

  ///  Required. The full resource name to query from the list of auditable
  ///  services.
  ///
  ///  The name follows the Google Cloud Platform resource format.
  ///  For example, a Cloud Platform project with id `my-project` will be named
  ///  `//cloudresourcemanager.googleapis.com/projects/my-project`.
  @$pb.TagNumber(1)
  $core.String get fullResourceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullResourceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFullResourceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullResourceName() => clearField(1);
}

/// Contains information about an auditable service.
class QueryAuditableServicesResponse_AuditableService
    extends $pb.GeneratedMessage {
  factory QueryAuditableServicesResponse_AuditableService({
    $core.String? name,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    return $result;
  }
  QueryAuditableServicesResponse_AuditableService._() : super();
  factory QueryAuditableServicesResponse_AuditableService.fromBuffer(
          $core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryAuditableServicesResponse_AuditableService.fromJson(
          $core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames
          ? ''
          : 'QueryAuditableServicesResponse.AuditableService',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesResponse_AuditableService clone() =>
      QueryAuditableServicesResponse_AuditableService()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesResponse_AuditableService copyWith(
          void Function(QueryAuditableServicesResponse_AuditableService)
              updates) =>
      super.copyWith((message) => updates(
              message as QueryAuditableServicesResponse_AuditableService))
          as QueryAuditableServicesResponse_AuditableService;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesResponse_AuditableService create() =>
      QueryAuditableServicesResponse_AuditableService._();
  QueryAuditableServicesResponse_AuditableService createEmptyInstance() =>
      create();
  static $pb.PbList<QueryAuditableServicesResponse_AuditableService>
      createRepeated() =>
          $pb.PbList<QueryAuditableServicesResponse_AuditableService>();
  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesResponse_AuditableService getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          QueryAuditableServicesResponse_AuditableService>(create);
  static QueryAuditableServicesResponse_AuditableService? _defaultInstance;

  /// Public name of the service.
  /// For example, the service name for Cloud IAM is 'iam.googleapis.com'.
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

/// A response containing a list of auditable services for a resource.
class QueryAuditableServicesResponse extends $pb.GeneratedMessage {
  factory QueryAuditableServicesResponse({
    $core.Iterable<QueryAuditableServicesResponse_AuditableService>? services,
  }) {
    final $result = create();
    if (services != null) {
      $result.services.addAll(services);
    }
    return $result;
  }
  QueryAuditableServicesResponse._() : super();
  factory QueryAuditableServicesResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory QueryAuditableServicesResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QueryAuditableServicesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<QueryAuditableServicesResponse_AuditableService>(
        1, _omitFieldNames ? '' : 'services', $pb.PbFieldType.PM,
        subBuilder: QueryAuditableServicesResponse_AuditableService.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesResponse clone() =>
      QueryAuditableServicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  QueryAuditableServicesResponse copyWith(
          void Function(QueryAuditableServicesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as QueryAuditableServicesResponse))
          as QueryAuditableServicesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesResponse create() =>
      QueryAuditableServicesResponse._();
  QueryAuditableServicesResponse createEmptyInstance() => create();
  static $pb.PbList<QueryAuditableServicesResponse> createRepeated() =>
      $pb.PbList<QueryAuditableServicesResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryAuditableServicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QueryAuditableServicesResponse>(create);
  static QueryAuditableServicesResponse? _defaultInstance;

  /// The auditable services for a resource.
  @$pb.TagNumber(1)
  $core.List<QueryAuditableServicesResponse_AuditableService> get services =>
      $_getList(0);
}

enum LintPolicyRequest_LintObject { condition, notSet }

/// The request to lint a Cloud IAM policy object.
class LintPolicyRequest extends $pb.GeneratedMessage {
  factory LintPolicyRequest({
    $core.String? fullResourceName,
    $114.Expr? condition,
  }) {
    final $result = create();
    if (fullResourceName != null) {
      $result.fullResourceName = fullResourceName;
    }
    if (condition != null) {
      $result.condition = condition;
    }
    return $result;
  }
  LintPolicyRequest._() : super();
  factory LintPolicyRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LintPolicyRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LintPolicyRequest_LintObject>
      _LintPolicyRequest_LintObjectByTag = {
    5: LintPolicyRequest_LintObject.condition,
    0: LintPolicyRequest_LintObject.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LintPolicyRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..oo(0, [5])
    ..aOS(1, _omitFieldNames ? '' : 'fullResourceName')
    ..aOM<$114.Expr>(5, _omitFieldNames ? '' : 'condition',
        subBuilder: $114.Expr.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LintPolicyRequest clone() => LintPolicyRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LintPolicyRequest copyWith(void Function(LintPolicyRequest) updates) =>
      super.copyWith((message) => updates(message as LintPolicyRequest))
          as LintPolicyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LintPolicyRequest create() => LintPolicyRequest._();
  LintPolicyRequest createEmptyInstance() => create();
  static $pb.PbList<LintPolicyRequest> createRepeated() =>
      $pb.PbList<LintPolicyRequest>();
  @$core.pragma('dart2js:noInline')
  static LintPolicyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LintPolicyRequest>(create);
  static LintPolicyRequest? _defaultInstance;

  LintPolicyRequest_LintObject whichLintObject() =>
      _LintPolicyRequest_LintObjectByTag[$_whichOneof(0)]!;
  void clearLintObject() => clearField($_whichOneof(0));

  ///  The full resource name of the policy this lint request is about.
  ///
  ///  The name follows the Google Cloud Platform (GCP) resource format.
  ///  For example, a GCP project with ID `my-project` will be named
  ///  `//cloudresourcemanager.googleapis.com/projects/my-project`.
  ///
  ///  The resource name is not used to read the policy instance from the Cloud
  ///  IAM database. The candidate policy for lint has to be provided in the same
  ///  request object.
  @$pb.TagNumber(1)
  $core.String get fullResourceName => $_getSZ(0);
  @$pb.TagNumber(1)
  set fullResourceName($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFullResourceName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFullResourceName() => clearField(1);

  /// [google.iam.v1.Binding.condition] [google.iam.v1.Binding.condition] object to be linted.
  @$pb.TagNumber(5)
  $114.Expr get condition => $_getN(1);
  @$pb.TagNumber(5)
  set condition($114.Expr v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCondition() => $_has(1);
  @$pb.TagNumber(5)
  void clearCondition() => clearField(5);
  @$pb.TagNumber(5)
  $114.Expr ensureCondition() => $_ensure(1);
}

/// Structured response of a single validation unit.
class LintResult extends $pb.GeneratedMessage {
  factory LintResult({
    LintResult_Level? level,
    $core.String? validationUnitName,
    LintResult_Severity? severity,
    $core.String? fieldName,
    $core.int? locationOffset,
    $core.String? debugMessage,
  }) {
    final $result = create();
    if (level != null) {
      $result.level = level;
    }
    if (validationUnitName != null) {
      $result.validationUnitName = validationUnitName;
    }
    if (severity != null) {
      $result.severity = severity;
    }
    if (fieldName != null) {
      $result.fieldName = fieldName;
    }
    if (locationOffset != null) {
      $result.locationOffset = locationOffset;
    }
    if (debugMessage != null) {
      $result.debugMessage = debugMessage;
    }
    return $result;
  }
  LintResult._() : super();
  factory LintResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LintResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LintResult',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..e<LintResult_Level>(1, _omitFieldNames ? '' : 'level', $pb.PbFieldType.OE,
        defaultOrMaker: LintResult_Level.LEVEL_UNSPECIFIED,
        valueOf: LintResult_Level.valueOf,
        enumValues: LintResult_Level.values)
    ..aOS(2, _omitFieldNames ? '' : 'validationUnitName')
    ..e<LintResult_Severity>(
        3, _omitFieldNames ? '' : 'severity', $pb.PbFieldType.OE,
        defaultOrMaker: LintResult_Severity.SEVERITY_UNSPECIFIED,
        valueOf: LintResult_Severity.valueOf,
        enumValues: LintResult_Severity.values)
    ..aOS(5, _omitFieldNames ? '' : 'fieldName')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'locationOffset', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'debugMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LintResult clone() => LintResult()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LintResult copyWith(void Function(LintResult) updates) =>
      super.copyWith((message) => updates(message as LintResult)) as LintResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LintResult create() => LintResult._();
  LintResult createEmptyInstance() => create();
  static $pb.PbList<LintResult> createRepeated() => $pb.PbList<LintResult>();
  @$core.pragma('dart2js:noInline')
  static LintResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LintResult>(create);
  static LintResult? _defaultInstance;

  /// The validation unit level.
  @$pb.TagNumber(1)
  LintResult_Level get level => $_getN(0);
  @$pb.TagNumber(1)
  set level(LintResult_Level v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  /// The validation unit name, for instance
  /// "lintValidationUnits/ConditionComplexityCheck".
  @$pb.TagNumber(2)
  $core.String get validationUnitName => $_getSZ(1);
  @$pb.TagNumber(2)
  set validationUnitName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasValidationUnitName() => $_has(1);
  @$pb.TagNumber(2)
  void clearValidationUnitName() => clearField(2);

  /// The validation unit severity.
  @$pb.TagNumber(3)
  LintResult_Severity get severity => $_getN(2);
  @$pb.TagNumber(3)
  set severity(LintResult_Severity v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasSeverity() => $_has(2);
  @$pb.TagNumber(3)
  void clearSeverity() => clearField(3);

  ///  The name of the field for which this lint result is about.
  ///
  ///  For nested messages `field_name` consists of names of the embedded fields
  ///  separated by period character. The top-level qualifier is the input object
  ///  to lint in the request. For example, the `field_name` value
  ///  `condition.expression` identifies a lint result for the `expression` field
  ///  of the provided condition.
  @$pb.TagNumber(5)
  $core.String get fieldName => $_getSZ(3);
  @$pb.TagNumber(5)
  set fieldName($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasFieldName() => $_has(3);
  @$pb.TagNumber(5)
  void clearFieldName() => clearField(5);

  /// 0-based character position of problematic construct within the object
  /// identified by `field_name`. Currently, this is populated only for condition
  /// expression.
  @$pb.TagNumber(6)
  $core.int get locationOffset => $_getIZ(4);
  @$pb.TagNumber(6)
  set locationOffset($core.int v) {
    $_setSignedInt32(4, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasLocationOffset() => $_has(4);
  @$pb.TagNumber(6)
  void clearLocationOffset() => clearField(6);

  /// Human readable debug message associated with the issue.
  @$pb.TagNumber(7)
  $core.String get debugMessage => $_getSZ(5);
  @$pb.TagNumber(7)
  set debugMessage($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasDebugMessage() => $_has(5);
  @$pb.TagNumber(7)
  void clearDebugMessage() => clearField(7);
}

/// The response of a lint operation. An empty response indicates
/// the operation was able to fully execute and no lint issue was found.
class LintPolicyResponse extends $pb.GeneratedMessage {
  factory LintPolicyResponse({
    $core.Iterable<LintResult>? lintResults,
  }) {
    final $result = create();
    if (lintResults != null) {
      $result.lintResults.addAll(lintResults);
    }
    return $result;
  }
  LintPolicyResponse._() : super();
  factory LintPolicyResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory LintPolicyResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LintPolicyResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.iam.admin.v1'),
      createEmptyInstance: create)
    ..pc<LintResult>(
        1, _omitFieldNames ? '' : 'lintResults', $pb.PbFieldType.PM,
        subBuilder: LintResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  LintPolicyResponse clone() => LintPolicyResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  LintPolicyResponse copyWith(void Function(LintPolicyResponse) updates) =>
      super.copyWith((message) => updates(message as LintPolicyResponse))
          as LintPolicyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LintPolicyResponse create() => LintPolicyResponse._();
  LintPolicyResponse createEmptyInstance() => create();
  static $pb.PbList<LintPolicyResponse> createRepeated() =>
      $pb.PbList<LintPolicyResponse>();
  @$core.pragma('dart2js:noInline')
  static LintPolicyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LintPolicyResponse>(create);
  static LintPolicyResponse? _defaultInstance;

  /// List of lint results sorted by `severity` in descending order.
  @$pb.TagNumber(1)
  $core.List<LintResult> get lintResults => $_getList(0);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
