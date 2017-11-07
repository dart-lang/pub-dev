// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

typedef CheckFunc(x);

class PbList<E> extends Object with ListMixin<E> implements List<E> {
  final List<E> _wrappedList;
  final CheckFunc check;

  PbList({this.check: _checkNotNull}) : _wrappedList = <E>[] {
    assert(check != null);
  }

  PbList.from(List from)
      // TODO(sra): Should this be validated?
      : _wrappedList = new List<E>.from(from),
        check = _checkNotNull;

  factory PbList.forFieldType(int fieldType) =>
      new PbList(check: getCheckFunction(fieldType));

  bool operator ==(other) => (other is PbList) && _areListsEqual(other, this);

  int get hashCode {
    int hash = 0;
    for (final value in _wrappedList) {
      hash = (hash + value.hashCode) & 0x3fffffff;
      hash = (hash + hash << 10) & 0x3fffffff;
      hash = (hash ^ hash >> 6) & 0x3fffffff;
    }
    hash = (hash + hash << 3) & 0x3fffffff;
    hash = (hash ^ hash >> 11) & 0x3fffffff;
    hash = (hash + hash << 15) & 0x3fffffff;
    return hash;
  }

  /// Returns an [Iterator] for the list.
  Iterator<E> get iterator => _wrappedList.iterator;

  /// Returns a new lazy [Iterable] with elements that are created by calling
  /// `f` on each element of this `PbList` in iteration order.
  Iterable<T> map<T>(T f(E e)) => _wrappedList.map<T>(f);

  /// Applies the function [f] to each element of this list in iteration order.
  void forEach(void f(E element)) {
    _wrappedList.forEach(f);
  }

  /// Returns the element at the given [index] in the list or throws an
  /// [IndexOutOfRangeException] if [index] is out of bounds.
  E operator [](int index) => _wrappedList[index];

  /// Sets the entry at the given [index] in the list to [value].
  /// Throws an [IndexOutOfRangeException] if [index] is out of bounds.
  void operator []=(int index, E value) {
    _validate(value);
    _wrappedList[index] = value;
  }

  /// Unsupported -- violated non-null constraint imposed by protobufs.
  ///
  /// Changes the length of the list. If [newLength] is greater than the current
  /// [length], entries are initialized to [:null:]. Throws an
  /// [UnsupportedError] if the list is not extendable.
  void set length(int newLength) {
    if (newLength > length) {
      throw new ArgumentError('Extending protobuf lists is not supported');
    }
    _wrappedList.length = newLength;
  }

  /// Adds [value] at the end of the list, extending the length by one.
  /// Throws an [UnsupportedError] if the list is not extendable.
  void add(E value) {
    _validate(value);
    _wrappedList.add(value);
  }

  /// Appends all elements of the [collection] to the end of list.
  /// Extends the length of the list by the length of [collection].
  /// Throws an [UnsupportedError] if the list is not extendable.
  void addAll(Iterable<E> collection) {
    collection.forEach(_validate);
    _wrappedList.addAll(collection);
  }

  /// Copies [:end - start:] elements of the [from] array, starting from
  /// [skipCount], into [:this:], starting at [start].
  /// Throws an [UnsupportedError] if the list is not extendable.
  void setRange(int start, int end, Iterable<E> from, [int skipCount = 0]) {
    // NOTE: In case `take()` returns less than `end - start` elements, the
    // _wrappedList will fail with a `StateError`.
    from.skip(skipCount).take(end - start).forEach(_validate);
    _wrappedList.setRange(start, end, from, skipCount);
  }

  /// Inserts a new element in the list.
  /// The element must be valid (and not nullable) for the PbList type.
  void insert(int index, E element) {
    _validate(element);
    _wrappedList.insert(index, element);
  }

  /// Inserts all elements of [iterable] at position [index] in the list.
  ///
  /// Elements in [iterable] must be valid and not nullable for the PbList type.
  void insertAll(int index, Iterable<E> iterable) {
    iterable.forEach(_validate);
    _wrappedList.insertAll(index, iterable);
  }

  /// Overwrites elements of `this` with elements of [iterable] starting at
  /// position [index] in the list.
  ///
  /// Elements in [iterable] must be valid and not nullable for the PbList type.
  void setAll(int index, Iterable<E> iterable) {
    iterable.forEach(_validate);
    _wrappedList.setAll(index, iterable);
  }

  /// Returns the number of elements in this collection.
  int get length => _wrappedList.length;

  void _validate(E val) {
    check(val);
    // TODO: remove after migration to check functions is finished
    if (val is! E) {
      throw new ArgumentError('Value ($val) is not of the correct type');
    }
  }
}
