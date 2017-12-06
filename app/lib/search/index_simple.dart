// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pana/pana.dart' show DependencyTypes;

import '../shared/search_service.dart';
import '../shared/utils.dart' show StringInternPool;

import 'platform_specificity.dart';
import 'scoring.dart';
import 'text_utils.dart';

/// The [PackageIndex] registered in the current service scope.
PackageIndex get packageIndex => ss.lookup(#packageIndexService);

/// Register a new [PackageIndex] in the current service scope.
void registerPackageIndex(PackageIndex index) =>
    ss.register(#packageIndexService, index);

class SimplePackageIndex implements PackageIndex {
  final Map<String, PackageDocument> _packages = <String, PackageDocument>{};
  final Map<String, String> _normalizedPackageText = <String, String>{};
  final TokenIndex _nameIndex = new TokenIndex(minLength: 2);
  final TokenIndex _descrIndex = new TokenIndex(minLength: 3);
  final TokenIndex _readmeIndex = new TokenIndex(minLength: 3);
  final StringInternPool _internPool = new StringInternPool();
  DateTime _lastUpdated;
  bool _isReady = false;

  @override
  bool get isReady => _isReady;

  @override
  Map<String, dynamic> get debugInfo {
    final data = {
      'packageCount': _packages.length,
      'lastUpdated': _lastUpdated?.toIso8601String(),
    };

    if (_lastUpdated != null) {
      data['lastUpdateDelta'] =
          new DateTime.now().difference(_lastUpdated).toString();
    }

    return data;
  }

  @override
  Future<bool> containsPackage(String package,
      {String version, Duration maxAge}) async {
    final PackageDocument doc = _packages[package];
    if (doc == null) return false;
    if (version != null && doc.version != version) return false;
    if (maxAge != null &&
        (doc.timestamp == null ||
            new DateTime.now().toUtc().difference(doc.timestamp) > maxAge)) {
      return false;
    }
    return true;
  }

  @override
  Future addPackage(PackageDocument document) async {
    final PackageDocument doc = document.intern(_internPool.intern);
    await removePackage(doc.package);
    _packages[doc.package] = doc;
    _nameIndex.add(doc.package, doc.package);
    _descrIndex.add(doc.package, doc.description);
    _readmeIndex.add(doc.package, doc.readme);
    final String allText = [doc.package, doc.description, doc.readme]
        .where((s) => s != null)
        .join(' ');
    _normalizedPackageText[doc.package] = normalizeBeforeIndexing(allText);
  }

  @override
  Future addPackages(Iterable<PackageDocument> documents) async {
    for (PackageDocument doc in documents) {
      await addPackage(doc);
    }
  }

  @override
  Future removePackage(String package) async {
    final PackageDocument doc = _packages.remove(package);
    if (doc == null) return;
    _nameIndex.remove(package);
    _descrIndex.remove(package);
    _readmeIndex.remove(package);
    _normalizedPackageText.remove(package);
  }

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    final Set<String> packages = new Set.from(_packages.keys);

    // filter on package prefix
    if (query.parsedQuery?.packagePrefix != null) {
      final String prefix = query.parsedQuery.packagePrefix.toLowerCase();
      packages.removeWhere(
        (package) =>
            !_packages[package].package.toLowerCase().startsWith(prefix),
      );
    }

    // filter on platform
    Map<String, double> platformSpecificity;
    if (query.platformPredicate != null) {
      packages.removeWhere((package) =>
          !query.platformPredicate.matches(_packages[package].platforms));
      platformSpecificity = <String, double>{};
      packages.forEach((String package) {
        final PackageDocument doc = _packages[package];
        platformSpecificity[package] =
            scorePlatformSpecificity(doc.platforms, query.platformPredicate);
      });
    }

    // filter on dependency
    if (query.parsedQuery.hasAnyDependency) {
      packages.removeWhere((package) {
        final doc = _packages[package];
        if (doc.dependencies == null) return true;
        for (String dependency in query.parsedQuery.allDependencies) {
          if (!doc.dependencies.containsKey(dependency)) return true;
        }
        for (String dependency in query.parsedQuery.refDependencies) {
          final String type = doc.dependencies[dependency];
          if (type == null || type == DependencyTypes.transitive) return true;
        }
        return false;
      });
    }

    // filter on email
    if (query.parsedQuery.emails.isNotEmpty) {
      packages.removeWhere((package) {
        final doc = _packages[package];
        for (String email in query.parsedQuery.emails) {
          if (doc?.emails?.contains(email) ?? false) {
            return false;
          }
        }
        return true;
      });
    }

    // do text matching
    final Score textScore = _searchText(packages, query.parsedQuery.text);
    final Score filtered = textScore ?? _initScore(packages);

    List<PackageScore> results;
    switch (query.order ?? SearchOrder.top) {
      case SearchOrder.top:
        final List<Score> scores = [
          filtered,
          _getOverallScore(packages),
        ];
        if (platformSpecificity != null) {
          scores.add(new Score(platformSpecificity));
        }
        final Score overallScore =
            Score.multiply(scores).removeLowValues(fraction: 0.01);
        results = _rankWithValues(overallScore.getValues());
        break;
      case SearchOrder.text:
        results = _rankWithValues(textScore.getValues());
        break;
      case SearchOrder.created:
        results = _rankWithComparator(packages, _compareCreated);
        break;
      case SearchOrder.updated:
        results = _rankWithComparator(packages, _compareUpdated);
        break;
      case SearchOrder.popularity:
        results = _rankWithValues(getPopularityScore(packages));
        break;
      case SearchOrder.health:
        results = _rankWithValues(getHealthScore(packages));
        break;
      case SearchOrder.maintenance:
        results = _rankWithValues(getMaintenanceScore(packages));
        break;
    }

    // bound by offset and limit
    final int totalCount = results.length;
    if (query.offset != null && query.offset > 0) {
      if (query.offset >= results.length) {
        results = <PackageScore>[];
      } else {
        results = results.sublist(query.offset);
      }
    }
    if (query.limit != null && results.length > query.limit) {
      results = results.sublist(0, query.limit);
    }

    return new PackageSearchResult(
      totalCount: totalCount,
      indexUpdated: _lastUpdated.toIso8601String(),
      packages: results,
    );
  }

  @override
  Future merge() async {
    _isReady = true;
    _lastUpdated = new DateTime.now().toUtc();
    _internPool.checkUnboundGrowth();
  }

  // visible for testing only
  Map<String, double> getHealthScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (package) => (_packages[package].health ?? 0.0),
    );
  }

  // visible for testing only
  Map<String, double> getPopularityScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (package) => _packages[package].popularity ?? 0.0,
    );
  }

  // visible for testing only
  Map<String, double> getMaintenanceScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (package) => (_packages[package].maintenance ?? 0.0),
    );
  }

  Score _getOverallScore(Iterable<String> packages) {
    final Map<String, double> values =
        new Map.fromIterable(packages, value: (package) {
      final doc = _packages[package];
      final double overall = calculateOverallScore(
        popularity: doc.popularity ?? 0.0,
        health: doc.health ?? 0.0,
        maintenance: doc.maintenance ?? 0.0,
      );
      // don't multiply with zero.
      return 0.3 + 0.7 * overall;
    });
    return new Score(values);
  }

  Score _initScore(Iterable<String> keys) =>
      new Score(new Map.fromIterable(keys, value: (_) => 1.0));

  Score _searchText(Set<String> packages, String text) {
    if (text != null && text.isNotEmpty) {
      final List<String> words = text.split(' ');
      final int wordCount = words.length;
      final List<Score> wordScores = words.map((String word) {
        final nameTokens = _nameIndex.lookupTokens(word);
        final descrTokens = _descrIndex.lookupTokens(word);
        final readmeTokens = _readmeIndex.lookupTokens(word);

        final maxTokenLength = math.max(nameTokens.maxLength,
            math.max(descrTokens.maxLength, readmeTokens.maxLength));
        nameTokens.removeShortTokens(maxTokenLength);
        descrTokens.removeShortTokens(maxTokenLength);
        readmeTokens.removeShortTokens(maxTokenLength);

        final name = new Score(_nameIndex.scoreDocs(nameTokens,
            weight: 1.00, wordCount: wordCount));
        final descr = new Score(_descrIndex.scoreDocs(descrTokens,
            weight: 0.95, wordCount: wordCount));
        final readme = new Score(_readmeIndex.scoreDocs(readmeTokens,
            weight: 0.90, wordCount: wordCount));
        return Score.max([name, descr, readme]).removeLowValues(
            fraction: 0.01, minValue: 0.001);
      }).toList();
      Score score = Score.multiply(wordScores);
      // Ideally this projection should happen earlier (in both lookupTokens and
      // scoreDocs), but for the sake of simplicity it is done here.
      score = score.project(packages);

      // filter results based on exact phrases
      final List<String> phrases =
          extractExactPhrases(text).map(normalizeBeforeIndexing).toList();
      if (phrases.isNotEmpty) {
        final Map<String, double> matched = <String, double>{};
        for (String package in score.getKeys()) {
          final allText = _normalizedPackageText[package];
          final bool matchedAllPhrases =
              phrases.every((phrase) => allText.contains(phrase));
          if (matchedAllPhrases) {
            matched[package] = score[package];
          }
        }
        score = new Score(matched);
      }

      return score;
    }
    return null;
  }

  List<PackageScore> _rankWithValues(Map<String, double> values) {
    final List<PackageScore> list = values.keys
        .map((package) => new PackageScore(
              package: _packages[package].package,
              score: values[package],
            ))
        .toList();
    list.sort((a, b) {
      final int scoreCompare = -a.score.compareTo(b.score);
      if (scoreCompare != 0) return scoreCompare;
      // if two packages got the same score, order by last updated
      return _compareUpdated(_packages[a.package], _packages[b.package]);
    });
    return list;
  }

  List<PackageScore> _rankWithComparator(
      Set<String> packages, int compare(PackageDocument a, PackageDocument b)) {
    final List<PackageScore> list = packages
        .map((package) => new PackageScore(package: _packages[package].package))
        .toList();
    list.sort((a, b) => compare(_packages[a.package], _packages[b.package]));
    return list;
  }

  int _compareCreated(PackageDocument a, PackageDocument b) {
    if (a.created == null) return -1;
    if (b.created == null) return 1;
    return -a.created.compareTo(b.created);
  }

  int _compareUpdated(PackageDocument a, PackageDocument b) {
    if (a.updated == null) return -1;
    if (b.updated == null) return 1;
    return -a.updated.compareTo(b.updated);
  }
}

