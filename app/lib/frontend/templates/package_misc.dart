// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';

import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
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

/// Renders the Dart 3 ready badge.
final dart3ReadyNode = packageBadgeNode(
  label: 'Dart 3 ready',
  title: 'Package is compatible with Dart 3.',
);

/// Renders the tags using the pkg/tags template.
d.Node tagsNodeFromPackageView({
  required PackageView package,
  SearchForm? searchForm,
  String? version,
  bool isRetracted = false,
}) {
  searchForm ??= SearchForm();
  final tags = package.tags;
  final sdkTags = tags.where((s) => s.startsWith('sdk:')).toSet().toList();
  final simpleTags = <SimpleTag>[];
  final badgeTags = <BadgeTag>[];
  d.Node? discontinuedNode;
  if (package.isDiscontinued) {
    discontinuedNode = d.div(
      classes: ['-pub-tag-discontinued'],
      children: [
        d.span(classes: ['-discontinued-main'], text: 'discontinued'),
        if (package.replacedBy != null)
          d.span(
            classes: ['-discontinued-replacedby'],
            children: [
              d.text('replaced by: '),
              d.b(child: replacedByLink(package.replacedBy!)),
            ],
          ),
      ],
    );
  }
  if (isRetracted) {
    simpleTags.add(SimpleTag.retracted());
  }

  // Display unlisted tag only for packages that are not discontinued or legacy.
  if (!package.isDiscontinued &&
      !package.isLegacy &&
      package.tags.contains(PackageTags.isUnlisted)) {
    simpleTags.add(SimpleTag.unlisted());
  }
  if (package.isObsolete) {
    simpleTags.add(SimpleTag.obsolete());
  }
  if (package.isLegacy) {
    simpleTags.add(SimpleTag.legacy());
  }
  String tagUrl(String requiredTag) =>
      searchForm!.addRequiredTagIfAbsent(requiredTag).toSearchLink();

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
      if (tags.contains(PlatformTag.platformAndroid))
        BadgeSubTag(
          text: 'Android',
          title: 'Packages compatible with Android platform',
          href: tagUrl(PlatformTag.platformAndroid),
        ),
      if (tags.contains(PlatformTag.platformIos))
        BadgeSubTag(
          text: 'iOS',
          title: 'Packages compatible with iOS platform',
          href: tagUrl(PlatformTag.platformIos),
        ),
      if (tags.contains(PlatformTag.platformLinux))
        BadgeSubTag(
          text: 'Linux',
          title: 'Packages compatible with Linux platform',
          href: tagUrl(PlatformTag.platformLinux),
        ),
      if (tags.contains(PlatformTag.platformMacos))
        BadgeSubTag(
          text: 'macOS',
          title: 'Packages compatible with macOS platform',
          href: tagUrl(PlatformTag.platformMacos),
        ),
      if (tags.contains(PlatformTag.platformWeb))
        BadgeSubTag(
          text: 'web',
          title: 'Packages compatible with Web platform',
          href: tagUrl(PlatformTag.platformWeb),
        ),
      if (tags.contains(PlatformTag.platformWindows))
        BadgeSubTag(
          text: 'Windows',
          title: 'Packages compatible with Windows platform',
          href: tagUrl(PlatformTag.platformWindows),
        ),
    ],
  );
  if (platformBadgeTag.subTags.isNotEmpty) {
    badgeTags.add(platformBadgeTag);
  }
  if (badgeTags.isEmpty && package.isPending) {
    simpleTags.add(SimpleTag.pending());
  }
  if (simpleTags.isEmpty && badgeTags.isEmpty && discontinuedNode == null) {
    final scorePageUrl = urls.pkgScoreUrl(package.name!, version: version);
    if (package.tags.contains(PackageVersionTags.hasError)) {
      simpleTags.add(SimpleTag.analysisIssue(scorePageUrl: scorePageUrl));
    } else {
      simpleTags.add(SimpleTag.unknownPlatforms(scorePageUrl: scorePageUrl));
    }
  }

  return d.fragment([
    if (discontinuedNode != null) discontinuedNode,
    ...badgeTags.map(badgeTagNode),
    ...simpleTags.map(simpleTagNode),
  ]);
}

d.Node replacedByLink(String replacedBy) {
  return d.a(
    href: urls.pkgPageUrl(replacedBy),
    title:
        'This package is discontinued, but author has suggested package:$replacedBy as a replacement',
    text: replacedBy,
  );
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
