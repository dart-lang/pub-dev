// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/notification.dart';
import '../shared/scheduler_stats.dart';
import '../shared/task_client.dart';

/// Handlers for the dartdoc service.
Future<shelf.Response> dartdocServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = {
    '/debug': debugHandler,
    // TODO: have a proper robots.txt after we are serving content
    '/robots.txt': rejectRobotsHandler,
  }[path];

  if (handler != null) {
    return handler(request);
  } else if (path.startsWith('/documentation/')) {
    return documentationHandler(request);
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
  final String path = request.requestedUri.path.substring('/packages/'.length);
  final List<String> pathParts = path.split('/');
  if (path.length == 0 || pathParts.length > 2) {
    return notFoundHandler(request);
  }
  final String package = pathParts[0];
  final String version = pathParts.length == 1 ? null : pathParts[1];

  final String requestMethod = request.method?.toUpperCase();
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

/// Handles requests for:
///   - /documentation/<package>
///   - /documentation/<package>/<version>
Future<shelf.Response> documentationHandler(shelf.Request request) async {
  final docFilePath = parseRequestUri(request.requestedUri);
  if (docFilePath == null) {
    return notFoundHandler(request);
  }
  final String requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    // placeholder response until proper implementation is done
    return jsonResponse({
      'package': docFilePath.package,
      'version': docFilePath.version,
      'path': docFilePath.path,
    });
  }
  return notFoundHandler(request);
}

class DocFilePath {
  final String package;
  final String version;
  final String path;

  DocFilePath(this.package, this.version, this.path);
}

DocFilePath parseRequestUri(Uri uri) {
  final pathSegments = uri.pathSegments;
  if (pathSegments.length < 3) {
    return null;
  }
  if (pathSegments[0] != 'documentation') {
    return null;
  }
  final String package = pathSegments[1];
  final String version = pathSegments[2];
  if (package.isEmpty || version.isEmpty) {
    return null;
  }
  String path = '/${pathSegments.skip(3).join('/')}';
  if (path.endsWith('/')) {
    path = '${path}index.html';
  }
  return new DocFilePath(package, version, path);
}
