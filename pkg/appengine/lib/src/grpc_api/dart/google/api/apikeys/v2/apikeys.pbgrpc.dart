//
//  Generated code. Do not modify.
//  source: google/api/apikeys/v2/apikeys.proto
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

import '../../../longrunning/operations.pb.dart' as $0;
import 'apikeys.pb.dart' as $29;
import 'resources.pb.dart' as $30;

export 'apikeys.pb.dart';

@$pb.GrpcServiceName('google.api.apikeys.v2.ApiKeys')
class ApiKeysClient extends $grpc.Client {
  static final _$createKey =
      $grpc.ClientMethod<$29.CreateKeyRequest, $0.Operation>(
          '/google.api.apikeys.v2.ApiKeys/CreateKey',
          ($29.CreateKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listKeys =
      $grpc.ClientMethod<$29.ListKeysRequest, $29.ListKeysResponse>(
          '/google.api.apikeys.v2.ApiKeys/ListKeys',
          ($29.ListKeysRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.ListKeysResponse.fromBuffer(value));
  static final _$getKey = $grpc.ClientMethod<$29.GetKeyRequest, $30.Key>(
      '/google.api.apikeys.v2.ApiKeys/GetKey',
      ($29.GetKeyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $30.Key.fromBuffer(value));
  static final _$getKeyString =
      $grpc.ClientMethod<$29.GetKeyStringRequest, $29.GetKeyStringResponse>(
          '/google.api.apikeys.v2.ApiKeys/GetKeyString',
          ($29.GetKeyStringRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.GetKeyStringResponse.fromBuffer(value));
  static final _$updateKey =
      $grpc.ClientMethod<$29.UpdateKeyRequest, $0.Operation>(
          '/google.api.apikeys.v2.ApiKeys/UpdateKey',
          ($29.UpdateKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteKey =
      $grpc.ClientMethod<$29.DeleteKeyRequest, $0.Operation>(
          '/google.api.apikeys.v2.ApiKeys/DeleteKey',
          ($29.DeleteKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$undeleteKey =
      $grpc.ClientMethod<$29.UndeleteKeyRequest, $0.Operation>(
          '/google.api.apikeys.v2.ApiKeys/UndeleteKey',
          ($29.UndeleteKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$lookupKey =
      $grpc.ClientMethod<$29.LookupKeyRequest, $29.LookupKeyResponse>(
          '/google.api.apikeys.v2.ApiKeys/LookupKey',
          ($29.LookupKeyRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $29.LookupKeyResponse.fromBuffer(value));

  ApiKeysClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Operation> createKey($29.CreateKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createKey, request, options: options);
  }

  $grpc.ResponseFuture<$29.ListKeysResponse> listKeys(
      $29.ListKeysRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listKeys, request, options: options);
  }

  $grpc.ResponseFuture<$30.Key> getKey($29.GetKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKey, request, options: options);
  }

  $grpc.ResponseFuture<$29.GetKeyStringResponse> getKeyString(
      $29.GetKeyStringRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getKeyString, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateKey($29.UpdateKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateKey, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteKey($29.DeleteKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteKey, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> undeleteKey($29.UndeleteKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteKey, request, options: options);
  }

  $grpc.ResponseFuture<$29.LookupKeyResponse> lookupKey(
      $29.LookupKeyRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupKey, request, options: options);
  }
}

@$pb.GrpcServiceName('google.api.apikeys.v2.ApiKeys')
abstract class ApiKeysServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.apikeys.v2.ApiKeys';

  ApiKeysServiceBase() {
    $addMethod($grpc.ServiceMethod<$29.CreateKeyRequest, $0.Operation>(
        'CreateKey',
        createKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.CreateKeyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.ListKeysRequest, $29.ListKeysResponse>(
        'ListKeys',
        listKeys_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.ListKeysRequest.fromBuffer(value),
        ($29.ListKeysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.GetKeyRequest, $30.Key>(
        'GetKey',
        getKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.GetKeyRequest.fromBuffer(value),
        ($30.Key value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$29.GetKeyStringRequest, $29.GetKeyStringResponse>(
            'GetKeyString',
            getKeyString_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $29.GetKeyStringRequest.fromBuffer(value),
            ($29.GetKeyStringResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.UpdateKeyRequest, $0.Operation>(
        'UpdateKey',
        updateKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.UpdateKeyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.DeleteKeyRequest, $0.Operation>(
        'DeleteKey',
        deleteKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.DeleteKeyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.UndeleteKeyRequest, $0.Operation>(
        'UndeleteKey',
        undeleteKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $29.UndeleteKeyRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$29.LookupKeyRequest, $29.LookupKeyResponse>(
        'LookupKey',
        lookupKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $29.LookupKeyRequest.fromBuffer(value),
        ($29.LookupKeyResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Operation> createKey_Pre($grpc.ServiceCall call,
      $async.Future<$29.CreateKeyRequest> request) async {
    return createKey(call, await request);
  }

  $async.Future<$29.ListKeysResponse> listKeys_Pre($grpc.ServiceCall call,
      $async.Future<$29.ListKeysRequest> request) async {
    return listKeys(call, await request);
  }

  $async.Future<$30.Key> getKey_Pre(
      $grpc.ServiceCall call, $async.Future<$29.GetKeyRequest> request) async {
    return getKey(call, await request);
  }

  $async.Future<$29.GetKeyStringResponse> getKeyString_Pre(
      $grpc.ServiceCall call,
      $async.Future<$29.GetKeyStringRequest> request) async {
    return getKeyString(call, await request);
  }

  $async.Future<$0.Operation> updateKey_Pre($grpc.ServiceCall call,
      $async.Future<$29.UpdateKeyRequest> request) async {
    return updateKey(call, await request);
  }

  $async.Future<$0.Operation> deleteKey_Pre($grpc.ServiceCall call,
      $async.Future<$29.DeleteKeyRequest> request) async {
    return deleteKey(call, await request);
  }

  $async.Future<$0.Operation> undeleteKey_Pre($grpc.ServiceCall call,
      $async.Future<$29.UndeleteKeyRequest> request) async {
    return undeleteKey(call, await request);
  }

  $async.Future<$29.LookupKeyResponse> lookupKey_Pre($grpc.ServiceCall call,
      $async.Future<$29.LookupKeyRequest> request) async {
    return lookupKey(call, await request);
  }

  $async.Future<$0.Operation> createKey(
      $grpc.ServiceCall call, $29.CreateKeyRequest request);
  $async.Future<$29.ListKeysResponse> listKeys(
      $grpc.ServiceCall call, $29.ListKeysRequest request);
  $async.Future<$30.Key> getKey(
      $grpc.ServiceCall call, $29.GetKeyRequest request);
  $async.Future<$29.GetKeyStringResponse> getKeyString(
      $grpc.ServiceCall call, $29.GetKeyStringRequest request);
  $async.Future<$0.Operation> updateKey(
      $grpc.ServiceCall call, $29.UpdateKeyRequest request);
  $async.Future<$0.Operation> deleteKey(
      $grpc.ServiceCall call, $29.DeleteKeyRequest request);
  $async.Future<$0.Operation> undeleteKey(
      $grpc.ServiceCall call, $29.UndeleteKeyRequest request);
  $async.Future<$29.LookupKeyResponse> lookupKey(
      $grpc.ServiceCall call, $29.LookupKeyRequest request);
}
