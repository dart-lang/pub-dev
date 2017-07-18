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
  final Map<String, PackageDocument> _documents = {};
  final _TokenIndex _nameIndex = new _TokenIndex();
  final _TokenIndex _descrIndex = new _TokenIndex();
  final _TokenIndex _readmeIndex = new _TokenIndex();
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
    final Map<String, _PackageResult> resultMap = {};
    void addAll(Map<String, double> scores, double weight) {
      scores.forEach((String url, double score) {
        final _PackageResult pr =
            resultMap.putIfAbsent(url, () => new _PackageResult(url, 0.0));
        pr.score += score * weight;
      });
    }

    addAll(_nameIndex.search(query.text), 0.90);
    addAll(_descrIndex.search(query.text), 0.08);
    addAll(_readmeIndex.search(query.text), 0.02);

    List<_PackageResult> list = resultMap.values.toList();
    if (query.type != null) {
      list.removeWhere((pr) {
        final PackageDocument doc = _documents[pr.url];
        return doc.detectedTypes == null ||
            !doc.detectedTypes.contains(query.type);
      });
    }

    for (_PackageResult pr in list) {
      final PackageDocument doc = _documents[pr.url];
      pr.score = (pr.score * 7 + doc.popularity) / 8;
    }
    list.sort((a, b) => -a.score.compareTo(b.score));
    if (list.isNotEmpty) {
      final double bestScore = list.first.score;
      final double scoreTreshold = bestScore / 25;
      list.removeWhere((pr) => pr.score < scoreTreshold);
    }

    final int totalCount = min(maxSearchResults, list.length);
    if (query.offset != null && query.offset > 0) {
      if (query.offset > totalCount) {
        list = [];
      } else {
        list = list.sublist(query.offset);
      }
    }
    if (query.limit != null && list.length > query.limit) {
      list = list.sublist(0, query.limit);
    }

    return new PackageSearchResult(
      totalCount: totalCount,
      indexUpdated: _lastUpdated.toIso8601String(),
      packages: list.map((pr) {
        final PackageDocument doc = _documents[pr.url];
        return new PackageScore(
          url: doc.url,
          package: doc.package,
          version: doc.version,
          devVersion: doc.devVersion,
          score: pr.score,
        );
      }).toList(),
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

class _TokenIndex {
  final Map<String, Set<String>> _inverseUrls = {};
  final Map<String, double> _weights = {};

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
    for (Set<String> set in _inverseUrls.values) {
      set.remove(url);
      // TODO: remove set if it becomes empty
    }
  }

  // A TF-IDF-like scoring, with more weight for longer terms.
  Map<String, double> search(String text) {
    final Set<String> tokens = _tokenize(normalizeBeforeIndexing(text));
    if (tokens == null || tokens.isEmpty) return null;
    double sumWeight = 0.0;
    final Map<String, double> counts = {};
    for (String token in tokens) {
      final Set<String> set = _inverseUrls[token];
      if (set == null || set.isEmpty) continue;

      final double weight = _tokenWeight(token) / set.length;
      sumWeight += weight;

      for (String url in set) {
        final double prevValue = counts[url] ?? 0.0;
        counts[url] = prevValue + weight;
      }
    }
    for (String url in counts.keys.toList()) {
      counts[url] = 10000.0 * counts[url] / sumWeight / _weights[url];
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

class _PackageResult {
  final String url;
  double score;

  _PackageResult(this.url, this.score);
}
