///
//  Generated code. Do not modify.
///
library google.api.servicecontrol.v1_service_controller_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'service_controller.pb.dart';
import 'service_controller.pbjson.dart';

export 'service_controller.pb.dart';

abstract class ServiceControllerServiceBase extends GeneratedService {
  Future<CheckResponse> check(ServerContext ctx, CheckRequest request);
  Future<ReportResponse> report(ServerContext ctx, ReportRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'Check': return new CheckRequest();
      case 'Report': return new ReportRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'Check': return this.check(ctx, request);
      case 'Report': return this.report(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ServiceController$json;
  Map<String, dynamic> get $messageJson => ServiceController$messageJson;
}

