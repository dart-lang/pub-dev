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
  required bool includeDiscontinued,
  required bool includeUnlisted,
  required bool includeNullSafe,
  required Map<String, String>? hiddenInputs,
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
      ),
      d.button(classes: ['icon'], ariaLabel: 'search'),
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
              ),
            ),
            d.img(
              classes: ['search-filters-btn', 'search-filters-btn-active'],
              image: d.Image(
                src: staticUrls
                    .getAssetUrl('/static/img/search-filters-active.svg'),
                alt: 'icon to toggle the display of search filters (active)',
              ),
            ),
          ],
        ),
      if (sortParam != null && sortParam.isNotEmpty)
        d.input(type: 'hidden', name: 'sort', value: sortParam),
      d.input(
        id: '-search-discontinued-field',
        type: 'hidden',
        name: 'discontinued',
        value: '1',
        disabled: !includeDiscontinued,
      ),
      d.input(
        id: '-search-unlisted-field',
        type: 'hidden',
        name: 'unlisted',
        value: '1',
        disabled: !includeUnlisted,
      ),
      d.input(
        id: '-search-null-safe-field',
        type: 'hidden',
        name: 'null-safe',
        value: '1',
        disabled: !includeNullSafe,
      ),
      if (hiddenInputs != null)
        ...hiddenInputs.entries
            .map((e) => d.input(type: 'hidden', name: e.key, value: e.value)),
    ],
  );
}
