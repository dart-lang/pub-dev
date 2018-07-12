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

import '../history/backend.dart';
import '../shared/analyzer_client.dart';
import '../shared/dartdoc_client.dart';
import '../shared/handlers.dart';
import '../shared/platform.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';
import '../shared/urls.dart' as urls;
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
        request.requestedUri.replace(path: urls.searchUrl()).toString());
  }

  final handler = _handlers[path];

  if (handler != null) {
    return await handler(request);
  } else if (path == '/api/packages') {
    // NOTE: This is special-cased, since it is not an API used by pub but
    // rather by the editor.
    return _apiPackagesHandler(request);
  } else if (path.startsWith('/api/documentation')) {
    return _apiDocumentationHandler(request);
  } else if (path.startsWith('/api') ||
      path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return await shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return await _packageHandler(request);
  } else if (path.startsWith('/doc')) {
    return _docHandler(request);
  } else if (path == '/robots.txt' && !isProductionHost(request)) {
    return rejectRobotsHandler(request);
  } else if (staticFileCache.hasFile(request.requestedUri.path)) {
    return _staticsHandler(request);
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
  '/api/search': _apiSearchHandler,
  '/api/history': _apiHistoryHandler, // experimental, do not rely on it
  '/debug': _debugHandler,
  '/feed.atom': _atomFeedHandler,
  '/sitemap.txt': _siteMapHandler,
  '/authorized': _authorizedHandler,
  '/packages.json': _packagesHandler,
  '/help': _helpPageHandler,
};

/// Handles requests for /debug
shelf.Response _debugHandler(shelf.Request request) {
  Map toShortStat(LastNTracker<Duration> tracker) => {
        'median': tracker.median?.inMilliseconds,
        'p90': tracker.p90?.inMilliseconds,
        'p99': tracker.p99?.inMilliseconds,
      };
  return debugResponse({
    'package': {
      'analysis_latency': toShortStat(_packageAnalysisLatencyTracker),
      'overall_latency': toShortStat(_packageOverallLatencyTracker),
    },
    'search': {
      'overall_latency': toShortStat(_searchOverallLatencyTracker),
    },
  });
}

/// Handles requests for /
Future<shelf.Response> __indexHandler(shelf.Request request) =>
    _indexHandler(request, null);

/// Handles requests for /flutter
Future<shelf.Response> _flutterLandingHandler(shelf.Request request) =>
    _indexHandler(request, KnownPlatforms.flutter);

/// Handles requests for /server
shelf.Response _serverLandingHandler(shelf.Request request) =>
    redirectResponse('/');

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
  final isProd = isProductionHost(request);
  String pageContent =
      isProd ? await backend.uiPackageCache?.getUIIndexPage(platform) : null;
  if (pageContent == null) {
    final packages = await _topPackages(platform: platform);
    final minilist = templateService.renderMiniList(packages);

    pageContent = templateService.renderIndexPage(minilist, platform);
    if (isProd) {
      await backend.uiPackageCache?.setUIIndexPage(platform, pageContent);
    }
  }
  return htmlResponse(pageContent);
}

