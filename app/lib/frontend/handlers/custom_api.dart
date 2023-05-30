// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/search/search_form.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/dartdoc/models.dart';
import 'package:pub_dev/shared/count_topics.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/models.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../dartdoc/backend.dart';
import '../../frontend/request_context.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../package/name_tracker.dart';
import '../../package/overrides.dart';
import '../../scorecard/backend.dart';
import '../../search/search_client.dart';
import '../../search/search_service.dart';
import '../../shared/configuration.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart' show jsonUtf8Encoder;

import 'headers.dart';

/// Handles requests for /api/documentation/<package>
Future<shelf.Response> apiDocumentationHandler(
    shelf.Request request, String package) async {
  checkPackageVersionParams(package);
  if (isSoftRemoved(package)) {
    return jsonResponse({}, status: 404);
  }

  if (!await packageBackend.isPackageVisible(package)) {
    return jsonResponse({}, status: 404);
  }

  if (requestContext.experimentalFlags.showSandboxedOutput) {
    final status = await taskBackend.packageStatus(package);
    return jsonResponse({
      'name': package,
      'versions': status.versions.entries
          .map((e) => {
                'version': e.key,
                'status': e.value.status == PackageVersionStatus.pending ||
                        e.value.status == PackageVersionStatus.running
                    ? 'pending'
                    : (e.value.status == PackageVersionStatus.failed
                        ? 'failed'
                        : 'completed'),
                'hasDocumentation': e.value.docs,
              })
          .toList(),
    });
  }

  final cachedData = await cache.dartdocApiSummary(package).get();
  if (cachedData != null) {
    return jsonResponse(cachedData);
  }

  final versions = await packageBackend.listVersionsCached(package);
  if (versions.versions.isEmpty) {
    return jsonResponse({}, status: 404);
  }

  // Limit versions to the latest few (sorted semantically).
  final versionsToQuery = <String>{
    versions.latest.version,
    ...versions.versions.map((e) => e.version).toList().reversed.take(30),
  };

  final dartdocEntries = await dartdocBackend.getEntriesForVersions(
      package, versionsToQuery.toList());
  final dartdocEntriesMap = <String, DartdocEntry>{};
  for (final entry in dartdocEntries) {
    if (entry == null) continue;
    dartdocEntriesMap[entry.packageVersion] = entry;
  }

  final versionsData = [];
  for (int i = 0; i < versions.versions.length; i++) {
    final version = versions.versions[i].version;
    final entry = dartdocEntriesMap[version];
    final hasDocumentation = entry != null && entry.hasContent;
    final status =
        entry == null ? 'pending' : (entry.hasContent ? 'success' : 'failed');
    versionsData.add({
      'version': version,
      'status': status,
      'hasDocumentation': hasDocumentation,
    });
  }
  final data = {
    'name': package,
    'latestStableVersion': versions.latest.version,
    'versions': versionsData,
  };
  await cache.dartdocApiSummary(package).set(data);
  return jsonResponse(data);
}

/// Handles requests for
/// - /api/packages?compact=1
Future<shelf.Response> apiPackagesCompactListHandler(shelf.Request request) =>
    apiPackageNamesHandler(request);

/// Handles requests for
/// - /api/package-names
Future<shelf.Response> apiPackageNamesHandler(shelf.Request request) async {
  // only accept requests which allow gzip content encoding
  if (!request.acceptsGzipEncoding()) {
    throw NotAcceptableException('Client must accept gzip content.');
  }

  final bytes = await cache.packageNamesDataJsonGz().get(() async {
    final packageNames = await nameTracker.getVisiblePackageNames();
    packageNames.removeWhere(isSoftRemoved);

    return gzip.encode(jsonUtf8Encoder.convert({
      'packages': packageNames,
      // pagination is off for now
      'nextUrl': null,
    }));
  });

  return shelf.Response(200, body: bytes, headers: {
    ...jsonResponseHeaders,
    'Content-Encoding': 'gzip',
    ...CacheHeaders.packageNames(),
  });
}

