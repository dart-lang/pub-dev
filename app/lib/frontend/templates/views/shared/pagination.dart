// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../templates/listing.dart';

d.Node renderPagination(PageLinks links) {
  final hasPrevious = links.currentPage! > 1;
  final hasNext = links.currentPage! < links.rightmostPage;
  final pageCount = links.rightmostPage - links.leftmostPage + 1;

  return d.ul(
    classes: ['pagination'],
    children: [
      // previous
      d.li(
        classes: [if (!hasPrevious) '-disabled'],
        children: [
          d.a(
            href: hasPrevious
                ? links.searchForm.toSearchLink(page: links.currentPage! - 1)
                : null,
            rel: 'prev',
            children: [
              d.span(children: [d.text('«')]),
            ],
          ),
        ],
      ),

      // pages
      ...Iterable.generate(pageCount, (index) {
        final page = index + links.leftmostPage;
        final bool isCurrent = page == links.currentPage;
        String? rel;
        if (links.currentPage == page + 1) {
          rel = 'prev';
        } else if (links.currentPage == page - 1) {
          rel = 'next';
        }
        return d.li(
          classes: [if (isCurrent) '-active'],
          children: [
            d.a(
              href:
                  isCurrent ? null : links.searchForm.toSearchLink(page: page),
              rel: rel,
              children: [
                d.span(children: [d.text('$page')])
              ],
            ),
          ],
        );
      }),

      // next
      d.li(
        classes: [if (!hasNext) '-disabled'],
        children: [
          d.a(
            href: hasNext
                ? links.searchForm.toSearchLink(page: links.currentPage! + 1)
                : null,
            rel: 'next',
            children: [
              d.span(children: [d.text('»')]),
            ],
          ),
        ],
      ),
    ],
  );
}
