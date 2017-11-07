///
//  Generated code. Do not modify.
///
library google.monitoring.v3_metric_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'metric_service.pb.dart';
import '../../api/monitored_resource.pb.dart' as google$api;
import '../../api/metric.pb.dart' as google$api;
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'metric_service.pbjson.dart';

export 'metric_service.pb.dart';

abstract class MetricServiceBase extends GeneratedService {
  Future<ListMonitoredResourceDescriptorsResponse> listMonitoredResourceDescriptors(ServerContext ctx, ListMonitoredResourceDescriptorsRequest request);
  Future<google$api.MonitoredResourceDescriptor> getMonitoredResourceDescriptor(ServerContext ctx, GetMonitoredResourceDescriptorRequest request);
  Future<ListMetricDescriptorsResponse> listMetricDescriptors(ServerContext ctx, ListMetricDescriptorsRequest request);
  Future<google$api.MetricDescriptor> getMetricDescriptor(ServerContext ctx, GetMetricDescriptorRequest request);
  Future<google$api.MetricDescriptor> createMetricDescriptor(ServerContext ctx, CreateMetricDescriptorRequest request);
  Future<google$protobuf.Empty> deleteMetricDescriptor(ServerContext ctx, DeleteMetricDescriptorRequest request);
  Future<ListTimeSeriesResponse> listTimeSeries(ServerContext ctx, ListTimeSeriesRequest request);
  Future<google$protobuf.Empty> createTimeSeries(ServerContext ctx, CreateTimeSeriesRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListMonitoredResourceDescriptors': return new ListMonitoredResourceDescriptorsRequest();
      case 'GetMonitoredResourceDescriptor': return new GetMonitoredResourceDescriptorRequest();
      case 'ListMetricDescriptors': return new ListMetricDescriptorsRequest();
      case 'GetMetricDescriptor': return new GetMetricDescriptorRequest();
      case 'CreateMetricDescriptor': return new CreateMetricDescriptorRequest();
      case 'DeleteMetricDescriptor': return new DeleteMetricDescriptorRequest();
      case 'ListTimeSeries': return new ListTimeSeriesRequest();
      case 'CreateTimeSeries': return new CreateTimeSeriesRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListMonitoredResourceDescriptors': return this.listMonitoredResourceDescriptors(ctx, request);
      case 'GetMonitoredResourceDescriptor': return this.getMonitoredResourceDescriptor(ctx, request);
      case 'ListMetricDescriptors': return this.listMetricDescriptors(ctx, request);
      case 'GetMetricDescriptor': return this.getMetricDescriptor(ctx, request);
      case 'CreateMetricDescriptor': return this.createMetricDescriptor(ctx, request);
      case 'DeleteMetricDescriptor': return this.deleteMetricDescriptor(ctx, request);
      case 'ListTimeSeries': return this.listTimeSeries(ctx, request);
      case 'CreateTimeSeries': return this.createTimeSeries(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => MetricService$json;
  Map<String, dynamic> get $messageJson => MetricService$messageJson;
}

