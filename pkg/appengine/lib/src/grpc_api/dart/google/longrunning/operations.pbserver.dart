///
//  Generated code. Do not modify.
///
library google.longrunning_operations_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'operations.pb.dart';
import '../protobuf/empty.pb.dart' as google$protobuf;
import 'operations.pbjson.dart';

export 'operations.pb.dart';

abstract class OperationsServiceBase extends GeneratedService {
  Future<ListOperationsResponse> listOperations(ServerContext ctx, ListOperationsRequest request);
  Future<Operation> getOperation(ServerContext ctx, GetOperationRequest request);
  Future<google$protobuf.Empty> deleteOperation(ServerContext ctx, DeleteOperationRequest request);
  Future<google$protobuf.Empty> cancelOperation(ServerContext ctx, CancelOperationRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListOperations': return new ListOperationsRequest();
      case 'GetOperation': return new GetOperationRequest();
      case 'DeleteOperation': return new DeleteOperationRequest();
      case 'CancelOperation': return new CancelOperationRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListOperations': return this.listOperations(ctx, request);
      case 'GetOperation': return this.getOperation(ctx, request);
      case 'DeleteOperation': return this.deleteOperation(ctx, request);
      case 'CancelOperation': return this.cancelOperation(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Operations$json;
  Map<String, dynamic> get $messageJson => Operations$messageJson;
}

