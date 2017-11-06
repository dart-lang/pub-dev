///
//  Generated code. Do not modify.
///
library google.container.v1_cluster_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'cluster_service.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'cluster_service.pbjson.dart';

export 'cluster_service.pb.dart';

abstract class ClusterManagerServiceBase extends GeneratedService {
  Future<ListClustersResponse> listClusters(ServerContext ctx, ListClustersRequest request);
  Future<Cluster> getCluster(ServerContext ctx, GetClusterRequest request);
  Future<Operation> createCluster(ServerContext ctx, CreateClusterRequest request);
  Future<Operation> updateCluster(ServerContext ctx, UpdateClusterRequest request);
  Future<Operation> deleteCluster(ServerContext ctx, DeleteClusterRequest request);
  Future<ListOperationsResponse> listOperations(ServerContext ctx, ListOperationsRequest request);
  Future<Operation> getOperation(ServerContext ctx, GetOperationRequest request);
  Future<google$protobuf.Empty> cancelOperation(ServerContext ctx, CancelOperationRequest request);
  Future<ServerConfig> getServerConfig(ServerContext ctx, GetServerConfigRequest request);
  Future<ListNodePoolsResponse> listNodePools(ServerContext ctx, ListNodePoolsRequest request);
  Future<NodePool> getNodePool(ServerContext ctx, GetNodePoolRequest request);
  Future<Operation> createNodePool(ServerContext ctx, CreateNodePoolRequest request);
  Future<Operation> deleteNodePool(ServerContext ctx, DeleteNodePoolRequest request);
  Future<Operation> rollbackNodePoolUpgrade(ServerContext ctx, RollbackNodePoolUpgradeRequest request);
  Future<Operation> setNodePoolManagement(ServerContext ctx, SetNodePoolManagementRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListClusters': return new ListClustersRequest();
      case 'GetCluster': return new GetClusterRequest();
      case 'CreateCluster': return new CreateClusterRequest();
      case 'UpdateCluster': return new UpdateClusterRequest();
      case 'DeleteCluster': return new DeleteClusterRequest();
      case 'ListOperations': return new ListOperationsRequest();
      case 'GetOperation': return new GetOperationRequest();
      case 'CancelOperation': return new CancelOperationRequest();
      case 'GetServerConfig': return new GetServerConfigRequest();
      case 'ListNodePools': return new ListNodePoolsRequest();
      case 'GetNodePool': return new GetNodePoolRequest();
      case 'CreateNodePool': return new CreateNodePoolRequest();
      case 'DeleteNodePool': return new DeleteNodePoolRequest();
      case 'RollbackNodePoolUpgrade': return new RollbackNodePoolUpgradeRequest();
      case 'SetNodePoolManagement': return new SetNodePoolManagementRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListClusters': return this.listClusters(ctx, request);
      case 'GetCluster': return this.getCluster(ctx, request);
      case 'CreateCluster': return this.createCluster(ctx, request);
      case 'UpdateCluster': return this.updateCluster(ctx, request);
      case 'DeleteCluster': return this.deleteCluster(ctx, request);
      case 'ListOperations': return this.listOperations(ctx, request);
      case 'GetOperation': return this.getOperation(ctx, request);
      case 'CancelOperation': return this.cancelOperation(ctx, request);
      case 'GetServerConfig': return this.getServerConfig(ctx, request);
      case 'ListNodePools': return this.listNodePools(ctx, request);
      case 'GetNodePool': return this.getNodePool(ctx, request);
      case 'CreateNodePool': return this.createNodePool(ctx, request);
      case 'DeleteNodePool': return this.deleteNodePool(ctx, request);
      case 'RollbackNodePoolUpgrade': return this.rollbackNodePoolUpgrade(ctx, request);
      case 'SetNodePoolManagement': return this.setNodePoolManagement(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ClusterManager$json;
  Map<String, dynamic> get $messageJson => ClusterManager$messageJson;
}

