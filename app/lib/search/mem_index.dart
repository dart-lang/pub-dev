// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/service/topics/models.dart';

import '../shared/utils.dart' show boundedList;
import 'models.dart';
import 'search_service.dart';
import 'text_utils.dart';
import 'token_index.dart';

final _logger = Logger('search.mem_index');
final _textSearchTimeout = Duration(milliseconds: 500);

class InMemoryPackageIndex {
  final List<PackageDocument> _documents;
  final _documentsByName = <String, PackageDocument>{};
  late final PackageNameIndex _packageNameIndex;
  late final TokenIndex _descrIndex;
  late final TokenIndex _readmeIndex;
  late final TokenIndex _apiSymbolIndex;

  /// Adjusted score takes the overall score and transforms
  /// it linearly into the [0.4-1.0] range.
  final _adjustedOverallScores = <String, double>{};
  late final List<PackageHit> _overallOrderedHits;
  late final List<PackageHit> _createdOrderedHits;
  late final List<PackageHit> _updatedOrderedHits;
  late final List<PackageHit> _popularityOrderedHits;
  late final List<PackageHit> _downloadsOrderedHits;
  late final List<PackageHit> _likesOrderedHits;
  late final List<PackageHit> _pointsOrderedHits;

  // Contains all of the topics the index had seen so far.
  // TODO: consider moving this into a separate index
  // TODO: get the list of topics from the bucket
  final _topics = <String>{
    ...canonicalTopics.aliasToCanonicalMap.values,
  };

  late final DateTime _lastUpdated;

  InMemoryPackageIndex({
    required Iterable<PackageDocument> documents,
  }) : _documents = [...documents] {
    final apiDocPageKeys = <String>[];
    final apiDocPageValues = <String>[];
    for (final doc in _documents) {
      _documentsByName[doc.package] = doc;

      final apiDocPages = doc.apiDocPages;
      if (apiDocPages != null) {
        for (final page in apiDocPages) {
          if (page.symbols != null && page.symbols!.isNotEmpty) {
            apiDocPageKeys.add(_apiDocPageId(doc.package, page));
            apiDocPageValues.add(page.symbols!.join(' '));
          }
        }
      }

      // Note: we are not removing topics from this set, only adding them, no
      //       need for tracking the current topic count.
      _topics.addAll(doc.tags
          .where((t) => t.startsWith('topic:'))
          .map((t) => t.split('topic:').last));
    }

    final packageKeys = _documents.map((d) => d.package).toList();
    _packageNameIndex = PackageNameIndex(packageKeys);
    _descrIndex = TokenIndex(
      packageKeys,
      _documents.map((d) => d.description).toList(),
    );
    _readmeIndex = TokenIndex(
      packageKeys,
      _documents.map((d) => d.readme).toList(),
    );
    _apiSymbolIndex = TokenIndex(apiDocPageKeys, apiDocPageValues);

    // update like scores only if they were not set (should happen only in local tests)
    if (_documentsByName.values.any((e) => e.likeScore == null)) {
      _documentsByName.values.updateLikeScores();
    }
    _updateOverallScores();
    _lastUpdated = clock.now().toUtc();
    _overallOrderedHits = _rankWithComparator(_compareOverall,
        score: (doc) => doc.overallScore ?? 0.0);
    _createdOrderedHits = _rankWithComparator(_compareCreated);
    _updatedOrderedHits = _rankWithComparator(_compareUpdated);
    _popularityOrderedHits = _rankWithComparator(_comparePopularity,
        score: (doc) => doc.popularityScore ?? 0);
    _downloadsOrderedHits = _rankWithComparator(_compareDownloads,
        score: (doc) => doc.downloadCount.toDouble());
    _likesOrderedHits = _rankWithComparator(_compareLikes,
        score: (doc) => doc.likeCount.toDouble());
    _pointsOrderedHits = _rankWithComparator(_comparePoints,
        score: (doc) => doc.grantedPoints.toDouble());
  }

  IndexInfo indexInfo() {
    return IndexInfo(
      isReady: true,
      packageCount: _documentsByName.length,
      lastUpdated: _lastUpdated,
    );
  }