/// Handles requests for
/// - /api/package-name-completion-data
///
/// NOTE: we don't require the `Accept: application/json` header for this request.
Future<shelf.Response> apiPackageNameCompletionDataHandler(
    shelf.Request request) async {
  // only accept requests which allow gzip content encoding
  if (!request.acceptsGzipEncoding()) {
    throw NotAcceptableException(
        'Client must send "Accept-Encoding: gzip" header');
  }

  final bytes = await cache.packageNameCompletitionDataJsonGz().get(() async {
    final rs = await searchClient.search(
      ServiceSearchQuery.parse(
        tagsPredicate: TagsPredicate.regularSearch(),
        limit: 20000,
      ),
      // Do not cache response at the search client level, as we'll be caching
      // it in a processed form much longer.
      skipCache: true,
    );

    return gzip.encode(jsonUtf8Encoder.convert({
      'packages': rs.packageHits.map((p) => p.package).toList(),
    }));
  });

  return shelf.Response(200, body: bytes, headers: {
    ...jsonResponseHeaders,
    'Content-Encoding': 'gzip',
    ...CacheHeaders.packageNameCompletion(),
  });
}

/// Handles request for /api/packages?page=<num>
Future<shelf.Response> apiPackagesHandler(shelf.Request request) async {
  final int pageSize = 100;
  final int page =
      extractPageFromUrlParameters(request.requestedUri.queryParameters);

  // Check that we're not at last page (abuse -1 as special index in cache)
  final lastPageCacheEntry = cache.apiPackagesListPage(-1);
  final lastPage = await lastPageCacheEntry.get();
  if (lastPage != null) {
    if (page > (lastPage['page'] as num)) {
      return jsonResponse({'message': 'no content'}, status: 400);
    }
  }

  final data = await cache.apiPackagesListPage(page).get(() async {
    final offset = pageSize * (page - 1);
    final allPackages = nameTracker.visiblePackagesOrderedByLastPublished;
    final packages = allPackages.skip(offset).take(pageSize).toList();
    final pageVersions = await packageBackend.lookupVersions(
      packages.map((p) =>
          QualifiedVersionKey(package: p.package, version: p.latestVersion)),
    );

    final packagesJson = [];

    final uri = activeConfiguration.primaryApiUri;
    for (final version in pageVersions.whereType<PackageVersion>()) {
      final versionString = Uri.encodeComponent(version.version!);
      final packageString = Uri.encodeComponent(version.package);

      final apiArchiveUrl = urls.pkgArchiveDownloadUrl(
          version.package, version.version!,
          baseUri: uri);
      final apiPackageUrl =
          uri!.resolve('/api/packages/$packageString').toString();
      final apiPackageVersionUrl = uri
          .resolve('/api/packages/$packageString/versions/$versionString')
          .toString();

      packagesJson.add({
        'name': version.package,
        'latest': {
          'version': version.version,
          'pubspec': version.pubspec!.asJson,

          // TODO: We should get rid of these:
          'archive_url': apiArchiveUrl,
          'package_url': apiPackageUrl,
          'url': apiPackageVersionUrl,

          // NOTE: We do not add the following
          //    - 'new_dartdoc_url'
        },
      });
    }

    final json = <String, dynamic>{
      'next_url': null,
      'packages': packagesJson,

      // NOTE: We do not add the following:
      //     - 'pages'
      //     - 'prev_url'
    };

    if (allPackages.length > offset + pageSize) {
      json['next_url'] = '${uri!.resolve('/api/packages?page=${page + 1}')}';
    } else {
      // Set the last page in cache, if not already there with a lower number.
      final lastPage = await lastPageCacheEntry.get();
      if (lastPage == null || (lastPage['page'] as int) > page) {
        await lastPageCacheEntry.set({'page': page});
      }
    }
    return json;
  });

  return jsonResponse(data!);
}

/// Handles requests for
/// - /api/packages/<package>/metrics
Future<shelf.Response> apiPackageMetricsHandler(
    shelf.Request request, String packageName) async {
  final packageVersion = request.requestedUri.queryParameters['version'];
  checkPackageVersionParams(packageName, packageVersion);
  final current = request.requestedUri.queryParameters.containsKey('current');
  final data = await scoreCardBackend.getScoreCardData(
    packageName,
    packageVersion,
    onlyCurrent: current,
    showSandboxedOutput: requestContext.experimentalFlags.showSandboxedOutput,
  );
  if (data == null) {
    return jsonResponse({}, status: 404);
  }
  final score = await packageVersionScoreHandler(request, packageName);
  final result = {
    'score': score.toJson(),
    'scorecard': data.toJson(),
  };
  return jsonResponse(result);
}

