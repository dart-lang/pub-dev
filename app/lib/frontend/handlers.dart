// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';

import 'handlers/admin.dart';
import 'handlers/atom_feed.dart';
import 'handlers/custom_api.dart';
import 'handlers/documentation.dart';
import 'handlers/landing.dart';
import 'handlers/listing.dart';
import 'handlers/misc.dart';
import 'handlers/package.dart';
import 'handlers/redirects.dart';
import 'static_files.dart';

final _pubHeaderLogger = Logger('pub.header_logger');

void _logPubHeaders(shelf.Request request) {
  request.headers.forEach((String key, String value) {
    final lowerCaseKey = key.toLowerCase();
    if (lowerCaseKey.startsWith('x-pub')) {
      _pubHeaderLogger.info('$key: $value');
    }
  });
}

/// Handler for the whole URL space of pub.dartlang.org
///
/// The passed in [shelfPubApi] handler will be used for handling requests to
///   - /api/*
Future<shelf.Response> appHandler(
  shelf.Request request,
  shelf.Handler shelfPubApi,
) async {
  final path = request.requestedUri.path;

  _logPubHeaders(request);

  final redirected = tryHandleRedirects(request);
  if (redirected != null) return redirected;

  final handler = _handlers[path];

  if (handler != null) {
    return await handler(request);
  } else if (path.startsWith('/admin/confirm/')) {
    return await adminConfirmHandler(request);
  } else if (path == '/api/packages' &&
      request.requestedUri.queryParameters['compact'] == '1') {
    return apiPackagesCompactListHandler(request);
  } else if (path == '/api/packages') {
    // NOTE: This is special-cased, since it is not an API used by pub but
    // rather by the editor.
    return apiPackagesHandler(request);
  } else if (path.startsWith('/api/documentation')) {
    return apiDocumentationHandler(request);
  } else if (isHandlerForApiPackageMetrics(request.requestedUri)) {
    return apiPackageMetricsHandler(request);
  } else if (path.startsWith('/api') ||
      path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return await shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return await packageHandler(request);
  } else if (path.startsWith('/documentation')) {
    return documentationHandler(
        request.context['_originalRequest'] as shelf.Request ?? request);
  } else if (path == '/robots.txt' && !isProductionHost(request)) {
    return rejectRobotsHandler(request);
  } else if (staticFileCache.hasFile(request.requestedUri.path)) {
    return staticsHandler(request);
  } else {
    return formattedNotFoundHandler(request);
  }
}

const _handlers = <String, shelf.Handler>{
  '/': indexLandingHandler,
  '/packages': packagesHandlerHtml,
  '/flutter': flutterLandingHandler,
  '/flutter/packages': flutterPackagesHandlerHtml,
  '/web': webLandingHandler,
  '/web/packages': webPackagesHandlerHtml,
  '/api/search': apiSearchHandler,
  '/api/history': apiHistoryHandler, // experimental, do not rely on it
  '/debug': _debugHandler,
  '/feed.atom': atomFeedHandler,
  '/sitemap.txt': siteMapTxtHandler,
  '/authorized': authorizedHandler,
  '/packages.json': packagesHandler,
  '/help': helpPageHandler,
  '/oauth/callback': oauthCallbackHandler,
  '/experimental': experimentalHandler,
};

/// Handles requests for /debug
shelf.Response _debugHandler(shelf.Request request) {
  return debugResponse({
    'package': packageDebugStats(),
    'search': searchDebugStats(),
  });
}
