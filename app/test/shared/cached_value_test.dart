// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/cached_value.dart';

void main() {
  test('set value immediately available', () {
    final cv = CachedValue<String>(
      name: 'test',
      interval: Duration(hours: 1),
      maxAge: Duration(days: 1),
      updateFn: () async => null,
    );
    expect(cv.isAvailable, isFalse);
    cv.value = 'x';
    expect(cv.isAvailable, isTrue);
    expect(cv.value, 'x');
  });

  test('failing update does not crash', () async {
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
    cv.scheduleUpdates();
    await Future.delayed(Duration(seconds: 2));
    expect(cv.isAvailable, isFalse);
    expect(count, greaterThan(10));
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
