// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../dom/dom.dart' as d;

/// Renders a section of the package versions page.
d.Node versionSectionNode({
  required String id,
  required String label,
  required String packageName,
  required List<d.Node> rows,
}) {
  return d.fragment([
    d.h2(id: id, text: '$label versions of $packageName'),
    d.table(
      classes: ['version-table'],
      attributes: {'data-package': packageName},
      head: [
        d.tr(
          children: [
            d.th(classes: ['version'], text: 'Version'),
            d.th(classes: ['badge'], text: ''),
            d.th(
              classes: ['sdk'],
              child: d.span(classes: ['label'], text: 'Min Dart SDK'),
            ),
            d.th(
              classes: ['uploaded'],
              child: d.span(classes: ['label'], text: 'Uploaded'),
            ),
            d.th(
              classes: ['documentation'],
              child: d.span(classes: ['label'], text: 'Documentation'),
            ),
            d.th(
              classes: ['archive'],
              child: d.span(classes: ['label'], text: 'Archive'),
            ),
          ],
        ),
      ],
      body: rows,
    ),
  ]);
}