  PackageSearchResult search(ServiceSearchQuery query) {
    final packageScores = IndexedScore(_packageNameIndex._packageNames, 1.0);

    // filter on package prefix
    if (query.parsedQuery.packagePrefix != null) {
      final String prefix = query.parsedQuery.packagePrefix!.toLowerCase();
      packageScores.retainWhere(
        (i, _) => _documents[i].packageNameLowerCased.startsWith(prefix),
      );
    }

    // filter on tags
    final combinedTagsPredicate =
        query.tagsPredicate.appendPredicate(query.parsedQuery.tagsPredicate);
    if (combinedTagsPredicate.isNotEmpty) {
      packageScores.retainWhere(
          (i, _) => combinedTagsPredicate.matches(_documents[i].tagsForLookup));
    }

    // filter on dependency
    if (query.parsedQuery.hasAnyDependency) {
      packageScores.removeWhere((i, _) {
        final doc = _documents[i];
        if (doc.dependencies.isEmpty) return true;
        for (final dependency in query.parsedQuery.allDependencies) {
          if (!doc.dependencies.containsKey(dependency)) return true;
        }
        for (final dependency in query.parsedQuery.refDependencies) {
          final type = doc.dependencies[dependency];
          if (type == null || type == DependencyTypes.transitive) return true;
        }
        return false;
      });
    }

    // filter on points
    if (query.minPoints != null && query.minPoints! > 0) {
      packageScores.removeWhere(
          (i, _) => _documents[i].grantedPoints < query.minPoints!);
    }

    // filter on updatedDuration
    final updatedDuration = query.parsedQuery.updatedDuration;
    if (updatedDuration != null && updatedDuration > Duration.zero) {
      final now = clock.now();
      packageScores.removeWhere(
          (i, _) => now.difference(_documents[i].updated) > updatedDuration);
    }
    final packages = packageScores.toKeySet();

    // do text matching
    final parsedQueryText = query.parsedQuery.text;
    final textResults = _searchText(
      packages,
      parsedQueryText,
      includeNameMatches: (query.offset ?? 0) == 0,
    );

    // filter packages that doesn't match text query
    if (textResults != null) {
      final keys = textResults.pkgScore.keys.toSet();
      packages.removeWhere((x) => !keys.contains(x));
    }

    final nameMatches = textResults?.nameMatches;
    List<String>? topicMatches;
    List<PackageHit> packageHits;

    if (parsedQueryText != null) {
      final parts = parsedQueryText
          .split(' ')
          .map((t) => canonicalTopics.aliasToCanonicalMap[t] ?? t)
          .toSet()
          .where(_topics.contains)
          .toList();
      if (parts.isNotEmpty) {
        topicMatches = parts;
      }
    }

    switch (query.effectiveOrder ?? SearchOrder.top) {
      case SearchOrder.top:
        if (textResults == null) {
          packageHits = _overallOrderedHits.whereInSet(packages);
          break;
        }

        /// Adjusted score takes the overall score and transforms
        /// it linearly into the [0.4-1.0] range, to allow better
        /// multiplication outcomes.
        final overallScore = textResults.pkgScore
            .mapValues((key, value) => value * _adjustedOverallScores[key]!);
        packageHits = _rankWithValues(overallScore);
        break;
      case SearchOrder.text:
        final score = textResults?.pkgScore ?? Score.empty;
        packageHits = _rankWithValues(score);
        break;
      case SearchOrder.created:
        packageHits = _createdOrderedHits.whereInSet(packages);
        break;
      case SearchOrder.updated:
        packageHits = _updatedOrderedHits.whereInSet(packages);
        break;
      case SearchOrder.popularity:
        packageHits = _popularityOrderedHits.whereInSet(packages);
        break;
      case SearchOrder.downloads:
        packageHits = _downloadsOrderedHits.whereInSet(packages);
        break;
      case SearchOrder.like:
        packageHits = _likesOrderedHits.whereInSet(packages);
        break;
      case SearchOrder.points:
        packageHits = _pointsOrderedHits.whereInSet(packages);
        break;
    }

    // bound by offset and limit (or randomize items)
    final totalCount = packageHits.length;
    packageHits =
        boundedList(packageHits, offset: query.offset, limit: query.limit);

    if (textResults != null && textResults.topApiPages.isNotEmpty) {
      packageHits = packageHits.map((ps) {
        final apiPages = textResults.topApiPages[ps.package]
            // TODO(https://github.com/dart-lang/pub-dev/issues/7106): extract title for the page
            ?.map((MapEntry<String, double> e) =>
                ApiPageRef(path: _apiDocPath(e.key)))
            .toList();
        return ps.change(apiPages: apiPages);
      }).toList();
    }

    return PackageSearchResult(
      timestamp: clock.now().toUtc(),
      totalCount: totalCount,
      nameMatches: nameMatches,
      topicMatches: topicMatches,
      packageHits: packageHits,
    );
  }

