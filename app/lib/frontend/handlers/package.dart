// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:_pub_shared/data/advisories_api.dart'
    show ListAdvisoriesResponse;
import 'package:_pub_shared/utils/dart_sdk_version.dart';
import 'package:meta/meta.dart';
import 'package:neat_cache/neat_cache.dart';
import 'package:pub_dev/frontend/handlers/headers.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/backend.dart';
import '../../account/like_backend.dart';
import '../../audit/backend.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../package/overrides.dart';
import '../../publisher/backend.dart';
import '../../scorecard/backend.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart';

import '../request_context.dart';
import '../templates/misc.dart';
import '../templates/package.dart';
import '../templates/package_admin.dart';
import '../templates/package_versions.dart';

import 'account.dart' show checkAuthenticatedPageRequest;
import 'misc.dart' show formattedNotFoundHandler;

// Non-revealing metrics to monitor the search service behavior from outside.
final _packageDataLoadLatencyTracker = DurationTracker();
final _packageDoneLatencyTracker = DurationTracker();

Map packageDebugStats() {
  return {
    'data_load_latency': _packageDataLoadLatencyTracker.toShortStat(),
    'done_latency': _packageDoneLatencyTracker.toShortStat(),
  };
}

/// Handles requests for /packages/<package> - JSON
Future<shelf.Response> packageShowHandlerJson(
    shelf.Request request, String packageName) async {
  checkPackageVersionParams(packageName);
  final package = await packageBackend.lookupPackage(packageName);
  if (package == null || package.isNotVisible) {
    return formattedNotFoundHandler(request);
  }

  final versions = await packageBackend.listVersionsCached(packageName);

  final json = {
    'name': package.name,
    // output is expected in descending versions order
    'versions': versions.descendingVersions.map((v) => v.version).toList(),
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
    assetKind: null,
    canonicalUrlFn: (p, v) => urls.pkgVersionsUrl(p),
    renderFn: (data) async {
      final versions = await packageBackend.listVersionsCached(packageName);
      if (versions.versions.isEmpty) {
        return redirectToSearch(packageName);
      }

      final dartSdkVersion =
          await getDartSdkVersion(lastKnownStable: toolStableDartSdkVersion);
      final taskStatus = await taskBackend.packageStatus(packageName);
      return renderPkgVersionsPage(
        data,
        // output is expected in descending versions order
        versions.descendingVersions,
        dartSdkVersion: dartSdkVersion.semanticVersion,
        taskStatus: taskStatus,
      );
    },
    cacheEntry: cache.uiPackageVersions(packageName),
  );
}

