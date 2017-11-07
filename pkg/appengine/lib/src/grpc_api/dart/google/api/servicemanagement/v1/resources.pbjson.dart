///
//  Generated code. Do not modify.
///
library google.api.servicemanagement.v1_resources_pbjson;

const ManagedService$json = const {
  '1': 'ManagedService',
  '2': const [
    const {'1': 'service_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'producer_project_id', '3': 3, '4': 1, '5': 9},
  ],
};

const OperationMetadata$json = const {
  '1': 'OperationMetadata',
  '2': const [
    const {'1': 'resource_names', '3': 1, '4': 3, '5': 9},
    const {'1': 'steps', '3': 2, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.OperationMetadata.Step'},
    const {'1': 'progress_percentage', '3': 3, '4': 1, '5': 5},
    const {'1': 'start_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
  '3': const [OperationMetadata_Step$json],
  '4': const [OperationMetadata_Status$json],
};

const OperationMetadata_Step$json = const {
  '1': 'Step',
  '2': const [
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.google.api.servicemanagement.v1.OperationMetadata.Status'},
  ],
};

const OperationMetadata_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'DONE', '2': 1},
    const {'1': 'NOT_STARTED', '2': 2},
    const {'1': 'IN_PROGRESS', '2': 3},
    const {'1': 'FAILED', '2': 4},
    const {'1': 'CANCELLED', '2': 5},
  ],
};

const Diagnostic$json = const {
  '1': 'Diagnostic',
  '2': const [
    const {'1': 'location', '3': 1, '4': 1, '5': 9},
    const {'1': 'kind', '3': 2, '4': 1, '5': 14, '6': '.google.api.servicemanagement.v1.Diagnostic.Kind'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9},
  ],
  '4': const [Diagnostic_Kind$json],
};

const Diagnostic_Kind$json = const {
  '1': 'Kind',
  '2': const [
    const {'1': 'WARNING', '2': 0},
    const {'1': 'ERROR', '2': 1},
  ],
};

const ConfigSource$json = const {
  '1': 'ConfigSource',
  '2': const [
    const {'1': 'id', '3': 5, '4': 1, '5': 9},
    const {'1': 'files', '3': 2, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.ConfigFile'},
  ],
};

const ConfigFile$json = const {
  '1': 'ConfigFile',
  '2': const [
    const {'1': 'file_path', '3': 1, '4': 1, '5': 9},
    const {'1': 'file_contents', '3': 3, '4': 1, '5': 12},
    const {'1': 'file_type', '3': 4, '4': 1, '5': 14, '6': '.google.api.servicemanagement.v1.ConfigFile.FileType'},
  ],
  '4': const [ConfigFile_FileType$json],
};

const ConfigFile_FileType$json = const {
  '1': 'FileType',
  '2': const [
    const {'1': 'FILE_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'SERVICE_CONFIG_YAML', '2': 1},
    const {'1': 'OPEN_API_JSON', '2': 2},
    const {'1': 'OPEN_API_YAML', '2': 3},
    const {'1': 'FILE_DESCRIPTOR_SET_PROTO', '2': 4},
  ],
};

const ConfigRef$json = const {
  '1': 'ConfigRef',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ChangeReport$json = const {
  '1': 'ChangeReport',
  '2': const [
    const {'1': 'config_changes', '3': 1, '4': 3, '5': 11, '6': '.google.api.ConfigChange'},
  ],
};

const Rollout$json = const {
  '1': 'Rollout',
  '2': const [
    const {'1': 'rollout_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'create_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'created_by', '3': 3, '4': 1, '5': 9},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.google.api.servicemanagement.v1.Rollout.RolloutStatus'},
    const {'1': 'traffic_percent_strategy', '3': 5, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.Rollout.TrafficPercentStrategy'},
    const {'1': 'delete_service_strategy', '3': 200, '4': 1, '5': 11, '6': '.google.api.servicemanagement.v1.Rollout.DeleteServiceStrategy'},
    const {'1': 'service_name', '3': 8, '4': 1, '5': 9},
  ],
  '3': const [Rollout_TrafficPercentStrategy$json, Rollout_DeleteServiceStrategy$json],
  '4': const [Rollout_RolloutStatus$json],
};

const Rollout_TrafficPercentStrategy$json = const {
  '1': 'TrafficPercentStrategy',
  '2': const [
    const {'1': 'percentages', '3': 1, '4': 3, '5': 11, '6': '.google.api.servicemanagement.v1.Rollout.TrafficPercentStrategy.PercentagesEntry'},
  ],
  '3': const [Rollout_TrafficPercentStrategy_PercentagesEntry$json],
};

const Rollout_TrafficPercentStrategy_PercentagesEntry$json = const {
  '1': 'PercentagesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 1},
  ],
  '7': const {},
};

const Rollout_DeleteServiceStrategy$json = const {
  '1': 'DeleteServiceStrategy',
};

const Rollout_RolloutStatus$json = const {
  '1': 'RolloutStatus',
  '2': const [
    const {'1': 'ROLLOUT_STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'IN_PROGRESS', '2': 1},
    const {'1': 'SUCCESS', '2': 2},
    const {'1': 'CANCELLED', '2': 3},
    const {'1': 'FAILED', '2': 4},
    const {'1': 'PENDING', '2': 5},
  ],
};

