// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../shared/handlers.dart';
import '../../shared/packages_overrides.dart';
import '../../shared/platform.dart';
import '../../shared/search_service.dart';
import '../../shared/utils.dart' show DurationTracker;

import '../backend.dart';
import '../models.dart';
import '../search_service.dart';
import '../templates/listing.dart';

final _searchOverallLatencyTracker = DurationTracker();

Map searchDebugStats() {
  return {
    'overall_latency': _searchOverallLatencyTracker.toShortStat(),
  };
}

/// Handles /packages - package listing
Future<shelf.Response> packagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, null);

/// Handles /flutter/packages
Future<shelf.Response> flutterPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.flutter);

/// Handles /web/packages
Future<shelf.Response> webPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.web);

/// Handles:
/// - /packages - package listing
/// - /flutter/packages
/// - /server/packages
/// - /web/packages
Future<shelf.Response> _packagesHandlerHtmlCore(
    shelf.Request request, String platform) async {
  // TODO: use search memcache for all results here or remove search memcache
  final searchQuery = parseFrontendSearchQuery(request.requestedUri, platform);
  final sw = Stopwatch()..start();
  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;

  final links =
      PageLinks(searchQuery.offset, totalCount, searchQuery: searchQuery);
  final result = htmlResponse(renderPkgIndexPage(
    searchResult.packages,
    links,
    platform,
    searchQuery: searchQuery,
    totalCount: totalCount,
  ));
  _searchOverallLatencyTracker.add(sw.elapsed);
  return result;
}

/// Handles requests for /packages - multiplexes to JSON/HTML handler.
Future<shelf.Response> packagesHandler(shelf.Request request) async {
  final int page = extractPageFromUrlParameters(request.url);
  final path = request.requestedUri.path;
  if (path.endsWith('.json')) {
    return _packagesHandlerJson(request, page, true);
  } else if (request.url.queryParameters['format'] == 'json') {
    return _packagesHandlerJson(request, page, false);
  } else {
    return packagesHandlerHtml(request);
  }
}

/// Handles requests for /packages - JSON
Future<shelf.Response> _packagesHandlerJson(
    shelf.Request request, int page, bool dotJsonResponse) async {
  final pageSize = 50;

  final offset = pageSize * (page - 1);
  final limit = pageSize + 1;

  final packages = await backend.latestPackages(offset: offset, limit: limit);
  packages.removeWhere((p) => isSoftRemoved(p.name));
  final bool lastPage = packages.length < limit;

  Uri nextPageUrl;
  if (!lastPage) {
    nextPageUrl =
        request.requestedUri.resolve('/packages.json?page=${page + 1}');
  }

  String toUrl(Package package) {
    final postfix = dotJsonResponse ? '.json' : '';
    return request.requestedUri
        .resolve('/packages/${Uri.encodeComponent(package.name)}$postfix')
        .toString();
  }

  final json = {
    'packages': packages.take(pageSize).map(toUrl).toList(),
    'next': nextPageUrl != null ? '$nextPageUrl' : null,

    // NOTE: We're not returning the following entry:
    //   - 'prev'
    //   - 'pages'
  };

  return jsonResponse(json);
}
