// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.logging_impl;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:appengine/api/logging.dart';

import '../protobuf_api/rpc/rpc_service.dart';
import '../protobuf_api/logging_service.dart';
import '../protobuf_api/internal/log_service.pb.dart' as pb;

class LoggingRpcImpl extends Logging {
  final LoggingServiceClientRPCStub _clientRPCStub;
  final List<pb.UserAppLogLine> _logLines = <pb.UserAppLogLine>[];

  LoggingRpcImpl(RPCService rpcService, String ticket)
      : _clientRPCStub = new LoggingServiceClientRPCStub(rpcService, ticket);

  void log(LogLevel level, String message, {DateTime timestamp}) {
    if (timestamp == null) {
      timestamp = new DateTime.now();
    }

    // Issue 15747158.
    print('$timestamp: ApplicationLog | $level: ${message.trim()}');

    _logLines.add(_createLogLine(level, message, timestamp));
  }

  pb.UserAppLogLine _createLogLine(
      LogLevel level, String message, DateTime timestamp) {
    var timestampUsec = timestamp.toUtc().millisecondsSinceEpoch * 1000;
    return new pb.UserAppLogLine()
        ..timestampUsec = new Int64(timestampUsec)
        ..level = new Int64(level.level)
        ..message = message;
  }

  Future flush() {
    if (_logLines.isEmpty) {
      return new Future.value();
    }

    var group = new pb.UserAppLogGroup();
    group.logLine.addAll(_logLines);
    _logLines.clear();

    var request = new pb.FlushRequest()
        ..logs = group.writeToBuffer();

    // NOTE: We swallow errors here to prevent clients sending error messages
    // using the logging service -- which would create an infinite error loop.
    // TODO: We could introduce a local logging mechanism in the future which
    // we could use to report such errors.
    return _clientRPCStub.Flush(request).catchError((_) {}).then((_) => null);
  }
}
