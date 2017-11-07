///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_metric_value_pbjson;

const MetricValue$json = const {
  '1': 'MetricValue',
  '2': const [
    const {'1': 'labels', '3': 1, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.MetricValue.LabelsEntry'},
    const {'1': 'start_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'end_time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'bool_value', '3': 4, '4': 1, '5': 8},
    const {'1': 'int64_value', '3': 5, '4': 1, '5': 3},
    const {'1': 'double_value', '3': 6, '4': 1, '5': 1},
    const {'1': 'string_value', '3': 7, '4': 1, '5': 9},
    const {'1': 'distribution_value', '3': 8, '4': 1, '5': 11, '6': '.google.api.servicecontrol.v1.Distribution'},
  ],
  '3': const [MetricValue_LabelsEntry$json],
};

const MetricValue_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

const MetricValueSet$json = const {
  '1': 'MetricValueSet',
  '2': const [
    const {'1': 'metric_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'metric_values', '3': 2, '4': 3, '5': 11, '6': '.google.api.servicecontrol.v1.MetricValue'},
  ],
};

