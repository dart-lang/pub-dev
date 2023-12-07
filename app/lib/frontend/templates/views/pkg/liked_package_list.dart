// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../account/models.dart';
import '../../../../shared/urls.dart' as urls;

import '../../../dom/dom.dart' as d;
import '../../../dom/material.dart' as material;
import '../../../static_files.dart' show staticUrls;

/// Renders the package list of /my-liked-packages page.
d.Node likedPackageListNode(List<LikeData> likes) {
  final thumbUpOutlinedUrl =
      staticUrls.getAssetUrl('/static/img/thumb-up-24px.svg');
  final thumbUpFilledUrl =
      staticUrls.getAssetUrl('/static/img/thumb-up-filled-24px.svg');
  return d.div(
    classes: ['packages', '-compact'],
    children: likes.map(
      (like) => d.div(
        classes: ['packages-item'],
        children: [
          d.div(
            classes: ['packages-header'],
            children: [
              d.h3(
                classes: ['packages-title'],
                child: d.a(
                  href: urls.pkgPageUrl(like.package!),
                  text: like.package,
                ),
              ),
              d.div(
                classes: ['packages-icons'],
                child: material.button(
                  unelevated: true,
                  customTypeClass: '-pub-like-button',
                  attributes: {
                    'data-package': like.package!,
                    'data-thumb_up_outlined': thumbUpOutlinedUrl,
                    'data-thumb_up_filled': thumbUpFilledUrl,
                  },
                  icon: d.Image(
                    src: thumbUpFilledUrl,
                    alt: 'thumb up',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Unlike',
                ),
              ),
            ],
          ),
          d.p(
            classes: ['packages-metadata'],
            children: [
              d.text(' Liked '),
              d.xAgoTimestamp(like.created!, datePrefix: 'on'),
            ],
          ),
        ],
      ),
    ),
  );
}
