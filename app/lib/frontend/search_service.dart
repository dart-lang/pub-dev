// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';
import 'dart:math' show min;

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/customsearch/v1.dart' as customsearch;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;

import '../shared/analyzer_client.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';

import 'keys.dart';
import 'models.dart';

part 'search_service_cse.dart';

Logger _logger = new Logger('pub.frontend.search');

/// Timeout to try search service and after that fall back to CSE.
const searchServiceTimeout = const Duration(seconds: 4);

/// The [SearchService] registered in the current service scope.
SearchService get searchService => ss.lookup(#_search);

/// Register a new [SearchService] in the current service scope.
void registerSearchService(SearchService s) => ss.register(#_search, s);

/// A wrapper around the Custom Search API, used for searching for pub packages.
class SearchService {
  final _GoogleCseClient _cseClient;

  SearchService(http.Client httpClient, customsearch.CustomsearchApi csearch)
      : _cseClient = new _GoogleCseClient(httpClient, csearch);

  /// Search for packes using [queryText], starting at offset [offset] returning
  /// max [numResults].
  Future<SearchResultPage> search(SearchQuery query) async {
    try {
      final result = await searchClient.search(query).timeout(
        searchServiceTimeout,
        onTimeout: () async {
          _logger.warning('Search service exceeded timeout.');
          return null;
        },
      );
      final List<String> packages =
          result.packages.map((ps) => ps.package).toList();
      final page = await _loadResultForPackages(
          query, result.totalCount, packages, 'service');
      if (page != null) {
        return page;
      } else {
        _logger.warning('Search service was not ready.');
      }
    } catch (e, st) {
      _logger.severe('Unable to call search service.', e, st);
    }
    _logger.severe('Fallback to CSE search backend.');
    return _cseClient._searchCSE(query);
  }

  Future close() async {
    _cseClient.httpClient.close();
  }
}

Future<SearchResultPage> _loadResultForPackages(SearchQuery query,
    int totalCount, List<String> packages, String backend) async {
  final List<Key> packageKeys = packages
      .map((package) => dbService.emptyKey.append(Package, id: package))
      .toList();
  final List<Package> packageEntries = await dbService.lookup(packageKeys);
  packageEntries.removeWhere((p) => p == null);

  final List<Key> versionKeys =
      packageEntries.map((p) => p.latestVersionKey).toList();
  final List<Key> devVersionKeys =
      packageEntries.map((p) => p.latestDevVersionKey).toList();
  if (versionKeys.isNotEmpty) {
    // Analysis data fetched concurrently to reduce overall latency.
    final Future<List<AnalysisData>> allAnalysisFuture = Future.wait(
        packageEntries.map(
            (p) => analyzerClient.getAnalysisData(p.name, p.latestVersion)));
    final Future<List<PackageVersion>> allVersionsFuture =
        dbService.lookup([]..addAll(versionKeys)..addAll(devVersionKeys));

    final List batchResults =
        await Future.wait([allAnalysisFuture, allVersionsFuture]);
    final List<AnalysisData> analysisDataList = await batchResults[0];
    final List<PackageVersion> allVersions = await batchResults[1];

    final versions = allVersions.sublist(0, versionKeys.length);
    final devVersions = allVersions.sublist(versionKeys.length);
    final List<SearchResultPackage> resultPackages =
        new List.generate(versions.length, (i) {
      final AnalysisView view = new AnalysisView(analysisDataList[i]);
      return new SearchResultPackage(
          versions[i], devVersions[i], view.platforms);
    });

    return new SearchResultPage(query, totalCount, resultPackages, backend);
  } else {
    return new SearchResultPage.empty(query, backend: backend);
  }
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The query used for the search.
  final SearchQuery query;

  /// The total number of results available for the search.
  final int totalCount;

  /// The packages found by the search.
  final List<SearchResultPackage> packages;

  /// Which search backend was used.
  final String backend;

  SearchResultPage(this.query, this.totalCount, this.packages, this.backend);

  factory SearchResultPage.empty(SearchQuery query, {String backend}) =>
      new SearchResultPage(query, 0, [], backend ?? 'none');
}

/// The composed package data to be displayed on the search results page.
class SearchResultPackage {
  final PackageVersion stableVersion;
  final PackageVersion devVersion;
  final List<String> platforms;

  SearchResultPackage(this.stableVersion, this.devVersion, this.platforms);
}
