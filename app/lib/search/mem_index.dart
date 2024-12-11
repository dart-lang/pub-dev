// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
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
  late final TokenIndex<String> _descrIndex;
  late final TokenIndex<String> _readmeIndex;
  late final TokenIndex<IndexedApiDocPage> _apiSymbolIndex;
  late final _scorePool = ScorePool(_packageNameIndex._packageNames);
  final _tagDocumentIndexes = <String, List<int>>{};
  final _documentTagIds = <List<int>>[];

  /// Adjusted score takes the overall score and transforms
  /// it linearly into the [0.4-1.0] range.
  late final List<double> _adjustedOverallScores;
  late final List<IndexedPackageHit> _overallOrderedHits;
  late final List<IndexedPackageHit> _createdOrderedHits;
  late final List<IndexedPackageHit> _updatedOrderedHits;
  late final List<IndexedPackageHit> _popularityOrderedHits;
  late final List<IndexedPackageHit> _downloadsOrderedHits;
  late final List<IndexedPackageHit> _likesOrderedHits;
  late final List<IndexedPackageHit> _pointsOrderedHits;

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
    final apiDocPageKeys = <IndexedApiDocPage>[];
    final apiDocPageValues = <String>[];
    for (var i = 0; i < _documents.length; i++) {
      final doc = _documents[i];
      _documentsByName[doc.package] = doc;

      // transform tags into numberical IDs
      final tagIds = <int>[];
      for (final tag in doc.tags) {
        _tagDocumentIndexes.putIfAbsent(tag, () => []).add(i);
      }
      tagIds.sort();
      _documentTagIds.add(tagIds);

      final apiDocPages = doc.apiDocPages;
      if (apiDocPages != null) {
        for (final page in apiDocPages) {
          if (page.symbols != null && page.symbols!.isNotEmpty) {
            apiDocPageKeys.add(IndexedApiDocPage(i, page));
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
      skipDocumentWeight: true,
    );
    _readmeIndex = TokenIndex(
      packageKeys,
      _documents.map((d) => d.readme).toList(),
    );
    _apiSymbolIndex = TokenIndex(apiDocPageKeys, apiDocPageValues);

    // update download scores only if they were not set (should happen on old runtime's snapshot and local tests)
    if (_documents.any((e) => e.downloadScore == null)) {
      _documents.updateDownloadScores();
    }

    // update like scores only if they were not set (should happen only in local tests)
    if (_documents.any((e) => e.likeScore == null)) {
      _documents.updateLikeScores();
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
    // prevent any work if offset is outside of the range
    if ((query.offset ?? 0) > _documents.length) {
      return PackageSearchResult.empty();
    }
    return _scorePool.withScore(
      value: 1.0,
      fn: (score) {
        return _search(query, score);
      },
    );
  }

  PackageSearchResult _search(
      ServiceSearchQuery query, IndexedScore<String> packageScores) {
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
      for (final entry in combinedTagsPredicate.entries) {
        final docIndexes = _tagDocumentIndexes[entry.key];

        if (entry.value) {
          // predicate is required, zeroing the gaps between index values
          if (docIndexes == null) {
            // the predicate is required, no document will match it
            return PackageSearchResult.empty();
          }

          for (var i = 0; i < docIndexes.length; i++) {
            if (i == 0) {
              packageScores.fillRange(0, docIndexes[i], 0.0);
              continue;
            }
            packageScores.fillRange(docIndexes[i - 1] + 1, docIndexes[i], 0.0);
          }
          packageScores.fillRange(docIndexes.last + 1, _documents.length, 0.0);
        } else {
          // predicate is prohibited, zeroing the values

          if (docIndexes == null) {
            // the predicate is prohibited, no document has it, always a match
            continue;
          }
          for (final i in docIndexes) {
            packageScores.setValue(i, 0.0);
          }
        }
      }
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

    // do text matching
    final parsedQueryText = query.parsedQuery.text;
    final textResults = _searchText(
      packageScores,
      parsedQueryText,
      includeNameMatches: (query.offset ?? 0) == 0,
    );

    final nameMatches = textResults?.nameMatches;
    List<String>? topicMatches;

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

    List<IndexedPackageHit> indexedHits;
    switch (query.effectiveOrder ?? SearchOrder.top) {
      case SearchOrder.top:
        if (textResults == null) {
          indexedHits = _overallOrderedHits.whereInScores(packageScores);
          break;
        }

        /// Adjusted score takes the overall score and transforms
        /// it linearly into the [0.4-1.0] range, to allow better
        /// multiplication outcomes.
        packageScores.multiplyAllFromValues(_adjustedOverallScores);
        indexedHits = _rankWithValues(packageScores,
            requiredLengthThreshold: query.offset);
        break;
      case SearchOrder.text:
        indexedHits = _rankWithValues(packageScores,
            requiredLengthThreshold: query.offset);
        break;
      case SearchOrder.created:
        indexedHits = _createdOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.updated:
        indexedHits = _updatedOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.popularity:
        indexedHits = _popularityOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.downloads:
        indexedHits = _downloadsOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.like:
        indexedHits = _likesOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.points:
        indexedHits = _pointsOrderedHits.whereInScores(packageScores);
        break;
    }

    // bound by offset and limit (or randomize items)
    final totalCount = indexedHits.length;
    indexedHits =
        boundedList(indexedHits, offset: query.offset, limit: query.limit);

    late List<PackageHit> packageHits;
    if (textResults != null && (textResults.topApiPages?.isNotEmpty ?? false)) {
      packageHits = indexedHits.map((ps) {
        final apiPages = textResults.topApiPages?[ps.index]
            // TODO(https://github.com/dart-lang/pub-dev/issues/7106): extract title for the page
            ?.map((MapEntry<String, double> e) => ApiPageRef(path: e.key))
            .toList();
        return ps.hit.change(apiPages: apiPages);
      }).toList();
    } else {
      packageHits = indexedHits.map((h) => h.hit).toList();
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
    _adjustedOverallScores = _documents.map((doc) {
      final downloadScore = doc.downloadScore ?? doc.popularityScore ?? 0.0;
      final likeScore = doc.likeScore ?? 0.0;
      final popularity = (downloadScore + likeScore) / 2;
      final points = doc.grantedPoints / math.max(1, doc.maxPoints);
      final overall = popularity * 0.5 + points * 0.5;
      doc.overallScore = overall;
      // adding a base score prevents later multiplication with zero
      return 0.4 + 0.6 * overall;
    }).toList();
  }

  _TextResults? _searchText(
    IndexedScore<String> packageScores,
    String? text, {
    required bool includeNameMatches,
  }) {
    final sw = Stopwatch()..start();
    if (text != null && text.isNotEmpty) {
      final words = splitForQuery(text);
      if (words.isEmpty) {
        for (var i = 0; i < packageScores.length; i++) {
          packageScores.setValue(i, 0);
        }
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
      /// However, API docs search should be filtered on the original list.
      final indexedPositiveList = packageScores.toIndexedPositiveList();

      for (final word in words) {
        if (includeNameMatches && _documentsByName.containsKey(word)) {
          nameMatches ??= <String>{};
          nameMatches.add(word);
        }

        _scorePool.withScore(
          value: 0.0,
          fn: (wordScore) {
            _packageNameIndex.searchWord(word,
                score: wordScore, filterOnNonZeros: packageScores);
            _descrIndex.searchAndAccumulate(word, score: wordScore);
            _readmeIndex.searchAndAccumulate(word,
                weight: 0.75, score: wordScore);
            packageScores.multiplyAllFrom(wordScore);
          },
        );
      }

      final topApiPages =
          List<List<MapEntry<String, double>>?>.filled(_documents.length, null);
      const maxApiPageCount = 2;
      if (!checkAborted()) {
        _apiSymbolIndex.withSearchWords(words, weight: 0.70, (symbolPages) {
          for (var i = 0; i < symbolPages.length; i++) {
            final value = symbolPages.getValue(i);
            if (value < 0.01) continue;

            final doc = symbolPages.keys[i];
            if (!indexedPositiveList[doc.index]) continue;

            // skip if the previously found pages are better than the current one
            final pages =
                topApiPages[doc.index] ??= <MapEntry<String, double>>[];
            if (pages.length >= maxApiPageCount && pages.last.value > value) {
              continue;
            }

            // update the top api packages score
            packageScores.setValueMaxOf(doc.index, value);

            // add the page and re-sort the current results
            pages.add(MapEntry(doc.page.relativePath, value));
            if (pages.length > 1) {
              pages.sort((a, b) => -a.value.compareTo(b.value));
            }

            // keep the results limited to the max count
            if (pages.length > maxApiPageCount) {
              pages.removeLast();
            }
          }
        });
      }

      // filter results based on exact phrases
      final phrases = extractExactPhrases(text);
      if (!aborted && phrases.isNotEmpty) {
        for (var i = 0; i < packageScores.length; i++) {
          if (packageScores.isNotPositive(i)) continue;
          final doc = _documents[i];
          final matchedAllPhrases = phrases.every((phrase) =>
              doc.package.contains(phrase) ||
              doc.description!.contains(phrase) ||
              doc.readme!.contains(phrase));
          if (!matchedAllPhrases) {
            packageScores.setValue(i, 0);
          }
        }
      }

      return _TextResults(
        topApiPages,
        nameMatches: nameMatches?.toList(),
      );
    }
    return null;
  }

  List<IndexedPackageHit> _rankWithValues(
    IndexedScore<String> score, {
    // if the item count is fewer than this threshold, an empty list will be returned
    int? requiredLengthThreshold,
  }) {
    final list = <IndexedPackageHit>[];
    for (var i = 0; i < score.length; i++) {
      final value = score.getValue(i);
      if (value <= 0.0) continue;
      list.add(IndexedPackageHit(
          i, PackageHit(package: score.keys[i], score: value)));
    }
    if ((requiredLengthThreshold ?? 0) > list.length) {
      // There is no point to sort or even keep the results, as the search query offset ignores these anyway.
      return [];
    }
    list.sort((a, b) {
      final scoreCompare = -a.hit.score!.compareTo(b.hit.score!);
      if (scoreCompare != 0) return scoreCompare;
      // if two packages got the same score, order by last updated
      return _compareUpdated(_documents[a.index], _documents[b.index]);
    });
    return list;
  }

  List<IndexedPackageHit> _rankWithComparator(
    int Function(PackageDocument a, PackageDocument b) compare, {
    double Function(PackageDocument doc)? score,
  }) {
    final list = _documents
        .mapIndexed((index, doc) => IndexedPackageHit(
            index,
            PackageHit(
                package: doc.package,
                score: score == null ? null : score(doc))))
        .toList();
    list.sort((a, b) => compare(_documents[a.index], _documents[b.index]));
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
}

class _TextResults {
  final List<List<MapEntry<String, double>>?>? topApiPages;
  final List<String>? nameMatches;

  factory _TextResults.empty() => _TextResults(
        null,
        nameMatches: null,
      );

  _TextResults(
    this.topApiPages, {
    required this.nameMatches,
  });
}

/// A simple (non-inverted) index designed for package name lookup.
@visibleForTesting
class PackageNameIndex {
  final List<String> _packageNames;
  late final List<_PkgNameData> _data;

  PackageNameIndex(this._packageNames) {
    _data = _packageNames.map((package) {
      final collapsed = _collapseName(package);
      return _PkgNameData(collapsed, trigrams(collapsed).toSet());
    }).toList();
  }

  /// Maps package name to a reduced form of the name:
  /// the same character parts, but without `-`.
  String _collapseName(String package) =>
      package.replaceAll('_', '').toLowerCase();

  /// Search [text] and return the matching packages with scores.
  @visibleForTesting
  Map<String, double> search(String text) {
    IndexedScore<String>? score;
    for (final w in splitForQuery(text)) {
      final s = IndexedScore(_packageNames);
      searchWord(w, score: s, filterOnNonZeros: score);
      if (score == null) {
        score = s;
      } else {
        score.multiplyAllFrom(s);
      }
    }
    return score?.toMap() ?? {};
  }

  /// Search using the parsed [word] and return the matching packages with scores
  /// as a new [IndexedScore] instance.
  ///
  /// When [filterOnNonZeros] is present, only the indexes with an already
  /// non-zero value are evaluated.
  void searchWord(
    String word, {
    required IndexedScore<String> score,
    IndexedScore<String>? filterOnNonZeros,
  }) {
    assert(score.keys.length == _packageNames.length);
    final singularWord = word.length <= 3 || !word.endsWith('s')
        ? word
        : word.substring(0, word.length - 1);
    final collapsedWord = _collapseName(singularWord);
    final parts =
        collapsedWord.length <= 3 ? [collapsedWord] : trigrams(collapsedWord);
    for (var i = 0; i < _data.length; i++) {
      if (filterOnNonZeros?.isNotPositive(i) ?? false) {
        continue;
      }

      final entry = _data[i];
      if (entry.collapsed.contains(collapsedWord)) {
        score.setValue(i, 1.0);
        continue;
      }
      var matched = 0;
      var unmatched = 0;
      final acceptThreshold = parts.length ~/ 2;
      final rejectThreshold = parts.length - acceptThreshold;
      for (final part in parts) {
        if (entry.trigrams.contains(part)) {
          matched++;
        } else {
          unmatched++;
          if (unmatched > rejectThreshold) {
            // we have no chance to accept this hit
            break;
          }
        }
      }

      if (matched >= acceptThreshold) {
        // making sure that match score is minimum 0.5
        final v = matched / parts.length;
        if (v >= 0.5) {
          score.setValue(i, v);
        }
      }
    }
  }
}

class _PkgNameData {
  final String collapsed;
  final Set<String> trigrams;

  _PkgNameData(this.collapsed, this.trigrams);
}

extension on List<IndexedPackageHit> {
  List<IndexedPackageHit> whereInScores(IndexedScore scores) {
    return where((h) => scores.isPositive(h.index)).toList();
  }
}

class IndexedPackageHit {
  final int index;
  final PackageHit hit;

  IndexedPackageHit(this.index, this.hit);
}

class IndexedApiDocPage {
  final int index;
  final ApiDocPage page;

  IndexedApiDocPage(this.index, this.page);
}
