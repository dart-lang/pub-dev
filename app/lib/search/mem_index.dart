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
import 'package:pub_dev/third_party/bit_array/bit_array.dart';

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
  final _nameToIndex = <String, int>{};
  late final PackageNameIndex _packageNameIndex;
  late final TokenIndex<String> _descrIndex;
  late final TokenIndex<String> _readmeIndex;
  late final TokenIndex<IndexedApiDocPage> _apiSymbolIndex;
  late final _bitArrayPool = BitArrayPool(_documents.length);
  late final _scorePool = ScorePool(_packageNameIndex._packageNames);

  /// Maps the tag strings to a list of document index values using bit arrays.
  /// - (`PackageDocument doc.tags -> BitArray(List<_documents.indexOf(doc)>)`).
  final _tagBitArrays = <String, BitArray>{};

  /// Adjusted score takes the overall score and transforms
  /// it linearly into the [0.4-1.0] range.
  late final List<double> _adjustedOverallScores;
  late final List<IndexedPackageHit> _overallOrderedHits;
  late final List<IndexedPackageHit> _createdOrderedHits;
  late final List<IndexedPackageHit> _updatedOrderedHits;
  late final List<IndexedPackageHit> _downloadsOrderedHits;
  late final List<IndexedPackageHit> _likesOrderedHits;
  late final List<IndexedPackageHit> _pointsOrderedHits;
  late final List<IndexedPackageHit> _trendingOrderedHits;

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
      _nameToIndex[doc.package] = i;

      // transform tags into numberical IDs
      for (final tag in doc.tags) {
        _tagBitArrays
            .putIfAbsent(tag, () => BitArray(_documents.length))
            .setBit(i);
      }

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
    _downloadsOrderedHits = _rankWithComparator(_compareDownloads,
        score: (doc) => doc.downloadCount.toDouble());
    _likesOrderedHits = _rankWithComparator(_compareLikes,
        score: (doc) => doc.likeCount.toDouble());
    _pointsOrderedHits = _rankWithComparator(_comparePoints,
        score: (doc) => doc.grantedPoints.toDouble());
    _trendingOrderedHits = _rankWithComparator(_compareTrending,
        score: (doc) => doc.trendScore.toDouble());
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
    if ((query.offset ?? 0) >= _documents.length) {
      return PackageSearchResult.empty();
    }
    return _bitArrayPool.withPoolItem(fn: (array) {
      return _scorePool.withPoolItem(
        fn: (score) {
          return _search(query, array, score);
        },
      );
    });
  }

  PackageSearchResult _search(
    ServiceSearchQuery query,
    BitArray packages,
    IndexedScore<String> packageScores,
  ) {
    // filter on tags
    final combinedTagsPredicate =
        query.tagsPredicate.appendPredicate(query.parsedQuery.tagsPredicate);
    if (combinedTagsPredicate.isNotEmpty) {
      for (final entry in combinedTagsPredicate.entries) {
        final tagBits = _tagBitArrays[entry.key];
        if (entry.value) {
          if (tagBits == null) {
            // the predicate is not matched by any document
            return PackageSearchResult.empty();
          }
          packages.and(tagBits);
        } else {
          if (tagBits == null) {
            // negative predicate without index means all document is matched
            continue;
          }
          packages.andNot(tagBits);
        }
      }
    }

    // filter on package prefix
    if (query.parsedQuery.packagePrefix != null) {
      final prefix = query.parsedQuery.packagePrefix!.toLowerCase();
      packages.clearWhere(
        (i) => !_documents[i].packageNameLowerCased.startsWith(prefix),
      );
    }

    // filter on dependency
    if (query.parsedQuery.hasAnyDependency) {
      packages.clearWhere((i) {
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
      packages
          .clearWhere((i) => _documents[i].grantedPoints < query.minPoints!);
    }

    // filter on updatedDuration
    final updatedDuration = query.parsedQuery.updatedDuration;
    if (updatedDuration != null && updatedDuration > Duration.zero) {
      final now = clock.now();
      packages.clearWhere(
          (i) => now.difference(_documents[i].updated) > updatedDuration);
    }

    // TODO: find a better way to handle predicate-only filtering and scoring
    for (final index in packages.asIntIterable()) {
      if (index >= _documents.length) break;
      packageScores.setValue(index, 1.0);
    }

    // do text matching
    final parsedQueryText = query.parsedQuery.text;
    final textResults = _searchText(
      packageScores,
      packages,
      parsedQueryText,
      textMatchExtent: query.textMatchExtent ?? TextMatchExtent.api,
    );

    String? bestNameMatch;
    if (parsedQueryText != null &&
        query.parsedQuery.hasOnlyFreeText &&
        query.isNaturalOrder) {
      // exact package name
      if (_documentsByName.containsKey(parsedQueryText)) {
        bestNameMatch = parsedQueryText;
      } else {
        // reduced package name match
        final matches = _packageNameIndex.lookupMatchingNames(parsedQueryText);
        if (matches != null && matches.isNotEmpty) {
          bestNameMatch = matches.length == 1
              ? matches.single
              :
              // Note: to keep it simple, we select the most downloaded one from competing matches.
              matches.reduce((a, b) {
                  if (_documentsByName[a]!.downloadCount >
                      _documentsByName[b]!.downloadCount) {
                    return a;
                  } else {
                    return b;
                  }
                });
        }
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
        indexedHits = _rankWithValues(
          packageScores,
          requiredLengthThreshold: query.offset,
          bestNameMatch: bestNameMatch,
        );
        break;
      case SearchOrder.text:
        indexedHits = _rankWithValues(
          packageScores,
          requiredLengthThreshold: query.offset,
          bestNameMatch: bestNameMatch,
        );
        break;
      case SearchOrder.created:
        indexedHits = _createdOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.updated:
        indexedHits = _updatedOrderedHits.whereInScores(packageScores);
        break;
      // ignore: deprecated_member_use
      case SearchOrder.popularity:
      case SearchOrder.downloads:
        indexedHits = _downloadsOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.like:
        indexedHits = _likesOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.points:
        indexedHits = _pointsOrderedHits.whereInScores(packageScores);
        break;
      case SearchOrder.trending:
        indexedHits = _trendingOrderedHits.whereInScores(packageScores);
        break;
    }

    // bound by offset and limit (or randomize items)
    final totalCount = indexedHits.length;
    indexedHits =
        boundedList(indexedHits, offset: query.offset, limit: query.limit);

    late List<PackageHit> packageHits;
    if ((query.textMatchExtent ?? TextMatchExtent.api).shouldMatchApi() &&
        textResults != null &&
        (textResults.topApiPages?.isNotEmpty ?? false)) {
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

    // Only indicate name match when the first item's score is lower than the second's score.
    final indicateNameMatch = bestNameMatch != null &&
        packageHits.length > 1 &&
        ((packageHits[0].score ?? 0) <= (packageHits[1].score ?? 0));
    return PackageSearchResult(
      timestamp: clock.now().toUtc(),
      totalCount: totalCount,
      nameMatches: indicateNameMatch ? [bestNameMatch] : null,
      packageHits: packageHits,
      errorMessage: textResults?.errorMessage,
    );
  }

  /// Update the overall score both on [PackageDocument] and in the [_adjustedOverallScores] map.
  void _updateOverallScores() {
    _adjustedOverallScores = _documents.map((doc) {
      final downloadScore = doc.downloadScore ?? 0.0;
      final likeScore = doc.likeScore ?? 0.0;
      final popularityScore = (downloadScore + likeScore) / 2;

      // prevent division by zero in case maxPoints is zero
      final pointRatio = doc.grantedPoints / math.max(1, doc.maxPoints);
      // force value between 0.0 and 1.0 in case we have bad points
      // using square root to lower the differences between higher values
      final pointScore = math.sqrt(math.max(0.0, math.min(1.0, pointRatio)));

      final overall = popularityScore * 0.5 + pointScore * 0.5;
      doc.overallScore = overall;
      // adding a base score prevents later multiplication with zero
      return 0.4 + 0.6 * overall;
    }).toList();
  }

  _TextResults? _searchText(
    IndexedScore<String> packageScores,
    BitArray packages,
    String? text, {
    required TextMatchExtent textMatchExtent,
  }) {
    if (text == null || text.isEmpty) {
      return null;
    }

    final sw = Stopwatch()..start();
    final words = splitForQuery(text);
    if (words.isEmpty) {
      // packages.clearAll();
      packageScores.fillRange(0, packageScores.length, 0);
      return _TextResults.empty();
    }

    final matchName = textMatchExtent.shouldMatchName();
    if (!matchName) {
      // packages.clearAll();
      packageScores.fillRange(0, packageScores.length, 0);
      return _TextResults.empty(
          errorMessage:
              'Search index in reduced mode: unable to match query text.');
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

    final matchDescription = textMatchExtent.shouldMatchDescription();
    final matchReadme = textMatchExtent.shouldMatchReadme();
    final matchApi = textMatchExtent.shouldMatchApi();

    for (final word in words) {
      _scorePool.withPoolItem(
        fn: (wordScore) {
          _packageNameIndex.searchWord(word,
              score: wordScore, filterOnNonZeros: packageScores);

          if (matchDescription) {
            _descrIndex.searchAndAccumulate(word, score: wordScore);
          }
          if (matchReadme) {
            _readmeIndex.searchAndAccumulate(word,
                weight: 0.75, score: wordScore);
          }
          packageScores.multiplyAllFrom(wordScore);
        },
      );
    }

    final topApiPages =
        List<List<MapEntry<String, double>>?>.filled(_documents.length, null);

    if (matchApi) {
      const maxApiPageCount = 2;
      if (!checkAborted()) {
        _apiSymbolIndex.withSearchWords(words, weight: 0.70, (symbolPages) {
          for (var i = 0; i < symbolPages.length; i++) {
            final value = symbolPages.getValue(i);
            if (value < 0.01) continue;

            final doc = symbolPages.keys[i];
            if (!packages[doc.index]) continue;

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
    }

    // filter results based on exact phrases
    final phrases = extractExactPhrases(text);
    if (!aborted && phrases.isNotEmpty) {
      for (var i = 0; i < packageScores.length; i++) {
        if (packageScores.isNotPositive(i)) continue;
        final doc = _documents[i];
        final matchedAllPhrases = phrases.every((phrase) =>
            (matchName && doc.package.contains(phrase)) ||
            (matchDescription && doc.description!.contains(phrase)) ||
            (matchReadme && doc.readme!.contains(phrase)));
        if (!matchedAllPhrases) {
          packageScores.setValue(i, 0);
        }
      }
    }

    return _TextResults(topApiPages);
  }

  List<IndexedPackageHit> _rankWithValues(
    IndexedScore<String> score, {
    // if the item count is fewer than this threshold, an empty list will be returned
    int? requiredLengthThreshold,
    String? bestNameMatch,
  }) {
    final list = <IndexedPackageHit>[];
    final bestNameIndex =
        bestNameMatch == null ? null : _nameToIndex[bestNameMatch];
    for (var i = 0; i < score.length; i++) {
      final value = score.getValue(i);
      if (value <= 0.0 && i != bestNameIndex) continue;
      list.add(IndexedPackageHit(
          i, PackageHit(package: score.keys[i], score: value)));
    }
    if ((requiredLengthThreshold ?? 0) > list.length) {
      // There is no point to sort or even keep the results, as the search query offset ignores these anyway.
      return [];
    }
    list.sort((a, b) {
      if (a.index == bestNameIndex) return -1;
      if (b.index == bestNameIndex) return 1;
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

  int _compareTrending(PackageDocument a, PackageDocument b) {
    final x = -a.trendScore.compareTo(b.trendScore);
    if (x != 0) return x;
    return _compareUpdated(a, b);
  }
}

class _TextResults {
  final List<List<MapEntry<String, double>>?>? topApiPages;
  final String? errorMessage;

  factory _TextResults.empty({String? errorMessage}) {
    return _TextResults(
      null,
      errorMessage: errorMessage,
    );
  }

  _TextResults(
    this.topApiPages, {
    this.errorMessage,
  });
}

/// A simple (non-inverted) index designed for package name lookup.
@visibleForTesting
class PackageNameIndex {
  final List<String> _packageNames;
  late final List<_PkgNameData> _data;

  /// Maps the collapsed name to all the original names (e.g. `asyncmap`=> [`async_map`, `as_y_n_cmaP`]).
  late final Map<String, List<String>> _collapsedNameResolvesToMap;

  PackageNameIndex(this._packageNames) {
    _data = _packageNames.map((package) {
      final lowercased = package.toLowerCase();
      final collapsed = _removeUnderscores(lowercased);
      return _PkgNameData(lowercased, collapsed, trigrams(collapsed).toSet());
    }).toList();
    _collapsedNameResolvesToMap = {};
    for (var i = 0; i < _data.length; i++) {
      _collapsedNameResolvesToMap
          .putIfAbsent(_data[i].collapsed, () => [])
          .add(_packageNames[i]);
    }
  }

  String _removeUnderscores(String text) => text.replaceAll('_', '');

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
    final lowercasedWord = word.toLowerCase();
    final collapsedWord = _removeUnderscores(lowercasedWord);
    final parts =
        collapsedWord.length <= 3 ? [collapsedWord] : trigrams(collapsedWord);
    for (var i = 0; i < _data.length; i++) {
      if (filterOnNonZeros?.isNotPositive(i) ?? false) {
        continue;
      }

      final entry = _data[i];
      if (entry.collapsed.length >= collapsedWord.length &&
          entry.collapsed.contains(collapsedWord)) {
        // also check for non-collapsed match
        if (entry.lowercased.length >= lowercasedWord.length &&
            entry.lowercased.contains(lowercasedWord)) {
          score.setValue(i, 1.0);
          continue;
        }

        score.setValue(i, 0.99);
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

  /// Returns the list of package names where the collapsed name matches.
  List<String>? lookupMatchingNames(String text) {
    return _collapsedNameResolvesToMap[_removeUnderscores(text.toLowerCase())];
  }
}

class _PkgNameData {
  final String lowercased;
  final String collapsed;
  final Set<String> trigrams;

  _PkgNameData(this.lowercased, this.collapsed, this.trigrams);
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