  /// Update the overall score both on [PackageDocument] and in the [_adjustedOverallScores] map.
  void _updateOverallScores() {
    for (final doc in _documentsByName.values) {
      final downloadScore = doc.popularityScore ?? 0.0;
      final likeScore = doc.likeScore ?? 0.0;
      final popularity = (downloadScore + likeScore) / 2;
      final points = doc.grantedPoints / math.max(1, doc.maxPoints);
      final overall = popularity * 0.5 + points * 0.5;
      doc.overallScore = overall;
      // adding a base score prevents later multiplication with zero
      _adjustedOverallScores[doc.package] = 0.4 + 0.6 * overall;
    }
  }

  _TextResults? _searchText(
    Set<String> packages,
    String? text, {
    required bool includeNameMatches,
  }) {
    final sw = Stopwatch()..start();
    if (text != null && text.isNotEmpty) {
      final words = splitForQuery(text);
      if (words.isEmpty) {
        return _TextResults.empty();
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

      Set<String>? nameMatches;
      if (includeNameMatches && _documentsByName.containsKey(text)) {
        nameMatches ??= <String>{};
        nameMatches.add(text);
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
        final nameScore = _packageNameIndex.searchWord(word,
            filterOnPackages: wordScopedPackages);
        if (includeNameMatches && _documentsByName.containsKey(word)) {
          nameMatches ??= <String>{};
          nameMatches.add(word);
        }

        final descr = _descrIndex
            .searchWords([word], weight: 0.90, limitToIds: wordScopedPackages);
        final readme = _readmeIndex
            .searchWords([word], weight: 0.75, limitToIds: wordScopedPackages);
        final score = Score.max([nameScore, descr, readme]);
        coreScores.add(score);
        // don't update if the query is single-word
        if (words.length > 1) {
          wordScopedPackages = score.keys.toSet();
          if (wordScopedPackages.isEmpty) {
            break;
          }
        }
      }

      final core = Score.multiply(coreScores);

      var symbolPages = Score.empty;
      if (!checkAborted()) {
        symbolPages = _apiSymbolIndex.searchWords(words, weight: 0.70);
      }

      final apiPackages = <String, double>{};
      final topApiPages = <String, List<MapEntry<String, double>>>{};
      const maxApiPageCount = 2;
      for (final entry in symbolPages.entries) {
        final pkg = _apiDocPkg(entry.key);
        if (!packages.contains(pkg)) continue;

        // skip if the previously found pages are better than the current one
        final pages = topApiPages.putIfAbsent(pkg, () => []);
        if (pages.length >= maxApiPageCount && pages.last.value > entry.value) {
          continue;
        }

        // update the top api packages score
        apiPackages[pkg] = math.max(entry.value, apiPackages[pkg] ?? 0.0);

        // add the page and re-sort the current results
        pages.add(entry);
        if (pages.length > 1) {
          pages.sort((a, b) => -a.value.compareTo(b.value));
        }
        // keep the results limited to the max count
        if (pages.length > maxApiPageCount) {
          pages.removeLast();
        }
      }

      final apiPkgScore = Score(apiPackages);
      var score = Score.max([core, apiPkgScore])
          .project(packages)
          .removeLowValues(fraction: 0.2, minValue: 0.01);

      // filter results based on exact phrases
      final phrases = extractExactPhrases(text);
      if (!aborted && phrases.isNotEmpty) {
        final matched = <String, double>{};
        for (final MapEntry(key: package, value: packageScore)
            in score.entries) {
          final doc = _documentsByName[package]!;
          final bool matchedAllPhrases = phrases.every((phrase) =>
              doc.package.contains(phrase) ||
              doc.description!.contains(phrase) ||
              doc.readme!.contains(phrase));
          if (matchedAllPhrases) {
            matched[package] = packageScore;
          }
        }
        score = Score(matched);
      }

      return _TextResults(
        score,
        topApiPages,
        nameMatches: nameMatches?.toList(),
      );
    }
    return null;
  }

  List<PackageHit> _rankWithValues(Map<String, double> values) {
    final list = values.entries
        .map((e) => PackageHit(package: e.key, score: e.value))
        .toList();
    list.sort((a, b) {
      final int scoreCompare = -a.score!.compareTo(b.score!);
      if (scoreCompare != 0) return scoreCompare;
      // if two packages got the same score, order by last updated
      return _compareUpdated(
          _documentsByName[a.package]!, _documentsByName[b.package]!);
    });
    return list;
  }

  List<PackageHit> _rankWithComparator(
    int Function(PackageDocument a, PackageDocument b) compare, {
    double Function(PackageDocument doc)? score,
  }) {
    final list = _documentsByName.values
        .map((doc) => PackageHit(
            package: doc.package, score: score == null ? null : score(doc)))
        .toList();
    list.sort((a, b) =>
        compare(_documentsByName[a.package]!, _documentsByName[b.package]!));
    return list;
  }

  int _compareCreated(PackageDocument a, PackageDocument b) {
    return -a.created.compareTo(b.created);
  }

  int _compareUpdated(PackageDocument a, PackageDocument b) {
    return -a.updated.compareTo(b.updated);
  }

  int _compareOverall(PackageDocument a, PackageDocument b) {
    final x = -(a.overallScore ?? 0.0).compareTo(b.overallScore ?? 0.0);
    if (x != 0) return x;
    return _compareUpdated(a, b);
  }

  int _comparePopularity(PackageDocument a, PackageDocument b) {
    final x = -(a.popularityScore ?? 0.0).compareTo(b.popularityScore ?? 0.0);
    if (x != 0) return x;
    return _compareUpdated(a, b);
  }

  int _compareDownloads(PackageDocument a, PackageDocument b) {
    final x = -a.downloadCount.compareTo(b.downloadCount);
    if (x != 0) return x;
    return _compareUpdated(a, b);
  }

  int _compareLikes(PackageDocument a, PackageDocument b) {
    final x = -a.likeCount.compareTo(b.likeCount);
    if (x != 0) return x;
    return _compareUpdated(a, b);
  }

  int _comparePoints(PackageDocument a, PackageDocument b) {
    final x = -a.grantedPoints.compareTo(b.grantedPoints);
    if (x != 0) return x;
    return _compareUpdated(a, b);
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
  final Map<String, List<MapEntry<String, double>>> topApiPages;
  final List<String>? nameMatches;

  factory _TextResults.empty() => _TextResults(
        Score.empty,
        {},
        nameMatches: null,
      );

  _TextResults(
    this.pkgScore,
    this.topApiPages, {
    required this.nameMatches,
  });
}

/// A simple (non-inverted) index designed for package name lookup.
@visibleForTesting
class PackageNameIndex {
  final List<String> _packageNames;
  late final Map<String, _PkgNameData> _data;

  PackageNameIndex(this._packageNames) {
    _data = Map.fromEntries(_packageNames.map((package) {
      final collapsed = _collapseName(package);
      return MapEntry(
        package,
        _PkgNameData(collapsed, trigrams(collapsed).toSet()),
      );
    }));
  }

  /// Maps package name to a reduced form of the name:
  /// the same character parts, but without `-`.
  String _collapseName(String package) =>
      package.replaceAll('_', '').toLowerCase();

  /// Search [text] and return the matching packages with scores.
  @visibleForTesting
  Score search(String text) {
    Score? score;
    for (final w in splitForQuery(text)) {
      final s = searchWord(w, filterOnPackages: score?.keys);
      if (score == null) {
        score = s;
      } else {
        // Note: on one hand, it is inefficient to multiply the [Score] on each
        // iteration. However, (1) this is only happening in test, (2) it may be
        // better for the next iteration to work on a more limited `filterOnPackages`,
        // and (3) it will be updated to a more efficient in-place update (#8225).
        score = Score.multiply([score, s]);
      }
    }
    return score ?? Score.empty;
  }

  /// Search using the parsed [word] and return the matching packages with scores
  /// as a new [Score] instance.
  ///
  /// When [filterOnPackages] is present, only the names present are evaluated.
  Score searchWord(
    String word, {
    Iterable<String>? filterOnPackages,
  }) {
    final pkgNamesToCheck = filterOnPackages ?? _packageNames;
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

      // making sure that match score is minimum 0.5
      if (matched > 0) {
        final v = matched / parts.length;
        if (v >= 0.5) {
          values[pkg] = v;
        }
      }
    }
    return Score(values);
  }
}

class _PkgNameData {
  final String collapsed;
  final Set<String> trigrams;

  _PkgNameData(this.collapsed, this.trigrams);
}

extension on List<PackageHit> {
  List<PackageHit> whereInSet(Set<String> packages) {
    return where((hit) => packages.contains(hit.package)).toList();
  }
}
