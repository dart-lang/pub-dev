// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:mime/mime.dart' as mime;
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;

import '../shared/analyzer_client.dart';
import '../shared/handlers.dart';
import '../shared/platform.dart';
import '../shared/search_client.dart';
import '../shared/search_service.dart';
import '../shared/utils.dart';

import 'atom_feed.dart';
import 'backend.dart';
import 'handlers_redirects.dart';
import 'models.dart';
import 'search_memcache.dart';
import 'search_service.dart';
import 'templates.dart';

final String _staticPath = Platform.script.resolve('../../static').toFilePath();

// Non-revealing metrics to monitor the search service behavior from outside.
final _packageAnalysisLatencyTracker = new LastNTracker<Duration>();
final _packageOverallLatencyTracker = new LastNTracker<Duration>();
final _searchOverallLatencyTracker = new LastNTracker<Duration>();

/// Handler for the whole URL space of pub.dartlang.org
///
/// The passed in [shelfPubApi] handler will be used for handling requests to
///   - /api/*
Future<shelf.Response> appHandler(
    shelf.Request request, shelf.Handler shelfPubApi) async {
  final path = request.requestedUri.path;

  logPubHeaders(request);

  final handler = _handlers[path];

  if (handler != null) {
    return handler(request);
  } else if (path == '/api/packages') {
    // NOTE: This is special-cased, since it is not an API used by pub but
    // rather by the editor.
    return apiPackagesHandler(request);
  } else if (path.startsWith('/api') ||
      path.startsWith('/packages') && path.endsWith('.tar.gz')) {
    return shelfPubApi(request);
  } else if (path.startsWith('/packages/')) {
    return packageHandler(request);
  } else if (path.startsWith('/experimental/packages/')) {
    return packageHandlerV2(request);
  } else if (path.startsWith('/doc')) {
    return docHandler(request);
  } else if (path.startsWith('/static')) {
    return staticsHandler(request);
  } else {
    return _formattedNotFoundHandler(request);
  }
}

const _handlers = const <String, shelf.Handler>{
  '/': indexHandler,
  '/experimental': indexHandlerV2,
  '/experimental/': indexHandlerV2,
  '/experimental/packages': packagesHandlerHtmlV2,
  '/experimental/flutter': flutterLandingHandlerV2,
  '/experimental/flutter/packages': flutterPackagesHandlerHtmlV2,
  '/experimental/server': serverLandingHandlerV2,
  '/experimental/server/packages': serverPackagesHandlerHtmlV2,
  '/experimental/web': webLandingHandlerV2,
  '/experimental/web/packages': webPackagesHandlerHtmlV2,
  '/debug': debugHandler,
  '/feed.atom': atomFeedHandler,
  '/authorized': authorizedHandler,
  '/search': searchHandler,
  '/packages': packagesHandler,
  '/packages.json': packagesHandler,
  '/flutter': redirectToFlutterPackages,
  '/flutter/': redirectToFlutterPackages,
  '/flutter/packages': flutterPackagesHandler,
  '/flutter/plugins': redirectToFlutterPackages,
};

