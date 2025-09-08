// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../dom/dom.dart' as d;
import '../../../../static_files.dart';

d.Node detailHeaderNode({
  required d.Node titleNode,
  required d.Node? metadataNode,
  required d.Node? tagsNode,
  required d.Image? image,
  required d.Node? likeNode,
  required bool isFlutterFavorite,

  /// Set true for more whitespace in the header.
  required bool isLoose,
}) {
  final hasBanners = isFlutterFavorite;
  return d.fragment([
    if (hasBanners)
      d.div(
        classes: ['detail-banners'],
        children: [
          if (isFlutterFavorite)
            d.a(
              href:
                  'https://flutter.dev/docs/development/packages-and-plugins/favorites',
              target: '_blank',
              rel: 'noopener',
              title: 'Package is a Flutter Favorite',
              children: [
                d.img(
                  classes: [
                    'ff-banner',
                    'ff-banner-desktop',
                    'displayed-in-light-theme',
                  ],
                  image: d.Image.decorative(
                    src: staticUrls.getAssetUrl(
                      '/static/img/ff-banner-desktop-2x.png',
                    ),
                    width: 150,
                    height: 218,
                  ),
                ),
                d.img(
                  classes: [
                    'ff-banner',
                    'ff-banner-desktop',
                    'displayed-in-dark-theme',
                  ],
                  image: d.Image.decorative(
                    src: staticUrls.getAssetUrl(
                      '/static/img/ff-banner-desktop-dark-2x.png',
                    ),
                    width: 150,
                    height: 218,
                  ),
                ),
                d.img(
                  classes: [
                    'ff-banner',
                    'ff-banner-mobile',
                    'displayed-in-light-theme',
                  ],
                  image: d.Image.decorative(
                    src: staticUrls.getAssetUrl(
                      '/static/img/ff-banner-mobile-2x.png',
                    ),
                    width: 94,
                    height: 116,
                  ),
                ),
                d.img(
                  classes: [
                    'ff-banner',
                    'ff-banner-mobile',
                    'displayed-in-dark-theme',
                  ],
                  image: d.Image.decorative(
                    src: staticUrls.getAssetUrl(
                      '/static/img/ff-banner-mobile-dark-2x.png',
                    ),
                    width: 94,
                    height: 116,
                  ),
                ),
              ],
            ),
        ],
      ),
    d.div(
      classes: ['detail-header', if (isLoose) '-is-loose'],
      child: d.div(
        classes: ['detail-container'],
        child: d.div(
          classes: ['detail-header-outer-block'],
          children: [
            if (image != null)
              d.div(
                classes: ['detail-header-image-block'],
                child: d.img(classes: ['detail-header-image'], image: image),
              ),
            d.div(
              classes: ['detail-header-content-block'],
              children: [
                d.h1(
                  classes: ['title', 'pub-monochrome-icon-hoverable'],
                  child: titleNode,
                ),
                d.div(classes: ['metadata'], child: metadataNode),
                if (tagsNode != null || likeNode != null)
                  d.div(
                    classes: ['detail-tags-and-like'],
                    children: [
                      if (tagsNode != null)
                        d.div(classes: ['detail-tags'], child: tagsNode),
                      if (likeNode != null) likeNode,
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  ]);
}
