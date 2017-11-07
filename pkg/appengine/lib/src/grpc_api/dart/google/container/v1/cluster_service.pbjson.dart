///
//  Generated code. Do not modify.
///
library google.container.v1_cluster_service_pbjson;

import '../../protobuf/empty.pbjson.dart' as google$protobuf;

const NodeConfig$json = const {
  '1': 'NodeConfig',
  '2': const [
    const {'1': 'machine_type', '3': 1, '4': 1, '5': 9},
    const {'1': 'disk_size_gb', '3': 2, '4': 1, '5': 5},
    const {'1': 'oauth_scopes', '3': 3, '4': 3, '5': 9},
    const {'1': 'service_account', '3': 9, '4': 1, '5': 9},
    const {'1': 'metadata', '3': 4, '4': 3, '5': 11, '6': '.google.container.v1.NodeConfig.MetadataEntry'},
    const {'1': 'image_type', '3': 5, '4': 1, '5': 9},
    const {'1': 'labels', '3': 6, '4': 3, '5': 11, '6': '.google.container.v1.NodeConfig.LabelsEntry'},
    const {'1': 'local_ssd_count', '3': 7, '4': 1, '5': 5},
    const {'1': 'tags', '3': 8, '4': 3, '5': 9},
    const {'1': 'preemptible', '3': 10, '4': 1, '5': 8},
  ],
  '3': const [NodeConfig_MetadataEntry$json, NodeConfig_LabelsEntry$json],
};

const NodeConfig_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const NodeConfig_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const MasterAuth$json = const {
  '1': 'MasterAuth',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9},
    const {'1': 'password', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_ca_certificate', '3': 100, '4': 1, '5': 9},
    const {'1': 'client_certificate', '3': 101, '4': 1, '5': 9},
    const {'1': 'client_key', '3': 102, '4': 1, '5': 9},
  ],
};

const AddonsConfig$json = const {
  '1': 'AddonsConfig',
  '2': const [
    const {'1': 'http_load_balancing', '3': 1, '4': 1, '5': 11, '6': '.google.container.v1.HttpLoadBalancing'},
    const {'1': 'horizontal_pod_autoscaling', '3': 2, '4': 1, '5': 11, '6': '.google.container.v1.HorizontalPodAutoscaling'},
  ],
};

const HttpLoadBalancing$json = const {
  '1': 'HttpLoadBalancing',
  '2': const [
    const {'1': 'disabled', '3': 1, '4': 1, '5': 8},
  ],
};

const HorizontalPodAutoscaling$json = const {
  '1': 'HorizontalPodAutoscaling',
  '2': const [
    const {'1': 'disabled', '3': 1, '4': 1, '5': 8},
  ],
};

const Cluster$json = const {
  '1': 'Cluster',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'initial_node_count', '3': 3, '4': 1, '5': 5},
    const {'1': 'node_config', '3': 4, '4': 1, '5': 11, '6': '.google.container.v1.NodeConfig'},
    const {'1': 'master_auth', '3': 5, '4': 1, '5': 11, '6': '.google.container.v1.MasterAuth'},
    const {'1': 'logging_service', '3': 6, '4': 1, '5': 9},
    const {'1': 'monitoring_service', '3': 7, '4': 1, '5': 9},
    const {'1': 'network', '3': 8, '4': 1, '5': 9},
    const {'1': 'cluster_ipv4_cidr', '3': 9, '4': 1, '5': 9},
    const {'1': 'addons_config', '3': 10, '4': 1, '5': 11, '6': '.google.container.v1.AddonsConfig'},
    const {'1': 'subnetwork', '3': 11, '4': 1, '5': 9},
    const {'1': 'node_pools', '3': 12, '4': 3, '5': 11, '6': '.google.container.v1.NodePool'},
    const {'1': 'locations', '3': 13, '4': 3, '5': 9},
    const {'1': 'enable_kubernetes_alpha', '3': 14, '4': 1, '5': 8},
    const {'1': 'self_link', '3': 100, '4': 1, '5': 9},
    const {'1': 'zone', '3': 101, '4': 1, '5': 9},
    const {'1': 'endpoint', '3': 102, '4': 1, '5': 9},
    const {'1': 'initial_cluster_version', '3': 103, '4': 1, '5': 9},
    const {'1': 'current_master_version', '3': 104, '4': 1, '5': 9},
    const {'1': 'current_node_version', '3': 105, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 106, '4': 1, '5': 9},
    const {'1': 'status', '3': 107, '4': 1, '5': 14, '6': '.google.container.v1.Cluster.Status'},
    const {'1': 'status_message', '3': 108, '4': 1, '5': 9},
    const {'1': 'node_ipv4_cidr_size', '3': 109, '4': 1, '5': 5},
    const {'1': 'services_ipv4_cidr', '3': 110, '4': 1, '5': 9},
    const {'1': 'instance_group_urls', '3': 111, '4': 3, '5': 9},
    const {'1': 'current_node_count', '3': 112, '4': 1, '5': 5},
    const {'1': 'expire_time', '3': 113, '4': 1, '5': 9},
  ],
  '4': const [Cluster_Status$json],
};

