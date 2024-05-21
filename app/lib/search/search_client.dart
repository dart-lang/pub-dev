// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;

import '../../../service/rate_limit/rate_limit.dart';
import '../shared/configuration.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/utils.dart';

import 'search_service.dart';

/// The number of requests allowed over [_searchRateLimitWindow]
const _searchRateLimit = 120;
const _searchRateLimitWindow = Duration(minutes: 2);
const _searchRateLimitWindowAsText = 'last 2 minutes';

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
  final _fallbackSearchThreshold = clock.now().add(Duration(minutes: 30));

  SearchClient([http.Client? client])
      : _httpClient = client ?? httpRetryClient(retries: 3);

  /// Calls the search service (or uses cache) to serve the [query].
  Future<PackageSearchResult> search(
    ServiceSearchQuery query, {
    required String? sourceIp,
    bool skipCache = false,
  }) async {
    // check validity first
    final validity = query.evaluateValidity();
    if (validity.isRejected) {
      return PackageSearchResult.empty(
        message: 'Search query rejected. ${validity.rejectReason}',
        statusCode: 400,
      );
    }

    final serviceUrlParams = Uri(queryParameters: query.toUriQueryParameters());

    // returns null on timeout (after 5 seconds)
    Future<http.Response?> doCallHttpServiceEndpoint({String? prefix}) async {
      final httpHostPort = prefix ?? activeConfiguration.searchServicePrefix;
      final serviceUrl = '$httpHostPort/search$serviceUrlParams';
      try {
        return await _httpClient
            .get(Uri.parse(serviceUrl), headers: cloudTraceHeaders())
            .timeout(Duration(seconds: 5));
      } on TimeoutException {
        return null;
      }
    }

    Future<PackageSearchResult> searchFn() async {
      // calling versioned endpoint
      var response = await doCallHttpServiceEndpoint();
      // if needed and possible, calling fallback request to unversioned endpoint
      if (response == null || response.statusCode != 200) {
        final serviceIsInStartup =
            clock.now().isBefore(_fallbackSearchThreshold);
        if (serviceIsInStartup &&
            activeConfiguration.fallbackSearchServicePrefix != null) {
          response = await doCallHttpServiceEndpoint(
              prefix: activeConfiguration.fallbackSearchServicePrefix);
        }
      }
      if (response == null) {
        return PackageSearchResult.empty(
            message: 'Search is temporarily unavailable.');
      }
      if (response.statusCode == 200) {
        return PackageSearchResult.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
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

    if (sourceIp != null) {
      await verifyRequestCounts(
        sourceIp: sourceIp,
        operation: 'search',
        limit: _searchRateLimit,
        window: _searchRateLimitWindow,
        windowAsText: _searchRateLimitWindowAsText,
      );
    }

    if (skipCache) {
      return await searchFn();
    } else {
      final cacheEntry = cache.packageSearchResult(serviceUrlParams.toString());
      final cached = await cacheEntry.get();
      if (cached != null) {
        return cached;
      }
      final r = await searchFn();
      await cacheEntry.set(
          r,
          r.message == null
              ? const Duration(minutes: 3)
              : const Duration(minutes: 1));
      return r;
    }
  }

  Future<void> close() async {
    _httpClient.close();
  }
}
