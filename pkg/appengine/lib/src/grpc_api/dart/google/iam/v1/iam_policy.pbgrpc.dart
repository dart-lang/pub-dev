//
//  Generated code. Do not modify.
//  source: google/iam/v1/iam_policy.proto
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

import 'iam_policy.pb.dart' as $42;
import 'policy.pb.dart' as $43;

export 'iam_policy.pb.dart';

@$pb.GrpcServiceName('google.iam.v1.IAMPolicy')
class IAMPolicyClient extends $grpc.Client {
  static final _$setIamPolicy =
      $grpc.ClientMethod<$42.SetIamPolicyRequest, $43.Policy>(
          '/google.iam.v1.IAMPolicy/SetIamPolicy',
          ($42.SetIamPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $43.Policy.fromBuffer(value));
  static final _$getIamPolicy =
      $grpc.ClientMethod<$42.GetIamPolicyRequest, $43.Policy>(
          '/google.iam.v1.IAMPolicy/GetIamPolicy',
          ($42.GetIamPolicyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $43.Policy.fromBuffer(value));
  static final _$testIamPermissions = $grpc.ClientMethod<
          $42.TestIamPermissionsRequest, $42.TestIamPermissionsResponse>(
      '/google.iam.v1.IAMPolicy/TestIamPermissions',
      ($42.TestIamPermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $42.TestIamPermissionsResponse.fromBuffer(value));

  IAMPolicyClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$43.Policy> setIamPolicy($42.SetIamPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setIamPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$43.Policy> getIamPolicy($42.GetIamPolicyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getIamPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$42.TestIamPermissionsResponse> testIamPermissions(
      $42.TestIamPermissionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$testIamPermissions, request, options: options);
  }
}

@$pb.GrpcServiceName('google.iam.v1.IAMPolicy')
abstract class IAMPolicyServiceBase extends $grpc.Service {
  $core.String get $name => 'google.iam.v1.IAMPolicy';

  IAMPolicyServiceBase() {
    $addMethod($grpc.ServiceMethod<$42.SetIamPolicyRequest, $43.Policy>(
        'SetIamPolicy',
        setIamPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.SetIamPolicyRequest.fromBuffer(value),
        ($43.Policy value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$42.GetIamPolicyRequest, $43.Policy>(
        'GetIamPolicy',
        getIamPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $42.GetIamPolicyRequest.fromBuffer(value),
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
  }

  $async.Future<$43.Policy> setIamPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$42.SetIamPolicyRequest> request) async {
    return setIamPolicy(call, await request);
  }

  $async.Future<$43.Policy> getIamPolicy_Pre($grpc.ServiceCall call,
      $async.Future<$42.GetIamPolicyRequest> request) async {
    return getIamPolicy(call, await request);
  }

  $async.Future<$42.TestIamPermissionsResponse> testIamPermissions_Pre(
      $grpc.ServiceCall call,
      $async.Future<$42.TestIamPermissionsRequest> request) async {
    return testIamPermissions(call, await request);
  }

  $async.Future<$43.Policy> setIamPolicy(
      $grpc.ServiceCall call, $42.SetIamPolicyRequest request);
  $async.Future<$43.Policy> getIamPolicy(
      $grpc.ServiceCall call, $42.GetIamPolicyRequest request);
  $async.Future<$42.TestIamPermissionsResponse> testIamPermissions(
      $grpc.ServiceCall call, $42.TestIamPermissionsRequest request);
}
