// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../shared/handlers.dart';
import '../shared/notification.dart';
import '../shared/urls.dart';
import '../shared/utils.dart' show contentType, redirectDartdocPages;

import 'backend.dart';
import 'models.dart';

final _allTracker = new ArchiveTracker();
final _visitorTracker = new ArchiveTracker();
final _obsoleteTracker = new ArchiveTracker();

void _track(DartdocEntry entry, String path) {
  _allTracker.track(entry);
  if (path != 'status.json' && path != 'log.txt' && path != 'package.tar.gz') {
    _visitorTracker.track(entry);
    if (entry.isObsolete ?? false) {
      _obsoleteTracker.track(entry);
    }
  }
}

/// Handlers for the dartdoc service.
Future<shelf.Response> dartdocServiceHandler(shelf.Request request) async {
  final path = request.requestedUri.path;
  final shelf.Handler handler = {
    '/': _indexHandler,
    apiNotificationEndpoint: notificationHandler,
    '/debug': _debugHandler,
  }[path];

  if (handler != null) {
    return await handler(request);
  } else if (path.startsWith('/documentation')) {
    return _documentationHandler(request);
  } else if (path == '/robots.txt' && !isProductionHost(request)) {
    return rejectRobotsHandler(request);
  } else if (path == '/robots.txt') {
    return _robotsTxtHandler(request);
  } else {
    return notFoundHandler(request);
  }
}

/// Handler /debug requests
shelf.Response _debugHandler(shelf.Request request) => debugResponse({
      'archiveTracker': {
        'all': _allTracker.samples,
        'visitor': _visitorTracker.samples,
        'obsolete': _obsoleteTracker.samples,
      },
    });

/// Handles / requests
Future<shelf.Response> _indexHandler(shelf.Request request) async {
  return htmlResponse(_indexHtmlContent);
}

/// Handles /robots.txt requests
Future<shelf.Response> _robotsTxtHandler(shelf.Request request) async {
  return htmlResponse(_robotsTxtContent);
}

/// Handles requests for:
///   - /documentation/<package>/<version>
Future<shelf.Response> _documentationHandler(shelf.Request request) async {
  final docFilePath = parseRequestUri(request.requestedUri);
  if (docFilePath == null) {
    return _indexHandler(request);
  }
  if (redirectDartdocPages.containsKey(docFilePath.package)) {
    return redirectResponse(redirectDartdocPages[docFilePath.package]);
  }
  if (docFilePath.package == null || docFilePath.version == null) {
    return redirectResponse(pkgDocUrl(docFilePath.package, isLatest: true));
  }
  if (docFilePath.path == null) {
    return redirectResponse('${request.requestedUri}/');
  }
  final String requestMethod = request.method?.toUpperCase();
  final entry = await dartdocBackend.getServingEntry(
      docFilePath.package, docFilePath.version);
  if (entry == null) {
    return redirectResponse(pkgVersionsUrl(docFilePath.package));
  }
  if (entry.isLatest == true && docFilePath.version != 'latest') {
    return redirectResponse(pkgDocUrl(docFilePath.package,
        isLatest: true, relativePath: docFilePath.path));
  }
  if (requestMethod == 'HEAD') {
    if (!entry.hasContent && docFilePath.path.endsWith('.html')) {
      return notFoundHandler(request);
    }
    _track(entry, docFilePath.path);
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path);
    if (info == null) {
      return notFoundHandler(request);
    }
    // TODO: add content-length header too
    return htmlResponse('');
  }
  if (requestMethod == 'GET') {
    if (!entry.hasContent && docFilePath.path.endsWith('.html')) {
      return redirectResponse(pkgVersionsUrl(docFilePath.package));
    }
    _track(entry, docFilePath.path);
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
  if (version.isEmpty) {
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

const _robotsTxtContent = '''
User-agent: *
Disallow:
''';

const _indexHtmlContent = '''
<!DOCTYPE html>
<html>
  <head>
    <title>Dart package API docs | Dartdocs</title>
    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,300,700' rel='stylesheet' type='text/css'>
  </head>

  <body class="default hide_toc">
    <header id="page-header">
      <nav id="mainnav">
        <a href="$siteRoot" class="brand" title="Dart">
          <img src="https://dartlang.org/assets/logo-61576b6c2423c80422c986036ead4a7fc64c70edd7639c6171eba19e992c87d9.svg" alt="Dart" height="50px">
        </a>
      </nav>
    </header>

    <main id="page-content">
      <h2>Dart package API docs</h2>
      <p>
        API documentation for a package published on the
        <a href="$siteRoot">Pub package manager</a>, is
        available via the <b>Documentation</b> link located on any individual
        package page on Pub.</p>
    </main>
  </body>
</html>
''';
