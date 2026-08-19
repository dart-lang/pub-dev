//
//  Generated code. Do not modify.
//  source: google/iam/v2beta/policy.proto
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
import 'policy.pb.dart' as $46;

export 'policy.pb.dart';

@$pb.GrpcServiceName('google.iam.v2beta.Policies')
class PoliciesClient extends $grpc.Client {
  static final _$listPolicies =
      $grpc.ClientMethod<$46.ListPoliciesRequest, $46.ListPoliciesResponse>(
          '/google.iam.v2beta.Policies/ListPolicies',
          ($46.ListPoliciesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $46.ListPoliciesResponse.fromBuffer(value));
  static final _$getPolicy =
      $grpc.ClientMethod<$46.GetPolicyRequest, $46.Policy>(
          '/google.iam.v2beta.Policies/GetPolicy',
          ($46.GetPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $46.Policy.fromBuffer(value));
  static final _$createPolicy =
      $grpc.ClientMethod<$46.CreatePolicyRequest, $0.Operation>(
          '/google.iam.v2beta.Policies/CreatePolicy',
          ($46.CreatePolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updatePolicy =
      $grpc.ClientMethod<$46.UpdatePolicyRequest, $0.Operation>(
          '/google.iam.v2beta.Policies/UpdatePolicy',
          ($46.UpdatePolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deletePolicy =
      $grpc.ClientMethod<$46.DeletePolicyRequest, $0.Operation>(
          '/google.iam.v2beta.Policies/DeletePolicy',
          ($46.DeletePolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  PoliciesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$46.ListPoliciesResponse> listPolicies(
      $46.ListPoliciesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPolicies, request, options: options);
  }

  $grpc.ResponseFuture<$46.Policy> getPolicy($46.GetPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createPolicy(
      $46.CreatePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updatePolicy(
      $46.UpdatePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updatePolicy, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deletePolicy(
      $46.DeletePolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePolicy, request, options: options);
  }
}

@$pb.GrpcServiceName('google.iam.v2beta.Policies')
abstract class PoliciesServiceBase extends $grpc.Service {
  $core.String get $name => 'google.iam.v2beta.Policies';

  PoliciesServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$46.ListPoliciesRequest, $46.ListPoliciesResponse>(
            'ListPolicies',
            listPolicies_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $46.ListPoliciesRequest.fromBuffer(value),
            ($46.ListPoliciesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.GetPolicyRequest, $46.Policy>(
        'GetPolicy',
        getPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $46.GetPolicyRequest.fromBuffer(value),
        ($46.Policy value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.CreatePolicyRequest, $0.Operation>(
        'CreatePolicy',
        createPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.CreatePolicyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.UpdatePolicyRequest, $0.Operation>(
        'UpdatePolicy',
        updatePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.UpdatePolicyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$46.DeletePolicyRequest, $0.Operation>(
        'DeletePolicy',
        deletePolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $46.DeletePolicyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$46.ListPoliciesResponse> listPolicies_Pre(
      $grpc.ServiceCall call,
      $async.Future<$46.ListPoliciesRequest> request) async {
    return listPolicies(call, await request);
  }

  $async.Future<$46.Policy> getPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$46.GetPolicyRequest> request) async {
    return getPolicy(call, await request);
  }

  $async.Future<$0.Operation> createPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$46.CreatePolicyRequest> request) async {
    return createPolicy(call, await request);
  }

  $async.Future<$0.Operation> updatePolicy_Pre($grpc.ServiceCall call,
      $async.Future<$46.UpdatePolicyRequest> request) async {
    return updatePolicy(call, await request);
  }

  $async.Future<$0.Operation> deletePolicy_Pre($grpc.ServiceCall call,
      $async.Future<$46.DeletePolicyRequest> request) async {
    return deletePolicy(call, await request);
  }

  $async.Future<$46.ListPoliciesResponse> listPolicies(
      $grpc.ServiceCall call, $46.ListPoliciesRequest request);
  $async.Future<$46.Policy> getPolicy(
      $grpc.ServiceCall call, $46.GetPolicyRequest request);
  $async.Future<$0.Operation> createPolicy(
      $grpc.ServiceCall call, $46.CreatePolicyRequest request);
  $async.Future<$0.Operation> updatePolicy(
      $grpc.ServiceCall call, $46.UpdatePolicyRequest request);
  $async.Future<$0.Operation> deletePolicy(
      $grpc.ServiceCall call, $46.DeletePolicyRequest request);
}
