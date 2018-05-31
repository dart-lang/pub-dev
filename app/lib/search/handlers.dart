// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/notification.dart';
import '../shared/search_service.dart';

import 'index_simple.dart';

final Logger _logger = new Logger('pub.search.handlers');
final Duration _slowSearchThreshold = const Duration(milliseconds: 200);

/// Handlers for the search service.
Future<shelf.Response> searchServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final shelf.Handler handler = {
    apiNotificationEndpoint: notificationHandler,
    '/debug': _debugHandler,
    '/search': _searchHandler,
    '/robots.txt': rejectRobotsHandler,
  }[path];

  if (handler != null) {
    return await handler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
shelf.Response _debugHandler(shelf.Request request) {
  return debugResponse({
    'ready': packageIndex.isReady,
    'info': packageIndex.debugInfo,
  });
}

/// Handles /search requests.
Future<shelf.Response> _searchHandler(shelf.Request request) async {
  if (!packageIndex.isReady) {
    return htmlResponse(searchIndexNotReadyText,
        status: searchIndexNotReadyCode);
  }
  final bool indent = request.url.queryParameters['indent'] == 'true';
  final Stopwatch sw = new Stopwatch()..start();
  final SearchQuery query = new SearchQuery.fromServiceUrl(request.url);
  final PackageSearchResult result = await packageIndex.search(query);
  final Duration elapsed = sw.elapsed;
  if (elapsed > _slowSearchThreshold) {
    _logger.warning(
        'Search handler exceeded ${_slowSearchThreshold.inMilliseconds}ms: '
        '${query.toServiceQueryParameters()}');
  }
  return jsonResponse(result.toJson(), indent: indent);
}