const Cluster_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PROVISIONING', '2': 1},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'RECONCILING', '2': 3},
    const {'1': 'STOPPING', '2': 4},
    const {'1': 'ERROR', '2': 5},
  ],
};

const ClusterUpdate$json = const {
  '1': 'ClusterUpdate',
  '2': const [
    const {'1': 'desired_node_version', '3': 4, '4': 1, '5': 9},
    const {'1': 'desired_monitoring_service', '3': 5, '4': 1, '5': 9},
    const {'1': 'desired_addons_config', '3': 6, '4': 1, '5': 11, '6': '.google.container.v1.AddonsConfig'},
    const {'1': 'desired_node_pool_id', '3': 7, '4': 1, '5': 9},
    const {'1': 'desired_image_type', '3': 8, '4': 1, '5': 9},
    const {'1': 'desired_node_pool_autoscaling', '3': 9, '4': 1, '5': 11, '6': '.google.container.v1.NodePoolAutoscaling'},
    const {'1': 'desired_locations', '3': 10, '4': 3, '5': 9},
    const {'1': 'desired_master_version', '3': 100, '4': 1, '5': 9},
  ],
};

const Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'operation_type', '3': 3, '4': 1, '5': 14, '6': '.google.container.v1.Operation.Type'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.google.container.v1.Operation.Status'},
    const {'1': 'detail', '3': 8, '4': 1, '5': 9},
    const {'1': 'status_message', '3': 5, '4': 1, '5': 9},
    const {'1': 'self_link', '3': 6, '4': 1, '5': 9},
    const {'1': 'target_link', '3': 7, '4': 1, '5': 9},
  ],
  '4': const [Operation_Status$json, Operation_Type$json],
};

const Operation_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PENDING', '2': 1},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'DONE', '2': 3},
    const {'1': 'ABORTING', '2': 4},
  ],
};

const Operation_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'CREATE_CLUSTER', '2': 1},
    const {'1': 'DELETE_CLUSTER', '2': 2},
    const {'1': 'UPGRADE_MASTER', '2': 3},
    const {'1': 'UPGRADE_NODES', '2': 4},
    const {'1': 'REPAIR_CLUSTER', '2': 5},
    const {'1': 'UPDATE_CLUSTER', '2': 6},
    const {'1': 'CREATE_NODE_POOL', '2': 7},
    const {'1': 'DELETE_NODE_POOL', '2': 8},
    const {'1': 'SET_NODE_POOL_MANAGEMENT', '2': 9},
  ],
};

const CreateClusterRequest$json = const {
  '1': 'CreateClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster', '3': 3, '4': 1, '5': 11, '6': '.google.container.v1.Cluster'},
  ],
};

const GetClusterRequest$json = const {
  '1': 'GetClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
  ],
};

const UpdateClusterRequest$json = const {
  '1': 'UpdateClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'update', '3': 4, '4': 1, '5': 11, '6': '.google.container.v1.ClusterUpdate'},
  ],
};

const DeleteClusterRequest$json = const {
  '1': 'DeleteClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
  ],
};

const ListClustersRequest$json = const {
  '1': 'ListClustersRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
  ],
};

const ListClustersResponse$json = const {
  '1': 'ListClustersResponse',
  '2': const [
    const {'1': 'clusters', '3': 1, '4': 3, '5': 11, '6': '.google.container.v1.Cluster'},
    const {'1': 'missing_zones', '3': 2, '4': 3, '5': 9},
  ],
};

const GetOperationRequest$json = const {
  '1': 'GetOperationRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'operation_id', '3': 3, '4': 1, '5': 9},
  ],
};

const ListOperationsRequest$json = const {
  '1': 'ListOperationsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
  ],
};

const CancelOperationRequest$json = const {
  '1': 'CancelOperationRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'operation_id', '3': 3, '4': 1, '5': 9},
  ],
};

const ListOperationsResponse$json = const {
  '1': 'ListOperationsResponse',
  '2': const [
    const {'1': 'operations', '3': 1, '4': 3, '5': 11, '6': '.google.container.v1.Operation'},
    const {'1': 'missing_zones', '3': 2, '4': 3, '5': 9},
  ],
};