class Score {
  final Map<String, double> _values;

  Score(Map<String, double> values) : _values = new Map.unmodifiable(values);

  Set<String> getKeys() => _values.keys.toSet();
  double getMaxValue() => _values.values.fold(0.0, math.max);
  Map<String, double> getValues() => _values;

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
    return new Score(new Map.fromIterable(
      keys,
      value: (key) =>
          scores.fold(1.0, (double value, Score s) => s[key] * value),
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
    return new Score(result);
  }

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
    return new Score(result);
  }

  Score project(Iterable<String> keys) {
    final result = <String, double>{};
    for (String key in keys) {
      final double value = _values[key];
      if (value == null) continue;
      result[key] = value;
    }
    return new Score(result);
  }

  Score map(double f(double value)) {
    final result = <String, double>{};
    for (String key in _values.keys) {
      result[key] = f(_values[key]);
    }
    return new Score(result);
  }
}

class TokenMatch {
  final Map<String, double> _tokenWeights = <String, double>{};
  double _sumWeight;
  int _maxLength;

  double operator [](String token) => _tokenWeights[token];

  void operator []=(String token, double weight) {
    _tokenWeights[token] = weight;
    _sumWeight = null;
    _maxLength = null;
  }

  Iterable<String> get tokens => _tokenWeights.keys;

