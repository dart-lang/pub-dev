//
//  Generated code. Do not modify.
//  source: google/api/serviceusage/v1beta1/serviceusage.proto
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
import 'resources.pb.dart' as $40;
import 'serviceusage.pb.dart' as $39;

export 'serviceusage.pb.dart';

@$pb.GrpcServiceName('google.api.serviceusage.v1beta1.ServiceUsage')
class ServiceUsageClient extends $grpc.Client {
  static final _$enableService =
      $grpc.ClientMethod<$39.EnableServiceRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/EnableService',
          ($39.EnableServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$disableService =
      $grpc.ClientMethod<$39.DisableServiceRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/DisableService',
          ($39.DisableServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$getService =
      $grpc.ClientMethod<$39.GetServiceRequest, $40.Service>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/GetService',
          ($39.GetServiceRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $40.Service.fromBuffer(value));
  static final _$listServices =
      $grpc.ClientMethod<$39.ListServicesRequest, $39.ListServicesResponse>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/ListServices',
          ($39.ListServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $39.ListServicesResponse.fromBuffer(value));
  static final _$batchEnableServices =
      $grpc.ClientMethod<$39.BatchEnableServicesRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/BatchEnableServices',
          ($39.BatchEnableServicesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listConsumerQuotaMetrics = $grpc.ClientMethod<
          $39.ListConsumerQuotaMetricsRequest,
          $39.ListConsumerQuotaMetricsResponse>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/ListConsumerQuotaMetrics',
      ($39.ListConsumerQuotaMetricsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ListConsumerQuotaMetricsResponse.fromBuffer(value));
  static final _$getConsumerQuotaMetric = $grpc.ClientMethod<
          $39.GetConsumerQuotaMetricRequest, $40.ConsumerQuotaMetric>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/GetConsumerQuotaMetric',
      ($39.GetConsumerQuotaMetricRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $40.ConsumerQuotaMetric.fromBuffer(value));
  static final _$getConsumerQuotaLimit = $grpc.ClientMethod<
          $39.GetConsumerQuotaLimitRequest, $40.ConsumerQuotaLimit>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/GetConsumerQuotaLimit',
      ($39.GetConsumerQuotaLimitRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $40.ConsumerQuotaLimit.fromBuffer(value));
  static final _$createAdminOverride =
      $grpc.ClientMethod<$39.CreateAdminOverrideRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/CreateAdminOverride',
          ($39.CreateAdminOverrideRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateAdminOverride =
      $grpc.ClientMethod<$39.UpdateAdminOverrideRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/UpdateAdminOverride',
          ($39.UpdateAdminOverrideRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteAdminOverride =
      $grpc.ClientMethod<$39.DeleteAdminOverrideRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/DeleteAdminOverride',
          ($39.DeleteAdminOverrideRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listAdminOverrides = $grpc.ClientMethod<
          $39.ListAdminOverridesRequest, $39.ListAdminOverridesResponse>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/ListAdminOverrides',
      ($39.ListAdminOverridesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ListAdminOverridesResponse.fromBuffer(value));
  static final _$importAdminOverrides =
      $grpc.ClientMethod<$39.ImportAdminOverridesRequest, $0.Operation>(
          '/google.api.serviceusage.v1beta1.ServiceUsage/ImportAdminOverrides',
          ($39.ImportAdminOverridesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$createConsumerOverride = $grpc.ClientMethod<
          $39.CreateConsumerOverrideRequest, $0.Operation>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/CreateConsumerOverride',
      ($39.CreateConsumerOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$updateConsumerOverride = $grpc.ClientMethod<
          $39.UpdateConsumerOverrideRequest, $0.Operation>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/UpdateConsumerOverride',
      ($39.UpdateConsumerOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$deleteConsumerOverride = $grpc.ClientMethod<
          $39.DeleteConsumerOverrideRequest, $0.Operation>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/DeleteConsumerOverride',
      ($39.DeleteConsumerOverrideRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$listConsumerOverrides = $grpc.ClientMethod<
          $39.ListConsumerOverridesRequest, $39.ListConsumerOverridesResponse>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/ListConsumerOverrides',
      ($39.ListConsumerOverridesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $39.ListConsumerOverridesResponse.fromBuffer(value));
  static final _$importConsumerOverrides = $grpc.ClientMethod<
          $39.ImportConsumerOverridesRequest, $0.Operation>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/ImportConsumerOverrides',
      ($39.ImportConsumerOverridesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));
  static final _$generateServiceIdentity = $grpc.ClientMethod<
          $39.GenerateServiceIdentityRequest, $0.Operation>(
      '/google.api.serviceusage.v1beta1.ServiceUsage/GenerateServiceIdentity',
      ($39.GenerateServiceIdentityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Operation.fromBuffer(value));

  ServiceUsageClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Operation> enableService(
      $39.EnableServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enableService, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> disableService(
      $39.DisableServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disableService, request, options: options);
  }

  $grpc.ResponseFuture<$40.Service> getService($39.GetServiceRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getService, request, options: options);
  }

  $grpc.ResponseFuture<$39.ListServicesResponse> listServices(
      $39.ListServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listServices, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> batchEnableServices(
      $39.BatchEnableServicesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchEnableServices, request, options: options);
  }

  $grpc.ResponseFuture<$39.ListConsumerQuotaMetricsResponse>
      listConsumerQuotaMetrics($39.ListConsumerQuotaMetricsRequest request,
          {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listConsumerQuotaMetrics, request,
        options: options);
  }

  $grpc.ResponseFuture<$40.ConsumerQuotaMetric> getConsumerQuotaMetric(
      $39.GetConsumerQuotaMetricRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConsumerQuotaMetric, request,
        options: options);
  }

  $grpc.ResponseFuture<$40.ConsumerQuotaLimit> getConsumerQuotaLimit(
      $39.GetConsumerQuotaLimitRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConsumerQuotaLimit, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createAdminOverride(
      $39.CreateAdminOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createAdminOverride, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateAdminOverride(
      $39.UpdateAdminOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateAdminOverride, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteAdminOverride(
      $39.DeleteAdminOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAdminOverride, request, options: options);
  }

  $grpc.ResponseFuture<$39.ListAdminOverridesResponse> listAdminOverrides(
      $39.ListAdminOverridesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAdminOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> importAdminOverrides(
      $39.ImportAdminOverridesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$importAdminOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> createConsumerOverride(
      $39.CreateConsumerOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createConsumerOverride, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> updateConsumerOverride(
      $39.UpdateConsumerOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateConsumerOverride, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> deleteConsumerOverride(
      $39.DeleteConsumerOverrideRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteConsumerOverride, request,
        options: options);
  }

  $grpc.ResponseFuture<$39.ListConsumerOverridesResponse> listConsumerOverrides(
      $39.ListConsumerOverridesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listConsumerOverrides, request, options: options);
  }

  $grpc.ResponseFuture<$0.Operation> importConsumerOverrides(
      $39.ImportConsumerOverridesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$importConsumerOverrides, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.Operation> generateServiceIdentity(
      $39.GenerateServiceIdentityRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$generateServiceIdentity, request,
        options: options);
  }
}

@$pb.GrpcServiceName('google.api.serviceusage.v1beta1.ServiceUsage')
abstract class ServiceUsageServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.serviceusage.v1beta1.ServiceUsage';

  ServiceUsageServiceBase() {
    $addMethod($grpc.ServiceMethod<$39.EnableServiceRequest, $0.Operation>(
        'EnableService',
        enableService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.EnableServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.DisableServiceRequest, $0.Operation>(
        'DisableService',
        disableService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.DisableServiceRequest.fromBuffer(value),
        ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetServiceRequest, $40.Service>(
        'GetService',
        getService_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetServiceRequest.fromBuffer(value),
        ($40.Service value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.ListServicesRequest, $39.ListServicesResponse>(
            'ListServices',
            listServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.ListServicesRequest.fromBuffer(value),
            ($39.ListServicesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.BatchEnableServicesRequest, $0.Operation>(
            'BatchEnableServices',
            batchEnableServices_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.BatchEnableServicesRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ListConsumerQuotaMetricsRequest,
            $39.ListConsumerQuotaMetricsResponse>(
        'ListConsumerQuotaMetrics',
        listConsumerQuotaMetrics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ListConsumerQuotaMetricsRequest.fromBuffer(value),
        ($39.ListConsumerQuotaMetricsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetConsumerQuotaMetricRequest,
            $40.ConsumerQuotaMetric>(
        'GetConsumerQuotaMetric',
        getConsumerQuotaMetric_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetConsumerQuotaMetricRequest.fromBuffer(value),
        ($40.ConsumerQuotaMetric value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.GetConsumerQuotaLimitRequest,
            $40.ConsumerQuotaLimit>(
        'GetConsumerQuotaLimit',
        getConsumerQuotaLimit_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.GetConsumerQuotaLimitRequest.fromBuffer(value),
        ($40.ConsumerQuotaLimit value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.CreateAdminOverrideRequest, $0.Operation>(
            'CreateAdminOverride',
            createAdminOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.CreateAdminOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.UpdateAdminOverrideRequest, $0.Operation>(
            'UpdateAdminOverride',
            updateAdminOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.UpdateAdminOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.DeleteAdminOverrideRequest, $0.Operation>(
            'DeleteAdminOverride',
            deleteAdminOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.DeleteAdminOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ListAdminOverridesRequest,
            $39.ListAdminOverridesResponse>(
        'ListAdminOverrides',
        listAdminOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ListAdminOverridesRequest.fromBuffer(value),
        ($39.ListAdminOverridesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.ImportAdminOverridesRequest, $0.Operation>(
            'ImportAdminOverrides',
            importAdminOverrides_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.ImportAdminOverridesRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.CreateConsumerOverrideRequest, $0.Operation>(
            'CreateConsumerOverride',
            createConsumerOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.CreateConsumerOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.UpdateConsumerOverrideRequest, $0.Operation>(
            'UpdateConsumerOverride',
            updateConsumerOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.UpdateConsumerOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.DeleteConsumerOverrideRequest, $0.Operation>(
            'DeleteConsumerOverride',
            deleteConsumerOverride_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.DeleteConsumerOverrideRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$39.ListConsumerOverridesRequest,
            $39.ListConsumerOverridesResponse>(
        'ListConsumerOverrides',
        listConsumerOverrides_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $39.ListConsumerOverridesRequest.fromBuffer(value),
        ($39.ListConsumerOverridesResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.ImportConsumerOverridesRequest, $0.Operation>(
            'ImportConsumerOverrides',
            importConsumerOverrides_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.ImportConsumerOverridesRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$39.GenerateServiceIdentityRequest, $0.Operation>(
            'GenerateServiceIdentity',
            generateServiceIdentity_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $39.GenerateServiceIdentityRequest.fromBuffer(value),
            ($0.Operation value) => value.writeToBuffer()));
  }

  $async.Future<$0.Operation> enableService_Pre($grpc.ServiceCall call,
      $async.Future<$39.EnableServiceRequest> request) async {
    return enableService(call, await request);
  }

  $async.Future<$0.Operation> disableService_Pre($grpc.ServiceCall call,
      $async.Future<$39.DisableServiceRequest> request) async {
    return disableService(call, await request);
  }

  $async.Future<$40.Service> getService_Pre($grpc.ServiceCall call,
      $async.Future<$39.GetServiceRequest> request) async {
    return getService(call, await request);
  }

  $async.Future<$39.ListServicesResponse> listServices_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ListServicesRequest> request) async {
    return listServices(call, await request);
  }

  $async.Future<$0.Operation> batchEnableServices_Pre($grpc.ServiceCall call,
      $async.Future<$39.BatchEnableServicesRequest> request) async {
    return batchEnableServices(call, await request);
  }

  $async.Future<$39.ListConsumerQuotaMetricsResponse>
      listConsumerQuotaMetrics_Pre($grpc.ServiceCall call,
          $async.Future<$39.ListConsumerQuotaMetricsRequest> request) async {
    return listConsumerQuotaMetrics(call, await request);
  }

  $async.Future<$40.ConsumerQuotaMetric> getConsumerQuotaMetric_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetConsumerQuotaMetricRequest> request) async {
    return getConsumerQuotaMetric(call, await request);
  }

  $async.Future<$40.ConsumerQuotaLimit> getConsumerQuotaLimit_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GetConsumerQuotaLimitRequest> request) async {
    return getConsumerQuotaLimit(call, await request);
  }

  $async.Future<$0.Operation> createAdminOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.CreateAdminOverrideRequest> request) async {
    return createAdminOverride(call, await request);
  }

  $async.Future<$0.Operation> updateAdminOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.UpdateAdminOverrideRequest> request) async {
    return updateAdminOverride(call, await request);
  }

  $async.Future<$0.Operation> deleteAdminOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.DeleteAdminOverrideRequest> request) async {
    return deleteAdminOverride(call, await request);
  }

  $async.Future<$39.ListAdminOverridesResponse> listAdminOverrides_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ListAdminOverridesRequest> request) async {
    return listAdminOverrides(call, await request);
  }

  $async.Future<$0.Operation> importAdminOverrides_Pre($grpc.ServiceCall call,
      $async.Future<$39.ImportAdminOverridesRequest> request) async {
    return importAdminOverrides(call, await request);
  }

  $async.Future<$0.Operation> createConsumerOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.CreateConsumerOverrideRequest> request) async {
    return createConsumerOverride(call, await request);
  }

  $async.Future<$0.Operation> updateConsumerOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.UpdateConsumerOverrideRequest> request) async {
    return updateConsumerOverride(call, await request);
  }

  $async.Future<$0.Operation> deleteConsumerOverride_Pre($grpc.ServiceCall call,
      $async.Future<$39.DeleteConsumerOverrideRequest> request) async {
    return deleteConsumerOverride(call, await request);
  }

  $async.Future<$39.ListConsumerOverridesResponse> listConsumerOverrides_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ListConsumerOverridesRequest> request) async {
    return listConsumerOverrides(call, await request);
  }

  $async.Future<$0.Operation> importConsumerOverrides_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.ImportConsumerOverridesRequest> request) async {
    return importConsumerOverrides(call, await request);
  }

  $async.Future<$0.Operation> generateServiceIdentity_Pre(
      $grpc.ServiceCall call,
      $async.Future<$39.GenerateServiceIdentityRequest> request) async {
    return generateServiceIdentity(call, await request);
  }

  $async.Future<$0.Operation> enableService(
      $grpc.ServiceCall call, $39.EnableServiceRequest request);
  $async.Future<$0.Operation> disableService(
      $grpc.ServiceCall call, $39.DisableServiceRequest request);
  $async.Future<$40.Service> getService(
      $grpc.ServiceCall call, $39.GetServiceRequest request);
  $async.Future<$39.ListServicesResponse> listServices(
      $grpc.ServiceCall call, $39.ListServicesRequest request);
  $async.Future<$0.Operation> batchEnableServices(
      $grpc.ServiceCall call, $39.BatchEnableServicesRequest request);
  $async.Future<$39.ListConsumerQuotaMetricsResponse> listConsumerQuotaMetrics(
      $grpc.ServiceCall call, $39.ListConsumerQuotaMetricsRequest request);
  $async.Future<$40.ConsumerQuotaMetric> getConsumerQuotaMetric(
      $grpc.ServiceCall call, $39.GetConsumerQuotaMetricRequest request);
  $async.Future<$40.ConsumerQuotaLimit> getConsumerQuotaLimit(
      $grpc.ServiceCall call, $39.GetConsumerQuotaLimitRequest request);
  $async.Future<$0.Operation> createAdminOverride(
      $grpc.ServiceCall call, $39.CreateAdminOverrideRequest request);
  $async.Future<$0.Operation> updateAdminOverride(
      $grpc.ServiceCall call, $39.UpdateAdminOverrideRequest request);
  $async.Future<$0.Operation> deleteAdminOverride(
      $grpc.ServiceCall call, $39.DeleteAdminOverrideRequest request);
  $async.Future<$39.ListAdminOverridesResponse> listAdminOverrides(
      $grpc.ServiceCall call, $39.ListAdminOverridesRequest request);
  $async.Future<$0.Operation> importAdminOverrides(
      $grpc.ServiceCall call, $39.ImportAdminOverridesRequest request);
  $async.Future<$0.Operation> createConsumerOverride(
      $grpc.ServiceCall call, $39.CreateConsumerOverrideRequest request);
  $async.Future<$0.Operation> updateConsumerOverride(
      $grpc.ServiceCall call, $39.UpdateConsumerOverrideRequest request);
  $async.Future<$0.Operation> deleteConsumerOverride(
      $grpc.ServiceCall call, $39.DeleteConsumerOverrideRequest request);
  $async.Future<$39.ListConsumerOverridesResponse> listConsumerOverrides(
      $grpc.ServiceCall call, $39.ListConsumerOverridesRequest request);
  $async.Future<$0.Operation> importConsumerOverrides(
      $grpc.ServiceCall call, $39.ImportConsumerOverridesRequest request);
  $async.Future<$0.Operation> generateServiceIdentity(
      $grpc.ServiceCall call, $39.GenerateServiceIdentityRequest request);
}
