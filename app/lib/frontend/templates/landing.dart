// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart' show PackageView;
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';

import '_cache.dart';
import 'layout.dart';
import 'misc.dart' show renderMiniList;

/// Renders the `views/page/landing.mustache` template.
String renderLandingPage({
  List<PackageView> ffPackages, // old + new
  List<PackageView> topPackages, // old only
  List<PackageView> mostPopularPackages, // new only
  List<PackageView> topFlutterPackages, // new only
  List<PackageView> topDartPackages, // new only
}) {
  final isExperimental = requestContext.isExperimental;
  final hasTagged =
      !isExperimental && ffPackages != null && ffPackages.isNotEmpty;
  final hasTop =
      !isExperimental && topPackages != null && topPackages.isNotEmpty;
  final hasFF = isExperimental && ffPackages != null && ffPackages.isNotEmpty;
  final hasMostPopular = isExperimental &&
      mostPopularPackages != null &&
      mostPopularPackages.isNotEmpty;
  final hasTopFlutter = isExperimental &&
      topFlutterPackages != null &&
      topFlutterPackages.isNotEmpty;
  final hasTopDart =
      isExperimental && topDartPackages != null && topDartPackages.isNotEmpty;
  final values = {
    // old design's variables
    'has_tagged': hasTagged,
    'tagged_minilist_html': hasTagged ? renderMiniList(ffPackages) : null,
    'tagged_more_url': '/flutter/favorites',
    'has_top': hasTop,
    'top_minilist_html': hasTop ? renderMiniList(topPackages) : null,
    'top_more_url': urls.searchUrl(),
    // new design's variables
    'has_ff': hasFF,
    'ff_mini_list_html': hasFF ? renderMiniList(ffPackages) : null,
    'ff_view_all_url': '/flutter/favorites',
    'has_mp': hasMostPopular,
    'mp_mini_list_html':
        hasMostPopular ? renderMiniList(mostPopularPackages) : null,
    'mp_view_all_url': urls.searchUrl(order: urls.SearchOrder.popularity),
    'has_tf': hasTopFlutter,
    'tf_mini_list_html':
        hasTopFlutter ? renderMiniList(topFlutterPackages) : null,
    'tf_view_all_url': urls.searchUrl(sdk: SdkTagValue.flutter),
    'has_td': hasTopDart,
    'td_mini_list_html': hasTopDart ? renderMiniList(topDartPackages) : null,
    'td_view_all_url': urls.searchUrl(sdk: SdkTagValue.dart),
  };
  final String content = templateCache.renderTemplate('page/landing', values);
  return renderLayoutPage(
    PageType.landing,
    content,
    title: 'Dart packages',
  );
}
