// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../scorecard/backend.dart';
import '../shared/analyzer_client.dart';
import '../shared/handlers.dart';
import '../shared/packages_overrides.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';

import 'backend.dart';
import 'handlers/admin.dart';
import 'handlers/atom_feed.dart';
import 'handlers/custom_api.dart';
import 'handlers/documentation.dart';
import 'handlers/landing.dart';
import 'handlers/misc.dart';
import 'handlers/redirects.dart';
import 'models.dart';
import 'search_service.dart';
import 'static_files.dart';
import 'templates.dart';

final _pubHeaderLogger = new Logger('pub.header_logger');

// Non-revealing metrics to monitor the search service behavior from outside.
final _packageAnalysisLatencyTracker = new DurationTracker();
final _packagePreRenderLatencyTracker = new DurationTracker();
final _packageDoneLatencyTracker = new DurationTracker();
final _packageOverallLatencyTracker = new DurationTracker();
final _searchOverallLatencyTracker = new DurationTracker();

void _logPubHeaders(shelf.Request request) {
  request.headers.forEach((String key, String value) {
    final lowerCaseKey = key.toLowerCase();
    if (lowerCaseKey.startsWith('x-pub')) {
      _pubHeaderLogger.info('$key: $value');
    }
  });
}

/// Handler for the whole URL space of pub.dartlang.org
///
/// The passed in [shelfPubApi] handler will be used for handling requests to
///   - /api/*
Future<shelf.Response> appHandler(
    shelf.Request request, shelf.Handler shelfPubApi) async {
  final path = request.requestedUri.path;

  _logPubHeaders(request);

  final redirected = tryHandleRedirects(request);
  if (redirected != null) return redirected;

  final handler = _handlers[path];

  if (handler != null) {
    return await handler(request);
  } else if (path.startsWith('/admin/confirm/')) {
    return await adminConfirmHandler(request);
  } else if (path == '/api/packages' &&
      request.requestedUri.queryParameters['compact'] == '1') {
    return apiPackagesCompactListHandler(request);
  } else if (path == '/api/packages') {
    // NOTE: This is special-cased, since it is not an API used by pub but
    // rather by the editor.
    return apiPackagesHandler(request);
  } else if (path.startsWith('/api/documentation')) {
    return apiDocumentationHandler(request);
  } else if (isHandlerForApiPackageMetrics(request.requestedUri)) {
    return apiPackageMetricsHandler(request);
  } else if (path.startsWith('/api') ||
      path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return await shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return await _packageHandler(request);
  } else if (path.startsWith('/documentation')) {
    return documentationHandler(
        request.context['_originalRequest'] as shelf.Request ?? request);
  } else if (path == '/robots.txt' && !isProductionHost(request)) {
    return rejectRobotsHandler(request);
  } else if (staticFileCache.hasFile(request.requestedUri.path)) {
    return staticsHandler(request);
  } else {
    return _formattedNotFoundHandler(request);
  }
}

const _handlers = const <String, shelf.Handler>{
  '/': indexLandingHandler,
  '/packages': _packagesHandlerHtml,
  '/flutter': flutterLandingHandler,
  '/flutter/packages': _flutterPackagesHandlerHtml,
  '/web': webLandingHandler,
  '/web/packages': _webPackagesHandlerHtml,
  '/api/search': apiSearchHandler,
  '/api/history': apiHistoryHandler, // experimental, do not rely on it
  '/debug': _debugHandler,
  '/feed.atom': atomFeedHandler,
  '/sitemap.txt': siteMapTxtHandler,
  '/authorized': authorizedHandler,
  '/packages.json': _packagesHandler,
  '/help': helpPageHandler,
};

/// Handles requests for /debug
shelf.Response _debugHandler(shelf.Request request) {
  return debugResponse({
    'package': {
      'analysis_latency': _packageAnalysisLatencyTracker.toShortStat(),
      'pre_render_latency': _packagePreRenderLatencyTracker.toShortStat(),
      'done_latency': _packageDoneLatencyTracker.toShortStat(),
      'overall_latency': _packageOverallLatencyTracker.toShortStat(),
    },
    'search': {
      'overall_latency': _searchOverallLatencyTracker.toShortStat(),
    },
  });
}

