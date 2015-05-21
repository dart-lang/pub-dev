// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library logging_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import 'internal/api_base.pb.dart';
import 'internal/log_service.pb.dart' as pb;
import 'rpc/rpc_service.dart';
import '../../api/errors.dart' as errors;

class LoggingServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  LoggingServiceClientRPCStub(this._rpcService, this._ticket);

  Future<VoidProto> Flush(pb.FlushRequest request) {
    return _rpcService.call(
        'logservice', 'Flush', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new VoidProto.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw errors.ProtocolError.INVALID_RESPONSE;
          }
    });
  }
}
