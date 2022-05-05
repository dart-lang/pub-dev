// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/frontend/static_files.dart';

import '../../../dom/dom.dart' as d;

d.Node? packageListMetadataLicense(List<String>? spdxIdentifiers) {
  if (spdxIdentifiers == null || spdxIdentifiers.isEmpty) {
    return null;
  }
  final label = spdxIdentifiers.join(', ');
  return d.fragment(
    [
      d.img(
        classes: ['packages-metadata-license-icon'],
        image: d.Image(
          src: staticUrls.getAssetUrl('/static/img/material-icon-balance.svg'),
          alt: 'Icon for licenses.',
          width: 16,
          height: 16,
        ),
      ),
      d.text(label),
    ],
  );
}
