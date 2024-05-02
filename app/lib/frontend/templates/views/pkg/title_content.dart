// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

d.Node titleContentNode({
  required String package,
  required String version,
}) {
  return d.fragment([
    d.text('$package $version '),
    copyIcon(package: package, version: version),
  ]);
}

d.Node copyIcon({required String package, required String version}) {
  return d.span(
    classes: ['pkg-page-title-copy'],
    children: [
      d.img(
        classes: ['pkg-page-title-copy-icon'],
        attributes: {
          'data-copy-content': '$package: ^$version',
          'data-ga-click-event': 'copy-package-version',
        },
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/content-copy-icon.svg'),
          alt: 'copy "$package: ^$version" to clipboard',
          width: 18,
          height: 18,
        ),
        title: 'Copy "$package: ^$version" to clipboard',
      ),
      d.div(
        classes: ['pkg-page-title-copy-feedback'],
        children: [
          d.span(classes: ['code'], text: '$package: ^$version'),
          d.text(' copied to clipboard'),
        ],
      ),
    ],
  );
}
