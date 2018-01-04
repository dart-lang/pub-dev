// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:http_parser/http_parser.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;

import '../shared/analyzer_client.dart';
import '../shared/handlers.dart';
import '../shared/platform.dart';
import '../shared/search_service.dart';
import '../shared/utils.dart';

import 'atom_feed.dart';
import 'backend.dart';
import 'handlers_redirects.dart';
import 'models.dart';
import 'search_service.dart';
import 'static_files.dart';
import 'templates.dart';

final _pubHeaderLogger = new Logger('pub.header_logger');

// Non-revealing metrics to monitor the search service behavior from outside.
final _packageAnalysisLatencyTracker = new LastNTracker<Duration>();
final _packageOverallLatencyTracker = new LastNTracker<Duration>();
final _searchOverallLatencyTracker = new LastNTracker<Duration>();

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

  if (path.startsWith('/experimental')) {
    var newPath = path.substring('/experimental'.length);
    if (newPath.isEmpty) newPath = '/';
    return redirectResponse(
        request.requestedUri.replace(path: newPath).toString());
  }
  if (path == '/search') {
    return redirectResponse(
        request.requestedUri.replace(path: '/packages').toString());
  }

  final handler = _handlers[path];

  if (handler != null) {
    return handler(request);
  } else if (path == '/api/packages') {
    // NOTE: This is special-cased, since it is not an API used by pub but
    // rather by the editor.
    return _apiPackagesHandler(request);
  } else if (path.startsWith('/api') ||
      path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return _packageHandler(request);
  } else if (path.startsWith('/doc')) {
    return _docHandler(request);
  } else if (path == '/robots.txt' && !_isProd(request)) {
    return rejectRobotsHandler(request);
  } else if (path.startsWith(staticUrls.staticPath)) {
    return _staticsHandler(request);
  } else if (staticRootFiles.contains(path)) {
    return _staticsHandler(request,
        pathOverride: '${staticUrls.staticPath}$path');
  } else {
    return _formattedNotFoundHandler(request);
  }
}

const _handlers = const <String, shelf.Handler>{
  '/': __indexHandler,
  '/packages': _packagesHandlerHtml,
  '/flutter': _flutterLandingHandler,
  '/flutter/packages': _flutterPackagesHandlerHtml,
  '/flutter/plugins': _redirectToFlutterPackages,
  '/server': _serverLandingHandler,
  '/server/packages': _serverPackagesHandlerHtml,
  '/web': _webLandingHandler,
  '/web/packages': _webPackagesHandlerHtml,
  '/debug': _debugHandler,
  '/feed.atom': _atomFeedHandler,
  '/sitemap.txt': _siteMapHandler,
  '/authorized': _authorizedHandler,
  '/packages.json': _packagesHandler,
  '/help': _helpPageHandler,
};

/// Handles requests for /debug
Future<shelf.Response> _debugHandler(shelf.Request request) async {
  Map toShortStat(LastNTracker<Duration> tracker) => {
        'median': tracker.median?.inMilliseconds,
        'p90': tracker.p90?.inMilliseconds,
        'p99': tracker.p99?.inMilliseconds,
      };
  return jsonResponse({
    'package': {
      'analysis_latency': toShortStat(_packageAnalysisLatencyTracker),
      'overall_latency': toShortStat(_packageOverallLatencyTracker),
    },
    'search': {
      'overall_latency': toShortStat(_searchOverallLatencyTracker),
    },
  }, indent: true);
}

/// Handles requests for /
Future<shelf.Response> __indexHandler(shelf.Request request) =>
    _indexHandler(request, null);

/// Handles requests for /flutter
Future<shelf.Response> _flutterLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.flutter);

/// Handles requests for /server
Future<shelf.Response> _serverLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.server);

/// Handles requests for /web
Future<shelf.Response> _webLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.web);

/// Handles requests for:
/// - /
/// - /flutter
/// - /server
/// - /web
Future<shelf.Response> _indexHandler(
    shelf.Request request, String platform) async {
  final String queryText = request.requestedUri.queryParameters['q']?.trim();
  if (queryText != null) {
    final String path = request.requestedUri.path;
    final String separator = path.endsWith('/') ? '' : '/';
    final String newPath = '$path${separator}packages';
    return redirectResponse(
        request.requestedUri.replace(path: newPath).toString());
  }
  final isProd = _isProd(request);
  String pageContent =
      isProd ? await backend.uiPackageCache?.getUIIndexPage(platform) : null;
  if (pageContent == null) {
    Future<String> searchAndRenderMiniList(SearchOrder order) async {
      final count = 15;
      final result = await searchService.search(new SearchQuery.parse(
          platform: platform, limit: count, order: order));
      final packages = result.packages.take(count).toList();
      return templateService.renderMiniList(packages);
    }

    final minilist = await searchAndRenderMiniList(SearchOrder.top);
    pageContent = templateService.renderIndexPage(minilist, platform);
    if (isProd) {
      await backend.uiPackageCache?.setUIIndexPage(platform, pageContent);
    }
  }
  return htmlResponse(pageContent);
}

