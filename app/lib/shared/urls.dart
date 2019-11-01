// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

import '../package/overrides.dart';
import '../search/search_service.dart' show SearchQuery;
import 'versions.dart';

const primaryHost = 'pub.dev';
const legacyHost = 'pub.dartlang.org';
const fullSiteUrl = 'https://$primaryHost/';
const siteRoot = 'https://$primaryHost';
const dartSiteRoot = 'https://dart.dev';
const httpsApiDartDev = 'https://api.dart.dev/';

String pkgPageUrl(String package,
    {String version, bool includeHost = false, String fragment}) {
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

String pkgAdminUrl(String package, {String version}) =>
    pkgPageUrl(package, version: version) + '/admin';

String pkgVersionsUrl(String package) => pkgPageUrl(package) + '/versions';

String analysisTabUrl(String package) {
  final String fragment = '-analysis-tab-';
  return package == null
      ? '#$fragment'
      : pkgPageUrl(package, fragment: fragment);
}

String publisherUrl(String publisherId) => '/publishers/$publisherId';
String publisherPackagesUrl(String publisherId) =>
    SearchQuery.parse(publisherId: publisherId).toSearchLink();
String publisherAdminUrl(String publisherId) =>
    '/publishers/$publisherId/admin';

String searchUrl({String platform, String q, int page}) =>
    SearchQuery.parse(platform: platform, query: q).toSearchLink(page: page);

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
