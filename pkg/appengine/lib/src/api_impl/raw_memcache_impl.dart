// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache_raw_impl;

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:memcache/memcache_raw.dart' as raw;

import '../../api/errors.dart';
import '../protobuf_api/rpc/rpc_service.dart';
import '../protobuf_api/internal/memcache_service.pb.dart' as pb;
import '../protobuf_api/memcache_service.dart';

class RawMemcacheRpcImpl implements raw.RawMemcache {
  final MemcacheServiceClientRPCStub _clientRPCStub;

  RawMemcacheRpcImpl(RPCService rpcService, String ticket)
      : _clientRPCStub = new MemcacheServiceClientRPCStub(rpcService, ticket);

  bool _sameKey(a, b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<List<raw.GetResult>> get(List<raw.GetOperation> batch) {
    var request = new pb.MemcacheGetRequest();
    batch.forEach((operation) => request.key.add(operation.key));
    return _clientRPCStub.Get(request).then((pb.MemcacheGetResponse response) {
      if (response.item.length > request.key.length) {
        throw ProtocolError.INVALID_RESPONSE;
      }
      // The response from the memcache service only have the items which
      // where actually found. In most cases the items found are returned
      // in the same order as the keys in the request. The loop below is
      // optimized for this case to degenerate into linear time by remembering
      // the last index.
      var result = [];
      int responseItemIdx = 0;
      int remaining = response.item.length;
      for (int i = 0; i < batch.length; i++) {
        bool found = false;
        for (int j = 0;
             remaining > 0 && !found && j < response.item.length;
             j++) {
          if (_sameKey(batch[i].key, response.item[responseItemIdx].key)) {
            // Value found for key.
            result.add(new raw.GetResult(
                raw.Status.NO_ERROR,
                null,
                response.item[responseItemIdx].flags,
                null,
                response.item[responseItemIdx].value));
            found = true;
            remaining--;
          }
          responseItemIdx = (responseItemIdx + 1) % response.item.length;
        }
        if (!found) {
          // This key had no value found.
          result.add(new raw.GetResult(raw.Status.KEY_NOT_FOUND,
                                       null,
                                       0,
                                       null,
                                       null));
        }
      }
      return result;
    });
  }

  Future<List<raw.SetResult>> set(List<raw.SetOperation> batch) {
    var request = new pb.MemcacheSetRequest();
    batch.forEach((operation) {
      var item = new pb.MemcacheSetRequest_Item();
      item.key = operation.key;
      item.value = operation.value;
      switch (operation.operation) {
        case raw.SetOperation.SET:
          item.setPolicy = pb.MemcacheSetRequest_SetPolicy.SET;
          break;
        case raw.SetOperation.ADD:
          item.setPolicy = pb.MemcacheSetRequest_SetPolicy.ADD;
          break;
        case raw.SetOperation.REPLACE:
          item.setPolicy = pb.MemcacheSetRequest_SetPolicy.REPLACE;
          break;
        default:
          throw new UnsupportedError('Unsupported set operation $operation');
      }
      request.item.add(item);
    });
    return _clientRPCStub.Set(request).then((pb.MemcacheSetResponse response) {
      if (response.setStatus.length != request.item.length) {
        throw ProtocolError.INVALID_RESPONSE;
      }
      var result = [];
      response.setStatus.forEach((status) {
        switch (status) {
          case pb.MemcacheSetResponse_SetStatusCode.STORED:
            result.add(new raw.SetResult(raw.Status.NO_ERROR, null));
            break;
          case pb.MemcacheSetResponse_SetStatusCode.NOT_STORED:
            result.add(new raw.SetResult(raw.Status.NOT_STORED, null));
            break;
          case pb.MemcacheSetResponse_SetStatusCode.EXISTS:
            result.add(new raw.SetResult(raw.Status.KEY_EXISTS, null));
            break;
          case pb.MemcacheSetResponse_SetStatusCode.ERROR:
            result.add(new raw.SetResult(raw.Status.ERROR, null));
            break;
          default:
            throw new UnsupportedError('Unsupported set status $status');
        }
      });
      return result;
    });
  }

  Future<List<raw.RemoveResult>> remove(List<raw.RemoveOperation> batch) {
    var request = new pb.MemcacheDeleteRequest();
    batch.forEach((operation) {
      var item = new pb.MemcacheDeleteRequest_Item();
      item.key = operation.key;
      request.item.add(item);
    });
    return _clientRPCStub.Delete(request)
        .then((pb.MemcacheDeleteResponse response) {
          var result = [];
          response.deleteStatus.forEach((status) {
            if (status == pb.MemcacheDeleteResponse_DeleteStatusCode.DELETED) {
              result.add(
                  new raw.RemoveResult(raw.Status.NO_ERROR, null));
            } else if (status ==
                       pb.MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND) {
              result.add(
                  new raw.RemoveResult(raw.Status.KEY_NOT_FOUND, null));
            } else {
              throw new UnsupportedError('Unsupported delete status $status');
            }
          });
          return result;
    });
  }

  Future<List<raw.IncrementResult>> increment(
      List<raw.IncrementOperation> batch) {
    if (batch.length == 1) {
      var request = new pb.MemcacheIncrementRequest();
      request.key = batch[0].key;
      request.delta = new Int64(batch[0].delta);
      request.direction =
          batch[0].direction == raw.IncrementOperation.INCREMENT
              ? pb.MemcacheIncrementRequest_Direction.INCREMENT
              : pb.MemcacheIncrementRequest_Direction.DECREMENT;
      request.initialValue = new Int64(batch[0].initialValue);
      return _clientRPCStub.Increment(request)
          .then((pb.MemcacheIncrementResponse response) {
            raw.Status status;
            String message;
            switch (response.incrementStatus) {
              case pb.MemcacheIncrementResponse_IncrementStatusCode.OK:
                status = raw.Status.NO_ERROR;
                break;
              case pb.MemcacheIncrementResponse_IncrementStatusCode.NOT_CHANGED:
                status = raw.Status.NO_ERROR;
                break;
              case pb.MemcacheIncrementResponse_IncrementStatusCode.ERROR:
                status = raw.Status.ERROR;
                message = 'Increment failed';
                break;
              default:
                throw new UnsupportedError(
                    'Unsupported increment status ${response.incrementStatus}');
            }
            int newValue = response.newValue.toInt();
            if (newValue < 0) newValue = 0x10000000000000000 + newValue;
            var result = new raw.IncrementResult(status, message, newValue);
            return [result];
      });
    } else {
      throw new UnsupportedError('Unsupported batch increment');
    }
  }

  Future clear() {
    var request = new pb.MemcacheFlushRequest();

    return _clientRPCStub.FlushAll(request).then((_) => null);
  }
}
