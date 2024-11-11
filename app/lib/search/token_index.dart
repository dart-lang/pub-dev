// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'text_utils.dart';

/// Represents an evaluated score as an {id: score} map.
extension type const Score._(Map<String, double> _values)
    implements Map<String, double> {
  static const Score empty = Score._({});

  Score(this._values);

  factory Score.fromEntries(Iterable<MapEntry<String, double>> entries) =>
      Score(Map.fromEntries(entries));

  double get maxValue => _values.values.fold(0.0, math.max);

  /// Calculates the intersection of the [scores], by multiplying the values.
  static Score multiply(List<Score> scores) {
    if (scores.isEmpty) {
      return Score.empty;
    }
    if (scores.length == 1) {
      return scores.single;
    }
    if (scores.any((score) => score.isEmpty)) {
      return Score.empty;
    }
    var keys = scores.first.keys.toSet();
    for (var i = 1; i < scores.length; i++) {
      keys = keys.intersection(scores[i].keys.toSet());
    }
    if (keys.isEmpty) {
      return Score.empty;
    }
    final values = <String, double>{};
    for (final key in keys) {
      var value = scores.first[key]!;
      for (var i = 1; i < scores.length; i++) {
        value *= scores[i][key]!;
      }
      values[key] = value;
    }
    return Score(values);
  }

  /// Calculates the union of the [scores], by using the maximum values from
  /// the sets.
  static Score max(List<Score> scores) {
    // remove empty scores
    scores.removeWhere((s) => s.isEmpty);

    if (scores.isEmpty) {
      return Score.empty;
    }
    if (scores.length == 1) {
      return scores.single;
    }
    final keys = scores.expand((e) => e.keys).toSet();
    final result = <String, double>{};
    for (final key in keys) {
      var value = 0.0;
      for (var i = 0; i < scores.length; i++) {
        final v = scores[i][key];
        if (v != null) {
          value = math.max(value, v);
        }
      }
      result[key] = value;
    }
    return Score(result);
  }

  /// Remove insignificant values below a certain threshold:
  /// - [fraction] of the maximum value
  /// - [minValue] as an absolute minimum filter
  Score removeLowValues({double? fraction, double? minValue}) {
    assert(minValue != null || fraction != null);
    double? threshold = minValue;
    if (fraction != null) {
      final double fractionValue = maxValue * fraction;
      threshold ??= fractionValue;
      threshold = math.max(threshold, fractionValue);
    }
    if (threshold == null) {
      return this;
    }
    return Score.fromEntries(
        _values.entries.where((entry) => entry.value >= threshold!));
  }

  /// Keeps the scores only for values in [keys].
  Score project(Set<String> keys) => Score.fromEntries(
      _values.entries.where((entry) => keys.contains(entry.key)));

  /// Transfer the score values with [f].
  Score mapValues(double Function(String key, double value) f) =>
      Score.fromEntries(
          _values.entries.map((e) => MapEntry(e.key, f(e.key, e.value))));
}

/// The weighted tokens used for the final search.
class TokenMatch {
  final Map<String, double> _tokenWeights = <String, double>{};
  double? _maxWeight;

  double? operator [](String token) => _tokenWeights[token];

  void operator []=(String token, double weight) {
    _tokenWeights[token] = weight;
    _maxWeight = null;
  }

  Iterable<String> get tokens => _tokenWeights.keys;

  double get maxWeight =>
      _maxWeight ??= _tokenWeights.values.fold<double>(0.0, math.max);

  Map<String, double> get tokenWeights => _tokenWeights;

  void addWithMaxValue(String token, double weight) {
    final old = _tokenWeights[token] ?? 0.0;
    if (old < weight) {
      _tokenWeights[token] = weight;
    }
  }
}

/// Stores a token -> documentId inverted index with weights.
class TokenIndex<K> {
  final List<K> _ids;

  /// Maps token Strings to a weighted documents (addressed via indexes).
  final _inverseIds = <String, Map<int, double>>{};

  late final _length = _ids.length;

  TokenIndex(List<K> ids, List<String?> values) : _ids = ids {
    assert(ids.length == values.length);
    final length = values.length;
    for (var i = 0; i < length; i++) {
      final text = values[i];

      if (text == null) {
        continue;
      }
      final tokens = tokenize(text);
      if (tokens == null || tokens.isEmpty) {
        continue;
      }
      // Document weight is a highly scaled-down proxy of the length.
      final dw = 1 + math.log(1 + tokens.length) / 100;
      for (final e in tokens.entries) {
        final token = e.key;
        final weights = _inverseIds.putIfAbsent(token, () => {});
        weights[i] = math.max(weights[i] ?? 0.0, e.value / dw);
      }
    }
  }

