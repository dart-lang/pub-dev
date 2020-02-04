// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../dartdoc/backend.dart';
import '../../package/overrides.dart';
import '../../shared/handlers.dart';
import '../../shared/urls.dart';
import '../../shared/utils.dart' show contentType;

import '../templates/misc.dart';

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
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path);
    if (info == null) {
      return notFoundHandler(request);
    }
    // TODO: add content-length header too
    return htmlResponse('');
  }
  if (requestMethod == 'GET') {
    if (!entry.hasContent && docFilePath.path.endsWith('.html')) {
      final logTxtUrl = pkgDocUrl(docFilePath.package,
          version: docFilePath.version, relativePath: 'log.txt');
      final versionsUrl = pkgVersionsUrl(docFilePath.package);
      final content = renderErrorPage(
          'Documentation missing',
          'Pub site failed to generate dartdoc for this package.\n\n'
              '- View [dartdoc log]($logTxtUrl)\n'
              '- Check [other versions]($versionsUrl) of the same package.\n');
      return htmlResponse(content, status: 404);
    }
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path);
    if (info == null) {
      return notFoundHandler(request);
    }
    if (isNotModified(request, info.lastModified, info.etag)) {
      return shelf.Response.notModified();
    }
    final stream = dartdocBackend.readContent(entry, docFilePath.path);
    final headers = {
      HttpHeaders.contentTypeHeader: contentType(docFilePath.path),
      HttpHeaders.cacheControlHeader:
          'private, max-age=${staticShortCache.inSeconds}',
    };
    if (info.lastModified != null) {
      headers[HttpHeaders.lastModifiedHeader] =
          formatHttpDate(info.lastModified);
    }
    if (info.etag != null) {
      headers[HttpHeaders.etagHeader] = info.etag;
    }
    return shelf.Response(HttpStatus.ok, body: stream, headers: headers);
  }
  return notFoundHandler(request);
}

/// The parsed structure of the documentation URL.
/// [package] is always set, [version] or [path] may be missing.
class DocFilePath {
  final String package;
  final String version;
  final String path;

  DocFilePath(this.package, this.version, this.path);
}

/// Parses the /documentation/<package>/<version>/<path with many levels> URL
/// and returns the parsed structure.
DocFilePath parseRequestUri(Uri uri) {
  final int segmentCount = uri.pathSegments.length;
  if (segmentCount < 2) return null;
  if (uri.pathSegments[0] != 'documentation') return null;

  final String package = uri.pathSegments[1];
  if (package.isEmpty) return null;
  if (segmentCount == 2) {
    return DocFilePath(package, null, null);
  }

  final String version = uri.pathSegments[2];
  if (version.isEmpty) {
    return DocFilePath(package, null, null);
  }
  if (segmentCount == 3) {
    return DocFilePath(package, version, null);
  }

  final relativeSegments =
      uri.pathSegments.skip(3).where((s) => s.isNotEmpty).toList();
  String path = relativeSegments.join('/');
  if (path.isEmpty) {
    path = 'index.html';
  } else if (path.isNotEmpty && !relativeSegments.last.contains('.')) {
    path = '$path/index.html';
  }
  return DocFilePath(package, version, path);
}
