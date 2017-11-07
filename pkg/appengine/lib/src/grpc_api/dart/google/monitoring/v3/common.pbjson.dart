///
//  Generated code. Do not modify.
///
library google.monitoring.v3_common_pbjson;

const TypedValue$json = const {
  '1': 'TypedValue',
  '2': const [
    const {'1': 'bool_value', '3': 1, '4': 1, '5': 8},
    const {'1': 'int64_value', '3': 2, '4': 1, '5': 3},
    const {'1': 'double_value', '3': 3, '4': 1, '5': 1},
    const {'1': 'string_value', '3': 4, '4': 1, '5': 9},
    const {'1': 'distribution_value', '3': 5, '4': 1, '5': 11, '6': '.google.api.Distribution'},
  ],
};

const TimeInterval$json = const {
  '1': 'TimeInterval',
  '2': const [
    const {'1': 'end_time', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
    const {'1': 'start_time', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp'},
  ],
};

const Aggregation$json = const {
  '1': 'Aggregation',
  '2': const [
    const {'1': 'alignment_period', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'per_series_aligner', '3': 2, '4': 1, '5': 14, '6': '.google.monitoring.v3.Aggregation.Aligner'},
    const {'1': 'cross_series_reducer', '3': 4, '4': 1, '5': 14, '6': '.google.monitoring.v3.Aggregation.Reducer'},
    const {'1': 'group_by_fields', '3': 5, '4': 3, '5': 9},
  ],
  '4': const [Aggregation_Aligner$json, Aggregation_Reducer$json],
};

const Aggregation_Aligner$json = const {
  '1': 'Aligner',
  '2': const [
    const {'1': 'ALIGN_NONE', '2': 0},
    const {'1': 'ALIGN_DELTA', '2': 1},
    const {'1': 'ALIGN_RATE', '2': 2},
    const {'1': 'ALIGN_INTERPOLATE', '2': 3},
    const {'1': 'ALIGN_NEXT_OLDER', '2': 4},
    const {'1': 'ALIGN_MIN', '2': 10},
    const {'1': 'ALIGN_MAX', '2': 11},
    const {'1': 'ALIGN_MEAN', '2': 12},
    const {'1': 'ALIGN_COUNT', '2': 13},
    const {'1': 'ALIGN_SUM', '2': 14},
    const {'1': 'ALIGN_STDDEV', '2': 15},
    const {'1': 'ALIGN_COUNT_TRUE', '2': 16},
    const {'1': 'ALIGN_FRACTION_TRUE', '2': 17},
    const {'1': 'ALIGN_PERCENTILE_99', '2': 18},
    const {'1': 'ALIGN_PERCENTILE_95', '2': 19},
    const {'1': 'ALIGN_PERCENTILE_50', '2': 20},
    const {'1': 'ALIGN_PERCENTILE_05', '2': 21},
  ],
};

const Aggregation_Reducer$json = const {
  '1': 'Reducer',
  '2': const [
    const {'1': 'REDUCE_NONE', '2': 0},
    const {'1': 'REDUCE_MEAN', '2': 1},
    const {'1': 'REDUCE_MIN', '2': 2},
    const {'1': 'REDUCE_MAX', '2': 3},
    const {'1': 'REDUCE_SUM', '2': 4},
    const {'1': 'REDUCE_STDDEV', '2': 5},
    const {'1': 'REDUCE_COUNT', '2': 6},
    const {'1': 'REDUCE_COUNT_TRUE', '2': 7},
    const {'1': 'REDUCE_FRACTION_TRUE', '2': 8},
    const {'1': 'REDUCE_PERCENTILE_99', '2': 9},
    const {'1': 'REDUCE_PERCENTILE_95', '2': 10},
    const {'1': 'REDUCE_PERCENTILE_50', '2': 11},
    const {'1': 'REDUCE_PERCENTILE_05', '2': 12},
  ],
};