Future<List<PackageView>> _topPackages({String platform, int count: 15}) async {
  // TODO: store top packages in memcache
  final result = await searchService.search(new SearchQuery.parse(
    platform: platform,
    limit: count,
    isAd: true,
  ));
  return result.packages.take(count).toList();
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
  final items = new List.from(const ['', 'help', 'web', 'flutter']
      .map((url) => '${urls.siteRoot}/$url'));

  final stream = backend.allPackageNames(
      updatedSince: twoYearsAgo, excludeDiscontinued: true);
  await for (var package in stream) {
    items.add(urls.pkgPageUrl(package, includeHost: true));
    items.add(urls.pkgDocUrl(package, isLatest: true, includeHost: true));
  }

  items.sort();

  return new shelf.Response.ok(items.join('\n'));
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

Future<shelf.Response> _staticsHandler(shelf.Request request) async {
  // Simplifies all of '.', '..', '//'!
  final String normalized = path.normalize(request.requestedUri.path);
  final StaticFile staticFile = staticFileCache.getFile(normalized);
  if (staticFile != null) {
    if (isNotModified(request, staticFile.lastModified, staticFile.etag)) {
      return new shelf.Response.notModified();
    }
    final String hash = request.requestedUri.queryParameters['hash'];
    final Duration cacheAge = hash != null && hash == staticFile.etag
        ? staticLongCache
        : staticShortCache;
    return new shelf.Response.ok(
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
shelf.Response _serverPackagesHandlerHtml(shelf.Request request) {
  final params = request.requestedUri.queryParameters;
  final uri = new Uri(
    path: '/packages',
    queryParameters: params.isNotEmpty ? params : null,
  );
  return redirectResponse(uri.toString());
}

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
  final searchQuery = _parseSearchQuery(request, platform);
  final searchResult = await searchService.search(searchQuery);
  final int totalCount = searchResult.totalCount;

  final links = new PackageLinks(searchQuery.offset, totalCount,
      searchQuery: searchQuery);
  return htmlResponse(templateService.renderPkgIndexPage(
    searchResult.packages,
    links,
    platform,
    searchQuery: searchQuery,
    totalCount: totalCount,
  ));
}

SearchQuery _parseSearchQuery(shelf.Request request, String platform) {
  final int page = _pageFromUrl(request.url);
  final int offset = PackageLinks.resultsPerPage * (page - 1);
  final String queryText = request.requestedUri.queryParameters['q'] ?? '';
  final String sortParam = request.requestedUri.queryParameters['sort'];
  final SearchOrder sortOrder = (sortParam == null || sortParam.isEmpty)
      ? null
      : parseSearchOrder(sortParam);
  final isApiEnabled = request.requestedUri.queryParameters['api'] != '0';
  return new SearchQuery.parse(
    query: queryText,
    platform: platform,
    order: sortOrder,
    offset: offset,
    limit: PackageLinks.resultsPerPage,
    apiEnabled: isApiEnabled,
  );
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
  return jsonResponse(json);
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
      // TODO: cache error?
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
    final AnalysisExtract analysisExtract =
        await analyzerClient.getAnalysisExtract(analysisKey);
    final AnalysisView analysisView =
        await analyzerClient.getAnalysisView(analysisKey);
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final versionDownloadUrls =
        await Future.wait(first10Versions.map((PackageVersion version) {
      return backend.downloadUrl(packageName, version.version);
    }).toList());

    cachedPage = templateService.renderPkgShowPage(
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

/// Handles requests for /api/documentation/<package>
Future<shelf.Response> _apiDocumentationHandler(shelf.Request request) async {
  final parts = path.split(request.requestedUri.path).skip(1).toList();
  if (parts.length != 3 || parts[2].isEmpty) {
    return jsonResponse({}, status: 404);
  }
  final String package = parts[2];
  final versions = await backend.versionsOfPackage(package);
  if (versions.isEmpty) {
    return jsonResponse({}, status: 404);
  }

  versions.sort((a, b) => a.semanticVersion.compareTo(b.semanticVersion));
  String latestStableVersion = versions.last.version;
  for (int i = versions.length - 1; i >= 0; i--) {
    if (!versions[i].semanticVersion.isPreRelease) {
      latestStableVersion = versions[i].version;
      break;
    }
  }

  final dartdocEntries = await dartdocClient.getEntries(
      package, versions.map((pv) => pv.version).toList());
  final versionsData = [];

  for (int i = 0; i < versions.length; i++) {
    final entry = dartdocEntries[i];
    final hasDocumentation = entry != null && entry.hasContent;
    final status =
        entry == null ? 'awaiting' : (entry.hasContent ? 'success' : 'failed');
    versionsData.add({
      'version': versions[i].version,
      'status': status,
      'hasDocumentation': hasDocumentation,
    });
  }
  return jsonResponse({
    'name': package,
    'latestStableVersion': latestStableVersion,
    'versions': versionsData,
  });
}

/// Handles requests for /api/history
/// NOTE: Experimental, do not rely on it.
Future<shelf.Response> _apiHistoryHandler(shelf.Request request) async {
  final list = await historyBackend
      .getAll(
        scope: request.requestedUri.queryParameters['scope'],
        packageName: request.requestedUri.queryParameters['package'],
        packageVersion: request.requestedUri.queryParameters['version'],
        limit: 25,
      )
      .toList();
  return jsonResponse({
    'results': list
        .map((h) => {
              'id': h.id,
              'package': h.packageName,
              'version': h.packageVersion,
              'timestamp': h.timestamp.toIso8601String(),
              'scope': h.scope,
              'source': h.source,
              'eventType': h.eventType,
              'eventData': h.eventData,
              'markdown': h.formatMarkdown(),
            })
        .toList(),
  }, indent: true);
}

/// Handles requests for /flutter/plugins (redirects to /flutter/packages).
shelf.Response _redirectToFlutterPackages(shelf.Request request) =>
    redirectResponse('/flutter/packages');

Future<shelf.Response> _formattedNotFoundHandler(shelf.Request request) async {
  final packages = await _topPackages();
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

/// Handles requests for /api/search
Future<shelf.Response> _apiSearchHandler(shelf.Request request) async {
  final searchQuery = _parseSearchQuery(request, null);
  final sr = await searchClient.search(searchQuery);
  final packages = sr.packages.map((ps) => {'package': ps.package}).toList();
  final hasNextPage = sr.totalCount > searchQuery.limit + searchQuery.offset;
  final result = <String, dynamic>{
    'packages': packages,
  };
  if (hasNextPage) {
    final newParams =
        new Map<String, dynamic>.from(request.requestedUri.queryParameters);
    final nextPageIndex = (searchQuery.offset ~/ searchQuery.limit) + 2;
    newParams['page'] = nextPageIndex.toString();
    final nextPageUrl =
        request.requestedUri.replace(queryParameters: newParams).toString();
    result['next'] = nextPageUrl;
  }
  return jsonResponse(result);
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
