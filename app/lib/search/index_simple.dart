// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:gcloud/service_scope.dart' as ss;

import '../shared/search_service.dart';

import 'text_utils.dart';

/// The [PackageIndex] registered in the current service scope.
PackageIndex get packageIndex => ss.lookup(#packageIndexService);

/// Register a new [PackageIndex] in the current service scope.
void registerPackageIndex(PackageIndex index) =>
    ss.register(#packageIndexService, index);

class SimplePackageIndex implements PackageIndex {
  final Map<String, PackageDocument> _packages = <String, PackageDocument>{};
  final TokenIndex _nameIndex = new TokenIndex(minLength: 2);
  final TokenIndex _descrIndex = new TokenIndex(minLength: 3);
  final TokenIndex _readmeIndex = new TokenIndex(minLength: 3);
  DateTime _lastUpdated;
  bool _isReady = false;

  @override
  bool get isReady => _isReady;

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
  Future addPackage(PackageDocument doc) async {
    await removePackage(doc.package);
    _packages[doc.package] = doc;
    _nameIndex.add(doc.package, doc.package);
    _descrIndex.add(doc.package, compactDescription(doc.description));
    _readmeIndex.add(doc.package, compactReadme(doc.readme));
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
  }

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    // do text matching
    final Score textScore = _searchText(query.text, query.packagePrefix);

    // The set of packages to filter on.
    final Set<String> packages =
        textScore?.getKeys()?.toSet() ?? _packages.keys.toSet();

    // filter on package prefix
    if (query.packagePrefix != null) {
      packages.removeWhere(
        (package) => !_packages[package]
            .package
            .toLowerCase()
            .startsWith(query.packagePrefix.toLowerCase()),
      );
    }

    // filter on platform
    if (query.platformPredicate != null) {
      packages.removeWhere((package) =>
          !query.platformPredicate.matches(_packages[package].platforms));
    }

    // reduce text results if filter did remove a package
    textScore?.removeWhere((key) => !packages.contains(key));

    List<PackageScore> results;
    switch (query.order ?? SearchOrder.overall) {
      case SearchOrder.overall:
        final Score overallScore = new Score()
          ..addValues(textScore?.values, 0.85)
          ..addValues(getPopularityScore(packages), 0.10)
          ..addValues(getHealthScore(packages), 0.05);
        results = _rankWithValues(overallScore.values);
        break;
      case SearchOrder.text:
        results = _rankWithValues(textScore.values);
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
  }

  // visible for testing only
  Map<String, double> getHealthScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (String package) => (_packages[package].health ?? 0.0) * 100,
    );
  }

  // visible for testing only
  Map<String, double> getPopularityScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (String package) => _packages[package].popularity * 100,
    );
  }

  // visible for testing only
  Map<String, double> getMaintenanceScore(Iterable<String> packages) {
    return new Map.fromIterable(
      packages,
      value: (String package) => (_packages[package].maintenance ?? 0.0) * 100,
    );
  }

  Score _searchText(String text, String packagePrefix) {
    if (text != null && text.isNotEmpty) {
      final Score textScore = new Score()
        ..addValues(_nameIndex.search(text, coverageWeight: 0.90), 0.60)
        ..addValues(_descrIndex.search(text, coverageWeight: 0.75), 0.20)
        ..addValues(_readmeIndex.search(text, coverageWeight: 0.50), 0.20);
      textScore.removeLowScores(0.05);
      textScore.removeWhere((id) => textScore.values[id] < 1.0);
      return textScore;
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
  final Map<String, double> values = <String, double>{};

  Iterable<String> getKeys() => values.keys;

  void addValues(Map<String, double> newValues, double weight) {
    if (newValues == null) return;
    newValues.forEach((String key, double score) {
      if (score != null) {
        final double prev = values[key] ?? 0.0;
        values[key] = prev + score * weight;
      }
    });
  }

  void removeWhere(bool keyCondition(String key)) {
    final Set<String> keysToRemove = values.keys.where(keyCondition).toSet();
    keysToRemove.forEach(values.remove);
  }

  void removeLowScores(double fraction) {
    final double maxValue = values.values.fold(0.0, max);
    final double cutoff = maxValue * fraction;
    removeWhere((key) => values[key] < cutoff);
  }
}

class TokenIndex {
  final Map<String, Set<String>> _inverseIds = <String, Set<String>>{};
  final Map<String, double> _weights = <String, double>{};
  final int _minLength;

  TokenIndex({int minLength: 0}) : _minLength = minLength;

  /// The number of tokens stored in the index.
  int get tokenCount => _inverseIds.length;

  void add(String id, String text) {
    final Set<String> tokens = _tokenize(text, _minLength);
    if (tokens == null || tokens.isEmpty) return;
    double sumWeight = 0.0;
    for (String token in tokens) {
      final Set<String> set = _inverseIds.putIfAbsent(token, () => new Set());
      set.add(id);
      sumWeight += _tokenWeight(token, _minLength);
    }
    _weights[id] = sumWeight;
  }

  void remove(String id) {
    _weights.remove(id);
    final List<String> removeKeys = [];
    _inverseIds.forEach((String key, Set<String> set) {
      set.remove(id);
      if (set.isEmpty) removeKeys.add(key);
    });
    removeKeys.forEach(_inverseIds.remove);
  }

  /// Search the index for [text], with a (term-match / document coverage percent)
  /// scoring. Longer tokens weight more in the relevance score.
  ///
  /// [coverageWeight] controls the weight of the document coverage percent in
  /// the final score. 1.0 - full coverage score is used, 0.0 - none is used.
  Map<String, double> search(String text, {double coverageWeight: 1.0}) {
    final Set<String> tokens = _tokenize(text, _minLength);
    if (tokens == null || tokens.isEmpty) return null;
    // the sum of all token weights in the search query
    double queryWeight = 0.0;
    final Map<String, double> docScores = <String, double>{};

    // use the inverted index to aggregate scores for each document
    for (String token in tokens) {
      final double tokenWeight = _tokenWeight(token, _minLength);
      queryWeight += tokenWeight;

      final Set<String> set = _inverseIds[token];
      if (set == null || set.isEmpty) continue;

      for (String id in set) {
        final double prevValue = docScores[id] ?? 0.0;
        docScores[id] = prevValue + tokenWeight;
      }
    }

    // normalize token weights to 0.0-1.0 range, also adjust to document coverage
    for (String id in docScores.keys.toList()) {
      final double matchWeight = docScores[id];

      // the percent of the match in relation to the total query [0.0 - 1.0]
      final double queryScore = matchWeight / queryWeight;

      // the percent of the match in relation to the document [0.0 - 1.0]
      final double coverageScore = matchWeight / _weights[id];

      final double weightedCoverageScore =
          1 - (coverageWeight * (1.0 - coverageScore));

      final double score = 100.0 * queryScore * weightedCoverageScore;
      docScores[id] = score;
    }
    return docScores;
  }

  // The longer the token, the more importance it has.
  // Length -> Weight
  // 1 ->  1 (Length * Length)
  // 2 ->  4 (Length * Length)
  // 3 ->  9 (Length * Length)
  // 4 -> 16 (Length * Length)
  // 5 -> 25 (Length * Length)
  // 6 -> 36 (Length * Length)
  // 7 -> 49 (Length * Length)
  // 8 -> 64 (Length * Length)
  // 9 -> 72 (Length * 8)
  //10 -> 80 (Length * 8)
  double _tokenWeight(String token, int minLength) {
    int tokenLength = token.length;
    if (minLength > 0) {
      tokenLength -= minLength - 1;
    }
    return (tokenLength * min(token.length, 8)).toDouble();
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

    for (int ngramLength = max(minNgram, minLength);
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
