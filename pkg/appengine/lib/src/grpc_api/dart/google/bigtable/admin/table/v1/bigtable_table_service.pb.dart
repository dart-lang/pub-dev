///
//  Generated code. Do not modify.
///
library google.bigtable.admin.table.v1_bigtable_table_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bigtable_table_service_messages.pb.dart';
import 'bigtable_table_data.pb.dart';
import '../../../../protobuf/empty.pb.dart' as google$protobuf;

class BigtableTableServiceApi {
  RpcClient _client;
  BigtableTableServiceApi(this._client);

  Future<Table> createTable(ClientContext ctx, CreateTableRequest request) {
    var emptyResponse = new Table();
    return _client.invoke(ctx, 'BigtableTableService', 'CreateTable', request, emptyResponse);
  }
  Future<ListTablesResponse> listTables(ClientContext ctx, ListTablesRequest request) {
    var emptyResponse = new ListTablesResponse();
    return _client.invoke(ctx, 'BigtableTableService', 'ListTables', request, emptyResponse);
  }
  Future<Table> getTable(ClientContext ctx, GetTableRequest request) {
    var emptyResponse = new Table();
    return _client.invoke(ctx, 'BigtableTableService', 'GetTable', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteTable(ClientContext ctx, DeleteTableRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableService', 'DeleteTable', request, emptyResponse);
  }
  Future<google$protobuf.Empty> renameTable(ClientContext ctx, RenameTableRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableService', 'RenameTable', request, emptyResponse);
  }
  Future<ColumnFamily> createColumnFamily(ClientContext ctx, CreateColumnFamilyRequest request) {
    var emptyResponse = new ColumnFamily();
    return _client.invoke(ctx, 'BigtableTableService', 'CreateColumnFamily', request, emptyResponse);
  }
  Future<ColumnFamily> updateColumnFamily(ClientContext ctx, ColumnFamily request) {
    var emptyResponse = new ColumnFamily();
    return _client.invoke(ctx, 'BigtableTableService', 'UpdateColumnFamily', request, emptyResponse);
  }
  Future<google$protobuf.Empty> deleteColumnFamily(ClientContext ctx, DeleteColumnFamilyRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableService', 'DeleteColumnFamily', request, emptyResponse);
  }
  Future<google$protobuf.Empty> bulkDeleteRows(ClientContext ctx, BulkDeleteRowsRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableTableService', 'BulkDeleteRows', request, emptyResponse);
  }
}

