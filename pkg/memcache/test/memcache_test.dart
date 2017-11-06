// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:test/test.dart';

import '../lib/memcache.dart';
import '../lib/memcache_raw.dart' as raw;
import '../lib/src/memcache_impl.dart';

import 'mock_raw_memcache.dart';


class _MemcacheModifiedError extends TypeMatcher {
  const _MemcacheModifiedError() : super("ModifiedError");
  bool matches(item, Map matchState) => item is ModifiedError;
}

const isMemcacheModifiedError = const _MemcacheModifiedError();

class IncrementDecrementTestData {
  final key;
  final delta;
  final initialValue;
  final expected;

  IncrementDecrementTestData(this.key,
                             this.delta,
                             this.initialValue,
                             this.expected);
}

main() {
  var ok = new raw.SetResult(raw.Status.NO_ERROR, null);

  group('memcache', () {
    test('get', () {
      var mock = new MockRawMemcache();
      var memcache = new MemCacheImpl(mock);

      var notFound = new raw.GetResult(
          raw.Status.KEY_NOT_FOUND, 'Not found', 0, null, null);
      var foundB = new raw.GetResult(
          raw.Status.NO_ERROR, 'Not found', 0, null, [66]);

      mock.registerGet(expectAsync((batch) {
        expect(batch.length, 1);
        expect(batch[0].key, [65]);
        return new Future.value([notFound]);
      }, count: 2));

      expect(memcache.get([65]), completion(isNull));
      expect(memcache.get('A'), completion(isNull));

      mock.registerGet(expectAsync((batch) {
        expect(batch.length, 1);
        expect(batch[0].key, [65]);
        return new Future.value([foundB]);
      }, count: 4));

      expect(memcache.get([65], asBinary: true), completion([66]));
      expect(memcache.get([65]), completion('B'));
      expect(memcache.get('A', asBinary: true), completion([66]));
      expect(memcache.get('A'), completion('B'));
    });
  });

  test('get-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerGet(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }, count: 4));

    expect(memcache.get([65], asBinary: true), throwsA(isArgumentError));
    expect(memcache.get([65]), throwsA(isArgumentError));
    expect(memcache.get('A', asBinary: true), throwsA(isArgumentError));
    expect(memcache.get('A'), throwsA(isArgumentError));
  });

  test('get-throws', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerGet((_) {
      throw new ArgumentError();
    });

    expect(memcache.get([65], asBinary: true), throwsA(isArgumentError));
    expect(memcache.get([65]), throwsA(isArgumentError));
    expect(memcache.get('A', asBinary: true), throwsA(isArgumentError));
    expect(memcache.get('A'), throwsA(isArgumentError));
  });

  test('get-all', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);
    var keyA = [65];
    var keyCD = [67, 68];
    var keys = [keyA, keyCD];

    var foundA = new raw.GetResult(
        raw.Status.NO_ERROR, null, 0, null, [66]);
    var foundCD = new raw.GetResult(
        raw.Status.NO_ERROR, null, 0, null, [69, 70]);
    mock.registerGet(expectAsync((batch) {
      expect(batch.length, keys.length);
      for (var i = 0; i < keys.length; i++) {
        expect(batch[i].key, keys[i]);
      }
      return new Future.value([foundA, foundCD]);
    }, count: 4));

    expect(memcache.getAll(['A', 'CD']), completion({'A': 'B', 'CD': 'EF'}));
    expect(memcache.getAll([keyA, 'CD']), completion({keyA: 'B', 'CD': 'EF'}));
    expect(memcache.getAll(['A', keyCD]), completion({'A': 'B', keyCD: 'EF'}));
    expect(memcache.getAll([keyA, keyCD]),
                            completion({keyA: 'B', keyCD: 'EF'}));
  });

  test('get-all-throws', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerGet((_) {
      throw new ArgumentError();
    });

    expect(memcache.getAll(['A', [65]], asBinary: true),
           throwsA(isArgumentError));
  });

  test('set', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet(expectAsync((batch) {
      expect(batch.length, 1);
      expect(batch[0].operation, raw.SetOperation.SET);
      expect(batch[0].key, [65]);
      expect(batch[0].value, [66]);
      expect(batch[0].expiration, 0);
      return new Future.value([ok]);
    }, count: 4));

    expect(memcache.set([65], [66]), completion(isNull));
    expect(memcache.set('A', [66]), completion(isNull));
    expect(memcache.set([65], 'B'), completion(isNull));
    expect(memcache.set('A', 'B'), completion(isNull));
  });

  testSetAction(action, operation) {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    testWithExpiration(expiration) {
      mock.registerSet(expectAsync((batch) {
        expect(batch.length, 1);
        expect(batch[0].operation, operation);
        expect(batch[0].key, [65]);
        expect(batch[0].value, [66]);
        expect(batch[0].expiration,
               expiration == null ? 0 : expiration.inSeconds);
        return new Future.value([ok]);
      }, count: 4));

      expect(memcache.set([65], [66], action: action, expiration: expiration),
             completion(isNull));
      expect(memcache.set('A', [66], action: action, expiration: expiration),
             completion(isNull));
      expect(memcache.set([65], 'B', action: action, expiration: expiration),
             completion(isNull));
      expect(memcache.set('A', 'B', action: action, expiration: expiration),
             completion(isNull));
    }

    var expirations = [null, new Duration(hours: 1), new Duration(days: 30)];
    for (var expiration in expirations) {
      testWithExpiration(expiration);
    }
  }

  test('set-action-set', () {
    testSetAction(SetAction.SET, raw.SetOperation.SET);
  });

  test('set-action-add', () {
    testSetAction(SetAction.ADD, raw.SetOperation.ADD);
  });

  test('set-action-replace', () {
    testSetAction(SetAction.REPLACE, raw.SetOperation.REPLACE);
  });

  test('set-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }, count: 16));

    expect(memcache.set([65], [66]), throwsA(isArgumentError));
    expect(memcache.set('A', [66]), throwsA(isArgumentError));
    expect(memcache.set([65], 'B'), throwsA(isArgumentError));
    expect(memcache.set('A', 'B'), throwsA(isArgumentError));
    for (var action in [SetAction.SET, SetAction.ADD, SetAction.REPLACE]) {
      expect(memcache.set([65], [66], action: action),
             throwsA(isArgumentError));
      expect(memcache.set('A', [66], action: action), throwsA(isArgumentError));
      expect(memcache.set([65], 'B', action: action), throwsA(isArgumentError));
      expect(memcache.set('A', 'B', action: action), throwsA(isArgumentError));
    }
  });

  test('set-throw', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet((_) {
      throw new ArgumentError();
    });

    expect(memcache.set([65], [66]), throwsA(isArgumentError));
    expect(memcache.set('A', [66]), throwsA(isArgumentError));
    expect(memcache.set([65], 'B'), throwsA(isArgumentError));
    expect(memcache.set('A', 'B'), throwsA(isArgumentError));
    for (var action in [SetAction.SET, SetAction.ADD, SetAction.REPLACE]) {
      expect(memcache.set([65], [66], action: action),
             throwsA(isArgumentError));
      expect(memcache.set('A', [66], action: action), throwsA(isArgumentError));
      expect(memcache.set([65], 'B', action: action), throwsA(isArgumentError));
      expect(memcache.set('A', 'B', action: action), throwsA(isArgumentError));
    }

    var expiration = new Duration(days: 30, seconds: 1);
    expect(memcache.set('A', 'B', expiration: expiration),
           throwsA(isArgumentError));
  });

  var setAllMaps = [
    {'A': 'B', 'CD': 'EF'},
    {'A': [66], [67, 68]: 'EF'},
    {[65]: 'B', 'CD': [69, 70]},
    {[65]: [66], [67, 68]: [69, 70]}
  ];
  var setAllKeys = [[65], [67, 68]];
  var setAllValues = [[66], [69, 70]];

  checkSetAllBatch(batch, operation, expiration) {
    expect(batch.length, setAllKeys.length);
    for (var i = 0; i < setAllKeys.length; i++) {
      expect(batch[i].operation, operation);
      expect(batch[i].key, setAllKeys[i]);
      expect(batch[i].value, setAllValues[i]);
      expect(batch[i].expiration,
             expiration == null ? 0 : expiration.inSeconds);
    }
  }

  test('set-all', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet(expectAsync((batch) {
      checkSetAllBatch(batch, raw.SetOperation.SET, null);
      return new Future.value([ok, ok]);
    }, count: setAllMaps.length));

    for (var m in setAllMaps) {
      expect(memcache.setAll(m), completes);
    }
  });

  testSetAllAction(action, operation) {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    testWithExpiration(expiration) {
      mock.registerSet(expectAsync((batch) {
        checkSetAllBatch(batch, operation, expiration);
        return new Future.value([ok, ok]);
      }, count: setAllMaps.length));

      for (var m in setAllMaps) {
        expect(memcache.setAll(
            m, action: action, expiration: expiration), completes);
      }
    }

    var expirations = [null, new Duration(hours: 1), new Duration(days: 30)];
    for (var expiration in expirations) {
      testWithExpiration(expiration);
    }
  }

  test('set-action-set', () {
    testSetAllAction(SetAction.SET, raw.SetOperation.SET);
  });

  test('set-action-add', () {
    testSetAllAction(SetAction.ADD, raw.SetOperation.ADD);
  });

  test('set-action-replace', () {
    testSetAllAction(SetAction.REPLACE, raw.SetOperation.REPLACE);
  });

  test('set-all-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }, count: setAllMaps.length));

    for (var m in setAllMaps) {
      expect(memcache.setAll(m), throwsA(isArgumentError));
    }
  });

  test('set-all-throws', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerSet((_) {
      throw new ArgumentError();
    });

    for (var m in setAllMaps) {
      expect(memcache.setAll(m), throwsA(isArgumentError));

      var expiration = new Duration(days: 30, seconds: 1);
      expect(memcache.setAll(m, expiration: expiration),
             throwsA(isArgumentError));
    }

  });

  test('remove', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerRemove(expectAsync((batch) {
      expect(batch.length, 1);
      expect(batch[0].key, [65]);
      return new Future.value([ok]);
    }, count: 2));

    expect(memcache.remove([65]), completion(isNull));
    expect(memcache.remove('A'), completion(isNull));
  });

  test('remove-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerRemove(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }));

    expect(memcache.remove([65]), throwsA(isArgumentError));
  });

  test('remove-throw', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerRemove((_) {
      throw new ArgumentError();
    });

    expect(memcache.remove([65]), throwsA(isArgumentError));
    expect(memcache.remove('A'), throwsA(isArgumentError));
  });

  test('remove-all-throws', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerRemove((_) {
      throw new ArgumentError();
    });

    expect(memcache.removeAll(['A', [65]]), throwsA(isArgumentError));
  });

  test('increment', () {
    var testData = [];
    var keys = ['A', [65]];
    var deltas = [0, 2, -1];
    var initialValues = [0, 2];
    var expected = initialValues[0];
    for (var key in keys) {
      for (var delta in deltas) {
        for (var initialValue in initialValues) {
          expected += delta;  // This requires the first delta to be 0.
          testData.add(new IncrementDecrementTestData(
              key, delta, initialValue, expected));
        }
      }
    }

    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    var count = 0;
    var value;

    mock.registerIncrement(expectAsync((batch) {
      expect(batch.length, 1);
      expect(batch[0].key, [65]);
      if (testData[count].delta >= 0) {
        expect(batch[0].direction, raw.IncrementOperation.INCREMENT);
        expect(batch[0].delta, testData[count].delta);
      } else {
        expect(batch[0].direction, raw.IncrementOperation.DECREMENT);
        expect(batch[0].delta, -testData[count].delta);
      }
      expect(batch[0].initialValue, testData[count].initialValue);
      if (value == null) {
        value = batch[0].initialValue;
      } else {
        if (batch[0].direction == raw.IncrementOperation.INCREMENT) {
          value += batch[0].delta;
        } else {
          value -= batch[0].delta;
        }
      }
      count++;
      return new Future.value(
          [new raw.IncrementResult(raw.Status.NO_ERROR, null, value)]);
    }, count: testData.length));

    for (var x in testData) {
      expect(memcache.increment(x.key,
                                delta: x.delta,
                                initialValue: x.initialValue),
             completion(x.expected));
    }
  });

  test('increment-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerIncrement(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }));

    expect(memcache.increment('A'), throwsA(isArgumentError));
  });

  test('increment-throw', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerIncrement((_) {
      throw new ArgumentError();
    });

    expect(memcache.increment('A'), throwsA(isArgumentError));
  });

  test('decrement', () {
    var testData = [];
    var keys = ['A', [65]];
    var deltas = [0, 2, -1];
    var initialValues = [100, 2];
    var expected = initialValues[0];
    for (var key in keys) {
      for (var delta in deltas) {
        for (var initialValue in initialValues) {
          expected -= delta;  // This requires the first delta to be 0.
          testData.add([key, delta, initialValue, expected]);
        }
      }
    }

    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    var count = 0;
    var value;

    mock.registerIncrement(expectAsync((batch) {
      expect(batch.length, 1);
      expect(batch[0].key, [65]);
      if (testData[count][1] > 0) {
        expect(batch[0].direction, raw.IncrementOperation.DECREMENT);
        expect(batch[0].delta, testData[count][1]);
      } else {
        expect(batch[0].direction, raw.IncrementOperation.INCREMENT);
        expect(batch[0].delta, -testData[count][1]);
      }
      expect(batch[0].initialValue, testData[count][2]);
      if (value == null) {
        value = batch[0].initialValue;
      } else {
        if (batch[0].direction == raw.IncrementOperation.INCREMENT) {
          value += batch[0].delta;
        } else {
          value -= batch[0].delta;
        }
      }
      count++;
      return new Future.value(
          [new raw.IncrementResult(raw.Status.NO_ERROR, null, value)]);
    }, count: testData.length));

    for (var x in testData) {
      expect(memcache.decrement(x[0], delta: x[1], initialValue: x[2]),
             completion(x[3]));
    }
  });

  test('decrement-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerIncrement(expectAsync((_) {
      return new Future.error(new ArgumentError());
    }));

    expect(memcache.decrement('A'), throwsA(isArgumentError));
  });

  test('decrement-throw', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerIncrement((_) {
      throw new ArgumentError();
    });

    expect(memcache.decrement('A'), throwsA(isArgumentError));
  });

  test('clear', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerClear(expectAsync(() => null, count: 2));

    expect(memcache.clear(), completion(isNull));
    expect(memcache.clear(), completion(isNull));
  });

  test('clear-error', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerClear(expectAsync(() {
      return new Future.error(new ArgumentError());
    }));

    expect(memcache.clear(), throwsA(isArgumentError));
  });

  test('clear-throw', () {
    var mock = new MockRawMemcache();
    var memcache = new MemCacheImpl(mock);

    mock.registerClear(() {
      throw new ArgumentError();
    });

    expect(memcache.clear(), throwsA(isArgumentError));
  });

  test('to-string', () {
    expect(new raw.GetOperation([65]).toString(), isNotNull);
    expect(new raw.GetResult(
        raw.Status.NO_ERROR, null, 0, null, [1]).toString(), isNotNull);
    expect(new raw.SetOperation(
        raw.SetOperation.SET,[65], 0, null, [1], 0).toString(), isNotNull);
    expect(new raw.SetResult(raw.Status.NO_ERROR, null).toString(), isNotNull);
    expect(new raw.RemoveOperation([65]).toString(), isNotNull);
    expect(new raw.RemoveResult(
        raw.Status.NO_ERROR, null).toString(), isNotNull);
    expect(new raw.IncrementOperation(
        [65], 1, raw.IncrementOperation.INCREMENT, 0, 0).toString(), isNotNull);
    expect(new raw.IncrementResult(
        raw.Status.NO_ERROR, null, 1).toString(), isNotNull);
  });

  group('memcache-with-cas', () {
    var mock;
    var memcache;
    var cas = 0xCA5;
    var result = new raw.GetResult(
        raw.Status.NO_ERROR, null, 0, cas, [66]);

    setUp(() {
      mock = new MockRawMemcache();
      memcache = new MemCacheImpl(mock).withCAS();

      mock.registerGet(expectAsync((batch) {
        expect(batch.length, 1);
        expect(batch[0].key, [65]);
        return new Future.value([result]);
      }));
    });

    tearDown((){
      mock = null;
      memcache = null;
    });

    check(batch, [operation = raw.SetOperation.SET]) {
      expect(batch.length, 1);
      expect(batch[0].operation, operation);
      expect(batch[0].key, [65]);
      expect(batch[0].value, [66]);
      if (operation == raw.SetOperation.SET) {
        expect(batch[0].cas, cas);
      } else {
        expect(batch[0].cas, isNull);
      }
      expect(batch[0].expiration, 0);
    }

    test('get-set', () {
      return memcache.get([65]).then((value) {
        expect(value, 'B');
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch);
          return new Future.value([ok]);
        }, count: 2));
        return memcache.set([65], [66]).then((value) {
          expect(value, isNull);
          return memcache.set('A', [66]).then((value) {
            expect(value, isNull);
          });
        });
      });
    });

    test('get-set-modified', () {
      var exists = new raw.SetResult(raw.Status.KEY_EXISTS, null);

      return memcache.get([65]).then((value) {
        expect(value, 'B');
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch);
          return new Future.value([exists]);
        }, count: 2));

        expect(memcache.set([65], [66]), throwsA(isMemcacheModifiedError));
        expect(memcache.set('A', [66]), throwsA(isMemcacheModifiedError));
      });
    });

    test('get-add', () {
      return memcache.get([65]).then((value) {
        expect(value, 'B');
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch, raw.SetOperation.ADD);
          return new Future.value([ok]);
        }));
        return memcache.set([65], [66], action: SetAction.ADD).then((value) {
          expect(value, isNull);
        });
      });
    });

    test('get-replace', () {
      return memcache.get([65]).then((value) {
        expect(value, 'B');
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch, raw.SetOperation.REPLACE);
          return new Future.value([ok]);
        }));
        return memcache.set([65], [66],
                            action: SetAction.REPLACE).then((value) {
          expect(value, isNull);
        });
      });
    });
  });

  group('memcache-with-cas-all', () {
    var mock;
    var memcache;
    var key1 = [65];
    var casA = 0xCA5;
    var casB = 0xCA2;
    var result =
        [ new raw.GetResult(raw.Status.NO_ERROR, null, 0, casA, [67]),
          new raw.GetResult(raw.Status.NO_ERROR, null, 0, casB, [68]) ];

    setUp(() {
      mock = new MockRawMemcache();
      memcache = new MemCacheImpl(mock).withCAS();

      mock.registerGet(expectAsync((batch) {
        expect(batch.length, 2);
        expect(batch[0].key, key1);
        expect(batch[1].key, [66]);
        return new Future.value(result);
      }));
    });

    tearDown((){
      mock = null;
      memcache = null;
    });

    check(batch, [operation = raw.SetOperation.SET]) {
      expect(batch.length, 2);
      expect(batch[0].operation, operation);
      expect(batch[0].key, [65]);
      expect(batch[0].value, [67]);
      expect(batch[1].key, [66]);
      expect(batch[1].value, [68]);
      if (operation == raw.SetOperation.SET) {
        expect(batch[0].cas, casA);
        expect(batch[1].cas, casB);
      } else {
        expect(batch[0].cas, isNull);
        expect(batch[1].cas, isNull);
      }
    }

    test('get-all-set-all', () {
      return memcache.getAll([key1, "B"]).then((values) {
        expect(values.length, 2);
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch);
          return new Future.value([ok, ok]);
        }));
        return memcache.setAll({key1: 'C', 'B': [68]}).then((value) {
          expect(value, isNull);
        });
      });
    });

    test('get-all-set-all-modified', () {
      var exists = new raw.SetResult(raw.Status.KEY_EXISTS, null);

      return memcache.getAll([key1, "B"]).then((values) {
        expect(values.length, 2);
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch);
          return new Future.value([ok, exists]);
        }));
        expect(memcache.setAll({key1: 'C', 'B': [68]}),
               throwsA(isMemcacheModifiedError));
      });
    });

    test('get-all-add-all', () {
      return memcache.getAll([key1, "B"]).then((values) {
        expect(values.length, 2);
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch, raw.SetOperation.ADD);
          return new Future.value([ok, ok]);
        }));
        return memcache.setAll({key1: 'C', 'B': [68]},
                               action: SetAction.ADD).then((value) {
          expect(value, isNull);
        });
      });
    });

    test('get-all-replace-all', () {
      return memcache.getAll([key1, "B"]).then((values) {
        expect(values.length, 2);
        mock.registerGet(null);
        mock.registerSet(expectAsync((batch) {
          check(batch, raw.SetOperation.REPLACE);
          return new Future.value([ok, ok]);
        }));
        return memcache.setAll({key1: 'C', 'B': [68]},
                               action: SetAction.REPLACE).then((value) {
          expect(value, isNull);
        });
      });
    });
  });

  group('memcache-dont-modify-arguments', () {
    var mock;
    var memcache;
    var result = new raw.GetResult(raw.Status.NO_ERROR, null, 0, null, [68]);

    setUp(() {
      mock = new MockRawMemcache();
      memcache = new MemCacheImpl(mock);
    });

    tearDown((){
      mock = null;
      memcache = null;
    });

    test('get-all', () {
      mock.registerGet(expectAsync((batch) {
        expect(batch.length, 2);
        expect(batch[0].key, [65]);
        expect(batch[1].key, [66]);
        return new Future.value([result, result]);
      }));

      var key1 = [65];
      var key2 = 'B';
      var keys = [key1, key2];
      return memcache.getAll(keys).then((_) {
        expect(keys[0] == key1, isTrue);
        expect(keys[1] == key2, isTrue);
      });
    });

    test('set-all', () {
      mock.registerSet(expectAsync((batch) {
        expect(batch.length, 2);
        expect(batch[0].key, [65]);
        expect(batch[1].key, [66]);
        return new Future.value([ok, ok]);
      }));

      var key1 = [65];
      var key2 = 'B';
      var value1 = 'A';
      var value2 = [66];
      var map = {key1: value1, key2: value2};
      return memcache.setAll(map).then((_) {
        var keys = map.keys.toList();
        expect(keys[0] == key1, isTrue);
        expect(keys[1] == key2, isTrue);
        expect(map[key1] == value1, isTrue);
        expect(map[key2] == value2, isTrue);
      });
    });

    test('remove-all', () {
      mock.registerRemove(expectAsync((batch) {
        expect(batch.length, 2);
        expect(batch[0].key, [65]);
        expect(batch[1].key, [66]);
        return new Future.value([result, result]);
      }));

      var key1 = [65];
      var key2 = 'B';
      var keys = [key1, key2];
      return memcache.removeAll(keys).then((_) {
        expect(keys[0] == key1, isTrue);
        expect(keys[1] == key2, isTrue);
      });
    });
  });
}
