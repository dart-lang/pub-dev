// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

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
  final package = await packageBackend.lookupPackage(packageName);
  if (package == null) return redirectToSearch(packageName);

  final versions = await packageBackend.versionsOfPackage(packageName);
  if (versions.isEmpty) {
    return redirectToSearch(packageName);
  }

  sortPackageVersionsDesc(versions);
  PackageVersion latestVersion = versions.firstWhere(
      (v) => v.version == package.latestVersion,
      orElse: () => null);
  latestVersion ??= versions.firstWhere(
      (v) => v.version == package.latestDevVersion,
      orElse: () => null);
  latestVersion ??= versions.first;

  final versionDownloadUrls =
      await Future.wait(versions.map((PackageVersion version) {
    return packageBackend.downloadUrl(packageName, version.version);
  }).toList());

  final analysis = await analyzerClient.getAnalysisView(
      latestVersion.package, latestVersion.version);

  final uploaderEmails =
      await accountBackend.getEmailsOfUserIds(package.uploaders);

  final isAdmin =
      await packageBackend.isPackageAdmin(package, userSessionData?.userId);

  final bool isLiked = (userSessionData == null)
      ? false
      : await accountBackend.getPackageLikeStatus(
              await accountBackend.lookupUserById(userSessionData?.userId),
              package.name) !=
          null;

  return htmlResponse(renderPkgVersionsPage(
    package,
    isLiked,
    uploaderEmails,
    latestVersion,
    versions,
    versionDownloadUrls,
    analysis,
    isAdmin: isAdmin,
  ));
}

/// Handles requests for /packages/<package>
/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> packageVersionHandlerHtml(
    shelf.Request request, String packageName,
    {String versionName}) async {
  if (redirectPackagePages.containsKey(packageName)) {
    return redirectResponse(redirectPackagePages[packageName]);
  }
  final Stopwatch sw = Stopwatch()..start();
  String cachedPage;
  if (requestContext.uiCacheEnabled) {
    cachedPage = await cache.uiPackagePage(packageName, versionName).get();
  }

  if (cachedPage == null) {
    final Package package = await packageBackend.lookupPackage(packageName);

    final bool isLiked = (userSessionData == null)
        ? false
        : await accountBackend.getPackageLikeStatus(
                await accountBackend.lookupUserById(userSessionData?.userId),
                package.name) !=
            null;
    if (package == null) {
      return redirectToSearch(packageName);
    }

    final selectedVersion = await packageBackend.lookupPackageVersion(
        packageName, versionName ?? package.latestVersion);
    if (selectedVersion == null) {
      return redirectResponse(urls.pkgVersionsUrl(packageName));
    }

    final Stopwatch serviceSw = Stopwatch()..start();
    final AnalysisView analysisView = await analyzerClient.getAnalysisView(
        selectedVersion.package, selectedVersion.version);
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);
    _packagePreRenderLatencyTracker.add(serviceSw.elapsed);

    final isAdmin =
        await packageBackend.isPackageAdmin(package, userSessionData?.userId);

    cachedPage = renderPkgShowPage(
      package,
      isLiked,
      uploaderEmails,
      selectedVersion,
      analysisView,
      isAdmin: isAdmin,
    );
    _packageDoneLatencyTracker.add(serviceSw.elapsed);

    if (requestContext.uiCacheEnabled) {
      await cache.uiPackagePage(packageName, versionName).set(cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }

  return htmlResponse(cachedPage);
}

/// Handles requests for /packages/<package>/admin
/// Handles requests for /packages/<package>/versions/<version>/admin
Future<shelf.Response> packageAdminHandler(
    shelf.Request request, String packageName) async {
  if (redirectPackagePages.containsKey(packageName)) {
    return redirectResponse(redirectPackagePages[packageName]);
  }
  final package = await packageBackend.lookupPackage(packageName);
  if (package == null) return redirectToSearch(packageName);

  final version = await packageBackend.lookupPackageVersion(
      packageName, package.latestVersion);
  if (version == null) {
    return redirectResponse(urls.pkgVersionsUrl(packageName));
  }

  if (userSessionData == null) {
    return htmlResponse(renderUnauthenticatedPage());
  }

  final isAdmin =
      await packageBackend.isPackageAdmin(package, userSessionData?.userId);
  if (!isAdmin) {
    return htmlResponse(renderUnauthorizedPage());
  }

  final uploaderEmails =
      await accountBackend.getEmailsOfUserIds(package.uploaders);
  final analysis =
      await analyzerClient.getAnalysisView(version.package, version.version);
  final publishers =
      await publisherBackend.listPublishersForUser(userSessionData.userId);

  return htmlResponse(renderPkgAdminPage(
    package,
    uploaderEmails,
    version,
    analysis,
    publishers.map((p) => p.publisherId).toList(),
  ));
}
