///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_operation_pbjson;

const Operation$json = const {
  '1': 'Operation',
  '2': const [
    const {'1': 'operation_id', '3': 1, '4': 1, '5': 9},
    const {'1': 'operation_name', '3': 2, '4': 1, '5': 9},
    const {'1': 'consumer_id', '3': 3, '4': 1, '5': 9},
    const {'1': 'start_time', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'labels', '3': 6, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.Operation.LabelsEntry'},
    const {'1': 'metric_value_sets', '3': 7, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.MetricValueSet'},
    const {'1': 'log_entries', '3': 8, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.LogEntry'},
    const {'1': 'importance', '3': 11, '4': 1, '5': 14, '6': '.google.api.servicecontrol.v1.Operation.Importance'},
  ],
  '3': const [Operation_LabelsEntry$json],
  '4': const [Operation_Importance$json],
};

const Operation_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const Operation_Importance$json = const {
  '1': 'Importance',
  '2': const [
    const {'1': 'LOW', '2': 0},
    const {'1': 'HIGH', '2': 1},
  ],
};

