// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  var iterable1 = new Iterable.generate(3);
  var iterable2 = new Iterable.generate(3, (i) => i + 3);
  var iterable3 = new Iterable.generate(3, (i) => i + 6);

  test('should combine multiple iterables when iterating', () {
    var combined = new CombinedIterableView([iterable1, iterable2, iterable3]);
    expect(combined, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  });

  test('should combine multiple iterables with some empty ones', () {
    var combined =
        new CombinedIterableView([iterable1, [], iterable2, [], iterable3, []]);
    expect(combined, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  });

  test('should function as an empty iterable when no iterables are passed', () {
    var empty = new CombinedIterableView([]);
    expect(empty, isEmpty);
  });

  test('should function as an empty iterable with all empty iterables', () {
    var empty = new CombinedIterableView([[], [], []]);
    expect(empty, isEmpty);
  });

  test('should reflect changes from the underlying iterables', () {
    var list1 = [];
    var list2 = [];
    var combined = new CombinedIterableView([list1, list2]);
    expect(combined, isEmpty);
    list1.addAll([1, 2]);
    list2.addAll([3, 4]);
    expect(combined, [1, 2, 3, 4]);
    expect(combined.last, 4);
    expect(combined.first, 1);
  });

  test('should reflect changes from the iterable of iterables', () {
    var iterables = <Iterable>[];
    var combined = new CombinedIterableView(iterables);
    expect(combined, isEmpty);
    expect(combined, hasLength(0));

    iterables.add(iterable1);
    expect(combined, isNotEmpty);
    expect(combined, hasLength(3));

    iterables.clear();
    expect(combined, isEmpty);
    expect(combined, hasLength(0));
  });
}
