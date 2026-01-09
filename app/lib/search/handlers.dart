// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/search/search_request_data.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

import '../shared/env_config.dart';
import '../shared/handlers.dart';

import 'backend.dart';
import 'search_service.dart';

final Logger _logger = Logger('pub.search.handlers');
final Duration _slowSearchThreshold = const Duration(milliseconds: 200);

/// Handlers for the search service.
Future<shelf.Response> searchServiceHandler(shelf.Request request) async {
  final router = Router(notFoundHandler: notFoundHandler)
    ..get('/debug', _debugHandler)
    ..get('/liveness_check', (_) => healthCheckOkResponse())
    ..get('/readiness_check', _readinessCheckHandler)
    ..get('/search', _searchHandler)
    ..post('/search', _searchHandler)
    ..get('/robots.txt', rejectRobotsHandler);
  return await router.call(request);
}

/// Handles GET /readiness_check requests.
Future<shelf.Response> _readinessCheckHandler(shelf.Request request) async {
  if (await searchIndex.isReady()) {
    return healthCheckOkResponse();
  } else {
    return healthCheckNotReadyResponse();
  }
}

/// Handler GET /debug requests
Future<shelf.Response> _debugHandler(shelf.Request request) async {
  final info = await searchIndex.indexInfo();
  return debugResponse(info.toJson());
}

/// Handles GET /search requests.
/// Handles POST /search requests.
Future<shelf.Response> _searchHandler(shelf.Request request) async {
  final info = await searchIndex.indexInfo();
  if (!info.isReady) {
    return jsonResponse({
      'error': searchIndexNotReadyText,
    }, status: searchIndexNotReadyCode);
  }
  final Stopwatch sw = Stopwatch()..start();
  final query = request.method == 'POST'
      ? ServiceSearchQuery(
          SearchRequestData.fromJson(
            json.decode(await request.readAsString()) as Map<String, dynamic>,
          ),
        )
      : ServiceSearchQuery(
          SearchRequestData.fromServiceUrl(request.requestedUri),
        );
  final result = await searchIndex.search(query);
  final Duration elapsed = sw.elapsed;
  if (elapsed > _slowSearchThreshold) {
    _logger.info(
      '[pub-slow-search-query] Slow search: handler exceeded ${_slowSearchThreshold.inMilliseconds} ms: '
      '${query.toDebugString()}',
    );
  }

  if (request.requestedUri.queryParameters['debug-drift'] == '1') {
    return jsonResponse({
      'gae': envConfig.debugMap(includeInstanceHash: true),
      'index': info.toJson(),
      ...result.toJson(),
    });
  }

  return jsonResponse(result.toJson());
}
