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
      final builder = TopKSortedListBuilder(5, compare);
      expect(builder.getTopK().toList(), []);
    });

    test('single item', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.add(1);
      expect(builder.getTopK().toList(), [1]);
    });

    test('three items ascending', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([1, 2, 3]);
      expect(builder.getTopK().toList(), [3, 2, 1]);
    });

    test('three items descending', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([3, 2, 1]);
      expect(builder.getTopK().toList(), [3, 2, 1]);
    });

    test('10 items + repeated', () {
      final builder = TopKSortedListBuilder(5, compare);
      builder.addAll([1, 10, 2, 9, 3, 8, 4, 7, 6, 5, 9]);
      expect(builder.getTopK().toList(), [10, 9, 9, 8, 7]);
    });

    test('randomized verification', () {
      for (var i = 0; i < 1000; i++) {
        final r = Random(i);
        final length = 1000 + r.nextInt(1000);
        final k = 10 + r.nextInt(200);
        final items = List.generate(length, (i) => i);
        final b1 = TopKSortedListBuilder(k, compare)..addAll(items);
        final r1 = b1.getTopK().toList();
        expect(r1, List.generate(k, (i) => length - 1 - i));

        items.shuffle(r);
        final b2 = TopKSortedListBuilder(k, compare)..addAll(items);
        final r2 = b2.getTopK().toList();
        expect(r2, r1);
      }
    });
  });
}
