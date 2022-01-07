// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../search/search_form.dart';
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '../request_context.dart';
import '../static_files.dart';

import 'views/pkg/badge.dart';
import 'views/pkg/labeled_scores.dart';
import 'views/pkg/tags.dart';

/// Renders the core library badge node, used for SDK library hits.
final coreLibraryBadgeNode = packageBadgeNode(label: 'Core library');

/// Renders the Flutter Favorite badge, used by package listing.
final flutterFavoriteBadgeNode = packageBadgeNode(
  label: 'Flutter Favorite',
  icon: d.Image(
    src: staticUrls.flutterLogo32x32,
    alt: 'Flutter logo',
    width: 13,
    height: 13,
  ),
);

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
  bool isRetracted = false,
}) {
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final simpleTags = <SimpleTag>[];
  final badgeTags = <BadgeTag>[];
  if (package.isDiscontinued) {
    simpleTags.add(SimpleTag.discontinued());
  }
  if (isRetracted) {
    simpleTags.add(SimpleTag.retracted());
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
  if (requestContext.showNewSearchUI) {
    String tagUrl(String requiredTag) =>
        SearchForm().toggleRequiredTag(requiredTag).toSearchLink();

    final sdkBadgeTag = BadgeTag(
      text: 'SDK',
      subTags: [
        if (sdkTags.contains(SdkTag.sdkDart))
          BadgeSubTag(
            text: 'Dart',
            title: 'Packages compatible with Dart SDK',
            href: tagUrl(SdkTag.sdkDart),
          ),
        if (sdkTags.contains(SdkTag.sdkFlutter))
          BadgeSubTag(
            text: 'Flutter',
            title: 'Packages compatible with Flutter SDK',
            href: tagUrl(SdkTag.sdkFlutter),
          ),
      ],
    );
    if (sdkBadgeTag.subTags.isNotEmpty) {
      badgeTags.add(sdkBadgeTag);
    }

    final platformBadgeTag = BadgeTag(
      text: 'Platform',
      subTags: [
        if (tags.contains(FlutterSdkTag.platformAndroid))
          BadgeSubTag(
            text: 'Android',
            title: 'Packages compatible with Android platform',
            href: tagUrl(FlutterSdkTag.platformAndroid),
          ),
        if (tags.contains(FlutterSdkTag.platformIos))
          BadgeSubTag(
            text: 'iOS',
            title: 'Packages compatible with iOS platform',
            href: tagUrl(FlutterSdkTag.platformIos),
          ),
        if (tags.contains(FlutterSdkTag.platformLinux))
          BadgeSubTag(
            text: 'Linux',
            title: 'Packages compatible with Linux platform',
            href: tagUrl(FlutterSdkTag.platformLinux),
          ),
        if (tags.contains(FlutterSdkTag.platformMacos))
          BadgeSubTag(
            text: 'macOS',
            title: 'Packages compatible with macOS platform',
            href: tagUrl(FlutterSdkTag.platformMacos),
          ),
        if (tags.contains(FlutterSdkTag.platformWeb))
          BadgeSubTag(
            text: 'web',
            title: 'Packages compatible with Web platform',
            href: tagUrl(FlutterSdkTag.platformWeb),
          ),
        if (tags.contains(FlutterSdkTag.platformWindows))
          BadgeSubTag(
            text: 'Windows',
            title: 'Packages compatible with Windows platform',
            href: tagUrl(FlutterSdkTag.platformWindows),
          ),
      ],
    );
    if (platformBadgeTag.subTags.isNotEmpty) {
      badgeTags.add(platformBadgeTag);
    }
  }
  // We only display first-class platform/runtimes
  if (!requestContext.showNewSearchUI && sdkTags.contains(SdkTag.sdkDart)) {
    badgeTags.add(BadgeTag(
      text: 'Dart',
      title: 'Packages compatible with Dart SDK',
      href: urls.searchUrl(context: SearchContext.dart()),
      subTags: [
        if (tags.contains(DartSdkTag.runtimeNativeJit))
          BadgeSubTag(
            text: 'native',
            title:
                'Packages compatible with Dart running on a native platform (JIT/AOT)',
            href: urls.searchUrl(
                context: SearchContext.dart(),
                runtimes: DartSdkRuntime.encodeRuntimeTags(
                    [DartSdkRuntime.nativeJit])),
          ),
        if (tags.contains(DartSdkTag.runtimeWeb))
          BadgeSubTag(
            text: 'js',
            title: 'Packages compatible with Dart compiled for the web',
            href: urls.searchUrl(
                context: SearchContext.dart(),
                runtimes:
                    DartSdkRuntime.encodeRuntimeTags([DartSdkRuntime.web])),
          ),
      ],
    ));
  }
  if (!requestContext.showNewSearchUI && sdkTags.contains(SdkTag.sdkFlutter)) {
    badgeTags.add(BadgeTag(
      text: 'Flutter',
      title: 'Packages compatible with Flutter SDK',
      href: urls.searchUrl(context: SearchContext.flutter()),
      subTags: [
        if (tags.contains(FlutterSdkTag.platformAndroid))
          BadgeSubTag(
            text: 'Android',
            title: 'Packages compatible with Flutter on the Android platform',
            href: urls.searchUrl(
                context: SearchContext.flutter(),
                platforms: [FlutterSdkPlatform.android]),
          ),
        if (tags.contains(FlutterSdkTag.platformIos))
          BadgeSubTag(
            text: 'iOS',
            title: 'Packages compatible with Flutter on the iOS platform',
            href: urls.searchUrl(
              context: SearchContext.flutter(),
              platforms: [FlutterSdkPlatform.ios],
            ),
          ),
        if (tags.contains(FlutterSdkTag.platformLinux))
          BadgeSubTag(
            text: 'Linux',
            title: 'Packages compatible with Flutter on the Linux platform',
            href: urls.searchUrl(
                context: SearchContext.flutter(),
                platforms: [FlutterSdkPlatform.linux]),
          ),
        if (tags.contains(FlutterSdkTag.platformMacos))
          BadgeSubTag(
            text: 'macOS',
            title: 'Packages compatible with Flutter on the macOS platform',
            href: urls.searchUrl(
                context: SearchContext.flutter(),
                platforms: [FlutterSdkPlatform.macos]),
          ),
        if (tags.contains(FlutterSdkTag.platformWeb))
          BadgeSubTag(
            text: 'web',
            title: 'Packages compatible with Flutter on the Web platform',
            href: urls.searchUrl(
              context: SearchContext.flutter(),
              platforms: [FlutterSdkPlatform.web],
            ),
          ),
        if (tags.contains(FlutterSdkTag.platformWindows))
          BadgeSubTag(
            text: 'Windows',
            title: 'Packages compatible with Flutter on the Windows platform',
            href: urls.searchUrl(
              context: SearchContext.flutter(),
              platforms: [FlutterSdkPlatform.windows],
            ),
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
