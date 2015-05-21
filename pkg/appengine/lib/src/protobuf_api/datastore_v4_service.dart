// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library datastore_v4_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/errors.dart';
import 'rpc/rpc_service.dart';
import 'internal/datastore_v4.pb.dart';

class DataStoreV4ServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  DataStoreV4ServiceClientRPCStub(this._rpcService, this._ticket);

  Future<BeginTransactionResponse>
  BeginTransaction(BeginTransactionRequest request) {
    return _rpcService.call('datastore_v4',
                            'BeginTransaction',
                            request.writeToBuffer(),
                            ticket: _ticket)
        .then((List<int> response) {
      try {
        return new BeginTransactionResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<RollbackResponse> Rollback(RollbackRequest request) {
    return _rpcService.call(
        'datastore_v4', 'Rollback', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new RollbackResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<CommitResponse> Commit(CommitRequest request) {
    return _rpcService.call(
        'datastore_v4', 'Commit', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new CommitResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<RunQueryResponse> RunQuery(RunQueryRequest request) {
    return _rpcService.call(
        'datastore_v4', 'RunQuery', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new RunQueryResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<ContinueQueryResponse> ContinueQuery(ContinueQueryRequest request) {
    return _rpcService.call('datastore_v4',
                            'ContinueQuery',
                            request.writeToBuffer(),
                            ticket: _ticket)
        .then((List<int> response) {
      try {
        return new ContinueQueryResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<LookupResponse> Lookup(LookupRequest request) {
    return _rpcService.call(
        'datastore_v4', 'Lookup', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new LookupResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<AllocateIdsResponse> AllocateIds(AllocateIdsRequest request) {
    return _rpcService.call(
        'datastore_v4', 'AllocateIds', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new AllocateIdsResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }
}
