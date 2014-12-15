// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library memcache_test;

import 'package:unittest/unittest.dart';
import 'package:memcache/memcache.dart';

import 'package:appengine/src/protobuf_api/rpc/rpc_service_remote_api.dart';
import 'package:appengine/src/api_impl/raw_memcache_impl.dart';
import 'package:memcache/src/memcache_impl.dart';

import '../../utils/error_matchers.dart';

main() {
  var rpcService = new RPCServiceRemoteApi('127.0.0.1', 4444);
  var memcache = new MemCacheImpl(new RawMemcacheRpcImpl(rpcService, ''));

  group('memcache', () {
    setUp(() => memcache.clear());

    test('get-set-get', () {
      memcache.get([1]).then(expectAsync((value) {
        expect(value, isNull);
        memcache.set('ABC', 'abc').then(expectAsync((value) {
          expect(value, isNull);
          memcache.get('ABC').then(expectAsync((value) {
            expect(value, 'abc');
          }));
        }));
      }));
    });

    test('get-add-replace', () {
      memcache.get([1]).then(expectAsync((value) {
        expect(value, isNull);
        memcache.set('ABC', 'abc').then(expectAsync((value) {
          expect(value, isNull);
          memcache.get('ABC').then(expectAsync((value) {
            expect(value, 'abc');
            memcache.set('ABC', 'ABC',
                         action: SetAction.REPLACE).then(expectAsync((value) {
              expect(value, isNull);
              memcache.get('ABC').then(expectAsync((value) {
                expect(value, 'ABC');
              }));
            }));
          }));
        }));
      }));
    });

    test('error-replace', () {
      memcache.get('A').then(expectAsync((value) {
        expect(value, isNull);
        expect(memcache.set('A', 'ABC', action: SetAction.REPLACE),
               throwsA(isMemcacheNotStored));
      }));
    });

    test('error-add', () {
      memcache.get('A').then(expectAsync((value) {
        expect(value, isNull);
        memcache.set('A', 'ABC').then(expectAsync((value) {
          expect(value, isNull);
          expect(memcache.set('A', 'ABC', action: SetAction.ADD),
                 throwsA(isMemcacheNotStored));
        }));
      }));
    });

    test('all-get-set-get', () {
      memcache.getAll(['A', 'B']).then(expectAsync((value) {
        expect(value, {'A': null, 'B': null});
        memcache.setAll({'A': 'ABC', 'B': 'abc'}).then(expectAsync((value) {
          expect(value, isNull);
          memcache.getAll(['A', 'B']).then(expectAsync((value) {
            expect(value, {'A': 'ABC', 'B': 'abc'});
            memcache.setAll({'A': 'abc', 'B': 'ABC'}).then(expectAsync((value) {
              expect(value, isNull);
              memcache.getAll(['A', 'B']).then(expectAsync((value) {
                expect(value, {'A': 'abc', 'B': 'ABC'});
              }));
            }));
          }));
        }));
      }));
    });

    test('all-get-add-replace', () {
      memcache.getAll(['A', 'B']).then(expectAsync((value) {
        expect(value, {'A': null, 'B': null});
        memcache.setAll({'A': 'ABC', 'B': 'abc'},
                        action: SetAction.ADD).then(expectAsync((value) {
          expect(value, isNull);
          memcache.getAll(['A', 'B']).then(expectAsync((value) {
            expect(value, {'A': 'ABC', 'B': 'abc'});
            memcache.setAll(
                {'A': 'abc', 'B': 'ABC'},
                action: SetAction.REPLACE).then(expectAsync((value) {
              expect(value, isNull);
              memcache.getAll(['A', 'B']).then(expectAsync((value) {
                expect(value, {'A': 'abc', 'B': 'ABC'});
              }));
            }));
          }));
        }));
      }));
    });

    test('all-error-replace', () {
      memcache.getAll(['A', 'B']).then(expectAsync((value) {
        expect(value, {'A': null, 'B': null});
        expect(memcache.setAll({'A': 'ABC', 'B': 'abc'},
                               action: SetAction.REPLACE),
               throwsA(isMemcacheNotStored));
      }));
    });

    test('all-error-add', () {
      memcache.getAll(['A', 'B']).then(expectAsync((value) {
        expect(value, {'A': null, 'B': null});
        memcache.setAll({'A': 'ABC', 'B': 'abc'}).then(expectAsync((value) {
          expect(value, isNull);
          expect(memcache.setAll({'A': 'ABC', 'B': 'abc'},
                                 action: SetAction.ADD),
                 throwsA(isMemcacheNotStored));
        }));
      }));
    });

    test('increment-increment', () {
      memcache.increment('A').then(expectAsync((value) {
        expect(value, 1);
        memcache.increment([65]).then(expectAsync((value) {
          expect(value, 2);
        }));
      }));
    });

    test('initial-increment-increment', () {
      memcache.increment('A', initialValue: 2).then(expectAsync((value) {
        expect(value, 3);
        memcache.increment([65], delta: 2).then(expectAsync((value) {
          expect(value, 5);
        }));
      }));
    });

    test('initial-max-increment-wrap-increment', () {
      memcache.increment(
          'A', initialValue: 0xFFFFFFFFFFFFFFFF).then(expectAsync((value) {
        expect(value, 0);
        memcache.increment([65], delta: 2).then(expectAsync((value) {
          expect(value, 2);
        }));
      }));
    });

    test('initial-almost-max-increment-increment-wrap', () {
      memcache.increment(
          'A', initialValue: 0xFFFFFFFFFFFFFFFE).then(expectAsync((value) {
        expect(value, 0xFFFFFFFFFFFFFFFF);
        memcache.increment([65], delta: 2).then(expectAsync((value) {
          expect(value, 1);
        }));
      }));
    });

    test('increment-max-delta-increment-wrap', () {
      memcache.increment(
          'A', delta: 0xFFFFFFFFFFFFFFFF).then(expectAsync((value) {
        expect(value, 0xFFFFFFFFFFFFFFFF);
        memcache.increment([65], delta: 2).then(expectAsync((value) {
          expect(value, 1);
        }));
      }));
    });

    test('decrement-decrement', () {
      memcache.decrement('A').then(expectAsync((value) {
        expect(value, 0);
        memcache.decrement([65]).then(expectAsync((value) {
          expect(value, 0);
        }));
      }));
    });

    test('initial-decrement-decrement', () {
      memcache.decrement('A', initialValue: 3).then(expectAsync((value) {
        expect(value, 2);
        memcache.decrement([65], delta: 2).then(expectAsync((value) {
          expect(value, 0);
        }));
      }));
    });

    test('initial-max-decrement-max-decrement', () {
      memcache.decrement(
          'A',
          delta: 0xFFFFFFFFFFFFFFFF,
          initialValue:  0xFFFFFFFFFFFFFFFF).then(expectAsync((value) {
        expect(value, 0);
        memcache.decrement(
            [65], delta: 0xFFFFFFFFFFFFFFFE).then(expectAsync((value) {
          expect(value, 0);
        }));
      }));
    });

    test('initial-max-decrement-decrement', () {
      memcache.decrement(
          'A', initialValue:  0xFFFFFFFFFFFFFFFF).then(expectAsync((value) {
        expect(value,  0xFFFFFFFFFFFFFFFE);
        memcache.decrement(
            [65], delta: 0xFFFFFFFFFFFFFFFE).then(expectAsync((value) {
          expect(value, 0);
        }));
      }));
    });
  });
}
