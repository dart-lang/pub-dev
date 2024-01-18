// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/templates/views/pkg/screenshots.dart';

import '../../../../dom/dom.dart' as d;

/// Renders the details page content.
d.Node detailPageNode({
  required d.Node headerNode,
  required d.Node tabsNode,
  required d.Node? infoBoxNode,
  String? infoBoxLead,
  d.Node? footerNode,
}) {
  final hasInfoBox = infoBoxNode != null;
  return d.fragment([
    d.div(
      classes: [
        'detail-wrapper',
        '-active',
        if (hasInfoBox) '-has-info-box',
      ],
      children: [
        headerNode,
        if (hasInfoBox)
          d.div(
            classes: ['detail-container'],
            child: d.div(
              classes: ['detail-lead'],
              children: [
                d.div(
                  classes: ['detail-metadata-toggle'],
                  children: [
                    d.div(classes: ['detail-metadata-toggle-icon'], text: '→'),
                    d.h3(classes: ['detail-lead-title'], text: 'Metadata'),
                  ],
                ),
                d.p(classes: ['detail-lead-text'], text: infoBoxLead),
                d.p(
                  classes: ['detail-lead-more'],
                  child: d.a(
                    classes: ['detail-metadata-toggle'],
                    text: 'More...',
                  ),
                ),
              ],
            ),
          ),
        d.div(
          classes: ['detail-body'],
          children: [
            d.div(classes: ['detail-tabs'], child: tabsNode),
            if (hasInfoBox)
              d.element(
                'aside',
                classes: ['detail-info-box'],
                child: infoBoxNode,
              ),
          ],
        ),
        if (footerNode != null) footerNode,
      ],
    ),
    if (hasInfoBox)
      d.div(
        classes: ['detail-metadata'],
        children: [
          d.h3(
            classes: ['detail-metadata-title'],
            children: [
              d.span(classes: ['detail-metadata-toggle'], text: '←'),
              d.text(' Metadata'),
            ],
          ),
          d.div(classes: ['detail-info-box'], child: infoBoxNode),
          d.p(
            classes: ['detail-lead-back'],
            child: d.a(
              classes: ['detail-metadata-toggle'],
              text: 'Back',
            ),
          ),
        ],
      ),
    imageCarousel(),
  ]);
}
