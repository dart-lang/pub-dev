///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_service_messages_pbjson;

const CreateTableRequest$json = const {
  '1': 'CreateTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'table_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'table', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.Table'},
    const {'1': 'initial_split_keys', '3': 4, '4': 3, '5': 9},
  ],
};

const ListTablesRequest$json = const {
  '1': 'ListTablesRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ListTablesResponse$json = const {
  '1': 'ListTablesResponse',
  '2': const [
    const {'1': 'tables', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.table.v1.Table'},
  ],
};

const GetTableRequest$json = const {
  '1': 'GetTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const DeleteTableRequest$json = const {
  '1': 'DeleteTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const RenameTableRequest$json = const {
  '1': 'RenameTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'new_id', '3': 2, '4': 1, '5': 9},
  ],
};

const CreateColumnFamilyRequest$json = const {
  '1': 'CreateColumnFamilyRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'column_family_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'column_family', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.table.v1.ColumnFamily'},
  ],
};

const DeleteColumnFamilyRequest$json = const {
  '1': 'DeleteColumnFamilyRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const BulkDeleteRowsRequest$json = const {
  '1': 'BulkDeleteRowsRequest',
  '2': const [
    const {'1': 'table_name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key_prefix', '3': 2, '4': 1, '5': 12},
    const {'1': 'delete_all_data_from_table', '3': 3, '4': 1, '5': 8},
  ],
};

