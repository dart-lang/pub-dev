// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pub_dev/search/heap.dart';
import 'package:pub_dev/third_party/bit_array/bit_array.dart';

import 'text_utils.dart';

/// The weighted tokens used for the final search.
class TokenMatch {
  final Map<String, double> _tokenWeights = <String, double>{};

  Iterable<MapEntry<String, double>> get entries => _tokenWeights.entries;

  @visibleForTesting
  Map<String, double> get tokenWeights => _tokenWeights;

  void setValueMaxOf(String token, double weight) {
    final old = _tokenWeights[token] ?? 0.0;
    if (old < weight) {
      _tokenWeights[token] = weight;
    }
  }
}

/// Per-token posting data: interleaved varint delta-encoded document indices
/// and quantized weights in a single byte array.
///
/// ## Byte format
///
/// Entries are stored sequentially with no separators or length prefix:
///
/// ```
/// [entry0] [entry1] [entry2] ...
/// ```
///
/// Each entry is:
///
/// ```
/// [delta varint: 1-5 bytes] [weight: 1 byte]
/// ```
///
/// - **Delta varint**: LEB128-encoded difference from the previous document
///   index (or 0 for the first entry). Each byte stores 7 data bits in
///   bits 0-6; bit 7 is the continuation flag (1 = more bytes follow).
///   Typical deltas (1-127) encode in a single byte.
/// - **Weight**: quantized token weight, 0-255, where the original float
///   weight is recovered as `(weight + 1) / 256`.
///
/// Example: doc indices [3, 5, 200] with weights [255, 128, 64] encodes as:
///
/// ```
/// 03 FF  02 80  C3 01 40
/// ─────  ─────  ────────
///  3,255  2,128  195(=200-5), 64  ← 195 needs two varint bytes: 0xC3 0x01
/// ```
class TokenPostings {
  /// Interleaved varint-delta-encoded doc indices and weights.
  final Uint8List _data;

  TokenPostings._(this._data);

  /// Iterates over all entries, calling [fn] with the document index and
  /// the quantized weight for each entry. No objects are allocated.
  void forEach(void Function(int docIndex, int weight) fn) {
    var pos = 0;
    var docIndex = 0;

    while (pos < _data.length) {
      var delta = 0;
      var shift = 0;
      int byte;

      do {
        byte = _data[pos++];
        delta |= (byte & 0x7F) << shift;
        shift += 7;
      } while (byte >= 0x80);

      docIndex += delta;
      fn(docIndex, _data[pos++]);
    }
  }
}

/// Builds a [TokenPostings] incrementally using 128-byte buffer chunks,
/// concatenating into a single [Uint8List] at the end.
class _PostingsBuilder {
  static const _bufferSize = 128;

  List<Uint8List>? _chunks;
  final _buffer = Uint8List(_bufferSize);
  int _pos = 0;
  int _prev = 0;

  void add(int docIndex, int weight) {
    // worst case: 5 bytes varint + 1 byte weight = 6 bytes
    if (_pos + 6 > _bufferSize) _flush();
    var delta = docIndex - _prev;
    assert(delta >= 0);

    _prev = docIndex;
    while (delta >= 0x80) {
      _buffer[_pos++] = delta & 0x7F | 0x80;
      delta >>= 7;
    }
    _buffer[_pos++] = delta;
    _buffer[_pos++] = weight;
  }

  void _flush() {
    (_chunks ??= []).add(_buffer.sublist(0, _pos));
    _pos = 0;
  }

  TokenPostings build() {
    final chunks = _chunks;
    if (chunks == null) {
      // Everything fits in a single buffer, no chunks were flushed.
      return TokenPostings._(_buffer.sublist(0, _pos));
    }
    if (_pos > 0) _flush();
    final total = chunks.fold<int>(0, (s, c) => s + c.length);
    final result = Uint8List(total);
    var offset = 0;
    for (final chunk in chunks) {
      result.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    return TokenPostings._(result);
  }
}

/// Describes a weighted field of a document.
class TokenIndexField {
  /// The text value of the field.
  final String text;

  /// Whether to skip the normalization for this field.
  final bool skipDocumentWeight;

  /// Token weight multiplier.
  final double weight;

  TokenIndexField(
    this.text, {
    this.skipDocumentWeight = false,
    this.weight = 1.0,
  });
}

/// Stores a token -> documentId inverted index with weights.
class TokenIndex {
  final int _length;

  /// Maps tokens to their posting data (document indices + quantized weights).
  final Map<String, TokenPostings> _postings;

  late final _scorePool = ScorePool(_length);

  TokenIndex._(this._length, this._postings);

