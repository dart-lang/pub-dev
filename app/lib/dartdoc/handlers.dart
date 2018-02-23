// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/notification.dart';
import '../shared/task_client.dart';
import '../shared/utils.dart' show contentType, redirectDartdocPages;

import 'backend.dart';

/// Handlers for the dartdoc service.
Future<shelf.Response> dartdocServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final handler = {
    '/': indexHandler,
    '/debug': _debugHandler,
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
shelf.Response _debugHandler(shelf.Request request) => debugResponse();

/// Handles / requests
Future<shelf.Response> indexHandler(shelf.Request request) async {
  return htmlResponse(indexHtmlContent);
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
///   - /documentation/<package>/<version>
Future<shelf.Response> documentationHandler(shelf.Request request) async {
  final docFilePath = parseRequestUri(request.requestedUri);
  if (docFilePath == null) {
    return notFoundHandler(request);
  }
  if (redirectDartdocPages.containsKey(docFilePath.package)) {
    return redirectResponse(redirectDartdocPages[docFilePath.package]);
  }
  final String requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    final entry = await dartdocBackend.getLatestEntry(
        docFilePath.package, docFilePath.version, true);
    if (entry == null) {
      return notFoundHandler(request);
    }
    final stream = dartdocBackend.readContent(entry, docFilePath.path);
    return new shelf.Response(
      HttpStatus.OK,
      body: stream,
      headers: {HttpHeaders.CONTENT_TYPE: contentType(docFilePath.path)},
    );
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
  final pathSegments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  if (pathSegments.length < 3) {
    // TODO: handle URLs without versions, redirect to latest stable version
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
  final relativeSegments = pathSegments.skip(3).toList();
  String path = relativeSegments.join('/');
  if (path.isEmpty) {
    path = 'index.html';
  } else if (path.isNotEmpty && !relativeSegments.last.contains('.')) {
    path = '$path/index.html';
  }
  return new DocFilePath(package, version, path);
}

const indexHtmlContent = '''
<!DOCTYPE html>
<html>
  <head>
    <title>Dart package API docs | Dartdocs</title>
    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,300,700' rel='stylesheet' type='text/css'>
  </head>

  <body class="default hide_toc">
    <header id="page-header">
      <nav id="mainnav">
        <a href="https://pub.dartlang.org/" class="brand" title="Dart">
          <img src="https://dartlang.org/assets/logo-61576b6c2423c80422c986036ead4a7fc64c70edd7639c6171eba19e992c87d9.svg" alt="Dart" height="50px">
        </a>
      </nav>
    </header>

    <main id="page-content">
      <h2>Dart package API docs</h2>
      <p>
        API documentation for a package published on the
        <a href="https://pub.dartlang.org/">Pub package manager</a>, is
        available via the <b>Documentation</b> link located on any individual
        package page on Pub.</p>
    </main>
  </body>
</html>
''';
