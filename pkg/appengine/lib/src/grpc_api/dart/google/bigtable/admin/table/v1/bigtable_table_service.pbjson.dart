///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_service_pbjson;

import 'bigtable_table_service_messages.pbjson.dart';
import 'bigtable_table_data.pbjson.dart';
import '../../../../longrunning/operations.pbjson.dart' as google$longrunning;
import '../../../../protobuf/any.pbjson.dart' as google$protobuf;
import '../../../../rpc/status.pbjson.dart' as google$rpc;
import '../../../../protobuf/duration.pbjson.dart' as google$protobuf;
import '../../../../protobuf/empty.pbjson.dart' as google$protobuf;

const BigtableTableService$json = const {
  '1': 'BigtableTableService',
  '2': const [
    const {'1': 'CreateTable', '2': '.google.bigtable.admin.table.v1.CreateTableRequest', '3': '.google.bigtable.admin.table.v1.Table', '4': const {}},
    const {'1': 'ListTables', '2': '.google.bigtable.admin.table.v1.ListTablesRequest', '3': '.google.bigtable.admin.table.v1.ListTablesResponse', '4': const {}},
    const {'1': 'GetTable', '2': '.google.bigtable.admin.table.v1.GetTableRequest', '3': '.google.bigtable.admin.table.v1.Table', '4': const {}},
    const {'1': 'DeleteTable', '2': '.google.bigtable.admin.table.v1.DeleteTableRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'RenameTable', '2': '.google.bigtable.admin.table.v1.RenameTableRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'CreateColumnFamily', '2': '.google.bigtable.admin.table.v1.CreateColumnFamilyRequest', '3': '.google.bigtable.admin.table.v1.ColumnFamily', '4': const {}},
    const {'1': 'UpdateColumnFamily', '2': '.google.bigtable.admin.table.v1.ColumnFamily', '3': '.google.bigtable.admin.table.v1.ColumnFamily', '4': const {}},
    const {'1': 'DeleteColumnFamily', '2': '.google.bigtable.admin.table.v1.DeleteColumnFamilyRequest', '3': '.google.protobuf.Empty', '4': const {}},
    const {'1': 'BulkDeleteRows', '2': '.google.bigtable.admin.table.v1.BulkDeleteRowsRequest', '3': '.google.protobuf.Empty', '4': const {}},
  ],
};

const BigtableTableService$messageJson = const {
  '.google.bigtable.admin.table.v1.CreateTableRequest': CreateTableRequest$json,
  '.google.bigtable.admin.table.v1.Table': Table$json,
  '.google.longrunning.Operation': google$longrunning.Operation$json,
  '.google.protobuf.Any': google$protobuf.Any$json,
  '.google.rpc.Status': google$rpc.Status$json,
  '.google.bigtable.admin.table.v1.Table.ColumnFamiliesEntry': Table_ColumnFamiliesEntry$json,
  '.google.bigtable.admin.table.v1.ColumnFamily': ColumnFamily$json,
  '.google.bigtable.admin.table.v1.GcRule': GcRule$json,
  '.google.protobuf.Duration': google$protobuf.Duration$json,
  '.google.bigtable.admin.table.v1.GcRule.Intersection': GcRule_Intersection$json,
  '.google.bigtable.admin.table.v1.GcRule.Union': GcRule_Union$json,
  '.google.bigtable.admin.table.v1.ListTablesRequest': ListTablesRequest$json,
  '.google.bigtable.admin.table.v1.ListTablesResponse': ListTablesResponse$json,
  '.google.bigtable.admin.table.v1.GetTableRequest': GetTableRequest$json,
  '.google.bigtable.admin.table.v1.DeleteTableRequest': DeleteTableRequest$json,
  '.google.protobuf.Empty': google$protobuf.Empty$json,
  '.google.bigtable.admin.table.v1.RenameTableRequest': RenameTableRequest$json,
  '.google.bigtable.admin.table.v1.CreateColumnFamilyRequest': CreateColumnFamilyRequest$json,
  '.google.bigtable.admin.table.v1.DeleteColumnFamilyRequest': DeleteColumnFamilyRequest$json,
  '.google.bigtable.admin.table.v1.BulkDeleteRowsRequest': BulkDeleteRowsRequest$json,
};

