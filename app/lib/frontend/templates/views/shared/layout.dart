// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;

/// Renders the footer content.
d.Node siteFooterNode() {
  d.Node link(String href, String label, {bool sep = true}) =>
      d.a(classes: ['link', if (sep) 'sep'], href: href, text: label);

  d.Node icon(String linkHref, List<String> classes, String iconSrc,
          String title) =>
      d.a(
        classes: ['link', 'icon', ...classes],
        href: linkHref,
        child: d.img(
          src: iconSrc,
          classes: ['inline-icon'],
          title: title,
          alt: title,
        ),
      );

  return d.element(
    'footer',
    classes: ['site-footer'],
    children: [
      link('${urls.dartSiteRoot}/', 'Dart language', sep: false),
      link('/policy', 'Policy'),
      link('https://www.google.com/intl/en/policies/terms/', 'Terms'),
      link('https://developers.google.com/terms/', 'API Terms'),
      link('/security', 'Security'),
      link('https://www.google.com/intl/en/policies/privacy/', 'Privacy'),
      link('/help', 'Help'),
      icon(
        '/feed.atom',
        ['sep'],
        staticUrls.getAssetUrl('/static/img/rss-feed-icon.svg'),
        'RSS/atom feed',
      ),
      icon(
        'https://github.com/dart-lang/pub-dev/issues/new',
        ['github_issue'],
        staticUrls.getAssetUrl('/static/img/bug-report-white-96px.png'),
        'Report an issue with this site',
      ),
    ],
  );
}
