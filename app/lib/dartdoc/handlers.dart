// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
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
  }[path];

  if (handler != null) {
    return handler(request);
  } else if (path.startsWith('/documentation')) {
    return documentationHandler(request);
  } else if (path.startsWith('/packages/')) {
    return packageHandler(request);
  } else if (path == '/robots.txt' && !isProductionHost(request)) {
    return rejectRobotsHandler(request);
  } else if (path == '/robots.txt') {
    return robotsTxtHandler(request);
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

/// Handles /robots.txt requests
Future<shelf.Response> robotsTxtHandler(shelf.Request request) async {
  return htmlResponse(robotsTxtContent);
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
    return indexHandler(request);
  }
  if (redirectDartdocPages.containsKey(docFilePath.package)) {
    return redirectResponse(redirectDartdocPages[docFilePath.package]);
  }
  if (docFilePath.version == null) {
    final version = await dartdocBackend.getLatestVersion(docFilePath.package);
    if (version == null) {
      return notFoundHandler(request);
    } else {
      return redirectResponse(
          '/documentation/${docFilePath.package}/$version/');
    }
  }
  if (docFilePath.path == null) {
    return redirectResponse('${request.requestedUri}/');
  }
  final String requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'GET') {
    final entry = await dartdocBackend.getLatestEntry(
        docFilePath.package, docFilePath.version, true);
    if (entry == null) {
      return notFoundHandler(request);
    }
    if (!entry.hasContent && docFilePath.path.endsWith('.html')) {
      return redirectResponse(
          '/documentation/${docFilePath.package}/${docFilePath.version}/log.txt');
    }
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path);
    if (info == null) {
      return notFoundHandler(request);
    }
    if (isNotModified(request, info.lastModified, info.etag)) {
      return new shelf.Response.notModified();
    }
    final stream = dartdocBackend.readContent(entry, docFilePath.path);
    final headers = {
      HttpHeaders.CONTENT_TYPE: contentType(docFilePath.path),
      HttpHeaders.CACHE_CONTROL: 'max-age: ${staticShortCache.inSeconds}',
    };
    if (info.lastModified != null) {
      headers[HttpHeaders.LAST_MODIFIED] = formatHttpDate(info.lastModified);
    }
    if (info.etag != null) {
      headers[HttpHeaders.ETAG] = info.etag;
    }
    return new shelf.Response(HttpStatus.OK, body: stream, headers: headers);
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
  final int segmentCount = uri.pathSegments.length;
  if (segmentCount < 2) return null;
  if (uri.pathSegments[0] != 'documentation') return null;

  final String package = uri.pathSegments[1];
  if (package.isEmpty) return null;
  if (segmentCount == 2) {
    return new DocFilePath(package, null, null);
  }

  final String version = uri.pathSegments[2];
  if (version.isEmpty || version == 'latest') {
    return new DocFilePath(package, null, null);
  }
  if (segmentCount == 3) {
    return new DocFilePath(package, version, null);
  }

  final relativeSegments =
      uri.pathSegments.skip(3).where((s) => s.isNotEmpty).toList();
  String path = relativeSegments.join('/');
  if (path.isEmpty) {
    path = 'index.html';
  } else if (path.isNotEmpty && !relativeSegments.last.contains('.')) {
    path = '$path/index.html';
  }
  return new DocFilePath(package, version, path);
}

const robotsTxtContent = '''
User-agent: *
Disallow:
''';

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
