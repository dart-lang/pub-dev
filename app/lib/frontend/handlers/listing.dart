// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../package/name_tracker.dart';
import '../../package/search_adapter.dart';
import '../../search/search_form.dart';
import '../../search/search_service.dart';
import '../../shared/handlers.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart' show DurationTracker;

import '../templates/listing.dart';

final _searchOverallLatencyTracker = DurationTracker();

Map searchDebugStats() {
  return {
    'overall_latency': _searchOverallLatencyTracker.toShortStat(),
  };
}

/// Handles /packages - package listing
Future<shelf.Response> packagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, context: SearchContext.regular());

/// Handles /dart/packages
Future<shelf.Response> dartPackagesHandlerHtml(shelf.Request request) async {
  return await _packagesHandlerHtmlCore(request, context: SearchContext.dart());
}

/// Handles /flutter/packages
Future<shelf.Response> flutterPackagesHandlerHtml(shelf.Request request) {
  return _packagesHandlerHtmlCore(
    request,
    context: SearchContext.flutter(),
  );
}

/// Handles /flutter/favorites
Future<shelf.Response> flutterFavoritesPackagesHandlerHtml(
  shelf.Request request,
) {
  return _packagesHandlerHtmlCore(
    request,
    context: SearchContext.flutterFavorites(),
    title: 'Flutter Favorite packages',
    searchPlaceholder: 'Search Flutter favorite packages',
  );
}

/// Handles /web/packages
Future<shelf.Response> webPackagesHandlerHtml(shelf.Request request) async {
  return redirectResponse(
    urls.searchUrl(
      context: SearchContext.dart(),
      runtimes: [DartSdkRuntime.web],
      q: request.requestedUri.queryParameters['q'],
    ),
  );
}

/// Handles:
/// - /packages - package listing
/// - /dart/packages
/// - /flutter/packages
Future<shelf.Response> _packagesHandlerHtmlCore(
  shelf.Request request, {
  required SearchContext context,
  String? title,
  String? searchPlaceholder,
}) async {
  final openSections =
      request.requestedUri.queryParameters['open-sections']?.split(' ').toSet();
  final searchForm =
      SearchForm.parse(context, request.requestedUri.queryParameters);
  final sw = Stopwatch()..start();
  final searchResult = await searchAdapter.search(searchForm);
  final int totalCount = searchResult.totalCount;

  final links = PageLinks(searchForm, totalCount);
  final result = htmlResponse(
    renderPkgIndexPage(
      searchResult,
      links,
      sdk: context.sdk,
      searchForm: searchForm,
      title: title,
      searchPlaceholder: searchPlaceholder,
      messageFromBackend: searchResult.message,
      openSections: openSections,
    ),
  );
  _searchOverallLatencyTracker.add(sw.elapsed);
  return result;
}

/// Handles requests for /packages - multiplexes to JSON/HTML handler.
Future<shelf.Response> packagesHandler(shelf.Request request) async {
  final int page =
      extractPageFromUrlParameters(request.requestedUri.queryParameters);
  final path = request.requestedUri.path;
  if (path.endsWith('.json')) {
    return _packagesHandlerJson(request, page, true);
  } else if (request.requestedUri.queryParameters['format'] == 'json') {
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

  final allPackages = nameTracker.visiblePackagesOrderedByLastPublished;
  final pkgPage = allPackages.skip(offset).take(pageSize).toList();

  Uri? nextPageUrl;
  if (allPackages.length > offset + pageSize) {
    nextPageUrl =
        request.requestedUri.resolve('/packages.json?page=${page + 1}');
  }

  final postfix = dotJsonResponse ? '.json' : '';
  String toUrl(String package) {
    return request.requestedUri
        .resolve('/packages/${Uri.encodeComponent(package)}$postfix')
        .toString();
  }

  final json = {
    'packages': pkgPage.map((p) => toUrl(p.package)).toList(),
    'next': nextPageUrl != null ? '$nextPageUrl' : null,

    // NOTE: We're not returning the following entry:
    //   - 'prev'
    //   - 'pages'
  };

  return jsonResponse(json);
}
