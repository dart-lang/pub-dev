// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../shared/analyzer_client.dart';
import '../../shared/handlers.dart';
import '../../shared/packages_overrides.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../backend.dart';
import '../models.dart';
import '../request_context.dart';
import '../templates/package.dart';
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
  final Package package = await backend.lookupPackage(packageName);
  if (package == null) return formattedNotFoundHandler(request);

  final versions = await backend.versionsOfPackage(packageName);
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
  final package = await backend.lookupPackage(packageName);
  if (package == null) return redirectToSearch(packageName);

  final versions = await backend.versionsOfPackage(packageName);
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
    return backend.downloadUrl(packageName, version.version);
  }).toList());

  final analysis = await analyzerClient.getAnalysisView(
      latestVersion.package, latestVersion.version);

  final uploaderEmails =
      await accountBackend.getEmailsOfUserIds(package.uploaders);

  return htmlResponse(renderPkgVersionsPage(package, uploaderEmails,
      latestVersion, versions, versionDownloadUrls, analysis));
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
  final bool useCache = requestContext.uiCacheEnabled;
  if (useCache && backend.uiPackageCache != null) {
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
    final Stopwatch serviceSw = Stopwatch()..start();
    final AnalysisView analysisView = await analyzerClient.getAnalysisView(
        selectedVersion.package, selectedVersion.version);
    _packageAnalysisLatencyTracker.add(serviceSw.elapsed);

    final versionDownloadUrls =
        await Future.wait(first10Versions.map((PackageVersion version) {
      return backend.downloadUrl(packageName, version.version);
    }).toList());
    _packagePreRenderLatencyTracker.add(serviceSw.elapsed);

    final uploaderEmails =
        await accountBackend.getEmailsOfUserIds(package.uploaders);

    cachedPage = renderPkgShowPage(package, uploaderEmails, first10Versions,
        versionDownloadUrls, selectedVersion, versions.length, analysisView);
    _packageDoneLatencyTracker.add(serviceSw.elapsed);

    if (useCache && backend.uiPackageCache != null) {
      await backend.uiPackageCache
          .setUIPackagePage(packageName, versionName, cachedPage);
    }
    _packageOverallLatencyTracker.add(sw.elapsed);
  }

  return htmlResponse(cachedPage);
}
