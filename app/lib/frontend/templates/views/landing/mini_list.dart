// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../package/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../shared/images.dart';

d.Node miniListNode(String sectionTag, List<PackageView> packages) {
  return d.div(
    classes: ['mini-list'],
    children: packages.map(
      (p) => d.div(
        classes: ['mini-list-item'],
        children: [
          _title(sectionTag, p),
          _body(p),
          _footer(sectionTag, p),
        ],
      ),
    ),
  );
}

d.Node _title(String sectionTag, PackageView p) {
  return d.a(
    classes: ['mini-list-item-title'],
    href: urls.pkgPageUrl(p.name),
    attributes: {'data-ga-click-event': 'landing-$sectionTag-card-title'},
    child: d.h3(text: p.name),
  );
}

d.Node _body(PackageView p) {
  return d.div(
    classes: ['mini-list-item-body'],
    child: d.p(
      classes: ['mini-list-item-description'],
      text: p.ellipsizedDescription,
    ),
  );
}

d.Node _footer(String sectionTag, PackageView p) {
  return d.div(
    classes: ['mini-list-item-footer'],
    children: [
      if (p.publisherId != null)
        d.div(
          classes: ['mini-list-item-publisher'],
          children: [
            d.img(
              classes: ['publisher-badge'],
              image: verifiedPublisherIconImage(),
              title: 'Published by a pub.dev verified publisher',
            ),
            d.a(
              classes: ['publisher-link'],
              href: urls.publisherUrl(p.publisherId!),
              attributes: {
                'data-ga-click-event': 'landing-$sectionTag-card-publisher'
              },
              text: p.publisherId,
            ),
          ],
        ),
    ],
  );
}
