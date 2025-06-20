// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A data structure that keep satisfies the "heap property". This property
/// dictates that in a max-heap, each node's value is greater than or equal
/// to its children's values, and in a min-heap, each node's value is less
/// than or equal to its children's values.
///
/// The provided comparator decides which kind of heap is being built.
class Heap<T> {
  final Comparator<T> _compare;
  final _items = <T>[];
  bool _isValid = true;

  Heap(this._compare);

  int get length => _items.length;

  /// Collects [item] and adds it to the end of the internal list, marks the [Heap]
  /// as non-valid.
  ///
  /// A separate operation may trigger the restoration of the heap proprerty.
  void collect(T item) {
    _items.add(item);
    _isValid = false;
  }

  /// Collects [items] and adds them the end of the internal list, marks the [Heap]
  /// as non-valid.
  ///
  /// A separate operation may trigger the restoration of the heap proprerty.
  void collectAll(Iterable<T> items) {
    _items.addAll(items);
    _isValid = false;
  }

  /// Ensures that the tree structure below the [index] is a valid heap.
  void _heapify(int index) {
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

  /// (Re-)builds the heap property if needed.
  void _buildHeapIfNeeded() {
    if (_isValid) {
      assert(_isValidHeap());
      return;
    }

    if (_items.isEmpty) {
      _isValid = true;
      return;
    }
    for (var i = (_items.length >> 1); i >= 0; i--) {
      _heapify(i);
    }

    assert(_isValidHeap());
    _isValid = true;
  }

  /// Verifies the heap property is true for all items.
  bool _isValidHeap() {
    for (var i = 1; i < _items.length; i++) {
      final parentIndex = (i - 1) >> 1;
      if (_compare(_items[parentIndex], _items[i]) > 0) {
        return false;
      }
    }
    return true;
  }

  /// Creates a sorted list of the top-k items and removes them from the [Heap].
  ///
  /// The algorithm builds a max-heap in `O(N)` steps on the already collected items,
  /// and then selects the top-k items by removing the largest item from the [Heap]
  /// and restoring the heap property again in `O(k * log(N))` steps.
  Iterable<T> getAndRemoveTopK(int k) sync* {
    _buildHeapIfNeeded();
    var remaining = k;
    while (remaining > 0 && _items.isNotEmpty) {
      yield _items[0];
      remaining--;
      final last = _items.removeLast();
      if (_items.isEmpty) {
        break;
      }
      _items[0] = last;
      _heapify(0);
    }
    assert(_isValidHeap());
  }
}
