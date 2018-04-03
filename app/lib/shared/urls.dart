// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

import 'utils.dart' show siteRoot;
export 'utils.dart' show siteRoot;

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

String pkgPageUrl(String package, {String version, bool includeHost: false}) {
  String url = includeHost ? siteRoot : '';
  url += '/packages/$package';
  if (version != null) {
    url += '/versions/$version';
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

// TODO: lib/frontend/backend.dart

// TODO: lib/frontend/handlers.dart

String versionsTabUrl(String package) => '/packages/$package#-versions-tab-';

// TODO: lib/frontend/service_utils.dart

// TODO: lib/frontend/upload_signer_service.dart

// TODO: lib/shared/analyzer_client.dart

// TODO: lib/shared/configuration.dart

// TODO: lib/shared/dartdoc_client.dart

// TODO: lib/shared/notification.dart

// TODO: lib/shared/search_client.dart

// TODO: lib/shared/utils.dart

// TODO: test/analyzer/handlers_test_utils.dart

// TODO: test/frontend/handlers_test.dart

// TODO: test/frontend/tarball_storage_namer_test.dart

// TODO: test/search/handlers_test_utils.dart
