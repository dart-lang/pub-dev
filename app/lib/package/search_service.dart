// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../scorecard/backend.dart';
import '../search/search_client.dart';
import '../search/search_service.dart';
import '../shared/platform.dart';
import '../shared/redis_cache.dart' show cache;

import 'backend.dart';
import 'models.dart';
import 'name_tracker.dart';

final _logger = Logger('frontend.search_service');

/// The [SearchService] registered in the current service scope.
SearchService get searchService => ss.lookup(#_search) as SearchService;

/// Register a new [SearchService] in the current service scope.
void registerSearchService(SearchService s) => ss.register(#_search, s);

/// A wrapper around the Custom Search API, used for searching for pub packages.
class SearchService {
  /// Performs search using the `search` service and lookup package info and
  /// score from DatastoreDB.
  ///
  /// When the `search` service fails, it falls back to use the name tracker to
  /// provide package names and perform search in that set. Set [fallbackToNames]
  /// to false in cases where this is not the desired result.
  Future<SearchResultPage> search(SearchQuery query,
      {bool fallbackToNames = true}) async {
    PackageSearchResult result;
    try {
      result = await searchClient.search(query);
    } catch (e, st) {
      _logger.severe('Unable to search packages', e, st);
    }
    if (result == null && fallbackToNames) {
      result = await _fallbackSearch(query);
    }
    return _loadResultForPackages(query, result.totalCount, result.packages);
  }

  /// Search over the package names as a fallback, in the absence of the
  /// `search` service.
  Future<PackageSearchResult> _fallbackSearch(SearchQuery query) async {
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
    return PackageSearchResult(packages: scores, totalCount: totalCount);
  }

  Future close() async {}

  /// Returns the [PackageView] instance for [package] on its latest stable version.
  Future<PackageView> _getPackageView(String package) async {
    return await cache.packageView(package).get(() async {
      final p = await packageBackend.lookupPackage(package);
      if (p == null) return null;

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
  Future<List<PackageView>> getPackageViews(List<String> packages) async {
    // TODO: consider a cache-check first and batch-load the rest of the packages
    return await Future.wait(packages.map((p) => _getPackageView(p)));
  }

  Future<SearchResultPage> _loadResultForPackages(SearchQuery query,
      int totalCount, List<PackageScore> packageScores) async {
    final packageNames = packageScores
        .where((ps) => !ps.isExternal)
        .map((ps) => ps.package)
        .toList();
    final pubPackages = <String, PackageView>{};
    for (final view in await getPackageViews(packageNames)) {
      pubPackages[view.name] = view;
    }

    final resultPackages = packageScores
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
    return SearchResultPage(query, totalCount, resultPackages);
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

  SearchResultPage(this.query, this.totalCount, this.packages);

  factory SearchResultPage.empty(SearchQuery query) =>
      SearchResultPage(query, 0, []);
}

final _fallbackFeatured = <PackageView>[
  PackageView(
    name: 'http',
    ellipsizedDescription:
        'A composable, cross-platform, Future-based API for making HTTP requests.',
    platforms: KnownPlatforms.all,
  ),
  PackageView(
    name: 'image',
    ellipsizedDescription:
        'Provides server and web apps the ability to load, manipulate, and save images with various image file formats including PNG, JPEG, GIF, WebP, TIFF, TGA, PSD, PVR, and OpenEXR.',
    platforms: KnownPlatforms.all,
  ),
  PackageView(
    name: 'uuid',
    ellipsizedDescription:
        'RFC4122 (v1, v4, v5) UUID Generator and Parser for all Dart platforms (Web, VM, Flutter)',
    platforms: KnownPlatforms.all,
  ),
  PackageView(
    name: 'bloc',
    ellipsizedDescription:
        'A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.',
    platforms: KnownPlatforms.all,
  ),
  PackageView(
    name: 'event_bus',
    ellipsizedDescription:
        'A simple Event Bus using Dart Streams for decoupling applications',
    platforms: KnownPlatforms.all,
  ),
  PackageView(
    name: 'xml',
    ellipsizedDescription:
        'A lightweight library for parsing, traversing, querying, transforming and building XML documents.',
    platforms: KnownPlatforms.all,
  ),
];

/// Returns the top packages for displaying them on a landing page.
Future<List<PackageView>> topFeaturedPackages(
    {String platform, int count = 15}) async {
  // TODO: store top packages in memcache
  try {
    final result = await searchService.search(
      SearchQuery.parse(
        platform: platform,
        limit: count,
        isAd: true,
      ),
      fallbackToNames: false,
    );
    return result.packages.take(count).toList();
  } catch (e, st) {
    _logger.severe('Unable to load top packages', e, st);
  }
  return _fallbackFeatured;
}
