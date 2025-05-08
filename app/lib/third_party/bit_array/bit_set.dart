/// An integer-indexed collection to test membership status.
abstract class BitSet {
  /// Whether the value specified by the [index] is member of the collection.
  bool operator [](int index);

  /// The largest addressable or contained member of the [BitSet]:
  /// - Immutable sets should return the largest contained member.
  /// - Fixed-memory sets should return the maximum addressable value.
  int get length;

  /// The number of members.
  int get cardinality;

  /// Creates a copy of the current [BitSet].
  BitSet clone();

  /// Returns an iterable wrapper that returns the content of the [BitSet] as
  /// 32-bit int blocks. Members are iterated from a zero-based index and each
  /// block contains 32 values as a bit index.
  Iterable<int> asUint32Iterable();

  /// Returns an iterable wrapper of the [BitSet] that iterates over the index
  /// members that are set to true.
  Iterable<int> asIntIterable();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is BitSet &&
        runtimeType == other.runtimeType &&
        length == other.length) {
      final iter = asUint32Iterable().iterator;
      final otherIter = other.asUint32Iterable().iterator;
      while (iter.moveNext() && otherIter.moveNext()) {
        if (iter.current != otherIter.current) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode =>
      asUint32Iterable().fold(
        0,
        (int previousValue, element) => previousValue ^ element.hashCode,
      ) ^
      length.hashCode;
}
