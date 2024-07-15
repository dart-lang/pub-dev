// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;
import '../shared/images.dart';

d.Node? packageListMetadataLicense(List<String>? spdxIdentifiers) {
  if (spdxIdentifiers == null || spdxIdentifiers.isEmpty) {
    return null;
  }
  final label = spdxIdentifiers.join(', ');
  return d.fragment(
    [
      d.img(
        classes: ['inline-icon-img', 'filter-invert-on-dark'],
        image: licenseIconImage(),
      ),
      d.text(label),
    ],
  );
}
