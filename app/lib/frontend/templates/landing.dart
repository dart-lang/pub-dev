// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import '../../shared/urls.dart' as urls;

import '../template_consts.dart';

import '_cache.dart';
import 'layout.dart';

/// Renders the `views/index.mustache` template.
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
