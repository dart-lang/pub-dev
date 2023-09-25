// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../shared/utils.dart' show boundedList;
import 'search_service.dart';
import 'text_utils.dart';
import 'token_index.dart';

final _logger = Logger('search.mem_index');
final _textSearchTimeout = Duration(milliseconds: 500);

/// Returns the popularity score (0.0 - 1.0) of a package.
typedef PopularityValueFn = double Function(String packageName);
double _noPopularityScoreFn(String packageName) => 0.0;

class InMemoryPackageIndex {
  final PopularityValueFn _popularityValueFn;
  final Map<String, PackageDocument> _packages = <String, PackageDocument>{};
  final _packageNameIndex = PackageNameIndex();
  final TokenIndex _descrIndex = TokenIndex();
  final TokenIndex _readmeIndex = TokenIndex();
  final TokenIndex _apiSymbolIndex = TokenIndex();
  final _likeTracker = _LikeTracker();
  final bool _alwaysUpdateLikeScores;
  late final _createdOrderedHitCache = _OrderedHitCache(
      () => _rankWithComparator(_packages.keys.toSet(), _compareCreated));
  late final _updatedOrderedHitCache = _OrderedHitCache(
      () => _rankWithComparator(_packages.keys.toSet(), _compareUpdated));

  DateTime? _lastUpdated;
  bool _isReady = false;

  InMemoryPackageIndex({
    PopularityValueFn popularityValueFn = _noPopularityScoreFn,
    math.Random? random,
    @visibleForTesting bool alwaysUpdateLikeScores = false,
  })  : _popularityValueFn = popularityValueFn,
        _alwaysUpdateLikeScores = alwaysUpdateLikeScores;

  IndexInfo indexInfo() {
    return IndexInfo(
      isReady: _isReady,
      packageCount: _packages.length,
      lastUpdated: _lastUpdated,
    );
  }

  /// A package index may be accessed while the initialization phase is still
  /// running. Once the initialization is done (either via a snapshot or a
  /// `Package`-scan completes), the updater should call this method to indicate
  /// to the frontend load-balancer that the instance now accepts requests.
  void markReady() {
    _isReady = true;
  }

  void addPackage(PackageDocument doc) {
    _packages[doc.package] = doc;
    _packageNameIndex.add(doc.package);
    _descrIndex.add(doc.package, doc.description);
    _readmeIndex.add(doc.package, doc.readme);

    for (ApiDocPage page in doc.apiDocPages ?? const []) {
      final pageId = _apiDocPageId(doc.package, page);
      if (page.symbols != null && page.symbols!.isNotEmpty) {
        _apiSymbolIndex.add(pageId, page.symbols!.join(' '));
      }
    }

    _likeTracker.trackLikeCount(doc.package, doc.likeCount ?? 0);
    if (_alwaysUpdateLikeScores) {
      _likeTracker._updateScores();
    } else {
      _likeTracker._updateScoresIfNeeded();
    }

    _lastUpdated = clock.now().toUtc();
    _invalidateHitCaches();
  }

  void addPackages(Iterable<PackageDocument> documents) {
    for (PackageDocument doc in documents) {
      addPackage(doc);
    }
    _likeTracker._updateScores();
  }

