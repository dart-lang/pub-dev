// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/errors.dart';
import 'rpc/rpc_service.dart';
import 'internal/memcache_service.pb.dart';

class MemcacheServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  MemcacheServiceClientRPCStub(this._rpcService, this._ticket);

  Future<MemcacheGetResponse> Get(MemcacheGetRequest request) {
    return _rpcService.call('memcache', 'Get', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
          try {
            return new MemcacheGetResponse.fromBuffer(response);
          } on InvalidProtocolBufferException catch (error) {
            throw ProtocolError.INVALID_RESPONSE;
          }
    });
  }

  Future<MemcacheSetResponse> Set(MemcacheSetRequest request) {
    return _rpcService.call('memcache', 'Set', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheSetResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheDeleteResponse> Delete(MemcacheDeleteRequest request) {
    return _rpcService.call('memcache', 'Delete', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheDeleteResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheIncrementResponse> Increment(MemcacheIncrementRequest request) {
    return _rpcService.call('memcache', 'Increment', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheIncrementResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheBatchIncrementResponse> BatchIncrement(
      MemcacheBatchIncrementRequest request) {
    return _rpcService.call('memcache', 'BatchIncrement', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheBatchIncrementResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheFlushResponse> FlushAll(MemcacheFlushRequest request) {
    return _rpcService.call('memcache', 'FlushAll', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheFlushResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheStatsResponse> Stats(MemcacheStatsRequest request) {
    return _rpcService.call('memcache', 'Stats', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheStatsResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<MemcacheGrabTailResponse> GrabTail(MemcacheGrabTailRequest request) {
    return _rpcService.call('memcache', 'GrabTail', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new MemcacheGrabTailResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }
}
