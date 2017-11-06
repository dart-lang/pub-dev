///
//  Generated code. Do not modify.
///
library google.cloud.runtimeconfig.v1beta1_resources_pbjson;

const VariableState$json = const {
  '1': 'VariableState',
  '2': const [
    const {'1': 'VARIABLE_STATE_UNSPECIFIED', '2': 0},
    const {'1': 'UPDATED', '2': 1},
    const {'1': 'DELETED', '2': 2},
  ],
};

const RuntimeConfig$json = const {
  '1': 'RuntimeConfig',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
  ],
};

const Variable$json = const {
  '1': 'Variable',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 12},
    const {'1': 'text', '3': 5, '4': 1, '5': 9},
    const {'1': 'update_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'state', '3': 4, '4': 1, '5': 14, '6': '.google.cloud.runtimeconfig.v1beta1.VariableState'},
  ],
};

const EndCondition$json = const {
  '1': 'EndCondition',
  '2': const [
    const {'1': 'cardinality', '3': 1, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.EndCondition.Cardinality'},
  ],
  '3': const [EndCondition_Cardinality$json],
};

const EndCondition_Cardinality$json = const {
  '1': 'Cardinality',
  '2': const [
    const {'1': 'path', '3': 1, '4': 1, '5': 9},
    const {'1': 'number', '3': 2, '4': 1, '5': 5},
  ],
};

const Waiter$json = const {
  '1': 'Waiter',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'timeout', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'failure', '3': 3, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.EndCondition'},
    const {'1': 'success', '3': 4, '4': 1, '5': 11, '6': '.google.cloud.runtimeconfig.v1beta1.EndCondition'},
    const {'1': 'create_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'done', '3': 6, '4': 1, '5': 8},
    const {'1': 'error', '3': 7, '4': 1, '5': 11, '6': '.google.rpc.Status'},
  ],
};

