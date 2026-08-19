//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1/serviceusage.proto
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
import 'resources.pb.dart' as $38;
import 'serviceusage.pb.dart' as $37;

export 'serviceusage.pb.dart';

@$pb.GrpcServiceName('google.api.serviceusage.v1.ServiceUsage')
class ServiceUsageClient extends $grpc.Client {
  static final _$enableService =
      $grpc.ClientMethod<$37.EnableServiceRequest, $0.Operation>(
          '/google.api.serviceusage.v1.ServiceUsage/EnableService',
          ($37.EnableServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$disableService =
      $grpc.ClientMethod<$37.DisableServiceRequest, $0.Operation>(
          '/google.api.serviceusage.v1.ServiceUsage/DisableService',
          ($37.DisableServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$getService =
      $grpc.ClientMethod<$37.GetServiceRequest, $38.Service>(
          '/google.api.serviceusage.v1.ServiceUsage/GetService',
          ($37.GetServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $38.Service.fromBuffer(value));
  static final _$listServices =
      $grpc.ClientMethod<$37.ListServicesRequest, $37.ListServicesResponse>(
          '/google.api.serviceusage.v1.ServiceUsage/ListServices',
          ($37.ListServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $37.ListServicesResponse.fromBuffer(value));
  static final _$batchEnableServices =
      $grpc.ClientMethod<$37.BatchEnableServicesRequest, $0.Operation>(
          '/google.api.serviceusage.v1.ServiceUsage/BatchEnableServices',
          ($37.BatchEnableServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$batchGetServices = $grpc.ClientMethod<
          $37.BatchGetServicesRequest, $37.BatchGetServicesResponse>(
      '/google.api.serviceusage.v1.ServiceUsage/BatchGetServices',
      ($37.BatchGetServicesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $37.BatchGetServicesResponse.fromBuffer(value));

  ServiceUsageClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Operation> enableService(
      $37.EnableServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> disableService(
      $37.DisableServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableService, request, options: options);
  }

  $grpc.ResponseFuture<$38.Service> getService($37.GetServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getService, request, options: options);
  }

  $grpc.ResponseFuture<$37.ListServicesResponse> listServices(
      $37.ListServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServices, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> batchEnableServices(
      $37.BatchEnableServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchEnableServices, request, options: options);
  }

  $grpc.ResponseFuture<$37.BatchGetServicesResponse> batchGetServices(
      $37.BatchGetServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchGetServices, request, options: options);
  }
}

@$pb.GrpcServiceName('google.api.serviceusage.v1.ServiceUsage')
abstract class ServiceUsageServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.serviceusage.v1.ServiceUsage';

  ServiceUsageServiceBase() {
    $addMethod($grpc.ServiceMethod<$37.EnableServiceRequest, $0.Operation>(
        'EnableService',
        enableService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.EnableServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.DisableServiceRequest, $0.Operation>(
        'DisableService',
        disableService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.DisableServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.GetServiceRequest, $38.Service>(
        'GetService',
        getService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.GetServiceRequest.fromBuffer(value),
        ($38.Service value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$37.ListServicesRequest, $37.ListServicesResponse>(
            'ListServices',
            listServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $37.ListServicesRequest.fromBuffer(value),
            ($37.ListServicesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$37.BatchEnableServicesRequest, $0.Operation>(
            'BatchEnableServices',
            batchEnableServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $37.BatchEnableServicesRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$37.BatchGetServicesRequest,
            $37.BatchGetServicesResponse>(
        'BatchGetServices',
        batchGetServices_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $37.BatchGetServicesRequest.fromBuffer(value),
        ($37.BatchGetServicesResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Operation> enableService_Pre($grpc.ServiceCall call,
      $async.Future<$37.EnableServiceRequest> request) async {
    return enableService(call, await request);
  }

  $async.Future<$0.Operation> disableService_Pre($grpc.ServiceCall call,
      $async.Future<$37.DisableServiceRequest> request) async {
    return disableService(call, await request);
  }

  $async.Future<$38.Service> getService_Pre($grpc.ServiceCall call,
      $async.Future<$37.GetServiceRequest> request) async {
    return getService(call, await request);
  }

  $async.Future<$37.ListServicesResponse> listServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.ListServicesRequest> request) async {
    return listServices(call, await request);
  }

  $async.Future<$0.Operation> batchEnableServices_Pre($grpc.ServiceCall call,
      $async.Future<$37.BatchEnableServicesRequest> request) async {
    return batchEnableServices(call, await request);
  }

  $async.Future<$37.BatchGetServicesResponse> batchGetServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$37.BatchGetServicesRequest> request) async {
    return batchGetServices(call, await request);
  }

  $async.Future<$0.Operation> enableService(
      $grpc.ServiceCall call, $37.EnableServiceRequest request);
  $async.Future<$0.Operation> disableService(
      $grpc.ServiceCall call, $37.DisableServiceRequest request);
  $async.Future<$38.Service> getService(
      $grpc.ServiceCall call, $37.GetServiceRequest request);
  $async.Future<$37.ListServicesResponse> listServices(
      $grpc.ServiceCall call, $37.ListServicesRequest request);
  $async.Future<$0.Operation> batchEnableServices(
      $grpc.ServiceCall call, $37.BatchEnableServicesRequest request);
  $async.Future<$37.BatchGetServicesResponse> batchGetServices(
      $grpc.ServiceCall call, $37.BatchGetServicesRequest request);
}
