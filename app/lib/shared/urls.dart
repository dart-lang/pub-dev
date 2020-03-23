// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

import '../frontend/request_context.dart' show requestContext;
import '../package/overrides.dart';
import '../search/search_service.dart' show SearchOrder, SearchQuery;
import 'versions.dart';

export '../search/search_service.dart' show SearchOrder;

const primaryHost = 'pub.dev';
const legacyHost = 'pub.dartlang.org';
const fullSiteUrl = 'https://$primaryHost/';
const siteRoot = 'https://$primaryHost';
const dartSiteRoot = 'https://dart.dev';
const httpsApiDartDev = 'https://api.dart.dev/';

String pkgPageUrl(
  String package, {
  String version,
  bool includeHost = false,
  String fragment,
}) {
  String url = includeHost ? siteRoot : '';
  url += '/packages/$package';
  if (version != null) {
    url += '/versions/$version';
  }
  if (fragment != null) {
    url += '#$fragment';
  }
  return url;
}

String pkgReadmeUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version);

String pkgChangelogUrl(String package, {String version}) =>
    requestContext.isExperimental
        ? pkgPageUrl(package, version: version) + '/changelog'
        : pkgPageUrl(package, version: version, fragment: '-changelog-tab-');

String pkgExampleUrl(String package, {String version}) =>
    requestContext.isExperimental
        ? pkgPageUrl(package, version: version) + '/example'
        : pkgPageUrl(package, version: version, fragment: '-example-tab-');

String pkgInstallUrl(String package, {String version}) =>
    requestContext.isExperimental
        ? pkgPageUrl(package, version: version) + '/install'
        : pkgPageUrl(package, version: version, fragment: '-installing-tab-');

String pkgVersionsUrl(String package) => pkgPageUrl(package) + '/versions';

String pkgScoreUrl(String package, {String version}) =>
    requestContext.isExperimental
        ? pkgPageUrl(package, version: version) + '/score'
        : pkgPageUrl(package, version: version, fragment: '-analysis-tab-');

String pkgAdminUrl(String package) => pkgPageUrl(package) + '/admin';

String pkgArchiveDownloadUrl(String package, String version, {Uri baseUri}) {
  final path =
      '/packages/${Uri.encodeComponent(package)}/versions/${Uri.encodeComponent(version)}.tar.gz';
  if (baseUri == null) {
    return path;
  } else {
    return baseUri.resolve(path).toString();
  }
}

String pkgDocUrl(
  String package, {
  String version,
  bool includeHost = false,
  String relativePath,
  bool omitTrailingSlash = false,
  bool isLatest = false,
}) {
  String url = includeHost ? siteRoot : '';
  url += '/documentation/$package';
  if (isLatest) {
    version = 'latest';
  }
  if (version != null) {
    url += '/$version';
  }
  if (relativePath != null) {
    url = p.join(url, relativePath);
  } else if (!omitTrailingSlash) {
    url = '$url/';
  }
  if (url.endsWith('/index.html')) {
    url = url.substring(0, url.length - 'index.html'.length);
  }
  if (omitTrailingSlash && url.endsWith('/')) {
    url = url.substring(0, url.length - 1);
  }
  return url;
}

String publisherUrl(String publisherId) => '/publishers/$publisherId';
String publisherPackagesUrl(String publisherId) =>
    SearchQuery.parse(publisherId: publisherId).toSearchLink();
String publisherAdminUrl(String publisherId) =>
    '/publishers/$publisherId/admin';

String searchUrl({
  String sdk,
  List<String> runtimes,
  List<String> platforms,
  String q,
  int page,
  SearchOrder order,
}) {
  final query = SearchQuery.parse(
    sdk: sdk,
    runtimes: runtimes,
    platforms: platforms,
    query: q,
    order: order,
  );
  return query.toSearchLink(page: page);
}

String dartSdkMainUrl(String version) {
  final isDev = version.contains('dev');
  final channel = isDev ? 'dev' : 'stable';
  final url = p.join(httpsApiDartDev, channel, version);
  return '$url/';
}

