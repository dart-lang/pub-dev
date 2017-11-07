///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_metrics_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'logging_metrics.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'logging_metrics.pbjson.dart';

export 'logging_metrics.pb.dart';

abstract class MetricsServiceV2ServiceBase extends GeneratedService {
  Future<ListLogMetricsResponse> listLogMetrics(ServerContext ctx, ListLogMetricsRequest request);
  Future<LogMetric> getLogMetric(ServerContext ctx, GetLogMetricRequest request);
  Future<LogMetric> createLogMetric(ServerContext ctx, CreateLogMetricRequest request);
  Future<LogMetric> updateLogMetric(ServerContext ctx, UpdateLogMetricRequest request);
  Future<google$protobuf.Empty> deleteLogMetric(ServerContext ctx, DeleteLogMetricRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListLogMetrics': return new ListLogMetricsRequest();
      case 'GetLogMetric': return new GetLogMetricRequest();
      case 'CreateLogMetric': return new CreateLogMetricRequest();
      case 'UpdateLogMetric': return new UpdateLogMetricRequest();
      case 'DeleteLogMetric': return new DeleteLogMetricRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListLogMetrics': return this.listLogMetrics(ctx, request);
      case 'GetLogMetric': return this.getLogMetric(ctx, request);
      case 'CreateLogMetric': return this.createLogMetric(ctx, request);
      case 'UpdateLogMetric': return this.updateLogMetric(ctx, request);
      case 'DeleteLogMetric': return this.deleteLogMetric(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => MetricsServiceV2$json;
  Map<String, dynamic> get $messageJson => MetricsServiceV2$messageJson;
}

