// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/platform.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';

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

  Future<PackageSearchResult> _fallbackSearch(SearchQuery query) async {
    final names =
        await nameTracker.getPackageNames().timeout(Duration(seconds: 5));
    List<PackageScore> scores = <PackageScore>[];
    final text = (query.query ?? '').trim().toLowerCase();
    if (text.isNotEmpty) {
      if (nameTracker.hasPackage(text)) {
        scores.add(PackageScore(package: text, score: 1.0));
      }
      names.where((s) => s != text && s.startsWith(text)).forEach((s) {
        scores.add(PackageScore(package: s, score: 0.75));
      });
      names.where((s) => !s.startsWith(text) && s.contains(text)).forEach((s) {
        scores.add(PackageScore(package: s, score: 0.50));
      });
    } else {
      scores.addAll(names.map((s) => PackageScore(package: s, score: 0.1)));
    }
    final totalCount = scores.length;
    scores = scores.skip(query.offset ?? 0).take(query.limit ?? 10).toList();
    return PackageSearchResult(packages: scores, totalCount: totalCount);
  }

  Future close() async {}

  Future<SearchResultPage> _loadResultForPackages(SearchQuery query,
      int totalCount, List<PackageScore> packageScores) async {
    final packageEntries = await backend.lookupPackages(
        packageScores.where((ps) => !ps.isExternal).map((ps) => ps.package));
    packageEntries.removeWhere((p) => p == null);

    final pubPackages = <String, PackageView>{};
    final List<Key> versionKeys =
        packageEntries.map((p) => p.latestVersionKey).toList();
    if (versionKeys.isNotEmpty) {
      // Analysis data fetched concurrently to reduce overall latency.
      final Future<List<ScoreCardData>> analysisExtractsFuture = Future.wait(
          packageEntries.map((p) =>
              scoreCardBackend.getScoreCardData(p.name, p.latestVersion)));
      final Future<List<PackageVersion>> allVersionsFuture =
          backend.lookupLatestVersions(packageEntries);

      final List batchResults =
          await Future.wait([analysisExtractsFuture, allVersionsFuture]);
      final scoreCards =
          ((await batchResults[0]) as List).cast<ScoreCardData>();
      final versions = ((await batchResults[1]) as List).cast<PackageVersion>();

      for (int i = 0; i < versions.length; i++) {
        final package = packageEntries[i];
        final apiPages = packageScores
            .firstWhere((ps) => ps.package == package.name)
            .apiPages;
        final pv = PackageView.fromModel(
          package: package,
          version: versions[i],
          scoreCard: scoreCards[i],
          apiPages: apiPages,
        );
        pubPackages[pv.name] = pv;
      }
    }

    final resultPackages = packageScores
        .map((ps) {
          if (pubPackages.containsKey(ps.package)) {
            return pubPackages[ps.package];
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
