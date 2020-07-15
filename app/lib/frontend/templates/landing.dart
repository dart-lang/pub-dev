// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart' show PackageView;
import '../../shared/tags.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'layout.dart';
import 'misc.dart' show renderMiniList;

/// Renders the `views/page/landing.mustache` template.
String renderLandingPage({
  List<PackageView> ffPackages,
  List<PackageView> mostPopularPackages,
  List<PackageView> topFlutterPackages,
  List<PackageView> topDartPackages,
}) {
  bool isNotEmptyList(List l) => l != null && l.isNotEmpty;
  String renderMiniListIf(bool cond, List<PackageView> packages) =>
      cond ? renderMiniList(packages) : null;

  final hasFF = isNotEmptyList(ffPackages);
  final hasMostPopular = isNotEmptyList(mostPopularPackages);
  final hasTopFlutter = isNotEmptyList(topFlutterPackages);
  final hasTopDart = isNotEmptyList(topDartPackages);
  final values = {
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
    mainClasses: ['landing-main'],
  );
}
