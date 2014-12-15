// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:unittest/unittest.dart';

import 'package:appengine/api/errors.dart';
import 'package:appengine/src/appengine_context.dart';
import 'package:appengine/src/api_impl/raw_datastore_v3_impl.dart';
import 'package:appengine/src/protobuf_api/rpc/rpc_service.dart';
import 'package:appengine/src/protobuf_api/internal/datastore_v3.pb.dart';
import 'package:gcloud/datastore.dart' as raw;

import 'utils/mock_rpc.dart';
import 'utils/error_matchers.dart';
import 'utils/raw_datastore_test_utils.dart';

void runTests() {
  const INVALID_PROTOBUF = const [1, 2, 3, 4, 5];

  group('raw_datastore_v3_error_handling', () {
    var unnamedKeys5 = buildKeys(1, 6);
    var context = new AppengineContext(
        'dev', 'application', 'version', null, null, null);

    var transactionAbortedError = new RpcApplicationError(
        Error_ErrorCode.CONCURRENT_TRANSACTION.value, 'foobar');
    var needIndexError = new RpcApplicationError(
        Error_ErrorCode.NEED_INDEX.value, 'foobar');
    var timeoutError = new RpcApplicationError(
        Error_ErrorCode.TIMEOUT.value, 'foobar');

    buildMock(methodName, requestType, callback) {
      var mock = new MockRPCService('datastore_v3');
      mock.register(methodName, requestType, callback);
      return mock;
    }

    buildDatastore(mock) {
      return new DatastoreV3RpcImpl(mock, context, 'invalid-ticket');
    }

    group('allocateIds', () {
      test('network_error', () {
        var mock = buildMock('AllocateIds', AllocateIdsRequest,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.allocateIds(unnamedKeys5), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('AllocateIds', AllocateIdsRequest,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.allocateIds(unnamedKeys5), throwsA(isProtocolError));
      });
    });

    group('beginTransaction', () {
      test('network_error', () {
        var mock = buildMock('BeginTransaction', BeginTransactionRequest,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.beginTransaction(), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('BeginTransaction', BeginTransactionRequest,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.beginTransaction(), throwsA(isProtocolError));
      });
    });

    group('commit', () {
      var e = new raw.Entity(buildKey(1, idFunction: (i) => "$i"), {});

      test('network_error', () {
        var mock = buildMock('Put', PutRequest,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.commit(inserts: [e]), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('Put', PutRequest,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.commit(inserts: [e]), throwsA(isProtocolError));
      });

      test('transaction_aborted', () {
        var mock = buildMock('Put', PutRequest,
            (request) => new Future.error(transactionAbortedError));
        var datastore = buildDatastore(mock);
        expect(datastore.commit(inserts: [e]),
               throwsA(isTransactionAbortedError));
      });
    });

    group('rollback', () {
      var rpcTransaction = new Transaction();
      rpcTransaction.handle = new Int64(10);
      var transaction = new TransactionImpl(rpcTransaction);

      test('network_error', () {
        var mock = buildMock('Rollback', Transaction,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.rollback(transaction), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('Rollback', Transaction,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.rollback(transaction), throwsA(isProtocolError));
      });
    });

    group('lookup', () {
      var key = buildKey(1, idFunction: (i) => "$i");

      test('network_error', () {
        var mock = buildMock('Get', GetRequest,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.lookup([key]), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('Get', GetRequest,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.lookup([key]), throwsA(isProtocolError));
      });

      test('timeout_error', () {
        var mock = buildMock('Get', GetRequest,
            (request) => new Future.error(timeoutError));
        var datastore = buildDatastore(mock);
        expect(datastore.lookup([key]), throwsA(isTimeoutError));
      });
    });

    group('query', () {
      var query = new raw.Query(kind: 'TestKind');

      test('network_error', () {
        var mock = buildMock('RunQuery', Query,
            (request) => new Future.error(new NetworkError("")));
        var datastore = buildDatastore(mock);
        expect(datastore.query(query), throwsA(isNetworkError));
      });

      test('protocol_error', () {
        var mock = buildMock('RunQuery', Query,
            (request) => new Future.value(INVALID_PROTOBUF));
        var datastore = buildDatastore(mock);
        expect(datastore.query(query), throwsA(isProtocolError));
      });

      test('need_index_error', () {
        var mock = buildMock('RunQuery', Query,
            (request) => new Future.error(needIndexError));
        var datastore = buildDatastore(mock);
        expect(datastore.query(query), throwsA(isNeedIndexError));
      });
    });
  });
}

main() {
  runTests();
}
