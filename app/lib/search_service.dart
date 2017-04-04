// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.search_service;

import 'dart:async';
import 'dart:math' show min;

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

  /// Search for packes using [query], starting at offset [offset] returning
  /// max [numResults].
  Future<SearchResultPage> search(
      String query, int offset, int numResults) async {
    bool exists(x) => x != null;
    final db = dbService;

    final search = await csearch.cse
        .list(query, cx: _CUSTOM_SEARCH_ID, num: numResults, start: 1 + offset);
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
        final List<Key> versionKeys =
            packages.where(exists).map((p) => p.latestVersionKey).toList();
        if (versionKeys.isNotEmpty) {
          // select latest development versions for each package
          final packageKeys = versionKeys.map((vk) => vk.parent).toList();
          final List<PackageVersion> devVersions =
              await Future.wait(packageKeys.map((p) async {
            final List<PackageVersion> all =
                await db.query(PackageVersion, ancestorKey: p).run().toList();
            all.sort((a, b) => b.semanticVersion.compareTo(a.semanticVersion));
            return all.first;
          }));
          final versions = await db.lookup(versionKeys);
          final int count = min(
              int.parse(search.searchInformation.totalResults),
              SEARCH_MAX_RESULTS);
          return new SearchResultPage(
              query, offset, count, versions, devVersions);
        }
      }
    }
    return new SearchResultPage(query, offset, 0, [], []);
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

  /// The latest stable versions of the packages found by the search.
  final List<PackageVersion> stableVersions;

  /// The latest development versions of the packages found by the search.
  final List<PackageVersion> devVersions;

  SearchResultPage(this.query, this.offset, this.totalCount,
      this.stableVersions, this.devVersions);
}
