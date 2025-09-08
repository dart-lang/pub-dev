// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

/// Renders the standalone page template with [content].
///
/// [sideImage] should already contain the `?hash` request parameter for caching.
d.Node standalonePageNode(d.Node content, {d.Image? sideImage}) {
  assert(sideImage == null || sideImage.src.contains('/static/hash-'));
  final hasSideImage = sideImage != null;
  return d.div(
    classes: ['standalone-wrapper', if (hasSideImage) '-has-side-image'],
    children: [
      if (hasSideImage)
        d.div(
          classes: ['standalone-side-image-block'],
          child: d.img(classes: ['standalone-side-image'], image: sideImage),
        ),
      d.div(classes: ['standalone-content'], child: content),
    ],
  );
}
