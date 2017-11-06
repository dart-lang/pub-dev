///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_config_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'logging_config.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'logging_config.pbjson.dart';

export 'logging_config.pb.dart';

abstract class ConfigServiceV2ServiceBase extends GeneratedService {
  Future<ListSinksResponse> listSinks(ServerContext ctx, ListSinksRequest request);
  Future<LogSink> getSink(ServerContext ctx, GetSinkRequest request);
  Future<LogSink> createSink(ServerContext ctx, CreateSinkRequest request);
  Future<LogSink> updateSink(ServerContext ctx, UpdateSinkRequest request);
  Future<google$protobuf.Empty> deleteSink(ServerContext ctx, DeleteSinkRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ListSinks': return new ListSinksRequest();
      case 'GetSink': return new GetSinkRequest();
      case 'CreateSink': return new CreateSinkRequest();
      case 'UpdateSink': return new UpdateSinkRequest();
      case 'DeleteSink': return new DeleteSinkRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ListSinks': return this.listSinks(ctx, request);
      case 'GetSink': return this.getSink(ctx, request);
      case 'CreateSink': return this.createSink(ctx, request);
      case 'UpdateSink': return this.updateSink(ctx, request);
      case 'DeleteSink': return this.deleteSink(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ConfigServiceV2$json;
  Map<String, dynamic> get $messageJson => ConfigServiceV2$messageJson;
}

