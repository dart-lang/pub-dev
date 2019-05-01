// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../shared/handlers.dart';
import '../../shared/platform.dart';

import '../backend.dart';
import '../request_context.dart';
import '../search_service.dart';
import '../templates/landing.dart';
import '../templates/misc.dart';

/// Handles requests for /
Future<shelf.Response> indexLandingHandler(shelf.Request request) =>
    _indexHandler(request, null);

/// Handles requests for /flutter
Future<shelf.Response> flutterLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.flutter);

/// Handles requests for /web
Future<shelf.Response> webLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.web);

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
  final useCache = requestContext.uiCacheEnabled;
  String pageContent =
      useCache ? await backend.uiPackageCache?.getUIIndexPage(platform) : null;
  if (pageContent == null) {
    final packages = await topFeaturedPackages(platform: platform);
    final minilist = renderMiniList(packages);

    pageContent = renderIndexPage(minilist, platform);
    if (useCache) {
      await backend.uiPackageCache?.setUIIndexPage(platform, pageContent);
    }
  }
  return htmlResponse(pageContent);
}