  int get maxLength => _maxLength ??=
      _tokenWeights.keys.fold(0, (a, b) => math.max(a, b.length));

  double get sumWeight =>
      _sumWeight ??= _tokenWeights.values.fold(0.0, (a, b) => a + b);

  void removeShortTokens(int minLength) {
    for (String token in _tokenWeights.keys.toList()) {
      if (token.length < minLength) {
        _tokenWeights.remove(token);
      }
    }
    _sumWeight = null;
    _maxLength = null;
  }
}

class TokenIndex {
  final Map<String, Set<String>> _inverseIds = <String, Set<String>>{};
  final Map<String, double> _docSizes = <String, double>{};
  final int _minLength;

  TokenIndex({int minLength: 0}) : _minLength = minLength;

  /// The number of tokens stored in the index.
  int get tokenCount => _inverseIds.length;

  int get documentCount => _docSizes.length;

  void add(String id, String text) {
    final Set<String> tokens = _tokenize(text, _minLength);
    if (tokens == null || tokens.isEmpty) return;
    for (String token in tokens) {
      final Set<String> set = _inverseIds.putIfAbsent(token, () => new Set());
      set.add(id);
    }
    // Document size inspired by ElasticSearch's ranking.
    final docSize = math.sqrt(tokens.length);
    _docSizes[id] = docSize;
  }

