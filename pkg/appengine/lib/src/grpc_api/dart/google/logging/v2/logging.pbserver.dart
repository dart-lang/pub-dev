///
//  Generated code. Do not modify.
///
library google.logging.v2_logging_pbserver;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'logging.pb.dart';
import '../../protobuf/empty.pb.dart' as google$protobuf;
import 'logging.pbjson.dart';

export 'logging.pb.dart';

abstract class LoggingServiceV2ServiceBase extends GeneratedService {
  Future<google$protobuf.Empty> deleteLog(ServerContext ctx, DeleteLogRequest request);
  Future<WriteLogEntriesResponse> writeLogEntries(ServerContext ctx, WriteLogEntriesRequest request);
  Future<ListLogEntriesResponse> listLogEntries(ServerContext ctx, ListLogEntriesRequest request);
  Future<ListMonitoredResourceDescriptorsResponse> listMonitoredResourceDescriptors(ServerContext ctx, ListMonitoredResourceDescriptorsRequest request);
  Future<ListLogsResponse> listLogs(ServerContext ctx, ListLogsRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'DeleteLog': return new DeleteLogRequest();
      case 'WriteLogEntries': return new WriteLogEntriesRequest();
      case 'ListLogEntries': return new ListLogEntriesRequest();
      case 'ListMonitoredResourceDescriptors': return new ListMonitoredResourceDescriptorsRequest();
      case 'ListLogs': return new ListLogsRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'DeleteLog': return this.deleteLog(ctx, request);
      case 'WriteLogEntries': return this.writeLogEntries(ctx, request);
      case 'ListLogEntries': return this.listLogEntries(ctx, request);
      case 'ListMonitoredResourceDescriptors': return this.listMonitoredResourceDescriptors(ctx, request);
      case 'ListLogs': return this.listLogs(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => LoggingServiceV2$json;
  Map<String, dynamic> get $messageJson => LoggingServiceV2$messageJson;
}

