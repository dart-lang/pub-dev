// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/analyzer_service.dart';
import '../shared/handlers.dart';
import '../shared/notification.dart';

import 'backend.dart';

/// Handlers for the analyzer service.
Future<shelf.Response> analyzerServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = {
    apiNotificationEndpoint: notificationHandler,
    '/debug': _debugHandler,
    '/robots.txt': rejectRobotsHandler,
  }[path];

  if (handler != null) {
    return handler(request);
  } else if (path.startsWith('/packages/')) {
    return packageHandler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
shelf.Response _debugHandler(shelf.Request request) => debugResponse();

/// Handles requests for:
///   - /packages/<package>
///   - /packages/<package>/<version>
///   - /packages/<package>/<version>/<analysis>
Future<shelf.Response> packageHandler(shelf.Request request) async {
  final String path = request.requestedUri.path.substring('/packages/'.length);
  final List<String> pathParts = path.split('/');
  if (path.length == 0 || pathParts.length > 3) {
    return notFoundHandler(request);
  }
  final String package = pathParts[0];
  final String version = pathParts.length == 1 ? null : pathParts[1];
  final int analysisId = pathParts.length <= 2
      ? null
      : int.parse(pathParts[2], onError: (_) => -1);
  if (analysisId == -1) {
    return notFoundHandler(request);
  }
  final String panaVersion = request.url.queryParameters['panaVersion'];

  final String requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    final AnalysisData data = await analysisBackend.getAnalysis(package,
        version: version, analysis: analysisId, panaVersion: panaVersion);
    if (data == null) {
      return notFoundHandler(request);
    }
    return jsonResponse(data.toJson());
  }

  return notFoundHandler(request);
}
