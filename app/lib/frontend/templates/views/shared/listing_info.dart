// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node listingInfoNode({
  required int totalCount,
  required String? ownedBy,
  required d.Node sortControlNode,
  required String? messageMarkdown,
}) {
  final packageOrPackages = totalCount == 1 ? 'package' : 'packages';
  return d.div(
    classes: ['listing-info'],
    children: [
      d.div(
        classes: ['listing-info-count'],
        children: [
          d.span(classes: ['info-identifier'], text: 'Results '),
          d.span(classes: ['count'], text: '$totalCount'),
          d.text(' $packageOrPackages'),
          if (ownedBy != null && ownedBy.isNotEmpty) ...[
            d.text(' owned by '),
            d.code(text: ownedBy),
          ],
          if (messageMarkdown != null) d.markdown(messageMarkdown),
        ],
      ),
      sortControlNode,
    ],
  );
}
