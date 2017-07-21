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
  final Map<String, PackageDocument> _documents = <String, PackageDocument>{};
  final TokenIndex _nameIndex = new TokenIndex();
  final TokenIndex _descrIndex = new TokenIndex();
  final TokenIndex _readmeIndex = new TokenIndex();
  DateTime _lastUpdated;
  bool _isReady = false;

  @override
  bool get isReady => _isReady;

  @override
  Future add(PackageDocument doc) async {
    await removeUrl(doc.url);
    _documents[doc.url] = doc;
    _nameIndex.add(doc.url, doc.package);
    _descrIndex.add(doc.url, compactDescription(doc.description));
    _readmeIndex.add(doc.url, compactReadme(doc.readme));
  }

  @override
  Future addAll(Iterable<PackageDocument> documents) async {
    for (PackageDocument doc in documents) {
      await add(doc);
    }
  }

  @override
  Future removeUrl(String url) async {
    final PackageDocument doc = _documents.remove(url);
    if (doc == null) return;
    _nameIndex.removeUrl(url);
    _descrIndex.removeUrl(url);
    _readmeIndex.removeUrl(url);
  }

  @override
  Future<bool> contains(String url, String version, String devVersion) async {
    final PackageDocument doc = _documents[url];
    return doc != null && doc.version == version && doc.devVersion == null;
  }

  @override
  Future<PackageSearchResult> search(PackageQuery query) async {
    final Map<String, double> total = <String, double>{};
    void addAll(Map<String, double> scores, double weight) {
      scores.forEach((String url, double score) {
        final double prev = total[url] ?? 0.0;
        total[url] = prev + score * weight;
      });
    }

    addAll(_nameIndex.search(query.text), 0.80);
    addAll(_descrIndex.search(query.text), 0.10);
    addAll(_readmeIndex.search(query.text), 0.05);

    final Map<String, double> popularityScores = new Map.fromIterable(
      total.keys,
      value: (String url) => _documents[url].popularity * 100,
    );
    addAll(popularityScores, 0.05);

    List<PackageScore> results = <PackageScore>[];
    for (String url in total.keys) {
      final PackageDocument doc = _documents[url];

      // filter on type
      if (query.type != null &&
          (doc.detectedTypes == null ||
              !doc.detectedTypes.contains(query.type))) {
        continue;
      }

      results.add(new PackageScore(
        url: doc.url,
        package: doc.package,
        version: doc.version,
        devVersion: doc.devVersion,
        score: total[url],
      ));
    }

    results.sort((a, b) => -a.score.compareTo(b.score));

    // filter out the noise (maybe a single matching ngram)
    if (results.isNotEmpty) {
      final double bestScore = results.first.score;
      final double scoreTreshold = bestScore / 25;
      results.removeWhere((pr) => pr.score < scoreTreshold);
    }

    // bound by offset and limit
    final int totalCount = min(maxSearchResults, results.length);
    if (query.offset != null && query.offset > 0) {
      if (query.offset > totalCount) {
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

  @override
  Future<int> indexSize() async => -1;
}

class TokenIndex {
  final Map<String, Set<String>> _inverseUrls = <String, Set<String>>{};
  final Map<String, double> _weights = <String, double>{};

  /// The number of tokens stored in the index.
  int get tokenCount => _inverseUrls.length;

  void add(String url, String text) {
    final Set<String> tokens = _tokenize(normalizeBeforeIndexing(text));
    if (tokens == null || tokens.isEmpty) return;
    double sumWeight = 0.0;
    for (String token in tokens) {
      final Set<String> set = _inverseUrls.putIfAbsent(token, () => new Set());
      set.add(url);
      sumWeight += _tokenWeight(token);
    }
    _weights[url] = sumWeight;
  }

  void removeUrl(String url) {
    _weights.remove(url);
    final List<String> removeKeys = [];
    _inverseUrls.forEach((String key, Set<String> set) {
      set.remove(url);
      if (set.isEmpty) removeKeys.add(key);
    });
    removeKeys.forEach(_inverseUrls.remove);
  }

  // A TF-IDF-like scoring, with more weight for longer terms.
  Map<String, double> search(String text) {
    final Set<String> tokens = _tokenize(normalizeBeforeIndexing(text));
    if (tokens == null || tokens.isEmpty) return null;
    double sumWeight = 0.0;
    final Map<String, double> counts = <String, double>{};
    for (String token in tokens) {
      final double tokenWeight = _tokenWeight(token);
      sumWeight += tokenWeight;

      final Set<String> set = _inverseUrls[token];
      if (set == null || set.isEmpty) continue;

      for (String url in set) {
        final double prevValue = counts[url] ?? 0.0;
        counts[url] = prevValue + tokenWeight;
      }
    }
    for (String url in counts.keys.toList()) {
      final double current = counts[url];
      counts[url] = 100.0 * (current / _weights[url]) * (current / sumWeight);
    }
    return counts;
  }

  double _tokenWeight(String token) => (token.length * token.length).toDouble();
}

Set<String> _tokenize(String text) {
  text = normalizeBeforeIndexing(text);
  if (text.isEmpty) return null;
  final Set<String> ngrams = new Set();
  for (int ngramLength = 1; ngramLength <= 4; ngramLength++) {
    if (text.length <= ngramLength) {
      ngrams.add(text);
    } else {
      for (int i = 0; i <= text.length - ngramLength; i++) {
        ngrams.add(text.substring(i, i + ngramLength));
      }
    }
  }
  return ngrams;
}
