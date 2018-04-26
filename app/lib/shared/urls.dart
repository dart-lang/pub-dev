// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

const pubHostedDomain = 'pub.dartlang.org';

const siteRoot = 'https://$pubHostedDomain';

String pkgPageUrl(String package,
    {String version, bool includeHost: false, String fragment}) {
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
  bool includeHost: false,
  String relativePath,
  bool omitTrailingSlash: false,
}) {
  String url = includeHost ? siteRoot : '';
  url += '/documentation/$package';
  if (version != null) {
    url += '/$version';
  }
  if (relativePath != null) {
    url = p.join(url, relativePath);
  } else if (!omitTrailingSlash) {
    url = '$url/';
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
  return new Uri(
    path: packagesPath,
    queryParameters: params.isEmpty ? null : params,
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
    throw new Exception('Unable to parse homepage URL: $url');
  }
  if (!uri.hasScheme || !uri.scheme.startsWith('http')) {
    throw new Exception(
        'Use http:// or https:// URL schemes for homepage URL: $url');
  }
  if (uri.host == null ||
      uri.host.isEmpty ||
      !uri.host.contains('.') ||
      _invalidHostNames.contains(uri.host)) {
    throw new Exception('Homepage URL has no valid host: $url');
  }
}
