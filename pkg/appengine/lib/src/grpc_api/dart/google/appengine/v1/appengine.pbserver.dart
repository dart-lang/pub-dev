///
//  Generated code. Do not modify.
///
library google.appengine.v1_appengine_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'appengine.pb.dart';
import 'instance.pb.dart';
import '../../longrunning/operations.pb.dart' as google$longrunning;
import 'version.pb.dart';
import 'service.pb.dart';
import 'application.pb.dart';
import 'appengine.pbjson.dart';

export 'appengine.pb.dart';

abstract class InstancesServiceBase extends GeneratedService {
  Future<ListInstancesResponse> listInstances(ServerContext ctx, ListInstancesRequest request);
  Future<Instance> getInstance(ServerContext ctx, GetInstanceRequest request);
  Future<google$longrunning.Operation> deleteInstance(ServerContext ctx, DeleteInstanceRequest request);
  Future<google$longrunning.Operation> debugInstance(ServerContext ctx, DebugInstanceRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListInstances': return new ListInstancesRequest();
      case 'GetInstance': return new GetInstanceRequest();
      case 'DeleteInstance': return new DeleteInstanceRequest();
      case 'DebugInstance': return new DebugInstanceRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListInstances': return this.listInstances(ctx, request);
      case 'GetInstance': return this.getInstance(ctx, request);
      case 'DeleteInstance': return this.deleteInstance(ctx, request);
      case 'DebugInstance': return this.debugInstance(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Instances$json;
  Map<String, dynamic> get $messageJson => Instances$messageJson;
}

abstract class VersionsServiceBase extends GeneratedService {
  Future<ListVersionsResponse> listVersions(ServerContext ctx, ListVersionsRequest request);
  Future<Version> getVersion(ServerContext ctx, GetVersionRequest request);
  Future<google$longrunning.Operation> createVersion(ServerContext ctx, CreateVersionRequest request);
  Future<google$longrunning.Operation> updateVersion(ServerContext ctx, UpdateVersionRequest request);
  Future<google$longrunning.Operation> deleteVersion(ServerContext ctx, DeleteVersionRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListVersions': return new ListVersionsRequest();
      case 'GetVersion': return new GetVersionRequest();
      case 'CreateVersion': return new CreateVersionRequest();
      case 'UpdateVersion': return new UpdateVersionRequest();
      case 'DeleteVersion': return new DeleteVersionRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListVersions': return this.listVersions(ctx, request);
      case 'GetVersion': return this.getVersion(ctx, request);
      case 'CreateVersion': return this.createVersion(ctx, request);
      case 'UpdateVersion': return this.updateVersion(ctx, request);
      case 'DeleteVersion': return this.deleteVersion(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Versions$json;
  Map<String, dynamic> get $messageJson => Versions$messageJson;
}

abstract class ServicesServiceBase extends GeneratedService {
  Future<ListServicesResponse> listServices(ServerContext ctx, ListServicesRequest request);
  Future<Service> getService(ServerContext ctx, GetServiceRequest request);
  Future<google$longrunning.Operation> updateService(ServerContext ctx, UpdateServiceRequest request);
  Future<google$longrunning.Operation> deleteService(ServerContext ctx, DeleteServiceRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListServices': return new ListServicesRequest();
      case 'GetService': return new GetServiceRequest();
      case 'UpdateService': return new UpdateServiceRequest();
      case 'DeleteService': return new DeleteServiceRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListServices': return this.listServices(ctx, request);
      case 'GetService': return this.getService(ctx, request);
      case 'UpdateService': return this.updateService(ctx, request);
      case 'DeleteService': return this.deleteService(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Services$json;
  Map<String, dynamic> get $messageJson => Services$messageJson;
}

abstract class ApplicationsServiceBase extends GeneratedService {
  Future<Application> getApplication(ServerContext ctx, GetApplicationRequest request);
  Future<google$longrunning.Operation> repairApplication(ServerContext ctx, RepairApplicationRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'GetApplication': return new GetApplicationRequest();
      case 'RepairApplication': return new RepairApplicationRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'GetApplication': return this.getApplication(ctx, request);
      case 'RepairApplication': return this.repairApplication(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Applications$json;
  Map<String, dynamic> get $messageJson => Applications$messageJson;
}

