// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/search_service.dart';

import 'index_ducene.dart';

/// Handlers for the search service.
Future<shelf.Response> searchServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = {
    '/debug': debugHandler,
    '/search': searchHandler,
    // TODO: add handler for update notification
  }[path];

  if (handler != null) {
    return handler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
Future<shelf.Response> debugHandler(shelf.Request request) async {
  return jsonResponse({
    'ready': packageIndex.isReady,
    'indexSize': await packageIndex.indexSize(),
    'currentRss': ProcessInfo.currentRss,
    'maxRss': ProcessInfo.maxRss,
  }, indent: true);
}

/// Handles /search requests.
Future<shelf.Response> searchHandler(shelf.Request request) async {
  if (!packageIndex.isReady) {
    return htmlResponse(searchIndexNotReadyText,
        status: searchIndexNotReadyCode);
  }
  final bool indent = request.url.queryParameters['indent'] == 'true';
  final PackageSearchResult result = await packageIndex.search(
      new PackageQuery.fromServiceQueryParameters(request.url.queryParameters));
  return jsonResponse(result.toJson(), indent: indent);
}
