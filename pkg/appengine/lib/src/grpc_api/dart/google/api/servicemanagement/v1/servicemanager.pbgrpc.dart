//
//  Generated code. Do not modify.
//  source: google/api/servicemanagement/v1/servicemanager.proto
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
import '../../service.pb.dart' as $28;
import 'resources.pb.dart' as $27;
import 'servicemanager.pb.dart' as $26;

export 'servicemanager.pb.dart';

@$pb.GrpcServiceName('google.api.servicemanagement.v1.ServiceManager')
class ServiceManagerClient extends $grpc.Client {
  static final _$listServices =
      $grpc.ClientMethod<$26.ListServicesRequest, $26.ListServicesResponse>(
          '/google.api.servicemanagement.v1.ServiceManager/ListServices',
          ($26.ListServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $26.ListServicesResponse.fromBuffer(value));
  static final _$getService =
      $grpc.ClientMethod<$26.GetServiceRequest, $27.ManagedService>(
          '/google.api.servicemanagement.v1.ServiceManager/GetService',
          ($26.GetServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $27.ManagedService.fromBuffer(value));
  static final _$createService =
      $grpc.ClientMethod<$26.CreateServiceRequest, $0.Operation>(
          '/google.api.servicemanagement.v1.ServiceManager/CreateService',
          ($26.CreateServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteService =
      $grpc.ClientMethod<$26.DeleteServiceRequest, $0.Operation>(
          '/google.api.servicemanagement.v1.ServiceManager/DeleteService',
          ($26.DeleteServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$undeleteService =
      $grpc.ClientMethod<$26.UndeleteServiceRequest, $0.Operation>(
          '/google.api.servicemanagement.v1.ServiceManager/UndeleteService',
          ($26.UndeleteServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listServiceConfigs = $grpc.ClientMethod<
          $26.ListServiceConfigsRequest, $26.ListServiceConfigsResponse>(
      '/google.api.servicemanagement.v1.ServiceManager/ListServiceConfigs',
      ($26.ListServiceConfigsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ListServiceConfigsResponse.fromBuffer(value));
  static final _$getServiceConfig =
      $grpc.ClientMethod<$26.GetServiceConfigRequest, $28.Service>(
          '/google.api.servicemanagement.v1.ServiceManager/GetServiceConfig',
          ($26.GetServiceConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $28.Service.fromBuffer(value));
  static final _$createServiceConfig =
      $grpc.ClientMethod<$26.CreateServiceConfigRequest, $28.Service>(
          '/google.api.servicemanagement.v1.ServiceManager/CreateServiceConfig',
          ($26.CreateServiceConfigRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $28.Service.fromBuffer(value));
  static final _$submitConfigSource =
      $grpc.ClientMethod<$26.SubmitConfigSourceRequest, $0.Operation>(
          '/google.api.servicemanagement.v1.ServiceManager/SubmitConfigSource',
          ($26.SubmitConfigSourceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listServiceRollouts = $grpc.ClientMethod<
          $26.ListServiceRolloutsRequest, $26.ListServiceRolloutsResponse>(
      '/google.api.servicemanagement.v1.ServiceManager/ListServiceRollouts',
      ($26.ListServiceRolloutsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.ListServiceRolloutsResponse.fromBuffer(value));
  static final _$getServiceRollout =
      $grpc.ClientMethod<$26.GetServiceRolloutRequest, $27.Rollout>(
          '/google.api.servicemanagement.v1.ServiceManager/GetServiceRollout',
          ($26.GetServiceRolloutRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $27.Rollout.fromBuffer(value));
  static final _$createServiceRollout = $grpc.ClientMethod<
          $26.CreateServiceRolloutRequest, $0.Operation>(
      '/google.api.servicemanagement.v1.ServiceManager/CreateServiceRollout',
      ($26.CreateServiceRolloutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$generateConfigReport = $grpc.ClientMethod<
          $26.GenerateConfigReportRequest, $26.GenerateConfigReportResponse>(
      '/google.api.servicemanagement.v1.ServiceManager/GenerateConfigReport',
      ($26.GenerateConfigReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $26.GenerateConfigReportResponse.fromBuffer(value));

  ServiceManagerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$26.ListServicesResponse> listServices(
      $26.ListServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServices, request, options: options);
  }

  $grpc.ResponseFuture<$27.ManagedService> getService(
      $26.GetServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createService(
      $26.CreateServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteService(
      $26.DeleteServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> undeleteService(
      $26.UndeleteServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$undeleteService, request, options: options);
  }

  $grpc.ResponseFuture<$26.ListServiceConfigsResponse> listServiceConfigs(
      $26.ListServiceConfigsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServiceConfigs, request, options: options);
  }

  $grpc.ResponseFuture<$28.Service> getServiceConfig(
      $26.GetServiceConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceConfig, request, options: options);
  }

  $grpc.ResponseFuture<$28.Service> createServiceConfig(
      $26.CreateServiceConfigRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createServiceConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> submitConfigSource(
      $26.SubmitConfigSourceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$submitConfigSource, request, options: options);
  }

  $grpc.ResponseFuture<$26.ListServiceRolloutsResponse> listServiceRollouts(
      $26.ListServiceRolloutsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServiceRollouts, request, options: options);
  }

  $grpc.ResponseFuture<$27.Rollout> getServiceRollout(
      $26.GetServiceRolloutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getServiceRollout, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createServiceRollout(
      $26.CreateServiceRolloutRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createServiceRollout, request, options: options);
  }

  $grpc.ResponseFuture<$26.GenerateConfigReportResponse> generateConfigReport(
      $26.GenerateConfigReportRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateConfigReport, request, options: options);
  }
}

@$pb.GrpcServiceName('google.api.servicemanagement.v1.ServiceManager')
abstract class ServiceManagerServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.servicemanagement.v1.ServiceManager';

  ServiceManagerServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$26.ListServicesRequest, $26.ListServicesResponse>(
            'ListServices',
            listServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.ListServicesRequest.fromBuffer(value),
            ($26.ListServicesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetServiceRequest, $27.ManagedService>(
        'GetService',
        getService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetServiceRequest.fromBuffer(value),
        ($27.ManagedService value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CreateServiceRequest, $0.Operation>(
        'CreateService',
        createService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.CreateServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.DeleteServiceRequest, $0.Operation>(
        'DeleteService',
        deleteService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.DeleteServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.UndeleteServiceRequest, $0.Operation>(
        'UndeleteService',
        undeleteService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.UndeleteServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ListServiceConfigsRequest,
            $26.ListServiceConfigsResponse>(
        'ListServiceConfigs',
        listServiceConfigs_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ListServiceConfigsRequest.fromBuffer(value),
        ($26.ListServiceConfigsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetServiceConfigRequest, $28.Service>(
        'GetServiceConfig',
        getServiceConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetServiceConfigRequest.fromBuffer(value),
        ($28.Service value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.CreateServiceConfigRequest, $28.Service>(
        'CreateServiceConfig',
        createServiceConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.CreateServiceConfigRequest.fromBuffer(value),
        ($28.Service value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.SubmitConfigSourceRequest, $0.Operation>(
        'SubmitConfigSource',
        submitConfigSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.SubmitConfigSourceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.ListServiceRolloutsRequest,
            $26.ListServiceRolloutsResponse>(
        'ListServiceRollouts',
        listServiceRollouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.ListServiceRolloutsRequest.fromBuffer(value),
        ($26.ListServiceRolloutsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GetServiceRolloutRequest, $27.Rollout>(
        'GetServiceRollout',
        getServiceRollout_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GetServiceRolloutRequest.fromBuffer(value),
        ($27.Rollout value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$26.CreateServiceRolloutRequest, $0.Operation>(
            'CreateServiceRollout',
            createServiceRollout_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $26.CreateServiceRolloutRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$26.GenerateConfigReportRequest,
            $26.GenerateConfigReportResponse>(
        'GenerateConfigReport',
        generateConfigReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $26.GenerateConfigReportRequest.fromBuffer(value),
        ($26.GenerateConfigReportResponse value) => value.writeToBuffer()));
  }

  $async.Future<$26.ListServicesResponse> listServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ListServicesRequest> request) async {
    return listServices(call, await request);
  }

  $async.Future<$27.ManagedService> getService_Pre($grpc.ServiceCall call,
      $async.Future<$26.GetServiceRequest> request) async {
    return getService(call, await request);
  }

  $async.Future<$0.Operation> createService_Pre($grpc.ServiceCall call,
      $async.Future<$26.CreateServiceRequest> request) async {
    return createService(call, await request);
  }

  $async.Future<$0.Operation> deleteService_Pre($grpc.ServiceCall call,
      $async.Future<$26.DeleteServiceRequest> request) async {
    return deleteService(call, await request);
  }

  $async.Future<$0.Operation> undeleteService_Pre($grpc.ServiceCall call,
      $async.Future<$26.UndeleteServiceRequest> request) async {
    return undeleteService(call, await request);
  }

  $async.Future<$26.ListServiceConfigsResponse> listServiceConfigs_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ListServiceConfigsRequest> request) async {
    return listServiceConfigs(call, await request);
  }

  $async.Future<$28.Service> getServiceConfig_Pre($grpc.ServiceCall call,
      $async.Future<$26.GetServiceConfigRequest> request) async {
    return getServiceConfig(call, await request);
  }

  $async.Future<$28.Service> createServiceConfig_Pre($grpc.ServiceCall call,
      $async.Future<$26.CreateServiceConfigRequest> request) async {
    return createServiceConfig(call, await request);
  }

  $async.Future<$0.Operation> submitConfigSource_Pre($grpc.ServiceCall call,
      $async.Future<$26.SubmitConfigSourceRequest> request) async {
    return submitConfigSource(call, await request);
  }

  $async.Future<$26.ListServiceRolloutsResponse> listServiceRollouts_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.ListServiceRolloutsRequest> request) async {
    return listServiceRollouts(call, await request);
  }

  $async.Future<$27.Rollout> getServiceRollout_Pre($grpc.ServiceCall call,
      $async.Future<$26.GetServiceRolloutRequest> request) async {
    return getServiceRollout(call, await request);
  }

  $async.Future<$0.Operation> createServiceRollout_Pre($grpc.ServiceCall call,
      $async.Future<$26.CreateServiceRolloutRequest> request) async {
    return createServiceRollout(call, await request);
  }

  $async.Future<$26.GenerateConfigReportResponse> generateConfigReport_Pre(
      $grpc.ServiceCall call,
      $async.Future<$26.GenerateConfigReportRequest> request) async {
    return generateConfigReport(call, await request);
  }

  $async.Future<$26.ListServicesResponse> listServices(
      $grpc.ServiceCall call, $26.ListServicesRequest request);
  $async.Future<$27.ManagedService> getService(
      $grpc.ServiceCall call, $26.GetServiceRequest request);
  $async.Future<$0.Operation> createService(
      $grpc.ServiceCall call, $26.CreateServiceRequest request);
  $async.Future<$0.Operation> deleteService(
      $grpc.ServiceCall call, $26.DeleteServiceRequest request);
  $async.Future<$0.Operation> undeleteService(
      $grpc.ServiceCall call, $26.UndeleteServiceRequest request);
  $async.Future<$26.ListServiceConfigsResponse> listServiceConfigs(
      $grpc.ServiceCall call, $26.ListServiceConfigsRequest request);
  $async.Future<$28.Service> getServiceConfig(
      $grpc.ServiceCall call, $26.GetServiceConfigRequest request);
  $async.Future<$28.Service> createServiceConfig(
      $grpc.ServiceCall call, $26.CreateServiceConfigRequest request);
  $async.Future<$0.Operation> submitConfigSource(
      $grpc.ServiceCall call, $26.SubmitConfigSourceRequest request);
  $async.Future<$26.ListServiceRolloutsResponse> listServiceRollouts(
      $grpc.ServiceCall call, $26.ListServiceRolloutsRequest request);
  $async.Future<$27.Rollout> getServiceRollout(
      $grpc.ServiceCall call, $26.GetServiceRolloutRequest request);
  $async.Future<$0.Operation> createServiceRollout(
      $grpc.ServiceCall call, $26.CreateServiceRolloutRequest request);
  $async.Future<$26.GenerateConfigReportResponse> generateConfigReport(
      $grpc.ServiceCall call, $26.GenerateConfigReportRequest request);
}