const GetServerConfigRequest$json = const {
  '1': 'GetServerConfigRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
  ],
};

const ServerConfig$json = const {
  '1': 'ServerConfig',
  '2': const [
    const {'1': 'default_cluster_version', '3': 1, '4': 1, '5': 9},
    const {'1': 'valid_node_versions', '3': 3, '4': 3, '5': 9},
    const {'1': 'default_image_type', '3': 4, '4': 1, '5': 9},
    const {'1': 'valid_image_types', '3': 5, '4': 3, '5': 9},
    const {'1': 'valid_master_versions', '3': 6, '4': 3, '5': 9},
  ],
};

const CreateNodePoolRequest$json = const {
  '1': 'CreateNodePoolRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'node_pool', '3': 4, '4': 1, '5': 11, '6': '.google.container.v1.NodePool'},
  ],
};

const DeleteNodePoolRequest$json = const {
  '1': 'DeleteNodePoolRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'node_pool_id', '3': 4, '4': 1, '5': 9},
  ],
};

const ListNodePoolsRequest$json = const {
  '1': 'ListNodePoolsRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
  ],
};

const GetNodePoolRequest$json = const {
  '1': 'GetNodePoolRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'node_pool_id', '3': 4, '4': 1, '5': 9},
  ],
};

const NodePool$json = const {
  '1': 'NodePool',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'config', '3': 2, '4': 1, '5': 11, '6': '.google.container.v1.NodeConfig'},
    const {'1': 'initial_node_count', '3': 3, '4': 1, '5': 5},
    const {'1': 'self_link', '3': 100, '4': 1, '5': 9},
    const {'1': 'version', '3': 101, '4': 1, '5': 9},
    const {'1': 'instance_group_urls', '3': 102, '4': 3, '5': 9},
    const {'1': 'status', '3': 103, '4': 1, '5': 14, '6': '.google.container.v1.NodePool.Status'},
    const {'1': 'status_message', '3': 104, '4': 1, '5': 9},
    const {'1': 'autoscaling', '3': 4, '4': 1, '5': 11, '6': '.google.container.v1.NodePoolAutoscaling'},
    const {'1': 'management', '3': 5, '4': 1, '5': 11, '6': '.google.container.v1.NodeManagement'},
  ],
  '4': const [NodePool_Status$json],
};

const NodePool_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'PROVISIONING', '2': 1},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'RUNNING_WITH_ERROR', '2': 3},
    const {'1': 'RECONCILING', '2': 4},
    const {'1': 'STOPPING', '2': 5},
    const {'1': 'ERROR', '2': 6},
  ],
};

const NodeManagement$json = const {
  '1': 'NodeManagement',
  '2': const [
    const {'1': 'auto_upgrade', '3': 1, '4': 1, '5': 8},
    const {'1': 'upgrade_options', '3': 10, '4': 1, '5': 11, '6': '.google.container.v1.AutoUpgradeOptions'},
  ],
};

const AutoUpgradeOptions$json = const {
  '1': 'AutoUpgradeOptions',
  '2': const [
    const {'1': 'auto_upgrade_start_time', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
  ],
};

const SetNodePoolManagementRequest$json = const {
  '1': 'SetNodePoolManagementRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'node_pool_id', '3': 4, '4': 1, '5': 9},
    const {'1': 'management', '3': 5, '4': 1, '5': 11, '6': '.google.container.v1.NodeManagement'},
  ],
};

const RollbackNodePoolUpgradeRequest$json = const {
  '1': 'RollbackNodePoolUpgradeRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'zone', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'node_pool_id', '3': 4, '4': 1, '5': 9},
  ],
};

const ListNodePoolsResponse$json = const {
  '1': 'ListNodePoolsResponse',
  '2': const [
    const {'1': 'node_pools', '3': 1, '4': 3, '5': 11, '6': '.google.container.v1.NodePool'},
  ],
};

const NodePoolAutoscaling$json = const {
  '1': 'NodePoolAutoscaling',
  '2': const [
    const {'1': 'enabled', '3': 1, '4': 1, '5': 8},
    const {'1': 'min_node_count', '3': 2, '4': 1, '5': 5},
    const {'1': 'max_node_count', '3': 3, '4': 1, '5': 5},
  ],
};