/// Handles requests for /packages/<package>/changelog
/// Handles requests for /packages/<package>/versions/<version>/changelog
Future<shelf.Response> packageChangelogHandler(
    shelf.Request request, String packageName,
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: AssetKind.changelog,
    canonicalUrlFn: (p, v) => urls.pkgChangelogUrl(p, version: v),
    renderFn: (data) {
      if (!data.hasChangelog) {
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
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: AssetKind.example,
    canonicalUrlFn: (p, v) => urls.pkgExampleUrl(p, version: v),
    renderFn: (data) {
      if (!data.hasExample) {
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
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: null,
    canonicalUrlFn: (p, v) => urls.pkgInstallUrl(p, version: v),
    renderFn: (data) => renderPkgInstallPage(data),
    cacheEntry: cache.uiPackageInstall(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/license
/// Handles requests for /packages/<package>/versions/<version>/license
Future<shelf.Response> packageLicenseHandler(
    shelf.Request request, String packageName,
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: AssetKind.license,
    canonicalUrlFn: (p, v) => urls.pkgLicenseUrl(p, version: v),
    renderFn: (data) => renderPkgLicensePage(data),
    cacheEntry: cache.uiPackageLicense(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/pubspec
/// Handles requests for /packages/<package>/versions/<version>/pubspec
Future<shelf.Response> packagePubspecHandler(
    shelf.Request request, String packageName,
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: AssetKind.pubspec,
    canonicalUrlFn: (p, v) => urls.pkgPubspecUrl(p, version: v),
    renderFn: (data) => renderPkgPubspecPage(data),
    cacheEntry: cache.uiPackagePubspec(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/score
/// Handles requests for /packages/<package>/versions/<version>/score
Future<shelf.Response> packageScoreHandler(
    shelf.Request request, String packageName,
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: null,
    canonicalUrlFn: (p, v) => urls.pkgScoreUrl(p, version: v),
    renderFn: (data) => renderPkgScorePage(data),
    cacheEntry: cache.uiPackageScore(packageName, versionName),
  );
}

/// Handles requests for /packages/<package>/score/log.txt
/// Handles requests for /packages/<package>/versions/<version>/score/log.txt
Future<shelf.Response> packageScoreLogTxtHandler(
  shelf.Request request,
  String package, {
  String? version,
}) async {
  checkPackageVersionParams(package, version);
  if (redirectPackageUrls.containsKey(package)) {
    return redirectResponse(redirectPackageUrls[package]!);
  }
  if (!await packageBackend.isPackageVisible(package)) {
    return shelf.Response.notFound('no such package');
  }
  version ??= (await packageBackend.getLatestVersion(package));
  if (version == null) {
    return shelf.Response.notFound('no such package');
  }
  final log = await taskBackend.taskLog(package, version);
  return shelf.Response(
    log == null ? 404 : 200,
    body: log ?? 'no log',
    headers: {
      'content-type': 'text/plain;charset=UTF-8',
    },
  );
}

/// Handles requests for /packages/<package>
/// Handles requests for /packages/<package>/versions/<version>
Future<shelf.Response> packageVersionHandlerHtml(
    shelf.Request request, String packageName,
    {String? versionName}) async {
  return await _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: versionName,
    assetKind: AssetKind.readme,
    canonicalUrlFn: (p, v) => urls.pkgReadmeUrl(p, version: v),
    renderFn: (data) => renderPkgShowPage(data),
    cacheEntry: cache.uiPackagePage(packageName, versionName),
  );
}

Future<shelf.Response> _handlePackagePage({
  required shelf.Request request,
  required String packageName,
  required String? versionName,
  required String? assetKind,
  required String Function(String package, String? version) canonicalUrlFn,
  required FutureOr Function(PackagePageData data) renderFn,
  Entry<String>? cacheEntry,
}) async {
  checkPackageVersionParams(packageName, versionName);

  final canonicalUrl = canonicalUrlFn(
    await _canonicalPackageName(packageName),
    canonicalizeVersion(versionName) ?? versionName,
  );
  if (request.requestedUri.path != canonicalUrl) {
    return redirectResponse(canonicalUrl);
  }
  if (redirectPackageUrls.containsKey(packageName)) {
    return redirectResponse(redirectPackageUrls[packageName]!);
  }
  final Stopwatch sw = Stopwatch()..start();
  String? cachedPage;
  if (requestContext.uiCacheEnabled && cacheEntry != null) {
    cachedPage = await cacheEntry.get();
  }

  if (cachedPage == null) {
    final package = await packageBackend.lookupPackage(packageName);
    if (package == null || !package.isVisible) {
      if (package?.isModerated ?? false) {
        final content = renderModeratedPackagePage(packageName);
        return htmlResponse(content, status: 404);
      }
      if (await packageBackend.isPackageModerated(packageName)) {
        final content = renderModeratedPackagePage(packageName);
        return htmlResponse(content, status: 404);
      } else {
        return formattedNotFoundHandler(request);
      }
    }
    final serviceSw = Stopwatch()..start();
    late PackagePageData data;
    try {
      data = await loadPackagePageData(package, versionName, assetKind);
    } on NotFoundException {
      return formattedNotFoundHandler(request);
    }
    _packageDataLoadLatencyTracker.add(serviceSw.elapsed);
    final renderedResult = await renderFn(data);
    if (renderedResult is String) {
      cachedPage = renderedResult;
    } else if (renderedResult is shelf.Response) {
      return renderedResult;
    } else {
      throw StateError('Unknown result type: ${renderedResult.runtimeType}');
    }
    if (requestContext.uiCacheEnabled && cacheEntry != null) {
      await cacheEntry.set(cachedPage);
    }
    _packageDoneLatencyTracker.add(sw.elapsed);
  }
  return htmlResponse(cachedPage);
}

/// Returns the optionally lowercased version of [name], but only if there
/// is no package with exact [name], and there exists a package with its
/// lowercased version.
Future<String> _canonicalPackageName(String name) async {
  final lowerName = name.toLowerCase();
  if (name == lowerName) {
    return name;
  }
  if (await packageBackend.isPackageVisible(name)) {
    return name;
  }
  if (await packageBackend.isPackageVisible(lowerName)) {
    return lowerName;
  }
  return name;
}

/// Handles requests for /packages/<package>/admin
/// Handles requests for /packages/<package>/versions/<version>/admin
Future<shelf.Response> packageAdminHandler(
    shelf.Request request, String packageName) async {
  return _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: null,
    assetKind: null,
    canonicalUrlFn: (p, v) => urls.pkgAdminUrl(p),
    renderFn: (data) async {
      final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
      if (unauthenticatedRs != null) {
        return unauthenticatedRs;
      }
      if (!data.isAdmin) {
        return htmlResponse(renderUnauthorizedPage());
      }
      final page = await publisherBackend
          .listPublishersForUser(requestContext.authenticatedUserId!);
      final uploaderEmails = await accountBackend
          .lookupUsersById(data.package.uploaders ?? <String>[]);
      final retractableVersions =
          await packageBackend.listRetractableVersions(packageName);
      final retractedVersions =
          await packageBackend.listRecentlyRetractedVersions(packageName);
      return renderPkgAdminPage(
        data,
        page.publishers!.map((p) => p.publisherId).toList(),
        uploaderEmails.cast(),
        retractableVersions.map((v) => v.id!).toList(),
        retractedVersions.map((v) => v.id!).toList(),
      );
    },
  );
}

/// Handles requests for /packages/<package>/activity-log
Future<shelf.Response> packageActivityLogHandler(
    shelf.Request request, String packageName) async {
  return _handlePackagePage(
    request: request,
    packageName: packageName,
    versionName: null,
    assetKind: null,
    canonicalUrlFn: (p, v) => urls.pkgActivityLogUrl(p),
    renderFn: (data) async {
      final unauthenticatedRs = await checkAuthenticatedPageRequest(request);
      if (unauthenticatedRs != null) {
        return unauthenticatedRs;
      }
      if (!data.isAdmin) {
        return htmlResponse(renderUnauthorizedPage());
      }
      final before = auditBackend.parseBeforeQueryParameter(
          request.requestedUri.queryParameters['before']);
      final activities = await auditBackend.listRecordsForPackage(
        packageName,
        before: before,
      );
      return renderPkgActivityLogPage(data, activities);
    },
  );
}

@visibleForTesting
Future<PackagePageData> loadPackagePageData(
  Package package,
  String? versionName,
  String? assetKind,
) async {
  final packageName = package.name!;
  versionName ??= package.latestVersion;

  final latestReleasesFuture = packageBackend.latestReleases(package);

  final isLikedFuture = Future(() async {
    if (requestContext.isNotAuthenticated) {
      return false;
    }
    final likeStatus = await likeBackend.getPackageLikeStatus(
      requestContext.authenticatedUserId!,
      package.name!,
    );
    return likeStatus != null;
  });

  final selectedVersionFuture =
      packageBackend.lookupPackageVersion(packageName, versionName!);
  final versionInfoFuture =
      packageBackend.lookupPackageVersionInfo(packageName, versionName);

  final assetFuture = assetKind == null
      ? Future.value(null)
      : packageBackend.lookupPackageVersionAsset(
          packageName,
          versionName,
          assetKind,
        );

  final isAdminFuture = requestContext.isNotAuthenticated
      ? Future.value(false)
      : packageBackend.isPackageAdmin(
          package,
          requestContext.authenticatedUserId!,
        );

  final scoreCardFuture = scoreCardBackend
      .getScoreCardData(packageName, versionName, package: package);

  await Future.wait([
    latestReleasesFuture,
    isLikedFuture,
    selectedVersionFuture,
    versionInfoFuture,
    assetFuture,
    isAdminFuture,
    scoreCardFuture,
  ]);

  final selectedVersion = await selectedVersionFuture;
  if (selectedVersion == null) {
    throw NotFoundException.resource(
        'package "$packageName" version "$versionName"');
  }

  final versionInfo = await versionInfoFuture;
  if (versionInfo == null) {
    throw NotFoundException.resource(
        'package "$packageName" version "$versionName"');
  }

  return PackagePageData(
    package: package,
    latestReleases: await latestReleasesFuture,
    version: selectedVersion,
    versionInfo: versionInfo,
    asset: await assetFuture,
    scoreCard: await scoreCardFuture,
    isAdmin: await isAdminFuture,
    isLiked: await isLikedFuture,
  );
}

/// Handles /api/packages/<package> requests.
Future<shelf.Response> listVersionsHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);

  var body = await packageBackend.listVersionsGzCachedBytes(package);
  final supportsGzip = request.acceptsGzipEncoding();
  if (!supportsGzip) {
    body = gzip.decode(body);
  }
  return shelf.Response(
    200,
    body: body,
    headers: {
      'vary': 'Accept-Encoding', // body varies depending on accept-encoding!
      if (supportsGzip) 'content-encoding': 'gzip',
      'content-type': 'application/json; charset="utf-8"',
      'x-content-type-options': 'nosniff',
      ...CacheHeaders.versionListingApi(),
    },
  );
}

/// Handles requests for /packages/<package>/publisher
Future<shelf.Response> packagePublisherHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);
  final info = await packageBackend.getPublisherInfo(package);
  final publisherId = info.publisherId;
  final redirectUrl = publisherId == null
      ? urls.pkgPageUrl(package)
      : urls.publisherUrl(publisherId);
  return redirectResponse(redirectUrl);
}

/// Handles GET /api/packages/<package>/advisories
Future<ListAdvisoriesResponse> listAdvisoriesForPackage(
    shelf.Request request, String packageName) async {
  InvalidInputException.checkPackageName(packageName);
  final package = await packageBackend.lookupPackage(packageName);
  if (package == null) {
    throw NotFoundException.resource(packageName);
  }

  final advisories =
      await securityAdvisoryBackend.lookupSecurityAdvisories(packageName);
  if (advisories.isEmpty) {
    return ListAdvisoriesResponse(advisories: []);
  }
  final advisoriesUpdated = advisories.fold(
      advisories.first.syncTime,
      (previousValue, advisory) => advisory.syncTime.isAfter(previousValue)
          ? advisory.syncTime
          : previousValue);
  return ListAdvisoriesResponse(
      advisories: advisories.map((e) => e.advisory).toList(),
      advisoriesUpdated: advisoriesUpdated);
}