/// Handles requests for /help
Future<shelf.Response> _helpPageHandler(shelf.Request request) async {
  return htmlResponse(templateService.renderHelpPage());
}

/// Handles requests for /feed.atom
Future<shelf.Response> _atomFeedHandler(shelf.Request request) async {
  final int PageSize = 10;

  // The python version had paging support, but there was no point to it, since
  // the "next page" link was never returned to the caller.
  final int page = 1;

  final versions = await backend.latestPackageVersions(
      offset: PageSize * (page - 1), limit: PageSize);
  final feed = feedFromPackageVersions(request.requestedUri, versions);
  return atomXmlResponse(feed.toXmlDocument());
}

Future<shelf.Response> _siteMapHandler(shelf.Request request) async {
  // Google wants the return page to have < 50,000 entries and be less than
  // 50MB -  https://support.google.com/webmasters/answer/183668?hl=en
  // As of 2018-01-01, the return page is ~3,000 entries and ~140KB
  // By restricting to packages that have been updated in the last two years,
  // the count is closer to ~1,500

  final twoYearsAgo = new DateTime.now().subtract(twoYears);
  final items = new List.from(const ['', 'help', 'server', 'web', 'flutter']);

  await for (var package
      in backend.allPackageNames(updatedSince: twoYearsAgo)) {
    items.add('packages/$package');
  }

  items.sort();

  return new shelf.Response.ok(items.map((e) => '$siteRoot/$e').join('\n'));
}

/// Handles requests for /authorized
shelf.Response _authorizedHandler(_) =>
    htmlResponse(templateService.renderAuthorizedPage());

/// Handles requests for /doc
shelf.Response _docHandler(shelf.Request request) {
  final pubDocUrl = 'https://www.dartlang.org/tools/pub/';
  final dartlangDotOrgPath = redirectPaths[request.requestedUri.path];
  if (dartlangDotOrgPath != null) {
    return redirectResponse('$pubDocUrl$dartlangDotOrgPath');
  }
  return redirectResponse(pubDocUrl);
}

/// Handles requests for /packages - multiplexes to JSON/HTML handler.
Future<shelf.Response> _packagesHandler(shelf.Request request) async {
  final int page = _pageFromUrl(request.url);
  final path = request.requestedUri.path;
  if (path.endsWith('.json')) {
    return _packagesHandlerJson(request, page, true);
  } else if (request.url.queryParameters['format'] == 'json') {
    return _packagesHandlerJson(request, page, false);
  } else {
    return _packagesHandlerHtml(request);
  }
}

/// The max age a browser would take hold of the static files before checking
/// with the server for a newer version.
const _staticMaxAge = const Duration(minutes: 5);

Future<shelf.Response> _staticsHandler(shelf.Request request,
    {String pathOverride}) async {
  // Simplifies all of '.', '..', '//'!
  final String normalized =
      path.normalize(pathOverride ?? request.requestedUri.path);
  final StaticFile staticFile = staticsCache.getFile(normalized);
  if (staticFile != null) {
    final ifModifiedSince = request.ifModifiedSince;
    if (ifModifiedSince != null &&
        !staticFile.lastModified.isAfter(ifModifiedSince)) {
      return new shelf.Response.notModified();
    }
    final ifNoneMatch = request.headers[HttpHeaders.IF_NONE_MATCH];
    if (ifNoneMatch != null && ifNoneMatch == staticFile.etag) {
      return new shelf.Response.notModified();
    }
    return new shelf.Response.ok(
      staticFile.bytes,
      headers: {
        HttpHeaders.CONTENT_TYPE: staticFile.contentType,
        HttpHeaders.CONTENT_LENGTH: staticFile.bytes.length.toString(),
        HttpHeaders.LAST_MODIFIED: formatHttpDate(staticFile.lastModified),
        HttpHeaders.ETAG: staticFile.etag,
        HttpHeaders.CACHE_CONTROL: 'max-age: ${_staticMaxAge.inSeconds}',
      },
    );
  }
  return _formattedNotFoundHandler(request);
}

