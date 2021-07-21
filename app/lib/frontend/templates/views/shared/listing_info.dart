// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../shared/markdown.dart';
import '../../../dom/dom.dart' as d;

d.Node renderListingInfoNode({
  required int totalCount,
  required String? searchQuery,
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
          d.span(classes: ['info-identifier'], children: [d.text('Results')]),
          d.span(classes: ['count'], children: [d.text('$totalCount')]),
          d.text(' $packageOrPackages'),
          if (searchQuery != null && searchQuery.isNotEmpty) ...[
            d.text(' for search query '),
            d.code(children: [d.text(searchQuery)]),
          ],
          if (ownedBy != null && ownedBy.isNotEmpty) ...[
            d.text(' owned by '),
            d.code(children: [d.text(ownedBy)]),
          ],
          if (messageMarkdown != null)
            d.unsafeRawHtml(markdownToHtml(messageMarkdown)!),
        ],
      ),
      sortControlNode,
    ],
  );
}