  void remove(String id) {
    _docSizes.remove(id);
    final List<String> removeKeys = [];
    _inverseIds.forEach((String key, Set<String> set) {
      set.remove(id);
      if (set.isEmpty) removeKeys.add(key);
    });
    removeKeys.forEach(_inverseIds.remove);
  }

  /// Match the text against the corpus and return the tokens that have match.
  TokenMatch lookupTokens(String text) {
    final TokenMatch tokenMatch = new TokenMatch();
    final Set<String> tokens = _tokenize(text, _minLength);
    if (tokens == null || tokens.isEmpty) {
      return tokenMatch;
    }

    // Check which tokens have documents, and assign their weight.
    for (String token in tokens) {
      final int foundCount = _inverseIds[token]?.length ?? 0;
      if (foundCount == 0) continue;
      // Inverse document frequency score inspired by ElasticSearch's ranking.
      final double idf = 1.0 + math.log(documentCount / (foundCount + 1));
      tokenMatch[token] = idf * token.length;
    }
    return tokenMatch;
  }

  Map<String, double> scoreDocs(TokenMatch tokenMatch,
      {double weight: 1.0, int wordCount: 1}) {
    // Summarize the scores for the documents.
    final queryWeight = tokenMatch.sumWeight;
    final Map<String, double> docScores = <String, double>{};
    for (String token in tokenMatch.tokens) {
      for (String id in _inverseIds[token]) {
        final double prevValue = docScores[id] ?? 0.0;
        docScores[id] = prevValue + tokenMatch[token];
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
        docSize = math.pow(docSize, wordSizeExponent);
      }
      docScores[id] = weight * docScores[id] / queryWeight / docSize;
    }
    return docScores;
  }

  /// Search the index for [text], with a (term-match / document coverage percent)
  /// scoring. Longer tokens weight more in the relevance score.
  Map<String, double> search(String text) {
    final TokenMatch tokenMatch = lookupTokens(text);
    tokenMatch.removeShortTokens(tokenMatch.maxLength - 1);
    return scoreDocs(tokenMatch);
  }
}

const int minNgram = 1;
const int maxNgram = 4;
const int maxWordLength = 80;

Set<String> _tokenize(String originalText, int minLength) {
  if (originalText == null || originalText.isEmpty) return null;
  final Set<String> tokens = new Set();

  void addAllPrefixes(String phrase) {
    for (int i = maxNgram + 1; i < phrase.length; i++) {
      tokens.add(phrase.substring(0, i));
    }
    tokens.add(phrase);
  }

  for (String word in splitForIndexing(originalText)) {
    if (word.length > maxWordLength) word = word.substring(0, maxWordLength);

    final String normalizedWord = normalizeBeforeIndexing(word);
    if (normalizedWord.isEmpty) continue;

    for (int ngramLength = math.max(minNgram, minLength);
        ngramLength <= maxNgram;
        ngramLength++) {
      if (normalizedWord.length <= ngramLength) {
        tokens.add(normalizedWord);
      } else {
        for (int i = 0; i <= normalizedWord.length - ngramLength; i++) {
          tokens.add(normalizedWord.substring(i, i + ngramLength));
        }
      }
    }
    if (word.length <= maxNgram) continue; // ngrams covered everything

    // add all prefixes for better relevancy on longer phrases
    addAllPrefixes(normalizedWord);

    // scan for CamelCase phrases and index Case
    bool prevLower = _isLower(word[0]);
    for (int i = 1; i < word.length; i++) {
      final bool lower = _isLower(word[i]);
      if (!lower && prevLower) {
        final String part = word.substring(i);
        final String normalizedPart = normalizeBeforeIndexing(part);
        addAllPrefixes(normalizedPart);
      }
      prevLower = lower;
    }
  }
  if (minLength > 0) {
    tokens.removeWhere((t) => t.length < minLength);
  }
  return tokens;
}

bool _isLower(String c) => c.toLowerCase() == c;
