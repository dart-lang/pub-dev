///
//  Generated code. Do not modify.
///
library google.spanner.v1_result_set_pbjson;

const ResultSet$json = const {
  '1': 'ResultSet',
  '2': const [
    const {'1': 'metadata', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.ResultSetMetadata'},
    const {'1': 'rows', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.ListValue'},
    const {'1': 'stats', '3': 3, '4': 1, '5': 11, '6': '.google.spanner.v1.ResultSetStats'},
  ],
};

const PartialResultSet$json = const {
  '1': 'PartialResultSet',
  '2': const [
    const {'1': 'metadata', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.ResultSetMetadata'},
    const {'1': 'values', '3': 2, '4': 3, '5': 11, '6': '.google.protobuf.Value'},
    const {'1': 'chunked_value', '3': 3, '4': 1, '5': 8},
    const {'1': 'resume_token', '3': 4, '4': 1, '5': 12},
    const {'1': 'stats', '3': 5, '4': 1, '5': 11, '6': '.google.spanner.v1.ResultSetStats'},
  ],
};

const ResultSetMetadata$json = const {
  '1': 'ResultSetMetadata',
  '2': const [
    const {'1': 'row_type', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.StructType'},
    const {'1': 'transaction', '3': 2, '4': 1, '5': 11, '6': '.google.spanner.v1.Transaction'},
  ],
};

const ResultSetStats$json = const {
  '1': 'ResultSetStats',
  '2': const [
    const {'1': 'query_plan', '3': 1, '4': 1, '5': 11, '6': '.google.spanner.v1.QueryPlan'},
    const {'1': 'query_stats', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Struct'},
  ],
};

