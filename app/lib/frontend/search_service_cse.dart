// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of pub_dartlang_org.search_service;

/// The Custom Search ID used for making calls to the Custom Search API.
const String _CUSTOM_SEARCH_ID = "009011925481577436976:h931xn2j7o0";

/// The maximum number of results the Custom Search API will provide.
const SEARCH_MAX_RESULTS = 100;

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

class _GoogleCseClient {
  /// The URL pattern used to extract the package name from the result of a
  /// call to the Custom Search API.
  static final RegExp _PackageUrlPattern =
      new RegExp(r'https?://pub\.dartlang\.org/packages/([a-z0-9_]+)');

  /// The HTTP client used for making authenticated calls to the
  /// Custom Search API.
  final http.Client httpClient;

  /// The Custom Search client API stub.
  final customsearch.CustomsearchApi csearch;

  _GoogleCseClient(this.httpClient, this.csearch);

  Future<SearchResultPage> _searchCSE(SearchQuery query) async {
    final search = await csearch.cse.list(buildCseQueryText(query),
        cx: _CUSTOM_SEARCH_ID,
        num: query.limit,
        start: 1 + query.offset,
        sort: buildCseSort(query.bias));
    if (search.items != null) {
      final List<String> packages = search.items
          .map((item) {
            final match = _PackageUrlPattern.matchAsPrefix(item.link);
            return match == null ? null : match.group(1);
          })
          .where((String package) => package != null)
          .toList();
      final int count = min(
          int.parse(search.searchInformation.totalResults), SEARCH_MAX_RESULTS);
      return await _loadResultForPackages(query, count, packages, 'cse');
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

/// Returns the query text to use in CSE.
String buildCseQueryText(SearchQuery query) {
  String queryText = query.text;
  if (query.packagePrefix != null) {
    queryText += ' ${query.packagePrefix}';
  }
  query.platformPredicate?.required?.forEach((String platform) {
    // Corresponds with the <PageMap> entry in views/layout.mustache.
    queryText +=
        ' more:pagemap:${CseTokens.pageMapDocument}-${CseTokens.detectedType(platform)}:1';
  });
  return queryText;
}

/// Returns the sort attribute to use in CSE.
/// https://developers.google.com/custom-search/docs/structured_search#bias-by-attribute
String buildCseSort(SearchBias bias) {
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
