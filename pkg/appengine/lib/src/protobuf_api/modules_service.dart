// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library modules_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/errors.dart';
import '../protobuf_api/internal/modules_service.pb.dart' as pb;
import 'rpc/rpc_service.dart';

class ModulesServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  ModulesServiceClientRPCStub(this._rpcService, this._ticket);

  Future<pb.GetDefaultVersionResponse>
  GetDefaultVersion(pb.GetDefaultVersionRequest request) {
    return _rpcService.call('modules', 'GetDefaultVersion',
                            request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.GetDefaultVersionResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.GetModulesResponse>
  GetModules(pb.GetModulesRequest request) {
    return _rpcService.call(
        'modules', 'GetModules', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.GetModulesResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.GetVersionsResponse>
  GetVersions(pb.GetVersionsRequest request) {
    return _rpcService.call(
        'modules', 'GetVersions', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.GetVersionsResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.GetHostnameResponse>
  GetHostname(pb.GetHostnameRequest request) {
    return _rpcService.call(
        'modules', 'GetHostname', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.GetHostnameResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }
}
