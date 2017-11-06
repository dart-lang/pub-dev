///
//  Generated code. Do not modify.
///
library google.cloud.functions.v1beta2_operations_pbjson;

const OperationType$json = const {
  '1': 'OperationType',
  '2': const [
    const {'1': 'OPERATION_UNSPECIFIED', '2': 0},
    const {'1': 'CREATE_FUNCTION', '2': 1},
    const {'1': 'UPDATE_FUNCTION', '2': 2},
    const {'1': 'DELETE_FUNCTION', '2': 3},
  ],
};

const OperationMetadataV1Beta2$json = const {
  '1': 'OperationMetadataV1Beta2',
  '2': const [
    const {'1': 'target', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.google.cloud.functions.v1beta2.OperationType'},
    const {'1': 'request', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Any'},
  ],
};