  PackageSearchResult search(ServiceSearchQuery query) {
    final packages = Set<String>.of(_packages.keys);

    // filter on package prefix
    if (query.parsedQuery.packagePrefix != null) {
      final String prefix = query.parsedQuery.packagePrefix!.toLowerCase();
      packages.removeWhere(
        (package) =>
            !_packages[package]!.package.toLowerCase().startsWith(prefix),
      );
    }

    // filter on tags
    final combinedTagsPredicate =
        query.tagsPredicate.appendPredicate(query.parsedQuery.tagsPredicate);
    if (combinedTagsPredicate.isNotEmpty) {
      packages.retainWhere(
          (package) => combinedTagsPredicate.matches(_packages[package]!.tags));
    }

    // filter on dependency
    if (query.parsedQuery.hasAnyDependency) {
      packages.removeWhere((package) {
        final doc = _packages[package]!;
        if (doc.dependencies.isEmpty) return true;
        for (String dependency in query.parsedQuery.allDependencies) {
          if (!doc.dependencies.containsKey(dependency)) return true;
        }
        for (String dependency in query.parsedQuery.refDependencies) {
          final type = doc.dependencies[dependency];
          if (type == null || type == DependencyTypes.transitive) return true;
        }
        return false;
      });
    }

    // filter on points
    if (query.minPoints != null && query.minPoints! > 0) {
      packages.removeWhere((package) {
        final doc = _packages[package]!;
        return (doc.grantedPoints ?? 0) < query.minPoints!;
      });
    }

    // filter on updatedInDays
    if (query.updatedInDays != null && query.updatedInDays! > 0) {
      final threshold =
          Duration(days: query.updatedInDays!, hours: 11, minutes: 59);
      final now = clock.now();
      packages.removeWhere((package) {
        final doc = _packages[package]!;
        final diff = now.difference(doc.updated!);
        return diff > threshold;
      });
    }

    // do text matching
    final textResults = _searchText(packages, query.parsedQuery.text);

    // filter packages that doesn't match text query
    if (textResults != null) {
      final keys = textResults.pkgScore.getKeys();
      packages.removeWhere((x) => !keys.contains(x));
    }

    late List<PackageHit> packageHits;
    switch (query.effectiveOrder ?? SearchOrder.top) {
      case SearchOrder.top:
        final List<Score> scores = [
          _getOverallScore(packages),
          if (textResults != null) textResults.pkgScore,
        ];
        final overallScore = Score.multiply(scores);
        // If the search hits have an exact name match, we move it to the front of the result list.
        final parsedQueryText = query.parsedQuery.text;
        final priorityPackageName =
            packages.contains(parsedQueryText ?? '') ? parsedQueryText : null;
        packageHits = _rankWithValues(
          overallScore.getValues(),
          priorityPackageName: priorityPackageName,
        );
        break;
      case SearchOrder.text:
        final score = textResults?.pkgScore ?? Score.empty();
        packageHits = _rankWithValues(score.getValues());
        break;
      case SearchOrder.created:
        packageHits = _createdOrderedHitCache.whereInSet(packages);
        break;
      case SearchOrder.updated:
        packageHits = _updatedOrderedHitCache.whereInSet(packages);
        break;
      case SearchOrder.popularity:
        packageHits = _rankWithValues(getPopularityScore(packages));
        break;
      case SearchOrder.like:
        packageHits = _rankWithValues(getLikeScore(packages));
        break;
      case SearchOrder.points:
        packageHits = _rankWithValues(getPubPoints(packages));
        break;
    }

    // bound by offset and limit (or randomize items)
    final totalCount = packageHits.length;
    packageHits =
        boundedList(packageHits, offset: query.offset, limit: query.limit);

    if (textResults != null && textResults.topApiPages.isNotEmpty) {
      packageHits = packageHits.map((ps) {
        final apiPages = textResults.topApiPages[ps.package]
            // TODO: extract title for the page
            ?.map((String page) => ApiPageRef(path: page))
            .toList();
        return ps.change(apiPages: apiPages);
      }).toList();
    }

    return PackageSearchResult(
      timestamp: clock.now().toUtc(),
      totalCount: totalCount,
      packageHits: packageHits,
    );
  }

  @visibleForTesting
  Map<String, double> getPopularityScore(Iterable<String> packages) {
    return Map.fromEntries(packages
        .map((p) => MapEntry<String, double>(p, _popularityValueFn(p))));
  }

  @visibleForTesting
  Map<String, double> getLikeScore(Iterable<String> packages) {
    return Map.fromIterable(
      packages,
      value: (package) => (_packages[package]?.likeCount?.toDouble() ?? 0.0),
    );
  }

  @visibleForTesting
  Map<String, double> getPubPoints(Iterable<String> packages) {
    return Map.fromIterable(
      packages,
      value: (package) =>
          (_packages[package]?.grantedPoints?.toDouble() ?? 0.0),
    );
  }

  Score _getOverallScore(Iterable<String> packages) {
    final values = Map<String, double>.fromEntries(packages.map((package) {
      final doc = _packages[package]!;
      final downloadScore = _popularityValueFn(package);
      final likeScore = _likeTracker.getLikeScore(doc.package);
      final popularity = (downloadScore + likeScore) / 2;
      final points = (doc.grantedPoints ?? 0) / math.max(1, doc.maxPoints ?? 0);
      final overall = popularity * 0.5 + points * 0.5;
      // don't multiply with zero.
      return MapEntry(package, 0.4 + 0.6 * overall);
    }));
    return Score(values);
  }

