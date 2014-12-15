// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library datastore_v3_service;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

import '../../api/errors.dart';
import 'rpc/rpc_service.dart';
import 'internal/api_base.pb.dart';
import 'internal/datastore_v3.pb.dart';

class DataStoreV3ServiceClientRPCStub {
  final RPCService _rpcService;
  final String _ticket;

  DataStoreV3ServiceClientRPCStub(this._rpcService, this._ticket);

  Future<GetResponse> Get(GetRequest request) {
    return _rpcService.call(
        'datastore_v3', 'Get', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new GetResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<PutResponse> Put(PutRequest request) {
    return _rpcService.call(
        'datastore_v3', 'Put', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new PutResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<TouchResponse> Touch(TouchRequest request) {
    return _rpcService.call(
        'datastore_v3', 'Touch', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new TouchResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<DeleteResponse> Delete(DeleteRequest request) {
    return _rpcService.call(
        'datastore_v3', 'Delete', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new DeleteResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }


  Future<QueryResult> RunQuery(Query request) {
    return _rpcService.call(
        'datastore_v3', 'RunQuery', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new QueryResult.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }


  Future<AddActionsResponse> AddActions(AddActionsRequest request) {
    return _rpcService.call(
        'datastore_v3', 'AddActions', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new AddActionsResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<QueryResult> Next(NextRequest request) {
    return _rpcService.call(
        'datastore_v3', 'Next', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new QueryResult.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<VoidProto> DeleteCursor(Cursor request) {
    return _rpcService.call('datastore_v3',
                            'DeleteCursor',
                            request.writeToBuffer(),
                            ticket: _ticket)
        .then((List<int> response) {
      try {
        return new VoidProto.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }


  Future<Transaction> BeginTransaction(BeginTransactionRequest request) {
    return _rpcService.call('datastore_v3',
                            'BeginTransaction',
                            request.writeToBuffer(),
                            ticket: _ticket)
        .then((List<int> response) {
      try {
        return new Transaction.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<CommitResponse> Commit(Transaction request) {
    return _rpcService.call(
        'datastore_v3', 'Commit', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new CommitResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<VoidProto> Rollback(Transaction request) {
    return _rpcService.call(
        'datastore_v3', 'Rollback', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new VoidProto.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }


  Future<AllocateIdsResponse> AllocateIds(AllocateIdsRequest request) {
    return _rpcService.call(
        'datastore_v3', 'AllocateIds', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new AllocateIdsResponse.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }


  Future<VoidProto> CreateIndex(CompositeIndex request) {
    return _rpcService.call(
        'datastore_v3', 'CreateIndex', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new VoidProto.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<VoidProto> UpdateIndex(CompositeIndex request) {
    return _rpcService.call(
        'datastore_v3', 'UpdateIndex', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new VoidProto.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<CompositeIndices> GetIndices(StringProto request) {
    return _rpcService.call(
        'datastore_v3', 'GetIndices', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new CompositeIndices.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }

  Future<VoidProto> DeleteIndex(CompositeIndex request) {
    return _rpcService.call(
        'datastore_v3', 'DeleteIndex', request.writeToBuffer(), ticket: _ticket)
        .then((List<int> response) {
      try {
        return new VoidProto.fromBuffer(response);
      } on InvalidProtocolBufferException catch (error) {
        throw ProtocolError.INVALID_RESPONSE;
      }
    });
  }
}
