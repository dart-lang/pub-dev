//
//  Generated code. Do not modify.
//  source: google/iam/credentials/v1/iamcredentials.proto
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

import 'common.pb.dart' as $44;

export 'iamcredentials.pb.dart';

@$pb.GrpcServiceName('google.iam.credentials.v1.IAMCredentials')
class IAMCredentialsClient extends $grpc.Client {
  static final _$generateAccessToken = $grpc.ClientMethod<
          $44.GenerateAccessTokenRequest, $44.GenerateAccessTokenResponse>(
      '/google.iam.credentials.v1.IAMCredentials/GenerateAccessToken',
      ($44.GenerateAccessTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.GenerateAccessTokenResponse.fromBuffer(value));
  static final _$generateIdToken = $grpc.ClientMethod<
          $44.GenerateIdTokenRequest, $44.GenerateIdTokenResponse>(
      '/google.iam.credentials.v1.IAMCredentials/GenerateIdToken',
      ($44.GenerateIdTokenRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $44.GenerateIdTokenResponse.fromBuffer(value));
  static final _$signBlob =
      $grpc.ClientMethod<$44.SignBlobRequest, $44.SignBlobResponse>(
          '/google.iam.credentials.v1.IAMCredentials/SignBlob',
          ($44.SignBlobRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $44.SignBlobResponse.fromBuffer(value));
  static final _$signJwt =
      $grpc.ClientMethod<$44.SignJwtRequest, $44.SignJwtResponse>(
          '/google.iam.credentials.v1.IAMCredentials/SignJwt',
          ($44.SignJwtRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $44.SignJwtResponse.fromBuffer(value));

  IAMCredentialsClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$44.GenerateAccessTokenResponse> generateAccessToken(
      $44.GenerateAccessTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateAccessToken, request, options: options);
  }

  $grpc.ResponseFuture<$44.GenerateIdTokenResponse> generateIdToken(
      $44.GenerateIdTokenRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateIdToken, request, options: options);
  }

  $grpc.ResponseFuture<$44.SignBlobResponse> signBlob(
      $44.SignBlobRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signBlob, request, options: options);
  }

  $grpc.ResponseFuture<$44.SignJwtResponse> signJwt($44.SignJwtRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signJwt, request, options: options);
  }
}

@$pb.GrpcServiceName('google.iam.credentials.v1.IAMCredentials')
abstract class IAMCredentialsServiceBase extends $grpc.Service {
  $core.String get $name => 'google.iam.credentials.v1.IAMCredentials';

  IAMCredentialsServiceBase() {
    $addMethod($grpc.ServiceMethod<$44.GenerateAccessTokenRequest,
            $44.GenerateAccessTokenResponse>(
        'GenerateAccessToken',
        generateAccessToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.GenerateAccessTokenRequest.fromBuffer(value),
        ($44.GenerateAccessTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.GenerateIdTokenRequest,
            $44.GenerateIdTokenResponse>(
        'GenerateIdToken',
        generateIdToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $44.GenerateIdTokenRequest.fromBuffer(value),
        ($44.GenerateIdTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.SignBlobRequest, $44.SignBlobResponse>(
        'SignBlob',
        signBlob_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $44.SignBlobRequest.fromBuffer(value),
        ($44.SignBlobResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$44.SignJwtRequest, $44.SignJwtResponse>(
        'SignJwt',
        signJwt_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $44.SignJwtRequest.fromBuffer(value),
        ($44.SignJwtResponse value) => value.writeToBuffer()));
  }

  $async.Future<$44.GenerateAccessTokenResponse> generateAccessToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.GenerateAccessTokenRequest> request) async {
    return generateAccessToken(call, await request);
  }

  $async.Future<$44.GenerateIdTokenResponse> generateIdToken_Pre(
      $grpc.ServiceCall call,
      $async.Future<$44.GenerateIdTokenRequest> request) async {
    return generateIdToken(call, await request);
  }

  $async.Future<$44.SignBlobResponse> signBlob_Pre($grpc.ServiceCall call,
      $async.Future<$44.SignBlobRequest> request) async {
    return signBlob(call, await request);
  }

  $async.Future<$44.SignJwtResponse> signJwt_Pre(
      $grpc.ServiceCall call, $async.Future<$44.SignJwtRequest> request) async {
    return signJwt(call, await request);
  }

  $async.Future<$44.GenerateAccessTokenResponse> generateAccessToken(
      $grpc.ServiceCall call, $44.GenerateAccessTokenRequest request);
  $async.Future<$44.GenerateIdTokenResponse> generateIdToken(
      $grpc.ServiceCall call, $44.GenerateIdTokenRequest request);
  $async.Future<$44.SignBlobResponse> signBlob(
      $grpc.ServiceCall call, $44.SignBlobRequest request);
  $async.Future<$44.SignJwtResponse> signJwt(
      $grpc.ServiceCall call, $44.SignJwtRequest request);
}
