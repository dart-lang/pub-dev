// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../service/youtube/backend.dart';
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

d.Node videoListNode(List<PkgOfWeekVideo> videos) {
  return d.div(
    classes: ['landing-pow-list'],
    children: videos.map(
      (v) => d.div(
        classes: ['pow-video'],
        child: d.a(
          href: v.videoUrl,
          target: '_blank',
          rel: 'noopener',
          title: v.description,
          attributes: {'data-ga-click-event': 'package-of-the-week-video'},
          children: [
            d.img(
              classes: ['pow-video-thumbnail'],
              image: d.Image(
                src: v.thumbnailUrl,
                alt: v.title,
                width: 260,
                height: 195,
              ),
              lazy: true,
            ),
            d.div(
              classes: ['pow-video-overlay'],
              children: [
                d.img(
                  classes: ['pow-video-overlay-img-active'],
                  image: d.Image.decorative(
                    src: staticUrls
                        .getAssetUrl('/static/img/youtube-play-red.png'),
                    width: 76,
                    height: 53,
                  ),
                  lazy: true,
                ),
                d.img(
                  classes: ['pow-video-overlay-img-inactive'],
                  image: d.Image.decorative(
                    src: staticUrls
                        .getAssetUrl('/static/img/youtube-play-black.png'),
                    width: 76,
                    height: 53,
                  ),
                  lazy: true,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
