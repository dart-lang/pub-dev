///
//  Generated code. Do not modify.
///
library google.cloud.ml.v1beta1_operation_metadata_pbjson;

const OperationMetadata$json = const {
  '1': 'OperationMetadata',
  '2': const [
    const {'1': 'create_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'start_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'is_cancellation_requested', '3': 4, '4': 1, '5': 8},
    const {'1': 'operation_type', '3': 5, '4': 1, '5': 14, '6': '.google.cloud.ml.v1beta1.OperationMetadata.OperationType'},
    const {'1': 'model_name', '3': 6, '4': 1, '5': 9},
    const {'1': 'version', '3': 7, '4': 1, '5': 11, '6': '.google.cloud.ml.v1beta1.Version'},
  ],
  '4': const [OperationMetadata_OperationType$json],
};

const OperationMetadata_OperationType$json = const {
  '1': 'OperationType',
  '2': const [
    const {'1': 'OPERATION_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'CREATE_VERSION', '2': 1},
    const {'1': 'DELETE_VERSION', '2': 2},
    const {'1': 'DELETE_MODEL', '2': 3},
  ],
};

