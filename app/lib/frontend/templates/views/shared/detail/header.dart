// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';

import '../../../../dom/dom.dart' as d;
import '../../../../dom/material.dart' as material;
import '../../../../static_files.dart';

d.Node detailHeaderNode({
  required d.Node titleNode,
  required d.Node? metadataNode,
  required d.Node? tagsNode,
  required d.Image? image,
  required bool isLiked,
  required int? likeCount,
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
              children: [
                d.img(
                  classes: ['ff-banner', 'ff-banner-desktop'],
                  title: 'Package is a Flutter Favorite',
                  image: d.Image.decorative(
                    src: staticUrls
                        .getAssetUrl('/static/img/ff-banner-desktop-2x.png'),
                    width: 150,
                    height: 218,
                  ),
                ),
                d.img(
                  classes: ['ff-banner', 'ff-banner-mobile'],
                  title: 'Package is a Flutter Favorite',
                  image: d.Image.decorative(
                    src: staticUrls
                        .getAssetUrl('/static/img/ff-banner-mobile-2x.png'),
                    width: 94,
                    height: 116,
                  ),
                ),
              ],
            ),
        ],
      ),
    d.div(
      classes: [
        'detail-header',
        if (isLoose) '-is-loose',
      ],
      child: d.div(
        classes: ['detail-container'],
        child: d.div(
          classes: ['detail-header-outer-block'],
          children: [
            if (image != null)
              d.div(
                classes: ['detail-header-image-block'],
                child: d.img(
                  classes: ['detail-header-image'],
                  image: image,
                ),
              ),
            d.div(
              classes: ['detail-header-content-block'],
              children: [
                d.h1(classes: ['title'], child: titleNode),
                d.div(classes: ['metadata'], child: metadataNode),
                if (tagsNode != null || likeCount != null)
                  d.div(
                    classes: ['detail-tags-and-like'],
                    children: [
                      if (tagsNode != null)
                        d.div(classes: ['detail-tags'], child: tagsNode),
                      if (likeCount != null)
                        d.div(
                          classes: ['detail-like'],
                          children: [
                            material.iconButton(
                              id: '-pub-like-icon-button',
                              isOn: isLiked,
                              onIcon: d.Image(
                                src: staticUrls
                                    .getAssetUrl('/static/img/like-active.svg'),
                                alt: 'liked status: active',
                                width: 18,
                                height: 18,
                              ),
                              offIcon: d.Image(
                                src: staticUrls.getAssetUrl(
                                    '/static/img/like-inactive.svg'),
                                alt: 'liked status: inactive',
                                width: 18,
                                height: 18,
                              ),
                              attributes: {
                                'aria-label': isLiked
                                    ? 'Unlike this package'
                                    : 'Like this package',
                                'data-ga-click-event': 'toggle-like',
                                'aria-pressed': isLiked ? 'true' : 'false',
                              },
                            ),
                            d.span(
                              classes: ['likes-count'],
                              child: d.span(
                                id: 'likes-count',
                                text: _formatPackageLikes(likeCount),
                              ),
                            ),
                          ],
                        ),
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

// keep in-sync with pkg/web_app/lib/src/likes.dart
String? _formatPackageLikes(int? likesCount) {
  if (likesCount == null) return null;
  return formatWithSuffix(likesCount);
}
