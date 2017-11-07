///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_servicemanager_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'servicemanager.pb.dart';
import 'resources.pb.dart';
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import '../../service.pb.dart' as google$api;
import 'servicemanager.pbjson.dart';

export 'servicemanager.pb.dart';

abstract class ServiceManagerServiceBase extends GeneratedService {
  Future<ListServicesResponse> listServices(ServerContext ctx, ListServicesRequest request);
  Future<ManagedService> getService(ServerContext ctx, GetServiceRequest request);
  Future<google$longrunning.Operation> createService(ServerContext ctx, CreateServiceRequest request);
  Future<google$longrunning.Operation> deleteService(ServerContext ctx, DeleteServiceRequest request);
  Future<google$longrunning.Operation> undeleteService(ServerContext ctx, UndeleteServiceRequest request);
  Future<ListServiceConfigsResponse> listServiceConfigs(ServerContext ctx, ListServiceConfigsRequest request);
  Future<google$api.Service> getServiceConfig(ServerContext ctx, GetServiceConfigRequest request);
  Future<google$api.Service> createServiceConfig(ServerContext ctx, CreateServiceConfigRequest request);
  Future<google$longrunning.Operation> submitConfigSource(ServerContext ctx, SubmitConfigSourceRequest request);
  Future<ListServiceRolloutsResponse> listServiceRollouts(ServerContext ctx, ListServiceRolloutsRequest request);
  Future<Rollout> getServiceRollout(ServerContext ctx, GetServiceRolloutRequest request);
  Future<google$longrunning.Operation> createServiceRollout(ServerContext ctx, CreateServiceRolloutRequest request);
  Future<GenerateConfigReportResponse> generateConfigReport(ServerContext ctx, GenerateConfigReportRequest request);
  Future<google$longrunning.Operation> enableService(ServerContext ctx, EnableServiceRequest request);
  Future<google$longrunning.Operation> disableService(ServerContext ctx, DisableServiceRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListServices': return new ListServicesRequest();
      case 'GetService': return new GetServiceRequest();
      case 'CreateService': return new CreateServiceRequest();
      case 'DeleteService': return new DeleteServiceRequest();
      case 'UndeleteService': return new UndeleteServiceRequest();
      case 'ListServiceConfigs': return new ListServiceConfigsRequest();
      case 'GetServiceConfig': return new GetServiceConfigRequest();
      case 'CreateServiceConfig': return new CreateServiceConfigRequest();
      case 'SubmitConfigSource': return new SubmitConfigSourceRequest();
      case 'ListServiceRollouts': return new ListServiceRolloutsRequest();
      case 'GetServiceRollout': return new GetServiceRolloutRequest();
      case 'CreateServiceRollout': return new CreateServiceRolloutRequest();
      case 'GenerateConfigReport': return new GenerateConfigReportRequest();
      case 'EnableService': return new EnableServiceRequest();
      case 'DisableService': return new DisableServiceRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListServices': return this.listServices(ctx, request);
      case 'GetService': return this.getService(ctx, request);
      case 'CreateService': return this.createService(ctx, request);
      case 'DeleteService': return this.deleteService(ctx, request);
      case 'UndeleteService': return this.undeleteService(ctx, request);
      case 'ListServiceConfigs': return this.listServiceConfigs(ctx, request);
      case 'GetServiceConfig': return this.getServiceConfig(ctx, request);
      case 'CreateServiceConfig': return this.createServiceConfig(ctx, request);
      case 'SubmitConfigSource': return this.submitConfigSource(ctx, request);
      case 'ListServiceRollouts': return this.listServiceRollouts(ctx, request);
      case 'GetServiceRollout': return this.getServiceRollout(ctx, request);
      case 'CreateServiceRollout': return this.createServiceRollout(ctx, request);
      case 'GenerateConfigReport': return this.generateConfigReport(ctx, request);
      case 'EnableService': return this.enableService(ctx, request);
      case 'DisableService': return this.disableService(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ServiceManager$json;
  Map<String, dynamic> get $messageJson => ServiceManager$messageJson;
}