/// Handles requests for
//  - /api/packages/<package>/score
/// - /api/packages/<package>/versions/<version>/score
Future<VersionScore> packageVersionScoreHandler(
    shelf.Request request, String package,
    {String? version}) async {
  checkPackageVersionParams(package, version);
  return (await cache.versionScore(package, version).get(() async {
    final pkg = await packageBackend.lookupPackage(package);
    if (pkg == null) {
      throw NotFoundException.resource('package "$package"');
    }
    final v =
        (version == null || version == 'latest') ? pkg.latestVersion! : version;
    final pv = await packageBackend.lookupPackageVersion(package, v);
    if (pv == null) {
      throw NotFoundException.resource('package "$package" version "$version"');
    }

    var updated = pkg.updated;
    final card = await scoreCardBackend.getScoreCardData(package, v);
    if (card != null && card.updated!.isAfter(updated!)) {
      updated = card.updated;
    }

    final tags = <String>{
      ...pkg.getTags(),
      ...pv.getTags(),
      ...?card?.derivedTags,
    };

    return VersionScore(
      grantedPoints: card?.grantedPubPoints,
      maxPoints: card?.maxPubPoints,
      likeCount: pkg.likes,
      popularityScore: card?.popularityScore,
      tags: tags.toList(),
      lastUpdated: updated,
    );
  }))!;
}

/// Handles requests for
/// - /api/topic-name-completion-data
Future<shelf.Response> apiTopicNameCompletionDataHandler(
    shelf.Request request) async {
  // only accept requests which allow gzip content encoding
  if (!request.acceptsGzipEncoding()) {
    throw NotAcceptableException(
        'Client must send "Accept-Encoding: gzip" header.');
  }

  if (!request.acceptsJsonContent()) {
    throw NotAcceptableException(
        'Client must send "Accept: application/json" header.');
  }

  final bytes = await cache.topicNameCompletionDataJsonGz().get(() async {
    final data = await storageService
        .bucket(activeConfiguration.reportsBucketName!)
        .readAsBytes(topicsJsonFileName);

    return gzip.encode(data);
  });

  return shelf.Response(200, body: bytes, headers: {
    ...jsonResponseHeaders,
    'Content-Encoding': 'gzip',
    ...CacheHeaders.topicNameCompletion(),
  });
}

/// Handles requests for /api/search
Future<shelf.Response> apiSearchHandler(shelf.Request request) async {
  final searchForm = SearchForm.parse(request.requestedUri.queryParameters);
  final sr = await searchClient.search(searchForm.toServiceQuery());
  final packages = sr.packageHits.map((ps) => {'package': ps.package}).toList();
  final hasNextPage = sr.totalCount > searchForm.pageSize! + searchForm.offset;
  final result = <String, dynamic>{
    'packages': packages,
    if (sr.message != null) 'message': sr.message,
  };
  if (hasNextPage) {
    final newParams =
        Map<String, dynamic>.from(request.requestedUri.queryParameters);
    newParams['page'] = (searchForm.currentPage! + 1).toString();
    final nextPageUrl =
        request.requestedUri.replace(queryParameters: newParams).toString();
    result['next'] = nextPageUrl;
  }
  return jsonResponse(result, indentJson: requestContext.indentJson);
}

/// Handles GET /api/packages/<package>/options
Future<PkgOptions> getPackageOptionsHandler(
  shelf.Request request,
  String package,
) async {
  checkPackageVersionParams(package);
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource(package);
  }
  return PkgOptions(
    isDiscontinued: p.isDiscontinued,
    isUnlisted: p.isUnlisted,
  );
}

/// Handles PUT /api/packages/<package>/options
Future<PkgOptions> putPackageOptionsHandler(
  shelf.Request request,
  String package,
  PkgOptions options,
) async {
  await packageBackend.updateOptions(package, options);
  return await getPackageOptionsHandler(request, package);
}

/// Handles GET /api/packages/<package>/versions/<version>/options
Future<VersionOptions> getVersionOptionsHandler(
  shelf.Request request,
  String package,
  String version,
) async {
  checkPackageVersionParams(package, version);
  final pv = await packageBackend.lookupPackageVersion(package, version);
  if (pv == null) {
    throw NotFoundException.resource('$package $version');
  }
  return VersionOptions(
    isRetracted: pv.isRetracted,
  );
}

/// Handles PUT /api/packages/<package>/versions/<version>/options
Future<VersionOptions> putVersionOptionsHandler(
  shelf.Request request,
  String package,
  String version,
  VersionOptions options,
) async {
  await packageBackend.updatePackageVersionOptions(package, version, options);
  return await getVersionOptionsHandler(request, package, version);
}
