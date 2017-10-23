// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;

import '../shared/analyzer_client.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';

import 'models.dart';

/// The [SearchService] registered in the current service scope.
SearchService get searchService => ss.lookup(#_search);

/// Register a new [SearchService] in the current service scope.
void registerSearchService(SearchService s) => ss.register(#_search, s);

/// A wrapper around the Custom Search API, used for searching for pub packages.
class SearchService {
  /// Search for packes using [queryText], starting at offset [offset] returning
  /// max [numResults].
  Future<SearchResultPage> search(SearchQuery query) async {
    final result = await searchClient.search(query);
    final packages = result.packages.map((ps) => ps.package).toList();
    return _loadResultForPackages(query, result.totalCount, packages);
  }

  Future close() async {}
}

Future<SearchResultPage> _loadResultForPackages(
    SearchQuery query, int totalCount, List<String> packages) async {
  final packageKeys = packages
      .map((package) => dbService.emptyKey.append(Package, id: package))
      .toList();
  final List<Package> packageEntries = await dbService.lookup(packageKeys);
  packageEntries.removeWhere((p) => p == null);

  final versionKeys = packageEntries.map((p) => p.latestVersionKey).toList();
  if (versionKeys.isNotEmpty) {
    // Analysis data fetched concurrently to reduce overall latency.
    final analysisViewsFuture = analyzerClient.getAnalysisViews(
        packageEntries.map((p) => new AnalysisKey(p.name, p.latestVersion)));
    final Future<List<PackageVersion>> allVersionsFuture =
        dbService.lookup(versionKeys);

    final batchResults =
        await Future.wait([analysisViewsFuture, allVersionsFuture]);
    final List<AnalysisView> analysisViews = batchResults[0];
    final List<PackageVersion> versions = batchResults[1];

    final resultPackages = new List.generate(
        versions.length,
        (i) => new PackageView.fromModel(
              package: packageEntries[i],
              version: versions[i],
              analysis: analysisViews[i],
            ));
    return new SearchResultPage(query, totalCount, resultPackages);
  } else {
    return new SearchResultPage.empty(query);
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
      new SearchResultPage(query, 0, []);
}
