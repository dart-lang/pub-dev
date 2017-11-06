///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_model_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'model_service.pb.dart';
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import 'model_service.pbjson.dart';

export 'model_service.pb.dart';

abstract class ModelServiceBase extends GeneratedService {
  Future<Model> createModel(ServerContext ctx, CreateModelRequest request);
  Future<ListModelsResponse> listModels(ServerContext ctx, ListModelsRequest request);
  Future<Model> getModel(ServerContext ctx, GetModelRequest request);
  Future<google$longrunning.Operation> deleteModel(ServerContext ctx, DeleteModelRequest request);
  Future<google$longrunning.Operation> createVersion(ServerContext ctx, CreateVersionRequest request);
  Future<ListVersionsResponse> listVersions(ServerContext ctx, ListVersionsRequest request);
  Future<Version> getVersion(ServerContext ctx, GetVersionRequest request);
  Future<google$longrunning.Operation> deleteVersion(ServerContext ctx, DeleteVersionRequest request);
  Future<Version> setDefaultVersion(ServerContext ctx, SetDefaultVersionRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateModel': return new CreateModelRequest();
      case 'ListModels': return new ListModelsRequest();
      case 'GetModel': return new GetModelRequest();
      case 'DeleteModel': return new DeleteModelRequest();
      case 'CreateVersion': return new CreateVersionRequest();
      case 'ListVersions': return new ListVersionsRequest();
      case 'GetVersion': return new GetVersionRequest();
      case 'DeleteVersion': return new DeleteVersionRequest();
      case 'SetDefaultVersion': return new SetDefaultVersionRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateModel': return this.createModel(ctx, request);
      case 'ListModels': return this.listModels(ctx, request);
      case 'GetModel': return this.getModel(ctx, request);
      case 'DeleteModel': return this.deleteModel(ctx, request);
      case 'CreateVersion': return this.createVersion(ctx, request);
      case 'ListVersions': return this.listVersions(ctx, request);
      case 'GetVersion': return this.getVersion(ctx, request);
      case 'DeleteVersion': return this.deleteVersion(ctx, request);
      case 'SetDefaultVersion': return this.setDefaultVersion(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ModelService$json;
  Map<String, dynamic> get $messageJson => ModelService$messageJson;
}

