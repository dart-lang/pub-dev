// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A data structure that keep satisfies the "heap property". This property
/// dictates that in a max-heap, each node's value is greater than or equal
/// to its children's values, and in a min-heap, each node's value is less
/// than or equal to its children's values.
///
/// The provided comparator decides which kind of heap is being built.
class _Heap<T> {
  final Comparator<T> _compare;
  final _items = <T>[];

  _Heap(this._compare);

  int get length => _items.length;

  void _pushDown(int index) {
    final maxLength = _items.length;
    final item = _items[index];
    while (index < maxLength) {
      final leftIndex = (index << 1) + 1;
      if (leftIndex >= maxLength) {
        return;
      }
      var childIndex = leftIndex;
      final rightIndex = leftIndex + 1;
      if (rightIndex < maxLength &&
          _compare(_items[leftIndex], _items[rightIndex]) > 0) {
        childIndex = rightIndex;
      }
      if (_compare(item, _items[childIndex]) <= 0) {
        return;
      }
      _items[index] = _items[childIndex];
      _items[childIndex] = item;
      index = childIndex;
    }
  }

  bool _isValidHeap() {
    for (var i = 1; i < _items.length; i++) {
      final parentIndex = (i - 1) >> 1;
      if (_compare(_items[parentIndex], _items[i]) > 0) {
        print(parentIndex);
        print(_items);
        return false;
      }
    }
    return true;
  }
}

/// Builds a sorted list of the top-k items using the provided comparator.
///
/// The algorithm collects all items, builds a max-heap in O(N) steps, and
/// then selects the top-k items by removing the largest item from the heap
/// and restoring the heap property again in O(k * log(N)) steps.
class TopKSortedListBuilder<T> {
  final int _k;
  final _Heap<T> _heap;

  TopKSortedListBuilder(this._k, Comparator<T> compare)
      : _heap = _Heap<T>(compare);

  void addAll(Iterable<T> items) {
    for (final item in items) {
      add(item);
    }
  }

  void add(T item) {
    _heap._items.add(item);
  }

  /// Gets and removes the top-k items from the current list.
  Iterable<T> getTopK() sync* {
    if (_heap._items.isEmpty) {
      return;
    }
    for (var i = (_heap._items.length >> 1); i >= 0; i--) {
      _heap._pushDown(i);
    }
    assert(_heap._isValidHeap());
    var count = _k;
    while (count > 0 && _heap._items.isNotEmpty) {
      yield _heap._items[0];
      count--;
      final last = _heap._items.removeLast();
      if (_heap._items.isEmpty) {
        break;
      }
      _heap._items[0] = last;
      _heap._pushDown(0);
    }
  }
}
