// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_package_reader/pub_package_reader.dart'
    show reducePackageName;

/// Package names that are reserved for the Dart or Flutter team.
final _reservedPackageNames = <String>[
  '_macros',
  'brick',
  'core',
  'dart',
  'dart2js',
  'dart2native',
  'dartanalyzer',
  'dartaotruntime',
  'dartdevc',
  'dartfmt',
  'flutter_web',
  'flutter_web_test',
  'flutter_web_ui',
  'google_maps_flutter',
  'hummingbird',
  'in_app_purchase',
  'location_background',
  'web_socket', // for bquinlan@
  'math',
  'mirrors',
  'developer',
  'pub',
  'swift_ui',
  'swiftgen',
  'versions',
  'webview_flutter',
  'firebaseui',
  // removed in https://github.com/dart-lang/pub-dev/issues/2853
  'fluttery',
  'fluttery_audio',
  'fluttery_seekbar',
  'data_class',
  'hook',
  'kotlin', // for yousefi@
  'ok_http', // https://github.com/dart-lang/http/tree/master/pkgs/ok_http
  'credilio_sbm', // for owner of package:crediliosbm
  'app_update',
].map(reducePackageName).toList();

const redirectPackageUrls = <String, String>{
  'flutter': 'https://api.flutter.dev/',
  'flutter_driver':
      'https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html',
  'flutter_driver_extension':
      'https://api.flutter.dev/flutter/flutter_driver_extension/flutter_driver_extension-library.html',
  'flutter_gpu':
      'https://main-api.flutter.dev/flutter/flutter_gpu/flutter_gpu-library.html',
  'flutter_localizations':
      'https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html',
  'flutter_test':
      'https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html',
  'flutter_web_plugins':
      'https://api.flutter.dev/flutter/flutter_web_plugins/flutter_web_plugins-library.html',
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
  'flutter_lints',
  'json_serializable',
  'lint',
  'lints',
  'test',
  'test_descriptor',
  'test_process',
};

/// A package is soft-removed when we keep it in the archives and index, but we
/// won't serve the package or the documentation page, or any data about it.
bool isSoftRemoved(String packageName) =>
    redirectPackageUrls.containsKey(packageName);

/// Whether the [name] is (very similar) to a reserved package name.
bool matchesReservedPackageName(String name) =>
    _reservedPackageNames.contains(reducePackageName(name));

/// Whether the [publisherId] is part of dart.dev.
/// Packages under dart.dev are considered 'internal', and allowed to have homepage
/// URLs pointing to e.g. dart.dev.
bool isDartDevPublisher(String? publisherId) {
  if (publisherId == null) return false;
  if (publisherId == 'dart.dev') return true;
  if (publisherId.endsWith('.dart.dev')) return true;
  if (publisherId == 'flutter.dev') return true;
  if (publisherId.endsWith('.flutter.dev')) return true;
  if (publisherId == 'google.dev') return true;
  if (publisherId.endsWith('.google.dev')) return true;
  if (publisherId.endsWith('.google.com')) return true;
  return false;
}

/// Overriding the default maximum number of the allowed package version counts.
const maxVersionsPerPackageOverrides = <String, int>{
  'masamune': 1500, // last updated: 2024-09-16
};
