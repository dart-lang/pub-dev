///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_data_pbjson;

const Table$json = const {
  '1': 'Table',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'current_operation', '3': 2, '4': 1, '5': 11, '6': '.google.longrunning.Operation'},
    const {'1': 'column_families', '3': 3, '4': 3, '5': 11, '6': '.google.bigtable.admin.table.v1.Table.ColumnFamiliesEntry'},
    const {'1': 'granularity', '3': 4, '4': 1, '5': 14, '6': '.google.bigtable.admin.table.v1.Table.TimestampGranularity'},
  ],
  '3': const [Table_ColumnFamiliesEntry$json],
  '4': const [Table_TimestampGranularity$json],
};

const Table_ColumnFamiliesEntry$json = const {
  '1': 'ColumnFamiliesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.ColumnFamily'},
  ],
  '7': const {},
};

const Table_TimestampGranularity$json = const {
  '1': 'TimestampGranularity',
  '2': const [
    const {'1': 'MILLIS', '2': 0},
  ],
};

const ColumnFamily$json = const {
  '1': 'ColumnFamily',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'gc_expression', '3': 2, '4': 1, '5': 9},
    const {'1': 'gc_rule', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.GcRule'},
  ],
};

const GcRule$json = const {
  '1': 'GcRule',
  '2': const [
    const {'1': 'max_num_versions', '3': 1, '4': 1, '5': 5},
    const {'1': 'max_age', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'intersection', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.GcRule.Intersection'},
    const {'1': 'union', '3': 4, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.GcRule.Union'},
  ],
  '3': const [GcRule_Intersection$json, GcRule_Union$json],
};

const GcRule_Intersection$json = const {
  '1': 'Intersection',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.table.v1.GcRule'},
  ],
};

const GcRule_Union$json = const {
  '1': 'Union',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.table.v1.GcRule'},
  ],
};

