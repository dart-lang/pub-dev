///
//  Generated code. Do not modify.
///
library google.bigtable.admin.v2_bigtable_table_admin_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bigtable_table_admin.pb.dart';
import 'table.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import 'bigtable_table_admin.pbjson.dart';

export 'bigtable_table_admin.pb.dart';

abstract class BigtableTableAdminServiceBase extends GeneratedService {
  Future<Table> createTable(ServerContext ctx, CreateTableRequest request);
  Future<ListTablesResponse> listTables(ServerContext ctx, ListTablesRequest request);
  Future<Table> getTable(ServerContext ctx, GetTableRequest request);
  Future<google$protobuf.Empty> deleteTable(ServerContext ctx, DeleteTableRequest request);
  Future<Table> modifyColumnFamilies(ServerContext ctx, ModifyColumnFamiliesRequest request);
  Future<google$protobuf.Empty> dropRowRange(ServerContext ctx, DropRowRangeRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'CreateTable': return new CreateTableRequest();
      case 'ListTables': return new ListTablesRequest();
      case 'GetTable': return new GetTableRequest();
      case 'DeleteTable': return new DeleteTableRequest();
      case 'ModifyColumnFamilies': return new ModifyColumnFamiliesRequest();
      case 'DropRowRange': return new DropRowRangeRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'CreateTable': return this.createTable(ctx, request);
      case 'ListTables': return this.listTables(ctx, request);
      case 'GetTable': return this.getTable(ctx, request);
      case 'DeleteTable': return this.deleteTable(ctx, request);
      case 'ModifyColumnFamilies': return this.modifyColumnFamilies(ctx, request);
      case 'DropRowRange': return this.dropRowRange(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => BigtableTableAdmin$json;
  Map<String, dynamic> get $messageJson => BigtableTableAdmin$messageJson;
}