/// Handles requests for /packages - JSON
Future<shelf.Response> _packagesHandlerJson(
    shelf.Request request, int page, bool dotJsonResponse) async {
  final PageSize = 50;

  final offset = PageSize * (page - 1);
  final limit = PageSize + 1;

  final packages = await backend.latestPackages(offset: offset, limit: limit);
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
    'packages': packages.take(PageSize).map(toUrl).toList(),
    'next': nextPageUrl != null ? '$nextPageUrl' : null,

    // NOTE: We're not returning the following entry:
    //   - 'prev'
    //   - 'pages'
  };

  return jsonResponse(json);
}

/// Handles /packages - package listing
Future<shelf.Response> _packagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, null);

/// Handles /flutter/packages
Future<shelf.Response> _flutterPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.flutter);

/// Handles /server/packages
Future<shelf.Response> _serverPackagesHandlerHtml(shelf.Request request) =>
    _packagesHandlerHtmlCore(request, KnownPlatforms.server);

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
  final int page = _pageFromUrl(request.url);
  final int offset = PackageLinks.resultsPerPage * (page - 1);
  final String queryText = request.requestedUri.queryParameters['q'] ?? '';
  final String sortParam = request.requestedUri.queryParameters['sort'];
  final SearchOrder sortOrder = (sortParam == null || sortParam.isEmpty)
      ? null
      : parseSearchOrder(sortParam);

  final SearchQuery searchQuery = new SearchQuery.parse(
      query: queryText,
      platform: platform,
      order: sortOrder,
      offset: offset,
      limit: PackageLinks.resultsPerPage);
  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;

  final links = new PackageLinks(offset, totalCount, searchQuery: searchQuery);
  return htmlResponse(templateService.renderPkgIndexPage(
    searchResult.packages,
    links,
    platform,
    searchQuery: searchQuery,
    totalCount: totalCount,
  ));
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
      return _packageVersionHandlerHtml(request, package, version: version);
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
  return jsonResponse(json);
}

/// Handles requests for /packages/<package>/versions
Future<shelf.Response> _packageVersionsHandler(
    shelf.Request request, String packageName) async {
  final versions = await backend.versionsOfPackage(packageName);
  if (versions.isEmpty) return _formattedNotFoundHandler(request);

  sortPackageVersionsDesc(versions);

  final versionDownloadUrls =
      await Future.wait(versions.map((PackageVersion version) {
    return backend.downloadUrl(packageName, version.version);
  }).toList());

  return htmlResponse(templateService.renderPkgVersionsPage(
      packageName, versions, versionDownloadUrls));
}

