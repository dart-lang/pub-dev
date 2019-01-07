// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;

import '../scorecard/backend.dart';
import '../scorecard/models.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';

import 'models.dart';

/// The [SearchService] registered in the current service scope.
SearchService get searchService => ss.lookup(#_search) as SearchService;

/// Register a new [SearchService] in the current service scope.
void registerSearchService(SearchService s) => ss.register(#_search, s);

/// A wrapper around the Custom Search API, used for searching for pub packages.
class SearchService {
  Future<SearchResultPage> search(SearchQuery query) async {
    final result = await searchClient.search(query);
    return _loadResultForPackages(query, result.totalCount, result.packages);
  }

  Future close() async {}
}

Future<SearchResultPage> _loadResultForPackages(
    SearchQuery query, int totalCount, List<PackageScore> packageScores) async {
  final List<Key> packageKeys = packageScores
      .where((ps) => !ps.isExternal)
      .map((ps) => ps.package)
      .map((package) => dbService.emptyKey.append(Package, id: package))
      .toList();
  final packageEntries = (await dbService.lookup(packageKeys)).cast<Package>();
  packageEntries.removeWhere((p) => p == null);

  final pubPackages = <String, PackageView>{};
  final List<Key> versionKeys =
      packageEntries.map((p) => p.latestVersionKey).toList();
  if (versionKeys.isNotEmpty) {
    // Analysis data fetched concurrently to reduce overall latency.
    final Future<List<ScoreCardData>> analysisExtractsFuture = Future.wait(
        packageEntries.map((p) => scoreCardBackend
            .getScoreCardData(p.name, p.latestVersion, onlyCurrent: false)));
    final Future<List> allVersionsFuture = dbService.lookup(versionKeys);

    final List batchResults =
        await Future.wait([analysisExtractsFuture, allVersionsFuture]);
    final List<ScoreCardData> scoreCards = await batchResults[0];
    final List<PackageVersion> versions =
        (await batchResults[1]).cast<PackageVersion>();

    for (int i = 0; i < versions.length; i++) {
      final package = packageEntries[i];
      final apiPages =
          packageScores.firstWhere((ps) => ps.package == package.name).apiPages;
      final pv = new PackageView.fromModel(
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
          return new PackageView(
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
  return new SearchResultPage(query, totalCount, resultPackages);
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
      new SearchResultPage(query, 0, []);
}

/// Returns the top packages for displaying them on a landing page.
Future<List<PackageView>> topFeaturedPackages(
    {String platform, int count = 15}) async {
  // TODO: store top packages in memcache
  final result = await searchService.search(new SearchQuery.parse(
    platform: platform,
    limit: count,
    isAd: true,
  ));
  return result.packages.take(count).toList();
}
