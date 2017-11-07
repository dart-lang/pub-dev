///
//  Generated code. Do not modify.
///
library google.bigtable.v2_bigtable_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bigtable.pb.dart';
import 'bigtable.pbjson.dart';

export 'bigtable.pb.dart';

abstract class BigtableServiceBase extends GeneratedService {
  Future<ReadRowsResponse> readRows(ServerContext ctx, ReadRowsRequest request);
  Future<SampleRowKeysResponse> sampleRowKeys(ServerContext ctx, SampleRowKeysRequest request);
  Future<MutateRowResponse> mutateRow(ServerContext ctx, MutateRowRequest request);
  Future<MutateRowsResponse> mutateRows(ServerContext ctx, MutateRowsRequest request);
  Future<CheckAndMutateRowResponse> checkAndMutateRow(ServerContext ctx, CheckAndMutateRowRequest request);
  Future<ReadModifyWriteRowResponse> readModifyWriteRow(ServerContext ctx, ReadModifyWriteRowRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ReadRows': return new ReadRowsRequest();
      case 'SampleRowKeys': return new SampleRowKeysRequest();
      case 'MutateRow': return new MutateRowRequest();
      case 'MutateRows': return new MutateRowsRequest();
      case 'CheckAndMutateRow': return new CheckAndMutateRowRequest();
      case 'ReadModifyWriteRow': return new ReadModifyWriteRowRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ReadRows': return this.readRows(ctx, request);
      case 'SampleRowKeys': return this.sampleRowKeys(ctx, request);
      case 'MutateRow': return this.mutateRow(ctx, request);
      case 'MutateRows': return this.mutateRows(ctx, request);
      case 'CheckAndMutateRow': return this.checkAndMutateRow(ctx, request);
      case 'ReadModifyWriteRow': return this.readModifyWriteRow(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Bigtable$json;
  Map<String, dynamic> get $messageJson => Bigtable$messageJson;
}

