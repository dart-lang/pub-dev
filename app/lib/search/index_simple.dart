// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:meta/meta.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:pana/pana.dart' show DependencyTypes;
import 'package:path/path.dart' as p;

import '../shared/search_service.dart';
import '../shared/utils.dart' show boundedList, StringInternPool;

import 'platform_specificity.dart';
import 'scoring.dart';
import 'text_utils.dart';

/// The [PackageIndex] for Dart SDK API.
PackageIndex get dartSdkIndex => ss.lookup(#_dartSdkIndex) as PackageIndex;

/// Register a new [PackageIndex] for Dart SDK API.
void registerDartSdkIndex(PackageIndex index) =>
    ss.register(#_dartSdkIndex, index);

/// The [PackageIndex] registered in the current service scope.
PackageIndex get packageIndex =>
    ss.lookup(#packageIndexService) as PackageIndex;

/// Register a new [PackageIndex] in the current service scope.
void registerPackageIndex(PackageIndex index) =>
    ss.register(#packageIndexService, index);

class SimplePackageIndex implements PackageIndex {
  final bool _isSdkIndex;
  final String _urlPrefix;
  final Map<String, PackageDocument> _packages = <String, PackageDocument>{};
  final Map<String, String> _normalizedPackageText = <String, String>{};
  final TokenIndex _nameIndex = TokenIndex(minLength: 2);
  final TokenIndex _descrIndex = TokenIndex(minLength: 3);
  final TokenIndex _readmeIndex = TokenIndex(minLength: 3);
  final TokenIndex _apiSymbolIndex = TokenIndex(minLength: 2);
  final TokenIndex _apiDartdocIndex = TokenIndex(minLength: 3);
  final StringInternPool _internPool = StringInternPool();
  DateTime _lastUpdated;
  bool _isReady = false;

  SimplePackageIndex()
      : _isSdkIndex = false,
        _urlPrefix = null;

  SimplePackageIndex.sdk({@required String urlPrefix})
      : _isSdkIndex = true,
        _urlPrefix = urlPrefix;

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
          DateTime.now().difference(_lastUpdated).toString();
    }

    return data;
  }

  @override
  Future addPackage(PackageDocument document) async {
    final PackageDocument doc = document.intern(_internPool.intern);

    // isDiscontinued may be null
    if (document.isDiscontinued == true) {
      await removePackage(doc.package);
      return;
    }

    _packages[doc.package] = doc;
    _nameIndex.add(doc.package, doc.package);
    _descrIndex.add(doc.package, doc.description);
    _readmeIndex.add(doc.package, doc.readme);
    for (ApiDocPage page in doc.apiDocPages ?? const []) {
      final pageId = _apiDocPageId(doc.package, page);
      if (page.symbols != null && page.symbols.isNotEmpty) {
        _apiSymbolIndex.add(pageId, page.symbols.join(' '));
      }
      if (page.textBlocks != null && page.textBlocks.isNotEmpty) {
        _apiDartdocIndex.add(pageId, page.textBlocks.join(' '));
      }
    }
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
    for (ApiDocPage page in doc.apiDocPages ?? const []) {
      final pageId = _apiDocPageId(doc.package, page);
      _apiSymbolIndex.remove(pageId);
      _apiDartdocIndex.remove(pageId);
    }
  }

  @override
  Future<PackageSearchResult> search(SearchQuery query) async {
    final Set<String> packages = Set.from(_packages.keys);

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
    if (query.platform != null) {
      packages.removeWhere((package) {
        final doc = _packages[package];
        if (doc.platforms == null) return true;
        return !doc.platforms.contains(query.platform);
      });
      platformSpecificity = <String, double>{};
      packages.forEach((String package) {
        final PackageDocument doc = _packages[package];
        platformSpecificity[package] =
            scorePlatformSpecificity(doc.platforms, query.platform);
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
        if (doc?.emails == null) {
          return true;
        }
        for (String email in query.parsedQuery.emails) {
          final isDomainMatch = email.startsWith('@') &&
              doc.emails.where((e) => e.endsWith(email)).isNotEmpty;
          if (isDomainMatch || doc.emails.contains(email)) {
            return false;
          }
        }
        return true;
      });
    }

    // filter on ad
    if (query.isAd ?? false) {
      packages.removeWhere((package) {
        final doc = _packages[package];
        return doc.doNotAdvertise ?? false;
      });
    }

    // Remove legacy packages, if not included in the query.
    if (!query.includeLegacy) {
      packages.removeWhere((p) {
        return (_packages[p]?.supportsOnlyLegacySdk ?? false);
      });
    }

    // do text matching
    final isApiEnabled = query.isApiEnabled || query.parsedQuery.isApiEnabled;
    final textResults =
        _searchText(packages, query.parsedQuery.text, isApiEnabled);

    // filter packages that doesn't match text query
    if (textResults != null) {
      final keys = textResults.pkgScore.getKeys();
      packages.removeWhere((x) => !keys.contains(x));
    }

    List<PackageScore> results;
    switch (query.order ?? SearchOrder.top) {
      case SearchOrder.top:
        final List<Score> scores = [
          _getOverallScore(packages),
        ];
        if (query.order == null && textResults != null) {
          scores.add(textResults.pkgScore);
        }
        if (query.order == null && platformSpecificity != null) {
          scores.add(Score(platformSpecificity));
        }
        Score overallScore = Score.multiply(scores);
        // If there is an exact match for a package name, promote it to the top position.
        final queryText = query?.parsedQuery?.text;
        final matchingPackage = queryText == null
            ? null
            : (_packages[queryText] ?? _packages[queryText.toLowerCase()]);
        if (matchingPackage != null &&
            matchingPackage.maintenance != null &&
            matchingPackage.maintenance > 0.0) {
          final double maxValue = overallScore.getMaxValue();
          final map = Map<String, double>.from(
              overallScore.map((key, value) => value * 0.99)._values);
          map[matchingPackage.package] = maxValue;
          overallScore = Score(map);
        }
        results = _rankWithValues(overallScore.getValues());
        break;
      case SearchOrder.text:
        results = _rankWithValues(textResults.pkgScore.getValues());
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
    results = boundedList(results, offset: query.offset, limit: query.limit);

    if (textResults != null &&
        textResults.topApiPages != null &&
        textResults.topApiPages.isNotEmpty) {
      results = results.map((ps) {
        final apiPages = textResults.topApiPages[ps.package]
            // TODO: extract title for the page
            ?.map((String page) => ApiPageRef(path: page))
            ?.toList();
        return ps.change(apiPages: apiPages);
      }).toList();
    }

    if (_isSdkIndex) {
      results = results.map((ps) {
        String url = _urlPrefix;
        final doc = _packages[ps.package];
        final description = doc.description ?? ps.package;
        if (doc.apiDocPages != null && doc.apiDocPages.isNotEmpty) {
          final libPage = doc.apiDocPages.firstWhere(
            (dp) => dp.relativePath.endsWith('-library.html'),
            orElse: () => doc.apiDocPages.first,
          );
          url = p.join(_urlPrefix, libPage.relativePath);
        }
        final apiPages = ps.apiPages
            ?.map((ref) => ref.change(url: p.join(_urlPrefix, ref.path)))
            ?.toList();
        return ps.change(
          url: url,
          version: doc.version,
          description: description,
          apiPages: apiPages,
        );
      }).toList();
    }

    return PackageSearchResult(
      totalCount: totalCount,
      indexUpdated: _lastUpdated?.toIso8601String(),
      packages: results,
    );
  }

  @override
  Future merge() async {
    _isReady = true;
    _lastUpdated = DateTime.now().toUtc();
    _internPool.checkUnboundGrowth();
  }

  // visible for testing only
  Map<String, double> getHealthScore(Iterable<String> packages) {
    return Map.fromIterable(
      packages,
      value: (package) => (_packages[package].health ?? 0.0),
    );
  }

  // visible for testing only
  Map<String, double> getPopularityScore(Iterable<String> packages) {
    return Map.fromIterable(
      packages,
      value: (package) => _packages[package].popularity ?? 0.0,
    );
  }

  // visible for testing only
  Map<String, double> getMaintenanceScore(Iterable<String> packages) {
    return Map.fromIterable(
      packages,
      value: (package) => (_packages[package].maintenance ?? 0.0),
    );
  }

  Score _getOverallScore(Iterable<String> packages) {
    final Map<String, double> values =
        Map.fromIterable(packages, value: (package) {
      final doc = _packages[package];
      final double overall = calculateOverallScore(
        popularity: doc.popularity ?? 0.0,
        health: doc.health ?? 0.0,
        maintenance: doc.maintenance ?? 0.0,
      );
      // don't multiply with zero.
      return 0.3 + 0.7 * overall;
    });
    return Score(values);
  }

  _TextResults _searchText(
      Set<String> packages, String text, bool isExperimental) {
    if (text != null && text.isNotEmpty) {
      final List<String> words = splitForIndexing(text).toList();
      final int wordCount = words.length;
      final pkgScores = <Score>[];
      final apiPagesScores = <Score>[];
      for (String word in words) {
        final nameTokens = _nameIndex.lookupTokens(word);
        final descrTokens = _descrIndex.lookupTokens(word);
        final readmeTokens = _readmeIndex.lookupTokens(word);

        final name = Score(_nameIndex.scoreDocs(nameTokens,
            weight: 1.00, wordCount: wordCount));
        final descr = Score(_descrIndex.scoreDocs(descrTokens,
            weight: 0.95, wordCount: wordCount));
        final readme = Score(_readmeIndex.scoreDocs(readmeTokens,
            weight: 0.90, wordCount: wordCount));

        Score apiScore;
        if (isExperimental) {
          final apiSymbolTokens = _apiSymbolIndex.lookupTokens(word);
          final apiDartdocTokens = _apiDartdocIndex.lookupTokens(word);
          final symbolPages = Score(_apiSymbolIndex.scoreDocs(apiSymbolTokens,
              weight: 0.95, wordCount: wordCount));
          final dartdocPages = Score(_apiDartdocIndex
              .scoreDocs(apiDartdocTokens, weight: 0.90, wordCount: wordCount));
          final apiPages = Score.max([symbolPages, dartdocPages]);
          apiPagesScores.add(apiPages);

          final apiPackages = <String, double>{};
          for (String key in apiPages.getKeys()) {
            final pkg = _apiDocPkg(key);
            final value = apiPages[key];
            apiPackages[pkg] = math.max(value, apiPackages[pkg] ?? 0.0);
          }
          apiScore = Score(apiPackages);
        } else {
          apiScore = Score({});
        }

        pkgScores.add(Score.max([name, descr, readme, apiScore]));
      }
      Score score = Score.multiply(pkgScores);

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
        score = Score(matched);
      }

      score = score.removeLowValues(fraction: 0.01, minValue: 0.001);

      final apiDocScore = Score.multiply(apiPagesScores);
      final apiDocKeys = apiDocScore.getKeys().toList()
        ..sort((a, b) => -apiDocScore[a].compareTo(apiDocScore[b]));
      final topApiPages = <String, List<String>>{};
      for (String key in apiDocKeys) {
        final pkg = _apiDocPkg(key);
        final pages = topApiPages.putIfAbsent(pkg, () => []);
        if (pages.length < 3) {
          final page = _apiDocPath(key);
          pages.add(page);
        }
      }

      return _TextResults(score, topApiPages);
    }
    return null;
  }

  List<PackageScore> _rankWithValues(Map<String, double> values) {
    final List<PackageScore> list = values.keys
        .map((package) {
          final score = values[package];
          return PackageScore(package: package, score: score);
        })
        .where((ps) => ps != null)
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
        .map((package) => PackageScore(package: _packages[package].package))
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

  String _apiDocPageId(String package, ApiDocPage page) {
    return '$package::${page.relativePath}';
  }

  String _apiDocPkg(String id) {
    return id.split('::').first;
  }

  String _apiDocPath(String id) {
    return id.split('::').last;
  }
}

class _TextResults {
  final Score pkgScore;
  final Map<String, List<String>> topApiPages;

  _TextResults(this.pkgScore, this.topApiPages);
}

/// Represents an evaluated score as an {id: score} map.
class Score {
  final Map<String, double> _values;

  Score(Map<String, double> values) : _values = Map.unmodifiable(values);

  Set<String> getKeys() => _values.keys.toSet();
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
  Score map(double f(String key, double value)) {
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
          _lookupCandidates
              .putIfAbsent(reduced, () => Set<String>())
              .add(token);
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
      final candidates = Set<String>();
      candidates.add(token);
      for (String reduced in deriveLookupCandidates(token)) {
        final set = _lookupCandidates[reduced];
        if (set != null) {
          candidates.addAll(set);
        }
      }
      final tokenNgrams = ngrams(token, _minLength, 6);
      for (String candidate in candidates) {
        double candidateWeight = 0.0;
        if (token == candidate) {
          candidateWeight = 1.0;
        } else {
          final candidateNgrams = ngrams(candidate, _minLength, 6);
          candidateWeight = _ngramSimilarity(tokenNgrams, candidateNgrams);
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

  // Weighted Jaccard-similarity metric of sets of strings.
  double _ngramSimilarity(Set<String> a, Set<String> b) {
    final intersection = a.intersection(b);
    if (intersection.isEmpty) return 0.0;

    int sumFn(int sum, String str) =>
        sum + math.min<int>(100, str.length * str.length);

    final intersectionWeight = intersection.fold<int>(0, sumFn);
    final supersetWeight =
        a.fold<int>(0, sumFn) + b.fold<int>(0, sumFn) - intersectionWeight;
    return intersectionWeight / supersetWeight;
  }

  /// Returns an {id: score} map of the documents stored in the [TokenIndex].
  /// The tokens in [tokenMatch] will be used to calculate a weighted sum of scores.
  Map<String, double> scoreDocs(TokenMatch tokenMatch,
      {double weight = 1.0, int wordCount = 1}) {
    // Summarize the scores for the documents.
    final queryWeight = tokenMatch.maxWeight;
    final Map<String, double> docScores = <String, double>{};
    for (String token in tokenMatch.tokens) {
      final docWeights = _inverseIds[token];
      for (String id in docWeights.keys) {
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
