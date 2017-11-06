///
//  Generated code. Do not modify.
///
library google.api_metric_pbjson;

const MetricDescriptor$json = const {
  '1': 'MetricDescriptor',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'type', '3': 8, '4': 1, '5': 9},
    const {'1': 'labels', '3': 2, '4': 3, '5': 11, '6': '.google.api.LabelDescriptor'},
    const {'1': 'metric_kind', '3': 3, '4': 1, '5': 14, '6': '.google.api.MetricDescriptor.MetricKind'},
    const {'1': 'value_type', '3': 4, '4': 1, '5': 14, '6': '.google.api.MetricDescriptor.ValueType'},
    const {'1': 'unit', '3': 5, '4': 1, '5': 9},
    const {'1': 'description', '3': 6, '4': 1, '5': 9},
    const {'1': 'display_name', '3': 7, '4': 1, '5': 9},
  ],
  '4': const [MetricDescriptor_MetricKind$json, MetricDescriptor_ValueType$json],
};

const MetricDescriptor_MetricKind$json = const {
  '1': 'MetricKind',
  '2': const [
    const {'1': 'METRIC_KIND_UNSPECIFIED', '2': 0},
    const {'1': 'GAUGE', '2': 1},
    const {'1': 'DELTA', '2': 2},
    const {'1': 'CUMULATIVE', '2': 3},
  ],
};

const MetricDescriptor_ValueType$json = const {
  '1': 'ValueType',
  '2': const [
    const {'1': 'VALUE_TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'BOOL', '2': 1},
    const {'1': 'INT64', '2': 2},
    const {'1': 'DOUBLE', '2': 3},
    const {'1': 'STRING', '2': 4},
    const {'1': 'DISTRIBUTION', '2': 5},
    const {'1': 'MONEY', '2': 6},
  ],
};

const Metric$json = const {
  '1': 'Metric',
  '2': const [
    const {'1': 'type', '3': 3, '4': 1, '5': 9},
    const {'1': 'labels', '3': 2, '4': 3, '5': 11, '6': '.google.api.Metric.LabelsEntry'},
  ],
  '3': const [Metric_LabelsEntry$json],
};

const Metric_LabelsEntry$json = const {
  '1': 'LabelsEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 9},
  ],
  '7': const {},
};

