// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../scorecard/backend.dart';
import '../search/search_client.dart';
import '../search/search_service.dart';
import '../shared/redis_cache.dart' show cache;

import 'backend.dart';
import 'models.dart';
import 'name_tracker.dart';

final _logger = Logger('frontend.search_adapter');
final _random = Random.secure();

/// The `SearchAdapter` registered in the current service scope.
SearchAdapter get searchAdapter => ss.lookup(#_search) as SearchAdapter;

/// Register a new [SearchAdapter] in the current service scope.
void registerSearchAdapter(SearchAdapter s) => ss.register(#_search, s);

/// Uses the HTTP-based `search` service client to execute a search query and
/// processes its results, extending the search results with up-to-date package
/// data.
class SearchAdapter {
  final _pool = Pool(16);

  /// Lookup the top featured packages with the specific tags and sorting.
  ///
  /// Uses long-term caching and local randomized selection.
  /// Returns empty list when search is not available or doesn't yield results.
  Future<List<PackageView>> topFeatured({
    List<String> requiredTags,
    int count = 6,
    SearchOrder order,
  }) async {
    final query = SearchQuery.parse(
      limit: 100,
      tagsPredicate: TagsPredicate.advertisement(requiredTags: requiredTags),
      order: order,
    );
    final searchResults = await _searchOrFallback(
      query,
      false,
      ttl: Duration(hours: 6),
      updateCacheAfter: Duration(hours: 1),
    );
    if (searchResults?.packages == null) {
      return <PackageView>[];
    }
    final availablePackages = searchResults.packages
        .where((e) => !e.isExternal)
        .map((ps) => ps.package)
        .toList();
    final packages = <String>[];
    for (var i = 0; i < count && availablePackages.isNotEmpty; i++) {
      // The first item should come from the top results.
      final index = i == 0 && availablePackages.length > 20
          ? _random.nextInt(20)
          : _random.nextInt(availablePackages.length);
      packages.add(availablePackages.removeAt(index));
    }
    return await _getPackageViews(packages);
  }

  /// Performs search using the `search` service and lookup package info and
  /// score from DatastoreDB.
  ///
  /// When the `search` service fails, it falls back to use the name tracker to
  /// provide package names and perform search in that set.
  Future<SearchResultPage> search(SearchQuery query) async {
    final result = await _searchOrFallback(query, true);
    return SearchResultPage(query, result.totalCount,
        await getPackageViews(result.packages), result.message);
  }

  Future<PackageSearchResult> _searchOrFallback(
    SearchQuery query,
    bool fallbackToNames, {
    Duration ttl,
    Duration updateCacheAfter,
  }) async {
    PackageSearchResult result;
    try {
      result = await searchClient.search(query,
          ttl: ttl, updateCacheAfter: updateCacheAfter);
    } catch (e, st) {
      _logger.severe('Unable to search packages', e, st);
    }
    if (result == null && fallbackToNames) {
      result = await _fallbackSearch(query);
    }
    return result;
  }

  /// Search over the package names as a fallback, in the absence of the
  /// `search` service.
  Future<PackageSearchResult> _fallbackSearch(SearchQuery query) async {
    // Some search queries must not be served with the fallback search.
    if (query.uploaderOrPublishers != null || query.publisherId != null) {
      return PackageSearchResult.empty(
          message: 'Search is temporarily unavailable.');
    }

    final names =
        await nameTracker.getPackageNames().timeout(Duration(seconds: 5));
    final text = (query.query ?? '').trim().toLowerCase();
    List<PackageScore> scores =
        names.where((s) => s.contains(text)).map((pkgName) {
      if (pkgName == text) {
        return PackageScore(package: pkgName, score: 1.0);
      } else if (pkgName.startsWith(text)) {
        return PackageScore(package: pkgName, score: 0.75);
      } else {
        return PackageScore(package: pkgName, score: 0.5);
      }
    }).toList();
    scores.sort((a, b) => -a.score.compareTo(b.score));

    final totalCount = scores.length;
    scores = scores.skip(query.offset ?? 0).take(query.limit ?? 10).toList();
    return PackageSearchResult(
        timestamp: DateTime.now().toUtc(),
        packages: scores,
        totalCount: totalCount,
        message:
            'Search is temporarily impaired, filtering and ranking may be incorrect.');
  }

  /// Returns the [PackageView] instance for [package] on its latest stable version.
  ///
  /// Returns null if the package does not exists.
  Future<PackageView> _getPackageView(String package) async {
    return await cache.packageView(package).get(() async {
      final p = await packageBackend.lookupPackage(package);
      if (p == null) {
        _logger.warning('Package lookup failed for "$package".');
        return null;
      }

      final version = p.latestVersion;
      final pvFuture = packageBackend.lookupPackageVersion(package, version);
      final cardFuture = scoreCardBackend.getScoreCardData(package, version);
      await Future.wait([pvFuture, cardFuture]);

      final pv = await pvFuture;
      final card = await cardFuture;
      return PackageView.fromModel(package: p, version: pv, scoreCard: card);
    });
  }

  /// Returns the [PackageView] instance for each package in [packages], using
  /// the latest stable version.
  ///
  /// If the package does not exist, it will return null in the given index.
  Future<List<PackageView>> _getPackageViews(List<String> packages) async {
    final futures = <Future<PackageView>>[];
    for (final p in packages) {
      futures.add(_pool.withResource(() async => _getPackageView(p)));
    }
    return await Future.wait(futures);
  }

  Future<List<PackageView>> getPackageViews(List<PackageScore> packages) async {
    final packageNames =
        packages.where((ps) => !ps.isExternal).map((ps) => ps.package).toList();
    final pubPackages = <String, PackageView>{};
    for (final view in await _getPackageViews(packageNames)) {
      // The package may have been deleted, but the index still has it.
      if (view == null) continue;
      pubPackages[view.name] = view;
    }

    return packages
        .map((ps) {
          if (pubPackages.containsKey(ps.package)) {
            final view = pubPackages[ps.package];
            return view.change(apiPages: ps.apiPages);
          }
          if (ps.isExternal) {
            return PackageView(
              isExternal: true,
              url: ps.url,
              version: ps.version,
              name: ps.package,
              ellipsizedDescription: ps.description,
              apiPages: ps.apiPages,
            );
          }
          return null;
        })
        .where((pv) => pv != null)
        .toList();
  }

  Future<void> close() async {
    await _pool.close();
  }
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The query used for the search.
  final SearchQuery query;

  /// The total number of results available for the search.
  final int totalCount;

  /// The packages found by the search.
  final List<PackageView> packages;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String message;

  SearchResultPage(this.query, this.totalCount, this.packages, this.message);

  factory SearchResultPage.empty(SearchQuery query, {String message}) =>
      SearchResultPage(query, 0, [], message);
}
