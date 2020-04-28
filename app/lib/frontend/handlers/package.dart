// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:neat_cache/neat_cache.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../analyzer/analyzer_client.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../package/overrides.dart';
import '../../publisher/backend.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../request_context.dart';
import '../templates/misc.dart';
import '../templates/package.dart';
import '../templates/package_admin.dart';
import '../templates/package_versions.dart';

import 'misc.dart' show formattedNotFoundHandler;

// Non-revealing metrics to monitor the search service behavior from outside.
final _packageAnalysisLatencyTracker = DurationTracker();
final _packagePreRenderLatencyTracker = DurationTracker();
final _packageDoneLatencyTracker = DurationTracker();
final _packageOverallLatencyTracker = DurationTracker();

Map packageDebugStats() {
  return {
    'analysis_latency': _packageAnalysisLatencyTracker.toShortStat(),
    'pre_render_latency': _packagePreRenderLatencyTracker.toShortStat(),
    'done_latency': _packageDoneLatencyTracker.toShortStat(),
    'overall_latency': _packageOverallLatencyTracker.toShortStat(),
  };
}

/// Handles requests for /packages/<package> - JSON
Future<shelf.Response> packageShowHandlerJson(
    shelf.Request request, String packageName) async {
  final Package package = await packageBackend.lookupPackage(packageName);
  if (package == null) return formattedNotFoundHandler(request);

  final versions = await packageBackend.versionsOfPackage(packageName);
  sortPackageVersionsDesc(versions, decreasing: false);

  final uploaderEmails =
      await accountBackend.getEmailsOfUserIds(package.uploaders);

  final json = {
    'name': package.name,
    'uploaders': uploaderEmails,
    'versions':
        versions.map((packageVersion) => packageVersion.version).toList(),
  };
  return jsonResponse(json);
}

/// Handles requests for /packages/<package>/versions
Future<shelf.Response> packageVersionsListHandler(
    shelf.Request request, String packageName) async {
  return _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: null,
    renderFn: (data) async {
      final versions = await packageBackend.versionsOfPackage(packageName);
      if (versions.isEmpty) {
        return redirectToSearch(packageName);
      }

      sortPackageVersionsDesc(versions);
      final versionDownloadUrls =
          await Future.wait(versions.map((PackageVersion version) {
        return packageBackend.downloadUrl(packageName, version.version);
      }).toList());

      return renderPkgVersionsPage(data, versions, versionDownloadUrls);
    },
  );
}

