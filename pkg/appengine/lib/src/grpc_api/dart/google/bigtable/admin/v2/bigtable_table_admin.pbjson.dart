///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_table_admin_pbjson;

import 'table.pbjson.dart';
import '../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../protobuf/empty.pbjson.dart' as google$protobuf;

const CreateTableRequest$json = const {
  '1': 'CreateTableRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'table_id', '3': 2, '4': 1, '5': 9},
    const {'1': 'table', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.Table'},
    const {'1': 'initial_splits', '3': 4, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.CreateTableRequest.Split'},
  ],
  '3': const [CreateTableRequest_Split$json],
};

const CreateTableRequest_Split$json = const {
  '1': 'Split',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 12},
  ],
};

const DropRowRangeRequest$json = const {
  '1': 'DropRowRangeRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'row_key_prefix', '3': 2, '4': 1, '5': 12},
    const {'1': 'delete_all_data_from_table', '3': 3, '4': 1, '5': 8},
  ],
};

const ListTablesRequest$json = const {
  '1': 'ListTablesRequest',
  '2': const [
    const {'1': 'parent', '3': 1, '4': 1, '5': 9},
    const {'1': 'view', '3': 2, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Table.View'},
    const {'1': 'page_token', '3': 3, '4': 1, '5': 9},
  ],
};

const ListTablesResponse$json = const {
  '1': 'ListTablesResponse',
  '2': const [
    const {'1': 'tables', '3': 1, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.Table'},
    const {'1': 'next_page_token', '3': 2, '4': 1, '5': 9},
  ],
};

const GetTableRequest$json = const {
  '1': 'GetTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'view', '3': 2, '4': 1, '5': 14, '6': '.google.bigtable.admin.v2.Table.View'},
  ],
};

const DeleteTableRequest$json = const {
  '1': 'DeleteTableRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
  ],
};

const ModifyColumnFamiliesRequest$json = const {
  '1': 'ModifyColumnFamiliesRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9},
    const {'1': 'modifications', '3': 2, '4': 3, '5': 11, '6': '.google.bigtable.admin.v2.ModifyColumnFamiliesRequest.Modification'},
  ],
  '3': const [ModifyColumnFamiliesRequest_Modification$json],
};

const ModifyColumnFamiliesRequest_Modification$json = const {
  '1': 'Modification',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9},
    const {'1': 'create', '3': 2, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.ColumnFamily'},
    const {'1': 'update', '3': 3, '4': 1, '5': 11, '6': '.google.bigtable.admin.v2.ColumnFamily'},
    const {'1': 'drop', '3': 4, '4': 1, '5': 8},
  ],
};

const BigtableTableAdmin$json = const {
  '1': 'BigtableTableAdmin',
  '2': const [
    const {'1': 'CreateTable', '2': '.google.bigtable.admin.v2.CreateTableRequest', '3': '.google.bigtable.admin.v2.Table', '4': const {}},
    const {'1': 'ListTables', '2': '.google.bigtable.admin.v2.ListTablesRequest', '3': '.google.bigtable.admin.v2.ListTablesResponse', '4': const {}},
    const {'1': 'GetTable', '2': '.google.bigtable.admin.v2.GetTableRequest', '3': '.google.bigtable.admin.v2.Table', '4': const {}},
    const {'1': 'DeleteTable', '2': '.google.bigtable.admin.v2.DeleteTableRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'ModifyColumnFamilies', '2': '.google.bigtable.admin.v2.ModifyColumnFamiliesRequest', '3': '.google.bigtable.admin.v2.Table', '4': const {}},
    const {'1': 'DropRowRange', '2': '.google.bigtable.admin.v2.DropRowRangeRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const BigtableTableAdmin$messageJson = const {
  '.google.bigtable.admin.v2.CreateTableRequest': CreateTableRequest$json,
  '.google.bigtable.admin.v2.Table': Table$json,
  '.google.bigtable.admin.v2.Table.ColumnFamiliesEntry': Table_ColumnFamiliesEntry$json,
  '.google.bigtable.admin.v2.ColumnFamily': ColumnFamily$json,
  '.google.bigtable.admin.v2.GcRule': GcRule$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.bigtable.admin.v2.GcRule.Intersection': GcRule_Intersection$json,
  '.google.bigtable.admin.v2.GcRule.Union': GcRule_Union$json,
  '.google.bigtable.admin.v2.CreateTableRequest.Split': CreateTableRequest_Split$json,
  '.google.bigtable.admin.v2.ListTablesRequest': ListTablesRequest$json,
  '.google.bigtable.admin.v2.ListTablesResponse': ListTablesResponse$json,
  '.google.bigtable.admin.v2.GetTableRequest': GetTableRequest$json,
  '.google.bigtable.admin.v2.DeleteTableRequest': DeleteTableRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.bigtable.admin.v2.ModifyColumnFamiliesRequest': ModifyColumnFamiliesRequest$json,
  '.google.bigtable.admin.v2.ModifyColumnFamiliesRequest.Modification': ModifyColumnFamiliesRequest_Modification$json,
  '.google.bigtable.admin.v2.DropRowRangeRequest': DropRowRangeRequest$json,
};

