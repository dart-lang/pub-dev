///
//  Generated code. Do not modify.
///
library google.bigtable.v2_data_pbjson;

const Row$json = const {
  '1': 'Row',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12},
    const {'1': 'families', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v2.Family'},
  ],
};

const Family$json = const {
  '1': 'Family',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'columns', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v2.Column'},
  ],
};

const Column$json = const {
  '1': 'Column',
  '2': const [
    const {'1': 'qualifier', '3': 1, '4': 1, '5': 12},
    const {'1': 'cells', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v2.Cell'},
  ],
};

const Cell$json = const {
  '1': 'Cell',
  '2': const [
    const {'1': 'timestamp_micros', '3': 1, '4': 1, '5': 3},
    const {'1': 'value', '3': 2, '4': 1, '5': 12},
    const {'1': 'labels', '3': 3, '4': 3, '5': 9},
  ],
};

const RowRange$json = const {
  '1': 'RowRange',
  '2': const [
    const {'1': 'start_key_closed', '3': 1, '4': 1, '5': 12},
    const {'1': 'start_key_open', '3': 2, '4': 1, '5': 12},
    const {'1': 'end_key_open', '3': 3, '4': 1, '5': 12},
    const {'1': 'end_key_closed', '3': 4, '4': 1, '5': 12},
  ],
};

const RowSet$json = const {
  '1': 'RowSet',
  '2': const [
    const {'1': 'row_keys', '3': 1, '4': 3, '5': 12},
    const {'1': 'row_ranges', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.v2.RowRange'},
  ],
};

const ColumnRange$json = const {
  '1': 'ColumnRange',
  '2': const [
    const {'1': 'family_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'start_qualifier_closed', '3': 2, '4': 1, '5': 12},
    const {'1': 'start_qualifier_open', '3': 3, '4': 1, '5': 12},
    const {'1': 'end_qualifier_closed', '3': 4, '4': 1, '5': 12},
    const {'1': 'end_qualifier_open', '3': 5, '4': 1, '5': 12},
  ],
};

const TimestampRange$json = const {
  '1': 'TimestampRange',
  '2': const [
    const {'1': 'start_timestamp_micros', '3': 1, '4': 1, '5': 3},
    const {'1': 'end_timestamp_micros', '3': 2, '4': 1, '5': 3},
  ],
};

const ValueRange$json = const {
  '1': 'ValueRange',
  '2': const [
    const {'1': 'start_value_closed', '3': 1, '4': 1, '5': 12},
    const {'1': 'start_value_open', '3': 2, '4': 1, '5': 12},
    const {'1': 'end_value_closed', '3': 3, '4': 1, '5': 12},
    const {'1': 'end_value_open', '3': 4, '4': 1, '5': 12},
  ],
};

const RowFilter$json = const {
  '1': 'RowFilter',
  '2': const [
    const {'1': 'chain', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter.Chain'},
    const {'1': 'interleave', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter.Interleave'},
    const {'1': 'condition', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter.Condition'},
    const {'1': 'sink', '3': 16, '4': 1, '5': 8},
    const {'1': 'pass_all_filter', '3': 17, '4': 1, '5': 8},
    const {'1': 'block_all_filter', '3': 18, '4': 1, '5': 8},
    const {'1': 'row_key_regex_filter', '3': 4, '4': 1, '5': 12},
    const {'1': 'row_sample_filter', '3': 14, '4': 1, '5': 1},
    const {'1': 'family_name_regex_filter', '3': 5, '4': 1, '5': 9},
    const {'1': 'column_qualifier_regex_filter', '3': 6, '4': 1, '5': 12},
    const {'1': 'column_range_filter', '3': 7, '4': 1, '5': 11, '6': '.google.bigtable.v2.ColumnRange'},
    const {'1': 'timestamp_range_filter', '3': 8, '4': 1, '5': 11, '6': '.google.bigtable.v2.TimestampRange'},
    const {'1': 'value_regex_filter', '3': 9, '4': 1, '5': 12},
    const {'1': 'value_range_filter', '3': 15, '4': 1, '5': 11, '6': '.google.bigtable.v2.ValueRange'},
    const {'1': 'cells_per_row_offset_filter', '3': 10, '4': 1, '5': 5},
    const {'1': 'cells_per_row_limit_filter', '3': 11, '4': 1, '5': 5},
    const {'1': 'cells_per_column_limit_filter', '3': 12, '4': 1, '5': 5},
    const {'1': 'strip_value_transformer', '3': 13, '4': 1, '5': 8},
    const {'1': 'apply_label_transformer', '3': 19, '4': 1, '5': 9},
  ],
  '3': const [RowFilter_Chain$json, RowFilter_Interleave$json, RowFilter_Condition$json],
};

const RowFilter_Chain$json = const {
  '1': 'Chain',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.v2.RowFilter'},
  ],
};

const RowFilter_Interleave$json = const {
  '1': 'Interleave',
  '2': const [
    const {'1': 'filters', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.v2.RowFilter'},
  ],
};

const RowFilter_Condition$json = const {
  '1': 'Condition',
  '2': const [
    const {'1': 'predicate_filter', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter'},
    const {'1': 'true_filter', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter'},
    const {'1': 'false_filter', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.v2.RowFilter'},
  ],
};

const Mutation$json = const {
  '1': 'Mutation',
  '2': const [
    const {'1': 'set_cell', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.v2.Mutation.SetCell'},
    const {'1': 'delete_from_column', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.v2.Mutation.DeleteFromColumn'},
    const {'1': 'delete_from_family', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.v2.Mutation.DeleteFromFamily'},
    const {'1': 'delete_from_row', '3': 4, '4': 1, '5': 11, '6': '.google.bigtable.v2.Mutation.DeleteFromRow'},
  ],
  '3': const [Mutation_SetCell$json, Mutation_DeleteFromColumn$json, Mutation_DeleteFromFamily$json, Mutation_DeleteFromRow$json],
};

const Mutation_SetCell$json = const {
  '1': 'SetCell',
  '2': const [
    const {'1': 'family_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'column_qualifier', '3': 2, '4': 1, '5': 12},
    const {'1': 'timestamp_micros', '3': 3, '4': 1, '5': 3},
    const {'1': 'value', '3': 4, '4': 1, '5': 12},
  ],
};

const Mutation_DeleteFromColumn$json = const {
  '1': 'DeleteFromColumn',
  '2': const [
    const {'1': 'family_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'column_qualifier', '3': 2, '4': 1, '5': 12},
    const {'1': 'time_range', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.v2.TimestampRange'},
  ],
};

const Mutation_DeleteFromFamily$json = const {
  '1': 'DeleteFromFamily',
  '2': const [
    const {'1': 'family_name', '3': 1, '4': 1, '5': 9},
  ],
};

const Mutation_DeleteFromRow$json = const {
  '1': 'DeleteFromRow',
};

const ReadModifyWriteRule$json = const {
  '1': 'ReadModifyWriteRule',
  '2': const [
    const {'1': 'family_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'column_qualifier', '3': 2, '4': 1, '5': 12},
    const {'1': 'append_value', '3': 3, '4': 1, '5': 12},
    const {'1': 'increment_amount', '3': 4, '4': 1, '5': 3},
  ],
};

