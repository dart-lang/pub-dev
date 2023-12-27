// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;
import '../../../static_files.dart';

d.Node imageCarousel() {
  final imageContainer = d.div(
    classes: ['image-container'],
    id: '-image-container',
  );
  final next = material.floatingActionButton(
      id: '-carousel-next',
      icon: d.Image(
          src: staticUrls.getAssetUrl('/static/img/keyboard_arrow_right.svg'),
          height: 24,
          width: 24,
          alt: 'next'),
      classes: [
        'carousel-next',
        'carousel-nav'
      ],
      attributes: {
        'title': 'Next',
        'data-ga-click-event': 'screenshot-carousel-next-click',
      });

  final prev = material.floatingActionButton(
      id: '-carousel-prev',
      icon: d.Image(
          src: staticUrls.getAssetUrl('/static/img/keyboard_arrow_left.svg'),
          height: 24,
          width: 24,
          alt: 'previous'),
      classes: [
        'carousel-prev',
        'carousel-nav'
      ],
      attributes: {
        'title': 'Previous',
        'data-ga-click-event': 'screenshot-carousel-prev-click',
      });

  final description =
      d.p(id: '-screenshot-description', classes: ['screenshot-description']);

  return d.div(
    id: '-screenshot-carousel',
    classes: ['carousel'],
    children: [prev, imageContainer, next, description],
  );
}

d.Node collectionsIcon() {
  final collectionsIconWhite =
      staticUrls.getAssetUrl('/static/img/collections_white_24dp.svg');
  return d.img(
      classes: ['collections-icon'],
      image:
          d.Image.decorative(height: 30, width: 30, src: collectionsIconWhite));
}

d.Node screenshotThumbnailNode({
  required String thumbnailUrl,
  required List<String> screenshotUrls,
  required List<String> screenshotDescriptions,
}) {
  return d.div(classes: [
    'thumbnail-container'
  ], attributes: {
    'data-thumbnail': screenshotUrls.join(','),
    'data-thumbnail-descriptions-json': jsonEncode(screenshotDescriptions),
    'data-ga-click-event': 'screenshot-thumbnail-click',
  }, children: [
    d.img(
      classes: ['thumbnail-image'],
      image: d.Image(
          alt: 'screenshot', width: null, height: null, src: thumbnailUrl),
      title: 'View screenshots',
      attributes: {
        'tabindex': '0',
      },
    ),
  ]);
}
