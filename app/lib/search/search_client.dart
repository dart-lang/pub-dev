// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;

import '../scorecard/backend.dart';
import '../shared/configuration.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';

import 'search_service.dart';

/// Sets the search client.
void registerSearchClient(SearchClient client) =>
    ss.register(#_searchClient, client);

/// The active search client.
SearchClient get searchClient => ss.lookup(#_searchClient) as SearchClient;

/// Client methods that access the search service and the internals of the
/// indexed data.
class SearchClient {
  /// The HTTP client used for making calls to our search service.
  final http.Client _httpClient;

  SearchClient([http.Client client]) : _httpClient = client ?? http.Client();

  Future<PackageSearchResult> search(SearchQuery query, {Duration ttl}) async {
    // check validity first
    final validity = query.evaluateValidity();
    if (validity.isRejected) {
      return PackageSearchResult(
        totalCount: 0,
        packages: [],
        message: 'Search query rejected. ${validity.rejectReason}',
      );
    }

    final String httpHostPort = activeConfiguration.searchServicePrefix;
    final String serviceUrlParams =
        Uri(queryParameters: query.toServiceQueryParameters()).toString();
    final String serviceUrl = '$httpHostPort/search$serviceUrlParams';

    Future<PackageSearchResult> searchFn() async {
      final response = await getUrlWithRetry(
        _httpClient,
        serviceUrl,
        timeout: Duration(seconds: 5),
        // limit to a single attempt, no need to retry after timeout
        retryCount: 0,
      );
      if (response.statusCode == searchIndexNotReadyCode) {
        // Search request before the service initialization completed.
        // TODO: retry request, maybe another search instance will be able to serve it
        return null;
      }
      if (response.statusCode != 200) {
        // There has been an issue with the service
        // TODO: retry request, maybe another search instance will be able to serve it
        throw Exception('Service returned status code ${response.statusCode}');
      }
      final result = PackageSearchResult.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
      if (!result.isLegit) {
        // Search request before the service initialization completed.
        // TODO: retry request, maybe another search instance will be able to serve it
        return null;
      }
      return result;
    }

    return await cache
            .packageSearchResult(serviceUrl, ttl: ttl)
            .get(searchFn) ??
        PackageSearchResult.empty(
            message: 'Search is temporarily unavailable.');
  }

  /// Search service maintains a separate index in each of the running instances.
  /// This method will update the [ScoreCard] entry of the package, and it will
  /// be picked up by each search index individually, within a few minutes.
  Future<void> triggerReindex(String package, String version) async {
    await scoreCardBackend.updateScoreCard(package, version);
  }

  Future<void> close() async {
    _httpClient.close();
  }
}
