///
//  Generated code. Do not modify.
///
library google.devtools.clouddebugger.v2_debugger_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'debugger.pb.dart';
import '../../../protobuf/empty.pb.dart' as google$protobuf;
import 'debugger.pbjson.dart';

export 'debugger.pb.dart';

abstract class Debugger2ServiceBase extends GeneratedService {
  Future<SetBreakpointResponse> setBreakpoint(ServerContext ctx, SetBreakpointRequest request);
  Future<GetBreakpointResponse> getBreakpoint(ServerContext ctx, GetBreakpointRequest request);
  Future<google$protobuf.Empty> deleteBreakpoint(ServerContext ctx, DeleteBreakpointRequest request);
  Future<ListBreakpointsResponse> listBreakpoints(ServerContext ctx, ListBreakpointsRequest request);
  Future<ListDebuggeesResponse> listDebuggees(ServerContext ctx, ListDebuggeesRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'SetBreakpoint': return new SetBreakpointRequest();
      case 'GetBreakpoint': return new GetBreakpointRequest();
      case 'DeleteBreakpoint': return new DeleteBreakpointRequest();
      case 'ListBreakpoints': return new ListBreakpointsRequest();
      case 'ListDebuggees': return new ListDebuggeesRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'SetBreakpoint': return this.setBreakpoint(ctx, request);
      case 'GetBreakpoint': return this.getBreakpoint(ctx, request);
      case 'DeleteBreakpoint': return this.deleteBreakpoint(ctx, request);
      case 'ListBreakpoints': return this.listBreakpoints(ctx, request);
      case 'ListDebuggees': return this.listDebuggees(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => Debugger2$json;
  Map<String, dynamic> get $messageJson => Debugger2$messageJson;
}