/// Handles requests for /packages/<package>/changelog
/// Handles requests for /packages/<package>/versions/<version>/changelog
Future<shelf.Response> packageChangelogHandler(
    shelf.Request request, String packageName,
    {String versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    renderFn: (data) {
      if (data.version.changelog == null) {
        return redirectResponse(
            urls.pkgPageUrl(packageName, version: versionName));
      }
      return renderPkgChangelogPage(data);
    },
    cacheEntry: cache.uiPackageChangelog(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/example
/// Handles requests for /packages/<package>/versions/<version>/example
Future<shelf.Response> packageExampleHandler(
    shelf.Request request, String packageName,
    {String versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    renderFn: (data) {
      if (data.version.example == null) {
        return redirectResponse(
            urls.pkgPageUrl(packageName, version: versionName));
      }
      return renderPkgExamplePage(data);
    },
    cacheEntry: cache.uiPackageExample(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/install
/// Handles requests for /packages/<package>/versions/<version>/install
Future<shelf.Response> packageInstallHandler(
    shelf.Request request, String packageName,
    {String versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    renderFn: (data) => renderPkgInstallPage(data),
    cacheEntry: cache.uiPackageInstall(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/score
/// Handles requests for /packages/<package>/versions/<version>/score
Future<shelf.Response> packageScoreHandler(
    shelf.Request request, String packageName,
    {String versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    renderFn: (data) => renderPkgScorePage(data),
    cacheEntry: cache.uiPackageScore(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>
/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> packageVersionHandlerHtml(
    shelf.Request request, String packageName,
    {String versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    renderFn: (data) => renderPkgShowPage(data),
    cacheEntry: cache.uiPackagePage(packageName, versionName),
  );
}

Future<shelf.Response> _handlePackagePage({
  @required shelf.Request request,
  @required String packageName,
  @required String versionName,
  @required FutureOr Function(PackagePageData data) renderFn,
  Entry<String> cacheEntry,
}) async {
  if (redirectPackagePages.containsKey(packageName)) {
    return redirectResponse(redirectPackagePages[packageName]);
  }
  final Stopwatch sw = Stopwatch()..start();
  String cachedPage;
  if (requestContext.uiCacheEnabled && cacheEntry != null) {
    cachedPage = await cacheEntry.get();
  }

  if (cachedPage == null) {
    final serviceSw = Stopwatch()..start();
    final data = await _loadPackagePageData(packageName, versionName);
    if (data == null) {
      return redirectToSearch(packageName);
    }
    if (data.version == null) {
      return redirectResponse(urls.pkgVersionsUrl(packageName));
    }
    final renderedResult = await renderFn(data);
    if (renderedResult is String) {
      cachedPage = renderedResult;
    } else if (renderedResult is shelf.Response) {
      return renderedResult;
    } else {
      throw StateError('Unknown result type: ${renderedResult.runtimeType}');
    }
    _packageDoneLatencyTracker.add(serviceSw.elapsed);
    if (requestContext.uiCacheEnabled && cacheEntry != null) {
      await cacheEntry.set(cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }
  return htmlResponse(cachedPage);
}

/// Handles requests for /packages/<package>/admin
/// Handles requests for /packages/<package>/versions/<version>/admin
Future<shelf.Response> packageAdminHandler(
    shelf.Request request, String packageName) async {
  return _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: null,
    renderFn: (data) async {
      if (userSessionData == null) {
        return htmlResponse(renderUnauthenticatedPage());
      }
      if (!data.isAdmin) {
        return htmlResponse(renderUnauthorizedPage());
      }
      final publishers =
          await publisherBackend.listPublishersForUser(userSessionData.userId);
      return renderPkgAdminPage(
          data, publishers.map((p) => p.publisherId).toList());
    },
  );
}

Future<PackagePageData> _loadPackagePageData(
    String packageName, String versionName) async {
  final package = await packageBackend.lookupPackage(packageName);
  if (package == null) return null;

  final bool isLiked = (userSessionData == null)
      ? false
      : await accountBackend.getPackageLikeStatus(
              userSessionData.userId, package.name) !=
          null;

  final selectedVersion = await packageBackend.lookupPackageVersion(
      packageName, versionName ?? package.latestVersion);
  if (selectedVersion == null) {
    return PackagePageData.missingVersion(package: package);
  }

  final analysisView = await analyzerClient.getAnalysisView(
      selectedVersion.package, selectedVersion.version);

  final uploaderEmails =
      await accountBackend.getEmailsOfUserIds(package.uploaders);

  final isAdmin =
      await packageBackend.isPackageAdmin(package, userSessionData?.userId);

  return PackagePageData(
    package: package,
    version: selectedVersion,
    analysis: analysisView,
    uploaderEmails: uploaderEmails,
    isAdmin: isAdmin,
    isLiked: isLiked,
  );
}

/// Handles /api/packages/<package> requests.
Future<shelf.Response> listVersionsHandler(
    shelf.Request request, Uri baseUri, String package) async {
  final body = await cache.packageData(package).get(() async {
    final data = await packageBackend.listVersions(baseUri, package);
    return utf8.encode(json.encode(data.toJson()));
  });
  return shelf.Response(200, body: body, headers: {
    'content-type': 'application/json; charset="utf-8"',
    'x-content-type-options': 'nosniff',
  });
}
