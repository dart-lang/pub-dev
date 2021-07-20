// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;

import '../../package/backend.dart';
import '../../package/name_tracker.dart';
import '../../publisher/backend.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';
import '../static_files.dart';
import '../templates/misc.dart';

/// Handles requests for /help
Future<shelf.Response> helpPageHandler(shelf.Request request) async {
  return htmlResponse(renderHelpPage());
}

/// Handles requests for /help/scoring
Future<shelf.Response> helpPageScoringHandler(shelf.Request request) async {
  return htmlResponse(renderHelpScoringPage());
}

/// Handles requests for /help/search
Future<shelf.Response> helpPageSearchHandler(shelf.Request request) async {
  return htmlResponse(renderHelpSearchPage());
}

/// Handles requests for /help/publishing
Future<shelf.Response> helpPagePublishingHandler(shelf.Request request) async {
  return htmlResponse(renderHelpPublishingPage());
}

/// Handles requests for /policy
Future<shelf.Response> policyPageHandler(shelf.Request request) async {
  return htmlResponse(renderPolicyPage());
}

/// Handles requests for /security
Future<shelf.Response> securityPageHandler(shelf.Request request) async {
  return htmlResponse(renderSecurityPage());
}

/// Handles requests for /readiness_check
Future<shelf.Response> readinessCheckHandler(shelf.Request request) async {
  if (nameTracker.isReady) {
    return htmlResponse('OK');
  } else {
    return htmlResponse('Service Unavailable', status: 503);
  }
}

/// Handles requests for /robots.txt
Future<shelf.Response> robotsTxtHandler(shelf.Request request) async {
  if (requestContext.blockRobots) {
    return rejectRobotsHandler(request);
  }
  final uri = request.requestedUri;
  final sitemapUri = uri.replace(path: 'sitemap.txt');
  final sitemap2Uri = uri.replace(path: 'sitemap-2.txt');
  return shelf.Response(200,
      body: [
        'User-agent: *',
        'Sitemap: $sitemapUri',
        'Sitemap: $sitemap2Uri',
      ].join('\n'));
}

/// Handles requests for /sitemap.txt
Future<shelf.Response> sitemapTxtHandler(shelf.Request request) async {
  final uri = request.requestedUri;
  final content = await cache.sitemap(uri.toString()).get(() async {
    // Google wants the return page to have < 50,000 entries and be less than
    // 50MB -  https://support.google.com/webmasters/answer/183668?hl=en
    // As of 2018-01-01, the return page is ~3,000 entries and ~140KB
    // By restricting to packages that have been updated in the last two years,
    // the count is closer to ~1,500

    final items = <String>[];
    final pages = [
      '/',
      '/help',
      '/web',
      '/flutter',
      '/publishers',
    ];
    items.addAll(pages.map((page) => uri.replace(path: page).toString()));

    final stream = packageBackend.sitemapPackageNames();
    await for (var package in stream) {
      final pkgPath = urls.pkgPageUrl(package);
      items.add(uri.replace(path: pkgPath).toString());

      final docPath = urls.pkgDocUrl(package, isLatest: true);
      items.add(uri.replace(path: docPath).toString());
    }

    items.sort();
    return items.join('\n');
  });

  return shelf.Response.ok(content);
}

/// Handles requests for /sitemap-2.txt
Future<shelf.Response> sitemapPublishersTxtHandler(
    shelf.Request request) async {
  final uri = request.requestedUri;
  final content = await cache.sitemap(uri.toString()).get(() async {
    final page = await publisherBackend.listPublishers();

    return page.publishers!
        .map((p) => urls.publisherUrl(p.publisherId))
        .map((s) => uri.replace(path: s).toString())
        .join('\n');
  });

  return shelf.Response.ok(content);
}

/// Handles requests for /static/* content
Future<shelf.Response> staticsHandler(shelf.Request request) async {
  // Simplifies all of '.', '..', '//'!
  final String normalized = path.normalize(request.requestedUri.path);
  final StaticFile? staticFile = staticFileCache.getFile(normalized);
  if (staticFile != null) {
    if (isNotModified(request, staticFile.lastModified, staticFile.etag)) {
      return shelf.Response.notModified();
    }
    final String? hash = request.requestedUri.queryParameters['hash'];
    final headers = <String, String>{
      HttpHeaders.contentTypeHeader: staticFile.contentType,
      HttpHeaders.contentLengthHeader: staticFile.bytes.length.toString(),
      HttpHeaders.lastModifiedHeader: formatHttpDate(staticFile.lastModified),
      HttpHeaders.etagHeader: staticFile.etag,
    };
    if (hash != null && hash.isNotEmpty && hash == staticFile.etag) {
      headers[HttpHeaders.cacheControlHeader] =
          'private, max-age=${staticLongCache.inSeconds}';
    }
    return shelf.Response.ok(staticFile.bytes, headers: headers);
  }
  return notFoundHandler(request);
}

/// Handles requests for /experimental
Future<shelf.Response> experimentalHandler(shelf.Request request) async {
  final enabled = request.requestedUri.queryParameters['enabled'] == '1';
  final cookie = Cookie('experimental', enabled ? '1' : '0')
    ..httpOnly = true
    ..path = '/'
    ..maxAge = enabled ? 7 * 24 * 60 * 60 : 0; // cookie lives for one week
  return htmlResponse('''
<!doctype html>
<html>
<head>
  <meta http-equiv="refresh" content="5; url=/">
</head>
<body>
  <center>
    <p>
      <br><br><br>
      Experimental cookie enabled: <b>$enabled</b> (<a href="/experimental/?enabled=${enabled ? '0' : '1'}">toggle</a>).<br>
      (redirecting to <a href="/">pub.dev</a> in 5 seconds).
    </p>
  <center>
</body>
</html>''', headers: {
    HttpHeaders.setCookieHeader: cookie.toString(),
  });
}

String _notFoundMessage(Uri requestedUri) {
  return 'You\'ve stumbled onto a page (`${requestedUri.path}`) that doesn\'t exist. '
      'Luckily you have several options:\n\n'
      '- Use the search box above, which will list packages that match your query.\n'
      '- Visit the [packages](/packages) page and start browsing.\n'
      '- Pick one of the top packages, listed on the [home page](/).\n';
}

/// Renders a formatted response when the request points to a missing or invalid path.
shelf.Response formattedNotFoundHandler(shelf.Request request) {
  return htmlResponse(
    renderErrorPage(default404NotFound, _notFoundMessage(request.requestedUri)),
    status: 404,
  );
}

/// Renders a formatted response when the request contains invalid (e.g. badly formatted)
/// parameters.
shelf.Response formattedInvalidInputResponse(shelf.Request request) {
  return htmlResponse(
    renderErrorPage(default404NotFound, _notFoundMessage(request.requestedUri)),
    status: 400,
  );
}
