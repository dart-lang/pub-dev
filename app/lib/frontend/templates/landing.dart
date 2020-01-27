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
  bool isNotEmptyList(List l) => l != null && l.isNotEmpty;
  String renderMiniListIf(bool cond, List<PackageView> packages) =>
      cond ? renderMiniList(packages) : null;

  final isExperimental = requestContext.isExperimental;
  final hasTagged = !isExperimental && isNotEmptyList(ffPackages);
  final hasTop = !isExperimental && isNotEmptyList(topPackages);
  final hasFF = isExperimental && isNotEmptyList(ffPackages);
  final hasMostPopular = isExperimental && isNotEmptyList(mostPopularPackages);
  final hasTopFlutter = isExperimental && isNotEmptyList(topFlutterPackages);
  final hasTopDart = isExperimental && isNotEmptyList(topDartPackages);
  final values = {
    // old design's variables
    'has_tagged': hasTagged,
    'tagged_minilist_html': renderMiniListIf(hasTagged, ffPackages),
    'tagged_more_url': '/flutter/favorites',
    'has_top': hasTop,
    'top_minilist_html': renderMiniListIf(hasTop, topPackages),
    'top_more_url': urls.searchUrl(),
    // new design's variables
    'has_ff': hasFF,
    'ff_mini_list_html': renderMiniListIf(hasFF, ffPackages),
    'ff_view_all_url': '/flutter/favorites',
    'has_mp': hasMostPopular,
    'mp_mini_list_html': renderMiniListIf(hasMostPopular, mostPopularPackages),
    'mp_view_all_url': urls.searchUrl(order: urls.SearchOrder.popularity),
    'has_tf': hasTopFlutter,
    'tf_mini_list_html': renderMiniListIf(hasTopFlutter, topFlutterPackages),
    'tf_view_all_url': urls.searchUrl(sdk: SdkTagValue.flutter),
    'has_td': hasTopDart,
    'td_mini_list_html': renderMiniListIf(hasTopDart, topDartPackages),
    'td_view_all_url': urls.searchUrl(sdk: SdkTagValue.dart),
  };
  final String content = templateCache.renderTemplate('page/landing', values);
  return renderLayoutPage(
    PageType.landing,
    content,
    title: 'Dart packages',
    mainClasses: requestContext.isExperimental ? ['landing-main'] : null,
  );
}