  factory TokenIndex(List<String?> values, {bool skipDocumentWeight = false}) {
    final builders = <String, _PostingsBuilder>{};
    for (var i = 0; i < values.length; i++) {
      final text = values[i];
      if (text == null) continue;
      _addTokens(i, tokenize(text), skipDocumentWeight, builders);
    }
    return TokenIndex._(values.length, _finalize(builders));
  }

  /// Builds a single index from a list of [objects], extracting one or more
  /// weighted text fields from each via [extractFields] (e.g. description +
  /// readme of the same package document).
  ///
  /// For each object, the tokens of all its fields are merged, keeping the
  /// maximum weight per token.
  static TokenIndex fromFields<T>(
    List<T> objects,
    List<TokenIndexField> Function(T object) extractFields,
  ) {
    final builders = <String, _PostingsBuilder>{};
    for (var i = 0; i < objects.length; i++) {
      final merged = <String, double>{};
      for (final field in extractFields(objects[i])) {
        final tokens = tokenize(field.text);
        if (tokens == null || tokens.isEmpty) continue;
        final dw = field.skipDocumentWeight
            ? 1.0
            : _documentWeight(tokens.length);
        for (final e in tokens.entries) {
          final w = e.value / dw * field.weight;
          final old = merged[e.key];
          if (old == null || w > old) {
            merged[e.key] = w;
          }
        }
      }
      // Weights are already normalized above, so skip the document weight here.
      _addTokens(i, merged, true, builders);
    }
    return TokenIndex._(objects.length, _finalize(builders));
  }

  factory TokenIndex.fromValues(
    List<List<String>?> values, {
    bool skipDocumentWeight = false,
  }) {
    final builders = <String, _PostingsBuilder>{};
    for (var i = 0; i < values.length; i++) {
      final parts = values[i];
      if (parts == null || parts.isEmpty) continue;
      // Merge tokens from all texts for this doc index, keeping max weight.
      final merged = <String, double>{};
      for (final text in parts) {
        final tokens = tokenize(text);
        if (tokens == null) continue;
        for (final e in tokens.entries) {
          final old = merged[e.key];
          if (old == null || e.value > old) {
            merged[e.key] = e.value;
          }
        }
      }
      _addTokens(i, merged, skipDocumentWeight, builders);
    }
    return TokenIndex._(values.length, _finalize(builders));
  }

  static Map<String, TokenPostings> _finalize(
    Map<String, _PostingsBuilder> builders,
  ) {
    return builders.map((token, builder) => MapEntry(token, builder.build()));
  }

  /// Quantizes token weights and appends one entry per token to its builder.
  static void _addTokens(
    int docIndex,
    Map<String, double>? tokens,
    bool skipDocumentWeight,
    Map<String, _PostingsBuilder> builders,
  ) {
    if (tokens == null || tokens.isEmpty) return;
    // Document weight is a highly scaled-down proxy of the length.
    final dw = skipDocumentWeight ? 1.0 : _documentWeight(tokens.length);
    for (final e in tokens.entries) {
      final weight = e.value / dw;
      final quantized = (weight * 256 - 1).round().clamp(0, 255);
      builders
          .putIfAbsent(e.key, _PostingsBuilder.new)
          .add(docIndex, quantized);
    }
  }

  static double _documentWeight(int length) => 1 + math.log(1 + length) / 100;

  /// Match the text against the corpus and return the tokens or
  /// their partial segments that have match.
  @visibleForTesting
  Future<TokenMatch> lookupTokens(String text) async {
    final tokenMatch = TokenMatch();

    for (final word in splitForIndexing(text)) {
      final tokens = tokenize(word, isSplit: true) ?? {};

      final present = tokens.keys
          .where((token) => _postings.containsKey(token))
          .toList();
      if (present.isEmpty) {
        return TokenMatch();
      }
      final bestTokenValue = present
          .map((token) => tokens[token]!)
          .reduce(math.max);
      final minTokenValue = bestTokenValue * 0.7;
      for (final token in present) {
        final value = tokens[token]!;
        if (value >= minTokenValue) {
          tokenMatch.setValueMaxOf(token, value);
        }
      }
    }

    return tokenMatch;
  }

  /// Search the index for [words], providing the result [IndexedScore] values
  /// in the [fn] callback, reusing the score buffers between calls.
  Future<R> withSearchWords<R>(
    List<String> words,
    Future<R> Function(IndexedScore score) fn, {
    double weight = 1.0,
  }) async {
    IndexedScore? score;

    weight = math.pow(weight, 1 / words.length).toDouble();
    for (final w in words) {
      final s = _scorePool._acquire();
      await searchAndAccumulate(w, score: s, weight: weight);
      if (score == null) {
        score = s;
      } else {
        score.multiplyAllFrom(s);
        _scorePool._release(s);
      }
    }
    score ??= _scorePool._acquire();
    try {
      return await fn(score);
    } finally {
      _scorePool._release(score);
    }
  }