/// Handles requests for /debug
Future<shelf.Response> debugHandler(shelf.Request request) async {
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
Future<shelf.Response> indexHandler(_) async {
  String pageContent =
      await backend.uiPackageCache?.getUIIndexPage(false, null);
  if (pageContent == null) {
    final versions =
        await backend.latestPackageVersions(limit: 5, devVersions: true);
    assert(!versions.any((version) => version == null));
    final List<AnalysisExtract> analysisExtracts =
        await analyzerClient.getAnalysisExtracts(
            versions.map((pv) => new AnalysisKey(pv.package, pv.version)));
    pageContent = templateService.renderIndexPage(versions, analysisExtracts);
    await backend.uiPackageCache?.setUIIndexPage(false, null, pageContent);
  }
  return htmlResponse(pageContent);
}

/// Handles requests for /experimental/
Future<shelf.Response> indexHandlerV2(shelf.Request request) =>
    _indexHandlerV2(request, null);

/// Handles requests for /experimental/flutter
Future<shelf.Response> flutterLandingHandlerV2(shelf.Request request) =>
    _indexHandlerV2(request, KnownPlatforms.flutter);

/// Handles requests for /experimental/server
Future<shelf.Response> serverLandingHandlerV2(shelf.Request request) =>
    _indexHandlerV2(request, KnownPlatforms.server);

/// Handles requests for /experimental/web
Future<shelf.Response> webLandingHandlerV2(shelf.Request request) =>
    _indexHandlerV2(request, KnownPlatforms.web);

/// Handles requests for:
/// - /experimental/
/// - /experimental/flutter
/// - /experimental/server
/// - /experimental/web
Future<shelf.Response> _indexHandlerV2(
    shelf.Request request, String platform) async {
  String pageContent =
      await backend.uiPackageCache?.getUIIndexPage(true, platform);
  if (pageContent == null) {
    Future<String> searchAndRenderMiniList(SearchOrder order) async {
      final result = await searchService.search(
          new SearchQuery.parse(platform: platform, limit: 5, order: order));
      final packages = (result.packages.length <= 5)
          ? result.packages
          : result.packages.sublist(0, 5);
      return templateService.renderMiniList(packages);
    }

    Future<String> renderMiniList(Future<List<Package>> selected) async {
      final packages = await selected;
      final versions = await backend.lookupLatestVersions(packages);
      assert(!versions.any((version) => version == null));
      final List<AnalysisExtract> analysisExtracts =
          await analyzerClient.getAnalysisExtracts(
              versions.map((pv) => new AnalysisKey(pv.package, pv.version)));
      final views = new List<PackageView>.generate(versions.length, (index) {
        return new PackageView.fromModel(
          package: packages[index],
          version: versions[index],
          analysis: analysisExtracts[index],
        );
      });
      return templateService.renderMiniList(views);
    }

    final List<Future<String>> miniListFutures = [
      searchAndRenderMiniList(SearchOrder.top),
    ];
    if (platform == null) {
      miniListFutures.addAll([
        renderMiniList(backend.latestPackages(limit: 5)),
        renderMiniList(backend.newestPackages(limit: 5)),
      ]);
    } else {
      miniListFutures.addAll([
        searchAndRenderMiniList(SearchOrder.updated),
        searchAndRenderMiniList(SearchOrder.created),
      ]);
    }

    final List<String> miniListHtmls = await Future.wait(miniListFutures);
    pageContent = templateService.renderIndexPageV2(
        miniListHtmls[0], miniListHtmls[1], miniListHtmls[2], platform);
    await backend.uiPackageCache?.setUIIndexPage(true, platform, pageContent);
  }
  return htmlResponse(pageContent);
}

/// Handles requests for /feed.atom
Future<shelf.Response> atomFeedHandler(shelf.Request request) async {
  final int PageSize = 10;

  // The python version had paging support, but there was no point to it, since
  // the "next page" link was never returned to the caller.
  final int page = 1;

  final versions = await backend.latestPackageVersions(
      offset: PageSize * (page - 1), limit: PageSize);
  final feed = feedFromPackageVersions(request.requestedUri, versions);
  return atomXmlResponse(feed.toXmlDocument());
}

/// Handles requests for /authorized
shelf.Response authorizedHandler(_) =>
    htmlResponse(templateService.renderAuthorizedPage());

/// Handles requests for /doc
shelf.Response docHandler(shelf.Request request) {
  final pubDocUrl = 'https://www.dartlang.org/tools/pub/';
  final dartlangDotOrgPath = redirectPaths[request.requestedUri.path];
  if (dartlangDotOrgPath != null) {
    return redirectResponse('$pubDocUrl$dartlangDotOrgPath');
  }
  return redirectResponse(pubDocUrl);
}

/// Handles requests for /search
Future<shelf.Response> searchHandler(shelf.Request request) async {
  final Stopwatch sw = new Stopwatch();
  sw.start();

  final String cacheUrl = request.url.toString();
  final String cachedHtml = await searchMemcache?.getUiSearchPage(cacheUrl);
  if (cachedHtml != null) return htmlResponse(cachedHtml);

  final String queryText = request.url.queryParameters['q'] ?? '';
  final String platform = request.url.queryParameters['platforms'] ??
      request.url.queryParameters['platform'];

  final int page = _pageFromUrl(request.url);

  final SearchQuery query = new SearchQuery.parse(
    text: queryText,
    platform: platform,
    offset: PageLinks.resultsPerPage * (page - 1),
    limit: PageLinks.resultsPerPage,
  );
  if (!query.isValid) {
    return htmlResponse(templateService.renderSearchPage(
        new SearchResultPage.empty(query), new SearchLinks.empty(query)));
  }

  final resultPage = await searchService.search(query);
  final links = new SearchLinks(query, resultPage.totalCount);
  final String content = templateService.renderSearchPage(resultPage, links);

  _searchOverallLatencyTracker.add(sw.elapsed);

  await searchMemcache?.setUiSearchPage(cacheUrl, content);
  return htmlResponse(content);
}

/// Handles requests for /packages - multiplexes to JSON/HTML handler.
Future<shelf.Response> packagesHandler(shelf.Request request) async {
  final int page = _pageFromUrl(request.url);
  final path = request.requestedUri.path;
  if (path.endsWith('.json')) {
    return packagesHandlerJson(request, page, true);
  } else if (request.url.queryParameters['format'] == 'json') {
    return packagesHandlerJson(request, page, false);
  } else {
    return packagesHandlerHtml(request, page);
  }
}

/// Handles requests for /static
final StaticsCache staticsCache = new StaticsCache();

Future<shelf.Response> staticsHandler(shelf.Request request) async {
  // Simplifies all of '.', '..', '//'!
  final String normalized = path.normalize(request.requestedUri.path);
  if (normalized.startsWith('/static/')) {
    final assetPath = '$_staticPath/${normalized.substring('/static/'.length)}';

    final StaticFile staticFile = staticsCache.staticFiles[assetPath];
    if (staticFile != null) {
      return new shelf.Response.ok(staticFile.bytes,
          headers: {'content-type': staticFile.contentType});
    }
  }
  return _formattedNotFoundHandler(request);
}

/// Handles requests for /packages - JSON
Future<shelf.Response> packagesHandlerJson(
    shelf.Request request, int page, bool dotJsonResponse) async {
  final PageSize = 50;

  final offset = PageSize * (page - 1);
  final limit = PageSize + 1;

  final packages = await backend.latestPackages(offset: offset, limit: limit);
  final bool lastPage = packages.length < limit;

  var nextPageUrl;
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

/// Handles requests for `/packages` (default behavior) or `/flutter/packages`
/// (when [basePath] is specified) - HTML
Future<shelf.Response> packagesHandlerHtml(
  shelf.Request request,
  int page, {
  String basePath,
  String platform,
  String title,
  String faviconUrl,
  String descriptionHtml,
}) async {
  final offset = PackageLinks.resultsPerPage * (page - 1);
  final limit = PackageLinks.maxPages * PackageLinks.resultsPerPage + 1;

  List<Package> packages;
  if (platform != null) {
    final results = await searchClient.search(new SearchQuery.parse(
      platform: platform,
      order: SearchOrder.updated,
      offset: offset,
      limit: limit,
    ));
    packages =
        await backend.lookupPackages(results.packages.map((ps) => ps.package));
  } else {
    packages = await backend.latestPackages(offset: offset, limit: limit);
  }

  final links =
      new PackageLinks(offset, offset + packages.length, basePath: basePath);
  final pagePackages = packages.take(PackageLinks.resultsPerPage).toList();

  // Fetched concurrently to reduce overall latency.
  final versionsFuture = backend.lookupLatestVersions(pagePackages);
  final Future<List<AnalysisExtract>> analysisExtractsFuture =
      analyzerClient.getAnalysisExtracts(
          pagePackages.map((p) => new AnalysisKey(p.name, p.latestVersion)));

  final batchResults =
      await Future.wait([versionsFuture, analysisExtractsFuture]);
  final versions = batchResults[0];
  final List<AnalysisExtract> analysisExtracts = batchResults[1];

  final packageViews = new List.generate(
      pagePackages.length,
      (i) => new PackageView.fromModel(
            package: pagePackages[i],
            version: versions[i],
            analysis: analysisExtracts[i],
          ));

  return htmlResponse(templateService.renderPkgIndexPage(
    packageViews,
    links,
    title: title,
    faviconUrl: faviconUrl,
    descriptionHtml: descriptionHtml,
  ));
}

/// Handles /experimental/packages - package listing
Future<shelf.Response> packagesHandlerHtmlV2(shelf.Request request) =>
    _packagesHandlerHtmlV2(request, null);

/// Handles /experimental/flutter/packages
Future<shelf.Response> flutterPackagesHandlerHtmlV2(shelf.Request request) =>
    _packagesHandlerHtmlV2(request, KnownPlatforms.flutter);

/// Handles /experimental/server/packages
Future<shelf.Response> serverPackagesHandlerHtmlV2(shelf.Request request) =>
    _packagesHandlerHtmlV2(request, KnownPlatforms.server);

/// Handles /experimental/web/packages
Future<shelf.Response> webPackagesHandlerHtmlV2(shelf.Request request) =>
    _packagesHandlerHtmlV2(request, KnownPlatforms.web);

/// Handles:
/// - /experimental/packages - package listing
/// - /experimental/flutter/packages
/// - /experimental/server/packages
/// - /experimental/web/packages
Future<shelf.Response> _packagesHandlerHtmlV2(
    shelf.Request request, String platform) async {
  final int page = _pageFromUrl(request.url);
  final int offset = PackageLinks.resultsPerPage * (page - 1);
  final String queryText = request.requestedUri.queryParameters['q'] ?? '';
  final String sortParam = request.requestedUri.queryParameters['sort'];
  final SearchOrder sortOrder =
      sortParam == null ? null : parseSearchOrder(sortParam);

  int totalCount;
  List<PackageView> packageViews;
  SearchQuery searchQuery;
  if (platform != null || queryText.isNotEmpty) {
    searchQuery = new SearchQuery.parse(
        text: queryText,
        platform: platform,
        order: sortOrder,
        offset: offset,
        limit: PackageLinks.resultsPerPage);
    final effectiveQuery =
        searchQuery.change(order: sortOrder ?? SearchOrder.updated);
    final searchResult = await searchService.search(effectiveQuery);
    totalCount = searchResult.totalCount;
    packageViews = searchResult.packages;
  } else {
    final int limit = PackageLinks.maxPages * PackageLinks.resultsPerPage + 1;
    final List<Package> packages =
        await backend.latestPackages(offset: offset, limit: limit);
    totalCount = offset + packages.length;

    final List<Package> pagePackages =
        packages.take(PackageLinks.resultsPerPage).toList();
    final versionsFuture = backend.lookupLatestVersions(pagePackages);
    final analysisExtractsFuture = analyzerClient.getAnalysisExtracts(
        pagePackages.map((p) => new AnalysisKey(p.name, p.latestVersion)));

    final batchResults =
        await Future.wait([versionsFuture, analysisExtractsFuture]);
    final List<PackageVersion> versions = batchResults[0];
    final List<AnalysisExtract> analysisExtracts = batchResults[1];

    packageViews = new List.generate(
        pagePackages.length,
        (i) => new PackageView.fromModel(
              package: pagePackages[i],
              version: versions[i],
              analysis: analysisExtracts[i],
            ));
  }

  final links = new PackageLinks(offset, totalCount, searchQuery: searchQuery);
  return htmlResponse(templateService.renderPkgIndexPageV2(
    packageViews,
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
FutureOr<shelf.Response> packageHandler(shelf.Request request) {
  var path = request.requestedUri.path.substring('/packages/'.length);
  if (path.length == 0) {
    return _formattedNotFoundHandler(request);
  }

  final int slash = path.indexOf('/');
  if (slash == -1) {
    bool responseAsJson = request.url.queryParameters['format'] == 'json';
    if (path.endsWith('.json')) {
      responseAsJson = true;
      path = path.substring(0, path.length - '.json'.length);
    }
    if (responseAsJson) {
      return packageShowHandlerJson(request, Uri.decodeComponent(path));
    } else {
      return packageShowHandlerHtml(request, Uri.decodeComponent(path));
    }
  }

  final package = Uri.decodeComponent(path.substring(0, slash));
  if (path.substring(slash).startsWith('/versions')) {
    path = path.substring(slash + '/versions'.length);
    if (path.startsWith('/')) {
      if (path.endsWith('.yaml')) {
        path = path.substring(1, path.length - '.yaml'.length);
        final String version = Uri.decodeComponent(path);
        return packageVersionHandlerYaml(request, package, version);
      } else {
        path = path.substring(1);
        final String version = Uri.decodeComponent(path);
        return packageVersionHandlerHtml(request, package, version);
      }
    } else {
      return packageVersionsHandler(request, package);
    }
  }
  return _formattedNotFoundHandler(request);
}

/// Handles requests for /experimental/packages/...  - multiplexes to HTML/JSON handlers
///
/// Handles the following URLs:
///   - /packages/<package>
///   - /packages/<package>/versions
FutureOr<shelf.Response> packageHandlerV2(shelf.Request request) {
  var path =
      request.requestedUri.path.substring('/experimental/packages/'.length);
  if (path.length == 0) {
    return _formattedNotFoundHandler(request);
  }

  final int slash = path.indexOf('/');
  if (slash == -1) {
    bool responseAsJson = request.url.queryParameters['format'] == 'json';
    if (path.endsWith('.json')) {
      responseAsJson = true;
      path = path.substring(0, path.length - '.json'.length);
    }
    if (responseAsJson) {
      return packageShowHandlerJson(request, Uri.decodeComponent(path));
    } else {
      return packageVersionHandlerHtmlV2(
          request, Uri.decodeComponent(path), null);
    }
  }

  final package = Uri.decodeComponent(path.substring(0, slash));
  if (path.substring(slash).startsWith('/versions')) {
    path = path.substring(slash + '/versions'.length);
    if (path.startsWith('/')) {
      if (path.endsWith('.yaml')) {
        path = path.substring(1, path.length - '.yaml'.length);
        final String version = Uri.decodeComponent(path);
        return packageVersionHandlerYaml(request, package, version);
      } else {
        path = path.substring(1);
        final String version = Uri.decodeComponent(path);
        return packageVersionHandlerHtmlV2(request, package, version);
      }
    } else {
      return packageVersionsHandlerV2(request, package);
    }
  }
  return _formattedNotFoundHandler(request);
}

/// Handles requests for /packages/<package> - JSON
Future<shelf.Response> packageShowHandlerJson(
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

/// Handles requests for /packages/<package> - HTML
Future<shelf.Response> packageShowHandlerHtml(
    shelf.Request request, String packageName) async {
  return packageVersionHandlerHtml(request, packageName, null);
}

/// Handles requests for /packages/<package>/versions
Future<shelf.Response> packageVersionsHandler(
    shelf.Request request, String packageName) {
  return _packageVersionsHandler(
      request, packageName, templateService.renderPkgVersionsPage);
}

Future<shelf.Response> _packageVersionsHandler(
    shelf.Request request,
    String packageName,
    String render(String packageName, List<PackageVersion> versions,
        List<Uri> versionDownloadUrls)) async {
  final versions = await backend.versionsOfPackage(packageName);
  if (versions.isEmpty) return _formattedNotFoundHandler(request);

  sortPackageVersionsDesc(versions);

  final versionDownloadUrls =
      await Future.wait(versions.map((PackageVersion version) {
    return backend.downloadUrl(packageName, version.version);
  }).toList());

  return htmlResponse(render(packageName, versions, versionDownloadUrls));
}

/// Handles requests for /experimental/packages/<package>/versions
Future<shelf.Response> packageVersionsHandlerV2(
    shelf.Request request, String packageName) {
  return _packageVersionsHandler(
      request, packageName, templateService.renderPkgVersionsPageV2);
}

/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> packageVersionHandlerHtml(
    shelf.Request request, String packageName, String versionName) {
  return _packageVersionHandlerHtml(request, false, packageName, versionName,
      templateService.renderPkgShowPage);
}

Future<shelf.Response> _packageVersionHandlerHtml(
    shelf.Request request,
    bool isV2,
    String packageName,
    String versionName,
    String render(
        Package package,
        List<PackageVersion> first10Versions,
        List<Uri> versionDownloadUrls,
        PackageVersion selectedVersion,
        PackageVersion latestStableVersion,
        PackageVersion latestDevVersion,
        int totalNumberOfVersions,
        AnalysisView analysis)) async {
  final Stopwatch sw = new Stopwatch()..start();
  String cachedPage;
  if (backend.uiPackageCache != null) {
    cachedPage = await backend.uiPackageCache
        .getUIPackagePage(isV2, packageName, versionName);
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
    final AnalysisView analysisView = await analyzerClient.getAnalysisView(
        new AnalysisKey(selectedVersion.package, selectedVersion.version));
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final versionDownloadUrls =
        await Future.wait(first10Versions.map((PackageVersion version) {
      return backend.downloadUrl(packageName, version.version);
    }).toList());

    cachedPage = render(
        package,
        first10Versions,
        versionDownloadUrls,
        selectedVersion,
        latestStable,
        latestDev,
        versions.length,
        analysisView);

    if (backend.uiPackageCache != null) {
      await backend.uiPackageCache
          .setUIPackagePage(isV2, packageName, versionName, cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }

  return htmlResponse(cachedPage);
}

/// Handles requests for /experimental/packages/<package>/versions/<version>
Future<shelf.Response> packageVersionHandlerHtmlV2(
    shelf.Request request, String packageName, String versionName) {
  return _packageVersionHandlerHtml(request, true, packageName, versionName,
      templateService.renderPkgShowPageV2);
}

/// Handles requests for /packages/<package>/versions/<version>.yaml
Future<shelf.Response> packageVersionHandlerYaml(
    shelf.Request request, String package, String version) async {
  final packageVersion = await backend.lookupPackageVersion(package, version);
  if (packageVersion == null) {
    return _formattedNotFoundHandler(request);
  } else {
    return yamlResponse(packageVersion.pubspec.jsonString);
  }
}

/// Handles request for /api/packages?page=<num>
Future<shelf.Response> apiPackagesHandler(shelf.Request request) async {
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

/// Handles requests for /flutter (redirects to /flutter/packages).
shelf.Response redirectToFlutterPackages(shelf.Request request) =>
    redirectResponse('/flutter/packages');

/// Handles requests for /flutter/packages
Future<shelf.Response> flutterPackagesHandler(shelf.Request request) async {
  final int page = _pageFromUrl(request.url);
  return packagesHandlerHtml(
    request,
    page,
    basePath: '/flutter/packages',
    platform:
        new PlatformPredicate.only(KnownPlatforms.flutter).toQueryParamValue(),
    title: 'Flutter Packages',
    faviconUrl: LogoUrls.flutterLogo32x32,
    descriptionHtml: flutterPackagesDescriptionHtml,
  );
}

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

class StaticsCache {
  final Map<String, StaticFile> staticFiles = <String, StaticFile>{};

  StaticsCache() {
    final Directory staticsDirectory = new Directory(_staticPath);
    final files = staticsDirectory
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .map((file) => file.absolute);

    for (final File file in files) {
      final contentType = mime.lookupMimeType(file.path) ?? 'octet/binary';
      final bytes = file.readAsBytesSync();
      staticFiles[file.path] = new StaticFile(contentType, bytes);
    }
  }
}

class StaticFile {
  final String contentType;
  final List<int> bytes;

  StaticFile(this.contentType, this.bytes);
}
