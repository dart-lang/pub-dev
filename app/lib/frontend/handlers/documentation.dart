// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/task/handlers.dart';
// ignore: implementation_imports
import 'package:pub_package_reader/src/names.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../dartdoc/backend.dart';
import '../../package/overrides.dart';
import '../../shared/handlers.dart';
import '../../shared/urls.dart';
import '../../shared/utils.dart' show contentType;

import '../request_context.dart';
import '../templates/misc.dart';
import 'headers.dart';

/// Handles requests for:
///   - /documentation/<package>/<version>
Future<shelf.Response> documentationHandler(shelf.Request request) async {
  final docFilePath = parseRequestUri(request.requestedUri);
  if (docFilePath == null) {
    return notFoundHandler(request);
  }
  checkPackageVersionParams(docFilePath.package, docFilePath.version);
  if (redirectPackageUrls.containsKey(docFilePath.package)) {
    return redirectResponse(redirectPackageUrls[docFilePath.package]!);
  }
  if (!await packageBackend.isPackageVisible(docFilePath.package)) {
    return notFoundHandler(request);
  }
  if (docFilePath.version == null) {
    return redirectResponse(pkgDocUrl(docFilePath.package, isLatest: true));
  }
  if (docFilePath.path == null) {
    return redirectResponse('${request.requestedUri}/');
  }
  final String requestMethod = request.method.toUpperCase();

  if (requestContext.experimentalFlags.showSandboxedOutput) {
    if (requestMethod != 'HEAD' && requestMethod != 'GET') {
      // TODO: Should probably be "method not supported"!
      return notFoundHandler(request);
    }

    final package = docFilePath.package;
    var version = docFilePath.version!;
    final path = docFilePath.path!;
    // Redirect to /latest/ version if the version points to latest version
    if (version != 'latest') {
      final latestVersion = await packageBackend.getLatestVersion(package);
      if (latestVersion != null && latestVersion == version) {
        return redirectResponse(pkgDocUrl(
          docFilePath.package,
          isLatest: true,
          relativePath: docFilePath.path,
        ));
      }
    }
    // Find the latest version
    if (version == 'latest') {
      final latestVersion = await packageBackend.getLatestVersion(package);
      if (latestVersion == null) {
        return notFoundHandler(request);
      }
      version = latestVersion;
    }

    return await handleDartDoc(request, package, version, path);
  }

  final entry =
      await dartdocBackend.getEntry(docFilePath.package, docFilePath.version!);
  if (entry == null) {
    return notFoundHandler(request);
  }
  if (entry.isLatest == true && docFilePath.version != 'latest') {
    final version = await packageBackend.getLatestVersion(entry.packageName);
    if (version == docFilePath.version) {
      return redirectResponse(pkgDocUrl(docFilePath.package,
          isLatest: true, relativePath: docFilePath.path));
    }
  }
  if (requestMethod == 'HEAD') {
    if (!entry.hasContent && docFilePath.path!.endsWith('.html')) {
      return notFoundHandler(request);
    }
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path!);
    if (info == null) {
      return notFoundHandler(request);
    }
    // TODO: add content-length header too
    return htmlResponse('');
  }
  if (requestMethod == 'GET') {
    if (!entry.hasContent && docFilePath.path!.endsWith('.html')) {
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
    final info = await dartdocBackend.getFileInfo(entry, docFilePath.path!);
    if (info == null) {
      return notFoundHandler(request);
    }
    if (isNotModified(request, info.lastModified, info.etag)) {
      return shelf.Response.notModified();
    }
    final headers = {
      HttpHeaders.contentTypeHeader: contentType(docFilePath.path!),
      ...CacheHeaders.dartdocAsset(),
      HttpHeaders.lastModifiedHeader: formatHttpDate(info.lastModified),
      HttpHeaders.etagHeader: info.etag,
    };
    if (info.blobId != null) {
      final sendGzip = request.acceptsGzipEncoding();
      final content = dartdocBackend.readFromBlob(entry, info);
      return shelf.Response(
        HttpStatus.ok,
        body: sendGzip ? content : content.transform(gzip.decoder),
        headers: {
          ...headers,
          if (sendGzip) HttpHeaders.contentEncodingHeader: 'gzip',
        },
      );
    }
    final stream = dartdocBackend.readContent(entry, docFilePath.path!);
    return shelf.Response(HttpStatus.ok, body: stream, headers: headers);
  }
  return notFoundHandler(request);
}

/// The parsed structure of the documentation URL.
/// [package] is always set, [version] or [path] may be missing.
class DocFilePath {
  final String package;
  final String? version;
  final String? path;

  DocFilePath(this.package, this.version, this.path);
}

/// Parses the /documentation/<package>/<version>/<path with many levels> URL
/// and returns the parsed structure.
DocFilePath? parseRequestUri(Uri uri) {
  final int segmentCount = uri.pathSegments.length;
  if (segmentCount < 2) return null;
  if (uri.pathSegments[0] != 'documentation') return null;

  final String package = uri.pathSegments[1];
  // reject empty or invalid package names
  if (package.isEmpty || !identifierExpr.hasMatch(package)) {
    return null;
  }
  if (segmentCount == 2) {
    return DocFilePath(package, null, null);
  }

  final String version = uri.pathSegments[2];
  if (version.trim().isEmpty) {
    return DocFilePath(package, null, null);
  }
  // reject empty or invalid version names
  if (!_isValidVersion(version)) {
    return null;
  }
  if (segmentCount == 3) {
    return DocFilePath(package, version, null);
  }

  final relativeSegments =
      uri.pathSegments.skip(3).where((s) => s.isNotEmpty).toList();
  var pathSegments = relativeSegments;
  if (relativeSegments.isEmpty || !relativeSegments.last.contains('.')) {
    pathSegments = [...relativeSegments, 'index.html'];
  }
  final path = p.normalize(p.joinAll(pathSegments));
  return DocFilePath(package, version, path);
}

bool _isValidVersion(String version) {
  if (version.trim().isEmpty) return false;
  if (version == 'latest') return true;
  try {
    Version.parse(version);
  } on FormatException catch (_) {
    return false;
  }
  return true;
}
