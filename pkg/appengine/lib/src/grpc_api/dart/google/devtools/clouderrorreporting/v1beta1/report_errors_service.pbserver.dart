///
//  Generated code. Do not modify.
///
library google.devtools.clouderrorreporting.v1beta1_report_errors_service_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'report_errors_service.pb.dart';
import 'report_errors_service.pbjson.dart';

export 'report_errors_service.pb.dart';

abstract class ReportErrorsServiceBase extends GeneratedService {
  Future<ReportErrorEventResponse> reportErrorEvent(ServerContext ctx, ReportErrorEventRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'ReportErrorEvent': return new ReportErrorEventRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'ReportErrorEvent': return this.reportErrorEvent(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => ReportErrorsService$json;
  Map<String, dynamic> get $messageJson => ReportErrorsService$messageJson;
}

