// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '../static_files.dart';

import '_cache.dart';
import 'views/pkg/badge.dart';
import 'views/pkg/labeled_scores.dart';

/// Renders the Flutter Favorite badge, used by package listing.
d.Node renderFlutterFavoriteBadgeNode() {
  return renderPackageBadgeNode(
    label: 'Flutter Favorite',
    iconUrl: staticUrls.flutterLogo32x32,
  );
}

/// Renders the null-safe badge used by package listing and package page.
d.Node renderNullSafeBadgeNode() {
  return renderPackageBadgeNode(
    label: 'Null safety',
    title: 'Supports the null safety language feature.',
  );
}

/// Renders the tags using the pkg/tags template.
String renderTags({
  required PackageView package,
  String? version,
}) {
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final tagValues = <Map>[];
  final tagBadges = <Map>[];
  if (package.isDiscontinued) {
    tagValues.add({
      'status': 'discontinued',
      'text': 'discontinued',
      'has_href': false,
      'title': 'Package was discontinued.',
    });
  }
  // Display unlisted tag only for packages that are not discontinued.
  if (!package.isDiscontinued &&
      package.tags.contains(PackageTags.isUnlisted)) {
    tagValues.add({
      'status': 'unlisted',
      'text': 'unlisted',
      'has_href': false,
      'title': 'Package is unlisted, this means that while the package is still '
          'publicly available the author has decided that it should not appear '
          'in search results with default search filters. This is typically '
          'done because this package is meant to support another package, '
          'rather than being consumed directly.',
    });
  }
  if (package.isObsolete) {
    tagValues.add({
      'status': 'missing',
      'text': 'outdated',
      'has_href': false,
      'title': 'Package version too old, check latest stable.',
    });
  }
  if (package.isLegacy) {
    tagValues.add({
      'status': 'legacy',
      'text': 'Dart 2 incompatible',
      'has_href': false,
      'title': 'Package does not support Dart 2.',
    });
  }
  // We only display first-class platform/runtimes
  if (sdkTags.contains(SdkTag.sdkDart)) {
    tagBadges.add({
      'sdk': 'Dart',
      'title': 'Packages compatible with Dart SDK',
      'href': urls.searchUrl(sdk: SdkTagValue.dart),
      'sub_tags': [
        if (tags.contains(DartSdkTag.runtimeNativeJit))
          {
            'text': 'native',
            'title':
                'Packages compatible with Dart running on a native platform (JIT/AOT)',
            'href': urls.searchUrl(
                sdk: SdkTagValue.dart,
                runtimes: DartSdkRuntime.encodeRuntimeTags(
                    [DartSdkRuntime.nativeJit])),
          },
        if (tags.contains(DartSdkTag.runtimeWeb))
          {
            'text': 'js',
            'title': 'Packages compatible with Dart compiled for the web',
            'href': urls.searchUrl(
                sdk: SdkTagValue.dart,
                runtimes:
                    DartSdkRuntime.encodeRuntimeTags([DartSdkRuntime.web])),
          },
      ],
    });
  }
  if (sdkTags.contains(SdkTag.sdkFlutter)) {
    tagBadges.add({
      'sdk': 'Flutter',
      'title': 'Packages compatible with Flutter SDK',
      'href': urls.searchUrl(sdk: SdkTagValue.flutter),
      'sub_tags': [
        if (tags.contains(FlutterSdkTag.platformAndroid))
          {
            'text': 'Android',
            'title': 'Packages compatible with Flutter on the Android platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.android]),
          },
        if (tags.contains(FlutterSdkTag.platformIos))
          {
            'text': 'iOS',
            'title': 'Packages compatible with Flutter on the iOS platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter, platforms: [FlutterSdkPlatform.ios]),
          },
        if (tags.contains(FlutterSdkTag.platformLinux))
          {
            'text': 'Linux',
            'title': 'Packages compatible with Flutter on the Linux platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.linux]),
          },
        if (tags.contains(FlutterSdkTag.platformMacos))
          {
            'text': 'macOS',
            'title': 'Packages compatible with Flutter on the macOS platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.macos]),
          },
        if (tags.contains(FlutterSdkTag.platformWeb))
          {
            'text': 'web',
            'title': 'Packages compatible with Flutter on the Web platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter, platforms: [FlutterSdkPlatform.web]),
          },
        if (tags.contains(FlutterSdkTag.platformWindows))
          {
            'text': 'Windows',
            'title': 'Packages compatible with Flutter on the Windows platform',
            'href': urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.windows]),
          },
      ],
    });
  }
  if (tagBadges.isEmpty && package.isAwaiting!) {
    tagValues.add({
      'status': 'missing',
      'text': '[awaiting]',
      'has_href': false,
      'title': 'Analysis should be ready soon.',
    });
  }
  if (tagValues.isEmpty && tagBadges.isEmpty) {
    tagValues.add({
      'status': 'unidentified',
      'text': '[unidentified]',
      'title': 'Check the scores tab for further details.',
      'has_href': true,
      'href': urls.pkgScoreUrl(package.name!, version: version),
    });
  }
  return templateCache.renderTemplate('pkg/tags', {
    'tags': tagValues,
    'tag_badges': tagBadges,
  });
}

/// Renders the labeled scores widget (the score values in a compact layout).
String renderLabeledScores(PackageView view, {String? version}) {
  return renderLabeledScoresNode(
    pkgScorePageUrl: urls.pkgScoreUrl(view.name!, version: version),
    likeCount: view.likes,
    grantedPubPoints: view.grantedPubPoints,
    popularity: view.popularity,
  ).toString();
}

/// Formats the score from [0.0 - 1.0] range to [0 - 100] or '--'.
String formatScore(double? value) {
  if (value == null) return '--';
  if (value <= 0.0) return '0';
  if (value >= 1.0) return '100';
  return (value * 100.0).round().toString();
}
