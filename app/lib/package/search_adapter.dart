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
import '../search/search_form.dart';
import '../search/search_service.dart';

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
    String? sdk,
    bool contextIsFlutterFavorites = false,
    int count = 6,
    SearchOrder? order,
  }) async {
    final form = SearchForm.parse(
      contextIsFlutterFavorites: contextIsFlutterFavorites,
      sdk: sdk,
      pageSize: 100,
      order: order,
    );
    final searchResults = await _searchOrFallback(
      form,
      false,
      ttl: Duration(hours: 6),
      updateCacheAfter: Duration(hours: 1),
    );
    if (searchResults == null || searchResults.isEmpty) {
      return <PackageView>[];
    }
    final availablePackages =
        searchResults.allPackageHits.map((ps) => ps.package).toList();
    final packages = <String>[];
    for (var i = 0; i < count && availablePackages.isNotEmpty; i++) {
      // The first item should come from the top results.
      final index = i == 0 && availablePackages.length > 20
          ? _random.nextInt(20)
          : _random.nextInt(availablePackages.length);
      packages.add(availablePackages.removeAt(index));
    }
    return (await _getPackageViews(packages)).cast<PackageView>();
  }

  /// Performs search using the `search` service and lookup package info and
  /// score from DatastoreDB.
  ///
  /// When the `search` service fails, it falls back to use the name tracker to
  /// provide package names and perform search in that set.
  Future<SearchResultPage> search(SearchForm form) async {
    final result = await _searchOrFallback(form, true);
    final views = await _getPackageViewsFromHits(
      [
        if (result?.highlightedHit != null) result!.highlightedHit!,
        if (result?.packageHits != null) ...result!.packageHits,
      ],
    );
    return SearchResultPage(
      form,
      result!.totalCount,
      highlightedHit: result.highlightedHit == null
          ? null
          : views[result.highlightedHit!.package],
      sdkLibraryHits: result.sdkLibraryHits,
      packageHits: result.packageHits
          .map((h) => views[h.package])
          .where((v) => v != null)
          .cast<PackageView>()
          .toList(),
      message: result.message,
    );
  }

  Future<PackageSearchResult?> _searchOrFallback(
    SearchForm searchForm,
    bool fallbackToNames, {
    Duration? ttl,
    Duration? updateCacheAfter,
  }) async {
    PackageSearchResult? result;
    try {
      result = await searchClient.search(searchForm.toServiceQuery(),
          ttl: ttl, updateCacheAfter: updateCacheAfter);
    } catch (e, st) {
      _logger.severe('Unable to search packages', e, st);
    }
    if (result == null && fallbackToNames) {
      result = await _fallbackSearch(searchForm);
    }
    return result;
  }

  /// Search over the package names as a fallback, in the absence of the
  /// `search` service.
  Future<PackageSearchResult> _fallbackSearch(SearchForm form) async {
    // Some search queries must not be served with the fallback search.
    if (form.uploaderOrPublishers != null || form.publisherId != null) {
      return PackageSearchResult.empty(
          message: 'Search is temporarily unavailable.');
    }

    final names =
        await nameTracker.getPackageNames().timeout(Duration(seconds: 5));
    final text = (form.query ?? '').trim().toLowerCase();
    List<PackageHit> packageHits =
        names.where((s) => s.contains(text)).map((pkgName) {
      if (pkgName == text) {
        return PackageHit(package: pkgName, score: 1.0);
      } else if (pkgName.startsWith(text)) {
        return PackageHit(package: pkgName, score: 0.75);
      } else {
        return PackageHit(package: pkgName, score: 0.5);
      }
    }).toList();
    packageHits.sort((a, b) => -a.score!.compareTo(b.score!));

    final totalCount = packageHits.length;
    packageHits =
        packageHits.skip(form.offset).take(form.pageSize ?? 10).toList();
    return PackageSearchResult(
        timestamp: DateTime.now().toUtc(),
        packageHits: packageHits,
        totalCount: totalCount,
        message:
            'Search is temporarily impaired, filtering and ranking may be incorrect.');
  }

  /// Returns the [PackageView] instance for each package in [packages], using
  /// the latest stable version.
  ///
  /// If the package does not exist, it will return null in the given index.
  Future<List<PackageView?>> _getPackageViews(List<String> packages) async {
    final futures = <Future<PackageView?>>[];
    for (final p in packages) {
      futures.add(
          _pool.withResource(() async => scoreCardBackend.getPackageView(p)));
    }
    return await Future.wait(futures);
  }

  Future<Map<String, PackageView>> _getPackageViewsFromHits(
      List<PackageHit> hits) async {
    final results = <String, PackageView>{};
    final futures = <Future>[];
    for (final hit in hits) {
      final f = _pool.withResource(() async {
        final view = await scoreCardBackend.getPackageView(hit.package);
        if (view == null) {
          // The package may have been deleted, but the index still has it.
          return;
        }
        results[hit.package] = view.change(apiPages: hit.apiPages);
      });
      futures.add(f);
    }
    await Future.wait(futures);
    return results;
  }

  Future<void> close() async {
    await _pool.close();
  }
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The form used for the search.
  final SearchForm form;

  /// The total number of results available for the search.
  final int totalCount;

  final PackageView? highlightedHit;

  final List<SdkLibraryHit> sdkLibraryHits;

  /// The current list of packages on the page.
  final List<PackageView> packageHits;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String? message;

  SearchResultPage(
    this.form,
    this.totalCount, {
    this.highlightedHit,
    List<SdkLibraryHit>? sdkLibraryHits,
    List<PackageView>? packageHits,
    this.message,
  })  : sdkLibraryHits = sdkLibraryHits ?? <SdkLibraryHit>[],
        packageHits = packageHits ?? <PackageView>[];

  SearchResultPage.empty(this.form, {this.message})
      : totalCount = 0,
        highlightedHit = null,
        sdkLibraryHits = <SdkLibraryHit>[],
        packageHits = [];

  bool get hasNoHit =>
      highlightedHit == null && sdkLibraryHits.isEmpty && packageHits.isEmpty;
  bool get hasHit => !hasNoHit;
}
