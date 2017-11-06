///
//  Generated code. Do not modify.
///
library google.cloud.dataproc.v1_operations_pbjson;

const ClusterOperationStatus$json = const {
  '1': 'ClusterOperationStatus',
  '2': const [
    const {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.google.cloud.dataproc.v1.ClusterOperationStatus.State'},
    const {'1': 'inner_state', '3': 2, '4': 1, '5': 9},
    const {'1': 'details', '3': 3, '4': 1, '5': 9},
    const {'1': 'state_start_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '4': const [ClusterOperationStatus_State$json],
};

const ClusterOperationStatus_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'PENDING', '2': 1},
    const {'1': 'RUNNING', '2': 2},
    const {'1': 'DONE', '2': 3},
  ],
};

const ClusterOperationMetadata$json = const {
  '1': 'ClusterOperationMetadata',
  '2': const [
    const {'1': 'cluster_name', '3': 7, '4': 1, '5': 9},
    const {'1': 'cluster_uuid', '3': 8, '4': 1, '5': 9},
    const {'1': 'status', '3': 9, '4': 1, '5': 11, '6': '.google.cloud.dataproc.v1.ClusterOperationStatus'},
    const {'1': 'status_history', '3': 10, '4': 3, '5': 11, '6': '.google.cloud.dataproc.v1.ClusterOperationStatus'},
    const {'1': 'operation_type', '3': 11, '4': 1, '5': 9},
    const {'1': 'description', '3': 12, '4': 1, '5': 9},
  ],
};

