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

/// Handlers for the analyzer service.
Future<shelf.Response> analyzerServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = {
    '/debug': debugHandler,
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
Future<shelf.Response> debugHandler(shelf.Request request) async {
  return jsonResponse({
    'currentRss': ProcessInfo.currentRss,
    'maxRss': ProcessInfo.maxRss,
    'scheduler': latestSchedulerStats,
  }, indent: true);
}

/// Handles requests for:
///   - /packages/<package>
///   - /packages/<package>/<version>
///   - /packages/<package>/<version>/<analysis>
Future<shelf.Response> packageHandler(shelf.Request request) async {
  final onlyMeta = request.url.queryParameters['only-meta'] == 'true';
  final path = request.requestedUri.path.substring('/packages/'.length);
  final pathParts = path.split('/');
  if (path.length == 0 || pathParts.length > 3) {
    return notFoundHandler(request);
  }
  final package = pathParts[0];
  final version = pathParts.length == 1 ? null : pathParts[1];
  final analysisId = pathParts.length <= 2
      ? null
      : int.parse(pathParts[2], onError: (_) => -1);
  if (analysisId == -1) {
    return notFoundHandler(request);
  }
  final panaVersion = request.url.queryParameters['panaVersion'];

  final requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    final analysis = await analysisBackend.getAnalysis(package,
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
