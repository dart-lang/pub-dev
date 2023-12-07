// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;

d.Node searchBannerNode({
  required String formUrl,
  required String placeholder,
  required String? queryText,
  required bool autofocus,
  required bool showSearchFiltersButton,
  required String? sortParam,
  required bool hasActive,
}) {
  return d.form(
    classes: ['search-bar', 'banner-item'],
    action: formUrl,
    children: [
      d.input(
        classes: ['input'],
        name: 'q',
        placeholder: placeholder,
        autocomplete: 'on',
        autofocus: autofocus,
        value: queryText,
        attributes: {
          'title': 'Search',
          'aria-label': 'Search',
        },
      ),
      d.span(classes: ['icon']),
      if (showSearchFiltersButton)
        d.div(
          classes: [
            'search-filters-btn-wrapper',
            if (hasActive) '-active',
          ],
          children: [
            d.img(
              classes: ['search-filters-btn', 'search-filters-btn-inactive'],
              image: d.Image(
                src: staticUrls
                    .getAssetUrl('/static/img/search-filters-inactive.svg'),
                alt: 'icon to toggle the display of search filters (inactive)',
                width: 42,
                height: 42,
              ),
            ),
            d.img(
              classes: ['search-filters-btn', 'search-filters-btn-active'],
              image: d.Image(
                src: staticUrls
                    .getAssetUrl('/static/img/search-filters-active.svg'),
                alt: 'icon to toggle the display of search filters (active)',
                width: 42,
                height: 42,
              ),
            ),
          ],
        ),
      if (sortParam != null && sortParam.isNotEmpty)
        d.input(type: 'hidden', name: 'sort', value: sortParam),
    ],
  );
}
