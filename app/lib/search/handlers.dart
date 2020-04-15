// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';

import 'index_simple.dart';
import 'result_combiner.dart';
import 'search_service.dart';

final Logger _logger = Logger('pub.search.handlers');
final Duration _slowSearchThreshold = const Duration(milliseconds: 200);

/// Handlers for the search service.
Future<shelf.Response> searchServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = <String, shelf.Handler>{
    '/debug': _debugHandler,
    '/liveness_check': _livenessCheckHandler,
    '/readiness_check': _readinessCheckHandler,
    '/search': _searchHandler,
    '/robots.txt': rejectRobotsHandler,
  }[path];

  if (handler != null) {
    return await handler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handles /liveness_check requests.
Future<shelf.Response> _livenessCheckHandler(shelf.Request request) async {
  return htmlResponse('OK');
}

/// Handles /readiness_check requests.
Future<shelf.Response> _readinessCheckHandler(shelf.Request request) async {
  final info = await packageIndex.indexInfo();
  if (info.isReady) {
    return htmlResponse('OK');
  } else {
    return htmlResponse('Service Unavailable', status: 503);
  }
}

/// Handler /debug requests
Future<shelf.Response> _debugHandler(shelf.Request request) async {
  final info = await packageIndex.indexInfo();
  return debugResponse(info.toJson());
}

/// Handles /search requests.
Future<shelf.Response> _searchHandler(shelf.Request request) async {
  final info = await packageIndex.indexInfo();
  if (!info.isReady) {
    return htmlResponse(searchIndexNotReadyText,
        status: searchIndexNotReadyCode);
  }
  final Stopwatch sw = Stopwatch()..start();
  final SearchQuery query = SearchQuery.fromServiceUrl(request.requestedUri);
  final combiner = SearchResultCombiner(
      primaryIndex: packageIndex, dartSdkIndex: dartSdkIndex);
  final result = await combiner.search(query);
  final Duration elapsed = sw.elapsed;
  if (elapsed > _slowSearchThreshold) {
    _logger.info(
        '[pub-slow-search-query] Slow search: handler exceeded ${_slowSearchThreshold.inMilliseconds} ms: '
        '${query.toServiceQueryParameters()}');
  }

  return jsonResponse(result.toJson());
}
