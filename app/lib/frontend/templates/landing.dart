// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import '../../package/models.dart' show PackageView;
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import '_consts.dart';
import 'layout.dart';
import 'misc.dart' show renderMiniList;

/// Renders the `views/show.mustache` template.
String renderIndexPage(
  String topHtml,
  String platform,
) {
  final platformDict = getPlatformDict(platform);
  final packagesUrl = urls.searchUrl(platform: platform);
  final links = <String>[
    '<a href="$packagesUrl">${htmlEscape.convert(platformDict.morePlatformPackagesLabel)}</a>'
  ];
  if (platformDict.onlyPlatformPackagesUrl != null) {
    links.add('<a href="${platformDict.onlyPlatformPackagesUrl}">'
        '${htmlEscape.convert(platformDict.onlyPlatformPackagesLabel)}</a>');
  }
  final values = {
    'more_links_html': links.join(' '),
    'top_header': platformDict.topPlatformPackages,
    'ranking_tooltip_html': getSortDict('top').tooltip,
    'top_html': topHtml,
  };
  final String content = templateCache.renderTemplate('index', values);
  return renderLayoutPage(
    PageType.landing,
    content,
    title: platformDict.landingPageTitle,
    platform: platform,
  );
}

/// Renders the `views/landing.mustache` template.
String renderLandingPage({
  List<PackageView> taggedPackages,
  List<PackageView> topPackages,
}) {
  final hasTagged = taggedPackages != null && taggedPackages.isNotEmpty;
  final hasTop = topPackages != null && topPackages.isNotEmpty;
  final values = {
    'has_tagged': hasTagged,
    'tagged_minilist_html': hasTagged ? renderMiniList(taggedPackages) : null,
    // TODO: use /flutter/favorites
    'tagged_more_url': '/flutter/packages',
    'has_top': hasTop,
    'top_minilist_html': hasTop ? renderMiniList(topPackages) : null,
    'top_more_url': urls.searchUrl(),
  };
  final String content = templateCache.renderTemplate('landing', values);
  return renderLayoutPage(
    PageType.landing,
    content,
    title: 'Dart packages',
  );
}
