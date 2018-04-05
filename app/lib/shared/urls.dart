// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

const pubHostedDomain = 'pub.dartlang.org';

const siteRoot = 'https://$pubHostedDomain';

/// Removes the scheme part from `url`. (i.e. http://a/b becomes a/b).
String niceUrl(String url) {
  if (url == null) {
    return url;
  } else if (url.startsWith('https://')) {
    return url.substring('https://'.length);
  } else if (url.startsWith('http://')) {
    return url.substring('http://'.length);
  }
  return url;
}

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

String pkgDocUrl(String package,
    {String version, bool includeHost: false, String relativePath}) {
  String url = includeHost ? siteRoot : '';
  url += '/documentation/$package';
  if (version != null) {
    url += '/$version';
  }
  if (relativePath != null) {
    url = p.join(url, relativePath);
  } else {
    url = '$url/';
  }
  return url;
}

String versionsTabUrl(String package) =>
    pkgPageUrl(package, fragment: '-versions-tab-');

String analysisTabUrl(String package) {
  final String fragment = '-analysis-tab-';
  return package == null
      ? '#$fragment'
      : pkgPageUrl(package, fragment: fragment);
}

// TODO: lib/shared/analyzer_client.dart

// TODO: lib/shared/configuration.dart

// TODO: lib/shared/dartdoc_client.dart

// TODO: lib/shared/notification.dart

// TODO: lib/shared/search_client.dart
