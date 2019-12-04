// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../package/search_adapter.dart';
import '../../search/search_service.dart';
import '../../shared/handlers.dart';
import '../../shared/platform.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';
import '../templates/landing.dart';
import '../templates/misc.dart';

/// Handles requests for /
Future<shelf.Response> indexLandingHandler(shelf.Request request) =>
    _indexHandler(request, null);

/// Handles requests for /dart
Future<shelf.Response> dartLandingHandler(shelf.Request request) async =>
    redirectResponse(urls.searchUrl(sdk: SdkTagValue.dart));

/// Handles requests for /flutter
Future<shelf.Response> flutterLandingHandler(shelf.Request request) async {
  if (requestContext.isExperimental) {
    return redirectResponse(urls.searchUrl(sdk: SdkTagValue.flutter));
  }
  return await _indexHandler(request, KnownPlatforms.flutter);
}

/// Handles requests for /web
Future<shelf.Response> webLandingHandler(shelf.Request request) async {
  if (requestContext.isExperimental) {
    return redirectResponse(
      urls.searchUrl(
        sdk: SdkTagValue.dart,
        runtimes: [DartSdkRuntimeValue.web],
      ),
    );
  }
  return _indexHandler(request, KnownPlatforms.web);
}

/// Handles requests for:
/// - /
/// - /flutter
/// - /web
Future<shelf.Response> _indexHandler(
    shelf.Request request, String platform) async {
  final String queryText = request.requestedUri.queryParameters['q']?.trim();
  if (queryText != null) {
    final String path = request.requestedUri.path;
    final String separator = path.endsWith('/') ? '' : '/';
    final String newPath = '$path${separator}packages';
    return redirectResponse(
        request.requestedUri.replace(path: newPath).toString());
  }

  Future<String> _render() async {
    final packages = await topFeaturedPackages(platform: platform);
    final minilist = renderMiniList(packages);
    return renderIndexPage(minilist, platform);
  }

  if (requestContext.isExperimental) {
    final taggedResults = await searchAdapter.search(
      SearchQuery.parse(
        tagsPredicate: TagsPredicate.advertisement(
          requiredTags: ['is:flutter-favorite'],
        ),
        limit: 6,
        randomize: true,
      ),
    );
    final topResults = await searchAdapter.search(
      SearchQuery.parse(
        tagsPredicate: TagsPredicate.advertisement(),
        limit: 6,
        randomize: true,
      ),
    );
    return htmlResponse(renderLandingPage(
      taggedPackages: taggedResults.packages.take(6).toList(),
      topPackages: topResults.packages.take(6).toList(),
    ));
  }

  if (requestContext.uiCacheEnabled) {
    return htmlResponse(await cache.uiIndexPage(platform).get(_render));
  }
  return htmlResponse(await _render());
}
