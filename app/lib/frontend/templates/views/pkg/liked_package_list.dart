// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';

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

d.Node renderLikeButtonAndLabel(
    {required String package, required int likeCount, required bool isLiked}) {
  return d.div(
    classes: ['like-button-and-label'],
    children: [
      _renderLikeButton(package, isLiked),
      d.span(
        classes: ['like-button-and-label--count-wrapper'],
        child: d.span(
          classes: ['like-button-and-label--count'],
          text: _formatPackageLikes(likeCount),
          attributes: {
            'data-value': likeCount.toString(),
          },
        ),
      ),
    ],
  );
}

d.Node _renderLikeButton(String package, bool isLiked) {
  return material.iconButton(
    classes: ['like-button-and-label--button'],
    isOn: isLiked,
    onIcon: d.Image(
      src: staticUrls.getAssetUrl('/static/img/like-active.svg'),
      alt: 'liked status: active',
      width: 18,
      height: 18,
    ),
    offIcon: d.Image(
      src: staticUrls.getAssetUrl('/static/img/like-inactive.svg'),
      alt: 'liked status: inactive',
      width: 18,
      height: 18,
    ),
    title: isLiked ? 'Unlike this package' : 'Like this package',
    attributes: {
      'data-ga-click-event': 'toggle-like',
      'aria-pressed': isLiked ? 'true' : 'false',
      'data-package': package,
    },
  );
}

// keep in-sync with pkg/web_app/lib/src/likes.dart
String? _formatPackageLikes(int? likesCount) {
  if (likesCount == null) return null;
  return formatWithSuffix(likesCount);
}
