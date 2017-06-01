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
import 'package:http/http.dart' as http;

import 'keys.dart';
import 'models.dart';

/// The Custom Search ID used for making calls to the Custom Search API.
const String _CUSTOM_SEARCH_ID = "009011925481577436976:h931xn2j7o0";

/// The maximum number of results the Custom Search API will provide.
const SEARCH_MAX_RESULTS = 100;

/// The [SearchService] registered in the current service scope.
SearchService get searchService => ss.lookup(#_search);

/// Register a new [SearchService] in the current service scope.
void registerSearchService(SearchService s) => ss.register(#_search, s);

abstract class CseTokens {
  static const String pageMapDocument = 'document';
  static const String detectedTypePrefix = 'dt_';
  static const String experimentalScore = 'exp_score';

  static String detectedType(String type) => '$detectedTypePrefix$type';
}

/// Uses the datastore API in the current service scope to retrieve the private
/// Key and creates a new SearchService.
///
/// If the private key cannot be retrieved from datastore this method will
/// complete with `null`.
Future<SearchService> searchServiceViaApiKeyFromDb() async {
  final String keyString = await customSearchKeyFromDB();
  final httpClient = auth.clientViaApiKey(keyString);
  final csearch = new customsearch.CustomsearchApi(httpClient);
  return new SearchService(httpClient, csearch);
}

/// A wrapper around the Custom Search API, used for searching for pub packages.
class SearchService {
  /// The URL pattern used to extract the package name from the result of a
  /// call to the Custom Search API.
  static final RegExp _PackageUrlPattern =
      new RegExp(r'https?://pub\.dartlang\.org/packages/([a-z0-9_]+)');

  /// The HTTP client used for making authenticated calls to the
  /// Custom Search API.
  final http.Client httpClient;

  /// The Custom Search client API stub.
  final customsearch.CustomsearchApi csearch;

  SearchService(this.httpClient, this.csearch);

  /// Search for packes using [queryText], starting at offset [offset] returning
  /// max [numResults].
  Future<SearchResultPage> search(SearchQuery query) async {
    bool exists(x) => x != null;
    final db = dbService;

    final search = await csearch.cse.list(query.buildCseQueryText(),
        cx: _CUSTOM_SEARCH_ID,
        num: query.limit,
        start: 1 + query.offset,
        sort: query.buildCseSort());
    if (exists(search.items)) {
      final keys = search.items
          .map((item) {
            final match = _PackageUrlPattern.matchAsPrefix(item.link);
            if (exists(match)) {
              return db.emptyKey.append(Package, id: match.group(1));
            }
          })
          .where(exists)
          .toList();

      if (keys.isNotEmpty) {
        final List<Package> packages = await db.lookup(keys);
        packages.removeWhere((p) => !exists(p));
        final List<Key> versionKeys =
            packages.map((p) => p.latestVersionKey).toList();
        final List<Key> devVersionKeys =
            packages.map((p) => p.latestDevVersionKey).toList();
        if (versionKeys.isNotEmpty) {
          final allVersions =
              await db.lookup([]..addAll(versionKeys)..addAll(devVersionKeys));
          final versions = allVersions.sublist(0, versionKeys.length);
          final devVersions = allVersions.sublist(versionKeys.length);
          final int count = min(
              int.parse(search.searchInformation.totalResults),
              SEARCH_MAX_RESULTS);
          return new SearchResultPage(query, count, versions, devVersions);
        }
      }
    }
    return new SearchResultPage.empty(query);
  }
}

// https://developers.google.com/custom-search/docs/structured_search#bias-by-attribute
enum SearchBias { hard, strong, weak }

SearchBias parseExperimentalBias(String value) {
  if (value == null) return null;
  if (value == 'hard') return SearchBias.hard;
  if (value == 'strong') return SearchBias.strong;
  if (value == 'weak') return SearchBias.weak;
  return null;
}

class SearchQuery {
  /// The query string used for the search.
  final String text;

  /// The offset used for the search.
  final int offset;

  /// The maximum number of items queried when search.
  final int limit;

  /// Filter the results for this type.
  final String type;

  /// Bias responses and use score to adjust response order.
  final SearchBias bias;

  SearchQuery(
    this.text, {
    this.offset: 0,
    this.limit: 10,
    this.type,
    this.bias,
  });

  /// Returns the query text to use in CSE.
  String buildCseQueryText() {
    String queryText = text;
    if (type != null && type.isNotEmpty) {
      // Corresponds with the <PageMap> entry in views/layout.mustache.
      queryText +=
          ' more:pagemap:${CseTokens.pageMapDocument}-${CseTokens.detectedType(type)}:1';
    }
    return queryText;
  }

  /// Returns the sort attribute to use in CSE.
  /// https://developers.google.com/custom-search/docs/structured_search#bias-by-attribute
  String buildCseSort() {
    if (bias != null) {
      String suffix;
      switch (bias) {
        case SearchBias.hard:
          suffix = 'h';
          break;
        case SearchBias.strong:
          suffix = 's';
          break;
        case SearchBias.weak:
          suffix = 'w';
          break;
      }
      return '${CseTokens.pageMapDocument}-${CseTokens.experimentalScore}:d:$suffix';
    }
    return null;
  }

  /// Whether the query object can be used for running a search using the custom
  /// search api.
  bool get isValid =>
      text != null &&
      text.isNotEmpty &&
      (type == null || BuiltinTypes.isKnownType(type));
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The query used for the search.
  final SearchQuery query;

  /// The total number of results available for the search.
  final int totalCount;

  /// The latest stable versions of the packages found by the search.
  final List<PackageVersion> stableVersions;

  /// The latest development versions of the packages found by the search.
  final List<PackageVersion> devVersions;

  SearchResultPage(
      this.query, this.totalCount, this.stableVersions, this.devVersions);

  factory SearchResultPage.empty(SearchQuery query) =>
      new SearchResultPage(query, 0, [], []);
}
