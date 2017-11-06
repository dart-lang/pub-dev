///
//  Generated code. Do not modify.
///
library google.bigtable.v1_bigtable_service_messages_pbjson;

const ReadRowsRequest$json = const {
  '1': 'ReadRowsRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key', '3': 2, '4': 1, '5': 12},
    const {'1': 'row_range', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.v1.RowRange'},
    const {'1': 'row_set', '3': 8, '4': 1, '5': 11, '6': '.google.bigtable.v1.RowSet'},
    const {'1': 'filter', '3': 5, '4': 1, '5': 11, '6': '.google.bigtable.v1.RowFilter'},
    const {'1': 'allow_row_interleaving', '3': 6, '4': 1, '5': 8},
    const {'1': 'num_rows_limit', '3': 7, '4': 1, '5': 3},
  ],
};

const ReadRowsResponse$json = const {
  '1': 'ReadRowsResponse',
  '2': const [
    const {'1': 'row_key', '3': 1, '4': 1, '5': 12},
    const {'1': 'chunks', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v1.ReadRowsResponse.Chunk'},
  ],
  '3': const [ReadRowsResponse_Chunk$json],
};

const ReadRowsResponse_Chunk$json = const {
  '1': 'Chunk',
  '2': const [
    const {'1': 'row_contents', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.v1.Family'},
    const {'1': 'reset_row', '3': 2, '4': 1, '5': 8},
    const {'1': 'commit_row', '3': 3, '4': 1, '5': 8},
  ],
};

const SampleRowKeysRequest$json = const {
  '1': 'SampleRowKeysRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
  ],
};

const SampleRowKeysResponse$json = const {
  '1': 'SampleRowKeysResponse',
  '2': const [
    const {'1': 'row_key', '3': 1, '4': 1, '5': 12},
    const {'1': 'offset_bytes', '3': 2, '4': 1, '5': 3},
  ],
};

const MutateRowRequest$json = const {
  '1': 'MutateRowRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key', '3': 2, '4': 1, '5': 12},
    const {'1': 'mutations', '3': 3, '4': 3, '5': 11, '6': '.google.bigtable.v1.Mutation'},
  ],
};

const MutateRowsRequest$json = const {
  '1': 'MutateRowsRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'entries', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v1.MutateRowsRequest.Entry'},
  ],
  '3': const [MutateRowsRequest_Entry$json],
};

const MutateRowsRequest_Entry$json = const {
  '1': 'Entry',
  '2': const [
    const {'1': 'row_key', '3': 1, '4': 1, '5': 12},
    const {'1': 'mutations', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v1.Mutation'},
  ],
};

const MutateRowsResponse$json = const {
  '1': 'MutateRowsResponse',
  '2': const [
    const {'1': 'statuses', '3': 1, '4': 3, '5': 11, '6': '.google.rpc.Status'},
  ],
};

const CheckAndMutateRowRequest$json = const {
  '1': 'CheckAndMutateRowRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key', '3': 2, '4': 1, '5': 12},
    const {'1': 'predicate_filter', '3': 6, '4': 1, '5': 11, '6': '.google.bigtable.v1.RowFilter'},
    const {'1': 'true_mutations', '3': 4, '4': 3, '5': 11, '6': '.google.bigtable.v1.Mutation'},
    const {'1': 'false_mutations', '3': 5, '4': 3, '5': 11, '6': '.google.bigtable.v1.Mutation'},
  ],
};

const CheckAndMutateRowResponse$json = const {
  '1': 'CheckAndMutateRowResponse',
  '2': const [
    const {'1': 'predicate_matched', '3': 1, '4': 1, '5': 8},
  ],
};

const ReadModifyWriteRowRequest$json = const {
  '1': 'ReadModifyWriteRowRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key', '3': 2, '4': 1, '5': 12},
    const {'1': 'rules', '3': 3, '4': 3, '5': 11, '6': '.google.bigtable.v1.ReadModifyWriteRule'},
  ],
};

