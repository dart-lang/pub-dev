//
//  Generated code. Do not modify.
//  source: google/iam/v1beta/workload_identity_pool.proto
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

import '../../longrunning/operations.pb.dart' as $0;
import 'workload_identity_pool.pb.dart' as $41;

export 'workload_identity_pool.pb.dart';

@$pb.GrpcServiceName('google.iam.v1beta.WorkloadIdentityPools')
class WorkloadIdentityPoolsClient extends $grpc.Client {
  static final _$listWorkloadIdentityPools = $grpc.ClientMethod<
          $41.ListWorkloadIdentityPoolsRequest,
          $41.ListWorkloadIdentityPoolsResponse>(
      '/google.iam.v1beta.WorkloadIdentityPools/ListWorkloadIdentityPools',
      ($41.ListWorkloadIdentityPoolsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.ListWorkloadIdentityPoolsResponse.fromBuffer(value));
  static final _$getWorkloadIdentityPool = $grpc.ClientMethod<
          $41.GetWorkloadIdentityPoolRequest, $41.WorkloadIdentityPool>(
      '/google.iam.v1beta.WorkloadIdentityPools/GetWorkloadIdentityPool',
      ($41.GetWorkloadIdentityPoolRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.WorkloadIdentityPool.fromBuffer(value));
  static final _$createWorkloadIdentityPool =
      $grpc.ClientMethod<$41.CreateWorkloadIdentityPoolRequest, $0.Operation>(
          '/google.iam.v1beta.WorkloadIdentityPools/CreateWorkloadIdentityPool',
          ($41.CreateWorkloadIdentityPoolRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateWorkloadIdentityPool =
      $grpc.ClientMethod<$41.UpdateWorkloadIdentityPoolRequest, $0.Operation>(
          '/google.iam.v1beta.WorkloadIdentityPools/UpdateWorkloadIdentityPool',
          ($41.UpdateWorkloadIdentityPoolRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteWorkloadIdentityPool =
      $grpc.ClientMethod<$41.DeleteWorkloadIdentityPoolRequest, $0.Operation>(
          '/google.iam.v1beta.WorkloadIdentityPools/DeleteWorkloadIdentityPool',
          ($41.DeleteWorkloadIdentityPoolRequest value) =>
              value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$undeleteWorkloadIdentityPool = $grpc.ClientMethod<
          $41.UndeleteWorkloadIdentityPoolRequest, $0.Operation>(
      '/google.iam.v1beta.WorkloadIdentityPools/UndeleteWorkloadIdentityPool',
      ($41.UndeleteWorkloadIdentityPoolRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listWorkloadIdentityPoolProviders = $grpc.ClientMethod<
          $41.ListWorkloadIdentityPoolProvidersRequest,
          $41.ListWorkloadIdentityPoolProvidersResponse>(
      '/google.iam.v1beta.WorkloadIdentityPools/ListWorkloadIdentityPoolProviders',
      ($41.ListWorkloadIdentityPoolProvidersRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.ListWorkloadIdentityPoolProvidersResponse.fromBuffer(value));
  static final _$getWorkloadIdentityPoolProvider = $grpc.ClientMethod<
          $41.GetWorkloadIdentityPoolProviderRequest,
          $41.WorkloadIdentityPoolProvider>(
      '/google.iam.v1beta.WorkloadIdentityPools/GetWorkloadIdentityPoolProvider',
      ($41.GetWorkloadIdentityPoolProviderRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $41.WorkloadIdentityPoolProvider.fromBuffer(value));
  static final _$createWorkloadIdentityPoolProvider = $grpc.ClientMethod<
          $41.CreateWorkloadIdentityPoolProviderRequest, $0.Operation>(
      '/google.iam.v1beta.WorkloadIdentityPools/CreateWorkloadIdentityPoolProvider',
      ($41.CreateWorkloadIdentityPoolProviderRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateWorkloadIdentityPoolProvider = $grpc.ClientMethod<
          $41.UpdateWorkloadIdentityPoolProviderRequest, $0.Operation>(
      '/google.iam.v1beta.WorkloadIdentityPools/UpdateWorkloadIdentityPoolProvider',
      ($41.UpdateWorkloadIdentityPoolProviderRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteWorkloadIdentityPoolProvider = $grpc.ClientMethod<
          $41.DeleteWorkloadIdentityPoolProviderRequest, $0.Operation>(
      '/google.iam.v1beta.WorkloadIdentityPools/DeleteWorkloadIdentityPoolProvider',
      ($41.DeleteWorkloadIdentityPoolProviderRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$undeleteWorkloadIdentityPoolProvider = $grpc.ClientMethod<
          $41.UndeleteWorkloadIdentityPoolProviderRequest, $0.Operation>(
      '/google.iam.v1beta.WorkloadIdentityPools/UndeleteWorkloadIdentityPoolProvider',
      ($41.UndeleteWorkloadIdentityPoolProviderRequest value) =>
          value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  WorkloadIdentityPoolsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$41.ListWorkloadIdentityPoolsResponse>
      listWorkloadIdentityPools($41.ListWorkloadIdentityPoolsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listWorkloadIdentityPools, request,
        options: options);
  }

  $grpc.ResponseFuture<$41.WorkloadIdentityPool> getWorkloadIdentityPool(
      $41.GetWorkloadIdentityPoolRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWorkloadIdentityPool, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createWorkloadIdentityPool(
      $41.CreateWorkloadIdentityPoolRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWorkloadIdentityPool, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateWorkloadIdentityPool(
      $41.UpdateWorkloadIdentityPoolRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWorkloadIdentityPool, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteWorkloadIdentityPool(
      $41.DeleteWorkloadIdentityPoolRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWorkloadIdentityPool, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> undeleteWorkloadIdentityPool(
      $41.UndeleteWorkloadIdentityPoolRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteWorkloadIdentityPool, request,
        options: options);
  }

  $grpc.ResponseFuture<$41.ListWorkloadIdentityPoolProvidersResponse>
      listWorkloadIdentityPoolProviders(
          $41.ListWorkloadIdentityPoolProvidersRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listWorkloadIdentityPoolProviders, request,
        options: options);
  }

  $grpc.ResponseFuture<$41.WorkloadIdentityPoolProvider>
      getWorkloadIdentityPoolProvider(
          $41.GetWorkloadIdentityPoolProviderRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getWorkloadIdentityPoolProvider, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createWorkloadIdentityPoolProvider(
      $41.CreateWorkloadIdentityPoolProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createWorkloadIdentityPoolProvider, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateWorkloadIdentityPoolProvider(
      $41.UpdateWorkloadIdentityPoolProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWorkloadIdentityPoolProvider, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteWorkloadIdentityPoolProvider(
      $41.DeleteWorkloadIdentityPoolProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWorkloadIdentityPoolProvider, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> undeleteWorkloadIdentityPoolProvider(
      $41.UndeleteWorkloadIdentityPoolProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteWorkloadIdentityPoolProvider, request,
        options: options);
  }
}

@$pb.GrpcServiceName('google.iam.v1beta.WorkloadIdentityPools')
abstract class WorkloadIdentityPoolsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.iam.v1beta.WorkloadIdentityPools';

  WorkloadIdentityPoolsServiceBase() {
    $addMethod($grpc.ServiceMethod<$41.ListWorkloadIdentityPoolsRequest,
            $41.ListWorkloadIdentityPoolsResponse>(
        'ListWorkloadIdentityPools',
        listWorkloadIdentityPools_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.ListWorkloadIdentityPoolsRequest.fromBuffer(value),
        ($41.ListWorkloadIdentityPoolsResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetWorkloadIdentityPoolRequest,
            $41.WorkloadIdentityPool>(
        'GetWorkloadIdentityPool',
        getWorkloadIdentityPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetWorkloadIdentityPoolRequest.fromBuffer(value),
        ($41.WorkloadIdentityPool value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.CreateWorkloadIdentityPoolRequest,
            $0.Operation>(
        'CreateWorkloadIdentityPool',
        createWorkloadIdentityPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.CreateWorkloadIdentityPoolRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UpdateWorkloadIdentityPoolRequest,
            $0.Operation>(
        'UpdateWorkloadIdentityPool',
        updateWorkloadIdentityPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdateWorkloadIdentityPoolRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.DeleteWorkloadIdentityPoolRequest,
            $0.Operation>(
        'DeleteWorkloadIdentityPool',
        deleteWorkloadIdentityPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.DeleteWorkloadIdentityPoolRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.UndeleteWorkloadIdentityPoolRequest,
            $0.Operation>(
        'UndeleteWorkloadIdentityPool',
        undeleteWorkloadIdentityPool_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UndeleteWorkloadIdentityPoolRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.ListWorkloadIdentityPoolProvidersRequest,
            $41.ListWorkloadIdentityPoolProvidersResponse>(
        'ListWorkloadIdentityPoolProviders',
        listWorkloadIdentityPoolProviders_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.ListWorkloadIdentityPoolProvidersRequest.fromBuffer(value),
        ($41.ListWorkloadIdentityPoolProvidersResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$41.GetWorkloadIdentityPoolProviderRequest,
            $41.WorkloadIdentityPoolProvider>(
        'GetWorkloadIdentityPoolProvider',
        getWorkloadIdentityPoolProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.GetWorkloadIdentityPoolProviderRequest.fromBuffer(value),
        ($41.WorkloadIdentityPoolProvider value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $41.CreateWorkloadIdentityPoolProviderRequest, $0.Operation>(
        'CreateWorkloadIdentityPoolProvider',
        createWorkloadIdentityPoolProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.CreateWorkloadIdentityPoolProviderRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $41.UpdateWorkloadIdentityPoolProviderRequest, $0.Operation>(
        'UpdateWorkloadIdentityPoolProvider',
        updateWorkloadIdentityPoolProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UpdateWorkloadIdentityPoolProviderRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $41.DeleteWorkloadIdentityPoolProviderRequest, $0.Operation>(
        'DeleteWorkloadIdentityPoolProvider',
        deleteWorkloadIdentityPoolProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.DeleteWorkloadIdentityPoolProviderRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<
            $41.UndeleteWorkloadIdentityPoolProviderRequest, $0.Operation>(
        'UndeleteWorkloadIdentityPoolProvider',
        undeleteWorkloadIdentityPoolProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $41.UndeleteWorkloadIdentityPoolProviderRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$41.ListWorkloadIdentityPoolsResponse>
      listWorkloadIdentityPools_Pre($grpc.ServiceCall call,
          $async.Future<$41.ListWorkloadIdentityPoolsRequest> request) async {
    return listWorkloadIdentityPools(call, await request);
  }

  $async.Future<$41.WorkloadIdentityPool> getWorkloadIdentityPool_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.GetWorkloadIdentityPoolRequest> request) async {
    return getWorkloadIdentityPool(call, await request);
  }

  $async.Future<$0.Operation> createWorkloadIdentityPool_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.CreateWorkloadIdentityPoolRequest> request) async {
    return createWorkloadIdentityPool(call, await request);
  }

  $async.Future<$0.Operation> updateWorkloadIdentityPool_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UpdateWorkloadIdentityPoolRequest> request) async {
    return updateWorkloadIdentityPool(call, await request);
  }

  $async.Future<$0.Operation> deleteWorkloadIdentityPool_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.DeleteWorkloadIdentityPoolRequest> request) async {
    return deleteWorkloadIdentityPool(call, await request);
  }

  $async.Future<$0.Operation> undeleteWorkloadIdentityPool_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UndeleteWorkloadIdentityPoolRequest> request) async {
    return undeleteWorkloadIdentityPool(call, await request);
  }

  $async.Future<$41.ListWorkloadIdentityPoolProvidersResponse>
      listWorkloadIdentityPoolProviders_Pre(
          $grpc.ServiceCall call,
          $async.Future<$41.ListWorkloadIdentityPoolProvidersRequest>
              request) async {
    return listWorkloadIdentityPoolProviders(call, await request);
  }

  $async.Future<$41.WorkloadIdentityPoolProvider>
      getWorkloadIdentityPoolProvider_Pre(
          $grpc.ServiceCall call,
          $async.Future<$41.GetWorkloadIdentityPoolProviderRequest>
              request) async {
    return getWorkloadIdentityPoolProvider(call, await request);
  }

  $async.Future<$0.Operation> createWorkloadIdentityPoolProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.CreateWorkloadIdentityPoolProviderRequest>
          request) async {
    return createWorkloadIdentityPoolProvider(call, await request);
  }

  $async.Future<$0.Operation> updateWorkloadIdentityPoolProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UpdateWorkloadIdentityPoolProviderRequest>
          request) async {
    return updateWorkloadIdentityPoolProvider(call, await request);
  }

  $async.Future<$0.Operation> deleteWorkloadIdentityPoolProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.DeleteWorkloadIdentityPoolProviderRequest>
          request) async {
    return deleteWorkloadIdentityPoolProvider(call, await request);
  }

  $async.Future<$0.Operation> undeleteWorkloadIdentityPoolProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$41.UndeleteWorkloadIdentityPoolProviderRequest>
          request) async {
    return undeleteWorkloadIdentityPoolProvider(call, await request);
  }

  $async.Future<$41.ListWorkloadIdentityPoolsResponse>
      listWorkloadIdentityPools(
          $grpc.ServiceCall call, $41.ListWorkloadIdentityPoolsRequest request);
  $async.Future<$41.WorkloadIdentityPool> getWorkloadIdentityPool(
      $grpc.ServiceCall call, $41.GetWorkloadIdentityPoolRequest request);
  $async.Future<$0.Operation> createWorkloadIdentityPool(
      $grpc.ServiceCall call, $41.CreateWorkloadIdentityPoolRequest request);
  $async.Future<$0.Operation> updateWorkloadIdentityPool(
      $grpc.ServiceCall call, $41.UpdateWorkloadIdentityPoolRequest request);
  $async.Future<$0.Operation> deleteWorkloadIdentityPool(
      $grpc.ServiceCall call, $41.DeleteWorkloadIdentityPoolRequest request);
  $async.Future<$0.Operation> undeleteWorkloadIdentityPool(
      $grpc.ServiceCall call, $41.UndeleteWorkloadIdentityPoolRequest request);
  $async.Future<$41.ListWorkloadIdentityPoolProvidersResponse>
      listWorkloadIdentityPoolProviders($grpc.ServiceCall call,
          $41.ListWorkloadIdentityPoolProvidersRequest request);
  $async.Future<$41.WorkloadIdentityPoolProvider>
      getWorkloadIdentityPoolProvider($grpc.ServiceCall call,
          $41.GetWorkloadIdentityPoolProviderRequest request);
  $async.Future<$0.Operation> createWorkloadIdentityPoolProvider(
      $grpc.ServiceCall call,
      $41.CreateWorkloadIdentityPoolProviderRequest request);
  $async.Future<$0.Operation> updateWorkloadIdentityPoolProvider(
      $grpc.ServiceCall call,
      $41.UpdateWorkloadIdentityPoolProviderRequest request);
  $async.Future<$0.Operation> deleteWorkloadIdentityPoolProvider(
      $grpc.ServiceCall call,
      $41.DeleteWorkloadIdentityPoolProviderRequest request);
  $async.Future<$0.Operation> undeleteWorkloadIdentityPoolProvider(
      $grpc.ServiceCall call,
      $41.UndeleteWorkloadIdentityPoolProviderRequest request);
}
