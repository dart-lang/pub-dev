// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;

import '../scorecard/backend.dart';
import '../shared/configuration.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';
import '../tool/utils/http.dart';

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

  /// Before this timestamp we may use the fallback search service URL, which
  /// is the unversioned service URL, potentially getting responses from an
  /// older instance.
  final _fallbackSearchThreshold = clock.now().add(Duration(minutes: 10));

  SearchClient([http.Client? client])
      : _httpClient = client ?? httpRetryClient(retries: 3);

  /// Calls the search service (or uses cache) to serve the [query].
  Future<PackageSearchResult> search(
    ServiceSearchQuery query, {
    bool skipCache = false,
  }) async {
    // check validity first
    final validity = query.evaluateValidity();
    if (validity.isRejected) {
      return PackageSearchResult.empty(
        message: 'Search query rejected. ${validity.rejectReason}',
      );
    }

    final serviceUrlParams = Uri(queryParameters: query.toUriQueryParameters());

    Future<http.Response> doCallHttpServiceEndpoint({String? prefix}) async {
      final httpHostPort = prefix ?? activeConfiguration.searchServicePrefix;
      final serviceUrl = '$httpHostPort/search$serviceUrlParams';
      return await _httpClient
          .get(Uri.parse(serviceUrl), headers: cloudTraceHeaders())
          .timeout(Duration(seconds: 5));
    }

    Future<PackageSearchResult> searchFn() async {
      // calling versioned endpoint
      final response = await doCallHttpServiceEndpoint();
      if (response.statusCode == 200) {
        return PackageSearchResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
      // calling fallback request to unversioned endpoint
      final serviceIsInStartup = clock.now().isBefore(_fallbackSearchThreshold);
      if (serviceIsInStartup &&
          activeConfiguration.fallbackSearchServicePrefix != null) {
        final fallbackRs = await doCallHttpServiceEndpoint(
            prefix: activeConfiguration.fallbackSearchServicePrefix);
        if (fallbackRs.statusCode == 200) {
          return PackageSearchResult.fromJson(
            json.decode(fallbackRs.body) as Map<String, dynamic>,
          );
        }
      }
      // Search request before the service initialization completed.
      if (response.statusCode == searchIndexNotReadyCode) {
        return PackageSearchResult.empty(
            message: 'Search is temporarily unavailable.');
      }
      // There has been a generic issue with the service.
      return PackageSearchResult.empty(
          message: 'Service returned status code ${response.statusCode}.');
    }

    if (skipCache) {
      return await searchFn();
    } else {
      final cacheEntry = cache.packageSearchResult(serviceUrlParams.toString());
      return (await cacheEntry.get(searchFn))!;
    }
  }

  /// Search service maintains a separate index in each of the running instances.
  /// This method will update the ScoreCard entry of the package, and it will
  /// be picked up by each search index individually, within a few minutes.
  Future<void> triggerReindex(String package, String version) async {
    await scoreCardBackend.markScoreCardUpdated(package, version);
  }

  Future<void> close() async {
    _httpClient.close();
  }
}
