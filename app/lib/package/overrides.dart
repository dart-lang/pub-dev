// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../shared/urls.dart' as urls;

/// 'internal' packages are developed by the Dart team, and they are allowed to
/// point their URLs to *.dartlang.org (others would get a penalty for it).
const internalPackageNames = <String>[
  'angular',
  'angular_components',
];

const redirectPackagePages = <String, String>{
  'flutter': '${urls.siteRoot}/flutter',
};

const redirectDartdocPages = <String, String>{
  'flutter': 'https://docs.flutter.io/',
};

/// Known packages that should be put in `dev_dependencies`
///
/// This is a temporary hack that should be removed when INSTALL.md extraction
/// is implemented: https://github.com/dart-lang/pub-dev/issues/3403
const devDependencyPackages = <String>{
  'build_runner',
  'build_test',
  'build_verify',
  'build_web_compilers',
  'test',
  'test_descriptor',
  'test_process',
};

// TODO: remove this after all of the flutter plugins have a proper issue tracker entry in their pubspec.yaml
const _issueTrackerUrlOverrides = <String, String>{
  'https://github.com/flutter/plugins/issues':
      'https://github.com/flutter/flutter/issues',
};

String overrideIssueTrackerUrl(String url) {
  if (url == null) {
    return null;
  }
  return _issueTrackerUrlOverrides[url] ?? url;
}

/// A package is soft-removed when we keep it in the archives and index, but we
/// won't serve the package or the documentation page, or any data about it.
bool isSoftRemoved(String packageName) =>
    redirectPackagePages.containsKey(packageName);