/// Parses GitHub and GitLab urls, and returns the root of the repository.
String inferRepositoryUrl(String baseUrl) {
  if (baseUrl == null) {
    return null;
  }
  final uri = Uri.tryParse(baseUrl);
  if (uri == null) {
    return null;
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    return null;
  }
  if (uri.hasPort) {
    return null;
  }
  if (uri.host == 'github.com' || uri.host == 'gitlab.com') {
    final segments = uri.pathSegments.take(2).toList();
    if (segments.length != 2) {
      return null;
    }
    return Uri(scheme: uri.scheme, host: uri.host, pathSegments: segments)
        .toString();
  }
  return null;
}

/// Parses GitHub and GitLab urls, and returns the issue tracker of the repository.
String inferIssueTrackerUrl(String baseUrl) {
  if (baseUrl == null) {
    return null;
  }
  final uri = Uri.tryParse(baseUrl);
  if (uri == null) {
    return null;
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    return null;
  }
  if (uri.hasPort) {
    return null;
  }
  if (uri.host == 'github.com' || uri.host == 'gitlab.com') {
    final segments = uri.pathSegments.take(2).toList();
    if (segments.length != 2) {
      return null;
    }
    segments.add('issues');
    final url = Uri(
      scheme: 'https',
      host: uri.host,
      pathSegments: segments,
    ).toString();
    return overrideIssueTrackerUrl(url);
  }
  return null;
}

/// Infer base URL that can be used to link files from.
String inferBaseUrl({String homepageUrl, String repositoryUrl}) {
  String baseUrl = repositoryUrl ?? homepageUrl;
  if (baseUrl == null) return null;

  // In a few cases people specify only a deep repository URL for their
  // package (e.g. a monorepo for multiple packages). While we default the
  // base URL to be the repository URL, this check allows us to use the deep
  // URL for linking.
  if (homepageUrl != null && homepageUrl.startsWith(baseUrl)) {
    baseUrl = homepageUrl;
  }

  // URL cleanup
  final prefixReplacements = const <String, String>{
    'http://github.com/': 'https://github.com/',
    'http://www.github.com/': 'https://github.com/',
    'https://www.github.com/': 'https://github.com/',
    'http://gitlab.com/': 'https://gitlab.com/',
    'http://www.gitlab.com/': 'https://gitlab.com/',
    'https://www.gitlab.com/': 'https://gitlab.com/',
  };
  for (final prefix in prefixReplacements.keys) {
    if (baseUrl.startsWith(prefix)) {
      baseUrl = baseUrl.replaceFirst(prefix, prefixReplacements[prefix]);
    }
  }
  if ((baseUrl.startsWith('https://github.com/') ||
          baseUrl.startsWith('https://gitlab.com/')) &&
      baseUrl.endsWith('.git')) {
    baseUrl = baseUrl.substring(0, baseUrl.length - 4);
  }

  return baseUrl;
}

/// Infer the hosting/service provider for a given URL.
String inferServiceProviderName(String url) {
  if (url == null) {
    return null;
  }
  if (url.startsWith('https://github.com/')) {
    return 'GitHub';
  }
  if (url.startsWith('https://gitlab.com/')) {
    return 'GitLab';
  }
  return null;
}

String panaUrl() {
  return '$siteRoot/packages/pana';
}

/// Returns the versioned documentation URL for pana's maintenance suggestions.
String panaMaintenanceUrl() {
  return '$siteRoot/documentation/pana/$panaVersion/#maintenance-score';
}

/// Returns the consent URL that will be sent to the invited user.
String consentUrl(String consentId) => '$siteRoot/consent?id=$consentId';

/// Return true if the user-provided `documentation` URL should not be shown.
bool hideUserProvidedDocUrl(String url) {
  if (url == null || url.isEmpty) return true;
  final uri = Uri.parse(url);
  if (uri == null) return true;
  if (uri.scheme != 'http' && uri.scheme != 'https') return true;
  final host = uri.host.toLowerCase();
  return host == 'dartdocs.org' ||
      host == 'www.dartdocs.org' ||
      host == 'pub.dartlang.org' ||
      host == 'pub.dev';
}

/// Returns the [url] in a format that will be displayed on the user-facing
/// website.
/// - https:// prefixes are stripped down
/// - TODO: consider stripping long URLs
String displayableUrl(String url) {
  if (url == null) {
    return null;
  }
  if (url.startsWith('https://')) {
    url = url.substring('https://'.length);
  }
  return url;
}

String myPackagesUrl() => '/my-packages';
String myLikedPackagesUrl() => '/my-liked-packages';
String myPublishersUrl() => '/my-publishers';
String createPublisherUrl() => '/create-publisher';
