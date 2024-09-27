// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/search_form.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/shared/env_config.dart';

import '../scorecard/backend.dart';
import '../search/search_client.dart';
import '../search/search_service.dart';

import 'models.dart';
import 'name_tracker.dart';

final _logger = Logger('frontend.search_adapter');

/// The `SearchAdapter` registered in the current service scope.
SearchAdapter get searchAdapter => ss.lookup(#_search) as SearchAdapter;

/// Register a new [SearchAdapter] in the current service scope.
void registerSearchAdapter(SearchAdapter s) => ss.register(#_search, s);

/// Uses the HTTP-based `search` service client to execute a search query and
/// processes its results, extending the search results with up-to-date package
/// data.
class SearchAdapter {
  /// Performs search using the `search` service and lookup package info and
  /// score from DatastoreDB.
  ///
  /// When the `search` service fails, it falls back to use the name tracker to
  /// provide package names and perform search in that set.
  Future<SearchResultPage> search(SearchForm form,
      {required String? rateLimitKey}) async {
    final result = (await _searchOrFallback(form, rateLimitKey, true))!;
    final views = await _getPackageViewsFromHits([...result.packageHits]);
    return SearchResultPage(
      form,
      result.totalCount,
      nameMatches: result.nameMatches,
      sdkLibraryHits: result.sdkLibraryHits,
      packageHits:
          result.packageHits.map((h) => views[h.package]).nonNulls.toList(),
      errorMessage: result.errorMessage,
      statusCode: result.statusCode ?? 200,
    );
  }

  Future<PackageSearchResult?> _searchOrFallback(
    SearchForm searchForm,
    String? sourceIp,
    bool fallbackToNames,
  ) async {
    PackageSearchResult? result;
    try {
      result = await searchClient.search(
        searchForm.toServiceQuery(),
        sourceIp: sourceIp,
      );
    } on RateLimitException {
      rethrow;
    } catch (e, st) {
      if (envConfig.isRunningLocally) {
        // The fake server will start up the different instances with a slight
        // delay, and cached values like the top packages will trigger a few
        // search failures (which will be retried and successful shortly).
        _logger.info('Unable to search packages.', e);
      } else {
        _logger.severe('Unable to search packages.', e, st);
      }
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
    if (form.parsedQuery.tagsPredicate.isNotEmpty) {
      return PackageSearchResult.error(
        errorMessage: 'Search is temporarily unavailable.',
        statusCode: 503,
      );
    }

    final names = await nameTracker
        .getVisiblePackageNames()
        .timeout(Duration(seconds: 5));
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
      timestamp: clock.now().toUtc(),
      packageHits: packageHits,
      totalCount: totalCount,
      errorMessage:
          'Search is temporarily impaired, filtering and ranking may be incorrect.',
      statusCode: 503,
    );
  }

  Future<Map<String, PackageView>> _getPackageViewsFromHits(
      List<PackageHit> hits) async {
    final views = await scoreCardBackend
        .getPackageViews(hits.map((h) => h.package).toList());
    final results = <String, PackageView>{};
    for (var i = 0; i < hits.length; i++) {
      final view = views[i];
      if (view == null) continue;
      results[view.name] = view.change(apiPages: hits[i].apiPages);
    }
    return results;
  }
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The form used for the search.
  final SearchForm form;

  /// The total number of results available for the search.
  final int totalCount;

  /// Package names that are exact name matches or close to (e.g. names that
  /// would be considered as blocker for publishing).
  final List<String>? nameMatches;

  /// The hits from the SDK libraries.
  final List<SdkLibraryHit> sdkLibraryHits;

  /// The current list of packages on the page.
  final List<PackageView> packageHits;

  /// An optional message from the search service / client library, in case
  /// the query was not processed entirely.
  final String? errorMessage;

  /// The code that will be used to render the page.
  final int statusCode;

  SearchResultPage(
    this.form,
    this.totalCount, {
    this.nameMatches,
    List<SdkLibraryHit>? sdkLibraryHits,
    List<PackageView>? packageHits,
    this.errorMessage,
    this.statusCode = 200,
  })  : sdkLibraryHits = sdkLibraryHits ?? <SdkLibraryHit>[],
        packageHits = packageHits ?? <PackageView>[];

  bool get hasNoHit => sdkLibraryHits.isEmpty && packageHits.isEmpty;
  bool get hasHit => !hasNoHit;
}