const ClusterManager$json = const {
  '1': 'ClusterManager',
  '2': const [
    const {'1': 'ListClusters', '2': '.google.container.v1.ListClustersRequest', '3': '.google.container.v1.ListClustersResponse', '4': const {}},
    const {'1': 'GetCluster', '2': '.google.container.v1.GetClusterRequest', '3': '.google.container.v1.Cluster', '4': const {}},
    const {'1': 'CreateCluster', '2': '.google.container.v1.CreateClusterRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'UpdateCluster', '2': '.google.container.v1.UpdateClusterRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'DeleteCluster', '2': '.google.container.v1.DeleteClusterRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'ListOperations', '2': '.google.container.v1.ListOperationsRequest', '3': '.google.container.v1.ListOperationsResponse', '4': const {}},
    const {'1': 'GetOperation', '2': '.google.container.v1.GetOperationRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'CancelOperation', '2': '.google.container.v1.CancelOperationRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'GetServerConfig', '2': '.google.container.v1.GetServerConfigRequest', '3': '.google.container.v1.ServerConfig', '4': const {}},
    const {'1': 'ListNodePools', '2': '.google.container.v1.ListNodePoolsRequest', '3': '.google.container.v1.ListNodePoolsResponse', '4': const {}},
    const {'1': 'GetNodePool', '2': '.google.container.v1.GetNodePoolRequest', '3': '.google.container.v1.NodePool', '4': const {}},
    const {'1': 'CreateNodePool', '2': '.google.container.v1.CreateNodePoolRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'DeleteNodePool', '2': '.google.container.v1.DeleteNodePoolRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'RollbackNodePoolUpgrade', '2': '.google.container.v1.RollbackNodePoolUpgradeRequest', '3': '.google.container.v1.Operation', '4': const {}},
    const {'1': 'SetNodePoolManagement', '2': '.google.container.v1.SetNodePoolManagementRequest', '3': '.google.container.v1.Operation', '4': const {}},
  ],
};

const ClusterManager$messageJson = const {
  '.google.container.v1.ListClustersRequest': ListClustersRequest$json,
  '.google.container.v1.ListClustersResponse': ListClustersResponse$json,
  '.google.container.v1.Cluster': Cluster$json,
  '.google.container.v1.NodeConfig': NodeConfig$json,
  '.google.container.v1.NodeConfig.MetadataEntry': NodeConfig_MetadataEntry$json,
  '.google.container.v1.NodeConfig.LabelsEntry': NodeConfig_LabelsEntry$json,
  '.google.container.v1.MasterAuth': MasterAuth$json,
  '.google.container.v1.AddonsConfig': AddonsConfig$json,
  '.google.container.v1.HttpLoadBalancing': HttpLoadBalancing$json,
  '.google.container.v1.HorizontalPodAutoscaling': HorizontalPodAutoscaling$json,
  '.google.container.v1.NodePool': NodePool$json,
  '.google.container.v1.NodePoolAutoscaling': NodePoolAutoscaling$json,
  '.google.container.v1.NodeManagement': NodeManagement$json,
  '.google.container.v1.AutoUpgradeOptions': AutoUpgradeOptions$json,
  '.google.container.v1.GetClusterRequest': GetClusterRequest$json,
  '.google.container.v1.CreateClusterRequest': CreateClusterRequest$json,
  '.google.container.v1.Operation': Operation$json,
  '.google.container.v1.UpdateClusterRequest': UpdateClusterRequest$json,
  '.google.container.v1.ClusterUpdate': ClusterUpdate$json,
  '.google.container.v1.DeleteClusterRequest': DeleteClusterRequest$json,
  '.google.container.v1.ListOperationsRequest': ListOperationsRequest$json,
  '.google.container.v1.ListOperationsResponse': ListOperationsResponse$json,
  '.google.container.v1.GetOperationRequest': GetOperationRequest$json,
  '.google.container.v1.CancelOperationRequest': CancelOperationRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.container.v1.GetServerConfigRequest': GetServerConfigRequest$json,
  '.google.container.v1.ServerConfig': ServerConfig$json,
  '.google.container.v1.ListNodePoolsRequest': ListNodePoolsRequest$json,
  '.google.container.v1.ListNodePoolsResponse': ListNodePoolsResponse$json,
  '.google.container.v1.GetNodePoolRequest': GetNodePoolRequest$json,
  '.google.container.v1.CreateNodePoolRequest': CreateNodePoolRequest$json,
  '.google.container.v1.DeleteNodePoolRequest': DeleteNodePoolRequest$json,
  '.google.container.v1.RollbackNodePoolUpgradeRequest': RollbackNodePoolUpgradeRequest$json,
  '.google.container.v1.SetNodePoolManagementRequest': SetNodePoolManagementRequest$json,
};