  factory TokenIndex.fromMap(Map<K, String> map) {
    final keys = map.keys.toList();
    final values = map.values.toList();
    return TokenIndex(keys, values);
  }

  /// Match the text against the corpus and return the tokens or
  /// their partial segments that have match.
  @visibleForTesting
  TokenMatch lookupTokens(String text) {
    final tokenMatch = TokenMatch();

    for (final word in splitForIndexing(text)) {
      final tokens = tokenize(word, isSplit: true) ?? {};

      final present =
          tokens.keys.where((token) => _inverseIds.containsKey(token)).toList();
      if (present.isEmpty) {
        return TokenMatch();
      }
      final bestTokenValue =
          present.map((token) => tokens[token]!).reduce(math.max);
      final minTokenValue = bestTokenValue * 0.7;
      for (final token in present) {
        final value = tokens[token]!;
        if (value >= minTokenValue) {
          tokenMatch.addWithMaxValue(token, value);
        }
      }
    }

    return tokenMatch;
  }

  /// Search the index for [words], with a (term-match / document coverage percent)
  /// scoring.
  IndexedScore<K> searchWords(List<String> words, {double weight = 1.0}) {
    IndexedScore<K>? score;
    weight = math.pow(weight, 1 / words.length).toDouble();
    for (final w in words) {
      final s = IndexedScore(_ids);
      searchAndAccumulate(w, score: s, weight: weight);
      if (score == null) {
        score = s;
      } else {
        score.multiplyAllFrom(s);
      }
    }
    return score ?? IndexedScore(_ids);
  }

  /// Searches the index with [word] and stores the results in [score], using
  /// accumulation operation on the already existing values.
  void searchAndAccumulate(
    String word, {
    double weight = 1.0,
    required IndexedScore score,
  }) {
    assert(score.length == _length);
    final tokenMatch = lookupTokens(word);
    for (final token in tokenMatch.tokens) {
      final matchWeight = tokenMatch[token]!;
      final tokenWeight = _inverseIds[token]!;
      for (final e in tokenWeight.entries) {
        score.setValueMaxOf(e.key, matchWeight * e.value * weight);
      }
    }
  }
}

extension StringTokenIndexExt on TokenIndex<String> {
  /// Search the index for [text], with a (term-match / document coverage percent)
  /// scoring.
  @visibleForTesting
  Map<String, double> search(String text) {
    return searchWords(splitForQuery(text)).toScore();
  }
}

/// Mutable score list that can accessed via integer index.
class IndexedScore<K> {
  final List<K> _keys;
  final List<double> _values;

  IndexedScore._(this._keys, this._values);

  factory IndexedScore(List<K> keys, [double value = 0.0]) =>
      IndexedScore._(keys, List<double>.filled(keys.length, value));

  factory IndexedScore.fromMap(Map<K, double> values) =>
      IndexedScore._(values.keys.toList(), values.values.toList());

  List<K> get keys => _keys;
  late final length = _values.length;

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

  void removeWhere(bool Function(int index, K key) fn) {
    for (var i = 0; i < length; i++) {
      if (isNotPositive(i)) continue;
      if (fn(i, _keys[i])) {
        _values[i] = 0.0;
      }
    }
  }

  void retainWhere(bool Function(int index, K key) fn) {
    for (var i = 0; i < length; i++) {
      if (isNotPositive(i)) continue;
      if (!fn(i, _keys[i])) {
        _values[i] = 0.0;
      }
    }
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

  Set<K> toKeySet() {
    final set = <K>{};
    for (var i = 0; i < _values.length; i++) {
      final v = _values[i];
      if (v > 0.0) {
        set.add(_keys[i]);
      }
    }
    return set;
  }

  Map<K, double> top(int count, {double? minValue}) {
    final list = <int>[];
    double? lastValue;
    for (var i = 0; i < length; i++) {
      final v = _values[i];
      if (minValue != null && v < minValue) continue;
      if (list.length == count) {
        if (lastValue != null && lastValue >= v) continue;
        list[count - 1] = i;
      } else {
        list.add(i);
      }
      list.sort((a, b) => -_values[a].compareTo(_values[b]));
      lastValue = _values[list.last];
    }
    return Map.fromEntries(list.map((i) => MapEntry(_keys[i], _values[i])));
  }
}

extension StringIndexedScoreExt on IndexedScore<String> {
  Score toScore() {
    final map = <String, double>{};
    for (var i = 0; i < _values.length; i++) {
      final v = _values[i];
      if (v > 0.0) {
        map[_keys[i]] = v;
      }
    }
    return Score._(map);
  }
}
