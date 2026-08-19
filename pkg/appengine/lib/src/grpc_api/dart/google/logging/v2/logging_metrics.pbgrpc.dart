//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_metrics.proto
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

import '../../protobuf/empty.pb.dart' as $1;
import 'logging_metrics.pb.dart' as $20;

export 'logging_metrics.pb.dart';

@$pb.GrpcServiceName('google.logging.v2.MetricsServiceV2')
class MetricsServiceV2Client extends $grpc.Client {
  static final _$listLogMetrics =
      $grpc.ClientMethod<$20.ListLogMetricsRequest, $20.ListLogMetricsResponse>(
          '/google.logging.v2.MetricsServiceV2/ListLogMetrics',
          ($20.ListLogMetricsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $20.ListLogMetricsResponse.fromBuffer(value));
  static final _$getLogMetric =
      $grpc.ClientMethod<$20.GetLogMetricRequest, $20.LogMetric>(
          '/google.logging.v2.MetricsServiceV2/GetLogMetric',
          ($20.GetLogMetricRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $20.LogMetric.fromBuffer(value));
  static final _$createLogMetric =
      $grpc.ClientMethod<$20.CreateLogMetricRequest, $20.LogMetric>(
          '/google.logging.v2.MetricsServiceV2/CreateLogMetric',
          ($20.CreateLogMetricRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $20.LogMetric.fromBuffer(value));
  static final _$updateLogMetric =
      $grpc.ClientMethod<$20.UpdateLogMetricRequest, $20.LogMetric>(
          '/google.logging.v2.MetricsServiceV2/UpdateLogMetric',
          ($20.UpdateLogMetricRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $20.LogMetric.fromBuffer(value));
  static final _$deleteLogMetric =
      $grpc.ClientMethod<$20.DeleteLogMetricRequest, $1.Empty>(
          '/google.logging.v2.MetricsServiceV2/DeleteLogMetric',
          ($20.DeleteLogMetricRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  MetricsServiceV2Client($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$20.ListLogMetricsResponse> listLogMetrics(
      $20.ListLogMetricsRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listLogMetrics, request, options: options);
  }

  $grpc.ResponseFuture<$20.LogMetric> getLogMetric(
      $20.GetLogMetricRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getLogMetric, request, options: options);
  }

  $grpc.ResponseFuture<$20.LogMetric> createLogMetric(
      $20.CreateLogMetricRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createLogMetric, request, options: options);
  }

  $grpc.ResponseFuture<$20.LogMetric> updateLogMetric(
      $20.UpdateLogMetricRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateLogMetric, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteLogMetric(
      $20.DeleteLogMetricRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteLogMetric, request, options: options);
  }
}

@$pb.GrpcServiceName('google.logging.v2.MetricsServiceV2')
abstract class MetricsServiceV2ServiceBase extends $grpc.Service {
  $core.String get $name => 'google.logging.v2.MetricsServiceV2';

  MetricsServiceV2ServiceBase() {
    $addMethod($grpc.ServiceMethod<$20.ListLogMetricsRequest,
            $20.ListLogMetricsResponse>(
        'ListLogMetrics',
        listLogMetrics_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.ListLogMetricsRequest.fromBuffer(value),
        ($20.ListLogMetricsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.GetLogMetricRequest, $20.LogMetric>(
        'GetLogMetric',
        getLogMetric_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.GetLogMetricRequest.fromBuffer(value),
        ($20.LogMetric value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.CreateLogMetricRequest, $20.LogMetric>(
        'CreateLogMetric',
        createLogMetric_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.CreateLogMetricRequest.fromBuffer(value),
        ($20.LogMetric value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.UpdateLogMetricRequest, $20.LogMetric>(
        'UpdateLogMetric',
        updateLogMetric_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.UpdateLogMetricRequest.fromBuffer(value),
        ($20.LogMetric value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$20.DeleteLogMetricRequest, $1.Empty>(
        'DeleteLogMetric',
        deleteLogMetric_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $20.DeleteLogMetricRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$20.ListLogMetricsResponse> listLogMetrics_Pre(
      $grpc.ServiceCall call,
      $async.Future<$20.ListLogMetricsRequest> request) async {
    return listLogMetrics(call, await request);
  }

  $async.Future<$20.LogMetric> getLogMetric_Pre($grpc.ServiceCall call,
      $async.Future<$20.GetLogMetricRequest> request) async {
    return getLogMetric(call, await request);
  }

  $async.Future<$20.LogMetric> createLogMetric_Pre($grpc.ServiceCall call,
      $async.Future<$20.CreateLogMetricRequest> request) async {
    return createLogMetric(call, await request);
  }

  $async.Future<$20.LogMetric> updateLogMetric_Pre($grpc.ServiceCall call,
      $async.Future<$20.UpdateLogMetricRequest> request) async {
    return updateLogMetric(call, await request);
  }

  $async.Future<$1.Empty> deleteLogMetric_Pre($grpc.ServiceCall call,
      $async.Future<$20.DeleteLogMetricRequest> request) async {
    return deleteLogMetric(call, await request);
  }

  $async.Future<$20.ListLogMetricsResponse> listLogMetrics(
      $grpc.ServiceCall call, $20.ListLogMetricsRequest request);
  $async.Future<$20.LogMetric> getLogMetric(
      $grpc.ServiceCall call, $20.GetLogMetricRequest request);
  $async.Future<$20.LogMetric> createLogMetric(
      $grpc.ServiceCall call, $20.CreateLogMetricRequest request);
  $async.Future<$20.LogMetric> updateLogMetric(
      $grpc.ServiceCall call, $20.UpdateLogMetricRequest request);
  $async.Future<$1.Empty> deleteLogMetric(
      $grpc.ServiceCall call, $20.DeleteLogMetricRequest request);
}
