// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library user_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/errors.dart';
import '../protobuf_api/internal/user_service.pb.dart' as pb;
import 'rpc/rpc_service.dart';

class UserServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  UserServiceClientRPCStub(this._rpcService, this._ticket);

  Future<pb.CreateLoginURLResponse>
  CreateLoginURL(pb.CreateLoginURLRequest request) {
    return _rpcService.call(
        'user', 'CreateLoginURL', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.CreateLoginURLResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.CreateLogoutURLResponse>
  CreateLogoutURL(pb.CreateLogoutURLRequest request) {
    return _rpcService.call(
        'user', 'CreateLogoutURL', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.CreateLogoutURLResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.GetOAuthUserResponse>
  GetOAuthUser(pb.GetOAuthUserRequest request) {
    return _rpcService.call(
        'user', 'GetOAuthUser', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.GetOAuthUserResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<pb.CheckOAuthSignatureResponse>
  CheckOAuthSignature(pb.CheckOAuthSignatureRequest request) {
    return _rpcService.call(
        'user', 'CheckOAuthSignature', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new pb.CheckOAuthSignatureResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }
}
