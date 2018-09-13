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
import '../shared/utils.dart' show StringInternPool;

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
  final TokenIndex _nameIndex = new TokenIndex(minLength: 2);
  final TokenIndex _descrIndex = new TokenIndex(minLength: 3);
  final TokenIndex _readmeIndex = new TokenIndex(minLength: 3);
  final TokenIndex _apiDocIndex = new TokenIndex(minLength: 3);
  final StringInternPool _internPool = new StringInternPool();
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
      final text = [page.symbols, page.textBlocks]
          .where((list) => list != null && list.isNotEmpty)
          .expand((list) => list)
          .join(' ');
      _apiDocIndex.add(_apiDocPageId(doc.package, page), text);
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
      _apiDocIndex.remove(_apiDocPageId(package, page));
    }
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
        for (String email in query.parsedQuery.emails) {
          if (doc?.emails?.contains(email) ?? false) {
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
          scores.add(new Score(platformSpecificity));
        }
        Score overallScore = Score.multiply(scores);
        // If there is an exact match for a package name (in the filtered result
        // set), promote that package to the top position.
        if (query.order == null &&
            query.hasQuery &&
            query?.parsedQuery?.text != null &&
            overallScore.containsKey(query.parsedQuery.text)) {
          final matchedPackage = query.parsedQuery.text;
          final double maxValue = overallScore.getMaxValue();
          overallScore = overallScore.map(
              (key, value) => key == matchedPackage ? maxValue : value * 0.99);
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

    if (textResults != null &&
        textResults.topApiPages != null &&
        textResults.topApiPages.isNotEmpty) {
      results = results.map((ps) {
        final apiPages = textResults.topApiPages[ps.package]
            // TODO: extract title for the page
            ?.map((String page) => new ApiPageRef(path: page))
            ?.toList();
        return ps.change(apiPages: apiPages);
      }).toList();
    }

    if (_isSdkIndex) {
      results = results.map((ps) {
        String url = _urlPrefix;
        final doc = _packages[ps.package];
        String description = doc.description ?? ps.package;
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

    return new PackageSearchResult(
      totalCount: totalCount,
      indexUpdated: _lastUpdated?.toIso8601String(),
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
        final apiDocTokens =
            isExperimental ? _apiDocIndex.lookupTokens(word) : new TokenMatch();

        final name = new Score(_nameIndex.scoreDocs(nameTokens,
            weight: 1.00, wordCount: wordCount));
        final descr = new Score(_descrIndex.scoreDocs(descrTokens,
            weight: 0.95, wordCount: wordCount));
        final readme = new Score(_readmeIndex.scoreDocs(readmeTokens,
            weight: 0.90, wordCount: wordCount));

        Score apiScore;
        if (isExperimental) {
          final apiPages = new Score(_apiDocIndex.scoreDocs(apiDocTokens,
              weight: 0.80, wordCount: wordCount));
          apiPagesScores.add(apiPages);

          final apiPackages = <String, double>{};
          for (String key in apiPages.getKeys()) {
            final pkg = _apiDocPkg(key);
            final value = apiPages[key];
            apiPackages[pkg] = math.max(value, apiPackages[pkg] ?? 0.0);
          }
          apiScore = new Score(apiPackages);
        } else {
          apiScore = new Score({});
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
        score = new Score(matched);
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

      return new _TextResults(score, topApiPages);
    }
    return null;
  }

  List<PackageScore> _rankWithValues(Map<String, double> values) {
    final List<PackageScore> list = values.keys
        .map((package) {
          final score = values[package];
          return new PackageScore(package: package, score: score);
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

class Score {
  final Map<String, double> _values;

  Score(Map<String, double> values) : _values = new Map.unmodifiable(values);

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
      return new Score({});
    }
    return new Score(new Map.fromIterable(
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

  Score map(double f(String key, double value)) {
    final result = <String, double>{};
    for (String key in _values.keys) {
      result[key] = f(key, _values[key]);
    }
    return new Score(result);
  }
}

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

  Map<String, double> get tokenWeights => new Map.unmodifiable(_tokenWeights);
}

class TokenIndex {
  final Map<String, String> _textHashes = <String, String>{};
  final Map<String, Set<String>> _inverseIds = <String, Set<String>>{};
  final Map<String, Set<String>> _inverseNgrams = <String, Set<String>>{};
  final Map<String, double> _docSizes = <String, double>{};
  final int _minLength;

  TokenIndex({int minLength: 0}) : _minLength = minLength;

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
      final Set<String> set = _inverseIds.putIfAbsent(token, () => new Set());
      set.add(id);
      _inverseNgrams.putIfAbsent(token, () => _ngrams(token, _minLength));
    }
    // Document size is a highly scaled-down proxy of the length.
    final docSize = 1 + math.log(1 + tokens.length) / 100;
    _docSizes[id] = docSize;
    _textHashes[id] = textHash;
  }

  void remove(String id) {
    _textHashes.remove(id);
    _docSizes.remove(id);
    final List<String> removeKeys = [];
    _inverseIds.forEach((String key, Set<String> set) {
      set.remove(id);
      if (set.isEmpty) removeKeys.add(key);
    });
    removeKeys.forEach(_inverseIds.remove);
    removeKeys.forEach(_inverseNgrams.remove);
  }

  /// Match the text against the corpus and return the tokens that have match.
  TokenMatch lookupTokens(String text) {
    final TokenMatch tokenMatch = new TokenMatch();
    final tokens = tokenize(text);
    if (tokens == null || tokens.isEmpty) {
      return tokenMatch;
    }

    // Check which tokens have documents, and assign their weight.
    for (String token in tokens.keys) {
      final tokenNgrams = _ngrams(token, _minLength);
      for (String candidate in _inverseIds.keys) {
        double candidateWeight = 0.0;
        if (token == candidate) {
          candidateWeight = 1.0;
        } else {
          final candidateNgrams = _inverseNgrams[candidate];
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
        sum + math.min(100, str.length * str.length);

    final intersectionWeight = intersection.fold<int>(0, sumFn);
    final supersetWeight =
        a.fold<int>(0, sumFn) + b.fold<int>(0, sumFn) - intersectionWeight;
    return intersectionWeight / supersetWeight;
  }

  Map<String, double> scoreDocs(TokenMatch tokenMatch,
      {double weight: 1.0, int wordCount: 1}) {
    // Summarize the scores for the documents.
    final queryWeight = tokenMatch.maxWeight;
    final Map<String, double> docScores = <String, double>{};
    for (String token in tokenMatch.tokens) {
      for (String id in _inverseIds[token]) {
        final double prevValue = docScores[id] ?? 0.0;
        docScores[id] = math.max(prevValue, tokenMatch[token]);
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

const int _minNgram = 1;
const int _maxNgram = 6;

Set<String> _ngrams(String text, int minLength) {
  final ngrams = new Set<String>();
  for (int ngramLength = math.max(_minNgram, minLength);
      ngramLength <= _maxNgram;
      ngramLength++) {
    if (text.length > ngramLength) {
      for (int i = 0; i <= text.length - ngramLength; i++) {
        ngrams.add(text.substring(i, i + ngramLength));
      }
    }
  }
  return ngrams;
}
