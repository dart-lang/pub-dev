///
//  Generated code. Do not modify.
///
library google.bytestream_bytestream_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'bytestream.pb.dart';
import 'bytestream.pbjson.dart';

export 'bytestream.pb.dart';

abstract class ByteStreamServiceBase extends GeneratedService {
  Future<ReadResponse> read(ServerContext ctx, ReadRequest request);
  Future<WriteResponse> write(ServerContext ctx, WriteRequest request);
  Future<QueryWriteStatusResponse> queryWriteStatus(ServerContext ctx, QueryWriteStatusRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'Read': return new ReadRequest();
      case 'Write': return new WriteRequest();
      case 'QueryWriteStatus': return new QueryWriteStatusRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'Read': return this.read(ctx, request);
      case 'Write': return this.write(ctx, request);
      case 'QueryWriteStatus': return this.queryWriteStatus(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ByteStream$json;
  Map<String, dynamic> get $messageJson => ByteStream$messageJson;
}

