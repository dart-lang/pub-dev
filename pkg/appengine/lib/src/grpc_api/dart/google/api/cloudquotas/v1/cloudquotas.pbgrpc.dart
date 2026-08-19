//
//  Generated code. Do not modify.
//  source: google/api/cloudquotas/v1/cloudquotas.proto
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

import 'cloudquotas.pb.dart' as $31;
import 'resources.pb.dart' as $32;

export 'cloudquotas.pb.dart';

@$pb.GrpcServiceName('google.api.cloudquotas.v1.CloudQuotas')
class CloudQuotasClient extends $grpc.Client {
  static final _$listQuotaInfos =
      $grpc.ClientMethod<$31.ListQuotaInfosRequest, $31.ListQuotaInfosResponse>(
          '/google.api.cloudquotas.v1.CloudQuotas/ListQuotaInfos',
          ($31.ListQuotaInfosRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $31.ListQuotaInfosResponse.fromBuffer(value));
  static final _$getQuotaInfo =
      $grpc.ClientMethod<$31.GetQuotaInfoRequest, $32.QuotaInfo>(
          '/google.api.cloudquotas.v1.CloudQuotas/GetQuotaInfo',
          ($31.GetQuotaInfoRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $32.QuotaInfo.fromBuffer(value));
  static final _$listQuotaPreferences = $grpc.ClientMethod<
          $31.ListQuotaPreferencesRequest, $31.ListQuotaPreferencesResponse>(
      '/google.api.cloudquotas.v1.CloudQuotas/ListQuotaPreferences',
      ($31.ListQuotaPreferencesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $31.ListQuotaPreferencesResponse.fromBuffer(value));
  static final _$getQuotaPreference =
      $grpc.ClientMethod<$31.GetQuotaPreferenceRequest, $32.QuotaPreference>(
          '/google.api.cloudquotas.v1.CloudQuotas/GetQuotaPreference',
          ($31.GetQuotaPreferenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.QuotaPreference.fromBuffer(value));
  static final _$createQuotaPreference =
      $grpc.ClientMethod<$31.CreateQuotaPreferenceRequest, $32.QuotaPreference>(
          '/google.api.cloudquotas.v1.CloudQuotas/CreateQuotaPreference',
          ($31.CreateQuotaPreferenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.QuotaPreference.fromBuffer(value));
  static final _$updateQuotaPreference =
      $grpc.ClientMethod<$31.UpdateQuotaPreferenceRequest, $32.QuotaPreference>(
          '/google.api.cloudquotas.v1.CloudQuotas/UpdateQuotaPreference',
          ($31.UpdateQuotaPreferenceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $32.QuotaPreference.fromBuffer(value));

  CloudQuotasClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$31.ListQuotaInfosResponse> listQuotaInfos(
      $31.ListQuotaInfosRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listQuotaInfos, request, options: options);
  }

  $grpc.ResponseFuture<$32.QuotaInfo> getQuotaInfo(
      $31.GetQuotaInfoRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQuotaInfo, request, options: options);
  }

  $grpc.ResponseFuture<$31.ListQuotaPreferencesResponse> listQuotaPreferences(
      $31.ListQuotaPreferencesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listQuotaPreferences, request, options: options);
  }

  $grpc.ResponseFuture<$32.QuotaPreference> getQuotaPreference(
      $31.GetQuotaPreferenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getQuotaPreference, request, options: options);
  }

  $grpc.ResponseFuture<$32.QuotaPreference> createQuotaPreference(
      $31.CreateQuotaPreferenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createQuotaPreference, request, options: options);
  }

  $grpc.ResponseFuture<$32.QuotaPreference> updateQuotaPreference(
      $31.UpdateQuotaPreferenceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateQuotaPreference, request, options: options);
  }
}

@$pb.GrpcServiceName('google.api.cloudquotas.v1.CloudQuotas')
abstract class CloudQuotasServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.cloudquotas.v1.CloudQuotas';

  CloudQuotasServiceBase() {
    $addMethod($grpc.ServiceMethod<$31.ListQuotaInfosRequest,
            $31.ListQuotaInfosResponse>(
        'ListQuotaInfos',
        listQuotaInfos_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.ListQuotaInfosRequest.fromBuffer(value),
        ($31.ListQuotaInfosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.GetQuotaInfoRequest, $32.QuotaInfo>(
        'GetQuotaInfo',
        getQuotaInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.GetQuotaInfoRequest.fromBuffer(value),
        ($32.QuotaInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.ListQuotaPreferencesRequest,
            $31.ListQuotaPreferencesResponse>(
        'ListQuotaPreferences',
        listQuotaPreferences_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.ListQuotaPreferencesRequest.fromBuffer(value),
        ($31.ListQuotaPreferencesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$31.GetQuotaPreferenceRequest, $32.QuotaPreference>(
            'GetQuotaPreference',
            getQuotaPreference_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $31.GetQuotaPreferenceRequest.fromBuffer(value),
            ($32.QuotaPreference value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.CreateQuotaPreferenceRequest,
            $32.QuotaPreference>(
        'CreateQuotaPreference',
        createQuotaPreference_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.CreateQuotaPreferenceRequest.fromBuffer(value),
        ($32.QuotaPreference value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$31.UpdateQuotaPreferenceRequest,
            $32.QuotaPreference>(
        'UpdateQuotaPreference',
        updateQuotaPreference_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $31.UpdateQuotaPreferenceRequest.fromBuffer(value),
        ($32.QuotaPreference value) => value.writeToBuffer()));
  }

  $async.Future<$31.ListQuotaInfosResponse> listQuotaInfos_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.ListQuotaInfosRequest> request) async {
    return listQuotaInfos(call, await request);
  }

  $async.Future<$32.QuotaInfo> getQuotaInfo_Pre($grpc.ServiceCall call,
      $async.Future<$31.GetQuotaInfoRequest> request) async {
    return getQuotaInfo(call, await request);
  }

  $async.Future<$31.ListQuotaPreferencesResponse> listQuotaPreferences_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.ListQuotaPreferencesRequest> request) async {
    return listQuotaPreferences(call, await request);
  }

  $async.Future<$32.QuotaPreference> getQuotaPreference_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.GetQuotaPreferenceRequest> request) async {
    return getQuotaPreference(call, await request);
  }

  $async.Future<$32.QuotaPreference> createQuotaPreference_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.CreateQuotaPreferenceRequest> request) async {
    return createQuotaPreference(call, await request);
  }

  $async.Future<$32.QuotaPreference> updateQuotaPreference_Pre(
      $grpc.ServiceCall call,
      $async.Future<$31.UpdateQuotaPreferenceRequest> request) async {
    return updateQuotaPreference(call, await request);
  }

  $async.Future<$31.ListQuotaInfosResponse> listQuotaInfos(
      $grpc.ServiceCall call, $31.ListQuotaInfosRequest request);
  $async.Future<$32.QuotaInfo> getQuotaInfo(
      $grpc.ServiceCall call, $31.GetQuotaInfoRequest request);
  $async.Future<$31.ListQuotaPreferencesResponse> listQuotaPreferences(
      $grpc.ServiceCall call, $31.ListQuotaPreferencesRequest request);
  $async.Future<$32.QuotaPreference> getQuotaPreference(
      $grpc.ServiceCall call, $31.GetQuotaPreferenceRequest request);
  $async.Future<$32.QuotaPreference> createQuotaPreference(
      $grpc.ServiceCall call, $31.CreateQuotaPreferenceRequest request);
  $async.Future<$32.QuotaPreference> updateQuotaPreference(
      $grpc.ServiceCall call, $31.UpdateQuotaPreferenceRequest request);
}
