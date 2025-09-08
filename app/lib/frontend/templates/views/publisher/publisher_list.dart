// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../publisher/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

d.Node publisherListNode({
  required List<PublisherSummary> publishers,
  required bool isGlobal,
}) {
  return d.fragment([
    if (isGlobal) d.h2(text: 'Publishers'),
    if (publishers.isNotEmpty)
      d.div(
        classes: ['publishers', if (isGlobal) '-global'],
        children: publishers.map(
          (p) => d.div(
            classes: ['publishers-item'],
            children: [
              d.h3(
                classes: ['publishers-item-title'],
                child: d.a(
                  href: urls.publisherUrl(p.publisherId),
                  text: p.publisherId,
                ),
              ),
              d.p(
                children: [
                  d.text('Registered '),
                  d.xAgoTimestamp(p.created, datePrefix: 'on'),
                  d.text('.'),
                ],
              ),
            ],
          ),
        ),
      ),
    if (publishers.isEmpty) isGlobal ? _noPublisherGlobal : _noPublisherLocal,
    d.h3(text: 'Want to create a new publisher?'),
    d.p(
      children: [
        d.text('Use the '),
        d.a(href: urls.createPublisherUrl(), text: 'create publisher'),
        d.text(' page.'),
      ],
    ),
  ]);
}

final _noPublisherGlobal = d.p(text: 'No publisher has been registered.');
final _noPublisherLocal = d.p(
  children: [
    d.text('You are not a member of any '),
    d.a(
      href: 'https://dart.dev/tools/pub/verified-publishers',
      text: 'verified publishers',
      rel: 'noreferrer',
      target: '_blank',
    ),
    d.text('.'),
  ],
);
