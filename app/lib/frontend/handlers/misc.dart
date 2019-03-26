// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;

import '../../shared/handlers.dart';
import '../../shared/packages_overrides.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../backend.dart';
import '../search_service.dart';
import '../static_files.dart';
import '../templates/misc.dart';

/// Handles requests for /help
Future<shelf.Response> helpPageHandler(shelf.Request request) async {
  return htmlResponse(renderHelpPage());
}

/// Handles requests for /sitemap.txt
Future<shelf.Response> siteMapTxtHandler(shelf.Request request) async {
  // Google wants the return page to have < 50,000 entries and be less than
  // 50MB -  https://support.google.com/webmasters/answer/183668?hl=en
  // As of 2018-01-01, the return page is ~3,000 entries and ~140KB
  // By restricting to packages that have been updated in the last two years,
  // the count is closer to ~1,500

  final twoYearsAgo = DateTime.now().subtract(twoYears);
  final items = List.from(const ['', 'help', 'web', 'flutter']
      .map((url) => '${urls.siteRoot}/$url'));

  final stream = backend.allPackageNames(
      updatedSince: twoYearsAgo, excludeDiscontinued: true);
  await for (var package in stream) {
    if (isSoftRemoved(package)) continue;
    items.add(urls.pkgPageUrl(package, includeHost: true));
    items.add(urls.pkgDocUrl(package, isLatest: true, includeHost: true));
  }

  items.sort();

  return shelf.Response.ok(items.join('\n'));
}

/// Handles requests for /static/* content
Future<shelf.Response> staticsHandler(shelf.Request request) async {
  // Simplifies all of '.', '..', '//'!
  final String normalized = path.normalize(request.requestedUri.path);
  final StaticFile staticFile = staticFileCache.getFile(normalized);
  if (staticFile != null) {
    if (isNotModified(request, staticFile.lastModified, staticFile.etag)) {
      return shelf.Response.notModified();
    }
    final String hash = request.requestedUri.queryParameters['hash'];
    final Duration cacheAge = hash != null && hash == staticFile.etag
        ? staticLongCache
        : staticShortCache;
    return shelf.Response.ok(
      staticFile.bytes,
      headers: {
        HttpHeaders.contentTypeHeader: staticFile.contentType,
        HttpHeaders.contentLengthHeader: staticFile.bytes.length.toString(),
        HttpHeaders.lastModifiedHeader: formatHttpDate(staticFile.lastModified),
        HttpHeaders.etagHeader: staticFile.etag,
        HttpHeaders.cacheControlHeader: 'max-age: ${cacheAge.inSeconds}',
      },
    );
  }
  return notFoundHandler(request);
}

Future<shelf.Response> formattedNotFoundHandler(shelf.Request request) async {
  final packages = await topFeaturedPackages();
  final message =
      'You\'ve stumbled onto a page (`${request.requestedUri.path}`) that doesn\'t exist. '
      'Luckily you have several options:\n\n'
      '- Use the search box above, which will list packages that match your query.\n'
      '- Visit the [packages](/packages) page and start browsing.\n'
      '- Pick one of the top packages, listed below.\n';
  return htmlResponse(
    renderErrorPage(default404NotFound, message, packages),
    status: 404,
  );
}
