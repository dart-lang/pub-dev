// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../dom/dom.dart' as d;

d.Node packageBadgeNode({
  required String label,
  String? title,
  String? iconUrl,
}) {
  return d.span(
    classes: ['package-badge'],
    attributes: title != null ? <String, String>{'title': title} : null,
    children: [
      if (iconUrl != null)
        d.img(
          classes: ['package-badge-icon'],
          src: iconUrl,
          attributes: {
            'width': '13',
            'height': '13',
          },
        ),
      d.text(label),
    ],
  );
}
