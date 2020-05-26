// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'text_utils.dart';

/// Represents an evaluated score as an {id: score} map.
class Score {
  final Map<String, double> _values;

  Score(Map<String, double> values) : _values = Map.unmodifiable(values);

  Set<String> getKeys({bool Function(String key) where}) =>
      _values.keys.where((e) => where == null || where(e)).toSet();
  double getMaxValue() => _values.values.fold(0.0, math.max);
  Map<String, double> getValues() => _values;
  bool containsKey(String key) => _values.containsKey(key);

  double operator [](String key) => _values[key] ?? 0.0;

  /// Calculates the intersection of the [scores], by multiplying the values.
  static Score multiply(List<Score> scores) {
    Set<String> keys;
    for (Score score in scores) {
      if (keys == null) {
        keys = score.getKeys();
      } else {
        keys = keys.intersection(score.getKeys());
      }
    }
    if (keys == null || keys.isEmpty) {
      return Score({});
    }
    return Score(Map.fromIterable(
      keys,
      value: (key) =>
          scores.fold(1.0, (double value, Score s) => s[key as String] * value),
    ));
  }

  /// Calculates the union of the [scores], by using the maximum values from
  /// the sets.
  static Score max(List<Score> scores) {
    final result = <String, double>{};
    for (Score score in scores) {
      for (String key in score.getKeys()) {
        result[key] = math.max(result[key] ?? 0.0, score[key]);
      }
    }
    return Score(result);
  }

  /// Remove insignificant values below a certain threshold:
  /// - [fraction] of the maximum value
  /// - [minValue] as an absolute minimum filter
  Score removeLowValues({double fraction, double minValue}) {
    assert(minValue != null || fraction != null);
    double threshold = minValue;
    if (fraction != null) {
      final double fractionValue = getMaxValue() * fraction;
      threshold ??= fractionValue;
      threshold = math.max(threshold, fractionValue);
    }
    if (threshold == null) {
      return this;
    }
    final result = <String, double>{};
    for (String key in _values.keys) {
      final double value = _values[key];
      if (value < threshold) continue;
      result[key] = value;
    }
    return Score(result);
  }

  /// Keeps the scores only for values in [keys].
  Score project(Iterable<String> keys) {
    final result = <String, double>{};
    for (String key in keys) {
      final double value = _values[key];
      if (value == null) continue;
      result[key] = value;
    }
    return Score(result);
  }

  /// Transfer the score values with [f].
  Score map(double Function(String key, double value) f) {
    final result = <String, double>{};
    for (String key in _values.keys) {
      result[key] = f(key, _values[key]);
    }
    return Score(result);
  }
}

/// The weighted tokens used for the final search.
class TokenMatch {
  final Map<String, double> _tokenWeights = <String, double>{};
  double _maxWeight;

  double operator [](String token) => _tokenWeights[token];

  void operator []=(String token, double weight) {
    _tokenWeights[token] = weight;
    _maxWeight = null;
  }

  Iterable<String> get tokens => _tokenWeights.keys;

  double get maxWeight =>
      _maxWeight ??= _tokenWeights.values.fold(0.0, math.max);

  Map<String, double> get tokenWeights => Map.unmodifiable(_tokenWeights);
}

/// Stores a token -> documentId inverted index with weights.
class TokenIndex {
  /// {id: hash} map to detect if a document update or removal is a no-op.
  final _textHashes = <String, String>{};

  /// Maps token Strings to a weighted map of document ids.
  final _inverseIds = <String, Map<String, double>>{};

  /// Maps lookup candidates to their original token form.
  final _lookupCandidates = <String, Set<String>>{};

  /// {id: size} map to store a value representative to the document length
  final _docSizes = <String, double>{};
  final int _minLength;

  TokenIndex({int minLength = 0}) : _minLength = minLength;

  /// The number of tokens stored in the index.
  int get tokenCount => _inverseIds.length;

  int get documentCount => _docSizes.length;

  void add(String id, String text) {
    final tokens = tokenize(text);
    if (tokens == null || tokens.isEmpty) {
      if (_textHashes.containsKey(id)) {
        remove(id);
      }
      return;
    }
    final String textHash = '${text.hashCode}/${tokens.length}';
    if (_textHashes.containsKey(id) && _textHashes[id] != textHash) {
      remove(id);
    }
    for (String token in tokens.keys) {
      final Map<String, double> weights =
          _inverseIds.putIfAbsent(token, () => <String, double>{});
      // on the first insert of an entry, we populate the similarity candidates
      if (weights.isEmpty) {
        for (String reduced in deriveLookupCandidates(token)) {
          _lookupCandidates.putIfAbsent(reduced, () => <String>{}).add(token);
        }
      }
      weights[id] = math.max(weights[id] ?? 0.0, tokens[token]);
    }
    // Document size is a highly scaled-down proxy of the length.
    final docSize = 1 + math.log(1 + tokens.length) / 100;
    _docSizes[id] = docSize;
    _textHashes[id] = textHash;
  }

  void remove(String id) {
    _textHashes.remove(id);
    _docSizes.remove(id);
    final List<String> removeTokens = [];
    _inverseIds.forEach((String key, Map<String, double> weights) {
      weights.remove(id);
      if (weights.isEmpty) removeTokens.add(key);
    });
    removeTokens.forEach(_inverseIds.remove);
    removeTokens.forEach((token) {
      for (String reduced in deriveLookupCandidates(token)) {
        final set = _lookupCandidates[reduced];
        set.remove(token);
        if (set.isEmpty) {
          _lookupCandidates.remove(reduced);
        }
      }
    });
  }

