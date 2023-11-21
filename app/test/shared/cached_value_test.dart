// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/shared/cached_value.dart';
import 'package:test/test.dart';

import 'test_services.dart';

void main() {
  testWithProfile('set value immediately available', fn: () async {
    final cv = CachedValue<String>(
      name: 'test',
      interval: Duration(hours: 1),
      maxAge: Duration(days: 1),
      updateFn: () async => null,
    );
    expect(cv.isAvailable, isFalse);
    cv.setValue('x');
    expect(cv.isAvailable, isTrue);
    expect(cv.value, 'x');
  });

  testWithProfile('failing update does not crash', fn: () async {
    var count = 0;
    final cv = CachedValue<String>(
      name: 'test',
      interval: Duration(milliseconds: 100),
      maxAge: Duration(days: 1),
      updateFn: () async {
        count++;
        throw Exception();
      },
    );
    for (var i = 0; i < 15; i++) {
      await cv.update();
    }
    await asyncQueue.ongoingProcessing;
    expect(cv.isAvailable, isFalse);
    expect(count, greaterThan(10));
    await cv.close();
  });

  test('successful update', () async {
    final cv = CachedValue<String>(
      name: 'test',
      interval: Duration(milliseconds: 100),
      maxAge: Duration(days: 1),
      updateFn: () async => 'x',
    );
    await cv.update();
    expect(cv.isAvailable, isTrue);
    expect(cv.value, 'x');
  });
}
