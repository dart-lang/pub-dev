// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/task_client.dart';

/// Handlers for the dartdoc service.
Future<shelf.Response> dartdocServiceHandler(shelf.Request request) async {
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
Future<shelf.Response> packageHandler(shelf.Request request) async {
  final path = request.requestedUri.path.substring('/packages/'.length);
  final pathParts = path.split('/');
  if (path.length == 0 || pathParts.length > 2) {
    return notFoundHandler(request);
  }
  final package = pathParts[0];
  final version = pathParts.length == 1 ? null : pathParts[1];

  final requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    return notFoundHandler(request);
  } else if (requestMethod == 'POST') {
    if (await validateNotificationSecret(request)) {
      triggerTask(package, version);
      return jsonResponse({'success': true});
    } else {
      return jsonResponse({'success': false});
    }
  }

  return notFoundHandler(request);
}
