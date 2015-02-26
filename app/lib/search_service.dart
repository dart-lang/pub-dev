// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/customsearch/v1.dart' as customsearch;
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


/// Uses the datastore API in the current service scope to retrieve the private
/// Key and creates a new SearchService.
///
/// If the private key cannot be retrieved from datastore this method will
/// complete with `null`.
Future<SearchService> searchServiceViaApiKeyFromDb() async {
  String keyString = await customSearchKeyFromDB();
  var httpClient = auth.clientViaApiKey(keyString);
  var csearch = new customsearch.CustomsearchApi(httpClient);
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

  /// Search for packes using [query], starting at offset [offset] returning
  /// max [numResults].
  Future<SearchResultPage> search(
      String query, int offset, int numResults) async {
    var db = dbService;

    var search = await csearch.cse.list(
        query, cx: _CUSTOM_SEARCH_ID, num: numResults, start: 1 + offset);
    if (search.items != null) {
      var keys = search.items.map((item) {
        var match = _PackageUrlPattern.matchAsPrefix(item.link);
        if (match != null) {
          return db.emptyKey.append(Package, id: match.group(1));
        }
      }).where((i) => i != null).toList();

      if (keys.length > 0) {
        var packages = await db.lookup(keys);
        // TODO: Insert check that all packages the indexer found, we can
        // lookup.
        var versionKeys = packages.map((p) => p.latestVersionKey).toList();
        var versions = await db.lookup(versionKeys);
        int count = int.parse(search.searchInformation.totalResults);
        if (count > SEARCH_MAX_RESULTS) count = SEARCH_MAX_RESULTS;
        return new SearchResultPage(query, offset, count, versions);
      }
    }
    return new SearchResultPage(query, offset, 0, []);
  }
}

/// The results of a search via the Custom Search API.
class SearchResultPage {
  /// The query string used for the search.
  final String query;

  /// The offset used for the search/
  final int offset;

  /// The total number of results available for the search.
  final int totalCount;

  /// The latest versions of the packages found by the search.
  final List<PackageVersion> packageVersions;

  SearchResultPage(
      this.query, this.offset, this.totalCount, this.packageVersions);
}