  /// Searches the index with [word] and stores the results in [score], using
  /// accumulation operation on the already existing values.
  Future<void> searchAndAccumulate(
    String word, {
    double weight = 1.0,
    required IndexedScore score,
  }) async {
    assert(score.length == _length);
    final tokenMatch = await lookupTokens(word);
    for (final entry in tokenMatch.entries) {
      final matchWeight = entry.value;
      final posting = _postings[entry.key]!;
      posting.forEach((docIndex, w) {
        score.setValueMaxOf(docIndex, matchWeight * (w + 1) / 256 * weight);
      });
    }
  }
}

abstract class _AllocationPool<T> {
  final _pool = <T>[];

  /// Creates a ready-to-use item for the pool.
  final T Function() _allocate;

  /// Resets a previously used item to its initial state.
  final void Function(T) _reset;

  _AllocationPool(this._allocate, this._reset);

  T _acquire() {
    final T t;
    if (_pool.isNotEmpty) {
      t = _pool.removeLast();
      _reset(t);
    } else {
      t = _allocate();
    }
    return t;
  }

  void _release(T item) {
    _pool.add(item);
  }

  /// Executes [fn] and provides a pool item in the callback.
  /// The item will be released to the pool after [fn] completes.
  Future<R> withPoolItem<R>({required Future<R> Function(T array) fn}) async {
    final item = _acquire();
    try {
      return await fn(item);
    } finally {
      _release(item);
    }
  }

  /// Executes synchronous [fn] and provides a pool item in the callback.
  /// The item will be released to the pool after [fn] completes.
  R withPoolItemSync<R>({required R Function(T array) fn}) {
    final item = _acquire();
    try {
      return fn(item);
    } finally {
      _release(item);
    }
  }

  /// Executes [fn] and provides a getter function that can be used to
  /// acquire new pool items while the [fn] is being executed. The
  /// acquired items will be released back to the pool after [fn] completes.
  Future<R> withItemGetter<R>(
    Future<R> Function(T Function() itemFn) fn,
  ) async {
    List<T>? items;
    T itemFn() {
      items ??= <T>[];
      final item = _acquire();
      items!.add(item);
      return item;
    }

    try {
      return await fn(itemFn);
    } finally {
      if (items != null) {
        for (final item in items!) {
          _release(item);
        }
      }
    }
  }
}

/// A reusable pool for [IndexedScore] instances to spare some memory allocation.
class ScorePool extends _AllocationPool<IndexedScore> {
  ScorePool(int length)
    : super(
        () => IndexedScore(length),
        // sets all values to 0.0
        (score) => score._values.fillRange(0, score.length, 0.0),
      );
}

/// A reusable pool for [BitArray] instances to spare some memory allocation.
class BitArrayPool extends _AllocationPool<BitArray> {
  BitArrayPool(int length)
    : super(
        () => BitArray(length),
        (
          array,
        ) {}, // keeping the array as-is, reset happens at the beginning of the processing
      );
}

/// Mutable score list that can accessed via integer index.
class IndexedScore {
  final List<double> _values;

  IndexedScore(int length, [double value = 0.0])
    : _values = List<double>.filled(length, value);

  late final length = _values.length;

  int positiveCount() {
    var count = 0;
    for (var i = 0; i < length; i++) {
      if (isPositive(i)) count++;
    }
    return count;
  }

  bool isPositive(int index) {
    return _values[index] > 0.0;
  }

  bool isNotPositive(int index) {
    return _values[index] <= 0.0;
  }

  double getValue(int index) {
    return _values[index];
  }

  void setValue(int index, double value) {
    _values[index] = value;
  }

  void setValueMaxOf(int index, double value) {
    _values[index] = math.max(_values[index], value);
  }

  /// Sets the positions greater than or equal to [start] and less than [end],
  /// to [fillValue].
  void fillRange(int start, int end, double fillValue) {
    assert(start <= end);
    if (start == end) return;
    _values.fillRange(start, end, fillValue);
  }

  void multiplyAllFrom(IndexedScore other) {
    multiplyAllFromValues(other._values);
  }

  void multiplyAllFromValues(List<double> values) {
    assert(_values.length == values.length);
    for (var i = 0; i < _values.length; i++) {
      if (_values[i] == 0.0) continue;
      final v = values[i];
      _values[i] = v == 0.0 ? 0.0 : _values[i] * v;
    }
  }

  List<int> topIndices(int count, {double? minValue}) {
    minValue ??= 0.0;
    final heap = Heap<int>((a, b) => -_values[a].compareTo(_values[b]));
    for (var i = 0; i < length; i++) {
      final v = _values[i];
      if (v < minValue) continue;
      heap.collect(i);
    }
    return heap.getAndRemoveTopK(count).toList();
  }
}
