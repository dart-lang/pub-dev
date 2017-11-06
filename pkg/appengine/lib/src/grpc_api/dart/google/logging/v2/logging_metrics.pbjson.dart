///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_metrics_pbjson;

import '../../protobuf/empty.pbjson.dart' as google$protobuf;

const LogMetric$json = const {
  '1': 'LogMetric',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'description', '3': 2, '4': 1, '5': 9},
    const {'1': 'filter', '3': 3, '4': 1, '5': 9},
    const {'1': 'version', '3': 4, '4': 1, '5': 14, '6': '.google.logging.v2.LogMetric.ApiVersion'},
  ],
  '4': const [LogMetric_ApiVersion$json],
};

const LogMetric_ApiVersion$json = const {
  '1': 'ApiVersion',
  '2': const [
    const {'1': 'V2', '2': 0},
    const {'1': 'V1', '2': 1},
  ],
};

const ListLogMetricsRequest$json = const {
  '1': 'ListLogMetricsRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'page_token', '3': 2, '4': 1, '5': 9},
    const {'1': 'page_size', '3': 3, '4': 1, '5': 5},
  ],
};

const ListLogMetricsResponse$json = const {
  '1': 'ListLogMetricsResponse',
  '2': const [
    const {'1': 'metrics', '3': 1, '4': 3, '5': 11, '6': '.google.logging.v2.LogMetric'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetLogMetricRequest$json = const {
  '1': 'GetLogMetricRequest',
  '2': const [
    const {'1': 'metric_name', '3': 1, '4': 1, '5': 9},
  ],
};

const CreateLogMetricRequest$json = const {
  '1': 'CreateLogMetricRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'metric', '3': 2, '4': 1, '5': 11, '6': '.google.logging.v2.LogMetric'},
  ],
};

const UpdateLogMetricRequest$json = const {
  '1': 'UpdateLogMetricRequest',
  '2': const [
    const {'1': 'metric_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'metric', '3': 2, '4': 1, '5': 11, '6': '.google.logging.v2.LogMetric'},
  ],
};

const DeleteLogMetricRequest$json = const {
  '1': 'DeleteLogMetricRequest',
  '2': const [
    const {'1': 'metric_name', '3': 1, '4': 1, '5': 9},
  ],
};

const MetricsServiceV2$json = const {
  '1': 'MetricsServiceV2',
  '2': const [
    const {'1': 'ListLogMetrics', '2': '.google.logging.v2.ListLogMetricsRequest', '3': '.google.logging.v2.ListLogMetricsResponse', '4': const {}},
    const {'1': 'GetLogMetric', '2': '.google.logging.v2.GetLogMetricRequest', '3': '.google.logging.v2.LogMetric', '4': const {}},
    const {'1': 'CreateLogMetric', '2': '.google.logging.v2.CreateLogMetricRequest', '3': '.google.logging.v2.LogMetric', '4': const {}},
    const {'1': 'UpdateLogMetric', '2': '.google.logging.v2.UpdateLogMetricRequest', '3': '.google.logging.v2.LogMetric', '4': const {}},
    const {'1': 'DeleteLogMetric', '2': '.google.logging.v2.DeleteLogMetricRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const MetricsServiceV2$messageJson = const {
  '.google.logging.v2.ListLogMetricsRequest': ListLogMetricsRequest$json,
  '.google.logging.v2.ListLogMetricsResponse': ListLogMetricsResponse$json,
  '.google.logging.v2.LogMetric': LogMetric$json,
  '.google.logging.v2.GetLogMetricRequest': GetLogMetricRequest$json,
  '.google.logging.v2.CreateLogMetricRequest': CreateLogMetricRequest$json,
  '.google.logging.v2.UpdateLogMetricRequest': UpdateLogMetricRequest$json,
  '.google.logging.v2.DeleteLogMetricRequest': DeleteLogMetricRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
};

