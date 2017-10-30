// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/analyzer_service.dart';
import '../shared/handlers.dart';
import '../shared/task_client.dart';

import 'backend.dart';
import 'models.dart';

/// Handlers for the analyzer service.
Future<shelf.Response> analyzerServiceHandler(shelf.Request request) async {
  final handler = {
    '/debug': debugHandler,
  }[request.requestedUri.path];

  if (handler != null) {
    return handler(request);
  } else if (request.url.pathSegments.first == 'packages') {
    return packageHandler(request.change(path: 'packages'));
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
Future<shelf.Response> debugHandler(shelf.Request request) async {
  return jsonResponse({
    'currentRss': ProcessInfo.currentRss,
    'maxRss': ProcessInfo.maxRss,
    'scheduler': latestSchedulerStats,
  }, indent: true);
}

/// Handles requests for:
///   - <package>
///   - <package>/<version>
///   - <package>/<version>/<analysis>
Future<shelf.Response> packageHandler(shelf.Request request) async {
  final bool onlyMeta = request.url.queryParameters['only-meta'] == 'true';

  final List<String> pathParts = request.url.pathSegments;
  if (pathParts.isEmpty || pathParts.length > 3) {
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
    final Analysis analysis = await analysisBackend.getAnalysis(package,
        version: version, analysis: analysisId, panaVersion: panaVersion);
    if (analysis == null) {
      return notFoundHandler(request);
    }
    Map analysisContent;
    if (!onlyMeta) {
      analysisContent = analysis.analysisJson;
    }
    return jsonResponse(new AnalysisData(
            packageName: analysis.packageName,
            packageVersion: analysis.packageVersion,
            analysis: analysis.analysis,
            timestamp: analysis.timestamp,
            panaVersion: analysis.panaVersion,
            flutterVersion: analysis.flutterVersion,
            analysisStatus: analysis.analysisStatus,
            analysisContent: analysisContent)
        .toJson());
  } else if (requestMethod == 'POST') {
    if (pathParts.length != 2) {
      // trigger should have version and shouldn't contain analysis id
      return notFoundHandler(request);
    }
    if (await validateNotificationSecret(request)) {
      triggerTask(package, version);
      return jsonResponse({'success': true});
    } else {
      return jsonResponse({'success': false});
    }
  }

  return notFoundHandler(request);
}
