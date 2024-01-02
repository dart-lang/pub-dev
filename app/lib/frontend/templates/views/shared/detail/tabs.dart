// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../dom/dom.dart' as d;
import '../../../detail_page.dart' show Tab;

/// Renders the tab header and content of the details page.
d.Node detailTabsNode({
  required List<Tab> tabs,
}) {
  return d.fragment([
    d.div(
      classes: ['detail-tabs-wide-header'],
      child: d.div(
        classes: ['detail-container'],
        child: d.ul(
          classes: ['detail-tabs-header'],
          children: tabs.map(
            (t) => d.li(
              classes: t.titleClasses,
              child: t.titleNode,
            ),
          ),
        ),
      ),
    ),
    d.div(
      classes: ['detail-container', 'detail-body-main'],
      child: d.div(
        classes: ['detail-tabs-content'],
        children: tabs.where((t) => t.hasContent).map(
              (t) => d.element(
                'section',
                classes: t.contentClasses,
                child: t.contentNode!,
              ),
            ),
      ),
    ),
  ]);
}