/// Handles requests for /packages - multiplexes to JSON/HTML handler.
Future<shelf.Response> _packagesHandler(shelf.Request request) async {
  final int page = extractPageFromUrlParameters(request.url);
  final path = request.requestedUri.path;
  if (path.endsWith('.json')) {
    return _packagesHandlerJson(request, page, true);
  } else if (request.url.queryParameters['format'] == 'json') {
    return _packagesHandlerJson(request, page, false);
  } else {
    return _packagesHandlerHtml(request);
  }
}

/// Handles requests for /packages - JSON
Future<shelf.Response> _packagesHandlerJson(
    shelf.Request request, int page, bool dotJsonResponse) async {
  final pageSize = 50;

  final offset = pageSize * (page - 1);
  final limit = pageSize + 1;

  final packages = await backend.latestPackages(offset: offset, limit: limit);
  packages.removeWhere((p) => isSoftRemoved(p.name));
  final bool lastPage = packages.length < limit;

  Uri nextPageUrl;
  if (!lastPage) {
    nextPageUrl =
        request.requestedUri.resolve('/packages.json?page=${page + 1}');
  }

  String toUrl(Package package) {
    final postfix = dotJsonResponse ? '.json' : '';
    return request.requestedUri
        .resolve('/packages/${Uri.encodeComponent(package.name)}$postfix')
        .toString();
  }

  final json = {
    'packages': packages.take(pageSize).map(toUrl).toList(),
    'next': nextPageUrl != null ? '$nextPageUrl' : null,

    // NOTE: We're not returning the following entry:
    //   - 'prev'
    //   - 'pages'
  };

  return jsonResponse(json, pretty: isPrettyJson(request));
}

/// Handles /packages - package listing
Future<shelf.Response> _packagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, null);

/// Handles /flutter/packages
Future<shelf.Response> _flutterPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.flutter);

/// Handles /web/packages
Future<shelf.Response> _webPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.web);

/// Handles:
/// - /packages - package listing
/// - /flutter/packages
/// - /server/packages
/// - /web/packages
Future<shelf.Response> _packagesHandlerHtmlCore(
    shelf.Request request, String platform) async {
  // TODO: use search memcache for all results here or remove search memcache
  final searchQuery = parseFrontendSearchQuery(request.requestedUri, platform);
  final sw = new Stopwatch()..start();
  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;

  final links =
      new PageLinks(searchQuery.offset, totalCount, searchQuery: searchQuery);
  final result = htmlResponse(templateService.renderPkgIndexPage(
    searchResult.packages,
    links,
    platform,
    searchQuery: searchQuery,
    totalCount: totalCount,
  ));
  _searchOverallLatencyTracker.add(sw.elapsed);
  return result;
}

/// Handles requests for /packages/...  - multiplexes to HTML/JSON handlers
///
/// Handles the following URLs:
///   - /packages/<package>
///   - /packages/<package>/versions
FutureOr<shelf.Response> _packageHandler(shelf.Request request) {
  final segments = request.url.pathSegments;
  assert(segments.first == 'packages');

  final package = segments[1];

  if (segments.length == 2) {
    if (package.endsWith('.json')) {
      final packageName = package.substring(0, package.length - '.json'.length);
      return _packageShowHandlerJson(request, Uri.decodeComponent(packageName));
    } else {
      return _packageVersionHandlerHtml(request, Uri.decodeComponent(package));
    }
  }

  if (segments[2] == 'versions') {
    if (segments.length == 4) {
      final String version = Uri.decodeComponent(segments[3]);
      return _packageVersionHandlerHtml(request, package, versionName: version);
    } else {
      return _packageVersionsHandler(request, package);
    }
  }
  return _formattedNotFoundHandler(request);
}

