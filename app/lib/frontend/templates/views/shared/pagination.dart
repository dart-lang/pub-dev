// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../templates/listing.dart';

d.Node paginationNode(PageLinks links) {
  final hasPrevious = links.currentPage! > 1;
  final hasNext = links.currentPage! < links.rightmostPage;
  final pageCount = links.rightmostPage - links.leftmostPage + 1;

  return d.ul(
    classes: ['pagination'],
    children: [
      // previous
      d.li(
        classes: [if (!hasPrevious) '-disabled'],
        child: d.a(
          href: hasPrevious
              ? links.searchForm.toSearchLink(page: links.currentPage! - 1)
              : null,
          rel: 'prev nofollow',
          child: d.span(text: '«'),
        ),
      ),

      // pages
      ...Iterable.generate(pageCount, (index) {
        final page = index + links.leftmostPage;
        final bool isCurrent = page == links.currentPage;
        String? rel;
        if (links.currentPage == page + 1) {
          rel = 'prev nofollow';
        } else if (links.currentPage == page - 1) {
          rel = 'next nofollow';
        } else {
          rel = 'nofollow';
        }
        return d.li(
          classes: [if (isCurrent) '-active'],
          child: d.a(
            href: isCurrent ? null : links.searchForm.toSearchLink(page: page),
            rel: rel,
            child: d.span(text: '$page'),
          ),
        );
      }),

      // next
      d.li(
        classes: [if (!hasNext) '-disabled'],
        child: d.a(
          href: hasNext
              ? links.searchForm.toSearchLink(page: links.currentPage! + 1)
              : null,
          rel: 'next nofollow',
          child: d.span(text: '»'),
        ),
      ),
    ],
  );
}
