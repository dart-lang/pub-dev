///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_controller_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'controller.pb.dart';
import 'controller.pbjson.dart';

export 'controller.pb.dart';

abstract class Controller2ServiceBase extends GeneratedService {
  Future<RegisterDebuggeeResponse> registerDebuggee(ServerContext ctx, RegisterDebuggeeRequest request);
  Future<ListActiveBreakpointsResponse> listActiveBreakpoints(ServerContext ctx, ListActiveBreakpointsRequest request);
  Future<UpdateActiveBreakpointResponse> updateActiveBreakpoint(ServerContext ctx, UpdateActiveBreakpointRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'RegisterDebuggee': return new RegisterDebuggeeRequest();
      case 'ListActiveBreakpoints': return new ListActiveBreakpointsRequest();
      case 'UpdateActiveBreakpoint': return new UpdateActiveBreakpointRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'RegisterDebuggee': return this.registerDebuggee(ctx, request);
      case 'ListActiveBreakpoints': return this.listActiveBreakpoints(ctx, request);
      case 'UpdateActiveBreakpoint': return this.updateActiveBreakpoint(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Controller2$json;
  Map<String, dynamic> get $messageJson => Controller2$messageJson;
}