  _TextResults? _searchText(Set<String> packages, String? text) {
    final sw = Stopwatch()..start();
    if (text != null && text.isNotEmpty) {
      final words = splitForQuery(text);
      if (words.isEmpty) {
        return _TextResults(Score.empty(), <String, List<String>>{});
      }

      bool aborted = false;

      bool checkAborted() {
        if (!aborted && sw.elapsed > _textSearchTimeout) {
          aborted = true;
          _logger.info(
              '[pub-aborted-search-query] Aborted text search after ${sw.elapsedMilliseconds} ms.');
        }
        return aborted;
      }

      // Multiple words are scored separately, and then the individual scores
      // are multiplied. We can use a package filter that is applied after each
      // word to reduce the scope of the later words based on the previous results.
      // We cannot update the main `packages` variable yet, as the dartdoc API
      // symbols are added on top of the core results, and `packages` is used
      // there too.
      final coreScores = <Score>[];
      var wordScopedPackages = packages;
      for (final word in words) {
        final nameScore =
            _packageNameIndex.searchWord(word, packages: wordScopedPackages);
        final descr = _descrIndex
            .searchWords([word], weight: 0.90, limitToIds: wordScopedPackages);
        final readme = _readmeIndex
            .searchWords([word], weight: 0.75, limitToIds: wordScopedPackages);
        final score = Score.max([nameScore, descr, readme]);
        coreScores.add(score);
        // don't update if the query is single-word
        if (words.length > 1) {
          wordScopedPackages = score.getKeys();
          if (wordScopedPackages.isEmpty) {
            break;
          }
        }
      }

      final core = Score.multiply(coreScores);

      var symbolPages = Score.empty();
      if (!checkAborted()) {
        symbolPages = _apiSymbolIndex.searchWords(words, weight: 0.70);
      }

      final apiPackages = <String, double>{};
      for (final entry in symbolPages.getValues().entries) {
        final pkg = _apiDocPkg(entry.key);
        if (!packages.contains(pkg)) continue;
        apiPackages[pkg] = math.max(entry.value, apiPackages[pkg] ?? 0.0);
      }
      final apiPkgScore = Score(apiPackages);
      var score = Score.max([core, apiPkgScore])
          .project(packages)
          .removeLowValues(fraction: 0.2, minValue: 0.01);

      // filter results based on exact phrases
      final phrases = extractExactPhrases(text);
      if (!aborted && phrases.isNotEmpty) {
        final Map<String, double> matched = <String, double>{};
        for (String package in score.getKeys()) {
          final doc = _packages[package]!;
          final bool matchedAllPhrases = phrases.every((phrase) =>
              doc.package.contains(phrase) ||
              doc.description!.contains(phrase) ||
              doc.readme!.contains(phrase));
          if (matchedAllPhrases) {
            matched[package] = score[package];
          }
        }
        score = Score(matched);
      }

      final apiDocKeys = symbolPages.getKeys().toList()
        ..sort((a, b) => -symbolPages[a].compareTo(symbolPages[b]));
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

  List<PackageHit> _rankWithValues(
    Map<String, double> values, {
    String? priorityPackageName,
  }) {
    final list = values.entries
        .map((e) => PackageHit(package: e.key, score: e.value))
        .toList();
    list.sort((a, b) {
      if (a.package == priorityPackageName) return -1;
      if (b.package == priorityPackageName) return 1;
      final int scoreCompare = -a.score!.compareTo(b.score!);
      if (scoreCompare != 0) return scoreCompare;
      // if two packages got the same score, order by last updated
      return _compareUpdated(_packages[a.package]!, _packages[b.package]!);
    });
    return list;
  }

  List<PackageHit> _rankWithComparator(Set<String> packages,
      int Function(PackageDocument a, PackageDocument b) compare) {
    final list = packages
        .map((package) => PackageHit(package: _packages[package]!.package))
        .toList();
    list.sort((a, b) => compare(_packages[a.package]!, _packages[b.package]!));
    return list;
  }

  int _compareCreated(PackageDocument a, PackageDocument b) {
    if (a.created == null) return -1;
    if (b.created == null) return 1;
    return -a.created!.compareTo(b.created!);
  }

  int _compareUpdated(PackageDocument a, PackageDocument b) {
    if (a.updated == null) return -1;
    if (b.updated == null) return 1;
    return -a.updated!.compareTo(b.updated!);
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

  void _invalidateHitCaches() {
    _createdOrderedHitCache.invalide();
    _updatedOrderedHitCache.invalide();
  }
}

class _TextResults {
  final Score pkgScore;
  final Map<String, List<String>> topApiPages;

  _TextResults(this.pkgScore, this.topApiPages);
}

/// A simple (non-inverted) index designed for package name lookup.
@visibleForTesting
class PackageNameIndex {
  final _data = <String, _PkgNameData>{};

  /// Maps package name to a reduced form of the name:
  /// the same character parts, but without `-`.
  String _collapseName(String package) =>
      package.replaceAll('_', '').toLowerCase();

  void addAll(Iterable<String> packages) {
    for (final package in packages) {
      add(package);
    }
  }

  /// Add a new [package] to the index.
  void add(String package) {
    _data.putIfAbsent(package, () {
      final collapsed = _collapseName(package);
      return _PkgNameData(collapsed, trigrams(collapsed).toSet());
    });
  }

  /// Search [text] and return the matching packages with scores.
  Score search(String text) {
    return Score.multiply(splitForQuery(text).map(searchWord).toList());
  }

  /// Search using the parsed [word] and return the match packages with scores.
  Score searchWord(String word, {Set<String>? packages}) {
    final pkgNamesToCheck = packages ?? _data.keys;
    final values = <String, double>{};
    final singularWord = word.length <= 3 || !word.endsWith('s')
        ? word
        : word.substring(0, word.length - 1);
    final collapsedWord = _collapseName(singularWord);
    final parts =
        collapsedWord.length <= 3 ? [collapsedWord] : trigrams(collapsedWord);
    for (final pkg in pkgNamesToCheck) {
      final entry = _data[pkg];
      if (entry == null) {
        continue;
      }
      if (entry.collapsed.contains(collapsedWord)) {
        values[pkg] = 1.0;
        continue;
      }
      var matched = 0;
      for (final part in parts) {
        if (entry.trigrams.contains(part)) {
          matched++;
        }
      }
      if (matched > 0) {
        values[pkg] = matched / parts.length;
      }
    }
    return Score(values).removeLowValues(fraction: 0.5, minValue: 0.5);
  }
}

class _PkgNameData {
  final String collapsed;
  final Set<String> trigrams;

  _PkgNameData(this.collapsed, this.trigrams);
}

class _LikeScore {
  final String package;
  int likeCount = 0;
  double score = 0.0;

  _LikeScore(this.package);
}

class _LikeTracker {
  final _values = <String, _LikeScore>{};
  bool _changed = false;
  DateTime? _lastUpdated;

  double getLikeScore(String package) {
    return _values[package]?.score ?? 0.0;
  }

  void trackLikeCount(String package, int likeCount) {
    final v = _values.putIfAbsent(package, () => _LikeScore(package));
    if (v.likeCount != likeCount) {
      _changed = true;
      v.likeCount = likeCount;
    }
  }

  void _updateScoresIfNeeded() {
    if (!_changed) {
      // we know there is nothing to update
      return;
    }
    final now = clock.now();
    if (_lastUpdated != null && now.difference(_lastUpdated!).inHours < 12) {
      // we don't need to update too frequently
      return;
    }

    _updateScores();
  }

  /// Updates `_LikeScore.score` values, setting them between 0.0 (no likes) to
  /// 1.0 (most likes).
  void _updateScores() {
    final sw = Stopwatch()..start();
    final entries = _values.values.toList();
    entries.sort((a, b) => a.likeCount.compareTo(b.likeCount));
    for (int i = 0; i < entries.length; i++) {
      if (i > 0 && entries[i].likeCount == entries[i - 1].likeCount) {
        entries[i].score = entries[i - 1].score;
      } else {
        entries[i].score = (i + 1) / entries.length;
      }
    }
    _changed = false;
    _lastUpdated = clock.now();
    _logger.info('Updated like scores in ${sw.elapsed} (${entries.length})');
  }
}

class _OrderedHitCache {
  final List<PackageHit> Function() _updater;
  bool _expired = true;
  DateTime _lastUpdated = clock.now();
  List<PackageHit>? _values;

  _OrderedHitCache(this._updater);

  void invalide() {
    _expired = true;
  }

  List<PackageHit> getOrUpdate() {
    if (_expired ||
        _values == null ||
        clock.now().difference(_lastUpdated) > const Duration(hours: 1)) {
      _expired = false;
      _lastUpdated = clock.now();
      _values = _updater();
    }
    return _values!;
  }

  List<PackageHit> where(bool Function(PackageHit hit) fn) {
    return getOrUpdate().where(fn).toList();
  }

  List<PackageHit> whereInSet(Set<String> packages) {
    return where((hit) => packages.contains(hit.package));
  }
}
