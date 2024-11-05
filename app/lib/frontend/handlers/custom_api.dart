// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/search/search_form.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/frontend/templates/views/shared/search_banner.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../frontend/request_context.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../package/name_tracker.dart';
import '../../package/overrides.dart';
import '../../scorecard/backend.dart';
import '../../search/backend.dart';
import '../../search/search_client.dart';
import '../../search/search_service.dart';
import '../../service/topics/count_topics.dart';
import '../../shared/configuration.dart';
import '../../shared/exceptions.dart';
import '../../shared/handlers.dart';
import '../../shared/redis_cache.dart' show cache;
import '../../shared/storage.dart';
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart' show jsonUtf8Encoder;
import '../../task/backend.dart';
import '../../task/models.dart';
import 'cache_control.dart';

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

  final bytes = await searchBackend.getPackageNameCompletionDataJsonGz();
  return shelf.Response(200, body: bytes, headers: {
    ...jsonResponseHeaders,
    'Content-Encoding': 'gzip',
    ...CacheControl.completionData.headers,
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
    for (final version in pageVersions.nonNulls) {
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
  final data = packageVersion == null
      ? await scoreCardBackend.getLatestFinishedScoreCardData(packageName)
      : await scoreCardBackend.getScoreCardData(packageName, packageVersion);
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
    if (updated == null || card.updated?.isAfter(updated) == true) {
      updated = card.updated;
    }

    final tags = <String>{
      ...pkg.getTags(),
      ...pv.getTags(),
      ...?card.derivedTags,
    };

    return VersionScore(
      grantedPoints: card.grantedPubPoints,
      maxPoints: card.maxPubPoints,
      likeCount: pkg.likes,
      popularityScore: card.popularityScore,
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
    ...CacheControl.completionData.headers
  });
}

/// Handles requests for
/// - /api/search-input-completion-data
Future<shelf.Response> apiSearchInputCompletionDataHandler(
  shelf.Request request,
) async {
  // only accept requests which allow JSON response
  if (!request.acceptsJsonContent()) {
    throw NotAcceptableException(
      'Client must send "Accept: application/json" header.',
    );
  }

  final bytes = await cache.searchInputCompletionDataJsonGz().get(() async {
    final topicsJson = await storageService
        .bucket(activeConfiguration.reportsBucketName!)
        .readAsBytes(topicsJsonFileName);
    final topicsMap = json.decode(utf8.decode(topicsJson));
    final topics = (topicsMap as Map<String, Object?>).keys.toList();
    return gzip.encode(utf8.encode(completionDataJson(
      topics: topics,
      licenses: _commonLicenses,
    )));
  });

  if (!request.acceptsGzipEncoding()) {
    // TODO: Consider caching non-compressed response
    // Note: We must handle non-gzipped response, as we can't set the
    //       Content-Encoding header in the browser.
    //       Though, all browsers will allow gzip :D
    return shelf.Response(200, body: gzip.decode(bytes!), headers: {
      ...jsonResponseHeaders,
      ...CacheControl.completionData.headers
    });
  }

  return shelf.Response(200, body: bytes, headers: {
    ...jsonResponseHeaders,
    'Content-Encoding': 'gzip',
    ...CacheControl.completionData.headers
  });
}

/// A hardcoded list of common licenses.
///
/// TODO: Extract a list of all licenses used from analyzed data.
const _commonLicenses = [
  '0bsd',
  'aal',
  'afl-1.1',
  'afl-1.2',
  'afl-2.0',
  'afl-2.1',
  'afl-3.0',
  'agpl-3.0',
  'apl-1.0',
  'apsl-1.0',
  'apsl-1.1',
  'apsl-1.2',
  'apsl-2.0',
  'apache-1.1',
  'apache-2.0',
  'artistic-1.0',
  'artistic-1.0-perl',
  'artistic-1.0-cl8',
  'artistic-2.0',
  'bsd-1-clause',
  'bsd-2-clause',
  'bsd-2-clause-patent',
  'bsd-3-clause',
  'bsd-3-clause-lbnl',
  'bsl-1.0',
  'cal-1.0-combined-work-exception',
  'catosl-1.1',
  'cddl-1.0',
  'cecill-2.1',
  'cern-ohl-p-2.0',
  'cern-ohl-s-2.0',
  'cern-ohl-w-2.0',
  'cnri-python',
  'cpal-1.0',
  'cpl-1.0',
  'cua-opl-1.0',
  'ecl-1.0',
  'ecl-2.0',
  'efl-1.0',
  'efl-2.0',
  'epl-1.0',
  'epl-2.0',
  'eudatagrid',
  'eupl-1.1',
  'eupl-1.2',
  'entessa',
  'fair',
  'frameworx-1.0',
  'gpl-2.0',
  'gpl-3.0',
  'hpnd',
  'ipa',
  'ipl-1.0',
  'isc',
  'intel',
  'lgpl-2.0',
  'lgpl-2.1',
  'lgpl-3.0',
  'lpl-1.0',
  'lpl-1.02',
  'lppl-1.3c',
  'liliq-p-1.1',
  'liliq-r-1.1',
  'liliq-rplus-1.1',
  'mit',
  'mit-0',
  'mit-modern-variant',
  'mpl-1.0',
  'mpl-1.1',
  'mpl-2.0',
  'ms-pl',
  'ms-rl',
  'miros',
  'motosoto',
  'mulanpsl-2.0',
  'multics',
  'nasa-1.3',
  'ncsa',
  'ngpl',
  'nposl-3.0',
  'ntp',
  'naumen',
  'nokia',
  'oclc-2.0',
  'ofl-1.1',
  'ogtsl',
  'oldap-2.8',
  'oset-pl-2.1',
  'osl-1.0',
  'osl-2.0',
  'osl-2.1',
  'osl-3.0',
  'php-3.0',
  'php-3.01',
  'postgresql',
  'python-2.0',
  'qpl-1.0',
  'rpl-1.1',
  'rpl-1.5',
  'rpsl-1.0',
  'rscpl',
  'sissl',
  'spl-1.0',
  'simpl-2.0',
  'sleepycat',
  'ucl-1.0',
  'upl-1.0',
  'unicode-dfs-2016',
  'unlicense',
  'vsl-1.0',
  'w3c',
  'watcom-1.0',
  'xnet',
  'zpl-2.0',
  'zpl-2.1',
  'zlib',
];

/// Handles requests for /api/search
Future<shelf.Response> apiSearchHandler(shelf.Request request) async {
  final searchForm = SearchForm.parse(request.requestedUri.queryParameters);
  final sr = await searchClient.search(
    searchForm.toServiceQuery(),
    sourceIp: request.sourceIp,
  );
  final packages = sr.packageHits.map((ps) => {'package': ps.package}).toList();
  final hasNextPage = sr.totalCount > searchForm.pageSize! + searchForm.offset;
  final result = <String, dynamic>{
    'packages': packages,
    if (sr.errorMessage != null) 'message': sr.errorMessage,
  };
  if (hasNextPage) {
    final newParams = {...request.requestedUri.queryParameters};
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
