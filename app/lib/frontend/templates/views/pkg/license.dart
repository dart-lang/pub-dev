// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

/// Nicely formatted labels for common SPDX identifiers.
const _spdxLabels = {
  'AGPL-3.0': 'AGPL 3.0',
  'Apache-2.0': 'Apache 2.0',
  'BSD-2-Clause': 'BSD 2-clause',
  'BSD-3-Clause': 'BSD 3-clause',
  'GPL-3.0': 'GPL 3.0',
  'MPL-2.0': 'MPL 2.0',
  'LGPL-2.1': 'LGPL 2.1',
  'LGPL-3.0': 'LGPL 3.0',
};
String spdxLabel(String id) => _spdxLabels[id] ?? id;

d.Node? packageListMetadataLicense(List<String>? spdxIdentifiers) {
  if (spdxIdentifiers == null || spdxIdentifiers.isEmpty) {
    return null;
  }
  final more = spdxIdentifiers.length - 1;
  final label = [
    spdxLabel(spdxIdentifiers.first),
    if (more > 0) '+$more',
  ].join(' ');
  return d.fragment(
    [
      d.img(
        classes: ['packages-metadata-license-icon'],
        image: d.Image(
          src: '/static/img/material-icon-balance-48.svg',
          alt: 'Icon for licenses.',
          width: 16,
          height: 16,
        ),
      ),
      d.text(label),
    ],
  );
}
