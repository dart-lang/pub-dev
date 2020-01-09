// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart' show PackageView;
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'layout.dart';
import 'misc.dart' show renderMiniList;

/// Renders the `views/page/landing.mustache` template.
String renderLandingPage({
  List<PackageView> taggedPackages,
  List<PackageView> topPackages,
}) {
  final hasTagged = taggedPackages != null && taggedPackages.isNotEmpty;
  final hasTop = topPackages != null && topPackages.isNotEmpty;
  final values = {
    'has_tagged': hasTagged,
    'tagged_minilist_html': hasTagged ? renderMiniList(taggedPackages) : null,
    'tagged_more_url': '/flutter/favorites',
    'has_top': hasTop,
    'top_minilist_html': hasTop ? renderMiniList(topPackages) : null,
    'top_more_url': urls.searchUrl(),
  };
  final String content = templateCache.renderTemplate('page/landing', values);
  return renderLayoutPage(
    PageType.landing,
    content,
    title: 'Dart packages',
  );
}
