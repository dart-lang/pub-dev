// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/tags.dart';
import 'package:pub_dev/search/top_packages.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../service/youtube/backend.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../templates/views/landing/page.dart';

/// Handles requests for /dart
Future<shelf.Response> dartLandingHandler(shelf.Request request) async =>
    redirectResponse(urls.searchUrl(q: SdkTag.sdkDart));

/// Handles requests for /flutter
Future<shelf.Response> flutterLandingHandler(shelf.Request request) async {
  return redirectResponse(urls.searchUrl(q: SdkTag.sdkFlutter));
}

/// Handles requests for /web
Future<shelf.Response> webLandingHandler(shelf.Request request) async {
  return redirectResponse(urls.searchUrl(q: PlatformTag.platformWeb));
}

/// Handles requests for /
Future<shelf.Response> indexLandingHandler(shelf.Request request) async {
  final queryText = request.requestedUri.queryParameters['q']?.trim();
  if (queryText != null) {
    return redirectResponse(urls.searchUrl(q: queryText));
  }

  final content = await cache.uiLandingPageContent().get(() async {
    return landingPageContentNode(
      ffPackages: topPackages.flutterFavorites(),
      mostPopularPackages: topPackages.mostPopular(),
      topFlutterPackages: topPackages.topFlutter(),
      topDartPackages: topPackages.topDart(),
      trendingPackages: topPackages.trending(),
      topPoWVideos: youtubeBackend.getTopPackageOfWeekVideos(count: 4),
    );
  });

  return htmlResponse(renderLandingPage(content!));
}
