// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:appengine/api/errors.dart';
import 'package:appengine/src/api_impl/raw_memcache_impl.dart';
import 'package:appengine/src/protobuf_api/internal/memcache_service.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:memcache/src/memcache_impl.dart';
import 'package:unittest/unittest.dart';

import 'utils/mock_rpc.dart';
import 'utils/error_matchers.dart';

main() {
  const INVALID_PROTOBUF = const [1, 2, 3, 4, 5];

  group('memcache', () {
    test('set', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.set('language', 'dart'), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.set('language', 'dart'), throwsA(isProtocolError));

      // Tests status error returned from memcache service.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.ERROR);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.set('language', 'dart'), throwsA(isMemcacheError));

      // Tests not stored.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        expect(request.item[0].key, equals(UTF8.encode('language')));
        expect(request.item[0].value, equals(UTF8.encode('dart')));

        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.NOT_STORED);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.set('language', 'dart'), throwsA(isMemcacheNotStored));

      // Tests sucessfull store
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        expect(request.item[0].key, equals(UTF8.encode('language')));
        expect(request.item[0].value, equals(UTF8.encode('dart')));

        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        return new Future.value(response.writeToBuffer());
      }));

      expect(memcache.set('language', 'dart'), completes);
    });

    var setAllMap = {
      'language': 'dart',
       UTF8.encode('language'): 'dart',
       [1, 2, 3]: UTF8.encode('dart'),
    };
    var setAllKeys =
        [UTF8.encode('language'), UTF8.encode('language'), [1, 2, 3]];
    var setAllValues =
        [UTF8.encode('dart'), UTF8.encode('dart'), UTF8.encode('dart')];

    checkSetAllRequest(request, setPolicy) {
      expect(request.item.length, setAllKeys.length);
      for (var i = 0; i < setAllKeys.length; i++) {
        expect(request.item[i].setPolicy, setPolicy);
        expect(request.item[i].key, setAllKeys[i]);
        expect(request.item[i].value, setAllValues[i]);
      }
    }

    test('setAll', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.setAll(setAllMap), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.setAll(setAllMap), throwsA(isProtocolError));

      // Tests status error returned from memcache service.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.ERROR);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.setAll(setAllMap), throwsA(isMemcacheError));

      // Tests not stored.
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        checkSetAllRequest(request, MemcacheSetRequest_SetPolicy.SET);

        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.NOT_STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.setAll(setAllMap), throwsA(isMemcacheNotStored));

      // Tests sucessfull store
      mock.register('Set', MemcacheSetRequest, expectAsync((request) {
        checkSetAllRequest(request, MemcacheSetRequest_SetPolicy.SET);

        var response = new MemcacheSetResponse();
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        response.setStatus.add(MemcacheSetResponse_SetStatusCode.STORED);
        return new Future.value(response.writeToBuffer());
      }));

      expect(memcache.setAll(setAllMap), completes);
    });

    test('get', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.get('language'), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.get('language'), throwsA(isProtocolError));

      // Tests key not found.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        var response = new MemcacheGetResponse();
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.get('language'), completion(isNull));

      // Tests sucessfull get
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        var response = new MemcacheGetResponse();
        var item = new MemcacheGetResponse_Item();
        item.key = UTF8.encode('language');
        item.value = UTF8.encode('dart');
        response.item.add(item);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.get('language'), completion('dart'));
    });

    test('getAll', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      var key1 = 'language';
      var key2 = UTF8.encode('language');
      var key3 = [1, 2, 3];
      var keys = [key1, key2, key3];
      var nothing = {key1: null, key2: null, key3: null};
      var success = {key1: 'dart', key2: 'dart', key3: null};

      // Tests NetworkError.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.getAll(keys), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.getAll(keys), throwsA(isProtocolError));

      // Tests key not found.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        var response = new MemcacheGetResponse();
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.getAll(keys), completion(nothing));

      // Tests sucessfull get.
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        expect(request.key.length, 3);
        expect(request.key[0], key2);  // Key2 is the UTF-8 encoding of key1.
        expect(request.key[1], key2);
        expect(request.key[2], key3);
        var response = new MemcacheGetResponse();
        var item1 = new MemcacheGetResponse_Item();
        item1.key = key2;  // Key2 is the UTF-8 encoding of key1
        item1.value = UTF8.encode('dart');
        response.item.add(item1);
        var item2 = new MemcacheGetResponse_Item();
        item2.key = key2;
        item2.value = UTF8.encode('dart');
        response.item.add(item2);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.getAll(keys), completion(success));

      // Tests sucessfull get with different ordered response.
      // The result of getAll should be ordered with respect to the
      // passed in keys.
      var successWithLast = {key1: 'dart', key2: 'dart', key3: 'lastElement'};
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        expect(request.key.length, 3);
        expect(request.key[0], key2);  // Key2 is the UTF-8 encoding of key1.
        expect(request.key[1], key2);
        expect(request.key[2], key3);
        // Create a response where the resulting keys are in different order.
        var response = new MemcacheGetResponse();
        var item1 = new MemcacheGetResponse_Item();
        item1.key = key3;
        item1.value = UTF8.encode('lastElement');
        response.item.add(item1);
        var item2 = new MemcacheGetResponse_Item();
        item2.key = key2;
        item2.value = UTF8.encode('dart');
        response.item.add(item2);
        var item3 = new MemcacheGetResponse_Item();
        item3.key = key2; // key2 is the UTF-8 encoding of key1.
        item3.value = UTF8.encode('dart');
        response.item.add(item3);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.getAll(keys), completion(successWithLast));

      // Tests sucessfull get with single value response for two keys.
      // The result of getAll should be ordered with respect to the
      // passed in keys.
      var twoKeys = [key3, key1];
      var successWithOne = {key3: null, key1: 'dart'};
      mock.register('Get', MemcacheGetRequest, expectAsync((request) {
        expect(request.key.length, 2);
        expect(request.key[0], key3);
        expect(request.key[1], key2);  // Key2 is the UTF-8 encoding of key1.
        // Create a response with only key1 (aka. key2) having a value.
        var response = new MemcacheGetResponse();
        var item1 = new MemcacheGetResponse_Item();
        item1.key = key2; // key is the UTF-8 encoding of key1.
        item1.value = UTF8.encode('dart');
        response.item.add(item1);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.getAll(twoKeys), completion(successWithOne));
    });

    test('remove', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.remove('language'), throwsA(isNetworkError));

      // Tests ProtocolError
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.remove('language'), throwsA(isProtocolError));

      // Tests not found
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        var response = new MemcacheDeleteResponse();
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.remove('language'), completes);

      // Tests sucessfull delete
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        var response = new MemcacheDeleteResponse();
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.DELETED);
        return new Future.value(response.writeToBuffer());
      }));

      expect(memcache.remove('language'), completes);
    });

    test('removeAll', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      var key1 = 'language';
      var key2 = UTF8.encode('language');
      var key3 = [1, 2, 3];
      var keys = [key1, key2, key3];

      // Tests NetworkError.
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.removeAll(keys), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.removeAll(keys), throwsA(isProtocolError));

      // Tests invalid response.
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        var response = new MemcacheDeleteResponse();
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.removeAll(keys), throwsA(isMemcacheError));

      // Tests not found.
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        expect(request.item.length, 3);
        // Key2 is the UTF-8 encoding of key1.
        expect(request.item[0].key, key2);
        expect(request.item[1].key, key2);
        expect(request.item[2].key, key3);

        var response = new MemcacheDeleteResponse();
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND);
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND);
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.NOT_FOUND);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.removeAll(keys), completes);

      // Tests sucessfull delete.
      mock.register('Delete', MemcacheDeleteRequest, expectAsync((request) {
        expect(request.item.length, 3);
        // Key2 is the UTF-8 encoding of key1.
        expect(request.item[0].key, key2);
        expect(request.item[1].key, key2);
        expect(request.item[2].key, key3);

        var response = new MemcacheDeleteResponse();
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.DELETED);
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.DELETED);
        response.deleteStatus.add(
            MemcacheDeleteResponse_DeleteStatusCode.DELETED);
        return new Future.value(response.writeToBuffer());
      }));

      expect(memcache.removeAll(keys), completes);
    });

    test('increment', () {
      var key1 = 'increment';
      var key2 = UTF8.encode(key1);

      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests sucessfull increment.
      mock.register(
          'Increment', MemcacheIncrementRequest, expectAsync((request) {
        expect(request.key, key2);
        expect(request.delta.toInt(), 1);
        expect(request.direction, MemcacheIncrementRequest_Direction.INCREMENT);
        expect(request.initialValue.toInt(), 0);
        expect(request.initialFlags, 0);

        var response = new MemcacheIncrementResponse();
        response.incrementStatus =
            MemcacheIncrementResponse_IncrementStatusCode.OK;
        response.newValue = new Int64(42);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.increment(key1), completion(42));
    });

    test('decrement', () {
      var key1 = 'decrement';
      var key2 = UTF8.encode(key1);

      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests sucessfull decrement.
      mock.register(
          'Increment', MemcacheIncrementRequest, expectAsync((request) {
        expect(request.key, key2);
        expect(request.delta.toInt(), 1);
        expect(request.direction, MemcacheIncrementRequest_Direction.DECREMENT);
        expect(request.initialValue.toInt(), 0);
        expect(request.initialFlags, 0);

        var response = new MemcacheIncrementResponse();
        response.incrementStatus =
            MemcacheIncrementResponse_IncrementStatusCode.OK;
        response.newValue = new Int64(42);
        return new Future.value(response.writeToBuffer());
      }));
      expect(memcache.decrement(key1), completion(42));
    });

    test('increment-decrement-errors', () {
      var key1 = 'key';
      var key2 = UTF8.encode(key1);

      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError.
      mock.register(
          'Increment', MemcacheIncrementRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }, count: 2));
      expect(memcache.increment(key1), throwsA(isNetworkError));
      expect(memcache.decrement(key1), throwsA(isNetworkError));

      // Tests ProtocolError.
      mock.register(
          'Increment', MemcacheIncrementRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
            }, count: 2));
      expect(memcache.increment(key1), throwsA(isProtocolError));
      expect(memcache.decrement(key1), throwsA(isProtocolError));

      // Tests error response.
      mock.register(
          'Increment', MemcacheIncrementRequest, expectAsync((request) {
        var response = new MemcacheIncrementResponse();
        response.incrementStatus =
            MemcacheIncrementResponse_IncrementStatusCode.ERROR;
        return new Future.value(response.writeToBuffer());
      }, count: 2));
      expect(memcache.increment(key1), throwsA(isMemcacheError));
      expect(memcache.decrement(key1), throwsA(isMemcacheError));
    });

    test('clear', () {
      var mock = new MockRPCService('memcache');
      var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(mock, ''));

      // Tests NetworkError
      mock.register('FlushAll', MemcacheFlushRequest, expectAsync((request) {
        return new Future.error(new NetworkError(""));
      }));
      expect(memcache.clear(), throwsA(isNetworkError));

      // Tests ProtocolError
      mock.register('FlushAll', MemcacheFlushRequest, expectAsync((request) {
        return new Future.value(INVALID_PROTOBUF);
      }));
      expect(memcache.clear(), throwsA(isProtocolError));

      // Tests sucessfull clear
      mock.register('FlushAll', MemcacheFlushRequest, expectAsync((request) {
        return new Future.value(new MemcacheFlushResponse().writeToBuffer());
      }));

      expect(memcache.clear(), completes);
    });
  });
}