/// Handles requests for /packages/<package> - JSON
Future<shelf.Response> _packageShowHandlerJson(
    shelf.Request request, String packageName) async {
  final Package package = await backend.lookupPackage(packageName);
  if (package == null) return _formattedNotFoundHandler(request);

  final versions = await backend.versionsOfPackage(packageName);
  sortPackageVersionsDesc(versions, decreasing: false);

  final json = {
    'name': package.name,
    'uploaders': package.uploaderEmails,
    'versions':
        versions.map((packageVersion) => packageVersion.version).toList(),
  };
  return jsonResponse(json, pretty: isPrettyJson(request));
}

/// Handles requests for /packages/<package>/versions
Future<shelf.Response> _packageVersionsHandler(
    shelf.Request request, String packageName) async {
  final versions = await backend.versionsOfPackage(packageName);
  if (versions.isEmpty) {
    return redirectToSearch(packageName);
  }

  sortPackageVersionsDesc(versions);

  final versionDownloadUrls =
      await Future.wait(versions.map((PackageVersion version) {
    return backend.downloadUrl(packageName, version.version);
  }).toList());

  return htmlResponse(templateService.renderPkgVersionsPage(
      packageName, versions, versionDownloadUrls));
}

/// Handles requests for /packages/<package>
/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> _packageVersionHandlerHtml(
    shelf.Request request, String packageName,
    {String versionName}) async {
  if (redirectPackagePages.containsKey(packageName)) {
    return redirectResponse(redirectPackagePages[packageName]);
  }
  final Stopwatch sw = new Stopwatch()..start();
  String cachedPage;
  final bool isProd = isProductionHost(request);
  if (isProd && backend.uiPackageCache != null) {
    cachedPage =
        await backend.uiPackageCache.getUIPackagePage(packageName, versionName);
  }

  if (cachedPage == null) {
    final Package package = await backend.lookupPackage(packageName);
    if (package == null) {
      return redirectToSearch(packageName);
    }

    final versions = await backend.versionsOfPackage(packageName);

    sortPackageVersionsDesc(versions, decreasing: true, pubSorting: true);
    final latestStable = versions[0];
    final first10Versions = versions.take(10).toList();

    sortPackageVersionsDesc(versions, decreasing: true, pubSorting: false);
    final latestDev = versions[0];

    PackageVersion selectedVersion;
    if (versionName != null) {
      selectedVersion = versions.firstWhere(
        (v) => v.version == versionName,
        orElse: () => null,
      );
      if (selectedVersion == null) {
        return redirectResponse(urls.versionsTabUrl(packageName));
      }
    } else {
      if (selectedVersion == null) {
        selectedVersion = latestStable;
      }
    }
    final Stopwatch serviceSw = new Stopwatch()..start();
    final analysisKey =
        new AnalysisKey(selectedVersion.package, selectedVersion.version);
    final card = await scoreCardBackend.getScoreCardData(
        analysisKey.package, analysisKey.version,
        onlyCurrent: false);
    final AnalysisView analysisView =
        await analyzerClient.getAnalysisView(analysisKey);
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final versionDownloadUrls =
        await Future.wait(first10Versions.map((PackageVersion version) {
      return backend.downloadUrl(packageName, version.version);
    }).toList());
    _packagePreRenderLatencyTracker.add(serviceSw.elapsed);

    cachedPage = templateService.renderPkgShowPage(
        package,
        versionName != null,
        first10Versions,
        versionDownloadUrls,
        selectedVersion,
        latestStable,
        latestDev,
        versions.length,
        card,
        analysisView);
    _packageDoneLatencyTracker.add(serviceSw.elapsed);

    if (isProd && backend.uiPackageCache != null) {
      await backend.uiPackageCache
          .setUIPackagePage(packageName, versionName, cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }

  return htmlResponse(cachedPage);
}

Future<shelf.Response> _formattedNotFoundHandler(shelf.Request request) async {
  final packages = await topFeaturedPackages();
  final message =
      'You\'ve stumbled onto a page (`${request.requestedUri.path}`) that doesn\'t exist. '
      'Luckily you have several options:\n\n'
      '- Use the search box above, which will list packages that match your query.\n'
      '- Visit the [packages](/packages) page and start browsing.\n'
      '- Pick one of the top packages, listed below.\n';
  return htmlResponse(
    templateService.renderErrorPage(default404NotFound, message, packages),
    status: 404,
  );
}
