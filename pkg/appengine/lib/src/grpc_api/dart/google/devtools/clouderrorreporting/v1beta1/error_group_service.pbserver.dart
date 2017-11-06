///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_error_group_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'error_group_service.pb.dart';
import 'common.pb.dart';
import 'error_group_service.pbjson.dart';

export 'error_group_service.pb.dart';

abstract class ErrorGroupServiceBase extends GeneratedService {
  Future<ErrorGroup> getGroup(ServerContext ctx, GetGroupRequest request);
  Future<ErrorGroup> updateGroup(ServerContext ctx, UpdateGroupRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'GetGroup': return new GetGroupRequest();
      case 'UpdateGroup': return new UpdateGroupRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'GetGroup': return this.getGroup(ctx, request);
      case 'UpdateGroup': return this.updateGroup(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ErrorGroupService$json;
  Map<String, dynamic> get $messageJson => ErrorGroupService$messageJson;
}

