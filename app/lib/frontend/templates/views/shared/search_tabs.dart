// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

class SearchTab {
  final bool active;
  final String href;
  final String title;
  final String text;

  SearchTab({
    required this.active,
    required this.href,
    required this.title,
    required this.text,
  });
}

d.Node searchTabsNode(Iterable<SearchTab> tabs) {
  return d.div(
    classes: ['list-filters'],
    children: tabs.map(
      (tab) => d.a(
        classes: [
          'search-link',
          'filter',
          if (tab.active) '-active',
        ],
        href: tab.href,
        title: tab.title,
        children: [
          if (tab.active)
            d.img(
              classes: ['filter-icon'],
              src: staticUrls.getAssetUrl('/static/img/checkmark-icon.svg'),
            ),
          d.text(tab.text),
        ],
      ),
    ),
  );
}