  /// Match the text against the corpus and return the tokens that have match.
  TokenMatch lookupTokens(String text) {
    final TokenMatch tokenMatch = TokenMatch();
    final tokens = tokenize(text) ?? {};

    // Check which tokens have documents, and assign their weight.
    for (String token in tokens.keys) {
      final candidates = <String>{};
      candidates.add(token);
      if (_lookupCandidates.containsKey(token)) {
        candidates.addAll(_lookupCandidates[token]);
      }
      for (String reduced in deriveLookupCandidates(token)) {
        if (_inverseIds.containsKey(reduced)) {
          candidates.add(reduced);
        }
        final set = _lookupCandidates[reduced];
        if (set != null) {
          candidates.addAll(set);
        }
      }
      Set<String> tokenNgrams;
      double tokenWeightSum;
      for (String candidate in candidates) {
        double candidateWeight = 0.0;
        if (token == candidate) {
          candidateWeight = 1.0;
        } else if (token.startsWith(candidate)) {
          candidateWeight = candidate.length / token.length;
          if (couldBeSingularAndPlural(candidate, token, isKnownPrefix: true)) {
            candidateWeight = math.pow(candidateWeight, 0.2).toDouble();
          }
        } else if (token.endsWith(candidate)) {
          candidateWeight = candidate.length / token.length;
        } else if (candidate.startsWith(token)) {
          candidateWeight = token.length / candidate.length;
          if (couldBeSingularAndPlural(token, candidate, isKnownPrefix: true)) {
            candidateWeight = math.pow(candidateWeight, 0.2).toDouble();
          }
        } else if (candidate.endsWith(token)) {
          candidateWeight = token.length / candidate.length;
        } else {
          tokenNgrams ??= ngrams(token, _minLength, 6);
          final candidateNgrams = ngrams(candidate, _minLength, 6);
          tokenWeightSum ??= tokenNgrams.fold<double>(0.0, _ngramWeightSum);
          candidateWeight =
              _ngramSimilarity(tokenNgrams, candidateNgrams, tokenWeightSum);
        }
        candidateWeight *= tokens[token];
        if (candidateWeight > 0.3) {
          final int foundCount = _inverseIds[candidate]?.length ?? 0;
          if (foundCount <= 0) continue;
          final double score = candidateWeight;
          final double old = tokenMatch[candidate];
          if (old == null || old < score) {
            tokenMatch[candidate] = score;
          }
        }
      }
    }
    return tokenMatch;
  }

  // Function to aggregate the N-gram set's weight based on the length of the tokens.
  double _ngramWeightSum(double sum, String str) {
    final len = str.length;
    if (len < _ngramSimilarityWeights.length) {
      return sum + _ngramSimilarityWeights[len];
    } else {
      return sum + _ngramSimilarityWeights.last;
    }
  }

  // Weighted Jaccard-similarity metric of sets of strings.
  double _ngramSimilarity(Set<String> a, Set<String> b, double aWeightSum) {
    // We are not calling `Set.intersection()` here, because that will also build a
    // new `Set`, which we don't need.
    final intersectionWeight =
        a.where((b.contains)).fold<double>(0, _ngramWeightSum);
    if (intersectionWeight == 0.0) return 0.0;

    final supersetWeight =
        aWeightSum + b.fold<double>(0, _ngramWeightSum) - intersectionWeight;
    return intersectionWeight / supersetWeight;
  }

  /// Returns an {id: score} map of the documents stored in the [TokenIndex].
  /// The tokens in [tokenMatch] will be used to calculate a weighted sum of scores.
  ///
  /// When [limitToIds] is specified, the result will contain only the set of
  /// identifiers in it.
  Map<String, double> scoreDocs(TokenMatch tokenMatch,
      {double weight = 1.0, int wordCount = 1, Set<String> limitToIds}) {
    // Summarize the scores for the documents.
    final queryWeight = tokenMatch.maxWeight;
    final Map<String, double> docScores = <String, double>{};
    for (String token in tokenMatch.tokens) {
      final docWeights = _inverseIds[token];
      for (String id in docWeights.keys) {
        if (limitToIds != null && !limitToIds.contains(id)) continue;
        final double prevValue = docScores[id] ?? 0.0;
        final double currentValue = tokenMatch[token] * docWeights[id];
        docScores[id] = math.max(prevValue, currentValue);
      }
    }

    // In multi-word queries we will penalize the score with the document size
    // for each word separately. As these scores will be mulitplied, we need to
    // compensate the formula in order to prevent multiple exponential penalties.
    final double wordSizeExponent = 1.0 / wordCount;

    // post-process match weights
    for (String id in docScores.keys.toList()) {
      double docSize = _docSizes[id];
      if (wordCount > 1) {
        docSize = math.pow(docSize, wordSizeExponent).toDouble();
      }
      docScores[id] = weight * docScores[id] / queryWeight / docSize;
    }
    return docScores;
  }

  /// Search the index for [text], with a (term-match / document coverage percent)
  /// scoring. Longer tokens weight more in the relevance score.
  Map<String, double> search(String text) {
    return scoreDocs(lookupTokens(text));
  }
}

/// Pre-calculated weight list for ngram similarity.
final _ngramSimilarityWeights =
    List<double>.generate(20, (i) => math.pow(i, 1.5).toDouble());
