// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../../../static_files.dart';

d.Node oneClickInstallNode({required String packageName}) {
  return d.fragment([
    d.div(
      classes: ['pkg-page-install-wrapper'],
      children: [
        d.h3(classes: ['title'], child: d.text('Install command')),
        d.div(classes: [
          'pkg-page-install'
        ], children: [
          d.span(classes: [
            'pkg-page-install-code'
          ], children: [
            d.pre(children: [d.text('dart pub add $packageName')])
          ]),
          d.span(
            classes: ['pkg-page-install-copy'],
            children: [
              d.img(
                classes: ['pkg-page-install-copy-icon'],
                attributes: {
                  'data-copy-content': 'dart pub add $packageName',
                  'data-ga-click-event': 'copy-package-version',
                },
                image: d.Image(
                  src: staticUrls
                      .getAssetUrl('/static/img/content-copy-icon.svg'),
                  alt: 'copy "dart pub add $packageName" to clipboard',
                  width: 18,
                  height: 18,
                ),
                title: 'Copy "dart pub add $packageName" to clipboard',
              ),
              d.div(
                classes: ['pkg-page-install-copy-feedback'],
                children: [
                  d.span(classes: ['code'], text: '$packageName'),
                  d.text(' copied to clipboard'),
                ],
              ),
            ],
          ),
        ]),
      ],
    ),
  ]);
}
