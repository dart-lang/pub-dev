///
//  Generated code. Do not modify.
///
library google.bigtable.v1_bigtable_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bigtable_service_messages.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'bigtable_data.pb.dart';

class BigtableServiceApi {
  RpcClient _client;
  BigtableServiceApi(this._client);

  Future<ReadRowsResponse> readRows(ClientContext ctx, ReadRowsRequest request) {
    var emptyResponse = new ReadRowsResponse();
    return _client.invoke(ctx, 'BigtableService', 'ReadRows', request, emptyResponse);
  }
  Future<SampleRowKeysResponse> sampleRowKeys(ClientContext ctx, SampleRowKeysRequest request) {
    var emptyResponse = new SampleRowKeysResponse();
    return _client.invoke(ctx, 'BigtableService', 'SampleRowKeys', request, emptyResponse);
  }
  Future<google$protobuf.Empty> mutateRow(ClientContext ctx, MutateRowRequest request) {
    var emptyResponse = new google$protobuf.Empty();
    return _client.invoke(ctx, 'BigtableService', 'MutateRow', request, emptyResponse);
  }
  Future<MutateRowsResponse> mutateRows(ClientContext ctx, MutateRowsRequest request) {
    var emptyResponse = new MutateRowsResponse();
    return _client.invoke(ctx, 'BigtableService', 'MutateRows', request, emptyResponse);
  }
  Future<CheckAndMutateRowResponse> checkAndMutateRow(ClientContext ctx, CheckAndMutateRowRequest request) {
    var emptyResponse = new CheckAndMutateRowResponse();
    return _client.invoke(ctx, 'BigtableService', 'CheckAndMutateRow', request, emptyResponse);
  }
  Future<Row> readModifyWriteRow(ClientContext ctx, ReadModifyWriteRowRequest request) {
    var emptyResponse = new Row();
    return _client.invoke(ctx, 'BigtableService', 'ReadModifyWriteRow', request, emptyResponse);
  }
}

