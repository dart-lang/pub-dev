// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:pub_server/repository.dart' show GenericProcessingException;

import 'packages_overrides.dart';
import 'versions.dart';

const _pubDartlangOrg = 'pub.dartlang.org';
const _pubDev = 'pub.dev';
const _apiPubDev = 'api.pub.dev';

const siteRoot = 'https://$_pubDartlangOrg';
const _apiDartlangOrg = 'https://api.dartlang.org/';

bool isProductionHost(String host) {
  return host == _pubDartlangOrg || host == _pubDev || host == _apiPubDev;
}

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

String pkgVersionsUrl(String package) => pkgPageUrl(package) + '/versions';

String versionsTabUrl(String package) =>
    pkgPageUrl(package, fragment: '-versions-tab-');

String analysisTabUrl(String package) {
  final String fragment = '-analysis-tab-';
  return package == null
      ? '#$fragment'
      : pkgPageUrl(package, fragment: fragment);
}

String searchUrl({String platform, String q, int page}) {
  final packagesPath = platform == null ? '/packages' : '/$platform/packages';
  final params = <String, String>{};
  if (q != null && q.isNotEmpty) {
    params['q'] = q;
  }
  if (page != null && page > 1) {
    params['page'] = page.toString();
  }
  return Uri(
    path: packagesPath,
    queryParameters: params.isEmpty ? null : params,
  ).toString();
}

String pkgInviteUrl({
  @required String type,
  @required String package,
  @required String email,
  @required String urlNonce,
}) {
  return Uri(
    scheme: 'https',
    host: _pubDartlangOrg,
    path: p.join('/admin/confirm', type, package, email, urlNonce),
  ).toString();
}

final _invalidHostNames = const <String>[
  '..',
  '...',
  'example.com',
  'example.org',
  'example.net',
  'www.example.com',
  'www.example.org',
  'www.example.net',
  'none',
];

void syntaxCheckHomepageUrl(String url) {
  Uri uri;
  try {
    uri = Uri.parse(url);
  } catch (_) {
    throw GenericProcessingException('Unable to parse homepage URL: $url');
  }
  final hasValidScheme = uri.scheme == 'http' || uri.scheme == 'https';
  if (!hasValidScheme) {
    throw GenericProcessingException(
        'Use http:// or https:// URL schemes for homepage URL: $url');
  }
  if (uri.host == null ||
      uri.host.isEmpty ||
      !uri.host.contains('.') ||
      _invalidHostNames.contains(uri.host)) {
    throw GenericProcessingException('Homepage URL has no valid host: $url');
  }
}

String dartSdkMainUrl(String version) {
  final isDev = version.contains('dev');
  final channel = isDev ? 'dev' : 'stable';
  final url = p.join(_apiDartlangOrg, channel, version);
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

/// Returns the versioned documentation URL for pana's maintenance suggestions.
String panaMaintenanceUrl() {
  return 'https://pub.dartlang.org/documentation/pana/$panaVersion/#maintenance-score';
}