Future<shelf.Response> _packageVersionHandlerHtmlCore(
    shelf.Request request,
    String packageName,
    String render(
        Package package,
        bool isVersionPage,
        List<PackageVersion> first10Versions,
        List<Uri> versionDownloadUrls,
        PackageVersion selectedVersion,
        PackageVersion latestStableVersion,
        PackageVersion latestDevVersion,
        int totalNumberOfVersions,
        AnalysisExtract extract,
        AnalysisView analysis),
    {String versionName}) async {
  final Stopwatch sw = new Stopwatch()..start();
  String cachedPage;
  final bool isProd = _isProd(request);
  if (isProd && backend.uiPackageCache != null) {
    cachedPage =
        await backend.uiPackageCache.getUIPackagePage(packageName, versionName);
  }

  if (cachedPage == null) {
    final Package package = await backend.lookupPackage(packageName);
    if (package == null) return _formattedNotFoundHandler(request);

    final versions = await backend.versionsOfPackage(packageName);

    sortPackageVersionsDesc(versions, decreasing: true, pubSorting: true);
    final latestStable = versions[0];
    final first10Versions = versions.take(10).toList();

    sortPackageVersionsDesc(versions, decreasing: true, pubSorting: false);
    final latestDev = versions[0];

    PackageVersion selectedVersion;
    if (versionName != null) {
      for (var v in versions) {
        if (v.version == versionName) selectedVersion = v;
      }
      // TODO: cache error?
      if (selectedVersion == null) {
        return _formattedNotFoundHandler(request);
      }
    } else {
      if (selectedVersion == null) {
        selectedVersion = latestStable;
      }
    }
    final Stopwatch serviceSw = new Stopwatch()..start();
    final analysisKey =
        new AnalysisKey(selectedVersion.package, selectedVersion.version);
    final AnalysisExtract analysisExtract =
        await analyzerClient.getAnalysisExtract(analysisKey);
    final AnalysisView analysisView =
        await analyzerClient.getAnalysisView(analysisKey);
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final versionDownloadUrls =
        await Future.wait(first10Versions.map((PackageVersion version) {
      return backend.downloadUrl(packageName, version.version);
    }).toList());

    cachedPage = render(
        package,
        versionName != null,
        first10Versions,
        versionDownloadUrls,
        selectedVersion,
        latestStable,
        latestDev,
        versions.length,
        analysisExtract,
        analysisView);

    if (isProd && backend.uiPackageCache != null) {
      await backend.uiPackageCache
          .setUIPackagePage(packageName, versionName, cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }

  return htmlResponse(cachedPage);
}

/// Handles requests for /packages/<package>
/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> _packageVersionHandlerHtml(
        shelf.Request request, String packageName, {String version}) =>
    _packageVersionHandlerHtmlCore(
        request, packageName, templateService.renderPkgShowPage,
        versionName: version);

/// Handles request for /api/packages?page=<num>
Future<shelf.Response> _apiPackagesHandler(shelf.Request request) async {
  final int PageSize = 100;

  final int page = _pageFromUrl(request.url);

  final packages = await backend.latestPackages(
      offset: PageSize * (page - 1), limit: PageSize + 1);

  // NOTE: We queried for `PageSize+1` packages, if we get less than that, we
  // know it was the last page.
  // But we only use `PageSize` packages to display in the result.
  final List<Package> pagePackages = packages.take(PageSize).toList();
  final List<PackageVersion> pageVersions =
      await backend.lookupLatestVersions(pagePackages);

  final lastPage = packages.length == pagePackages.length;

  final packagesJson = [];

  final uri = request.requestedUri;
  for (var version in pageVersions) {
    final versionString = Uri.encodeComponent(version.version);
    final packageString = Uri.encodeComponent(version.package);

    final apiArchiveUrl = uri
        .resolve('/packages/$packageString/versions/$versionString.tar.gz')
        .toString();
    final apiPackageUrl =
        uri.resolve('/api/packages/$packageString').toString();
    final apiPackageVersionUrl = uri
        .resolve('/api/packages/$packageString/versions/$versionString')
        .toString();
    final apiNewPackageVersionUrl =
        uri.resolve('/api/packages/$packageString/new').toString();
    final apiUploadersUrl =
        uri.resolve('/api/packages/$packageString/uploaders').toString();
    final versionUrl = uri
        .resolve('/api/packages/$packageString/versions/{version}')
        .toString();

    packagesJson.add({
      'name': version.package,
      'latest': {
        'version': version.version,
        'pubspec': version.pubspec.asJson,

        // TODO: We should get rid of these:
        'archive_url': apiArchiveUrl,
        'package_url': apiPackageUrl,
        'url': apiPackageVersionUrl,

        // NOTE: We do not add the following
        //    - 'new_dartdoc_url'
      },
      // TODO: We should get rid of these:
      'url': apiPackageUrl,
      'version_url': versionUrl,
      'new_version_url': apiNewPackageVersionUrl,
      'uploaders_url': apiUploadersUrl,
    });
  }

  final Map<String, dynamic> json = {
    'next_url': null,
    'packages': packagesJson,

    // NOTE: We do not add the following:
    //     - 'pages'
    //     - 'prev_url'
  };

  if (!lastPage) {
    json['next_url'] =
        '${request.requestedUri.resolve('/api/packages?page=${page + 1}')}';
  }

  return jsonResponse(json);
}

/// Handles requests for /flutter/plugins (redirects to /flutter/packages).
shelf.Response _redirectToFlutterPackages(shelf.Request request) =>
    redirectResponse('/flutter/packages');

shelf.Response _formattedNotFoundHandler(shelf.Request request) {
  final message = 'The path \'${request.requestedUri.path}\' was not found.';
  return htmlResponse(
    templateService.renderErrorPage(default404NotFound, message, null),
    status: 404,
  );
}

/// Extracts the 'page' query parameter from [url].
///
/// Returns a valid positive integer.
int _pageFromUrl(Uri url) {
  final pageAsString = url.queryParameters['page'];
  int pageAsInt = 1;
  if (pageAsString != null) {
    try {
      pageAsInt = max(int.parse(pageAsString), 1);
    } catch (_, __) {}
  }
  return pageAsInt;
}

bool _isProd(shelf.Request request) {
  final String host = request.requestedUri.host;
  return host == hostedDomain;
}
