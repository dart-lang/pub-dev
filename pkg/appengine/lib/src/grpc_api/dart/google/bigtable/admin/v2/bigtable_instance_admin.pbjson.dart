///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_instance_admin_pbjson;

import 'instance.pbjson.dart';
import '../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const CreateInstanceRequest$json = const {
  '1': 'CreateInstanceRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'instance_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'instance', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.Instance'},
    const {'1': 'clusters', '3': 4, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.CreateInstanceRequest.ClustersEntry'},
  ],
  '3': const [CreateInstanceRequest_ClustersEntry$json],
};

const CreateInstanceRequest_ClustersEntry$json = const {
  '1': 'ClustersEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.Cluster'},
  ],
  '7': const {},
};

const GetInstanceRequest$json = const {
  '1': 'GetInstanceRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListInstancesRequest$json = const {
  '1': 'ListInstancesRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const ListInstancesResponse$json = const {
  '1': 'ListInstancesResponse',
  '2': const [
    const {'1': 'instances', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.Instance'},
    const {'1': 'failed_locations', '3': 2, '4': 3, '5': 9},
    const {'1': 'next_page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const DeleteInstanceRequest$json = const {
  '1': 'DeleteInstanceRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateClusterRequest$json = const {
  '1': 'CreateClusterRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'cluster_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'cluster', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.Cluster'},
  ],
};

const GetClusterRequest$json = const {
  '1': 'GetClusterRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListClustersRequest$json = const {
  '1': 'ListClustersRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const ListClustersResponse$json = const {
  '1': 'ListClustersResponse',
  '2': const [
    const {'1': 'clusters', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.Cluster'},
    const {'1': 'failed_locations', '3': 2, '4': 3, '5': 9},
    const {'1': 'next_page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const DeleteClusterRequest$json = const {
  '1': 'DeleteClusterRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateInstanceMetadata$json = const {
  '1': 'CreateInstanceMetadata',
  '2': const [
    const {'1': 'original_request', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.CreateInstanceRequest'},
    const {'1': 'request_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'finish_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const UpdateClusterMetadata$json = const {
  '1': 'UpdateClusterMetadata',
  '2': const [
    const {'1': 'original_request', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.Cluster'},
    const {'1': 'request_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'finish_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const BigtableInstanceAdmin$json = const {
  '1': 'BigtableInstanceAdmin',
  '2': const [
    const {'1': 'CreateInstance', '2': '.google.bigtable.admin.v2.CreateInstanceRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetInstance', '2': '.google.bigtable.admin.v2.GetInstanceRequest', '3': '.google.bigtable.admin.v2.Instance', '4': const {}},
    const {'1': 'ListInstances', '2': '.google.bigtable.admin.v2.ListInstancesRequest', '3': '.google.bigtable.admin.v2.ListInstancesResponse', '4': const {}},
    const {'1': 'UpdateInstance', '2': '.google.bigtable.admin.v2.Instance', '3': '.google.bigtable.admin.v2.Instance', '4': const {}},
    const {'1': 'DeleteInstance', '2': '.google.bigtable.admin.v2.DeleteInstanceRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'CreateCluster', '2': '.google.bigtable.admin.v2.CreateClusterRequest', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'GetCluster', '2': '.google.bigtable.admin.v2.GetClusterRequest', '3': '.google.bigtable.admin.v2.Cluster', '4': const {}},
    const {'1': 'ListClusters', '2': '.google.bigtable.admin.v2.ListClustersRequest', '3': '.google.bigtable.admin.v2.ListClustersResponse', '4': const {}},
    const {'1': 'UpdateCluster', '2': '.google.bigtable.admin.v2.Cluster', '3': '.google.longrunning.Operation', '4': const {}},
    const {'1': 'DeleteCluster', '2': '.google.bigtable.admin.v2.DeleteClusterRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const BigtableInstanceAdmin$messageJson = const {
  '.google.bigtable.admin.v2.CreateInstanceRequest': CreateInstanceRequest$json,
  '.google.bigtable.admin.v2.Instance': Instance$json,
  '.google.bigtable.admin.v2.CreateInstanceRequest.ClustersEntry': CreateInstanceRequest_ClustersEntry$json,
  '.google.bigtable.admin.v2.Cluster': Cluster$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.bigtable.admin.v2.GetInstanceRequest': GetInstanceRequest$json,
  '.google.bigtable.admin.v2.ListInstancesRequest': ListInstancesRequest$json,
  '.google.bigtable.admin.v2.ListInstancesResponse': ListInstancesResponse$json,
  '.google.bigtable.admin.v2.DeleteInstanceRequest': DeleteInstanceRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.bigtable.admin.v2.CreateClusterRequest': CreateClusterRequest$json,
  '.google.bigtable.admin.v2.GetClusterRequest': GetClusterRequest$json,
  '.google.bigtable.admin.v2.ListClustersRequest': ListClustersRequest$json,
  '.google.bigtable.admin.v2.ListClustersResponse': ListClustersResponse$json,
  '.google.bigtable.admin.v2.DeleteClusterRequest': DeleteClusterRequest$json,
};

