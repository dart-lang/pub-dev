// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '../static_files.dart';

import 'views/pkg/badge.dart';
import 'views/pkg/labeled_scores.dart';
import 'views/pkg/tags.dart';

/// Renders the Flutter Favorite badge, used by package listing.
d.Node flutterFavoriteBadgeNode() {
  return packageBadgeNode(
    label: 'Flutter Favorite',
    iconUrl: staticUrls.flutterLogo32x32,
  );
}

/// Renders the null-safe badge used by package listing and package page.
d.Node nullSafeBadgeNode({String? title}) {
  return packageBadgeNode(
    label: 'Null safety',
    title: title ?? 'Supports the null safety language feature.',
  );
}

/// Renders the tags using the pkg/tags template.
d.Node tagsNodeFromPackageView({
  required PackageView package,
  String? version,
}) {
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final simpleTags = <SimpleTag>[];
  final badgeTags = <BadgeTag>[];
  if (package.isDiscontinued) {
    simpleTags.add(SimpleTag.discontinued());
  }
  // Display unlisted tag only for packages that are not discontinued.
  if (!package.isDiscontinued &&
      package.tags.contains(PackageTags.isUnlisted)) {
    simpleTags.add(SimpleTag.unlisted());
  }
  if (package.isObsolete) {
    simpleTags.add(SimpleTag.obsolete());
  }
  if (package.isLegacy) {
    simpleTags.add(SimpleTag.legacy());
  }
  // We only display first-class platform/runtimes
  if (sdkTags.contains(SdkTag.sdkDart)) {
    badgeTags.add(BadgeTag(
      sdk: 'Dart',
      title: 'Packages compatible with Dart SDK',
      href: urls.searchUrl(sdk: SdkTagValue.dart),
      subTags: [
        if (tags.contains(DartSdkTag.runtimeNativeJit))
          BadgeSubTag(
            text: 'native',
            title:
                'Packages compatible with Dart running on a native platform (JIT/AOT)',
            href: urls.searchUrl(
                sdk: SdkTagValue.dart,
                runtimes: DartSdkRuntime.encodeRuntimeTags(
                    [DartSdkRuntime.nativeJit])),
          ),
        if (tags.contains(DartSdkTag.runtimeWeb))
          BadgeSubTag(
            text: 'js',
            title: 'Packages compatible with Dart compiled for the web',
            href: urls.searchUrl(
                sdk: SdkTagValue.dart,
                runtimes:
                    DartSdkRuntime.encodeRuntimeTags([DartSdkRuntime.web])),
          ),
      ],
    ));
  }
  if (sdkTags.contains(SdkTag.sdkFlutter)) {
    badgeTags.add(BadgeTag(
      sdk: 'Flutter',
      title: 'Packages compatible with Flutter SDK',
      href: urls.searchUrl(sdk: SdkTagValue.flutter),
      subTags: [
        if (tags.contains(FlutterSdkTag.platformAndroid))
          BadgeSubTag(
            text: 'Android',
            title: 'Packages compatible with Flutter on the Android platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.android]),
          ),
        if (tags.contains(FlutterSdkTag.platformIos))
          BadgeSubTag(
            text: 'iOS',
            title: 'Packages compatible with Flutter on the iOS platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter, platforms: [FlutterSdkPlatform.ios]),
          ),
        if (tags.contains(FlutterSdkTag.platformLinux))
          BadgeSubTag(
            text: 'Linux',
            title: 'Packages compatible with Flutter on the Linux platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.linux]),
          ),
        if (tags.contains(FlutterSdkTag.platformMacos))
          BadgeSubTag(
            text: 'macOS',
            title: 'Packages compatible with Flutter on the macOS platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.macos]),
          ),
        if (tags.contains(FlutterSdkTag.platformWeb))
          BadgeSubTag(
            text: 'web',
            title: 'Packages compatible with Flutter on the Web platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter, platforms: [FlutterSdkPlatform.web]),
          ),
        if (tags.contains(FlutterSdkTag.platformWindows))
          BadgeSubTag(
            text: 'Windows',
            title: 'Packages compatible with Flutter on the Windows platform',
            href: urls.searchUrl(
                sdk: SdkTagValue.flutter,
                platforms: [FlutterSdkPlatform.windows]),
          ),
      ],
    ));
  }
  if (badgeTags.isEmpty && package.isAwaiting!) {
    simpleTags.add(SimpleTag.awaiting());
  }
  if (simpleTags.isEmpty && badgeTags.isEmpty) {
    simpleTags.add(SimpleTag.unidentified(
        href: urls.pkgScoreUrl(package.name!, version: version)));
  }
  return tagsNode(simpleTags: simpleTags, badgeTags: badgeTags);
}

/// Renders the labeled scores widget (the score values in a compact layout).
d.Node labeledScoresNodeFromPackageView(PackageView view, {String? version}) {
  return labeledScoresNode(
    pkgScorePageUrl: urls.pkgScoreUrl(view.name!, version: version),
    likeCount: view.likes,
    grantedPubPoints: view.grantedPubPoints,
    popularity: view.popularity,
  );
}

/// Formats the score from [0.0 - 1.0] range to [0 - 100] or '--'.
String formatScore(double? value) {
  if (value == null) return '--';
  if (value <= 0.0) return '0';
  if (value >= 1.0) return '100';
  return (value * 100.0).round().toString();
}
