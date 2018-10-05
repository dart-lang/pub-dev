// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// 'internal' packages are developed by the Dart team, and they are allowed to
/// point their URLs to *.dartlang.org (others would get a penalty for it).
const internalPackageNames = const <String>[
  'angular',
  'angular_components',
];

final Set<String> knownMixedCasePackages = _knownMixedCasePackages.toSet();
final Set<String> blockedLowerCasePackages = _knownMixedCasePackages
    .map((s) => s.toLowerCase())
    .toSet()
      ..removeAll(_knownGoodLowerCasePackages);

const _knownMixedCasePackages = const [
  'Autolinker',
  'Babylon',
  'DartDemoCLI',
  'FileTeCouch',
  'Flutter_Nectar',
  'Google_Search_v2',
  'LoadingBox',
  'PolymerIntro',
  'Pong',
  'RAL',
  'Transmission_RPC',
  'ViAuthClient',
];
const _knownGoodLowerCasePackages = const [
  'babylon',
];

const redirectPackagePages = const <String, String>{
  'flutter': 'https://pub.dartlang.org/flutter',
};

const redirectDartdocPages = const <String, String>{
  'flutter': 'https://docs.flutter.io/',
};

const _issueTrackerUrlOverrides = const <String, String>{
  'https://github.com/flutter/plugins/issues':
      'https://github.com/flutter/flutter/issues',
};

String overrideIssueTrackerUrl(String url) {
  if (url == null) {
    return null;
  }
  return _issueTrackerUrlOverrides[url] ?? url;
}
