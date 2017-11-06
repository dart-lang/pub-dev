///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_instance_admin_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bigtable_instance_admin.pb.dart';
import '../../../longrunning/operations.pb.dart' as google$longrunning;
import 'instance.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import 'bigtable_instance_admin.pbjson.dart';

export 'bigtable_instance_admin.pb.dart';

abstract class BigtableInstanceAdminServiceBase extends GeneratedService {
  Future<google$longrunning.Operation> createInstance(ServerContext ctx, CreateInstanceRequest request);
  Future<Instance> getInstance(ServerContext ctx, GetInstanceRequest request);
  Future<ListInstancesResponse> listInstances(ServerContext ctx, ListInstancesRequest request);
  Future<Instance> updateInstance(ServerContext ctx, Instance request);
  Future<google$protobuf.Empty> deleteInstance(ServerContext ctx, DeleteInstanceRequest request);
  Future<google$longrunning.Operation> createCluster(ServerContext ctx, CreateClusterRequest request);
  Future<Cluster> getCluster(ServerContext ctx, GetClusterRequest request);
  Future<ListClustersResponse> listClusters(ServerContext ctx, ListClustersRequest request);
  Future<google$longrunning.Operation> updateCluster(ServerContext ctx, Cluster request);
  Future<google$protobuf.Empty> deleteCluster(ServerContext ctx, DeleteClusterRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateInstance': return new CreateInstanceRequest();
      case 'GetInstance': return new GetInstanceRequest();
      case 'ListInstances': return new ListInstancesRequest();
      case 'UpdateInstance': return new Instance();
      case 'DeleteInstance': return new DeleteInstanceRequest();
      case 'CreateCluster': return new CreateClusterRequest();
      case 'GetCluster': return new GetClusterRequest();
      case 'ListClusters': return new ListClustersRequest();
      case 'UpdateCluster': return new Cluster();
      case 'DeleteCluster': return new DeleteClusterRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateInstance': return this.createInstance(ctx, request);
      case 'GetInstance': return this.getInstance(ctx, request);
      case 'ListInstances': return this.listInstances(ctx, request);
      case 'UpdateInstance': return this.updateInstance(ctx, request);
      case 'DeleteInstance': return this.deleteInstance(ctx, request);
      case 'CreateCluster': return this.createCluster(ctx, request);
      case 'GetCluster': return this.getCluster(ctx, request);
      case 'ListClusters': return this.listClusters(ctx, request);
      case 'UpdateCluster': return this.updateCluster(ctx, request);
      case 'DeleteCluster': return this.deleteCluster(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => BigtableInstanceAdmin$json;
  Map<String, dynamic> get $messageJson => BigtableInstanceAdmin$messageJson;
}

