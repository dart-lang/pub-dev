///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_table_pbjson;

const Table$json = const {
  '1': 'Table',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'column_families', '3': 3, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.Table.ColumnFamiliesEntry'},
    const {'1': 'granularity', '3': 4, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Table.TimestampGranularity'},
  ],
  '3': const [Table_ColumnFamiliesEntry$json],
  '4': const [Table_TimestampGranularity$json, Table_View$json],
};

const Table_ColumnFamiliesEntry$json = const {
  '1': 'ColumnFamiliesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9},
    const {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.ColumnFamily'},
  ],
  '7': const {},
};

const Table_TimestampGranularity$json = const {
  '1': 'TimestampGranularity',
  '2': const [
    const {'1': 'TIMESTAMP_GRANULARITY_UNSPECIFIED', '2': 0},
    const {'1': 'MILLIS', '2': 1},
  ],
};

const Table_View$json = const {
  '1': 'View',
  '2': const [
    const {'1': 'VIEW_UNSPECIFIED', '2': 0},
    const {'1': 'NAME_ONLY', '2': 1},
    const {'1': 'SCHEMA_VIEW', '2': 2},
    const {'1': 'FULL', '2': 4},
  ],
};

const ColumnFamily$json = const {
  '1': 'ColumnFamily',
  '2': const [
    const {'1': 'gc_rule', '3': 1, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.GcRule'},
  ],
};

const GcRule$json = const {
  '1': 'GcRule',
  '2': const [
    const {'1': 'max_num_versions', '3': 1, '4': 1, '5': 5},
    const {'1': 'max_age', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Duration'},
    const {'1': 'intersection', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.GcRule.Intersection'},
    const {'1': 'union', '3': 4, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.GcRule.Union'},
  ],
  '3': const [GcRule_Intersection$json, GcRule_Union$json],
};

const GcRule_Intersection$json = const {
  '1': 'Intersection',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.GcRule'},
  ],
};

const GcRule_Union$json = const {
  '1': 'Union',
  '2': const [
    const {'1': 'rules', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.GcRule'},
  ],
};

