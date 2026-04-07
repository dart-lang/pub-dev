// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/number_format.dart';

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;

d.Node renderLikeButtonAndLabel({
  required String package,
  required int likeCount,
  required bool isLiked,
}) {
  return d.div(
    classes: ['like-button-and-label'],
    children: [
      renderLikeButton(package, likeCount: likeCount, isLiked: isLiked),
      d.span(
        classes: ['like-button-and-label--count-wrapper'],
        child: d.span(
          classes: ['like-button-and-label--count'],
          text: _formatPackageLikes(likeCount),
        ),
      ),
    ],
  );
}

d.Node renderLikeButton(
  String package, {
  required int likeCount,
  required bool isLiked,
}) {
  return d.button(
    classes: [
      'like-button-and-label--button',
      '-pub-icon-button',
      if (isLiked) '-pub-icon-button--on',
    ],
    attributes: {
      'data-ga-click-event': 'toggle-like',
      'aria-pressed': isLiked ? 'true' : 'false',
      'data-package': package,
      'data-value': likeCount.toString(),
      'title': isLiked ? 'Unlike this package' : 'Like this package',
    },
    children: [
      d.img(
        classes: ['-pub-icon-button-icon--on'],
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/like-active.svg'),
          alt: 'liked status: active',
          width: 18,
          height: 18,
        ),
      ),
      d.img(
        classes: ['-pub-icon-button-icon--off'],
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/like-inactive.svg'),
          alt: 'liked status: inactive',
          width: 18,
          height: 18,
        ),
      ),
    ],
  );
}

// keep in-sync with pkg/web_app/lib/src/likes.dart
String? _formatPackageLikes(int? likesCount) {
  if (likesCount == null) return null;
  return formatWithSuffix(likesCount);
}
