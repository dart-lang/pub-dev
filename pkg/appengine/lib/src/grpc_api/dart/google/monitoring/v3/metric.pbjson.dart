///
//  Generated code. Do not modify.
///
library google.monitoring.v3_metric_pbjson;

const Point$json = const {
  '1': 'Point',
  '2': const [
    const {'1': 'interval', '3': 1, '4': 1, '5': 11, '6': '.google.monitoring.v3.TimeInterval'},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.monitoring.v3.TypedValue'},
  ],
};

const TimeSeries$json = const {
  '1': 'TimeSeries',
  '2': const [
    const {'1': 'metric', '3': 1, '4': 1, '5': 11, '6': '.google.api.Metric'},
    const {'1': 'resource', '3': 2, '4': 1, '5': 11, '6': '.google.api.MonitoredResource'},
    const {'1': 'metric_kind', '3': 3, '4': 1, '5': 14, '6': '.google.api.MetricDescriptor.MetricKind'},
    const {'1': 'value_type', '3': 4, '4': 1, '5': 14, '6': '.google.api.MetricDescriptor.ValueType'},
    const {'1': 'points', '3': 5, '4': 3, '5': 11, '6': '.google.monitoring.v3.Point'},
  ],
};

