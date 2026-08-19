//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/iam.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/empty.pb.dart' as $1;
import '../../v1/iam_policy.pb.dart' as $42;
import '../../v1/policy.pb.dart' as $43;
import 'iam.pb.dart' as $45;

export 'iam.pb.dart';

@$pb.GrpcServiceName('google.iam.admin.v1.IAM')
class IAMClient extends $grpc.Client {
  static final _$listServiceAccounts = $grpc.ClientMethod<
          $45.ListServiceAccountsRequest, $45.ListServiceAccountsResponse>(
      '/google.iam.admin.v1.IAM/ListServiceAccounts',
      ($45.ListServiceAccountsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.ListServiceAccountsResponse.fromBuffer(value));
  static final _$getServiceAccount =
      $grpc.ClientMethod<$45.GetServiceAccountRequest, $45.ServiceAccount>(
          '/google.iam.admin.v1.IAM/GetServiceAccount',
          ($45.GetServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.ServiceAccount.fromBuffer(value));
  static final _$createServiceAccount =
      $grpc.ClientMethod<$45.CreateServiceAccountRequest, $45.ServiceAccount>(
          '/google.iam.admin.v1.IAM/CreateServiceAccount',
          ($45.CreateServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.ServiceAccount.fromBuffer(value));
  static final _$updateServiceAccount =
      $grpc.ClientMethod<$45.ServiceAccount, $45.ServiceAccount>(
          '/google.iam.admin.v1.IAM/UpdateServiceAccount',
          ($45.ServiceAccount value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.ServiceAccount.fromBuffer(value));
  static final _$patchServiceAccount =
      $grpc.ClientMethod<$45.PatchServiceAccountRequest, $45.ServiceAccount>(
          '/google.iam.admin.v1.IAM/PatchServiceAccount',
          ($45.PatchServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.ServiceAccount.fromBuffer(value));
  static final _$deleteServiceAccount =
      $grpc.ClientMethod<$45.DeleteServiceAccountRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/DeleteServiceAccount',
          ($45.DeleteServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$undeleteServiceAccount = $grpc.ClientMethod<
          $45.UndeleteServiceAccountRequest,
          $45.UndeleteServiceAccountResponse>(
      '/google.iam.admin.v1.IAM/UndeleteServiceAccount',
      ($45.UndeleteServiceAccountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.UndeleteServiceAccountResponse.fromBuffer(value));
  static final _$enableServiceAccount =
      $grpc.ClientMethod<$45.EnableServiceAccountRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/EnableServiceAccount',
          ($45.EnableServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$disableServiceAccount =
      $grpc.ClientMethod<$45.DisableServiceAccountRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/DisableServiceAccount',
          ($45.DisableServiceAccountRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$listServiceAccountKeys = $grpc.ClientMethod<
          $45.ListServiceAccountKeysRequest,
          $45.ListServiceAccountKeysResponse>(
      '/google.iam.admin.v1.IAM/ListServiceAccountKeys',
      ($45.ListServiceAccountKeysRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.ListServiceAccountKeysResponse.fromBuffer(value));
  static final _$getServiceAccountKey = $grpc.ClientMethod<
          $45.GetServiceAccountKeyRequest, $45.ServiceAccountKey>(
      '/google.iam.admin.v1.IAM/GetServiceAccountKey',
      ($45.GetServiceAccountKeyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $45.ServiceAccountKey.fromBuffer(value));
  static final _$createServiceAccountKey = $grpc.ClientMethod<
          $45.CreateServiceAccountKeyRequest, $45.ServiceAccountKey>(
      '/google.iam.admin.v1.IAM/CreateServiceAccountKey',
      ($45.CreateServiceAccountKeyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $45.ServiceAccountKey.fromBuffer(value));
  static final _$uploadServiceAccountKey = $grpc.ClientMethod<
          $45.UploadServiceAccountKeyRequest, $45.ServiceAccountKey>(
      '/google.iam.admin.v1.IAM/UploadServiceAccountKey',
      ($45.UploadServiceAccountKeyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $45.ServiceAccountKey.fromBuffer(value));
  static final _$deleteServiceAccountKey =
      $grpc.ClientMethod<$45.DeleteServiceAccountKeyRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/DeleteServiceAccountKey',
          ($45.DeleteServiceAccountKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$disableServiceAccountKey =
      $grpc.ClientMethod<$45.DisableServiceAccountKeyRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/DisableServiceAccountKey',
          ($45.DisableServiceAccountKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$enableServiceAccountKey =
      $grpc.ClientMethod<$45.EnableServiceAccountKeyRequest, $1.Empty>(
          '/google.iam.admin.v1.IAM/EnableServiceAccountKey',
          ($45.EnableServiceAccountKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$signBlob =
      $grpc.ClientMethod<$45.SignBlobRequest, $45.SignBlobResponse>(
          '/google.iam.admin.v1.IAM/SignBlob',
          ($45.SignBlobRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.SignBlobResponse.fromBuffer(value));
  static final _$signJwt =
      $grpc.ClientMethod<$45.SignJwtRequest, $45.SignJwtResponse>(
          '/google.iam.admin.v1.IAM/SignJwt',
          ($45.SignJwtRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.SignJwtResponse.fromBuffer(value));
  static final _$getIamPolicy =
      $grpc.ClientMethod<$42.GetIamPolicyRequest, $43.Policy>(
          '/google.iam.admin.v1.IAM/GetIamPolicy',
          ($42.GetIamPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $43.Policy.fromBuffer(value));
  static final _$setIamPolicy =
      $grpc.ClientMethod<$42.SetIamPolicyRequest, $43.Policy>(
          '/google.iam.admin.v1.IAM/SetIamPolicy',
          ($42.SetIamPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $43.Policy.fromBuffer(value));
  static final _$testIamPermissions = $grpc.ClientMethod<
          $42.TestIamPermissionsRequest, $42.TestIamPermissionsResponse>(
      '/google.iam.admin.v1.IAM/TestIamPermissions',
      ($42.TestIamPermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.TestIamPermissionsResponse.fromBuffer(value));
  static final _$queryGrantableRoles = $grpc.ClientMethod<
          $45.QueryGrantableRolesRequest, $45.QueryGrantableRolesResponse>(
      '/google.iam.admin.v1.IAM/QueryGrantableRoles',
      ($45.QueryGrantableRolesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.QueryGrantableRolesResponse.fromBuffer(value));
  static final _$listRoles =
      $grpc.ClientMethod<$45.ListRolesRequest, $45.ListRolesResponse>(
          '/google.iam.admin.v1.IAM/ListRoles',
          ($45.ListRolesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.ListRolesResponse.fromBuffer(value));
  static final _$getRole = $grpc.ClientMethod<$45.GetRoleRequest, $45.Role>(
      '/google.iam.admin.v1.IAM/GetRole',
      ($45.GetRoleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $45.Role.fromBuffer(value));
  static final _$createRole =
      $grpc.ClientMethod<$45.CreateRoleRequest, $45.Role>(
          '/google.iam.admin.v1.IAM/CreateRole',
          ($45.CreateRoleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $45.Role.fromBuffer(value));
  static final _$updateRole =
      $grpc.ClientMethod<$45.UpdateRoleRequest, $45.Role>(
          '/google.iam.admin.v1.IAM/UpdateRole',
          ($45.UpdateRoleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $45.Role.fromBuffer(value));
  static final _$deleteRole =
      $grpc.ClientMethod<$45.DeleteRoleRequest, $45.Role>(
          '/google.iam.admin.v1.IAM/DeleteRole',
          ($45.DeleteRoleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $45.Role.fromBuffer(value));
  static final _$undeleteRole =
      $grpc.ClientMethod<$45.UndeleteRoleRequest, $45.Role>(
          '/google.iam.admin.v1.IAM/UndeleteRole',
          ($45.UndeleteRoleRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $45.Role.fromBuffer(value));
  static final _$queryTestablePermissions = $grpc.ClientMethod<
          $45.QueryTestablePermissionsRequest,
          $45.QueryTestablePermissionsResponse>(
      '/google.iam.admin.v1.IAM/QueryTestablePermissions',
      ($45.QueryTestablePermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.QueryTestablePermissionsResponse.fromBuffer(value));
  static final _$queryAuditableServices = $grpc.ClientMethod<
          $45.QueryAuditableServicesRequest,
          $45.QueryAuditableServicesResponse>(
      '/google.iam.admin.v1.IAM/QueryAuditableServices',
      ($45.QueryAuditableServicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $45.QueryAuditableServicesResponse.fromBuffer(value));
  static final _$lintPolicy =
      $grpc.ClientMethod<$45.LintPolicyRequest, $45.LintPolicyResponse>(
          '/google.iam.admin.v1.IAM/LintPolicy',
          ($45.LintPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $45.LintPolicyResponse.fromBuffer(value));

  IAMClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$45.ListServiceAccountsResponse> listServiceAccounts(
      $45.ListServiceAccountsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServiceAccounts, request, options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccount> getServiceAccount(
      $45.GetServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccount> createServiceAccount(
      $45.CreateServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccount> updateServiceAccount(
      $45.ServiceAccount request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccount> patchServiceAccount(
      $45.PatchServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$patchServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteServiceAccount(
      $45.DeleteServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.UndeleteServiceAccountResponse>
      undeleteServiceAccount($45.UndeleteServiceAccountRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteServiceAccount, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> enableServiceAccount(
      $45.EnableServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> disableServiceAccount(
      $45.DisableServiceAccountRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableServiceAccount, request, options: options);
  }

  $grpc.ResponseFuture<$45.ListServiceAccountKeysResponse>
      listServiceAccountKeys($45.ListServiceAccountKeysRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServiceAccountKeys, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccountKey> getServiceAccountKey(
      $45.GetServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceAccountKey, request, options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccountKey> createServiceAccountKey(
      $45.CreateServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createServiceAccountKey, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.ServiceAccountKey> uploadServiceAccountKey(
      $45.UploadServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadServiceAccountKey, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteServiceAccountKey(
      $45.DeleteServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteServiceAccountKey, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> disableServiceAccountKey(
      $45.DisableServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableServiceAccountKey, request,
        options: options);
  }

  $grpc.ResponseFuture<$1.Empty> enableServiceAccountKey(
      $45.EnableServiceAccountKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableServiceAccountKey, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.SignBlobResponse> signBlob(
      $45.SignBlobRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signBlob, request, options: options);
  }

  $grpc.ResponseFuture<$45.SignJwtResponse> signJwt($45.SignJwtRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signJwt, request, options: options);
  }

  $grpc.ResponseFuture<$43.Policy> getIamPolicy($42.GetIamPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIamPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$43.Policy> setIamPolicy($42.SetIamPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setIamPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$42.TestIamPermissionsResponse> testIamPermissions(
      $42.TestIamPermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testIamPermissions, request, options: options);
  }

  $grpc.ResponseFuture<$45.QueryGrantableRolesResponse> queryGrantableRoles(
      $45.QueryGrantableRolesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryGrantableRoles, request, options: options);
  }

  $grpc.ResponseFuture<$45.ListRolesResponse> listRoles(
      $45.ListRolesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listRoles, request, options: options);
  }

  $grpc.ResponseFuture<$45.Role> getRole($45.GetRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRole, request, options: options);
  }

  $grpc.ResponseFuture<$45.Role> createRole($45.CreateRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createRole, request, options: options);
  }

  $grpc.ResponseFuture<$45.Role> updateRole($45.UpdateRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateRole, request, options: options);
  }

  $grpc.ResponseFuture<$45.Role> deleteRole($45.DeleteRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteRole, request, options: options);
  }

  $grpc.ResponseFuture<$45.Role> undeleteRole($45.UndeleteRoleRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteRole, request, options: options);
  }

  $grpc.ResponseFuture<$45.QueryTestablePermissionsResponse>
      queryTestablePermissions($45.QueryTestablePermissionsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryTestablePermissions, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.QueryAuditableServicesResponse>
      queryAuditableServices($45.QueryAuditableServicesRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryAuditableServices, request,
        options: options);
  }

  $grpc.ResponseFuture<$45.LintPolicyResponse> lintPolicy(
      $45.LintPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lintPolicy, request, options: options);
  }
}

@$pb.GrpcServiceName('google.iam.admin.v1.IAM')
abstract class IAMServiceBase extends $grpc.Service {
  $core.String get $name => 'google.iam.admin.v1.IAM';

  IAMServiceBase() {
    $addMethod($grpc.ServiceMethod<$45.ListServiceAccountsRequest,
            $45.ListServiceAccountsResponse>(
        'ListServiceAccounts',
        listServiceAccounts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.ListServiceAccountsRequest.fromBuffer(value),
        ($45.ListServiceAccountsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.GetServiceAccountRequest, $45.ServiceAccount>(
            'GetServiceAccount',
            getServiceAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.GetServiceAccountRequest.fromBuffer(value),
            ($45.ServiceAccount value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.CreateServiceAccountRequest,
            $45.ServiceAccount>(
        'CreateServiceAccount',
        createServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.CreateServiceAccountRequest.fromBuffer(value),
        ($45.ServiceAccount value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.ServiceAccount, $45.ServiceAccount>(
        'UpdateServiceAccount',
        updateServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.ServiceAccount.fromBuffer(value),
        ($45.ServiceAccount value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.PatchServiceAccountRequest, $45.ServiceAccount>(
            'PatchServiceAccount',
            patchServiceAccount_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.PatchServiceAccountRequest.fromBuffer(value),
            ($45.ServiceAccount value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.DeleteServiceAccountRequest, $1.Empty>(
        'DeleteServiceAccount',
        deleteServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.DeleteServiceAccountRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UndeleteServiceAccountRequest,
            $45.UndeleteServiceAccountResponse>(
        'UndeleteServiceAccount',
        undeleteServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UndeleteServiceAccountRequest.fromBuffer(value),
        ($45.UndeleteServiceAccountResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.EnableServiceAccountRequest, $1.Empty>(
        'EnableServiceAccount',
        enableServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.EnableServiceAccountRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.DisableServiceAccountRequest, $1.Empty>(
        'DisableServiceAccount',
        disableServiceAccount_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.DisableServiceAccountRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.ListServiceAccountKeysRequest,
            $45.ListServiceAccountKeysResponse>(
        'ListServiceAccountKeys',
        listServiceAccountKeys_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.ListServiceAccountKeysRequest.fromBuffer(value),
        ($45.ListServiceAccountKeysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.GetServiceAccountKeyRequest,
            $45.ServiceAccountKey>(
        'GetServiceAccountKey',
        getServiceAccountKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.GetServiceAccountKeyRequest.fromBuffer(value),
        ($45.ServiceAccountKey value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.CreateServiceAccountKeyRequest,
            $45.ServiceAccountKey>(
        'CreateServiceAccountKey',
        createServiceAccountKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.CreateServiceAccountKeyRequest.fromBuffer(value),
        ($45.ServiceAccountKey value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UploadServiceAccountKeyRequest,
            $45.ServiceAccountKey>(
        'UploadServiceAccountKey',
        uploadServiceAccountKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UploadServiceAccountKeyRequest.fromBuffer(value),
        ($45.ServiceAccountKey value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.DeleteServiceAccountKeyRequest, $1.Empty>(
            'DeleteServiceAccountKey',
            deleteServiceAccountKey_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.DeleteServiceAccountKeyRequest.fromBuffer(value),
            ($1.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.DisableServiceAccountKeyRequest, $1.Empty>(
            'DisableServiceAccountKey',
            disableServiceAccountKey_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.DisableServiceAccountKeyRequest.fromBuffer(value),
            ($1.Empty value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.EnableServiceAccountKeyRequest, $1.Empty>(
            'EnableServiceAccountKey',
            enableServiceAccountKey_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.EnableServiceAccountKeyRequest.fromBuffer(value),
            ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.SignBlobRequest, $45.SignBlobResponse>(
        'SignBlob',
        signBlob_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.SignBlobRequest.fromBuffer(value),
        ($45.SignBlobResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.SignJwtRequest, $45.SignJwtResponse>(
        'SignJwt',
        signJwt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.SignJwtRequest.fromBuffer(value),
        ($45.SignJwtResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetIamPolicyRequest, $43.Policy>(
        'GetIamPolicy',
        getIamPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetIamPolicyRequest.fromBuffer(value),
        ($43.Policy value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.SetIamPolicyRequest, $43.Policy>(
        'SetIamPolicy',
        setIamPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.SetIamPolicyRequest.fromBuffer(value),
        ($43.Policy value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.TestIamPermissionsRequest,
            $42.TestIamPermissionsResponse>(
        'TestIamPermissions',
        testIamPermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.TestIamPermissionsRequest.fromBuffer(value),
        ($42.TestIamPermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.QueryGrantableRolesRequest,
            $45.QueryGrantableRolesResponse>(
        'QueryGrantableRoles',
        queryGrantableRoles_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.QueryGrantableRolesRequest.fromBuffer(value),
        ($45.QueryGrantableRolesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.ListRolesRequest, $45.ListRolesResponse>(
        'ListRoles',
        listRoles_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.ListRolesRequest.fromBuffer(value),
        ($45.ListRolesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.GetRoleRequest, $45.Role>(
        'GetRole',
        getRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $45.GetRoleRequest.fromBuffer(value),
        ($45.Role value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.CreateRoleRequest, $45.Role>(
        'CreateRole',
        createRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.CreateRoleRequest.fromBuffer(value),
        ($45.Role value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UpdateRoleRequest, $45.Role>(
        'UpdateRole',
        updateRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UpdateRoleRequest.fromBuffer(value),
        ($45.Role value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.DeleteRoleRequest, $45.Role>(
        'DeleteRole',
        deleteRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.DeleteRoleRequest.fromBuffer(value),
        ($45.Role value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.UndeleteRoleRequest, $45.Role>(
        'UndeleteRole',
        undeleteRole_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.UndeleteRoleRequest.fromBuffer(value),
        ($45.Role value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.QueryTestablePermissionsRequest,
            $45.QueryTestablePermissionsResponse>(
        'QueryTestablePermissions',
        queryTestablePermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.QueryTestablePermissionsRequest.fromBuffer(value),
        ($45.QueryTestablePermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$45.QueryAuditableServicesRequest,
            $45.QueryAuditableServicesResponse>(
        'QueryAuditableServices',
        queryAuditableServices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $45.QueryAuditableServicesRequest.fromBuffer(value),
        ($45.QueryAuditableServicesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$45.LintPolicyRequest, $45.LintPolicyResponse>(
            'LintPolicy',
            lintPolicy_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $45.LintPolicyRequest.fromBuffer(value),
            ($45.LintPolicyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$45.ListServiceAccountsResponse> listServiceAccounts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.ListServiceAccountsRequest> request) async {
    return listServiceAccounts(call, await request);
  }

  $async.Future<$45.ServiceAccount> getServiceAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.GetServiceAccountRequest> request) async {
    return getServiceAccount(call, await request);
  }

  $async.Future<$45.ServiceAccount> createServiceAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.CreateServiceAccountRequest> request) async {
    return createServiceAccount(call, await request);
  }

  $async.Future<$45.ServiceAccount> updateServiceAccount_Pre(
      $grpc.ServiceCall call, $async.Future<$45.ServiceAccount> request) async {
    return updateServiceAccount(call, await request);
  }

  $async.Future<$45.ServiceAccount> patchServiceAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.PatchServiceAccountRequest> request) async {
    return patchServiceAccount(call, await request);
  }

  $async.Future<$1.Empty> deleteServiceAccount_Pre($grpc.ServiceCall call,
      $async.Future<$45.DeleteServiceAccountRequest> request) async {
    return deleteServiceAccount(call, await request);
  }

  $async.Future<$45.UndeleteServiceAccountResponse> undeleteServiceAccount_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.UndeleteServiceAccountRequest> request) async {
    return undeleteServiceAccount(call, await request);
  }

  $async.Future<$1.Empty> enableServiceAccount_Pre($grpc.ServiceCall call,
      $async.Future<$45.EnableServiceAccountRequest> request) async {
    return enableServiceAccount(call, await request);
  }

  $async.Future<$1.Empty> disableServiceAccount_Pre($grpc.ServiceCall call,
      $async.Future<$45.DisableServiceAccountRequest> request) async {
    return disableServiceAccount(call, await request);
  }

  $async.Future<$45.ListServiceAccountKeysResponse> listServiceAccountKeys_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.ListServiceAccountKeysRequest> request) async {
    return listServiceAccountKeys(call, await request);
  }

  $async.Future<$45.ServiceAccountKey> getServiceAccountKey_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.GetServiceAccountKeyRequest> request) async {
    return getServiceAccountKey(call, await request);
  }

  $async.Future<$45.ServiceAccountKey> createServiceAccountKey_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.CreateServiceAccountKeyRequest> request) async {
    return createServiceAccountKey(call, await request);
  }

  $async.Future<$45.ServiceAccountKey> uploadServiceAccountKey_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.UploadServiceAccountKeyRequest> request) async {
    return uploadServiceAccountKey(call, await request);
  }

  $async.Future<$1.Empty> deleteServiceAccountKey_Pre($grpc.ServiceCall call,
      $async.Future<$45.DeleteServiceAccountKeyRequest> request) async {
    return deleteServiceAccountKey(call, await request);
  }

  $async.Future<$1.Empty> disableServiceAccountKey_Pre($grpc.ServiceCall call,
      $async.Future<$45.DisableServiceAccountKeyRequest> request) async {
    return disableServiceAccountKey(call, await request);
  }

  $async.Future<$1.Empty> enableServiceAccountKey_Pre($grpc.ServiceCall call,
      $async.Future<$45.EnableServiceAccountKeyRequest> request) async {
    return enableServiceAccountKey(call, await request);
  }

  $async.Future<$45.SignBlobResponse> signBlob_Pre($grpc.ServiceCall call,
      $async.Future<$45.SignBlobRequest> request) async {
    return signBlob(call, await request);
  }

  $async.Future<$45.SignJwtResponse> signJwt_Pre(
      $grpc.ServiceCall call, $async.Future<$45.SignJwtRequest> request) async {
    return signJwt(call, await request);
  }

  $async.Future<$43.Policy> getIamPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$42.GetIamPolicyRequest> request) async {
    return getIamPolicy(call, await request);
  }

  $async.Future<$43.Policy> setIamPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$42.SetIamPolicyRequest> request) async {
    return setIamPolicy(call, await request);
  }

  $async.Future<$42.TestIamPermissionsResponse> testIamPermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.TestIamPermissionsRequest> request) async {
    return testIamPermissions(call, await request);
  }

  $async.Future<$45.QueryGrantableRolesResponse> queryGrantableRoles_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.QueryGrantableRolesRequest> request) async {
    return queryGrantableRoles(call, await request);
  }

  $async.Future<$45.ListRolesResponse> listRoles_Pre($grpc.ServiceCall call,
      $async.Future<$45.ListRolesRequest> request) async {
    return listRoles(call, await request);
  }

  $async.Future<$45.Role> getRole_Pre(
      $grpc.ServiceCall call, $async.Future<$45.GetRoleRequest> request) async {
    return getRole(call, await request);
  }

  $async.Future<$45.Role> createRole_Pre($grpc.ServiceCall call,
      $async.Future<$45.CreateRoleRequest> request) async {
    return createRole(call, await request);
  }

  $async.Future<$45.Role> updateRole_Pre($grpc.ServiceCall call,
      $async.Future<$45.UpdateRoleRequest> request) async {
    return updateRole(call, await request);
  }

  $async.Future<$45.Role> deleteRole_Pre($grpc.ServiceCall call,
      $async.Future<$45.DeleteRoleRequest> request) async {
    return deleteRole(call, await request);
  }

  $async.Future<$45.Role> undeleteRole_Pre($grpc.ServiceCall call,
      $async.Future<$45.UndeleteRoleRequest> request) async {
    return undeleteRole(call, await request);
  }

  $async.Future<$45.QueryTestablePermissionsResponse>
      queryTestablePermissions_Pre($grpc.ServiceCall call,
          $async.Future<$45.QueryTestablePermissionsRequest> request) async {
    return queryTestablePermissions(call, await request);
  }

  $async.Future<$45.QueryAuditableServicesResponse> queryAuditableServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$45.QueryAuditableServicesRequest> request) async {
    return queryAuditableServices(call, await request);
  }

  $async.Future<$45.LintPolicyResponse> lintPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$45.LintPolicyRequest> request) async {
    return lintPolicy(call, await request);
  }

  $async.Future<$45.ListServiceAccountsResponse> listServiceAccounts(
      $grpc.ServiceCall call, $45.ListServiceAccountsRequest request);
  $async.Future<$45.ServiceAccount> getServiceAccount(
      $grpc.ServiceCall call, $45.GetServiceAccountRequest request);
  $async.Future<$45.ServiceAccount> createServiceAccount(
      $grpc.ServiceCall call, $45.CreateServiceAccountRequest request);
  $async.Future<$45.ServiceAccount> updateServiceAccount(
      $grpc.ServiceCall call, $45.ServiceAccount request);
  $async.Future<$45.ServiceAccount> patchServiceAccount(
      $grpc.ServiceCall call, $45.PatchServiceAccountRequest request);
  $async.Future<$1.Empty> deleteServiceAccount(
      $grpc.ServiceCall call, $45.DeleteServiceAccountRequest request);
  $async.Future<$45.UndeleteServiceAccountResponse> undeleteServiceAccount(
      $grpc.ServiceCall call, $45.UndeleteServiceAccountRequest request);
  $async.Future<$1.Empty> enableServiceAccount(
      $grpc.ServiceCall call, $45.EnableServiceAccountRequest request);
  $async.Future<$1.Empty> disableServiceAccount(
      $grpc.ServiceCall call, $45.DisableServiceAccountRequest request);
  $async.Future<$45.ListServiceAccountKeysResponse> listServiceAccountKeys(
      $grpc.ServiceCall call, $45.ListServiceAccountKeysRequest request);
  $async.Future<$45.ServiceAccountKey> getServiceAccountKey(
      $grpc.ServiceCall call, $45.GetServiceAccountKeyRequest request);
  $async.Future<$45.ServiceAccountKey> createServiceAccountKey(
      $grpc.ServiceCall call, $45.CreateServiceAccountKeyRequest request);
  $async.Future<$45.ServiceAccountKey> uploadServiceAccountKey(
      $grpc.ServiceCall call, $45.UploadServiceAccountKeyRequest request);
  $async.Future<$1.Empty> deleteServiceAccountKey(
      $grpc.ServiceCall call, $45.DeleteServiceAccountKeyRequest request);
  $async.Future<$1.Empty> disableServiceAccountKey(
      $grpc.ServiceCall call, $45.DisableServiceAccountKeyRequest request);
  $async.Future<$1.Empty> enableServiceAccountKey(
      $grpc.ServiceCall call, $45.EnableServiceAccountKeyRequest request);
  $async.Future<$45.SignBlobResponse> signBlob(
      $grpc.ServiceCall call, $45.SignBlobRequest request);
  $async.Future<$45.SignJwtResponse> signJwt(
      $grpc.ServiceCall call, $45.SignJwtRequest request);
  $async.Future<$43.Policy> getIamPolicy(
      $grpc.ServiceCall call, $42.GetIamPolicyRequest request);
  $async.Future<$43.Policy> setIamPolicy(
      $grpc.ServiceCall call, $42.SetIamPolicyRequest request);
  $async.Future<$42.TestIamPermissionsResponse> testIamPermissions(
      $grpc.ServiceCall call, $42.TestIamPermissionsRequest request);
  $async.Future<$45.QueryGrantableRolesResponse> queryGrantableRoles(
      $grpc.ServiceCall call, $45.QueryGrantableRolesRequest request);
  $async.Future<$45.ListRolesResponse> listRoles(
      $grpc.ServiceCall call, $45.ListRolesRequest request);
  $async.Future<$45.Role> getRole(
      $grpc.ServiceCall call, $45.GetRoleRequest request);
  $async.Future<$45.Role> createRole(
      $grpc.ServiceCall call, $45.CreateRoleRequest request);
  $async.Future<$45.Role> updateRole(
      $grpc.ServiceCall call, $45.UpdateRoleRequest request);
  $async.Future<$45.Role> deleteRole(
      $grpc.ServiceCall call, $45.DeleteRoleRequest request);
  $async.Future<$45.Role> undeleteRole(
      $grpc.ServiceCall call, $45.UndeleteRoleRequest request);
  $async.Future<$45.QueryTestablePermissionsResponse> queryTestablePermissions(
      $grpc.ServiceCall call, $45.QueryTestablePermissionsRequest request);
  $async.Future<$45.QueryAuditableServicesResponse> queryAuditableServices(
      $grpc.ServiceCall call, $45.QueryAuditableServicesRequest request);
  $async.Future<$45.LintPolicyResponse> lintPolicy(
      $grpc.ServiceCall call, $45.LintPolicyRequest request);
}
