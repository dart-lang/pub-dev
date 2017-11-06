///
//  Generated code. Do not modify.
///
library google.genomics.v1alpha2_pipelines_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'pipelines.pb.dart';
import '../../longrunning/operations.pb.dart' as google$longrunning;
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'pipelines.pbjson.dart';

export 'pipelines.pb.dart';

abstract class PipelinesV1Alpha2ServiceBase extends GeneratedService {
  Future<Pipeline> createPipeline(ServerContext ctx, CreatePipelineRequest request);
  Future<google$longrunning.Operation> runPipeline(ServerContext ctx, RunPipelineRequest request);
  Future<Pipeline> getPipeline(ServerContext ctx, GetPipelineRequest request);
  Future<ListPipelinesResponse> listPipelines(ServerContext ctx, ListPipelinesRequest request);
  Future<google$protobuf.Empty> deletePipeline(ServerContext ctx, DeletePipelineRequest request);
  Future<ControllerConfig> getControllerConfig(ServerContext ctx, GetControllerConfigRequest request);
  Future<google$protobuf.Empty> setOperationStatus(ServerContext ctx, SetOperationStatusRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreatePipeline': return new CreatePipelineRequest();
      case 'RunPipeline': return new RunPipelineRequest();
      case 'GetPipeline': return new GetPipelineRequest();
      case 'ListPipelines': return new ListPipelinesRequest();
      case 'DeletePipeline': return new DeletePipelineRequest();
      case 'GetControllerConfig': return new GetControllerConfigRequest();
      case 'SetOperationStatus': return new SetOperationStatusRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreatePipeline': return this.createPipeline(ctx, request);
      case 'RunPipeline': return this.runPipeline(ctx, request);
      case 'GetPipeline': return this.getPipeline(ctx, request);
      case 'ListPipelines': return this.listPipelines(ctx, request);
      case 'DeletePipeline': return this.deletePipeline(ctx, request);
      case 'GetControllerConfig': return this.getControllerConfig(ctx, request);
      case 'SetOperationStatus': return this.setOperationStatus(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => PipelinesV1Alpha2$json;
  Map<String, dynamic> get $messageJson => PipelinesV1Alpha2$messageJson;
}

