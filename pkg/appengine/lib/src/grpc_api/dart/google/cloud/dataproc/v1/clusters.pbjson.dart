///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_clusters_pbjson;

import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../protobuf/timestamp.pbjson.dart' as google$protobuf;
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../protobuf/field_mask.pbjson.dart' as google$protobuf;

const Cluster$json = const {
  '1': 'Cluster',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'config', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.ClusterConfig'},
    const {'1': 'status', '3': 4, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.ClusterStatus'},
    const {'1': 'status_history', '3': 7, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.ClusterStatus'},
    const {'1': 'cluster_uuid', '3': 6, '4': 1, '5': 9},
  ],
};

const ClusterConfig$json = const {
  '1': 'ClusterConfig',
  '2': const [
    const {'1': 'config_bucket', '3': 1, '4': 1, '5': 9},
    const {'1': 'gce_cluster_config', '3': 8, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.GceClusterConfig'},
    const {'1': 'master_config', '3': 9, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.InstanceGroupConfig'},
    const {'1': 'worker_config', '3': 10, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.InstanceGroupConfig'},
    const {'1': 'secondary_worker_config', '3': 12, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.InstanceGroupConfig'},
    const {'1': 'software_config', '3': 13, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.SoftwareConfig'},
    const {'1': 'initialization_actions', '3': 11, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.NodeInitializationAction'},
  ],
};

const GceClusterConfig$json = const {
  '1': 'GceClusterConfig',
  '2': const [
    const {'1': 'zone_uri', '3': 1, '4': 1, '5': 9},
    const {'1': 'network_uri', '3': 2, '4': 1, '5': 9},
    const {'1': 'subnetwork_uri', '3': 6, '4': 1, '5': 9},
    const {'1': 'internal_ip_only', '3': 7, '4': 1, '5': 8},
    const {'1': 'service_account_scopes', '3': 3, '4': 3, '5': 9},
    const {'1': 'tags', '3': 4, '4': 3, '5': 9},
    const {'1': 'metadata', '3': 5, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.GceClusterConfig.MetadataEntry'},
  ],
  '3': const [GceClusterConfig_MetadataEntry$json],
};

const GceClusterConfig_MetadataEntry$json = const {
  '1': 'MetadataEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const InstanceGroupConfig$json = const {
  '1': 'InstanceGroupConfig',
  '2': const [
    const {'1': 'num_instances', '3': 1, '4': 1, '5': 5},
    const {'1': 'instance_names', '3': 2, '4': 3, '5': 9},
    const {'1': 'image_uri', '3': 3, '4': 1, '5': 9},
    const {'1': 'machine_type_uri', '3': 4, '4': 1, '5': 9},
    const {'1': 'disk_config', '3': 5, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.DiskConfig'},
    const {'1': 'is_preemptible', '3': 6, '4': 1, '5': 8},
    const {'1': 'managed_group_config', '3': 7, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.ManagedGroupConfig'},
  ],
};

const ManagedGroupConfig$json = const {
  '1': 'ManagedGroupConfig',
  '2': const [
    const {'1': 'instance_template_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'instance_group_manager_name', '3': 2, '4': 1, '5': 9},
  ],
};

const DiskConfig$json = const {
  '1': 'DiskConfig',
  '2': const [
    const {'1': 'boot_disk_size_gb', '3': 1, '4': 1, '5': 5},
    const {'1': 'num_local_ssds', '3': 2, '4': 1, '5': 5},
  ],
};

const NodeInitializationAction$json = const {
  '1': 'NodeInitializationAction',
  '2': const [
    const {'1': 'executable_file', '3': 1, '4': 1, '5': 9},
    const {'1': 'execution_timeout', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
  ],
};

const ClusterStatus$json = const {
  '1': 'ClusterStatus',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.dataproc.v1.ClusterStatus.State'},
    const {'1': 'detail', '3': 2, '4': 1, '5': 9},
    const {'1': 'state_start_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '4': const [ClusterStatus_State$json],
};

const ClusterStatus_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'CREATING', '2': 1},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'ERROR', '2': 3},
    const {'1': 'DELETING', '2': 4},
    const {'1': 'UPDATING', '2': 5},
  ],
};

const SoftwareConfig$json = const {
  '1': 'SoftwareConfig',
  '2': const [
    const {'1': 'image_version', '3': 1, '4': 1, '5': 9},
    const {'1': 'properties', '3': 2, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.SoftwareConfig.PropertiesEntry'},
  ],
  '3': const [SoftwareConfig_PropertiesEntry$json],
};

const SoftwareConfig_PropertiesEntry$json = const {
  '1': 'PropertiesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const CreateClusterRequest$json = const {
  '1': 'CreateClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'cluster', '3': 2, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.Cluster'},
  ],
};

const UpdateClusterRequest$json = const {
  '1': 'UpdateClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 5, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.Cluster'},
    const {'1': 'update_mask', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask'},
  ],
};

const DeleteClusterRequest$json = const {
  '1': 'DeleteClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 2, '4': 1, '5': 9},
  ],
};

const GetClusterRequest$json = const {
  '1': 'GetClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 2, '4': 1, '5': 9},
  ],
};

const ListClustersRequest$json = const {
  '1': 'ListClustersRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 4, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 2, '4': 1, '5': 5},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListClustersResponse$json = const {
  '1': 'ListClustersResponse',
  '2': const [
    const {'1': 'clusters', '3': 1, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.Cluster'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const DiagnoseClusterRequest$json = const {
  '1': 'DiagnoseClusterRequest',
  '2': const [
    const {'1': 'project_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'region', '3': 3, '4': 1, '5': 9},
    const {'1': 'cluster_name', '3': 2, '4': 1, '5': 9},
  ],
};

const DiagnoseClusterResults$json = const {
  '1': 'DiagnoseClusterResults',
  '2': const [
    const {'1': 'output_uri', '3': 1, '4': 1, '5': 9},
  ],
};

const ClusterController$json = const {
  '1': 'ClusterController',
  '2': const [
    const {'1': 'CreateCluster', '2': '.google.cloud.dataproc.v1.CreateClusterRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'UpdateCluster', '2': '.google.cloud.dataproc.v1.UpdateClusterRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteCluster', '2': '.google.cloud.dataproc.v1.DeleteClusterRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetCluster', '2': '.google.cloud.dataproc.v1.GetClusterRequest', '3': '.google.cloud.dataproc.v1.Cluster', '4': const {}},
    const {'1': 'ListClusters', '2': '.google.cloud.dataproc.v1.ListClustersRequest', '3': '.google.cloud.dataproc.v1.ListClustersResponse', '4': const {}},
    const {'1': 'DiagnoseCluster', '2': '.google.cloud.dataproc.v1.DiagnoseClusterRequest', '3': '.google.longrunning.Operation', '4': const {}},
  ],
};

const ClusterController$messageJson = const {
  '.google.cloud.dataproc.v1.CreateClusterRequest': CreateClusterRequest$json,
  '.google.cloud.dataproc.v1.Cluster': Cluster$json,
  '.google.cloud.dataproc.v1.ClusterConfig': ClusterConfig$json,
  '.google.cloud.dataproc.v1.GceClusterConfig': GceClusterConfig$json,
  '.google.cloud.dataproc.v1.GceClusterConfig.MetadataEntry': GceClusterConfig_MetadataEntry$json,
  '.google.cloud.dataproc.v1.InstanceGroupConfig': InstanceGroupConfig$json,
  '.google.cloud.dataproc.v1.DiskConfig': DiskConfig$json,
  '.google.cloud.dataproc.v1.ManagedGroupConfig': ManagedGroupConfig$json,
  '.google.cloud.dataproc.v1.NodeInitializationAction': NodeInitializationAction$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.cloud.dataproc.v1.SoftwareConfig': SoftwareConfig$json,
  '.google.cloud.dataproc.v1.SoftwareConfig.PropertiesEntry': SoftwareConfig_PropertiesEntry$json,
  '.google.cloud.dataproc.v1.ClusterStatus': ClusterStatus$json,
  '.google.protobuf.Timestamp': google$protobuf.Timestamp$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.cloud.dataproc.v1.UpdateClusterRequest': UpdateClusterRequest$json,
  '.google.protobuf.FieldMask': google$protobuf.FieldMask$json,
  '.google.cloud.dataproc.v1.DeleteClusterRequest': DeleteClusterRequest$json,
  '.google.cloud.dataproc.v1.GetClusterRequest': GetClusterRequest$json,
  '.google.cloud.dataproc.v1.ListClustersRequest': ListClustersRequest$json,
  '.google.cloud.dataproc.v1.ListClustersResponse': ListClustersResponse$json,
  '.google.cloud.dataproc.v1.DiagnoseClusterRequest': DiagnoseClusterRequest$json,
};

