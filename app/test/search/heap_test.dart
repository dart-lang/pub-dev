// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:pub_dev/search/heap.dart';
import 'package:test/test.dart';

void main() {
  group('top-k sorted list', () {
    int compare(int a, int b) => -a.compareTo(b);

    test('no items', () {
      final heap = Heap(compare);
      expect(heap.getAndRemoveTopK(5).toList(), []);
    });

    test('single item', () {
      final heap = Heap(compare);
      heap.collect(1);
      expect(heap.getAndRemoveTopK(5).toList(), [1]);
    });

    test('three items ascending', () {
      final builder = Heap(compare);
      builder.collectAll([1, 2, 3]);
      expect(builder.getAndRemoveTopK(5).toList(), [3, 2, 1]);
    });

    test('three items descending', () {
      final heap = Heap(compare);
      heap.collectAll([3, 2, 1]);
      expect(heap.getAndRemoveTopK(5).toList(), [3, 2, 1]);
    });

    test('10 items + repeated', () {
      final heap = Heap(compare);
      heap.collectAll([1, 10, 2, 9, 3, 8, 4, 7, 6, 5, 9]);
      expect(heap.getAndRemoveTopK(5).toList(), [10, 9, 9, 8, 7]);
    });

    test('randomized verification', () {
      for (var i = 0; i < 1000; i++) {
        final r = Random(i);
        final length = 1000 + r.nextInt(1000);
        final k = 10 + r.nextInt(200);
        final items = List.generate(length, (i) => i);
        final b1 = Heap(compare)..collectAll(items);
        final r1 = b1.getAndRemoveTopK(k).toList();
        expect(r1, List.generate(k, (i) => length - 1 - i));

        items.shuffle(r);
        final b2 = Heap(compare)..collectAll(items);
        final r2 = b2.getAndRemoveTopK(k).toList();
        expect(r2, r1);
      }
    });
  });
}
