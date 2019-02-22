// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;

import '../../dartdoc/backend.dart';
import '../../history/backend.dart';
import '../../scorecard/backend.dart';
import '../../shared/dartdoc_memcache.dart';
import '../../shared/handlers.dart';
import '../../shared/packages_overrides.dart';
import '../../shared/search_client.dart';
import '../../shared/search_service.dart';

import '../backend.dart';
import '../models.dart';
import '../name_tracker.dart';

/// Handles requests for /api/documentation/<package>
Future<shelf.Response> apiDocumentationHandler(shelf.Request request) async {
  final parts = path.split(request.requestedUri.path).skip(1).toList();
  if (parts.length != 3 || parts[2].isEmpty) {
    return jsonResponse({}, status: 404, pretty: isPrettyJson(request));
  }
  final String package = parts[2];
  if (isSoftRemoved(package)) {
    return jsonResponse({}, status: 404, pretty: isPrettyJson(request));
  }

  final cachedData = await dartdocMemcache.getApiSummary(package);
  if (cachedData != null) {
    return jsonResponse(cachedData, pretty: isPrettyJson(request));
  }

  final versions = await backend.versionsOfPackage(package);
  if (versions.isEmpty) {
    return jsonResponse({}, status: 404, pretty: isPrettyJson(request));
  }

  versions.sort((a, b) => a.semanticVersion.compareTo(b.semanticVersion));
  String latestStableVersion = versions.last.version;
  for (int i = versions.length - 1; i >= 0; i--) {
    if (!versions[i].semanticVersion.isPreRelease) {
      latestStableVersion = versions[i].version;
      break;
    }
  }

  final dartdocEntries = await Future.wait(versions
      .map((pv) => dartdocBackend.getServingEntry(package, pv.version)));
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
  final data = {
    'name': package,
    'latestStableVersion': latestStableVersion,
    'versions': versionsData,
  };
  await dartdocMemcache.setApiSummary(package, data);
  return jsonResponse(data, pretty: isPrettyJson(request));
}

/// Handles requests for
/// - /api/packages?list=compact
Future<shelf.Response> apiPackagesCompactListHandler(
    shelf.Request request) async {
  final packageNames = await nameTracker.getPackageNames();
  packageNames.removeWhere(isSoftRemoved);
  return jsonResponse({'packages': packageNames},
      pretty: isPrettyJson(request));
}

/// Handles request for /api/packages?page=<num>
Future<shelf.Response> apiPackagesHandler(shelf.Request request) async {
  final int pageSize = 100;

  final int page = extractPageFromUrlParameters(request.url);

  final packages = await backend.latestPackages(
      offset: pageSize * (page - 1), limit: pageSize + 1);

  // NOTE: We queried for `PageSize+1` packages, if we get less than that, we
  // know it was the last page.
  // But we only use `PageSize` packages to display in the result.
  final List<Package> pagePackages = packages.take(pageSize).toList();
  pagePackages.removeWhere((p) => isSoftRemoved(p.name));
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

  return jsonResponse(json, pretty: isPrettyJson(request));
}

/// Whether [requestedUri] matches /api/packages/<package>/metrics
bool isHandlerForApiPackageMetrics(Uri requestedUri) {
  final requestedPath = requestedUri.path;
  final parts = requestedPath.split('/');
  return parts.length == 5 &&
      parts[0] == '' &&
      parts[1] == 'api' &&
      parts[2] == 'packages' &&
      parts[3].isNotEmpty &&
      parts[4] == 'metrics';
}

/// Handles requests for
/// - /api/packages/<package>/metrics
Future<shelf.Response> apiPackageMetricsHandler(shelf.Request request) async {
  final requestedPath = request.requestedUri.path;
  final parts = requestedPath.split('/');
  if (parts.length != 5) {
    return jsonResponse({}, status: 404, pretty: isPrettyJson(request));
  }
  final packageName = parts[3];
  final packageVersion = request.requestedUri.queryParameters['version'];
  final data =
      await scoreCardBackend.getScoreCardData(packageName, packageVersion);
  if (data == null) {
    return jsonResponse({}, status: 404, pretty: isPrettyJson(request));
  }
  final result = {
    'scorecard': data.toJson(),
  };
  if (request.requestedUri.queryParameters.containsKey('reports')) {
    final reports = await scoreCardBackend.loadReports(
      packageName,
      data.packageVersion,
      runtimeVersion: data.runtimeVersion,
    );
    result['reports'] =
        reports.map((k, report) => new MapEntry(k, report.toJson()));
  }
  return jsonResponse(result, pretty: isPrettyJson(request));
}

/// Handles requests for /api/history
/// NOTE: Experimental, do not rely on it.
Future<shelf.Response> apiHistoryHandler(shelf.Request request) async {
  final list = await historyBackend
      .getAll(
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
              'source': h.source,
              'eventType': h.eventType,
              'eventData': h.eventData,
              'markdown': h.formatMarkdown(),
            })
        .toList(),
  }, pretty: true);
}

/// Handles requests for /api/search
Future<shelf.Response> apiSearchHandler(shelf.Request request) async {
  final searchQuery = parseFrontendSearchQuery(request.requestedUri, null);
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
  return jsonResponse(result, pretty: isPrettyJson(request));
}
