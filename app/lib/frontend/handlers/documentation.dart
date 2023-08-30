// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:pub_dev/package/backend.dart';
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
  // Keep the `/latest/` URL if the latest finished is the latest version,
  // otherwise redirect to the latest finished version.
  if (version == 'latest') {
    final latestFinished = await taskBackend.latestFinishedVersion(package);
    if (latestFinished == null) {
      return notFoundHandler(request);
    }
    final latestVersion = await packageBackend.getLatestVersion(package);
    if (latestFinished != latestVersion) {
      return redirectResponse(pkgDocUrl(
        docFilePath.package,
        version: latestFinished,
        relativePath: docFilePath.path,
      ));
    }
    return await handleDartDoc(
        request, package, latestFinished, docFilePath.path!);
  }

  // May redirect to /latest/ URL if the version is latest version and it has a finished analysis.
  final latestVersion = await packageBackend.getLatestVersion(package);
  if (version == latestVersion) {
    final latestFinished = await taskBackend.latestFinishedVersion(package);
    if (version == latestFinished) {
      return redirectResponse(pkgDocUrl(
        docFilePath.package,
        isLatest: true,
        relativePath: docFilePath.path,
      ));
    }
  }

  // TODO: check if analysis finished for this version, redirect to closest version if possible

  return await handleDartDoc(request, package, version, docFilePath.path!);
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
