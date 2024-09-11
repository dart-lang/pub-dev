// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/handlers.dart';
// ignore: implementation_imports
import 'package:pub_package_reader/src/names.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../package/overrides.dart';
import '../../shared/handlers.dart';
import '../../shared/urls.dart';

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

  if (requestMethod != 'HEAD' && requestMethod != 'GET') {
    // TODO: Should probably be "method not supported"!
    return notFoundHandler(request);
  }

  final package = docFilePath.package;
  final version = docFilePath.version!;
  final resolved = await _resolveDocUrlVersion(package, version);
  if (resolved.isEmpty) {
    return notFoundHandler(
      request,
      body: resolved.message ?? default404NotFound,
    );
  }
  if (version != resolved.urlSegment) {
    return redirectResponse(pkgDocUrl(
      package,
      version: resolved.urlSegment,
      relativePath: docFilePath.path,
    ));
  } else {
    return await handleDartDoc(request, package, resolved, docFilePath.path!);
  }
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
  try {
    final parsedPath = Uri.parse(path);
    // a bad link embedded as path segment
    if (parsedPath.hasScheme) {
      return null;
    }
    // trigger lazy initialization issues
    parsedPath.queryParameters;
  } catch (_) {
    // ignore URL issues
    return null;
  }
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

/// Resolves the best version to display for a /documentation/[package]/[version]/
/// request. Also resolves the best URL it should be displayed under, in case it
/// needs a redirect.
///
/// Returns empty version and URL segment when there is no displayable version found.
Future<ResolvedDocUrlVersion> _resolveDocUrlVersion(
    String package, String version) async {
  return await cache.resolvedDocUrlVersion(package, version).get(() async {
    // Keep the `/latest/` URL if the latest finished is the latest version,
    // otherwise redirect to the latest finished version.
    if (version == 'latest') {
      final latestFinished = await taskBackend.latestFinishedVersion(package);
      if (latestFinished == null) {
        return ResolvedDocUrlVersion.empty(
            message: 'Analysis has not started yet.');
      }
      final latestVersion = await packageBackend.getLatestVersion(package);
      return ResolvedDocUrlVersion(
        version: latestFinished,
        urlSegment: latestFinished == latestVersion ? 'latest' : latestFinished,
      );
    }

    // Do not resolve if package version does not exists.
    final pv = await packageBackend.lookupPackageVersion(package, version);
    if (pv == null) {
      return ResolvedDocUrlVersion.empty(message: 'Not found.');
    }

    // Select the closest version (may be the same as version) that has a finished analysis.
    final closest = await taskBackend.closestFinishedVersion(package, version);
    return ResolvedDocUrlVersion(
      version: closest ?? version,
      urlSegment: closest ?? version,
    );
  }) as ResolvedDocUrlVersion;
}
